import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkData.dart';

class ParkData extends StatelessWidget {
  ParkData({
    super.key,
    required this.data,
  });

  final ParkDataModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            Text(data.startHour.toString()),
            Text(data.endHour.toString()),
            Text(data.available.toString()),
          ],
        ),
      ),
    );
  }
}
