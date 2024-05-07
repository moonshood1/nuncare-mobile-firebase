import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nuncare_mobile_firebase/constants/base_url.dart';

class CloudinarySevice {
  Future<String> uploadImageOnCloudinary(File image) async {
    try {
      final url = Uri.parse(cloudinaryUrl);

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'uzbfy5aa'
        ..files.add(
          await http.MultipartFile.fromPath(
            'file',
            image.path,
          ),
        );

      final response = await request.send();

      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      final imgUrl = jsonMap['url'];

      return imgUrl;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
