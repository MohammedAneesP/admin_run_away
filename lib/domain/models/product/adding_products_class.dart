class Product {
  final String itemName;
  final List<dynamic> productImages;
  final Map<dynamic,dynamic> stockAndSize;
  final String productId;
  final String price;
  final String brandId;
  final String description;

  Product({
    required this.itemName,
    required this.productImages,
    required this.stockAndSize,
    required this.productId,
    required this.price,
    required this.brandId,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      itemName: json['itemName'],
      productImages: List<dynamic>.from(json['productImages']),
      stockAndSize: Map<dynamic,dynamic>.from(json['stockAndSize']),
      productId: json['productId'],
      price: json['price'],
      brandId: json['brandId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'productImages': productImages,
      'stockAndSize': stockAndSize,
      'productId': productId,
      'price': price,
      'brandId': brandId,
      'description': description,
    };
  }
}