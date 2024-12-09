import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Leaderboard.dart';

class LeaderboardTopThree extends StatelessWidget {
  const LeaderboardTopThree({
    super.key,
    required this.data,
  });

  final LeaderboardModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            Text(data.username),
            Text(data.rank.rankName.toString()),
          ],
        ),
      ),
    );
  }
}
