// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:weather_application_1/weather.dart';
import 'package:weather_application_1/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool gpsStatus = false;
  bool hasPermission = false;

  Location location = Location();
  late LocationPermission permission;

  WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    checkGps();
  }

  checkGps() async {
    gpsStatus = await Geolocator.isLocationServiceEnabled();
    if (gpsStatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint("Location permissions are permanently denied");
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }

      if (hasPermission) {
        setState(() {
          //refresh the UI
        });

        getWeather();
      }
    } else {
      bool isTurnedOn = await Geolocator.openLocationSettings();
      if (isTurnedOn) {
        setState(() {
          // refresh the UI
        });

        checkGps();
      }
    }

    setState(() {
      //refresh the UI
    });
  }

  void getWeather() async {
    await weatherService.getWeatherData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(weatherService: weatherService);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitRipple(
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
