import 'package:flutter/material.dart';
import 'package:project_temperature/src/models/data_model.dart';
import 'package:project_temperature/src/repositories/data_repository_imp.dart';

class HomeController {
  final DataRepositoryImp _dataRepository;
  final TextEditingController textEditingController = TextEditingController();
  String city = 'Miami';
  bool isEnable = true;

  HomeController(this._dataRepository);

  String dayWeek(int day) {
    String date;
    switch (day) {
      case 1:
        date = 'Monday';
        break;
      case 2:
        date = 'Tuesday';
        break;
      case 3:
        date = 'Wednesday';
        break;
      case 4:
        date = 'Thursday';
        break;
      case 5:
        date = 'Friday';
        break;
      case 6:
        date = 'Saturday';
        break;
      case 7:
        date = 'Sunday';
        break;
      default:
        date = 'nda';
    }
    return date;
  }

  String monther(int montherInt) {
    String monther;
    switch (montherInt) {
      case 1:
        monther = 'Jan';
        break;
      case 2:
        monther = 'Feb';
        break;
      case 3:
        monther = 'Mar';
        break;
      case 4:
        monther = 'Apr';
        break;
      case 5:
        monther = 'May';
        break;
      case 6:
        monther = 'Jun';
        break;
      case 7:
        monther = 'Jul';
        break;
      case 8:
        monther = 'Aug';
        break;
      case 9:
        monther = 'Sep';
        break;
      case 10:
        monther = 'Oct';
        break;
      case 11:
        monther = 'Nov';
        break;
      case 12:
        monther = 'Dez';
        break;
      default:
        monther = 'nda';
    }
    return monther;
  }

  String getIcon(String description){
    if(description == 'Clouds'){
      return 'assets/images/Sun weather.png';
    } else {
      return 'assets/images/Sun.png';
    }
  }

  Future<DataModel> getData(String city) async {
    await Future.delayed(const Duration(seconds: 3));
    return _dataRepository.getData(city);
  }
}
