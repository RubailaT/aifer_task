import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'app_utils.dart';

class GetServiceUtils {
  static Future<String> fetchData(String getUrl, BuildContext context) async {
    try {
      final hasNetwork = await AppUtils.hasInternet();
      if (!hasNetwork) {
        if (context.mounted) {
          AppUtils.showInSnackBarNormal('No internet connection', context);
        }
        throw Exception('No internet connection');
      } else {
        debugPrint('Has Internet');
        final url = Uri.parse(getUrl);
        final headers = {
          "Content-Type": "application/json",
        };
        final response = await http.get(url, headers: headers);
        if (response.statusCode == 200) {
          if (kDebugMode) {
            log('$url: ${response.body}');
          }
          return response.body;
        } else if (response.statusCode == 500) {
          if (context.mounted) {
            AppUtils.showInSnackBarNormal(
                'status code: ${response.statusCode}, - Bad Gateway', context);
          }
          debugPrint('$url status code: ${response.statusCode}');
          throw Exception('Failed to get Data');
        } else if (response.statusCode == 401) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          debugPrint('$url status code: ${response.statusCode}');
          throw Exception('Failed to get Data');
        } else {
          if (context.mounted) {
            debugPrint('$url status code: ${response.statusCode}');
            AppUtils.showInSnackBarNormal('Something went wrong.', context);
          }
          debugPrint('$url status code: ${response.statusCode}');
          throw Exception('Failed to get Data');
        }
      }
    } catch (e) {
      // Show the exception message in a snack bar
      // Rethrow the exception so the calling code can handle it if necessary
      rethrow;
    }
  }
}
