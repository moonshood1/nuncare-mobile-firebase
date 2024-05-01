import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_user_card.dart';
import 'package:nuncare_mobile_firebase/components/my_user_card_row.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
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

  void searchDoctorsFromStore() async {
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

  @override
  void initState() {
    getDoctorsFromStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget doctorWidget = const Center(
      child: Text(
        "Aucun docteur dans l'annuaire",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: _searchTextController,
          //           decoration: const InputDecoration(
          //             hintText: 'Rechercher un médecin...',
          //             prefixIcon: Icon(Icons.search),
          //             border: OutlineInputBorder(),
          //           ),
          //         ),
          //       ),
          //       // IconButton(
          //       //   icon: const Icon(Icons.search),
          //       //   onPressed: searchDoctorsFromStore,
          //       // ),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
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
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(child: doctorWidget),
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