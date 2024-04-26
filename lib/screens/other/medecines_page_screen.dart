import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_medecine_card.dart';
import 'package:nuncare_mobile_firebase/models/medecine_model.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class MedecinesPageScreen extends StatefulWidget {
  const MedecinesPageScreen({super.key});

  @override
  State<MedecinesPageScreen> createState() => _MedecinesPageScreenState();
}

class _MedecinesPageScreenState extends State<MedecinesPageScreen> {
  final ResourceService _resourceService = ResourceService();

  List<Medecine> medecines = [];
  var _isLoading = false;

  @override
  void initState() {
    getMedecines();
    super.initState();
  }

  void getMedecines() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<Medecine> response = await _resourceService.getMedecines(size: '10');

      setState(() {
        medecines = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget medecineWidget = const Center(
      child: Text(
        "Aucun médicament ajouté",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    );

    if (_isLoading && medecines.isEmpty) {
      medecineWidget = const Center(
        child: MyLoadingCirle(),
      );
    }

    if (medecines.isNotEmpty) {
      medecineWidget = ListView.builder(
        itemCount: medecines.length,
        itemBuilder: (BuildContext ctx, int index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyMedecineCard(
            medecine: medecines[index],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Les médicaments assurés",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: medecineWidget,
      ),
    );
  }
}
