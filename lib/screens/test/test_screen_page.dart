import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_selectfield.dart';
import 'package:nuncare_mobile_firebase/components/my_user_tile.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/screens/message/chat_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/chat_service.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class TestPageScreen extends StatefulWidget {
  const TestPageScreen({super.key});

  @override
  State<TestPageScreen> createState() => _TestPageScreenState();
}

class _TestPageScreenState extends State<TestPageScreen> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final ResourceService _resourceService = ResourceService();

  String? _selectedDistrict;
  String? _selectedRegion;
  String? _selectedCity;

  bool _isDistrictSelected = false;
  bool _isRegionSelected = false;

  List<String> _districts = [];
  List<String> _regions = [];
  List<String> _cities = [];

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
        _isDistrictSelected = true;
        _regions = response;
      });

      print('Les regions disponibles pour $district : $response');
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

      print('Les villes disponibles pour $region : $response');
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
        child: Column(
          children: [
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
              label: 'Région',
              items: _regions,
              icon: Icons.location_city,
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
          ],
        ),
      ),
    );
  }
}
