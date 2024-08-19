import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuncare_mobile_firebase/constants/default_values.dart';
import 'package:nuncare_mobile_firebase/constants/uris.dart';
import 'package:nuncare_mobile_firebase/models/ad_model.dart';
import 'package:nuncare_mobile_firebase/models/article_model.dart';
import 'package:nuncare_mobile_firebase/models/hospital_model.dart';
import 'package:nuncare_mobile_firebase/models/info_model.dart';
import 'package:nuncare_mobile_firebase/constants/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:nuncare_mobile_firebase/models/medecine_model.dart';
import 'package:nuncare_mobile_firebase/models/notification_model.dart';
import 'package:nuncare_mobile_firebase/models/pharmacy_model.dart';
import 'package:nuncare_mobile_firebase/models/user_model.dart';

class ResourceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Notif>> getNotifications() async {
    try {
      final url = Uri.parse("$resourcesUri/notifications");

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
      final url = Uri.parse("$resourcesUri/infos");

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

  Future<List<Article>> getArticles({int size = 3}) async {
    try {
      final url = Uri.parse("$resourcesUri/articles?size=$size");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> articlesData = responseData['articles'] ?? [];

        final List<Article> articles =
            articlesData.map((data) => Article.fromJson(data)).toList();

        return articles;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des articles : $error');
    }
  }

  Future<List<Medecine>> getMedecines({String size = '5'}) async {
    try {
      final url = Uri.parse("$resourcesUri/medecines?size=$size");

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

  Future<List<Medecine>> searchMedecines(String searchText) async {
    try {
      final url = Uri.parse("$resourcesUri/medecines-search");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'searchText': searchText,
          },
        ),
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
        'Erreur lors de la récupération des médicaments : $error',
      );
    }
  }

  Future<List<Pharmacy>> getPharmacies({int size = 5}) async {
    try {
      final url = Uri.parse("$resourcesUri/pharmacies?size=$size");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> pharmaciesData = responseData['pharmacies'] ?? [];

        final List<Pharmacy> pharmacies =
            pharmaciesData.map((data) => Pharmacy.fromJson(data)).toList();

        return pharmacies;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des pharmacies : $error');
    }
  }

  Future<List<Pharmacy>> searchPharmacies(String searchText) async {
    try {
      final url = Uri.parse("$resourcesUri/pharmacies-search");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'searchText': searchText,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> pharmaciesData = responseData['pharmacies'] ?? [];

        final List<Pharmacy> pharmacies =
            pharmaciesData.map((data) => Pharmacy.fromJson(data)).toList();

        return pharmacies;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des pharmacies : $error');
    }
  }

  Future<List<Pharmacy>> localizePharmacies(String lat, String lng) async {
    try {
      final url =
          Uri.parse("$resourcesUri/pharmacies-localize?lat=$lat&lng=$lng");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> pharmaciesData = responseData['pharmacies'] ?? [];

        final List<Pharmacy> pharmacies =
            pharmaciesData.map((data) => Pharmacy.fromJson(data)).toList();

        return pharmacies;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(
        'Erreur lors de la récupération des hopitaux selon la position : $e',
      );
    }
  }

  Future<List<Hospital>> getHospitals({int size = 5}) async {
    try {
      final url = Uri.parse("$resourcesUri/hospitals?size=$size");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> hospitalsData = responseData['hospitals'] ?? [];

        final List<Hospital> hospitals =
            hospitalsData.map((data) => Hospital.fromJson(data)).toList();

        return hospitals;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des hopitaux : $error');
    }
  }

  Future<List<Hospital>> searchHospitals(String searchText) async {
    try {
      final url = Uri.parse("$resourcesUri/hospitals-search");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'searchText': searchText,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> hospitalsData = responseData['hospitals'] ?? [];

        final List<Hospital> hospitals =
            hospitalsData.map((data) => Hospital.fromJson(data)).toList();

        return hospitals;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des hopitaux : $error');
    }
  }

  Future<List<Hospital>> localizeHospitals(String lat, String lng) async {
    try {
      final url =
          Uri.parse("$resourcesUri/hospitals-localize?lat=$lat&lng=$lng");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> hospitalsData = responseData['hospitals'] ?? [];

        final List<Hospital> hospitals =
            hospitalsData.map((data) => Hospital.fromJson(data)).toList();

        return hospitals;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(
        'Erreur lors de la récupération des hopitaux selon la position : $e',
      );
    }
  }

