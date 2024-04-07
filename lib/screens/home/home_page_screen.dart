import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_skeleton.dart';
import 'package:nuncare_mobile_firebase/services/auth_service.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  void _logout() {
    final _auth = AuthService();

    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Accueil',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth(context) * 0.05,
          vertical: deviceWidth(context) * 0.03,
        ),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MySkeleton(
                      height: 120,
                      width: 300,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MySkeleton(
                      height: 120,
                      width: 300,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MySkeleton(
                      height: 120,
                      width: 300,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MySkeleton(
                height: 35,
                width: 300,
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MySkeleton(
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MySkeleton(
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MySkeleton(
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MySkeleton(
                      height: 120,
                      width: 120,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MySkeleton(
                height: 35,
                width: 300,
              ),
              SizedBox(
                height: 30,
              ),
              MySkeleton(
                height: 100,
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              MySkeleton(
                height: 100,
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              MySkeleton(
                height: 100,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
