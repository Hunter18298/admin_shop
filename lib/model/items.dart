import 'package:flutter/foundation.dart' show immutable;

//dyakri krdny chand taybatmandyak lo itemakan
@immutable
class Items {
  final String name;
  final String image;
  final String description;
  final int price;
  final bool? isFavourite;
  final String category;

  const Items({
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.isFavourite = false,
  });
  //loway datay la firebase y xaznkayna naw class y Items y
  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      category: json['category'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      isFavourite: json['isFavourite'],
    );
  }
  //data wak u map daxil bkre u ba pechawanawa
  Map<String, dynamic> toMap() => {
        'category': category,
        'name': name,
        'image': image,
        'description': description,
        'price': price,
        'isFavourite': isFavourite
      };
//data waku Json daxil bkre w ba pechawanawa
  Map<String, Object?> toJson() {
    return {
      'category': category,
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'isFavourite': isFavourite
    };
  }

  @override
  List<Object> get props => [name, image, description, price, category];
}
