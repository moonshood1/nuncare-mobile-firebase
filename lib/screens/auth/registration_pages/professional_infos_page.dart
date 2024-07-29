import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';
import 'package:nuncare_mobile_firebase/validators/number_validator.dart';

class ProfessionnalPageInfos extends StatefulWidget {
  ProfessionnalPageInfos({
    super.key,
    required this.controller,
    required this.yearsController,
    required this.promotionController,
    required this.orderNumberController,
    this.selectedSpeciality,
    this.selectedDistrict,
    this.selectedRegion,
    this.regions,
    required this.onChangeDistrict,
    required this.onChangeSpeciality,
    required this.onChangeRegion,
  });

  final PageController controller;
  final TextEditingController yearsController,
      promotionController,
      orderNumberController;
  String? selectedSpeciality;
  String? selectedDistrict;
  String? selectedRegion;
  List<String>? regions;
  final void Function(String? value) onChangeDistrict,
      onChangeSpeciality,
      onChangeRegion;

  @override
  State<ProfessionnalPageInfos> createState() => _ProfessionnalPageInfosState();
}

class _ProfessionnalPageInfosState extends State<ProfessionnalPageInfos>
    with AutomaticKeepAliveClientMixin {
  final ResourceService _resourceService = ResourceService();

  List<String> _specialities = [];
  List<String> _districts = [];
  List<String> _regions = [];
  bool _isDistrictSelected = false;

  void getSpecialities() async {
    try {
      List<String> response = await _resourceService.getSpecialities();

      setState(() {
        _specialities = response;
      });
    } catch (error) {
      print("specialite error");
      print(error);
    }
  }

  void getDistricts() async {
    try {
      List<String> response = await _resourceService.getDistricts();

      setState(() {
        _districts = response;
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
        _isDistrictSelected = true;
        _regions = response;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            MySelectField(
              label: 'Spécialité',
              items: _specialities,
              icon: Icons.medical_services,
              onChanged: (String? newValue) {
                widget.onChangeSpeciality(newValue!);
                widget.selectedSpeciality = newValue;

                setState(() {});
              },
              selectedValue: widget.selectedSpeciality,
            ),
            const SizedBox(
              height: 20,
            ),
            MySelectField(
              label: 'District',
              items: _districts,
              icon: Icons.map,
              onChanged: (String? newValue) async {
                widget.onChangeDistrict(newValue!);
                widget.selectedDistrict = newValue;
                widget.selectedRegion = null;
                widget.onChangeRegion(null);

                getRegionsForDistrict(newValue);

                setState(() {});
              },
              selectedValue: widget.selectedDistrict,
            ),

            // if (_isDistrictSelected)
            //   Column(
            //     children: [
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       MySelectField(
            //         label: 'Région',
            //         items: _regions,
            //         icon: Icons.location_city,
            //         onChanged: (String? newValue) {
            //           widget.onChangeRegion(newValue!);
            //           widget.selectedRegion = newValue;

            //           setState(() {});
            //         },
            //         selectedValue: widget.selectedRegion,
            //       ),
            //     ],
            //   ),
            // if (widget.selectedDistrict != null && _regions.isNotEmpty)
            //   Column(
            //     children: [
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       MySelectField(
            //         label: 'Région',
            //         items: _regions,
            //         icon: Icons.location_city,
            //         onChanged: (String? newValue) {
            //           widget.onChangeRegion(newValue!);
            //           widget.selectedRegion = newValue;

            //           setState(() {});
            //         },
            //         selectedValue: widget.selectedRegion,
            //       ),
            //     ],
            //   ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: widget.yearsController,
              obscureText: false,
              labelText: "Année d'expérience",
              validator: (value) => validateNumber(
                value,
                "le nombre d'année d'expérience",
              ),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.none,
              icon: Icons.calendar_month,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: widget.promotionController,
              obscureText: false,
              labelText: "Numéro promotion",
              validator: (value) => validateNumber(value, "la promotion"),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.none,
              icon: Icons.school,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: widget.orderNumberController,
              obscureText: false,
              labelText: "Numéro d'ordre",
              validator: (value) => validateNumber(value, "le numéro d'ordre"),
              isHidden: false,
              autoCorrect: false,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.none,
              icon: Icons.medical_information,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.controller.previousPage(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          curve: Curves.easeOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Retour",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => widget.controller.nextPage(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeIn,
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Suivant",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
