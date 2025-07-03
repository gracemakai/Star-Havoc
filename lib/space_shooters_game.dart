import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:space_shooters/components/enemy.dart';
import 'package:space_shooters/components/player.dart';
import 'package:space_shooters/hud.dart';

import 'high_score_manager.dart';

class SpaceShootersGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Player player;
  int currentScore = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('star_2.png'),
        ParallaxImageData('star_0.png'),
        ParallaxImageData('star_1.png'),
      ],
      baseVelocity: Vector2(0, -3),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );
    add(parallax);

    player = Player();

    add(player);

    add(SpawnComponent(
        period: 1,
        factory: (index) {
          return Enemy();
        },
        area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize)));

    add(Hud());
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.moveTo(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }

  Future<void> gameOver() async {
    overlays.add('GameOver');

    pauseEngine();

    final highScore = await HighScoreManager.getHighScore();
    if (currentScore > highScore) {
      await HighScoreManager.setHighScore(currentScore);
    }
  }

  void resetGame() {
    currentScore = 0;
    overlays.remove('GameOver');
    removeAll(children.whereType<Enemy>());
    resumeEngine();
  }
}
