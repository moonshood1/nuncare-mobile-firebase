import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_article_row.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class DiaryScreenPage extends StatefulWidget {
  const DiaryScreenPage({super.key});

  @override
  State<DiaryScreenPage> createState() => _DiaryScreenPageState();
}

class _DiaryScreenPageState extends State<DiaryScreenPage> {
  final ResourceService _resourceService = ResourceService();

  List<Article> articles = [];
  var _isLoading = false;

  @override
  void initState() {
    getArticles();
    super.initState();
  }

  void getArticles() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<Article> response = await _resourceService.getArticles(size: 20);

      setState(() {
        articles = response;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget articleWidget = const Center(
      child: Text(
        "Aucun article ajouté",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    );

    if (_isLoading && articles.isEmpty) {
      articleWidget = const Center(
        child: MyLoadingCirle(),
      );
    }

    if (articles.isNotEmpty) {
      articleWidget = ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext ctx, int index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyArticleRow(
            article: articles[index],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Le journal',
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
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: articleWidget,
      ),
    );
  }
}
