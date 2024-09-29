import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_ad_card.dart';
import 'package:nuncare_mobile_firebase/components/my_article_row.dart';
import 'package:nuncare_mobile_firebase/components/my_doctor_bubble.dart';
import 'package:nuncare_mobile_firebase/components/my_drawer.dart';
import 'package:nuncare_mobile_firebase/components/my_loading.dart';
import 'package:nuncare_mobile_firebase/components/my_medecine_card.dart';
import 'package:nuncare_mobile_firebase/models/ad_model.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/models/medecine_model.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/annuary_screen_page.dart';
import 'package:nuncare_mobile_firebase/screens/other/diary_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/annuary/medecine/medecines_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/news_page_screen.dart';
import 'package:nuncare_mobile_firebase/screens/other/notifications_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/hive_service.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ResourceService _resourceService = ResourceService();
  final HiveService _hiveService = HiveService();

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
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    // });
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
      _medsLoading = false;
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
      _isLoading = false;
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
    var screenWidth = MediaQuery.of(context).size.width;
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
          horizontal: screenWidth * 0.05,
          vertical: screenWidth * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildArticleList(articles),
              const SizedBox(
                height: 20,
              ),
              _buildAdCarouselSlider(),
              const SizedBox(
                height: 20,
              ),
              _buildMedecineList(medecines),
              const SizedBox(
                height: 20,
              ),
              _buildLastRegisteredDoctors(doctors),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildArticleList(List<Article> articles) {
    if (_isLoading == true) {
      return const Center(
        child: MyFadingCircleLoading(),
      );
    }

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
    }
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/article.png',
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Journal',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        for (final article in articles)
          MyArticleRow(
            article: article,
          ),
        _buildRedirectionButton(
          "Consulter le journal complet",
          const DiaryScreenPage(),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildAdCarouselSlider() {
    if (_adsLoading == true && ads.isEmpty) {
      return const Center(
        child: MyFadingCircleLoading(),
      );
    } else {
      return CarouselSlider(
        options: CarouselOptions(
          height: 160.0,
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

  Widget _buildMedecineList(List<Medecine> medecines) {
    if (_medsLoading) {
      return const Center(
        child: MyFadingCircleLoading(),
      );
    }

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
    }
    return Column(
      children: <Widget>[
        Row(
          children: [
            Image.asset(
              'assets/icons/medi.png',
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Médicaments assurés',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...medecines.sublist(0, 4).map(
              (medecine) => MyMedecineCard(
                medecine: medecine,
              ),
            ),
        const SizedBox(height: 10),
        _buildRedirectionButton(
          "Consulter la liste complète",
          const MedecinesPageScreen(),
        ),
      ],
    );
  }

  Widget _buildLastRegisteredDoctors(List<Doctor> doctors) {
    if (_docsLoading == true) {
      return const Center(
        child: MyFadingCircleLoading(),
      );
    }

    if (doctors.isEmpty) {
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
    }

    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/doctors.png',
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Derniers medecins inscrits',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              final doctor = doctors[index];
              return MyDoctorBubble(
                doctor: doctor,
              );
            },
            itemCount: doctors.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(height: 10),
        _buildRedirectionButton(
          "Consulter l'annuaire",
          const AnnuaryPageScreen(),
        ),
      ],
    );
  }
}
