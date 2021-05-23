import 'package:flutter/material.dart';
import 'package:flutter_learn_app/model/playerList.dart';
import 'package:flutter_learn_app/main.dart';

class PlayerCard extends StatelessWidget {
  final PlayerList playerList;

  PlayerCard({this.playerList});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              child:
                  Text(playerList.playerName + " => " + playerList.playerTeam),
              onTap: () {
               },
            ),
          ],
        ),
      ),
    );
  }
}
