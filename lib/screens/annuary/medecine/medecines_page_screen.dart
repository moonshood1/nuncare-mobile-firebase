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
  final TextEditingController _searchTextController = TextEditingController();

  List<Medecine> medecines = [];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMedecinesFromStore();
    });
  }

  void getMedecinesFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<Medecine> response = await _resourceService.getMedecines(size: '5');

      setState(() {
        medecines = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void _searchMedecinesFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Medecine> response = await _resourceService
          .searchMedecines(_searchTextController.text.trim());

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Retrouvez tous les médicaments assurés sur la plateforme en recherchant par nom dans la barre de recherche",
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
                      hintText: "Entrez le nom du médicament",
                      suffixIcon: InkWell(
                        onTap: _searchMedecinesFromStore,
                        child: const Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _buildView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildView() {
    if (_isLoading) {
      return const Center(
        child: MyFadingCircleLoading(),
      );
    }

    if (medecines.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Text(
              "Aucun médicament dans la liste",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: getMedecinesFromStore,
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
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        var medecine = medecines[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyMedecineCard(
            medecine: medecine,
          ),
        );
      },
      itemCount: medecines.length,
    );
  }
}
