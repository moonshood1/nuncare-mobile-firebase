import 'package:flutter/material.dart';

class MySelectField extends StatefulWidget {
  const MySelectField({
    super.key,
    required this.label,
    required this.items,
    required this.icon,
    required this.onChanged,
    this.selectedValue,
  });

  final String label;
  final List<String> items;
  final IconData icon;
  final ValueChanged<String?> onChanged;
  final String? selectedValue;

  @override
  State<MySelectField> createState() => _MySelectFieldState();
}

class _MySelectFieldState extends State<MySelectField> {
  String? _selectedItem;
  String? _errorText;

  List<String> _items = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _items = widget.items;
    _selectedItem = widget.selectedValue;
    return DropdownButtonFormField<String>(
      value: _selectedItem,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        prefixIcon: Icon(
          widget.icon,
          color: Theme.of(context).colorScheme.primary,
        ),
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
          borderRadius: BorderRadius.circular(10.0),
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
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: _errorText,
        errorStyle: const TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
      isExpanded: true,
      items: _items.map(
        (String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          );
        },
      ).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue;
          _errorText = null;
          widget.onChanged(newValue);
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez selectionner une valeur';
        }
        return null;
      },
    );
  }
}
