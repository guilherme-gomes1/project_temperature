import 'package:project_temperature/src/models/data_model.dart';

abstract class DataRepository {
  Future<DataModel> getData(String city);
}