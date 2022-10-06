Product productFromMap(Map<String, dynamic> json) => Product.fromMap(json);
Result detailsFromMap(Map<String, dynamic> json) => Result.fromMap(json);

class Product {
  Product({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String? next;
  String? previous;
  List<Result> results;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );
}

class Result {
  Result({
    required this.id,
    required this.brand,
    required this.image,
    required this.charge,
    required this.images,
    required this.slug,
    required this.productName,
    required this.description,
    required this.maximumOrder,
    required this.stock,
    required this.isActive,
    required this.seller,
  });
  int id;
  Brand brand;
  String image;
  Charge charge;
  List<Image> images;
  String slug;
  String productName;

  String description;

  int maximumOrder;
  int stock;

  bool isActive;

  String seller;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        brand: Brand.fromMap(json["brand"]),
        image: json["image"],
        charge: Charge.fromMap(json["charge"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
        slug: json["slug"],
        productName: json["product_name"],
        description: json["description"],
        maximumOrder: json["maximum_order"],
        stock: json["stock"],
        isActive: json["is_active"],
        seller: json["seller"],
      );
}

class Brand {
  Brand({
    required this.name,
    required this.image,
    required this.slug,
  });

  String name;
  String image;

  String slug;

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
        name: json["name"],
        image: json["image"],
        slug: json["slug"],
      );
}

class Charge {
  Charge({
    required this.currentCharge,
    required this.discountCharge,
    required this.sellingPrice,
    required this.profit,
  });

  double currentCharge;
  dynamic discountCharge;
  double sellingPrice;
  double profit;

  factory Charge.fromMap(Map<String, dynamic> json) => Charge(
        currentCharge: json["current_charge"],
        discountCharge: json["discount_charge"],
        sellingPrice: json["selling_price"],
        profit: json["profit"],
      );
}

class Image {
  Image({
    required this.id,
    required this.image,
    required this.isPrimary,
    required this.product,
  });

  int id;
  String image;
  bool isPrimary;
  int product;

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
        isPrimary: json["is_primary"],
        product: json["product"],
      );
}
