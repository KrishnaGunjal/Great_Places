import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../models/locationDetails.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  List<LocationDetails> _locationItems = [];

  List<LocationDetails> get locationItems {
    return [..._locationItems];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
  }

  void getLocation(LocationData loc) {
    if (loc.latitude == null || loc.longitude == null) {
      return;
    }

    final newLocation =
        LocationDetails(latitude: loc.latitude!, longitude: loc.longitude!);
    _locationItems.add(newLocation);
    notifyListeners();
  }
}
