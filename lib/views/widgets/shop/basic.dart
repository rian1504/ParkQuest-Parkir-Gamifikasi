import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Avatar/Avatar.dart';

class ShopBasicWidget extends StatelessWidget {
  const ShopBasicWidget({
    super.key,
    required this.data,
  });

  final AvatarModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            Text(data.rarityName),
            Text(data.avatarName),
            Text(data.avatarImage),
            Text(data.avatarDescription),
          ],
        ),
      ),
    );
  }
}
