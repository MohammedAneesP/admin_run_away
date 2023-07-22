class Product {
  final String itemName;
  final List<String> productImages;
  final List<int> shoeSize;
  final String productId;
  final double price;
  final String brandId;
  final String description;

  Product({
    required this.itemName,
    required this.productImages,
    required this.shoeSize,
    required this.productId,
    required this.price,
    required this.brandId,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      itemName: json['itemName'],
      productImages: List<String>.from(json['productImages']),
      shoeSize: List<int>.from(json['shoeSize']),
      productId: json['productId'],
      price: json['price'].toDouble(),
      brandId: json['brandId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'productImages': productImages,
      'shoeSize': shoeSize,
      'productId': productId,
      'price': price,
      'brandId': brandId,
      'description': description,
    };
  }
}

