import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_temperature/src/models/data_model.dart';
import 'package:project_temperature/src/repositories/data_repository.dart';


class DataRepositoryImp implements DataRepository{
  
  @override
  Future<DataModel> getData(String city) async{
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=c459bdbbb62e84ed01c32949c6f9c7e6&units=metric'));

    if(response.statusCode == 200){
      return DataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro desconhecido');
    }
  }

}