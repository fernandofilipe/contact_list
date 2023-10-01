import 'package:contact_list/shared/layout/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  final TextEditingController? controller;
  final String what;
  final IconData? iconData;
  final String title;
  final String? message;
  final String? textOk;
  final String? textCancel;
  final Function()? onOk;
  final Function()? onCancel;

  const DeleteDialog({
    super.key,
    required this.what,
    required this.title,
    this.message,
    this.controller,
    this.iconData,
    this.textOk,
    this.textCancel,
    this.onOk,
    this.onCancel,
  });

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.delete),
          const SizedBox(width: 5),
          Text(widget.title).tr(),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Text('APP_CONTACT_MESSAGE_REMOVE_CONTACT_CONFIRMATION').tr(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.iconData != null
                      ? Icon(widget.iconData)
                      : Container(
                          width: 0,
                        ),
                  const SizedBox(width: 5),
                  Text(
                    widget.what,
                    style: subTitleStyle,
                  ),
                ],
              ),
            ),
            Text(widget.message ?? 'APP_CONTACT_MESSAGE_REMOVE_ITEM').tr(),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: widget.onOk,
          child: Text(widget.textOk ?? 'APP_CONTACT_BUTTON_LABEL_OK').tr(),
        ),
        TextButton(
          onPressed: widget.onCancel,
          child:
              Text(widget.textCancel ?? 'APP_CONTACT_BUTTON_LABEL_CANCEL').tr(),
        ),
      ],
    );
  }
}
