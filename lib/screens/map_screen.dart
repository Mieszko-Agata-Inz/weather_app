import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          OSMFlutter(
            controller: mapController,
            osmOption: OSMOption(
              userTrackingOption: UserTrackingOption(
                enableTracking: true,
                unFollowUser: false,
              ),
              zoomOption: const ZoomOption(
                initZoom: 8,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
              userLocationMarker: UserLocationMaker(
                personMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.location_history_rounded,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
                directionArrowMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.double_arrow,
                    size: 48,
                  ),
                ),
              ),
              roadConfiguration: const RoadOption(
                roadColor: Colors.yellowAccent,
              ),
              markerOption: MarkerOption(
                  defaultMarker: const MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              )),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment(-0.4, 0.4),
                  radius: 0.6,
                  focalRadius: 0.2,
                  stops: [
                    0.05,
                    0.15,
                    0.4,
                    0.7
                  ],
                  colors: [
                    Color.fromARGB(255, 0, 132, 255),
                    Color.fromARGB(190, 0, 132, 255),
                    Color.fromARGB(92, 0, 132, 255),
                    Color.fromARGB(0, 0, 132, 255),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  MapController mapController = MapController(
    initMapWithUserPosition:
        const UserTrackingOption.withoutUserPosition(enableTracking: false),
    areaLimit: const BoundingBox.world(),
  );
}
