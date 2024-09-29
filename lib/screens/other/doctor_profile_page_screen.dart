import 'package:flutter/material.dart';
import 'package:nuncare_mobile_firebase/components/my_article_row.dart';
import 'package:nuncare_mobile_firebase/components/my_info_tile.dart';
import 'package:nuncare_mobile_firebase/components/my_skeleton.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';
import 'package:nuncare_mobile_firebase/screens/message/chat_page_screen.dart';
import 'package:nuncare_mobile_firebase/services/resource_service.dart';

class DoctorProfilePageScreen extends StatefulWidget {
  const DoctorProfilePageScreen({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  State<DoctorProfilePageScreen> createState() =>
      _DoctorProfilePageScreenState();
}

class _DoctorProfilePageScreenState extends State<DoctorProfilePageScreen> {
  final ResourceService _resourceService = ResourceService();
  var _isArticleLoading = false;
  List<Article> articles = [];

  void getUserArticlesFromStore() async {
    try {
      setState(() {
        _isArticleLoading = true;
      });

      List<Article> response =
          await _resourceService.getDoctorArticles(widget.doctor.id!);

      setState(() {
        articles = response;
        _isArticleLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getUserArticlesFromStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    widget.doctor.img,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.doctor.email,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text("Informations"),
            const SizedBox(
              height: 40,
            ),
            MyInfoTile(
              text: "${widget.doctor.firstName} ${widget.doctor.lastName}",
              title: "Nom complet",
            ),
            MyInfoTile(
              text: widget.doctor.isPhoneHidden
                  ? '**********'
                  : widget.doctor.phone,
              title: "Numéro de téléphone",
            ),
            MyInfoTile(
              text: widget.doctor.speciality,
              title: "Specialité",
            ),
            MyInfoTile(
              text: widget.doctor.university,
              title: "Université de formation",
            ),
            MyInfoTile(
              text: widget.doctor.promotion,
              title: "Promotion",
            ),
            MyInfoTile(
              text: widget.doctor.hospital,
              title: "Hopital d'exercice",
            ),
            MyInfoTile(
              text: widget.doctor.years.toString(),
              title: "Nombre d'années d'experience",
            ),
            MyInfoTile(
              text: widget.doctor.isOrderNumberHidden
                  ? '**********'
                  : widget.doctor.orderNumber,
              title: "Numéro d'ordre",
            ),
            // MyInfoTile(
            //   text: widget.doctor.district,
            //   title: "District",
            // ),
            MyInfoTile(
              text: widget.doctor.region,
              title: "Région",
            ),
            MyInfoTile(
              text: widget.doctor.city,
              title: "Ville",
            ),
            const SizedBox(
              height: 40,
            ),
            const Text("Articles publiés"),
            const SizedBox(
              height: 20,
            ),
            _buildArticleList(
              articles,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ChatPageScreen(
              receiverName: widget.doctor.email,
              receiverId: widget.doctor.firebaseId,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleList(List<Article> articles) {
    if (_isArticleLoading == false && articles.isEmpty) {
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
    } else if (_isArticleLoading == true && articles.isEmpty) {
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
        ],
      );
    } else {
      return Column(
        children: [
          for (final article in articles)
            MyArticleRow(
              article: article,
            ),
        ],
      );
    }
  }
}
