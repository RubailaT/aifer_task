// ignore_for_file: deprecated_member_use

// import 'dart:io';

import 'package:aifer_task/constants/color_class.dart';
import 'package:aifer_task/constants/text_style_class.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppUtils {
  ///To check internet connection
  static Future<bool> hasInternet() async {
    if (kIsWeb) {
      return true;
    } else {
      try {
        final url = Uri.parse('https://www.google.com');
        final response = await http.get(url);
        return kIsWeb ? true : response.statusCode == 200;
      } catch (e) {
        return kIsWeb
            ? true
            : false; // Request failed, so no internet connection
      }
    }
  }

  /// Navigate to a new screen/widget
  static navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  /// Show a normal snackbar with a message
  static showInSnackBarNormal(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      closeIconColor: Colors.white,
      showCloseIcon: true,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
      backgroundColor: Colors.white,
      content: Text(
        message,
        // style: TextStyleClass.primaryFont300(13, Colors.black)
        style: TextStyle(),
      ),
    ));
  }

  /// Widget to show when no data is found
  static noDataFoundWidget() {
    Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Oops!!",
            // style: TextStyleClass.primaryFont300(15, Colors.black45)
            style: TextStyle(),
          ),
          const SizedBox(height: 10.0),
          Text(
            "No data found",
            // style: TextStyleClass.primaryFont300(13, Colors.black),
            style: TextStyle(),
          ),
        ],
      ),
    );
  }

  /// Widget to show a loading spinner
  static loadingWidget(BuildContext context, double? size) {
    return SizedBox(
      height: size,
      child: const Center(child: CupertinoActivityIndicator(radius: 10.0)),
    );
  }

  static Widget buttonsRow({
    required previousOnTap,
    required nextOnTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: previousOnTap,
          child: Container(
            width: 166,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.cyan,
            ),
            child: Center(
              child: Text(
                'PREVIOUS',
                style: TextStyleClass.primaryFont400(14, ColorClass.white),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: nextOnTap,
          child: Container(
            width: 166,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.cyan,
            ),
            child: Center(
              child: Text(
                'NEXT',
                style: TextStyleClass.primaryFont400(14, ColorClass.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
