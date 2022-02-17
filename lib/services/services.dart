import 'package:flutter/material.dart';

import '../model/picsum_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'app_exceptions.dart';

class Services {
  Future<List<PicSumModel>> fetchPicturesAPI() async {
    String url = 'https://picsum.photos/v2/list';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final listResult = json.map((e) => PicSumModel.fromJson(e)).toList();
      return listResult;
    } else {
      throw Exception('Error fetching Picture');
    }
    //with exceptions
    // return returnResponse(response);
  }

  @visibleForTesting
  dynamic returnResponse(response) {
    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.body) as List;
        final listResult = json.map((e) => PicSumModel.fromJson(e)).toList();
        return listResult;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
