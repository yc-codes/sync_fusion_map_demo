import 'package:flutter/material.dart';
import 'package:sync_fusion_map_demo/home.dart';
import 'package:sync_fusion_map_demo/marker.dart';
import 'package:sync_fusion_map_demo/open_street.dart';
import 'package:sync_fusion_map_demo/selected.dart';

void main() {
  return runApp(MapsApp());
}

/// This widget will be the root of application.
class MapsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps Demo',
      home: Home(),
    );
  }
}
