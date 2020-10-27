import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(UsandoMaps());

class UsandoMaps extends StatefulWidget {
  @override
  _UsandoMapsState createState() => _UsandoMapsState();
}

class _UsandoMapsState extends State<UsandoMaps> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _tipoAtualMapa = MapType.normal;
  static const LatLng _latlong = const LatLng(-15.7801, -47.9292);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final Set<Marker> _marcas = {};

  LatLng _ultimaPosicao = _latlong;

  void _onCameraMove(CameraPosition position) {
    _ultimaPosicao = position.target;
  }

  void _adicionarMarca() {
    setState(() {
      _marcas.add(Marker(
        markerId: MarkerId(_ultimaPosicao.toString()),
        position: _ultimaPosicao,
        infoWindow: InfoWindow(
          title: 'Lugar preferido',
          snippet: 'Top',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _alterarTipoMapa() {
    setState(() {
      _tipoAtualMapa =
          _tipoAtualMapa == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Usando Maps'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              onCameraMove: _onCameraMove,
              markers: _marcas,
              mapType: _tipoAtualMapa,
              initialCameraPosition: CameraPosition(
                target: _latlong,
                zoom: 11.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        _alterarTipoMapa();
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _adicionarMarca,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
