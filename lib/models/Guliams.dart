enum ProductCategory {
  coffee,
  matcha,
  coldDrinks,
  smoothies,
  tea,
  macarons,
  bakery,
}

extension ProductCategoryExtension on ProductCategory {
  String get title {
    switch (this) {
      case ProductCategory.coffee:
        return 'Кава';

      case ProductCategory.matcha:
        return 'Матча';

      case ProductCategory.coldDrinks:
        return 'Холодні напої';

      case ProductCategory.smoothies:
        return 'Смузі';

      case ProductCategory.tea:
        return 'Чай';

      case ProductCategory.macarons:
        return 'Макаруни';

      case ProductCategory.bakery:
        return 'Випічка';
    }
  }
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    this.volume,
    this.isPopular = false,
    this.isNew = false,
    this.isAvailable = true,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final ProductCategory category;

  final String? volume;

  final bool isPopular;
  final bool isNew;
  final bool isAvailable;

  String get formattedPrice {
    if (price == price.roundToDouble()) {
      return '${price.toInt()} ₴';
    }

    return '${price.toStringAsFixed(2)} ₴';
  }

  String get searchText {
    return '''
    $name
    $description
    ${category.title}
    ${volume ?? ''}
    '''
        .toLowerCase();
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imagePath,
    ProductCategory? category,
    String? volume,
    bool? isPopular,
    bool? isNew,
    bool? isAvailable,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      volume: volume ?? this.volume,
      isPopular: isPopular ?? this.isPopular,
      isNew: isNew ?? this.isNew,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Product &&
            runtimeType == other.runtimeType &&
            id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}