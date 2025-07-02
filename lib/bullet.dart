import 'package:flame/components.dart';
import 'package:space_shooters/space_shooters_game.dart';

class Bullet extends SpriteAnimationComponent with HasGameReference<SpaceShootersGame>{

  Bullet({super.position}) : super(
    size: Vector2(25, 50),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {

    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'bullet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 1,
        textureSize: Vector2(20, 20),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * -400;

    if(position.y < -height) {
      removeFromParent();
    }
  }
}