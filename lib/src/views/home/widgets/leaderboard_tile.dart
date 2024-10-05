import 'package:flutter/material.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class LeaderboardTile extends StatelessWidget {
  final String user;
  final int rank;
  final int points;

  const LeaderboardTile({
    super.key,
    required this.user,
    required this.rank,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50.0,
            child: Text(
              "${rank.toString()}th",
              style: const TextStyle(
                color: primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            user.capitalizeFirst ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            width: 75.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/icons/coin.png",
                  height: 20.0,
                  width: 20.0,
                ),
                const SizedBox(width: 5.0),
                Text(
                  points.toString(),
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
