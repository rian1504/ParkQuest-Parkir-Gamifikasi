import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Models/User.dart';

class UbahProfileWidget extends StatelessWidget {
  UbahProfileWidget({
    super.key,
    required this.data,
  });

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            Text(data.name),
            Text(data.username),
            Text(data.username),
            Text(data.username),
            // Text(data.agencyCompany),
            // Text(data.position),
          ],
        ),
      ),
    );
  }
}
