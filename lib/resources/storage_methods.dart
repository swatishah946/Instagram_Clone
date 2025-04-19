import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class StorageMethods {
  Future<String> uploadImageToCloudinary(
    String folder,
    Uint8List file,
    bool isPost,
  ) async {
    try {
      final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
      final uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';

      if (cloudName.isEmpty || uploadPreset.isEmpty) {
        throw 'Cloudinary credentials are missing';
      }

      final uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset
        ..fields['folder'] = isPost ? 'posts' : folder;

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          file,
          filename: 'upload.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final url = RegExp(r'"secure_url":"(.*?)"').firstMatch(resBody)?.group(1);
        return url ?? '';
      } else {
        print("Cloudinary Upload Failed: $resBody");
        throw "Upload failed";
      }
    } catch (e) {
      print("Cloudinary upload error: $e");
      return '';
    }
  }
}
