import 'dart:convert';
import 'dart:io';

import 'package:basketball/model/basket.model.dart';
import 'package:basketball/ui/gameui.model.dart';
import 'package:http/http.dart' as http;

class BasketService {
  Future<List<GameUI>> loadGames() async {
    var _uri = Uri.https('www.mocky.io', 'v2/5de8d38a3100000f006b1479');
    var response = await http.Client().get(_uri);
    List<GameUI> games = List.empty(growable: true);
    if (response.statusCode == HttpStatus.ok) {
      var listGame = BasketBall.fromJson(jsonDecode(response.body));
      listGame.data?.forEach((element) {
        games.add(
          GameUI(
            homeTeam: element.homeTeam!.fullName!,
            visitorTeam: element.visitorTeam!.fullName!,
            score: '${element.homeTeamScore} - ${element.visitorTeamScore}',
          ),
        );
      });
    }
    return games;
  }
}
