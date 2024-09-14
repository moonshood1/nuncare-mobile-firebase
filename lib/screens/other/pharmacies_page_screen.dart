import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_pharmacy_card.dart';
import 'package:nuncare_mobile_firebase/components/my_skeleton.dart';
import 'package:nuncare_mobile_firebase/models/pharmacy_model.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/location_screen_page.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class PharmaciesPageScreen extends StatefulWidget {
  const PharmaciesPageScreen({super.key});

  @override
  State<PharmaciesPageScreen> createState() => _PharmaciesPageScreenState();
}

class _PharmaciesPageScreenState extends State<PharmaciesPageScreen> {
  final ResourceService _resourceService = ResourceService();
  final TextEditingController _searchTextController = TextEditingController();

  List<Pharmacy> pharmacies = [];
  var _isLoading = false;

  @override
  void initState() {
    getPharmaciesFromStore();
    super.initState();
  }

  void getPharmaciesFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<Pharmacy> response = await _resourceService.getPharmacies();

      setState(() {
        pharmacies = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void _searchPharmaciesFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Pharmacy> response = await _resourceService
          .searchPharmacies(_searchTextController.text.trim());

      setState(() {
        pharmacies = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void _searchPharmaciesByLocationFromStore(String lat, String lng) async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Pharmacy> response =
          await _resourceService.localizePharmacies(lat, lng);

      setState(() {
        pharmacies = response;
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
      _searchPharmaciesByLocationFromStore(
        result["lat"].toString(),
        result['lng'].toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget pharmacieWidget = Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Aucune pharmacie trouvée",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: getPharmaciesFromStore,
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

    if (_isLoading && pharmacies.isEmpty) {
      pharmacieWidget = const Column(
        children: [
          MyMedecineCardSkeleton(),
          SizedBox(height: 8),
          MyMedecineCardSkeleton(),
          SizedBox(height: 8),
          MyMedecineCardSkeleton(),
          SizedBox(height: 8),
          MyMedecineCardSkeleton(),
          SizedBox(height: 8),
          MyMedecineCardSkeleton(),
        ],
      );
    }

    if (pharmacies.isNotEmpty) {
      pharmacieWidget = Column(
        children: [
          ...pharmacies.map(
            (pharmacy) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyPharmacyCard(
                pharmacy: pharmacy,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Annuaire des pharmacies",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
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
          // IconButton(
          //   onPressed: () {
          //     _openCustomSearchModal(context);
          //   },
          //   icon: const Icon(
          //     Icons.tune,
          //     size: 30,
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Retrouvez toutes les pharmacies sur la plateforme en recherchant par nom dans la barre de recherche",
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
                        hintText: "Entrez le nom de la pharmacie",
                        suffixIcon: InkWell(
                          onTap: _searchPharmaciesFromStore,
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
                height: 10,
              ),
              pharmacieWidget
            ],
          ),
        ),
      ),
    );
  }
}
