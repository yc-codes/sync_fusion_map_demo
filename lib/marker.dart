import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sync_fusion_map_demo/countries.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MarkerMap extends StatefulWidget {
  @override
  _MarkerMapState createState() => _MarkerMapState();
}

class _MarkerMapState extends State<MarkerMap> {
  late List<String> _data;
  late MapShapeSource _mapSource;
  late int selectedIndex;
  late MapZoomPanBehavior _zoomPanBehavior;
  List<_MarkerDetails> _markers = [];

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

    _markers = <_MarkerDetails>[
      _MarkerDetails('Greece', 22.3072, 73.1812, 1),
      _MarkerDetails('Punjab', 11.3528, 77.1686, 2),
      _MarkerDetails('Jaipur', 26.9124, 75.7873, 3),
      _MarkerDetails('Mumbai', 19.0760, 72.8777, 4),
    ];

    selectedIndex = countries.indexWhere((county) => county == 'India');
    print(selectedIndex);

    _zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 15,
      enableDoubleTapZooming: true,
      maxZoomLevel: 50,
      focalLatLng: MapLatLng(
        _markers[3].latitude,
        _markers[3].longitude,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'marker map',
        ),
      ),
      body: Container(
        constraints: BoxConstraints(),
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
                initialMarkersCount: _markers.length,
                markerBuilder: (_, int index) {
                  return MapMarker(
                    longitude: _markers[index].longitude,
                    latitude: _markers[index].latitude,
                    size: const Size(50, 50),
                    child: Column(
                      children: [
                        index % 2 == 0
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF5434),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                alignment: Alignment.center,
                              )
                            : Icon(
                                Icons.location_on,
                                size: 24,
                              ),
                        Text(
                          _markers[index].number.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class _MarkerDetails {
  _MarkerDetails(this.countryName, this.latitude, this.longitude, this.number);

  final String countryName;
  final double latitude;
  final double longitude;
  final int number;
}
