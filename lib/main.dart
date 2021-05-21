import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sync_fusion_map_demo/countries.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:syncfusion_flutter_core/theme.dart';

void main() {
  return runApp(MapsApp());
}

/// This widget will be the root of application.
class MapsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Maps Demo',
      home: MyHomePage(),
    );
  }
}

/// This widget is the home page of the application.
class MyHomePage extends StatefulWidget {
  /// Initialize the instance of the [MyHomePage] class.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  late List<String> _data;
  late MapShapeSource _mapSource;
  late int selectedIndex;
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _data = countries;

    _mapSource = MapShapeSource.asset(
      'assets/countries.json',
      shapeDataField: 'ADMIN',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index],
      // dataLabelMapper: (int index) => _data[index].stateCode,
      // shapeColorValueMapper: (int index) => _data[index].color,
    );
    _zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 0,
      enableDoubleTapZooming: true,
      maxZoomLevel: 50,
    );

    selectedIndex = countries.indexWhere((county) => county == 'India');
    print(selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 520,
        child: Center(
          child: SfMapsTheme(
            data: SfMapsThemeData(
              layerColor: Color(0xFFE5E5E5),
              shapeHoverColor: Color(0xFFC7C7C7),
              selectionColor: Color(0xFF5F90F7),
              selectionStrokeColor: Colors.white,
            ),
            child: SfMaps(
              layers: <MapShapeLayer>[
                MapShapeLayer(
                  source: _mapSource,
                  showDataLabels: false,
                  // legend: MapLegend(MapElement.shape),
                  // tooltipSettings: MapTooltipSettings(
                  //   color: Colors.grey[700],
                  //   strokeColor: Colors.white,
                  //   strokeWidth: 2,
                  // ),
                  strokeColor: Colors.white,

                  strokeWidth: 0.5,
                  zoomPanBehavior: _zoomPanBehavior,
                  loadingBuilder: (BuildContext context) {
                    return CircularProgressIndicator(
                      strokeWidth: 3,
                    );
                  },
                  // shapeTooltipBuilder: (BuildContext context, int index) {
                  //   return Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text(
                  //       _data[index].stateCode,
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   );
                  // },
                  selectedIndex: selectedIndex,
                  onSelectionChanged: (int index) {
                    print('index:: ' + index.toString());
                    setState(() {
                      selectedIndex = index;
                    });
                  },

                  // selectionSettings: MapSelectionSettings(
                  //   color: Color(0xFF5F90F7),
                  //   strokeColor: Colors.white,
                  // ),

                  // dataLabelSettings: MapDataLabelSettings(
                  //   textStyle: TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: Theme.of(context).textTheme.caption!.fontSize,
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Collection of Australia state code data.
class Model {
  /// Initialize the instance of the [Model] class.
  const Model(this.country, this.color, this.stateCode);

  /// Represents the Australia state name.
  final String country;

  /// Represents the Australia state color.
  final Color color;

  /// Represents the Australia state code.
  final String stateCode;
}
