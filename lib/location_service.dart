import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<String> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Memeriksa apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Layanan lokasi dinonaktifkan.';
    }

    // Memeriksa status izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Izin lokasi ditolak';
      }
    }

    // Memeriksa jika izin lokasi ditolak secara permanen
    if (permission == LocationPermission.deniedForever) {
      return 'Izin lokasi ditolak secara permanen, kami tidak dapat meminta izin.';
    }

    // Mendapatkan lokasi saat ini
    final position = await Geolocator.getCurrentPosition();
    return 'Lintang: ${position.latitude}, Bujur: ${position.longitude}';
  }
}
