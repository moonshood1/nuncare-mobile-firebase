import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_pharmacy_card.dart';
import 'package:nuncare_mobile_firebase/models/pharmacy_model.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/location_screen_page.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/pharmacy/custom_pharmacies_search_screen_page.dart';
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
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPharmaciesFromStore();
    });
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

  void _searchPharmaciesWithParametersFromStore(
    String section,
    String area,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Pharmacy> response =
          await _resourceService.searchPharmaciesWithParameters(
        section,
        area,
      );

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

  void _openCustomSearchModal(BuildContext context) async {
    final result = await showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      builder: (ctx) => const CustomPharmacyScreenPage(),
    );

    print("resulat du pop : $result");

    if (result != null) {
      _searchPharmaciesWithParametersFromStore(
        result['section'] ?? '',
        result["area"] ?? '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Retrouvez toutes les pharmacies sur la plateforme en recherchant par section , zone ou emplacement géographique",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
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

    if (pharmacies.isEmpty) {
      return Center(
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
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        var pharmacy = pharmacies[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyPharmacyCard(
            pharmacy: pharmacy,
          ),
        );
      },
      itemCount: pharmacies.length,
    );
  }
}
