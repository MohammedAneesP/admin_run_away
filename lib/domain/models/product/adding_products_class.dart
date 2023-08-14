class Product {
  final String itemName;
  final List<dynamic> productImages;
  final List<dynamic> shoeSize;
  final String productId;
  final String stock;
  final String price;
  final String brandId;
  final String description;

  Product({
    required this.itemName,
    required this.productImages,
    required this.shoeSize,
    required this.productId,
    required this.stock,
    required this.price,
    required this.brandId,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      itemName: json['itemName'],
      productImages: List<dynamic>.from(json['productImages']),
      shoeSize: List<dynamic>.from(json['shoeSize']),
      productId: json['productId'],
      stock: json['stock'],
      price: json['price'],
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
      'stock':stock,
      'price': price,
      'brandId': brandId,
      'description': description,
    };
  }
}