import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF131921),
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AmazonCloneApp());
}

// ─── Theme & Constants ────────────────────────────────────────────────────────

class AmazonColors {
  static const background = Color(0xFF131921);
  static const navBar = Color(0xFF232F3E);
  static const searchBar = Color(0xFFFFFFFF);
  static const accent = Color(0xFFFF9900);
  static const accentDark = Color(0xFFE47911);
  static const cardBg = Color(0xFFFFFFFF);
  static const scaffoldBg = Color(0xFFEAEAEA);
  static const textPrimary = Color(0xFF0F1111);
  static const textSecondary = Color(0xFF565959);
  static const textLight = Color(0xFFFFFFFF);
  static const prime = Color(0xFF00A8E1);
  static const primeGold = Color(0xFFFCD200);
  static const green = Color(0xFF007600);
  static const red = Color(0xFFB12704);
  static const divider = Color(0xFFDDDDDD);
  static const starYellow = Color(0xFFFF9900);
}

// ─── Data Models ─────────────────────────────────────────────────────────────

class Product {
  final String id;
  final String title;
  final String brand;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviews;
  final String imageEmoji;
  final bool isPrime;
  final bool isBestSeller;
  final String category;
  final String? badge;

  const Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.imageEmoji,
    this.isPrime = false,
    this.isBestSeller = false,
    required this.category,
    this.badge,
  });

  int get discountPercent {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }
}

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

// ─── Sample Data ──────────────────────────────────────────────────────────────

const List<Product> sampleProducts = [
  Product(
    id: '1',
    title: 'Sony WH-1000XM5 Wireless Noise Canceling Headphones',
    brand: 'Sony',
    price: 279.99,
    originalPrice: 399.99,
    rating: 4.7,
    reviews: 12453,
    imageEmoji: '🎧',
    isPrime: true,
    isBestSeller: true,
    category: 'Electronics',
    badge: 'Best Seller',
  ),
  Product(
    id: '2',
    title: 'Apple AirPods Pro (2nd Generation) with MagSafe Case',
    brand: 'Apple',
    price: 199.00,
    originalPrice: 249.00,
    rating: 4.8,
    reviews: 89234,
    imageEmoji: '🎵',
    isPrime: true,
    category: 'Electronics',
    badge: 'Deal',
  ),
  Product(
    id: '3',
    title: 'Instant Pot Duo 7-in-1 Electric Pressure Cooker, 6 Quart',
    brand: 'Instant Pot',
    price: 59.99,
    originalPrice: 99.95,
    rating: 4.7,
    reviews: 145632,
    imageEmoji: '🍲',
    isPrime: true,
    isBestSeller: true,
    category: 'Kitchen',
    badge: 'Best Seller',
  ),
  Product(
    id: '4',
    title: 'Kindle Paperwhite (16 GB) – Now with a 6.8" display',
    brand: 'Amazon',
    price: 139.99,
    originalPrice: 159.99,
    rating: 4.6,
    reviews: 67890,
    imageEmoji: '📖',
    isPrime: true,
    category: 'Electronics',
  ),
  Product(
    id: '5',
    title: 'LEGO Icons Botanical Collection Sunflowers Set',
    brand: 'LEGO',
    price: 49.99,
    rating: 4.9,
    reviews: 3421,
    imageEmoji: '🌻',
    isPrime: true,
    category: 'Toys',
    badge: 'New',
  ),
  Product(
    id: '6',
    title: 'Ninja AF101 Air Fryer that Cooks, Crisps and Dehydrates',
    brand: 'Ninja',
    price: 89.99,
    originalPrice: 129.99,
    rating: 4.6,
    reviews: 54321,
    imageEmoji: '🍟',
    isPrime: true,
    isBestSeller: true,
    category: 'Kitchen',
  ),
  Product(
    id: '7',
    title: 'Samsung 65" Class QLED 4K Smart TV (2024)',
    brand: 'Samsung',
    price: 799.99,
    originalPrice: 1199.99,
    rating: 4.5,
    reviews: 8765,
    imageEmoji: '📺',
    isPrime: true,
    category: 'Electronics',
    badge: 'Deal',
  ),
  Product(
    id: '8',
    title: 'adidas Ultraboost 22 Running Shoes',
    brand: 'adidas',
    price: 119.95,
    originalPrice: 190.00,
    rating: 4.5,
    reviews: 23456,
    imageEmoji: '👟',
    isPrime: true,
    category: 'Fashion',
  ),
];

