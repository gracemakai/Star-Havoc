import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:space_shooters/space_shooters_game.dart';

import 'highscore_manager.dart';

class Hud extends PositionComponent with HasGameReference<SpaceShootersGame> {

  late TextComponent _scoreTextComponent;

  @override
  Future<void> onLoad() async {
    final textRenderer = TextPaint(
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 16,
      ),
    );

    _scoreTextComponent = TextComponent(
      text: 'Current score: ${game.currentScore}',
      position: Vector2(10, 10),
      textRenderer: textRenderer,
    );

    var topScore = await HighScoreManager.getHighScore();

    addAll([
      _scoreTextComponent,
      TextComponent(
        text: 'Top score: $topScore',
        position: Vector2(10, 40),
        textRenderer: textRenderer,
      )
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _scoreTextComponent.text = 'Current score: ${game.currentScore}';
    super.update(dt);
  }
}
