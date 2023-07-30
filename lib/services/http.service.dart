import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:http/http.dart' as http;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HttpService {
  String dreamboothApiKey =
      "QRPI1z4lwCgPsWKbReXxfc1DDYey5CKPWMcCWeYYd8rAlzwSsNEUiMNzxdSe";

  String baseUrl = "https://cloud.leonardo.ai/api/rest/v1/";
  final Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer 51632624-42a8-46c8-8f81-84af4d904e28'
  };
  String dreamboothTraining = "https://stablediffusionapi.com/api/v3/fine_tune";
  String dreamboothGetModelStatus =
      "https://stablediffusionapi.com/api/v3/fine_tune_status/";
  String dreamboothModelReload =
      "https://stablediffusionapi.com/api/v4/dreambooth/model_reload";
  String dreamboothTextToImage =
      "https://stablediffusionapi.com/api/v3/dreambooth";
  String dreamboothImageToImage =
      "https://stablediffusionapi.com/api/v3/dreambooth/img2img";
  String dreamboothCheckGenerationResult =
      "https://stablediffusionapi.com/api/v3/fetch/";
  String webhook =
      "https://3d0zjl4cce.execute-api.us-east-1.amazonaws.com/dev/webhook";

  Future<dynamic> post(String path, [Map<String, dynamic>? data]) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + path),
          body: jsonEncode({...?data}), headers: header);

      return jsonDecode(response.body);
    } catch (e) {
      return jsonDecode(
          {'status': 'error', 'message': e.toString()}.toString());
    }
  }

  Future<dynamic> get(String path, [String? id]) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$path/$id"),
          headers: header);

      return jsonDecode(response.body);
    } catch (e) {
      return jsonDecode(
          {'status': 'error', 'message': e.toString()}.toString());
    }
  }

  Future<bool> postFile(String path, File file,
      [Map<String, dynamic>? data]) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(path));
      request.fields.addAll({...?data});
      request.files.add(await http.MultipartFile.fromPath('file', file.path,
          contentType: MediaType.parse(lookupMimeType(file.path)!)));

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
