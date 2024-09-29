import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/models/info_model.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class NewsPageScreen extends StatefulWidget {
  const NewsPageScreen({super.key});

  @override
  State<NewsPageScreen> createState() => _NewsPageScreenState();
}

class _NewsPageScreenState extends State<NewsPageScreen> {
  final ResourceService _resourceService = ResourceService();
  List<Info> infos = [];
  var _isLoading = false;

  void getNewsFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Info> response = await _resourceService.getInfos();

      setState(() {
        infos = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Actualités",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: _buildView(),
    );
  }

  Widget _buildView() {
    if (_isLoading) {
      return const Center(
        child: MyFadingCircleLoading(),
      );
    }

    if (infos.isEmpty) {
      return const Center(
        child: Text(
          "Aucune actualité pour l'instant",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    }

    return ListView.builder(
      itemBuilder: (ctx, index) {
        var info = infos[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(info.title),
        );
      },
      itemCount: infos.length,
    );
  }
}
