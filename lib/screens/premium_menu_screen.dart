
import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class PremiumMenuScreen extends StatefulWidget {
  const PremiumMenuScreen({super.key});

  @override
  State<PremiumMenuScreen> createState() => _PremiumMenuScreenState();
}

class _PremiumMenuScreenState extends State<PremiumMenuScreen> {
  final TextEditingController _searchController = TextEditingController();

  ProductCategory? _selectedCategory;
  final Set<String> _favorites = <String>{};
  final Map<String, CartItem> _cart = <String, CartItem>{};

  int _pageIndex = 0;

  static const Color _bg = Color(0xFF090909);
  static const Color _surface = Color(0xFF141414);
  static const Color _surface2 = Color(0xFF1D1D1D);
  static const Color _gold = Color(0xFFD8AE68);
  static const Color _cream = Color(0xFFF4E9D8);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filteredProducts {
    final String query = _searchController.text.trim().toLowerCase();

    return allProducts.where((Product product) {
      final bool categoryMatches =
          _selectedCategory == null || product.category == _selectedCategory;

      final bool searchMatches =
          query.isEmpty || product.searchText.contains(query);

      return categoryMatches && searchMatches;
    }).toList();
  }

  List<Product> get _favoriteProducts {
    return allProducts
        .where((Product product) => _favorites.contains(product.id))
        .toList();
  }

  int get _cartCount {
    return _cart.values.fold<int>(
      0,
      (int total, CartItem item) => total + item.quantity,
    );
  }

  double get _cartTotal {
    return _cart.values.fold<double>(
      0,
      (double total, CartItem item) => total + item.totalPrice,
    );
  }

  void _toggleFavorite(Product product) {
    setState(() {
      if (_favorites.contains(product.id)) {
        _favorites.remove(product.id);
      } else {
        _favorites.add(product.id);
      }
    });
  }

  void _addToCart(Product product) {
    setState(() {
      final CartItem? current = _cart[product.id];

      if (current == null) {
        _cart[product.id] = CartItem(product: product, quantity: 1);
      } else {
        _cart[product.id] = current.copyWith(
          quantity: current.quantity + 1,
        );
      }
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: _surface2,
          content: Text('${product.name} додано до кошика'),
          action: SnackBarAction(
            label: 'Відкрити',
            textColor: _gold,
            onPressed: _openCart,
          ),
        ),
      );
  }

  void _increase(Product product) {
    setState(() {
      final CartItem? current = _cart[product.id];

      if (current == null) {
        _cart[product.id] = CartItem(product: product, quantity: 1);
      } else {
        _cart[product.id] = current.copyWith(
          quantity: current.quantity + 1,
        );
      }
    });
  }

  void _decrease(Product product) {
    setState(() {
      final CartItem? current = _cart[product.id];

      if (current == null) return;

      if (current.quantity <= 1) {
        _cart.remove(product.id);
      } else {
        _cart[product.id] = current.copyWith(
          quantity: current.quantity - 1,
        );
      }
    });
  }

  void _remove(Product product) {
    setState(() => _cart.remove(product.id));
  }

