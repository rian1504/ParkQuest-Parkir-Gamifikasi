import 'package:flutter/material.dart';
import 'package:parkquest_parkir_gamifikasi/Models/Leaderboard.dart';

class LeaderboardWidget extends StatelessWidget {
  const LeaderboardWidget({
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