const List<Map<String, dynamic>> categories = [
  {'icon': '⚡', 'label': 'Electronics'},
  {'icon': '🏠', 'label': 'Home'},
  {'icon': '👗', 'label': 'Fashion'},
  {'icon': '📚', 'label': 'Books'},
  {'icon': '🎮', 'label': 'Gaming'},
  {'icon': '🍳', 'label': 'Kitchen'},
  {'icon': '🏋️', 'label': 'Sports'},
  {'icon': '🧴', 'label': 'Beauty'},
];

const List<Map<String, dynamic>> banners = [
  {
    'title': 'Prime Day Deals',
    'subtitle': 'Up to 50% off on Electronics',
    'emoji': '⚡',
    'gradient': [Color(0xFF0F3460), Color(0xFF16213E)],
    'accent': Color(0xFFFCD200),
  },
  {
    'title': 'New Arrivals',
    'subtitle': 'Explore the latest in Fashion',
    'emoji': '✨',
    'gradient': [Color(0xFF1a1a2e), Color(0xFF16213E)],
    'accent': Color(0xFFFF9900),
  },
  {
    'title': 'Kitchen Deals',
    'subtitle': 'Cook smarter, not harder',
    'emoji': '🍳',
    'gradient': [Color(0xFF2d1b69), Color(0xFF131921)],
    'accent': Color(0xFF00A8E1),
  },
];

// ─── App ──────────────────────────────────────────────────────────────────────

class AmazonCloneApp extends StatelessWidget {
  const AmazonCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AmazonColors.scaffoldBg,
        colorScheme: ColorScheme.fromSeed(seedColor: AmazonColors.accent),
        appBarTheme: const AppBarTheme(
          backgroundColor: AmazonColors.background,
          elevation: 0,
        ),
      ),
      home: const MainScaffold(),
    );
  }
}

