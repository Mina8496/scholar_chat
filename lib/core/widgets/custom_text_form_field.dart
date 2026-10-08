import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final String? errorText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;

  final BorderSide? borderSide;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final bool obscureText;
  final bool enabled;
  final bool readOnly;

  final int maxLines;
  final int? maxLength;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final void Function(String?)? onSaved;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.borderSide,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? const TextStyle(color: Colors.white),
        labelText: labelText,
        errorText: errorText,
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

        enabledBorder: OutlineInputBorder(
          borderSide: borderSide ?? const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: borderSide ?? BorderSide(color: Colors.white, width: 2),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
