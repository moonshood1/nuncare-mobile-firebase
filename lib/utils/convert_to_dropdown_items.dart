import 'package:multi_dropdown/multi_dropdown.dart';

List<DropdownItem<String>> convertToDropdownItems(List<String> items) {
  return items.map((item) => DropdownItem(value: item, label: item)).toList();
}
