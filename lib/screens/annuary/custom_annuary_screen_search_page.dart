import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';
import 'package:nuncare_mobile_firebase/validators/number_validator.dart';

class CustomAnnuaryScreenPage extends StatefulWidget {
  const CustomAnnuaryScreenPage({super.key});

  @override
  State<CustomAnnuaryScreenPage> createState() =>
      _CustomAnnuaryScreenPageState();
}

class _CustomAnnuaryScreenPageState extends State<CustomAnnuaryScreenPage> {
  final ResourceService _resourceService = ResourceService();

  String? _selectedSpeciality;
  String? _selectedDistrict;
  String? _selectedRegion;
  String? _selectedCity;
  String? _selectedUniversity;
  String? _selectedGender;
  String? _selectedPromotion;

  var _isLoading = false;
  bool _isDistrictSelected = false;
  bool _isRegionSelected = false;

  List<String> _specialities = [];
  List<String> _districts = [];
  List<String> _regions = [];
  List<String> _cities = [];
  List<String> _promotions = [];

  @override
  void dispose() {
    super.dispose();
  }

  void _submitData() async {
    setState(() {
      _isLoading = true;
    });

    Navigator.of(context).pop({
      'district': _selectedDistrict,
      'region': _selectedRegion,
      'city': _selectedCity,
      'speciality': _selectedSpeciality ?? '',
      'promotion': _selectedPromotion,
      'university': _selectedUniversity,
      'gender': _selectedGender
    });

    setState(() {
      _isLoading = false;
    });
  }

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

  void getDistricts() async {
    try {
      List<String> response = await _resourceService.getDistricts();

      setState(() {
        _districts = response;
        _isDistrictSelected = true;
      });
    } catch (error) {
      print(error);
    }
  }

  void getPromotions() async {
    try {
      List<String> response = await _resourceService.getPromotions();

      setState(() {
        _promotions = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void getRegionsForDistrict(String district) async {
    try {
      List<String> response =
          await _resourceService.getRegionsForSelectedDistrict(district);

      setState(() {
        _isRegionSelected = true;
        _regions = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void getCitiesForRegion(String region) async {
    try {
      List<String> response =
          await _resourceService.getCitiesForSelectedRegion(region);

      setState(() {
        _isRegionSelected = true;
        _cities = response;
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
      getDistricts();
      getPromotions();
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
              label: 'District',
              items: _districts,
              icon: Icons.map,
              onChanged: (String? newValue) async {
                _selectedDistrict = newValue;
                _selectedRegion = null;

                getRegionsForDistrict(newValue!);

                setState(() {});
              },
              selectedValue: _selectedDistrict,
            ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'Choisissez une région',
              items: _regions,
              icon: Icons.map,
              onChanged: (String? newValue) {
                _selectedRegion = newValue;

                getCitiesForRegion(newValue!);

                setState(() {});
              },
              selectedValue: _selectedRegion,
            ),
            const SizedBox(
              height: 20,
            ),
            // MySelectField(
            //   label: 'Choisissez une ville',
            //   items: _cities,
            //   icon: Icons.map,
            //   onChanged: (String? newValue) {
            //     _selectedCity = newValue;
            //     setState(() {});
            //   },
            //   selectedValue: _selectedCity,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            MySelectField(
              label: 'Choisissez une spécialité',
              items: _specialities,
              icon: Icons.medical_services,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSpeciality = newValue;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'Choisissez une université',
              items: defaultUniversities,
              icon: Icons.school,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUniversity = newValue;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),

            MySelectField(
              label: 'Choisissez une promotion',
              items: _promotions,
              icon: Icons.school,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPromotion = newValue;
                });
              },
            ),
            // MyTextField(
            //   controller: _promotionController,
            //   obscureText: false,
            //   labelText: "Choisissez la promotion",
            //   validator: (value) => validateNumber(value, "La promotion"),
            //   isHidden: false,
            //   autoCorrect: false,
            //   keyboardType: TextInputType.number,
            //   textCapitalization: TextCapitalization.none,
            //   icon: Icons.school,
            // ),
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
