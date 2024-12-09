import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkSearch/ParkArea.dart';

class ParkArea extends StatelessWidget {
  const ParkArea({
    super.key,
    required this.data,
  });

  final ParkAreaModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            Text(data.parkName),
            Text(data.parkCoordinate),
            Text(data.parkCapacity.toString()),
          ],
        ),
      ),
    );
  }
}
