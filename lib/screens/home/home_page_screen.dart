import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_ad_card.dart';
import 'package:nuncare_mobile_firebase/components/my_article_row.dart';
import 'package:nuncare_mobile_firebase/components/my_doctor_bubble.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_medecine_card.dart';
import 'package:nuncare_mobile_firebase/components/my_skeleton.dart';
import 'package:nuncare_mobile_firebase/models/ad_model.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/models/medecine_model.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/annuary_screen_page.dart';
import 'package:nuncare_mobile_firebase/screens/other/diary_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/doctors_page_screen.dart';
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
  List<Doctor> doctors = [];
  var _isLoading = false;
  var _adsLoading = false;
  var _medsLoading = false;
  var _docsLoading = false;

  @override
  void initState() {
    getAdsForStore();
    getMedecinesFromStore();
    getArticlesFromStore();
    getlastRegisteredDoctors();
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

  void getlastRegisteredDoctors() async {
    try {
      setState(() {
        _docsLoading = true;
      });
      List<Doctor> response = await _resourceService.getLastRegisteredDoctors();

      setState(() {
        doctors = response;
        _docsLoading = false;
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
              Row(
                children: [
                  Image.asset(
                    'assets/icons/article.png',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Journal',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
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
              _buildAdCarouselSlider(),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/medi.png',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Médicaments assurés',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
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
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/doctors.png',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Derniers medecins inscrits',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildLastRegisteredDoctors(doctors),
              const SizedBox(
                height: 30,
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

  Widget _buildLastRegisteredDoctors(List<Doctor> doctors) {
    if (_docsLoading == false && doctors.isEmpty) {
      return const Align(
        alignment: Alignment.center,
        child: Text(
          "Aucun docteurs inscrits récemment",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w200,
          ),
        ),
      );
    } else if (_docsLoading == true && doctors.isEmpty) {
      return const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyDoctorBubbleSkeleton(),
            SizedBox(
              width: 30,
            ),
            MyDoctorBubbleSkeleton(),
            SizedBox(
              width: 30,
            ),
            MyDoctorBubbleSkeleton(),
            SizedBox(
              width: 30,
            ),
            MyDoctorBubbleSkeleton(),
          ],
        ),
      );
    } else {
      return Column(children: [
        const Text(
          'Retrouvez les 4 derniers docteurs inscrits sur la plateforme',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 13,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final doctor in doctors)
                MyDoctorBubble(
                  doctor: doctor,
                ),
            ],
          ),
        )
      ]);
    }
  }
}
