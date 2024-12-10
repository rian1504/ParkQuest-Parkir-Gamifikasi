import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Models/ParkRecommendation/ParkArea.dart';

class ParkArea extends StatelessWidget {
  ParkArea({
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
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/formRekomendasiParkir',
                  arguments: data.id,
                );
              },
              child: Text(data.parkName),
            ),
            Text(data.id.toString()),
            Text(data.parkName),
            Text(data.parkCoordinate),
            Text(data.parkCapacity.toString()),
          ],
        ),
      ),
    );
  }
}
