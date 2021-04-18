import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_location_map/models/place.dart';
import 'package:flutter_location_map/models/place_search.dart';
import 'package:flutter_location_map/services/geo_locator_service.dart';
import 'package:flutter_location_map/services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();

  Position currentLocation;
  List<PlaceSearch> searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  Place selectedLocationStatic;
  String placeType;
  List<Place> placeResults;
  List<Marker> markers = List<Marker>();

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);

    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    selectedLocation.close();
    super.dispose();
  }
}
