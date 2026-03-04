import '../../../../achitecture.dart';

class ItemMapper {
  Item fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }

  Map<String, dynamic> toJson(Item item) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = item.id;
    data['title'] = item.title;
    data['price'] = item.price;
    data['description'] = item.description;
    data['category'] = item.category;
    data['image'] = item.image;
    if (item.rating != null) {
      data['rating'] = item.rating!.toJson();
    }
    return data;
  }
}
