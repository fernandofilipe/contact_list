import 'package:contact_list/shared/layout/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final List<TextInputFormatter>? formatters;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Function(String)? onChanged;

  const CustomInput({
    super.key,
    required this.controller,
    required this.label,
    this.formatters,
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.onChanged,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  void initState() {
    widget.controller.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          label: Text(widget.label, style: subTitleStyle).tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          suffixIcon: widget.controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: const Icon(
                    Icons.cancel_rounded,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: () => widget.controller.clear(),
                ),
        ),
        controller: widget.controller,
        inputFormatters: widget.formatters,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
      ),
    );
  }
}
