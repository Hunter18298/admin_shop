import 'package:flutter/material.dart' show BuildContext;
import 'package:online_shop_admin/dialogs/generic_dialog.dart';

//bakarhenani showGenericDialog lo drustkrdni dialog ak lo logout y
Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
    optionsBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
    //.then() bakarde agar darey yan pshty dialog akay dagira
  ).then(
    (value) => value ?? false,
  );
}
