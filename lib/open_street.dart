/// Flutter package imports
import 'package:flutter/material.dart';
import 'package:sync_fusion_map_demo/util/sample_view.dart';

///Map import
// ignore: import_of_legacy_library_into_null_safe
import 'package:syncfusion_flutter_maps/maps.dart';

///Local import
// import '../../../../model/sample_view.dart';

/// Renders the map widget with OSM map.
class OpenStreet extends SampleView {
  /// Creates the map widget with OSM map.
  const OpenStreet(Key key) : super(key: key);

  @override
  _TileLayerSampleState createState() => _TileLayerSampleState();
}

class _TileLayerSampleState extends SampleViewState {
  late PageController _pageViewController;
  late MapTileLayerController _mapController;

  late MapZoomPanBehavior _zoomPanBehavior;

  late List<_WonderDetails> _worldWonders = [];
  late List<_RouteDetails> _lineList = [];

  late int _currentSelectedIndex;
  late int _previousSelectedIndex;
  late int _tappedMarkerIndex;

  late double _cardHeight;

  late bool _canUpdateFocalLatLng;
  late bool _canUpdateZoomLevel;
  late bool _isDesktop;

  @override
  void initState() {
    super.initState();
    _currentSelectedIndex = 3;
    _canUpdateFocalLatLng = true;
    _canUpdateZoomLevel = true;
    _mapController = MapTileLayerController();
    _worldWonders = <_WonderDetails>[];

    _worldWonders.add(_WonderDetails(
      place: 'Vadodara',
      latitude: 22.2973142,
      longitude: 73.1942567,
    ));

    _worldWonders.add(_WonderDetails(
      place: 'Ahmedabad',
      latitude: 23.0216238,
      longitude: 72.5797068,
    ));

    _worldWonders.add(_WonderDetails(
      place: 'Rajkot',
      latitude: 22.3051991,
      longitude: 70.8028335,
    ));

    _worldWonders.add(_WonderDetails(
      place: 'Jaipur',
      latitude: 26.9154576,
      longitude: 75.8189817,
    ));

    _lineList.add(
      _RouteDetails(
        MapLatLng(_worldWonders[0].latitude, _worldWonders[0].longitude),
        MapLatLng(_worldWonders[1].latitude, _worldWonders[1].longitude),
      ),
    );
    _lineList.add(
      _RouteDetails(
        MapLatLng(_worldWonders[1].latitude, _worldWonders[1].longitude),
        MapLatLng(_worldWonders[2].latitude, _worldWonders[2].longitude),
      ),
    );
    _lineList.add(
      _RouteDetails(
        MapLatLng(_worldWonders[2].latitude, _worldWonders[2].longitude),
        MapLatLng(_worldWonders[3].latitude, _worldWonders[3].longitude),
      ),
    );

    _zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 3,
      zoomLevel: 12,
      maxZoomLevel: 50,
      focalLatLng: MapLatLng(
        _worldWonders[2].latitude,
        _worldWonders[2].longitude,
      ),
      enableDoubleTapZooming: true,
    );
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _mapController.dispose();
    _worldWonders.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    _isDesktop = model.isWebFullView ||
        themeData.platform == TargetPlatform.macOS ||
        themeData.platform == TargetPlatform.windows ||
        themeData.platform == TargetPlatform.linux;
    if (_canUpdateZoomLevel) {
      _zoomPanBehavior.zoomLevel = _isDesktop ? 5 : 4;
      _canUpdateZoomLevel = false;
    }
    _cardHeight = (MediaQuery.of(context).orientation == Orientation.landscape)
        ? (_isDesktop ? 120 : 90)
        : 110;
    _pageViewController = PageController(
        initialPage: _currentSelectedIndex,
        viewportFraction:
            (MediaQuery.of(context).orientation == Orientation.landscape)
                ? (_isDesktop ? 0.5 : 0.7)
                : 0.8);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Open Street map + Polyline',
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/maps_grid.png',
              repeat: ImageRepeat.repeat,
            ),
          ),
          SfMaps(
            layers: [
              MapTileLayer(
                /// URL to request the tiles from the providers.
                ///
                /// The [urlTemplate] accepts the URL in WMTS format i.e. {z} —
                /// zoom level, {x} and {y} — tile coordinates.
                ///
                /// We will replace the {z}, {x}, {y} internally based on the
                /// current center point and the zoom level.
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                zoomPanBehavior: _zoomPanBehavior,
                controller: _mapController,
                initialMarkersCount: _worldWonders.length,
                tooltipSettings: MapTooltipSettings(
                  color: Colors.transparent,
                ),

                sublayers: [
                  MapLineLayer(
                    lines: List<MapLine>.generate(
                      _lineList.length,
                      (int index) {
                        return MapLine(
                          from: _lineList[index].from,
                          to: _lineList[index].to,
                          dashArray: [
                            8,
                            2,
                          ],
                          color: Colors.red,
                          width: 2.0,
                        );
                      },
                    ).toSet(),
                    // animation: _animation,
                    // tooltipBuilder: _tooltipBuilder,
                  )
                ],

                markerBuilder: (BuildContext context, int index) {
                  return MapMarker(
                    latitude: _worldWonders[index].latitude,
                    longitude: _worldWonders[index].longitude,
                    size: Size(30, 30),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WonderDetails {
  const _WonderDetails({
    required this.place,
    // required this.imagePath,
    required this.latitude,
    required this.longitude,
    // String? tooltipImagePath = 'asd',
  });

  final String place;
  final double latitude;
  final double longitude;
  // final String imagePath;
  // final String tooltipImagePath;
}

class _RouteDetails {
  _RouteDetails(
    this.from,
    this.to,
  );

  MapLatLng from;
  MapLatLng to;
}
