

class Brand {
  final String brandName;
  final String imageName;
  final String brandId;

  Brand({
    required this.brandName,
    required this.imageName,
    required this.brandId,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      brandName: json['brandName'],
      imageName: json['imageName'],
      brandId: json['brandId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandName': brandName,
      'imageName': imageName,
      'brandId': brandId,
    };
  }
}

