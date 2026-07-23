import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();

  ProductCategory? _selectedCategory;

  final Set<String> _favoriteProductIds = <String>{};

  final Map<String, CartItem> _cartItems = <String, CartItem>{};

  int _selectedNavigationIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filteredProducts {
    final String query = _searchController.text.trim().toLowerCase();

    return allProducts.where((Product product) {
      final bool matchesCategory = _selectedCategory == null ||
          product.category == _selectedCategory;

      final bool matchesSearch =
          query.isEmpty || product.searchText.contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Product> get _favoriteProducts {
    return allProducts.where((Product product) {
      return _favoriteProductIds.contains(product.id);
    }).toList();
  }

  int get _cartProductsCount {
    int count = 0;

    for (final CartItem item in _cartItems.values) {
      count += item.quantity;
    }

    return count;
  }

  double get _cartTotalPrice {
    double total = 0;

    for (final CartItem item in _cartItems.values) {
      total += item.totalPrice;
    }

    return total;
  }

  void _selectCategory(ProductCategory? category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _toggleFavorite(Product product) {
    setState(() {
      if (_favoriteProductIds.contains(product.id)) {
        _favoriteProductIds.remove(product.id);
      } else {
        _favoriteProductIds.add(product.id);
      }
    });
  }

  void _addProductToCart(Product product) {
    setState(() {
      final CartItem? currentItem = _cartItems[product.id];

      if (currentItem == null) {
        _cartItems[product.id] = CartItem(
          product: product,
          quantity: 1,
        );
      } else {
        _cartItems[product.id] = currentItem.copyWith(
          quantity: currentItem.quantity + 1,
        );
      }
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 900),
          behavior: SnackBarBehavior.floating,
          content: Text(
            '${product.name} додано до кошика',
          ),
          action: SnackBarAction(
            label: 'Кошик',
            onPressed: _openCart,
          ),
        ),
      );
  }

  void _increaseQuantity(Product product) {
    setState(() {
      final CartItem? currentItem = _cartItems[product.id];

      if (currentItem == null) {
        _cartItems[product.id] = CartItem(
          product: product,
          quantity: 1,
        );
        return;
      }

      _cartItems[product.id] = currentItem.copyWith(
        quantity: currentItem.quantity + 1,
      );
    });
  }

  void _decreaseQuantity(Product product) {
    setState(() {
      final CartItem? currentItem = _cartItems[product.id];

      if (currentItem == null) {
        return;
      }

      if (currentItem.quantity <= 1) {
        _cartItems.remove(product.id);
      } else {
        _cartItems[product.id] = currentItem.copyWith(
          quantity: currentItem.quantity - 1,
        );
      }
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cartItems.remove(product.id);
    });
  }

  void _clearSearch() {
    _searchController.clear();

    setState(() {});
  }

  void _changeNavigationPage(int index) {
    if (index == 2) {
      _openCart();
      return;
    }

    setState(() {
      _selectedNavigationIndex = index;
    });
  }

  void _openCart() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (
            BuildContext context,
            StateSetter setModalState,
          ) {
            void refreshCart() {
              setModalState(() {});
              setState(() {});
            }

            return _buildCartSheet(
              context,
              refreshCart,
            );
          },
        );
      },
    );
  }

  void _openProductDetails(Product product) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _buildProductDetailsSheet(product);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen =
        MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedNavigationIndex,
          children: <Widget>[
            _buildMenuPage(isWideScreen),
            _buildFavoritesPage(isWideScreen),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _cartProductsCount == 0
          ? null
          : FloatingActionButton.extended(
              onPressed: _openCart,
              backgroundColor: const Color(0xFF37251F),
              foregroundColor: Colors.white,
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text(
                '$_cartProductsCount',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
    );
  }

  Widget _buildMenuPage(bool isWideScreen) {
    final List<Product> products = _filteredProducts;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _buildHeader(),
        ),
        SliverToBoxAdapter(
          child: _buildWelcomeBanner(),
        ),
        SliverToBoxAdapter(
          child: _buildSearchField(),
        ),
        SliverToBoxAdapter(
          child: _buildCategories(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              14,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedCategory == null
                        ? 'Усе меню'
                        : _selectedCategory!.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2E211D),
                    ),
                  ),
                ),
                Text(
                  '${products.length} позицій',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8A7A73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (products.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildEmptySearchState(),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              120,
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (
                  BuildContext context,
                  int index,
                ) {
                  final Product product = products[index];

                  return _buildProductCard(product);
                },
                childCount: products.length,
              ),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWideScreen ? 4 : 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: isWideScreen ? 0.76 : 0.67,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFavoritesPage(bool isWideScreen) {
    final List<Product> products = _favoriteProducts;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              22,
              20,
              18,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE9E8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFFC95F5F),
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Обране',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2E211D),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Ваші улюблені позиції',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8A7A73),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (products.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildEmptyFavoritesState(),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              120,
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (
                  BuildContext context,
                  int index,
                ) {
                  return _buildProductCard(products[index]);
                },
                childCount: products.length,
              ),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWideScreen ? 4 : 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: isWideScreen ? 0.76 : 0.67,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        12,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF37251F),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x2537251F),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.local_cafe_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Juliam's Coffee",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2E211D),
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Кава, створена з любов’ю',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8A7A73),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              IconButton(
                onPressed: _openCart,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: const Size(48, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Color(0xFF37251F),
                ),
              ),
              if (_cartProductsCount > 0)
                Positioned(
                  right: -3,
                  top: -3,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 21,
                      minHeight: 21,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD78968),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFF8F4EF),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$_cartProductsCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        18,
      ),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF4B342C),
            Color(0xFF2D1E19),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x3537251F),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Вітаємо, Юлія 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Оберіть улюблений напій,\nа ми приготуємо його для вас.',
                  style: TextStyle(
                    color: Color(0xFFE8DCD7),
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0x22FFFFFF),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.coffee_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        14,
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) {
          setState(() {});
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Знайти напій або десерт...',
          hintStyle: const TextStyle(
            color: Color(0xFF9B8E88),
            fontSize: 15,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF6E5A52),
          ),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: _clearSearch,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF6E5A52),
                  ),
                ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFFEDE4DF),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFFD78968),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 54,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          _buildCategoryChip(
            title: 'Усі',
            icon: Icons.grid_view_rounded,
            isSelected: _selectedCategory == null,
            onTap: () {
              _selectCategory(null);
            },
          ),
          ...ProductCategory.values.map(
            (ProductCategory category) {
              return _buildCategoryChip(
                title: category.title,
                icon: _categoryIcon(category),
                isSelected: _selectedCategory == category,
                onTap: () {
                  _selectCategory(category);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Material(
        color: isSelected
            ? const Color(0xFF37251F)
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF37251F)
                    : const Color(0xFFECE3DE),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  size: 18,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF6E5A52),
                ),
                const SizedBox(width: 7),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF5E4B44),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _categoryIcon(ProductCategory category) {
    switch (category) {
      case ProductCategory.coffee:
        return Icons.coffee_rounded;

      case ProductCategory.matcha:
        return Icons.eco_rounded;

      case ProductCategory.coldDrinks:
        return Icons.local_drink_rounded;

      case ProductCategory.smoothies:
        return Icons.blender_rounded;

      case ProductCategory.tea:
        return Icons.emoji_food_beverage_rounded;

      case ProductCategory.macarons:
        return Icons.cookie_rounded;

      case ProductCategory.bakery:
        return Icons.bakery_dining_rounded;
    }
  }

  Widget _buildProductCard(Product product) {
    final bool isFavorite =
        _favoriteProductIds.contains(product.id);

    final int quantity =
        _cartItems[product.id]?.quantity ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _openProductDetails(product);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      color: const Color(0xFFF1EAE6),
                      child: Image.asset(
                        product.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return _buildImagePlaceholder(
                            product.category,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Material(
                        color: Colors.white.withValues(
                          alpha: 0.92,
                        ),
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: () {
                            _toggleFavorite(product);
                          },
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 20,
                              color: isFavorite
                                  ? const Color(0xFFC95F5F)
                                  : const Color(0xFF6E5A52),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (product.isPopular)
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD78968),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.local_fire_department_rounded,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Топ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    13,
                    11,
                    13,
                    12,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2E211D),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          product.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF8A7A73),
                            fontSize: 12,
                            height: 1.25,
                          ),
                        ),
                      ),
                      if (product.volume != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Text(
                            product.volume!,
                            style: const TextStyle(
                              color: Color(0xFF9B8E88),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              product.formattedPrice,
                              style: const TextStyle(
                                color: Color(0xFF37251F),
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          if (quantity == 0)
                            _buildAddButton(product)
                          else
                            _buildCompactQuantityControl(
                              product,
                              quantity,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(
    ProductCategory category,
  ) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFF4E9E3),
            Color(0xFFE2D1C8),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          _categoryIcon(category),
          size: 60,
          color: const Color(0xFF8D6E63),
        ),
      ),
    );
  }

  Widget _buildAddButton(Product product) {
    return Material(
      color: const Color(0xFF37251F),
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: () {
          _addProductToCart(product);
        },
        borderRadius: BorderRadius.circular(13),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 23,
          ),
        ),
      ),
    );
  }

  Widget _buildCompactQuantityControl(
    Product product,
    int quantity,
  ) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF3ECE8),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () {
              _decreaseQuantity(product);
            },
            borderRadius: BorderRadius.circular(13),
            child: const SizedBox(
              width: 32,
              height: 40,
              child: Icon(
                Icons.remove_rounded,
                size: 18,
                color: Color(0xFF37251F),
              ),
            ),
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              color: Color(0xFF37251F),
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          InkWell(
            onTap: () {
              _increaseQuantity(product);
            },
            borderRadius: BorderRadius.circular(13),
            child: const SizedBox(
              width: 32,
              height: 40,
              child: Icon(
                Icons.add_rounded,
                size: 18,
                color: Color(0xFF37251F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 50,
              color: Color(0xFFB29F97),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Нічого не знайдено',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF2E211D),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Спробуйте змінити запит або обрати іншу категорію.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF8A7A73),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: () {
              _searchController.clear();

              setState(() {
                _selectedCategory = null;
              });
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF37251F),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 14,
              ),
            ),
            child: const Text('Показати все меню'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyFavoritesState() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 108,
            height: 108,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE9E8),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              size: 54,
              color: Color(0xFFC95F5F),
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Тут поки порожньо',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF2E211D),
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          const Text(
            'Натискайте на сердечко біля товару,\nщоб додати його до обраного.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF8A7A73),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              setState(() {
                _selectedNavigationIndex = 0;
              });
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF37251F),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
            ),
            icon: const Icon(Icons.local_cafe_rounded),
            label: const Text('Перейти до меню'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      height: 74,
      selectedIndex: _selectedNavigationIndex,
      onDestinationSelected: _changeNavigationPage,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFEADDD7),
      destinations: <NavigationDestination>[
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Меню',
        ),
        const NavigationDestination(
          icon: Icon(Icons.favorite_border_rounded),
          selectedIcon: Icon(Icons.favorite_rounded),
          label: 'Обране',
        ),
        NavigationDestination(
          icon: Badge(
            isLabelVisible: _cartProductsCount > 0,
            label: Text('$_cartProductsCount'),
            child: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
          selectedIcon: Badge(
            isLabelVisible: _cartProductsCount > 0,
            label: Text('$_cartProductsCount'),
            child: const Icon(
              Icons.shopping_bag_rounded,
            ),
          ),
          label: 'Кошик',
        ),
      ],
    );
  }

  Widget _buildProductDetailsSheet(Product product) {
    final bool isFavorite =
        _favoriteProductIds.contains(product.id);

    final int quantity =
        _cartItems[product.id]?.quantity ?? 0;

    return StatefulBuilder(
      builder: (
        BuildContext context,
        StateSetter setModalState,
      ) {
        void refresh() {
          setModalState(() {});
          setState(() {});
        }

        return DraggableScrollableSheet(
          initialChildSize: 0.86,
          minChildSize: 0.58,
          maxChildSize: 0.95,
          builder: (
            BuildContext context,
            ScrollController scrollController,
          ) {
            final bool currentFavorite =
                _favoriteProductIds.contains(product.id);

            final int currentQuantity =
                _cartItems[product.id]?.quantity ?? 0;

            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF8F4EF),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 310,
                        width: double.infinity,
                        child: Image.asset(
                          product.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) {
                            return _buildImagePlaceholder(
                              product.category,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 14,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 48,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(
                                alpha: 0.85,
                              ),
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 24,
                        left: 18,
                        child: Material(
                          color: Colors.white.withValues(
                            alpha: 0.94,
                          ),
                          shape: const CircleBorder(),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Color(0xFF37251F),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 24,
                        right: 18,
                        child: Material(
                          color: Colors.white.withValues(
                            alpha: 0.94,
                          ),
                          shape: const CircleBorder(),
                          child: IconButton(
                            onPressed: () {
                              _toggleFavorite(product);
                              refresh();
                            },
                            icon: Icon(
                              currentFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: currentFavorite
                                  ? const Color(0xFFC95F5F)
                                  : const Color(0xFF37251F),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      22,
                      22,
                      22,
                      32,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                  color: Color(0xFF2E211D),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  height: 1.08,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              product.formattedPrice,
                              style: const TextStyle(
                                color: Color(0xFF37251F),
                                fontSize: 23,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: <Widget>[
                            _buildProductInfoChip(
                              icon: _categoryIcon(
                                product.category,
                              ),
                              label: product.category.title,
                            ),
                            if (product.volume != null)
                              _buildProductInfoChip(
                                icon: Icons.straighten_rounded,
                                label: product.volume!,
                              ),
                            if (product.isPopular)
                              _buildProductInfoChip(
                                icon:
                                    Icons.local_fire_department_rounded,
                                label: 'Популярне',
                              ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        const Text(
                          'Опис',
                          style: TextStyle(
                            color: Color(0xFF2E211D),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: const TextStyle(
                            color: Color(0xFF796A64),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 28),
                        if (currentQuantity == 0)
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: () {
                                _addProductToCart(product);
                                refresh();
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF37251F),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 17,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(18),
                                ),
                              ),
                              icon: const Icon(
                                Icons.shopping_bag_outlined,
                              ),
                              label: const Text(
                                'Додати до кошика',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: <Widget>[
                                Material(
                                  color: const Color(0xFFF0E7E2),
                                  borderRadius:
                                      BorderRadius.circular(14),
                                  child: IconButton(
                                    onPressed: () {
                                      _decreaseQuantity(product);
                                      refresh();
                                    },
                                    icon: const Icon(
                                      Icons.remove_rounded,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '$currentQuantity',
                                        style: const TextStyle(
                                          color:
                                              Color(0xFF2E211D),
                                          fontSize: 22,
                                          fontWeight:
                                              FontWeight.w900,
                                        ),
                                      ),
                                      const Text(
                                        'у кошику',
                                        style: TextStyle(
                                          color:
                                              Color(0xFF8A7A73),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Material(
                                  color: const Color(0xFF37251F),
                                  borderRadius:
                                      BorderRadius.circular(14),
                                  child: IconButton(
                                    onPressed: () {
                                      _increaseQuantity(product);
                                      refresh();
                                    },
                                    icon: const Icon(
                                      Icons.add_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProductInfoChip({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE9DFDA),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF7A6157),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6A554D),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartSheet(
    BuildContext context,
    VoidCallback refreshCart,
  ) {
    final List<CartItem> items =
        _cartItems.values.toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.45,
      maxChildSize: 0.95,
      builder: (
        BuildContext context,
        ScrollController scrollController,
      ) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF8F4EF),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  14,
                  12,
                  10,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 46,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD2C5BF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFF37251F),
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.shopping_bag_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Ваш кошик',
                                style: TextStyle(
                                  color: Color(0xFF2E211D),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                '$_cartProductsCount товарів',
                                style: const TextStyle(
                                  color: Color(0xFF8A7A73),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (items.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _cartItems.clear();
                              });

                              refreshCart();
                            },
                            child: const Text(
                              'Очистити',
                              style: TextStyle(
                                color: Color(0xFFC95F5F),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                color: Color(0xFFE8DDD8),
              ),
              if (items.isEmpty)
                Expanded(
                  child: _buildEmptyCartState(context),
                )
              else
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      20,
                    ),
                    itemCount: items.length,
                    separatorBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return const SizedBox(height: 12);
                    },
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      final CartItem item = items[index];

                      return _buildCartItem(
                        item,
                        refreshCart,
                      );
                    },
                  ),
                ),
              if (items.isNotEmpty)
                _buildCartSummary(
                  context,
                  refreshCart,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartItem(
    CartItem item,
    VoidCallback refreshCart,
  ) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 82,
              height: 82,
              child: Image.asset(
                item.product.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stackTrace,
                ) {
                  return _buildImagePlaceholder(
                    item.product.category,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF2E211D),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                if (item.product.volume != null)
                  Text(
                    item.product.volume!,
                    style: const TextStyle(
                      color: Color(0xFF94847D),
                      fontSize: 12,
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  '${item.totalPrice.toStringAsFixed(0)} ₴',
                  style: const TextStyle(
                    color: Color(0xFF37251F),
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  _removeFromCart(item.product);
                  refreshCart();
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFC95F5F),
                  size: 21,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2EAE6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _decreaseQuantity(item.product);
                        refreshCart();
                      },
                      child: const SizedBox(
                        width: 30,
                        height: 34,
                        child: Icon(
                          Icons.remove_rounded,
                          size: 17,
                        ),
                      ),
                    ),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _increaseQuantity(item.product);
                        refreshCart();
                      },
                      child: const SizedBox(
                        width: 30,
                        height: 34,
                        child: Icon(
                          Icons.add_rounded,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary(
    BuildContext context,
    VoidCallback refreshCart,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        18 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 22,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'До сплати',
                  style: TextStyle(
                    color: Color(0xFF786861),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${_cartTotalPrice.toStringAsFixed(0)} ₴',
                style: const TextStyle(
                  color: Color(0xFF2E211D),
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(this.context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Замовлення успішно оформлено',
                      ),
                    ),
                  );

                setState(() {
                  _cartItems.clear();
                });
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF37251F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 17,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Оформити замовлення',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCartState(
    BuildContext sheetContext,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 54,
                color: Color(0xFFB09E96),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Кошик порожній',
              style: TextStyle(
                color: Color(0xFF2E211D),
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Додайте напої або десерти,\nякі бажаєте замовити.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF8A7A73),
                fontSize: 14,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(sheetContext).pop();

                setState(() {
                  _selectedNavigationIndex = 0;
                });
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF37251F),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
              icon: const Icon(
                Icons.local_cafe_rounded,
              ),
              label: const Text(
                'Обрати напій',
              ),
            ),
          ],
        ),
      ),
    );
  }
}