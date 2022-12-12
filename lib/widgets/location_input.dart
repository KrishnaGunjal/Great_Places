import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  var _isLocationLoaded = false;
  LocationData? locData = null;

  Future<void> _getCurrentLocation() async {
    locData = await Location().getLocation();
    if (locData!.latitude == null || locData!.longitude == null) {
      _isLocationLoaded = false;
      return;
    } else {
      setState(() {
        _isLocationLoaded = true;
      });
      Provider.of<GreatPlaces>(context, listen: false).getLocation(locData!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: !_isLocationLoaded
              ? Text(
                  'No location choosen',
                  textAlign: TextAlign.center,
                )
              : Text(
                  'Lat: ${locData!.latitude.toString()} Long: ${locData!.longitude.toString()}'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: Icon(Icons.local_attraction_rounded),
                label: Text('Get current location')),
          ],
        )
      ],
    );
  }
}
