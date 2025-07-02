import 'package:flame/components.dart';
import 'package:space_shooters/space_shooters_game.dart';

class Explosion extends SpriteAnimationComponent
    with HasGameReference<SpaceShootersGame> {
  Explosion({super.position})
      : super(
          size: Vector2.all(80),
          anchor: Anchor.center,
          removeOnFinish: true,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'explosion.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: .1, textureSize: Vector2.all(32), loop: false),
    );
  }
}
