import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:amplify_flutter/amplify_flutter.dart';

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
    // final options = RestOptions(
    //   apiName: 'apicbb410f6',
    //   path: path,
    //   body: Uint8List.fromList(utf8.encode(jsonEncode(data)))
    // );

    // final operation = Amplify.API.post(
    //     restOptions: options
    // );
    // final response = await operation.response;
    //   print('='*100);
    //   print(response.body);
    // if (response.statusCode == 200) {
    //   print('*******************************************===');
    //   print(response.body);
    //   return response.body;
    // }
    // print('*******************************************===');
    // print(response.body);
    // return null;
    try {
      final response = await http.post(Uri.parse(baseUrl + path),
          body: jsonEncode({...?data}), headers: header);

      return jsonDecode(response.body);
    } catch (e) {
      return jsonDecode(
          {'status': 'error', 'message': e.toString()}.toString());
    }
  }
}
