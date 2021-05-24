import 'package:flutter/material.dart';
import 'package:sync_fusion_map_demo/marker.dart';
import 'package:sync_fusion_map_demo/open_street.dart';
import 'package:sync_fusion_map_demo/polyline.dart';
import 'package:sync_fusion_map_demo/selected.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text('Selected'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectedMap()),
                );
              },
            ),
            MaterialButton(
              child: Text('Marker'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarkerMap()),
                );
              },
            ),
            MaterialButton(
              child: Text('Open Street Marker + Polyline'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OpenStreet(Key('open'))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
