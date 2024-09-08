import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.labelText,
    required this.validator,
    required this.isHidden,
    required this.autoCorrect,
    required this.keyboardType,
    required this.textCapitalization,
    required this.icon,
    this.focusNode,
    this.inputFormatter,
    this.maxLines,
    this.minLines,
  });

  final TextEditingController controller;
  final bool obscureText, isHidden, autoCorrect;
  final String labelText;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final IconData icon;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLines;
  final int? minLines;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String? _errorText;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      autocorrect: widget.autoCorrect,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatter,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onChanged: (value) => setState(() {
        _errorText = widget.validator(value);
      }),
      style: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        prefixIcon: Icon(
          widget.icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        suffixIcon: widget.isHidden == true
            ? GestureDetector(
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        filled: true,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.red.shade300,
          ),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        errorText: _errorText,
        errorStyle: const TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
