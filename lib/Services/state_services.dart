import 'dart:convert';

import 'package:covid19_tracker_app/Model/world_state_model.dart';
import 'package:covid19_tracker_app/Utilities/app_url.dart';
import 'package:covid19_tracker_app/view/world_state.dart';
import 'package:http/http.dart' as http;




class StateServices {
    Future<WorldStateModel> fetchWorldStateRecord () async {
      final response = await http.get(Uri.parse(AppUrl.worldStateApi));


      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return WorldStateModel.fromJson(data);
      }

      else {

        throw Exception('error');
      }

    }

    Future<List<dynamic>> fetchCountriesList () async {
      var data;
      final response = await http.get(Uri.parse(AppUrl.countriesList));

      if(response.statusCode == 200) {
         data = jsonDecode(response.body);
        return data;
      }

      else {

        throw Exception('error');
      }

    }
}