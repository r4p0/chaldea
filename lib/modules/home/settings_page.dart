import 'package:chaldea/components/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'subpage/about_page.dart';
import 'subpage/account_page.dart';
import 'subpage/lang_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String language;
  String user;
  String dataVersion;

  @override
  void initState() {
    super.initState();
    dataVersion = getDataSetVersion();
  }

  @override
  Widget build(BuildContext context) {
    language = S.of(context).language;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings_tab_name),
      ),
      backgroundColor: MyColors.setting_bg,
      body: ListView(
        children: <Widget>[
          TileGroup(
            header: S.of(context).settings_data,
            tiles: <Widget>[
              ListTile(
                title: Text(S.of(context).settings_tutorial),
                trailing: null,
              ),
              ListTile(
                title: Text(S.of(context).server),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: db.userData.users[db.userData.curUser].server ??
                        GameServer.jp,
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        value: GameServer.cn,
                        child: Text(S.of(context).server_cn),
                      ),
                      DropdownMenuItem(
                        value: GameServer.jp,
                        child: Text(S.of(context).server_jp),
                      )
                    ],
                    onChanged: (v) {
                      db.userData.users[db.userData.curUser].server = v;
                      db.onAppUpdate();
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text(S.of(context).cur_account),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      db.userData.users[db.userData.curUser].name,
                      style: TextStyle(color: Colors.black87),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                onTap: () {
                  SplitRoute.popAndPush(context,
                      builder: (context) => AccountPage());
                },
              ),
            ],
          ),
          TileGroup(
            header: S.of(context).settings_general,
            tiles: <Widget>[
              ListTile(
                title: Text(S.of(context).settings_language),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      S.of(context).language,
                      style: TextStyle(color: Colors.black87),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                onTap: () {
                  SplitRoute.popAndPush(context,
                      builder: (context) => LanguagePage());
                },
              ),
//              // TODO: github issue
//              ListTile(
//                title: Text('Language'),
//                trailing: DropdownButton(
//                    underline: Divider(thickness: 0, color: Colors.transparent),
//                    value: S.of(context).language,
//                    items: LangCode.allEntries.keys.map((language) {
//                      return DropdownMenuItem(
//                          value: language, child: Text(language));
//                    }).toList(),
//                    onChanged: (language) {
//                      db.userData.language = language;
//                      db.onAppUpdate();
//                    }),
//              ),
              SwitchListTile.adaptive(
                  title: Text('使用移动数据下载'),
                  value: db.userData.useMobileNetwork ?? false,
                  onChanged: (v) async {
                    db.userData.useMobileNetwork = v;
                    await db.checkNetwork();
                    setState(() {});
                  }),
            ],
          ),
          TileGroup(
            header: 'Test(debug mode: ${kDebugMode ? 'on' : 'off'})',
            tiles: <Widget>[
              SwitchListTile.adaptive(
                  title: Text('允许下载'),
                  value: db.userData.testAllowDownload ?? true,
                  onChanged: (v) async {
                    db.userData.testAllowDownload = v;
                    await db.checkNetwork();
                    setState(() {});
                  }),
              ListTile(
                title: Text('Master-Detail width'),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<double>(
                    value: db.userData.criticalWidth ?? 768,
                    items: <DropdownMenuItem<double>>[
                      DropdownMenuItem(value: 768, child: Text('768')),
                      DropdownMenuItem(value: 600, child: Text('600'))
                    ],
                    onChanged: (v) {
                      db.userData.criticalWidth = v;
                      db.onAppUpdate();
                    },
                  ),
                ),
              ),
            ],
          ),
          TileGroup(
            header: S.of(context).backup_restore,
            tiles: <Widget>[
              ListTile(
                title: Text('Reload gamedata'),
                trailing: Text(dataVersion),
                onTap: () {
                  showDialog(
                      context: context,
                      child: SimpleCancelOkDialog(
                        title: Text('Confirm to reload gamedata?'),
                        onTapOk: () {
                          Fluttertoast.showToast(msg: 'cleaning...');
                          SchedulerBinding.instance
                              .addPostFrameCallback((_) async {
                            await db.clearData(game: true);
                            setState(() {
                              dataVersion = getDataSetVersion();
                            });
                            Fluttertoast.showToast(msg: 'gamedata reloaded');
                          });
                        },
                      ));
                },
              ),
              ListTile(
                title: Text('Clear all data(include userdata)'),
                onTap: () {
                  showDialog(
                      context: context,
                      child: SimpleCancelOkDialog(
                        title: Text('Confirm to delete all data?'),
                        onTapOk: () {
                          Fluttertoast.showToast(msg: 'cleaning...');
                          SchedulerBinding.instance
                              .addPostFrameCallback((_) async {
                            await db.clearData(user: true, game: true);
                            setState(() {
                              dataVersion = getDataSetVersion();
                            });
                            Fluttertoast.showToast(msg: 'all data reloaded');
                          });
                        },
                      ));
                },
              ),
              ListTile(
                title: Text(S.of(context).backup),
                onTap: () => Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('To be implemented...'))),
              ),
              ListTile(
                title: Text(S.of(context).restore),
                onTap: () => Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('To be implemented...'))),
              ),
              ListTile(
                title: Text('关于Chaldea'),
                onTap: () => SplitRoute.popAndPush(context,
                    builder: (context) => AboutPage()),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    db.saveData();
  }

  String getDataSetVersion() {
    final file = db.getLocalFile('VERSION', rel: db.userData.gameDataPath);
    return file.existsSync() ? file.readAsStringSync() : 'INVALID';
  }
}
