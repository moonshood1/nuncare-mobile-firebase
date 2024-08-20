import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_skeleton.dart';
import 'package:nuncare_mobile_firebase/components/my_user_card.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/custom_annuary_screen_search_page.dart';
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

  void _searchDoctorsWithParametersFromStore(
    String district,
    String region,
    String city,
    String speciality,
    String promotion,
    String university,
    String gender,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Doctor> response =
          await _resourceService.searchDoctorsWithParameters(
        district,
        region,
        city,
        speciality,
        promotion,
        university,
        gender,
      );

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

  void _openCustomSearchModal(BuildContext context) async {
    final result = await showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) => const CustomAnnuaryScreenPage(),
    );

    print("resulat du pop : $result");

    if (result != null) {
      _searchDoctorsWithParametersFromStore(
        result['district'] ?? '',
        result["region"] ?? '',
        result["city"] ?? '',
        result['speciality'] ?? '',
        result['promotion'] ?? '',
        result["university"] ?? '',
        result["gender"] ?? '',
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

    if (_isLoading == true && doctors.isEmpty) {
      doctorWidget = const Column(
        children: [
          MyDoctorCardSkeleton(),
          SizedBox(height: 10),
          MyDoctorCardSkeleton(),
          SizedBox(height: 10),
          MyDoctorCardSkeleton(),
          SizedBox(height: 10),
          MyDoctorCardSkeleton(),
          SizedBox(height: 10),
          MyDoctorCardSkeleton(),
        ],
      );
    }

    if (doctors.isNotEmpty) {
      doctorWidget = Column(
        children: [
          ...doctors.map(
            (doctor) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 2.5),
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
        actions: [
          IconButton(
            onPressed: () {
              _openSearchModal(context);
            },
            icon: const Icon(
              Icons.location_on,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              _openCustomSearchModal(context);
            },
            icon: const Icon(
              Icons.tune,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tous les medecins de Nuncare',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Retrouvez tous les medecins inscrits sur la plateforme en recherchant par nom dans la barre de recherche",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _searchTextController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        hintText: "Entrez le nom d'un médecin",
                        suffixIcon: InkWell(
                          onTap: _searchDoctorsFromStore,
                          child: const Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Les medecins de Nuncare',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Les derniers medecins inscrits sur la plateforme',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
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