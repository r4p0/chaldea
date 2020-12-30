import 'dart:convert';
import 'dart:io';
import 'dart:math' show min;

import 'package:chaldea/components/components.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:json_patch/json_patch.dart';
import 'package:share/share.dart';

class DatasetManagePage extends StatefulWidget {
  @override
  _DatasetManagePageState createState() => _DatasetManagePageState();
}

class _DatasetManagePageState extends State<DatasetManagePage> {
  Map<String, String> cachedFiles = {};
  List<String> onlineVersions = [];

  Dio _dio = Dio(BaseOptions(baseUrl: db.userData.serverDomain));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Dataset version control'),
        actions: <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          TileGroup(
            header: 'Userdata',
            children: <Widget>[
              ListTile(
                title: Text('Clear userdata'),
                onTap: () {
                  SimpleCancelOkDialog(
                    title: Text('Confirm'),
                    content: Text('Delete userdata?'),
                    onTapOk: () async {
                      showToast('cleaning userdata...');
                      await db.clearData(user: true, game: false);
                      setState(() {});
                      showToast('userdata cleared.');
                    },
                  ).show(context);
                },
              ),
              ListTile(
                title: Text('Backup userdata'),
                onTap: () {
                  SimpleCancelOkDialog(
                    title: Text('Confirm'),
                    content: Text('Backup userdata to\n${db.paths.savePath}'),
                    onTapOk: () async {
                      final fp = db.backupUserdata();
                      showInformDialog(context,
                          title: 'Backup success',
                          content: fp,
                          actions: [
                            FlatButton(
                              child: Text('Share'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Share.shareFiles([fp]);
                              },
                            ),
                          ]);
                    },
                  ).show(context);
                },
              ),
              ListTile(
                title: Text('Import userdata'),
                onTap: () async {
                  try {
                    final result = (await FilePicker.platform.pickFiles());
                    if (result != null) {
                      final path = result.files.single.path;
                      db.userData = UserData.fromJson(
                          json.decode(File(path).readAsStringSync()));
                      showToast('successfully imported userdata:\n$path');
                      db.saveUserData();
                    }
                  } catch (e) {
                    showToast('Import userdata failed! Error:\n$e');
                  }
                },
              ),
            ],
          ),
          TileGroup(
            header: 'GameData',
            children: <Widget>[
              ListTile(
                title: Text('Current Version'),
                trailing: Text(db.gameData.version),
              ),
              ListTile(
                title: Text('Reload default gamedata'),
                onTap: () {
                  SimpleCancelOkDialog(
                    title: Text('Confirm'),
                    content: Text('reload default dataset?'),
                    onTapOk: () async {
                      showToast('reloading gamedata...',
                          toastLength: Toast.LENGTH_LONG);
                      await db.loadZipAssets(kDatasetAssetKey, force: true);
                      if (db.loadGameData()) {
                        showToast('gamedata reloaded.');
                      }
                      setState(() {});
                    },
                  ).show(context);
                },
              ),
              ListTile(
                title: Text('Download icons'),
                onTap: () {
                  db.gameData.icons.forEach((name, icon) async {
                    final filepath =
                        join(db.paths.gameIconDir, icon.originName);
                    if (!File(filepath).existsSync()) {
                      try {
                        Response response = await _dio.download(icon.url,
                            join(db.paths.gameIconDir, icon.originName));
                        if (response.statusCode != 200) {
                          print('error $name, response: $response');
                          showToast('$name download failed');
                        } else {
                          print('downloaded icon $name');
                        }
                      } catch (e) {
                        print('download icon $name error: $e');
                        showToast('$name download failed');
                      }
                    }
                  });
                },
              ),
              ListTile(
                title: Text('Clear and reload default data'),
                subtitle: Text('including icons'),
                onTap: () {
                  SimpleCancelOkDialog(
                    title: Text('Confirm'),
                    content: Text('clear then reload default dataset?'),
                    onTapOk: () async {
                      showToast('clear & reloading',
                          toastLength: Toast.LENGTH_LONG);
                      await db.clearData(game: true);
                      setState(() {});
                      showToast('Default dataset loaded.');
                    },
                  ).show(context);
                },
              ),
              ListTile(
                title: Text('Import gamedata(zip/json)'),
                onTap: () async {
                  try {
                    final result = await FilePicker.platform.pickFiles();
                    if (result != null) {
                      final file = File(result.files.single.path);
                      if (file.path.toLowerCase().endsWith('.zip')) {
                        db.extractZip(file.readAsBytesSync().cast<int>(),
                            db.paths.gameDataDir);
                        db.loadGameData();
                      } else if (file.path.toLowerCase().endsWith('.json')) {
                        final newData = GameData.fromJson(
                            jsonDecode(file.readAsStringSync()));
                        if (newData.version != '0') {
                          db.gameData = newData;
                        } else {
                          throw 'Invalid contents';
                        }
                      } else {
                        throw 'unsupported file type';
                      }
                      showInformDialog(context,
                          title: 'Import dataset successfully');
                    }
                  } catch (e) {
                    showInformDialog(context,
                        title: 'Import gamedata failed!',
                        content: e.toString());
                  }
                },
              ),
            ],
          ),
          TileGroup(
            header: 'Download',
            children: <Widget>[
              ListTile(
                title: Text('Server'),
                subtitle: Text(db.userData.serverDomain ?? 'none'),
                trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => InputCancelOkDialog(
                          title: 'Edit server',
                          text: db.userData.serverDomain,
                          errorText: S.of(context).input_error,
                          onSubmit: (v) {
                            v = v.trim();
                            if (v.endsWith('/')) {
                              v = v.substring(0, v.length - 1);
                            }
                            setState(() {
                              db.userData.serverDomain = v;
                              _dio.options.baseUrl = db.userData.serverDomain;
                            });
                          },
                        ),
                      );
                    }),
              ),
              ListTile(
                title: Center(child: Text('Download Data')),
                onTap: () {
                  db.downloadGameData();
                  db.onAppUpdate();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void patchVersion(String version) async {
    try {
      Response response = await _dio.get('/patch',
          queryParameters: {'from': db.gameData.version, 'to': version});
      if (response.statusCode == 200) {
        var patch = response.data;
        print(
            'download patch: ${patch.toString().substring(0, min(200, patch.toString().length))}');
        final patched = JsonPatch.apply(
            db.getJsonFromFile(db.paths.gameDataFilepath),
            List.castFrom(patch));
        File file = File(db.paths.gameDataFilepath);
        var raf = file.openSync(mode: FileMode.write);
        raf.writeStringSync(json.encode(patched));
        raf.closeSync();
        db.loadGameData();
        setState(() {});
        showToast('patch success.');
        print('patched version: ${patched['version']}');
      }
    } catch (e, s) {
      showToast('patch data failed.');
      print('patch data error:\n$e');
      print('stack trace: \n$s');
      rethrow;
    }
  }
}
