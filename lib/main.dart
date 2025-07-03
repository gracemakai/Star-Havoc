import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_shooters/overlays/main_menu.dart';
import 'package:space_shooters/space_shooters_game.dart';

import 'overlays/game_over.dart';

void main() {
  runApp(GameWidget<SpaceShootersGame>.controlled(
    gameFactory: SpaceShootersGame.new,
    overlayBuilderMap: {
      'MainMenu': (_, game) => MainMenu(game: game),
      'GameOver': (_, game) => GameOver(game: game),
    },
    initialActiveOverlays: const ['MainMenu'],
  ));
}
