import 'package:flutter_location_map/models/place.dart';
import 'package:flutter_location_map/models/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyD--9wH195QOSLKuBZwoPlsqJIu1Knk7pE';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var apiUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&locationbias=ipbias&types=geocode&key=$key';

    // var url = Uri.https(
    //     'maps.googleapis.com',
    //     '/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key',
    //     {'q': '{https}'});
    var response = await http.get(apiUrl);
    print(response.body);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&locationbias=ipbias&key=$key';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }
}
