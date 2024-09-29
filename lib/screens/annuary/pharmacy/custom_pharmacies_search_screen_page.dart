import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class CustomPharmacyScreenPage extends StatefulWidget {
  const CustomPharmacyScreenPage({super.key});

  @override
  State<CustomPharmacyScreenPage> createState() =>
      _CustomPharmacyScreenPageState();
}

class _CustomPharmacyScreenPageState extends State<CustomPharmacyScreenPage> {
  final ResourceService _resourceService = ResourceService();

  String? _selectedSection;
  String? _selectedArea;

  var _isLoading = false;
  bool _isSectionSelected = false;

  List<String> _sections = [];
  List<String> _areas = [];

  @override
  void dispose() {
    super.dispose();
  }

  void _submitData() async {
    setState(() {
      _isLoading = true;
    });

    Navigator.of(context).pop({
      'section': _selectedSection,
      'area': _selectedArea ?? '',
    });

    setState(() {
      _isLoading = false;
    });
  }

  void getSections() async {
    try {
      List<String> response = await _resourceService.getSections();

      setState(() {
        _sections = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void getAreasForSection(String section) async {
    try {
      List<String> response =
          await _resourceService.getAreaForSelectedSection(section);

      setState(() {
        _isSectionSelected = true;
        _areas = response;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: <Widget>[
            const Text(
              "Sélectionnez vos critères de recherche",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'Choisissez une section',
              items: _sections,
              icon: Icons.map,
              onChanged: (String? newValue) {
                _selectedSection = newValue;

                getAreasForSection(newValue!);

                setState(() {});
              },
              selectedValue: _selectedSection,
            ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'Choisissez une zone',
              items: _areas,
              icon: Icons.medical_services,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedArea = newValue;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: _isLoading
                  ? const MyLoadingCirle()
                  : ElevatedButton(
                      onPressed: _submitData,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Effectuer la recherche",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
