import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_ad_card.dart';
import 'package:nuncare_mobile_firebase/components/my_article_card.dart';
import 'package:nuncare_mobile_firebase/components/my_article_row.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_medecine_card.dart';
import 'package:nuncare_mobile_firebase/models/ad_model.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/models/medecine_model.dart';
import 'package:nuncare_mobile_firebase/screens/other/diary_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/medecines_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/news_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/notifications_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ResourceService _resourceService = ResourceService();
  final AuthService _auth = AuthService();

  List<Ad> ads = [];
  List<Medecine> medecines = [];
  List<Article> articles = [];

  @override
  void initState() {
    getAdsForStore();
    getMedecinesFromStore();
    getArticlesFromStore();
    super.initState();
  }

  void getAdsForStore() async {
    try {
      List<Ad> response = await _resourceService.getAds();

      setState(() {
        ads = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void getMedecinesFromStore() async {
    try {
      List<Medecine> response = await _resourceService.getMedecines();

      setState(() {
        medecines = response;
      });
    } catch (error) {
      print(error);
    }
  }

  void getArticlesFromStore() async {
    try {
      List<Article> response = await _resourceService.getArticles();

      setState(() {
        articles = response;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/title_nuncare.png',
          scale: 2,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const NotificationsPageScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const NewsPageScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.newspaper,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth(context) * 0.05,
          vertical: deviceWidth(context) * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Le journal',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              _buildArticleList(articles),
              const SizedBox(
                height: 20,
              ),
              _buildRedirectionButton(
                "Consulter le journal complet",
                const DiaryScreenPage(),
              ),
              const SizedBox(
                height: 30,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 130.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                ),
                items: ads.map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return AdCard(ad: i);
                      },
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Les médicaments assurés',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              _buildMedecineList(medecines),
              const SizedBox(
                height: 20,
              ),
              _buildRedirectionButton(
                "Consulter la liste complète",
                const MedecinesPageScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedecineList(List<Medecine> medecines) {
    if (medecines.isEmpty) {
      return const Align(
        alignment: Alignment.center,
        child: Text(
          "Aucun médicament assuré",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w200,
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 15,
          children: <Widget>[
            ...medecines.sublist(0, 3).map(
                  (medecine) => MyMedecineCard(
                    medecine: medecine,
                  ),
                )
          ],
        ),
      );
    }
  }

  Widget _buildArticleList(List<Article> articles) {
    if (articles.isEmpty) {
      return const Align(
        alignment: Alignment.center,
        child: Text(
          "Aucun article disponible",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w200,
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            for (final article in articles)
              MyArticleRow(
                article: article,
              ),
          ],
        ),
      );
    }
  }

  Widget _buildRedirectionButton(String text, Widget screen) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => screen,
            ),
          );
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