  Future<List<Doctor>> getDoctors() async {
    try {
      final url = Uri.parse("$resourcesUri/doctors");

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

        final List<dynamic> doctorsData = responseData['doctors'] ?? [];

        final List<Doctor> doctors = doctorsData.map((data) {
          return Doctor.fromJson(data);
        }).toList();

        return doctors;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des docteurs : $error');
    }
  }

  Future<List<Doctor>> searchDoctors(String searchText) async {
    try {
      final url = Uri.parse("$resourcesUri/doctors-search");

      final token = await _auth.currentUser?.getIdToken();

      if (token == null) {
        throw Exception('Token non disponible');
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(
          {
            'searchText': searchText,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> doctorsData = responseData['doctors'] ?? [];

        final List<Doctor> doctors =
            doctorsData.map((data) => Doctor.fromJson(data)).toList();

        return doctors;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des articles : $error');
    }
  }

  Future<List<Doctor>> localizeDoctors(String lat, String lng) async {
    try {
      final url = Uri.parse("$resourcesUri/doctors-localize?lat=$lat&lng=$lng");

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

        final List<dynamic> doctorsData = responseData['doctors'] ?? [];

        final List<Doctor> doctors =
            doctorsData.map((data) => Doctor.fromJson(data)).toList();

        return doctors;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(
        'Erreur lors de la récupération des docteurs selon la position : $e',
      );
    }
  }

  Future<List<Doctor>> getLastRegisteredDoctors() async {
    try {
      final url = Uri.parse("$resourcesUri/doctors-registered");

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

        final List<dynamic> doctorsData = responseData['doctors'] ?? [];

        final List<Doctor> doctors = doctorsData.map((data) {
          return Doctor.fromJson(data);
        }).toList();

        return doctors;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception(
          'Erreur lors de la récupération des derniers inscrits : $error');
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

  Future<List<Article>> getDoctorArticles(String userId) async {
    final url = Uri.parse(
      "$resourcesUri/doctors-articles?id=$userId",
    );

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final List<dynamic> articlesData = responseData['articles'] ?? [];

      final List<Article> articles =
          articlesData.map((data) => Article.fromJson(data)).toList();

      return articles;
    } else {
      return [];
    }
  }

  Future<List<Doctor>> searchDoctorsWithParameters(
    String region,
    String speciality,
    String promotion,
  ) async {
    final url = Uri.parse(
      "$resourcesUri/doctors-custom-search?region=$region&speciality=$speciality&promotion=$promotion",
    );

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

      final List<dynamic> doctorsData = responseData['doctors'] ?? [];

      final List<Doctor> doctors =
          doctorsData.map((data) => Doctor.fromJson(data)).toList();

      return doctors;
    } else {
      return [];
    }
  }

  Future<List<String>> getRegionsForSpecificDistrict(String district) async {
    try {
      return defaultDistricts[district] ?? [];
    } catch (e) {
      throw Exception('Erreur lors de la récupération des regions : $e');
    }
  }

  Future<List<String>> getSpecialities() async {
    final url = Uri.parse(
      "$resourcesUri/specialities",
    );

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<String> specialitiesData =
          responseData['specialities'].cast<String>();

      return specialitiesData;
    } else {
      return [];
    }
  }

  Future<List<String>> getDistricts() async {
    final url = Uri.parse(
      "$resourcesUri/districts",
    );

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final List<String> districtsData =
          responseData['districts'].cast<String>();

      return districtsData;
    } else {
      return [];
    }
  }

  Future<List<String>> getRegionsForSelectedDistrict(String district) async {
    final url = Uri.parse(
      "$resourcesUri/regions-search?districtName=$district",
    );

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final List<String> regionsData = responseData['regions'].cast<String>();

      return regionsData;
    } else {
      return [];
    }
  }

  Future<List<String>> getCitiesForSelectedRegion(String region) async {
    final url = Uri.parse(
      "$resourcesUri/cities-search?regionName=$region",
    );

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final List<String> citiesData = responseData['cities'].cast<String>();

      return citiesData;
    } else {
      return [];
    }
  }
}