// ─── Main Scaffold ────────────────────────────────────────────────────────────

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  final List<CartItem> _cart = [];

  void _addToCart(Product product) {
    setState(() {
      final idx = _cart.indexWhere((c) => c.product.id == product.id);
      if (idx >= 0) {
        _cart[idx].quantity++;
      } else {
        _cart.add(CartItem(product: product));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title.split(' ').take(4).join(' ')}... added to cart'),
        backgroundColor: AmazonColors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

 int get _cartCount => _cart.fold(0, (sum, item) => sum + item.quantity);

double get _cartTotal =>
    _cart.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

@override
Widget build(BuildContext context) {
  final pages = [
    HomePage(
      onAddToCart: _addToCart,
      cartCount: _cartCount,
      onCartTap: () => setState(() => _currentIndex = 2),
    ),
    SearchPage(
      onAddToCart: _addToCart,
    ),
    CartPage(
      cart: _cart,
      total: _cartTotal,
      onQuantityChange: (item, delta) {
        setState(() {
          item.quantity += delta;
          if (item.quantity <= 0) _cart.remove(item);
        });
      },
    ),
    AccountPage(),
  ];

  return Scaffold(
    body: IndexedStack(index: _currentIndex, children: pages),
    bottomNavigationBar: _BottomNav(
      currentIndex: _currentIndex,
      cartCount: _cartCount,
      onTap: (i) => setState(() => _currentIndex = i),
    ),
  );
}
} 

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int current;
  final ValueChanged<int> onTap;
  final int badge;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
    this.badge = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isActive ? AmazonColors.accent : Colors.white60,
                  size: 24,
                ),
                if (badge > 0)
                  Positioned(
                    top: -6,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AmazonColors.accent,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        badge > 99 ? '99+' : '$badge',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AmazonColors.accent : Colors.white60,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class AmazonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartCount;
  final VoidCallback? onCartTap;
  final bool showSearch;

  const AmazonAppBar({
    super.key,
    this.cartCount = 0,
    this.onCartTap,
    this.showSearch = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AmazonColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Top row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  // Logo
                  Row(
                    children: [
                      const Text(
                        'amazon',
                        style: TextStyle(
                          color: AmazonColors.textLight,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 1, top: 8),
                        child: const Text(
                          '.in',
                          style: TextStyle(
                            color: AmazonColors.accent,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Location
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: AmazonColors.textLight, size: 14),
                      SizedBox(width: 2),
                      Text(
                        'Mumbai 400001',
                        style: TextStyle(color: AmazonColors.textLight, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Cart
                  GestureDetector(
                    onTap: onCartTap,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.shopping_cart_outlined, color: AmazonColors.textLight, size: 28),
                        if (cartCount > 0)
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: AmazonColors.accent,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$cartCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Search bar
            if (showSearch)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AmazonColors.searchBar,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      const Icon(Icons.search, color: AmazonColors.textSecondary, size: 22),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Search Amazon.in',
                          style: TextStyle(color: AmazonColors.textSecondary, fontSize: 14),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AmazonColors.accent,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: const Icon(Icons.search, color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Home Page ────────────────────────────────────────────────────────────────

class HomePage extends StatelessWidget {
  final ValueChanged<Product> onAddToCart;
  final int cartCount;
  final VoidCallback onCartTap;

  const HomePage({
    super.key,
    required this.onAddToCart,
    required this.cartCount,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AmazonColors.scaffoldBg,
      appBar: AmazonAppBar(cartCount: cartCount, onCartTap: onCartTap),
      body: ListView(
        children: [
          // Prime banner strip
          _PrimeBanner(),
          // Banners carousel
          _BannerCarousel(),
          // Categories
          _CategoriesSection(),
          // Flash deals
          _SectionHeader(title: '⚡ Flash Deals', subtitle: 'Ends in 04:32:17'),
          _HorizontalProductList(
            products: sampleProducts.where((p) => p.discountPercent > 20).toList(),
            onAddToCart: onAddToCart,
          ),
          // Best sellers
          _SectionHeader(title: '🏆 Best Sellers', subtitle: 'Most purchased this week'),
          _HorizontalProductList(
            products: sampleProducts.where((p) => p.isBestSeller).toList(),
            onAddToCart: onAddToCart,
          ),
          // All products grid
          _SectionHeader(title: '🛍️ Recommended for you'),
          _ProductGrid(
            products: sampleProducts,
            onAddToCart: onAddToCart,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _PrimeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF00A8E1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Text('prime', style: TextStyle(color: Colors.white, fontSize: 13, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          const Text('Free delivery on orders over ₹499', style: TextStyle(color: Colors.white, fontSize: 12)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('Join', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _BannerCarousel extends StatefulWidget {
  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: (banner['gradient'] as List<Color>),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Background emoji
                    Positioned(
                      right: 20,
                      bottom: 10,
                      child: Text(banner['emoji'] as String, style: const TextStyle(fontSize: 80)),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: (banner['accent'] as Color),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              banner['title'] as String,
                              style: const TextStyle(
                                color: Color(0xFF131921),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            banner['subtitle'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AmazonColors.accent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Shop Now',
                              style: TextStyle(
                                color: Color(0xFF131921),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (i) {
            return Container(
              width: i == _currentPage ? 16 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: i == _currentPage ? AmazonColors.accent : Colors.grey[400],
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Shop by Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AmazonColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 88,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return Container(
                  width: 72,
                  margin: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AmazonColors.scaffoldBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AmazonColors.divider),
                        ),
                        child: Center(
                          child: Text(cat['icon'] as String, style: const TextStyle(fontSize: 26)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat['label'] as String,
                        style: const TextStyle(fontSize: 11, color: AmazonColors.textPrimary),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionHeader({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AmazonColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(fontSize: 12, color: AmazonColors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const Text(
            'See all',
            style: TextStyle(fontSize: 13, color: Color(0xFF007185), fontWeight: FontWeight.w500),
          ),
          const Icon(Icons.chevron_right, size: 18, color: Color(0xFF007185)),
        ],
      ),
    );
  }
}

// ─── Horizontal Product List ──────────────────────────────────────────────────

class _HorizontalProductList extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product> onAddToCart;

  const _HorizontalProductList({
    required this.products,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _HorizontalProductCard(
            product: products[index],
            onAddToCart: onAddToCart,
          );
        },
      ),
    );
  }
}

class _HorizontalProductCard extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onAddToCart;

  const _HorizontalProductCard({
    super.key, // Recommended to use super.key in newer Flutter versions
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AmazonColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Stack(
            children: [
              Container(
                height: 110,
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Center(
                  child: Text(product.imageEmoji, style: const TextStyle(fontSize: 52)),
                ),
              ),
              if (product.badge != null)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: product.badge == 'Best Seller' ? AmazonColors.accent : AmazonColors.red,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      product.badge!,
                      style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    // Add favorite logic here
                  },
                  child: const Icon(
                    Icons.favorite, // Fixed: Icons (plural) and added closing parenthesis
                    size: 20,       // Fixed: size belongs to the Icon, not GestureDetector
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: AmazonColors.textPrimary),
                ),
                const SizedBox(height: 4),
                _StarRating(rating: product.rating, reviews: product.reviews, small: true),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '₹${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AmazonColors.textPrimary,
                      ),
                    ),
                    if (product.discountPercent > 0) ...[
                      const SizedBox(width: 4),
                      Text(
                        '-${product.discountPercent}%',
                        style: const TextStyle(fontSize: 10, color: AmazonColors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: GestureDetector(
              onTap: () => onAddToCart(product),
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  color: AmazonColors.accent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text(
                    'Proceed to buy',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF131921)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ─── Product Grid ─────────────────────────────────────────────────────────────

class _ProductGrid extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product> onAddToCart;


  const _ProductGrid({
    required this.products,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75, // ✅ balanced height
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return _ProductGridCard(
            product: product,
            onAddToCart: onAddToCart,
          );
        },
      ),
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onAddToCart;

  const _ProductGridCard({
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 👉 OPEN PRODUCT DETAIL
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              product: product,
              onAddToCart: onAddToCart,
            ),
          ),
        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AmazonColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // IMAGE
            Container(
              height: 130,
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(
                child: Text(product.imageEmoji, style: const TextStyle(fontSize: 60)),
              ),
            ),

            // INFO
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12)),

                  const SizedBox(height: 4),

                  Text(
                    '₹${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ADD TO CART
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => onAddToCart(product),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD814),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text('Add to Cart',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Star Rating ──────────────────────────────────────────────────────────────

class _StarRating extends StatelessWidget {
  final double rating;
  final int reviews;
  final bool small;

  const _StarRating({required this.rating, required this.reviews, this.small = false});

  @override
  Widget build(BuildContext context) {
    final starSize = small ? 11.0 : 14.0;
    final textSize = small ? 10.0 : 12.0;
    return Row(
      children: [
        ...List.generate(5, (i) {
          if (i < rating.floor()) {
            return Icon(Icons.star, size: starSize, color: AmazonColors.starYellow);
          } else if (i < rating) {
            return Icon(Icons.star_half, size: starSize, color: AmazonColors.starYellow);
          } else {
            return Icon(Icons.star_border, size: starSize, color: AmazonColors.starYellow);
          }
        }),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(fontSize: textSize, color: const Color(0xFF007185)),
        ),
        const SizedBox(width: 3),
        Text(
          '(${_formatReviews(reviews)})',
          style: TextStyle(fontSize: textSize, color: const Color(0xFF007185)),
        ),
      ],
    );
  }

  String _formatReviews(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(0)}K';
    return '$count';
  }
}

// ─── Product Detail Page ──────────────────────────────────────────────────────

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final ValueChanged<Product> onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
    
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AmazonColors.background,
        leading: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Product Details', style: TextStyle(color: Colors.white, fontSize: 16)),
        actions: [
  IconButton(
    icon: const Icon(Icons.search, color: Colors.white), 
    onPressed: () {
      // Your code here
    },
  ), // <--- This comma was missing
  const Icon(Icons.share, color: Colors.white),
  const SizedBox(width: 12),
],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 300,
              color: const Color(0xFFF7F7F7),
              child: Center(child: Text(p.imageEmoji, style: const TextStyle(fontSize: 140))),
            ),
            // Badges
            if (p.badge != null || p.isPrime)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Wrap(
                  spacing: 8,
                  children: [
                    if (p.badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: p.badge == 'Best Seller' ? AmazonColors.accent : AmazonColors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(p.badge!, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    if (p.isPrime)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AmazonColors.prime,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('prime', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                      ),
                  ],
                ),
              ),
            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(p.title, style: const TextStyle(fontSize: 18, color: AmazonColors.textPrimary, fontWeight: FontWeight.w400, height: 1.3)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: Text('by ${p.brand}', style: const TextStyle(fontSize: 13, color: Color(0xFF007185))),
            ),
            // Rating
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: _StarRating(rating: p.rating, reviews: p.reviews),
            ),
            // Price
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AmazonColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (p.originalPrice != null) ...[
                    Row(
                      children: [
                        Text(
                          'M.R.P.: ₹${p.originalPrice!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AmazonColors.textSecondary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: AmazonColors.red, borderRadius: BorderRadius.circular(4)),
                          child: Text('-${p.discountPercent}%', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                  Row(
                    children: [
                      const Text('Deal Price: ', style: TextStyle(fontSize: 14, color: AmazonColors.textSecondary)),
                      Text(
                        '₹${p.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AmazonColors.red),
                      ),
                    ],
                  ),
                  if (p.isPrime) ...[
                    const SizedBox(height: 6),
                    const Row(
                      children: [
                        Text('prime', style: TextStyle(color: AmazonColors.prime, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 14)),
                        SizedBox(width: 6),
                        Text('FREE delivery', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                  const SizedBox(height: 4),
                  const Text('✅  In Stock', style: TextStyle(color: AmazonColors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
            ),
            // About
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('About this item', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AmazonColors.textPrimary)),
                  const SizedBox(height: 8),
                  ...[
                    'Industry-leading noise cancellation technology',
                    'Up to 30 hours battery life with quick charge',
                    'Touch controls and voice assistant support',
                    'Foldable design for easy portability',
                    'Multipoint connection – connect to 2 devices at once',
                  ].map((point) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 13, color: AmazonColors.textSecondary)),
                        Expanded(child: Text(point, style: const TextStyle(fontSize: 13, color: AmazonColors.textSecondary, height: 1.4))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, -2))],
        ),
        child: Row(
          children: [
            // Buy Now
            Expanded(
              child: GestureDetector(
                onTap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(_)=> PaymentPage(total:p.price),
                    ),
                  );
                },
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA41C),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFe0921b), width: 0.5),
                  ),
                  child: const Center(
                    child: Text('Proceed to pay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AmazonColors.textPrimary)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Add to Cart
            Expanded(
              child: GestureDetector(
                onTap: () {
                  widget.onAddToCart(p);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD814),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFc9a800), width: 0.5),
                  ),
                  child: const Center(
                    child: Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AmazonColors.textPrimary)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Search Page ──────────────────────────────────────────────────────────────

class SearchPage extends StatefulWidget {
  final ValueChanged<Product> onAddToCart;

  const SearchPage({
    super.key,
    required this.onAddToCart,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  List<Product> _results = [];
  bool _searched = false;

  void _search(String query) {
    final q = query.toLowerCase().trim();
    setState(() {
      _searched = true;
      _results = q.isEmpty
          ? []
          : sampleProducts
              .where((p) =>
                  p.title.toLowerCase().contains(q) ||
                  p.brand.toLowerCase().contains(q) ||
                  p.category.toLowerCase().contains(q))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AmazonColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AmazonColors.background,
        title: Container(
          height: 38,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
          child: TextField(
            controller: _controller,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Search Amazon.in',
              hintStyle: const TextStyle(color: AmazonColors.textSecondary, fontSize: 14),
              prefixIcon: const Icon(Icons.search, color: AmazonColors.textSecondary, size: 20),
              suffixIcon: _controller.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        _controller.clear();
                        setState(() { _results = []; _searched = false; });
                      },
                      child: const Icon(Icons.close, size: 18, color: AmazonColors.textSecondary),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onSubmitted: _search,
            onChanged: (v) => setState(() {}),
          ),
        ),
      ),
      body: !_searched
          ? _SearchSuggestions(onSelect: (q) {
              _controller.text = q;
              _search(q);
            })
          : _results.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🔍', style: TextStyle(fontSize: 48)),
                      SizedBox(height: 16),
                      Text('No results found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AmazonColors.textPrimary)),
                      SizedBox(height: 8),
                      Text('Try different keywords', style: TextStyle(color: AmazonColors.textSecondary)),
                    ],
                  ),
                )
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('${_results.length} results for "${_controller.text}"',
                          style: const TextStyle(fontSize: 13, color: AmazonColors.textSecondary)),
                    ),
                    ..._results.map((p) => _SearchResultTile(
                      product: p,
                      onAddToCart: widget.onAddToCart,
                    )),
                  ],
                ),
    );
  }
}

class _SearchSuggestions extends StatelessWidget {
  final ValueChanged<String> onSelect;
  const _SearchSuggestions({required this.onSelect});

  static const _popular = ['Sony headphones', 'iPhone 15', 'Air fryer', 'Kindle', 'Nike shoes', 'LEGO sets', 'Samsung TV', 'Instant Pot'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text('Popular Searches', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AmazonColors.textPrimary)),
        ),
        ..._popular.map((q) => ListTile(
          leading: const Icon(Icons.trending_up, color: AmazonColors.accent),
          title: Text(q, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.north_west, size: 16, color: AmazonColors.textSecondary),
          onTap: () => onSelect(q),
        )),
      ],
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onAddToCart;
  const _SearchResultTile({
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AmazonColors.divider),
              ),
              child: Center(child: Text(product.imageEmoji, style: const TextStyle(fontSize: 48))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, color: AmazonColors.textPrimary, height: 1.3)),
                  const SizedBox(height: 4),
                  _StarRating(rating: product.rating, reviews: product.reviews, small: true),
                  const SizedBox(height: 4),
                  Text('₹${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  if (product.originalPrice != null)
                    Text('M.R.P.: ₹${product.originalPrice!.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 11, color: AmazonColors.textSecondary, decoration: TextDecoration.lineThrough)),
                  if (product.isPrime)
                    const Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text('prime  FREE Delivery',
                          style: TextStyle(color: AmazonColors.prime, fontSize: 11, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => onAddToCart(product),
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD814),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(child: Text('Add to Cart', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        child: Icon(
                          Icons.shopping_cart,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Cart Page ────────────────────────────────────────────────────────────────

class CartPage extends StatelessWidget {
  final List<CartItem> cart;
  final double total;
  final void Function(CartItem, int) onQuantityChange;

  const CartPage({
    super.key,
    required this.cart,
    required this.total,
    required this.onQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AmazonColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AmazonColors.background,
        title: Text(
          'Shopping Cart (${cart.length})',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🛒', style: TextStyle(fontSize: 72)),
                  const SizedBox(height: 16),
                  const Text('Your cart is empty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Add items to get started', style: TextStyle(color: AmazonColors.textSecondary)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AmazonColors.accent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Continue Shopping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Order summary
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:', style: TextStyle(fontSize: 16)),
                          Text(
                            '₹${total.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: AmazonColors.green, size: 16),
                          SizedBox(width: 4),
                          Text('Your order is eligible for FREE delivery', style: TextStyle(color: AmazonColors.green, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD814),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFc9a800), width: 0.5),
                          ),
                          child: const Center(
                            child: Text('Proceed to Buy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Cart items
                Expanded(
                  child: ListView.separated(
                    itemCount: cart.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return _CartItemTile(item: item, onQuantityChange: onQuantityChange);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final void Function(CartItem, int) onQuantityChange;

  const _CartItemTile({required this.item, required this.onQuantityChange});

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AmazonColors.divider),
            ),
            child: Center(child: Text(p.imageEmoji, style: const TextStyle(fontSize: 44))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: AmazonColors.textPrimary)),
                const SizedBox(height: 4),
                Text('₹${p.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AmazonColors.red)),
                if (p.isPrime)
                  const Text('prime  FREE Delivery',
                      style: TextStyle(color: AmazonColors.prime, fontSize: 11, fontStyle: FontStyle.italic)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Quantity controls
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AmazonColors.divider),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => onQuantityChange(item, -1),
                            child: Container(
                              width: 32,
                              height: 32,
                              child: const Icon(Icons.remove, size: 16),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            color: const Color(0xFFF7F7F7),
                            child: Center(
                              child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => onQuantityChange(item, 1),
                            child: Container(
                              width: 32,
                              height: 32,
                              child: const Icon(Icons.add, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => onQuantityChange(item, -item.quantity),
                      child: const Text('Delete', style: TextStyle(color: Color(0xFF007185), fontSize: 13)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Account Page ─────────────────────────────────────────────────────────────

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AmazonColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AmazonColors.background,
        title: const Text('Your Account', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          // Profile header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AmazonColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Text('👤', style: TextStyle(fontSize: 28))),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hello, Rohan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text('rohan@example.com', style: TextStyle(color: AmazonColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Prime card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF232F3E), Color(0xFF0F1111)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Text('prime', style: TextStyle(color: Color(0xFF00A8E1), fontSize: 22, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Prime Membership', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text('FREE delivery, exclusive deals & more', style: TextStyle(color: Colors.white60, fontSize: 11)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.white60),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _AccountSection(title: 'Orders', items: const [
            _AccountMenuItem(icon: Icons.shopping_bag_outlined, label: 'Your Orders', sub: 'Track, return or buy again'),
            _AccountMenuItem(icon: Icons.location_on_outlined, label: 'Your Addresses', sub: 'Saved delivery addresses'),
            _AccountMenuItem(icon: Icons.payment_outlined, label: 'Payment Options', sub: 'Cards, UPI, wallets'),
          ]),
          const SizedBox(height: 8),
          _AccountSection(title: 'Settings', items: const [
            _AccountMenuItem(icon: Icons.notifications_outlined, label: 'Notifications', sub: 'Deals, orders & updates'),
            _AccountMenuItem(icon: Icons.privacy_tip_outlined, label: 'Privacy Settings', sub: 'Manage your data'),
            _AccountMenuItem(icon: Icons.help_outline, label: 'Help & Support', sub: 'FAQs, contact us'),
            _AccountMenuItem(icon: Icons.logout, label: 'Sign Out', sub: ''),
          ]),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _AccountSection extends StatelessWidget {
  final String title;
  final List<_AccountMenuItem> items;

  const _AccountSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AmazonColors.textSecondary)),
          ),
          ...items.map((item) => Column(
            children: [
              ListTile(
                leading: Icon(item.icon, color: AmazonColors.textPrimary, size: 22),
                title: Text(item.label, style: const TextStyle(fontSize: 14, color: AmazonColors.textPrimary)),
                subtitle: item.sub.isNotEmpty ? Text(item.sub, style: const TextStyle(fontSize: 11)) : null,
                trailing: const Icon(Icons.chevron_right, color: AmazonColors.textSecondary, size: 20),
                dense: true,
                onTap: () {},
              ),
              const Divider(height: 1, indent: 56),
            ],
          )),
        ],
      ),
    );
  }
}

class _AccountMenuItem {
  final IconData icon;
  final String label;
  final String sub;
  const _AccountMenuItem({required this.icon, required this.label, required this.sub});
}
class PaymentPage extends StatelessWidget {
  final double total;

  const PaymentPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: AmazonColors.background,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Text(
            "Total Amount",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),

          const SizedBox(height: 8),

          Text(
            "₹${total.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),

          ListTile(
            leading: Icon(Icons.qr_code),
            title: Text("UPI Payment"),
          ),

          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Credit / Debit Card"),
          ),

          ListTile(
            leading: Icon(Icons.money),
            title: Text("Cash on Delivery"),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "Pay Now",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final int cartCount;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.currentIndex,
    required this.cartCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const Icon(Icons.shopping_cart),
              if (cartCount > 0)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
    );
  }
}