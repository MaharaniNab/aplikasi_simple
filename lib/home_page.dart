import 'package:aplikasi_simple/location_service.dart'; // Pastikan path-nya benar
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _latitude = '';
  String _longitude = '';
  bool _locationObtained = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    try {
      final location = await LocationService.getCurrentLocation();
      final positionParts = location.split(',');
      if (positionParts.length == 2) {
        setState(() {
          _latitude = positionParts[0].trim();
          _longitude = positionParts[1].trim();
          _locationObtained = true;
        });
      } else {
        setState(() {
          _latitude = 'Failed to get latitude';
          _longitude = 'Failed to get longitude';
          _locationObtained = false;
        });
      }
    } catch (e) {
      setState(() {
        _latitude = 'Error';
        _longitude = 'Error';
        _locationObtained = false;
      });
    }
  }

  void _openMaps() async {
    if (_latitude.isNotEmpty && _longitude.isNotEmpty) {
      final url =
          'https://www.google.com/maps/@$_latitude,$_longitude,15z'; // Updated URL format
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Google Maps')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location data is not available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm8x6tzNqYXTm64-ul2Sm7qQiwj_0oF9-mQg&s",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            DView.textTitle('Your Location', color: Colors.black),
            DView.height(),
            if (!_locationObtained)
              const Text(
                'Getting location...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              )
            else
              Column(
                children: [
                  Text(
                    'Latitude: $_latitude',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  DView.height(),
                  Text(
                    'Longitude: $_longitude',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            DView.height(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _openMaps,
                child: const Text('Open in Google Maps'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