  @override
  Widget build(BuildContext context) {
    final bool wide = MediaQuery.sizeOf(context).width >= 920;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: IndexedStack(
          index: _pageIndex,
          children: <Widget>[
            _buildMenuPage(wide),
            _buildFavoritesPage(wide),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
      floatingActionButton: _cartCount == 0
          ? null
          : FloatingActionButton.extended(
              onPressed: _openCart,
              backgroundColor: _gold,
              foregroundColor: Colors.black,
              icon: const Icon(Icons.shopping_bag_rounded),
              label: Text(
                '$_cartCount',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
    );
  }

  Widget _buildMenuPage(bool wide) {
    final List<Product> products = _filteredProducts;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildWelcomeBanner()),
        SliverToBoxAdapter(child: _buildSearch()),
        SliverToBoxAdapter(child: _buildCategories()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedCategory == null
                        ? 'Усе меню'
                        : _selectedCategory!.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text(
                  '${products.length} позицій',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (products.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildEmptySearch(),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 120),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: wide ? 4 : 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: wide ? 0.78 : 0.66,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildProductCard(products[index]);
                },
                childCount: products.length,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFavoritesPage(bool wide) {
    final List<Product> products = _favoriteProducts;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: _surface2,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: _gold,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Обране',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Ваші улюблені позиції',
                        style: TextStyle(color: Colors.white54),
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
            child: _buildEmptyFavorites(),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 120),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: wide ? 4 : 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: wide ? 0.78 : 0.66,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildProductCard(products[index]);
                },
                childCount: products.length,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 14, 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white10),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x55000000),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.local_cafe_rounded,
              color: _gold,
              size: 29,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "JULIAM'S COFFEE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Кава, створена з любов’ю',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              IconButton.filledTonal(
                onPressed: _openCart,
                style: IconButton.styleFrom(
                  backgroundColor: _surface,
                  foregroundColor: _cream,
                  fixedSize: const Size(48, 48),
                ),
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
              if (_cartCount > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 22,
                      minHeight: 22,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: _gold,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _bg, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$_cartCount',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
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
      margin: const EdgeInsets.fromLTRB(18, 8, 18, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF31251D),
            Color(0xFF17110D),
            Color(0xFF0D0D0D),
          ],
        ),
        border: Border.all(color: const Color(0x33D8AE68)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -42,
              top: -50,
              child: Container(
                width: 180,
                height: 180,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x18D8AE68),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
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
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Оберіть напій або десерт,\nа ми приготуємо його для вас.',
                          style: TextStyle(
                            color: Color(0xFFD9CFC6),
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          'JULIAM’S COFFEE',
                          style: TextStyle(
                            color: _gold,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      color: const Color(0x17FFFFFF),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: const Icon(
                      Icons.coffee_rounded,
                      color: _gold,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Знайти напій або десерт...',
          hintStyle: const TextStyle(color: Colors.white38),
          prefixIcon: const Icon(Icons.search_rounded, color: _gold),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
          filled: true,
          fillColor: _surface,
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
            borderSide: const BorderSide(color: Colors.white10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: _gold, width: 1.4),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        children: <Widget>[
          _buildCategoryChip(
            title: 'Усі',
            icon: Icons.grid_view_rounded,
            selected: _selectedCategory == null,
            onTap: () => setState(() => _selectedCategory = null),
          ),
          ...ProductCategory.values.map(
            (ProductCategory category) => _buildCategoryChip(
              title: category.title,
              icon: _categoryIcon(category),
              selected: _selectedCategory == category,
              onTap: () => setState(() => _selectedCategory = category),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: Material(
        color: selected ? _gold : _surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected ? _gold : Colors.white10,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  size: 18,
                  color: selected ? Colors.black : Colors.white70,
                ),
                const SizedBox(width: 7),
                Text(
                  title,
                  style: TextStyle(
                    color: selected ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
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
    final bool favorite = _favorites.contains(product.id);
    final int quantity = _cart[product.id]?.quantity ?? 0;

    return Hero(
      tag: 'product_${product.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openProduct(product),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white10),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x55000000),
                  blurRadius: 18,
                  offset: Offset(0, 9),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(
                        product.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return _imagePlaceholder(product.category);
                        },
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.transparent,
                              Color(0x77000000),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 9,
                        right: 9,
                        child: Material(
                          color: Colors.black54,
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: () => _toggleFavorite(product),
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                favorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 20,
                                color: favorite ? _gold : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (product.isPopular)
                        Positioned(
                          left: 9,
                          top: 9,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _gold,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'ТОП',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 12, 13, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: Text(
                            product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),
                        ),
                        if (product.volume != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              product.volume!,
                              style: const TextStyle(
                                color: _gold,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                product.formattedPrice,
                                style: const TextStyle(
                                  color: _cream,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            quantity == 0
                                ? _addButton(product)
                                : _quantityControl(product, quantity),
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
      ),
    );
  }

  Widget _addButton(Product product) {
    return Material(
      color: _gold,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: () => _addToCart(product),
        borderRadius: BorderRadius.circular(13),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.add_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _quantityControl(Product product, int quantity) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: _surface2,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () => _decrease(product),
            child: const SizedBox(
              width: 31,
              child: Icon(
                Icons.remove_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              color: _cream,
              fontWeight: FontWeight.w900,
            ),
          ),
          InkWell(
            onTap: () => _increase(product),
            child: const SizedBox(
              width: 31,
              child: Icon(
                Icons.add_rounded,
                size: 18,
                color: _gold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder(ProductCategory category) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF2A211B),
            Color(0xFF111111),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          _categoryIcon(category),
          color: _gold,
          size: 58,
        ),
      ),
    );
  }

  void _openProduct(Product product) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Закрити',
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 380),
      pageBuilder: (_, __, ___) {
        final bool desktop = MediaQuery.sizeOf(context).width > 820;

        return Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1280,
                    maxHeight: 860,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: desktop
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                flex: 7,
                                child: Hero(
                                  tag: 'product_${product.id}',
                                  child: Image.asset(
                                    product.imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        _imagePlaceholder(product.category),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: _productDetailsPanel(product),
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Hero(
                                  tag: 'product_${product.id}',
                                  child: Image.asset(
                                    product.imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        _imagePlaceholder(product.category),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: _productDetailsPanel(product),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, Animation<double> animation, __, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.97, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }

  Widget _productDetailsPanel(Product product) {
    return StatefulBuilder(
      builder: (
        BuildContext context,
        StateSetter setModalState,
      ) {
        final bool favorite = _favorites.contains(product.id);
        final int quantity = _cart[product.id]?.quantity ?? 0;

        void refresh() {
          setModalState(() {});
          setState(() {});
        }

        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              color: const Color(0xF5141414),
              padding: const EdgeInsets.fromLTRB(24, 26, 24, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton.filledTonal(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: _surface2,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.close_rounded),
                      ),
                      const Spacer(),
                      IconButton.filledTonal(
                        onPressed: () {
                          _toggleFavorite(product);
                          refresh();
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: _surface2,
                        ),
                        icon: Icon(
                          favorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: favorite ? _gold : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.name.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              height: 1.05,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(width: 74, height: 2, color: _gold),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              _infoChip(
                                _categoryIcon(product.category),
                                product.category.title,
                              ),
                              if (product.volume != null)
                                _infoChip(
                                  Icons.straighten_rounded,
                                  product.volume!,
                                ),
                              if (product.isPopular)
                                _infoChip(
                                  Icons.local_fire_department_rounded,
                                  'Популярне',
                                ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Text(
                            product.formattedPrice,
                            style: const TextStyle(
                              color: _gold,
                              fontSize: 27,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            'ОПИС',
                            style: TextStyle(
                              color: _cream,
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.description,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 15,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  quantity == 0
                      ? SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: FilledButton.icon(
                            onPressed: () {
                              _addToCart(product);
                              refresh();
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: _gold,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            icon: const Icon(Icons.shopping_bag_outlined),
                            label: const Text(
                              'ДОДАТИ ДО КОШИКА',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _surface2,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  _decrease(product);
                                  refresh();
                                },
                                icon: const Icon(Icons.remove_rounded),
                              ),
                              Expanded(
                                child: Text(
                                  '$quantity у кошику',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: _cream,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _increase(product);
                                  refresh();
                                },
                                icon: const Icon(
                                  Icons.add_rounded,
                                  color: _gold,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: _surface2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: _gold),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
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
            void refresh() {
              setModalState(() {});
              setState(() {});
            }

            final List<CartItem> items = _cart.values.toList();

            return DraggableScrollableSheet(
              initialChildSize: 0.86,
              minChildSize: 0.48,
              maxChildSize: 0.96,
              builder: (
                BuildContext context,
                ScrollController controller,
              ) {
                return Container(
                  decoration: const BoxDecoration(
                    color: _bg,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 14, 12, 12),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 46,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: _gold,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.shopping_bag_rounded,
                                    color: Colors.black,
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
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        '$_cartCount товарів',
                                        style: const TextStyle(
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (items.isNotEmpty)
                                  TextButton(
                                    onPressed: () {
                                      setState(() => _cart.clear());
                                      refresh();
                                    },
                                    child: const Text(
                                      'Очистити',
                                      style: TextStyle(color: _gold),
                                    ),
                                  ),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: Colors.white10),
                      if (items.isEmpty)
                        Expanded(child: _buildEmptyCart(context))
                      else
                        Expanded(
                          child: ListView.separated(
                            controller: controller,
                            padding: const EdgeInsets.all(14),
                            itemCount: items.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (_, int index) {
                              return _cartItem(items[index], refresh);
                            },
                          ),
                        ),
                      if (items.isNotEmpty) _cartSummary(context),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _cartItem(CartItem item, VoidCallback refresh) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: 82,
              height: 82,
              child: Image.asset(
                item.product.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return _imagePlaceholder(item.product.category);
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                if (item.product.volume != null) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(
                    item.product.volume!,
                    style: const TextStyle(color: Colors.white38),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  '${item.totalPrice.toStringAsFixed(0)} ₴',
                  style: const TextStyle(
                    color: _gold,
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
                  _remove(item.product);
                  refresh();
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.redAccent,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: _surface2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _decrease(item.product);
                        refresh();
                      },
                      child: const SizedBox(
                        width: 30,
                        height: 34,
                        child: Icon(
                          Icons.remove_rounded,
                          size: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        color: _cream,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _increase(item.product);
                        refresh();
                      },
                      child: const SizedBox(
                        width: 30,
                        height: 34,
                        child: Icon(
                          Icons.add_rounded,
                          size: 17,
                          color: _gold,
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

  Widget _cartSummary(BuildContext sheetContext) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        18,
        16,
        18,
        16 + MediaQuery.paddingOf(sheetContext).bottom,
      ),
      decoration: const BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'До сплати',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${_cartTotal.toStringAsFixed(0)} ₴',
                style: const TextStyle(
                  color: _cream,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(sheetContext);
                setState(() => _cart.clear());

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text('Замовлення успішно оформлено'),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: const Text(
                'ОФОРМИТИ ЗАМОВЛЕННЯ',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearch() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search_off_rounded,
              color: _gold,
              size: 66,
            ),
            SizedBox(height: 16),
            Text(
              'Нічого не знайдено',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Спробуйте інший запит або категорію.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFavorites() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.favorite_border_rounded,
              color: _gold,
              size: 70,
            ),
            const SizedBox(height: 18),
            const Text(
              'Тут поки порожньо',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Натисніть на сердечко біля товару.',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () => setState(() => _pageIndex = 0),
              style: FilledButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: Colors.black,
              ),
              child: const Text('Перейти до меню'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext sheetContext) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.shopping_bag_outlined,
              color: _gold,
              size: 70,
            ),
            const SizedBox(height: 18),
            const Text(
              'Кошик порожній',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Додайте напої або десерти.',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () {
                Navigator.pop(sheetContext);
                setState(() => _pageIndex = 0);
              },
              style: FilledButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: Colors.black,
              ),
              child: const Text('Обрати товар'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return NavigationBar(
      height: 74,
      selectedIndex: _pageIndex,
      onDestinationSelected: (int index) {
        if (index == 2) {
          _openCart();
          return;
        }

        setState(() => _pageIndex = index);
      },
      backgroundColor: _surface,
      indicatorColor: const Color(0x33D8AE68),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
        (Set<WidgetState> states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? _gold
                : Colors.white54,
            fontWeight: FontWeight.w700,
          );
        },
      ),
      destinations: <NavigationDestination>[
        const NavigationDestination(
          icon: Icon(Icons.home_outlined, color: Colors.white54),
          selectedIcon: Icon(Icons.home_rounded, color: _gold),
          label: 'Меню',
        ),
        const NavigationDestination(
          icon: Icon(Icons.favorite_border_rounded, color: Colors.white54),
          selectedIcon: Icon(Icons.favorite_rounded, color: _gold),
          label: 'Обране',
        ),
        NavigationDestination(
          icon: Badge(
            isLabelVisible: _cartCount > 0,
            label: Text('$_cartCount'),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white54,
            ),
          ),
          selectedIcon: Badge(
            isLabelVisible: _cartCount > 0,
            label: Text('$_cartCount'),
            child: const Icon(
              Icons.shopping_bag_rounded,
              color: _gold,
            ),
          ),
          label: 'Кошик',
        ),
      ],
    );
  }
}
