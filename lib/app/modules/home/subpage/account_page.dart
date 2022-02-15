import 'package:chaldea/generated/l10n.dart';
import 'package:chaldea/models/models.dart';
import 'package:chaldea/utils/extension.dart';
import 'package:chaldea/widgets/custom_dialogs.dart';
import 'package:chaldea/widgets/tile_items.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<User> get users => db2.userData.users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.cur_account),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: S.current.new_account,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return InputCancelOkDialog(
                    title: S.current.new_account,
                    errorText: S.current.input_invalid_hint,
                    validate: (v) =>
                        v == v.trim() &&
                        v.isNotEmpty &&
                        users.every((e) => e.name != v),
                    onSubmit: addUser,
                  );
                },
              );
            },
          )
        ],
      ),
      body: TileGroup(
        children: List.generate(
          users.length,
          (index) {
            final user = users[index];
            return RadioListTile<int>(
              value: index,
              groupValue: db2.userData.curUserKey,
              onChanged: (v) {
                if (v != null) {
                  db2.userData.curUserKey = v;
                  updateData();
                }
              },
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(user.name),
              secondary: PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: Text(S.current.rename),
                    onTap: () => renameUser(user),
                  ),
                  PopupMenuItem(
                    child: Text(S.current.move_up),
                    enabled: index != 0,
                    onTap: () => moveUser(index, -1),
                  ),
                  PopupMenuItem(
                    child: Text(S.current.move_down),
                    enabled: index != users.length - 1,
                    onTap: () => moveUser(index, 1),
                  ),
                  PopupMenuItem(
                    child: Text(S.current.copy),
                    onTap: () => copyUser(index),
                  ),
                  PopupMenuItem(
                    child: Text(S.current.clear),
                    onTap: () => clearUser(user),
                  ),
                  PopupMenuItem(
                    child: Text(S.current.delete),
                    onTap: () => deleteUser(index),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void addUser(String name) {
    users.add(User(name: name));
    db2.userData.curUserKey = users.length - 1;
    updateData();
  }

  void renameUser(User user) async {
    await Future.delayed(Duration.zero);
    showDialog(
      context: context,
      builder: (context) => InputCancelOkDialog(
        title: '${S.current.rename} - ${user.name}',
        text: user.name,
        errorText: S.current.input_invalid_hint,
        validate: (v) {
          return v == v.trim() &&
              v.isNotEmpty &&
              users.every((e) => e.name != v);
        },
        onSubmit: (v) {
          user.name = v;
          db2.notifyUserdata();
        },
      ),
    );
  }

  void moveUser(int key, int dx) {
    int newIndex = dx < 0 ? key - dx : key + dx - 1;
    final user = users.removeAt(key);
    users.insert(newIndex, user);
    setState(() {});
  }

  void copyUser(int key) {
    final originUser = users[key];
    final newUser = User.fromJson(originUser.toJson());
    int i = 2;
    String newName;
    String baseName = originUser.name.replaceFirst(RegExp(r' \(\d+\)$'), '');
    do {
      newName = '$baseName ($i)';
      i++;
    } while (users.any((user) => user.name == newName));
    users.add(newUser);
  }

  void clearUser(User user) async {
    await Future.delayed(Duration.zero);
    SimpleCancelOkDialog(
      title: const Text('Clear Data'),
      content: Text('Account: ${user.name}'),
      onTapOk: () {
        user.servants.clear();
        user.items.clear();
        user.svtPlanGroups.forEach((e) => e.clear());
        user.mysticCodes.clear();
        updateData();
      },
    ).showDialog(context);
  }

  void deleteUser(int key) async {
    await Future.delayed(Duration.zero);
    print('delete user key $key...');
    final canDelete = users.length > 1;
    final user = users[key];
    SimpleCancelOkDialog(
      title: Text('Delete ${user.name}'),
      content:
          canDelete ? null : const Text('Cannot delete, at least one account!'),
      onTapOk: canDelete
          ? () {
              users.removeAt(key);
              db2.userData.validate();
              updateData();
            }
          : null,
    ).showDialog(context);
  }

  void updateData() async {
    // notify updates, calc items
    setState(() {});
    // await db2.itemStat
    //     .update(lapse: const Duration(seconds: 1), withFuture: true);
    db2.notifyUserdata();
  }
}