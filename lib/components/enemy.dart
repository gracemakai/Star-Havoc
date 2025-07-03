import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shooters/space_shooters_game.dart';

import 'bullet.dart';
import 'explosion.dart';

class Enemy extends SpriteComponent with HasGameReference<SpaceShootersGame>, CollisionCallbacks{

  Enemy({super.position}) : super(
    size: Vector2.all(enemySize),
    anchor: Anchor.center,
  );

  static const enemySize = 100.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite(
      'enemy.png'
    );

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }


  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Bullet) {
      other.removeFromParent();
      removeFromParent();
      game.add(Explosion(position: position));
      game.currentScore += 1;
    }
  }

}