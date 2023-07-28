import 'package:flame/components.dart';

class BookShelfComponent extends SpriteComponent {
  BookShelfComponent._();
  static create() async {
    final sprite = await Sprite.load('item/shelf.png');
    BookShelfComponent shelf = BookShelfComponent._();
    shelf.sprite = sprite;
    shelf.size *= 2;
    return shelf;
  }
}
