import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_user_card.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/location_screen_page.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class AnnuaryPageScreen extends StatefulWidget {
  const AnnuaryPageScreen({super.key});

  @override
  State<AnnuaryPageScreen> createState() => _AnnuaryPageScreenState();
}

class _AnnuaryPageScreenState extends State<AnnuaryPageScreen> {
  final ResourceService _resourceService = ResourceService();
  final TextEditingController _searchTextController = TextEditingController();

  List<Doctor> doctors = [];
  var _isLoading = false;

  void getDoctorsFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Doctor> response = await _resourceService.getDoctors();

      setState(() {
        doctors = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void _searchDoctorsFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Doctor> response = await _resourceService
          .searchDoctors(_searchTextController.text.trim());

      setState(() {
        doctors = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void _searchDoctorsByLocationFromStore(String lat, String lng) async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Doctor> response = await _resourceService.localizeDoctors(lat, lng);

      setState(() {
        doctors = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void _openSearchModal(BuildContext context) async {
    final result = await showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      builder: (ctx) => const LocationScreenPage(),
    );

    if (result != null) {
      _searchDoctorsByLocationFromStore(
        result["lat"].toString(),
        result['lng'].toString(),
      );
    }
  }

  @override
  void initState() {
    getDoctorsFromStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget doctorWidget = Center(
      child: Column(
        children: [
          const Text(
            "Aucun docteur dans l'annuaire",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: getDoctorsFromStore,
            child: const Text(
              "Actualiser la liste",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );

    if (_isLoading && doctors.isEmpty) {
      doctorWidget = const Center(
        child: MyLoadingCirle(),
      );
    }

    if (doctors.isNotEmpty) {
      doctorWidget = Column(
        children: [
          ...doctors.map(
            (doctor) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyUserCard(doctor: doctor),
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Annuaire des medecins',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _searchTextController,
                        decoration: InputDecoration(
                          hintText: 'Rechercher un médecin...',
                          suffixIcon: InkWell(
                            onTap: _searchDoctorsFromStore,
                            child: const Icon(
                              Icons.search,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        _openSearchModal(context);
                      },
                      icon: const Icon(
                        Icons.location_on,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              doctorWidget
            ],
          ),
        ),
      ),
    );
  }
}




      // ListView.builder(
      //   itemCount: doctors.length,
      //   itemBuilder: (BuildContext ctx, int index) => Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: MyUserCard(
      //       doctor: doctors[index],
      //     ),
      //   ),
      // );