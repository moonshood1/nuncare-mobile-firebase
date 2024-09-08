import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/components/my_user_tile.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/screens/message/chat_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/chat_service.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';
import 'package:nuncare_mobile_firebase/utils/convert_to_dropdown_items.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class TestPageScreen extends StatefulWidget {
  const TestPageScreen({super.key});

  @override
  State<TestPageScreen> createState() => _TestPageScreenState();
}

class _TestPageScreenState extends State<TestPageScreen> {
  final ResourceService _resourceService = ResourceService();

  List<String> _specialities = [];
  List<String> _selectedSpecialities = [];

  void getSpecialities() async {
    try {
      List<String> response = await _resourceService.getSpecialities();

      setState(() {
        _specialities = response;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSpecialities();
    });
  }

  void checkValues() {
    print('speeeee : $_selectedSpecialities');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Test',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MultiSelectDialogField<String>(
                title: Text("Spécialités"),
                buttonText: Text("Spécialités"),
                confirmText: Text("Valider"),
                cancelText: Text("Annuler"),
                items: _specialities.map((e) => MultiSelectItem(e, e)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  _selectedSpecialities = values;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(onPressed: checkValues, child: Text("Tester"))
            ],
          ),
        ),
      ),
    );
  }
}
