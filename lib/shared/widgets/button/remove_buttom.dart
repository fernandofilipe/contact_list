import 'package:flutter/material.dart';

class RemoveButton extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onTap;
  const RemoveButton({
    super.key,
    this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.primaryContainer,
        size: 30,
      ),
    );
  }
}
