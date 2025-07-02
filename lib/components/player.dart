import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:space_shooters/components/bullet.dart';
import 'package:space_shooters/space_shooters_game.dart';

class Player extends SpriteAnimationComponent with HasGameReference<SpaceShootersGame>{

  late final SpawnComponent _bulletSpawn;

  Player() : super(
    size: Vector2(100, 150),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation('player.png',
    SpriteAnimationData.sequenced(amount: 4, stepTime: .2, textureSize: Vector2(32, 48)));
    position = game.size / 2;

    _bulletSpawn  = SpawnComponent(period: .2,
    selfPositioning: true,
    factory: (index) {
      return Bullet(position: position + Vector2(0, -height / 2));
    }, autoStart: false);

    game.add(_bulletSpawn);
  }

  void moveTo(Vector2 delta) {
    position.add(delta);
  }

  void startShooting() {
    _bulletSpawn.timer.start();
  }

  void stopShooting() {
    _bulletSpawn.timer.stop();
  }

}