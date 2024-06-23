import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_ad_card.dart';
import 'package:nuncare_mobile_firebase/components/my_article_row.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_medecine_card.dart';
import 'package:nuncare_mobile_firebase/components/my_skeleton.dart';
import 'package:nuncare_mobile_firebase/models/ad_model.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/models/medecine_model.dart';
import 'package:nuncare_mobile_firebase/screens/other/diary_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/medecines_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/news_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/notifications_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ResourceService _resourceService = ResourceService();

  List<Ad> ads = [];
  List<Medecine> medecines = [];
  List<Article> articles = [];
  var _isLoading = false;
  var _adsLoading = false;
  var _medsLoading = false;

  @override
  void initState() {
    getAdsForStore();
    getMedecinesFromStore();
    getArticlesFromStore();
    super.initState();
  }

  void getAdsForStore() async {
    try {
      setState(() {
        _adsLoading = true;
      });

      List<Ad> response = await _resourceService.getAds();

      setState(() {
        ads = response;
        _adsLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void getMedecinesFromStore() async {
    try {
      setState(() {
        _medsLoading = true;
      });
      List<Medecine> response = await _resourceService.getMedecines();

      setState(() {
        medecines = response;
        _medsLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void getArticlesFromStore() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<Article> response = await _resourceService.getArticles();

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
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        //iconTheme: IconThemeData(color: Colors.black),
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
              // const Text(
              //   'Le journal',
              //   style: TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 10),
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
              _buildAdCarouselSlider(),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Les médicaments assurés',
                style: TextStyle(
                  fontSize: 1,
                  fontWeight: FontWeight.bold,
                ),
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
    if (_medsLoading == false && medecines.isEmpty) {
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
    } else if (_medsLoading == true && medecines.isEmpty) {
      return const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 15,
          children: <Widget>[
            MyMedecineCardSkeleton(),
            MyMedecineCardSkeleton(),
            MyMedecineCardSkeleton(),
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ...medecines.sublist(0, 4).map(
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
    if (_isLoading == false && articles.isEmpty) {
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
    } else if (_isLoading == true && articles.isEmpty) {
      return const Column(
        children: [
          MyArticleSkeleton(),
          SizedBox(
            height: 40,
          ),
          MyArticleSkeleton(
            height: 100,
            width: double.infinity,
          ),
          MyArticleSkeleton(
            height: 100,
            width: double.infinity,
          ),
        ],
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

  Widget _buildAdCarouselSlider() {
    if (_adsLoading == true && ads.isEmpty) {
      return const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            MyAdSkeleton(),
            SizedBox(
              width: 10,
            ),
            MyAdSkeleton(),
            SizedBox(
              width: 10,
            ),
            MyAdSkeleton(),
          ],
        ),
      );
    } else {
      return CarouselSlider(
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
