import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onTap;
  const FavoriteButton({
    super.key,
    this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        controller?.text != null && controller!.text == 'true'
            ? Icons.star
            : Icons.star_border,
        color: Theme.of(context).colorScheme.primaryContainer,
        size: 30,
      ),
    );
  }
}
