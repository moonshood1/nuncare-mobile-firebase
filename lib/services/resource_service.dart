import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuncare_mobile_firebase/models/ad_model.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/models/info_model.dart';
import 'package:nuncare_mobile_firebase/constants/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:nuncare_mobile_firebase/models/medecine_model.dart';
import 'package:nuncare_mobile_firebase/models/notification_model.dart';

class ResourceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Medecine>> getMedecines({String size = '5'}) async {
    try {
      final url = Uri.parse("$baseUrl/resources/medecines?size=$size");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> medecinesData = responseData['medecines'] ?? [];

        final List<Medecine> medecines =
            medecinesData.map((data) => Medecine.fromJson(data)).toList();

        return medecines;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception(
          'Erreur lors de la récupération des médicaments : $error');
    }
  }

  Future<List<Ad>> getAds() async {
    try {
      final url = Uri.parse("$baseUrl/resources/ads");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> adsData = responseData['ads'] ?? [];

        final List<Ad> ads = adsData.map((data) => Ad.fromJson(data)).toList();

        return ads;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des pubs : $error');
    }
  }

  Future<void> addArticle(Article article) async {
    try {
      Map<String, dynamic> articleData = article.toJson();
      await _firestore.collection('Ads').add(articleData);
      print("Article ajouté avec succès");
    } catch (error) {
      print("Erreur lors de l'ajout de l'article: $error");
      throw error;
    }
  }

  Future<List<Article>> getArticles({int limit = 5}) {
    return _firestore
        .collection('Articles')
        .limit(limit)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return Article.fromJson(doc.data());
      }).toList();
    }).catchError((error) {
      print("Error getting articles: $error");
      throw error;
    });
  }

  Future<List<Article>> getSpecificUserArticles(String uid) {
    return _firestore
        .collection('Ads')
        .where('authorId', isEqualTo: uid)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return Article.fromJson(doc.data());
      }).toList();
    }).catchError((error) {
      print("Error getting articles: $error");
      throw error;
    });
  }

  Future<List<Notif>> getNotifications() async {
    try {
      final url = Uri.parse("$baseUrl/resources/notifications");

      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> notificationsData =
            responseData['notifications'] ?? [];

        final List<Notif> notifications =
            notificationsData.map((data) => Notif.fromJson(data)).toList();

        return notifications;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception(
          'Erreur lors de la récupération des notifications : $error');
    }
  }

  Future<List<Info>> getInfos() async {
    try {
      final url = Uri.parse("$baseUrl/resources/infos");

      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> infosData = responseData['infos'] ?? [];

        final List<Info> infos =
            infosData.map((data) => Info.fromJson(data)).toList();

        return infos;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des news : $error');
    }
  }
}
