import 'package:flutter/material.dart' show BuildContext;
import 'package:online_shop_admin/auth/auth_error.dart';
import 'package:online_shop_admin/dialogs/generic_dialog.dart';

//lo peshandani error la login u register u logout y
//har wak logout dialog a
Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}
