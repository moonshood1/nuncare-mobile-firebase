import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/components/my_textfield.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';
import 'package:nuncare_mobile_firebase/validators/number_validator.dart';

class LocationPageInfos extends StatefulWidget {
  LocationPageInfos({
    super.key,
    required this.controller,
    this.selectedDistrict,
    this.selectedRegion,
    this.selectedCity,
    this.regions,
    required this.onChangeDistrict,
    required this.onChangeRegion,
    required this.onChangeCity,
  });

  final PageController controller;
  String? selectedDistrict, selectedRegion, selectedCity;

  List<String>? regions;
  final void Function(String? value) onChangeDistrict,
      onChangeRegion,
      onChangeCity;

  @override
  State<LocationPageInfos> createState() => _LocationPageInfosState();
}

class _LocationPageInfosState extends State<LocationPageInfos>
    with AutomaticKeepAliveClientMixin {
  final ResourceService _resourceService = ResourceService();

  List<String> _districts = [];
  List<String> _regions = [];
  List<String> _cities = [];
  bool _isDistrictSelected = false;
  bool _isRegionSelected = false;

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
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                MySelectField(
                  label: 'Région',
                  items: _regions,
                  icon: Icons.location_city,
                  onChanged: (String? newValue) {
                    widget.onChangeRegion(newValue!);
                    widget.selectedRegion = newValue;

                    getCitiesForRegion(newValue);

                    setState(() {});
                  },
                  selectedValue: widget.selectedRegion,
                ),
              ],
            ),
            // if (widget.selectedDistrict != null && _regions.isNotEmpty)
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                MySelectField(
                  label: 'Ville',
                  items: _cities,
                  icon: Icons.location_city,
                  onChanged: (String? newValue) {
                    widget.onChangeCity(newValue!);
                    widget.selectedCity = newValue;

                    setState(() {});
                  },
                  selectedValue: widget.selectedCity,
                ),
              ],
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
