import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuncare_mobile_firebase/db/ad_hive.dart';
import 'package:nuncare_mobile_firebase/db/article_hive.dart';
import 'package:nuncare_mobile_firebase/db/medecine_hive.dart';

class HiveService {
  final String _articleBoxName = "articleBox";
  final String _adBoxName = "adBox";
  final String _medecineBoxName = "medecineBox";

  Future<Box<ArticleHive>> get _boxArticle async =>
      await Hive.openBox<ArticleHive>(_articleBoxName);

  Future<void> addArticles(List<ArticleHive> articles) async {
    var box = await _boxArticle;
    // await box.clear();
    await box.addAll(articles);
  }

  Future<List<ArticleHive>> getArticles() async {
    var box = await _boxArticle;
    return box.values.toList();
  }

  Future<void> updateArticles(List<ArticleHive> articles) async {
    var box = await _boxArticle;
    await box.clear();
    await box.addAll(articles);
  }

  ////
  Future<Box<MedecineHive>> get _boxMedecine async =>
      await Hive.openBox<MedecineHive>(_medecineBoxName);

  Future<void> addMedecines(List<MedecineHive> medecines) async {
    var box = await _boxMedecine;
    // await box.clear();
    await box.addAll(medecines);
  }

  Future<List<MedecineHive>> getMedecines() async {
    var box = await _boxMedecine;
    return box.values.toList();
  }

  Future<void> updateMedecines(List<MedecineHive> medecines) async {
    var box = await _boxMedecine;
    await box.clear();
    await box.addAll(medecines);
  }

/////
  Future<Box<Ad>> get _boxAd async => await Hive.openBox<Ad>(_adBoxName);

  Future<void> addAds(List<Ad> ads) async {
    var box = await _boxAd;
    // await box.clear();
    await box.addAll(ads);
  }

  Future<List<Ad>> getAds() async {
    var box = await _boxAd;
    return box.values.toList();
  }

  Future<void> updateAds(List<Ad> ads) async {
    var box = await _boxAd;
    await box.clear();
    await box.addAll(ads);
  }
}
