import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuncare_mobile_firebase/screens/auth/login_screen.dart';
import 'package:nuncare_mobile_firebase/screens/auth/register_screen.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  late PageController _pageController;

  void goToLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const LoginScreen(),
      ),
    );
  }

  void goToRegistrationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const RegisterScreen(),
      ),
    );
  }

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: sliders.length,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => SliderContent(
                  title: sliders[index].title,
                  image: sliders[index].image,
                  description: sliders[index].description,
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                ...List.generate(
                  sliders.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DotIndicator(
                      isActive: index == _pageIndex,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            ConnexionButtons(
              navigateToLogin: goToLoginScreen,
              navigateToRegistration: goToRegistrationScreen,
            ),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 6,
      width: isActive ? 12 : 6,
      decoration: BoxDecoration(
          border: isActive
              ? Border.all(color: Theme.of(context).colorScheme.primary)
              : Border.all(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withOpacity(0.2)),
    );
  }
}

class Slider {
  final String image, title, description;

  Slider({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Slider> sliders = [
  Slider(
    image: "assets/images/male_doctor.png",
    title: "NunCare pour les professionnels",
    description:
        "Découvrez la plateforme qui connecte tous les professionnels de la santé.",
  ),
  Slider(
    image: "assets/images/female_doctor.png",
    title: "NunCare , pour des échanges entre professionnels",
    description:
        "Discutez, transférez des documents, des données et des informations",
  )
];

class ConnexionButtons extends StatelessWidget {
  const ConnexionButtons({
    required this.navigateToLogin,
    required this.navigateToRegistration,
    super.key,
  });

  final void Function() navigateToLogin, navigateToRegistration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
            onPressed: navigateToRegistration,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
              foregroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
            child: Text(
              style: GoogleFonts.poppins(),
              "Inscription",
            ),
          ),
          ElevatedButton(
            onPressed: navigateToLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              textStyle: GoogleFonts.poppins(
                fontSize: 15,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
            child: Text(
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
              "Connexion",
            ),
          ),
        ],
      ),
    );
  }
}

class SliderContent extends StatelessWidget {
  const SliderContent({
    required this.title,
    required this.image,
    required this.description,
    super.key,
  });

  final String title, image, description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            image,
            width: 200,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w300),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
