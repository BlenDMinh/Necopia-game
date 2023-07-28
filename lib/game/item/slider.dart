import 'package:flame/components.dart';

class SliderComponent extends SpriteComponent {
  SliderComponent._();
  static create() async {
    final sliderSprite = await Sprite.load('item/slider.png');
    SliderComponent slider = SliderComponent._();
    slider.sprite = sliderSprite;
    slider.size /= 2.5;
    return slider;
  }
}
