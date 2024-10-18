import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shimmer/shimmer.dart';

FadeShimmer_circle(size) {
  return Container(
    margin: EdgeInsets.all(2),
    decoration: new BoxDecoration(
      color: Color(0xffE6E8EB),
      shape: BoxShape.circle,
    ),
    height: size,
    width: size,
  );
}

FadeShimmer_box(height, width, radius) {
  return Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Color(0xffE6E8EB), borderRadius: BorderRadius.circular(radius)),
    height: height,
    width: width,
  );
}

FadeShimmer_box_elite(height, width, radius) {
  return Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Color(0xFF3D3D3D), borderRadius: BorderRadius.circular(radius)),
    height: height,
    width: width,
  );
}

FadeShimmer_box_porter(height, width, radius) {
  return Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Color(0xFF959595), borderRadius: BorderRadius.circular(radius)),
    height: height,
    width: width,
  );
}

// Shimmer component for a circular image
shimmerCircle(double size) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    ),
  );
}

// Shimmer component for text
shimmerText(double width, double height) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Color(0xffE6E8EB), borderRadius: BorderRadius.circular(18)),
    ),
  );
}

// Shimmer component for linear progress bar
shimmerLinearProgress(double height) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      decoration: BoxDecoration(
          color: Color(0xffE6E8EB), borderRadius: BorderRadius.circular(18)),
    ),
  );
}



Widget Label({
  required String text,
}) {
  return Text(text,
      style: TextStyle(
          color: Color(0xff110B0F),
          fontFamily: 'RozhaOne',
          fontSize: 15,
          height: 21.3/ 15,
          fontWeight: FontWeight.w400));
}

class DateTimeFormatter {
  // Method to format both date and time based on user choice
  static String format(String isoDate,
      {bool includeDate = true, bool includeTime = false}) {
    if (isoDate.isEmpty) {
      return "";
    }

    try {
      // Remove AM/PM if present to avoid parsing issues
      String cleanedDate = isoDate.replaceAll(RegExp(r'(AM|PM)'), '').trim();

      // Parse the date
      DateTime dateTime = DateTime.parse(cleanedDate);

      // Format the date and time as needed
      String formattedDate = "";
      if (includeDate) {
        formattedDate =
            "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      }

      String formattedTime = "";
      if (includeTime) {
        formattedTime =
            "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
      }

      // Combine date and time if both are requested
      if (includeDate && includeTime) {
        return "$formattedDate $formattedTime";
      } else if (includeDate) {
        return formattedDate;
      } else if (includeTime) {
        return formattedTime;
      }
    } catch (e) {
      print("Error parsing date: $e");
      return "";
    }

    return "";
  }
}

