import 'dart:developer';

import '../model/picsum_model.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class Services{
  Future<List<PicSumModel>> fetchPicturesAPI()async{
    String url='https://picsum.photos/v2/list';
    final resposne =await http.get(Uri.parse(url));

    if(resposne.statusCode==200){
      final json= jsonDecode(resposne.body)as List;
      final listResult= json.map((e) => PicSumModel.fromJson(e)).toList();
      return listResult;
    }
   else {
      throw Exception('Error fetching Picture');
    }
  }
}