import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaPage extends StatelessWidget {
  const MapaPage({super.key});

  static final _laEsperanza = LatLng(14.8632, -91.5562);

  static final _limiteNoroeste = LatLng(14.8720, -91.5710);
  static final _limiteSureste = LatLng(14.8550, -91.5400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de La Esperanza'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _laEsperanza,
          initialZoom: 14.0,
          minZoom: 13.0,
          maxZoom: 17.5,
          keepAlive: true,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.all,
          ),
          cameraConstraint: CameraConstraint.contain(
            bounds: LatLngBounds(_limiteSureste, _limiteNoroeste),
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.transito_app',
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: _laEsperanza,
                width: 45,
                height: 45,
                child: const Icon(
                  Icons.location_on,
                  size: 45,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                '© OpenStreetMap contributors',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
