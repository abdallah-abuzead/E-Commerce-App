import 'package:flutter/material.dart';

abstract class AppDialogs {
  static Future<void> defaultDialog({
    required BuildContext context,
    String title = 'Removal Conformation',
    String content = 'Removing this data will remove all related data. Are you sure?',
    String cancelText = 'Cancel',
    String confirmText = 'Remove',
    Function()? onCancel,
    Function()? onConfirm,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              child: Text(cancelText),
            ),
            TextButton(onPressed: onConfirm, child: Text(confirmText)),
          ],
        );
      },
    );
  }
}
