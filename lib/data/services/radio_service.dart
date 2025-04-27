import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:radio_stations_app/core/constants.dart';
import 'package:radio_stations_app/data/models/radio_station.dart';

import '../../core/utils/radio_service_exception.dart';

class RadioService {
  Future<List<RadioStation>> fetchStations() async {
    try {
      final uri = Uri.parse(Constants.radioApiUrl);
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => RadioStation.fromJson(json)).toList();
      } else {
        throw RadioServiceException('Failed with status code ${response.statusCode}');
      }
    } on SocketException {
      throw RadioServiceException('No Internet Connection');
    } on TimeoutException {
      throw RadioServiceException('Request Timed Out');
    } catch (_) {
      throw RadioServiceException('Something went wrong');
    }
  }
}