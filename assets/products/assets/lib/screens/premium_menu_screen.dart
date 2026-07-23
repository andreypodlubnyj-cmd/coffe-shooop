
import 'dart:ui';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String volume;
  final String category;
  final String image;
  final String description;
  final List<String> ingredients;

  const Product({
    required this.id,
    required this.name,
    required this.volume,
    required this.category,
    required this.image,
    required this.description,
    required this.ingredients,
  });
}

const products = <Product>[
  Product(id:'espresso',name:'Еспресо',volume:'110 мл',category:'Кава',image:'assets/products/espresso.jpg',description:'Насичений та інтенсивний смак справжнього еспресо.',ingredients:['Кава','Вода']),
  Product(id:'lungo',name:'Еспресо лунго',volume:'185 мл',category:'Кава',image:'assets/products/lungo.jpg',description:'М’якший смак завдяки більшій кількості води.',ingredients:['Еспресо','Вода']),
  Product(id:'doppio',name:'Doppio',volume:'185 мл',category:'Кава',image:'assets/products/doppio.jpg',description:'Подвійний еспресо для поціновувачів міцної кави.',ingredients:['Подвійна порція еспресо','Вода']),
  Product(id:'americano185',name:'Американо',volume:'185 мл',category:'Кава',image:'assets/products/americano_185.jpg',description:'Класичний американо з насиченим збалансованим смаком.',ingredients:['Еспресо','Гаряча вода']),
  Product(id:'americano250',name:'Американо',volume:'250 мл',category:'Кава',image:'assets/products/americano_250.jpg',description:'Збільшена порція класичного американо.',ingredients:['Еспресо','Гаряча вода']),
  Product(id:'americanodoppio',name:'Американо Doppio',volume:'250 мл',category:'Кава',image:'assets/products/americano_doppio.jpg',description:'Міцний американо з подвійною порцією еспресо.',ingredients:['Подвійна порція еспресо','Гаряча вода']),
  Product(id:'americanomilk185',name:'Американо з молоком',volume:'185 мл',category:'Кава',image:'assets/products/americano_milk_185.jpg',description:'Американо, пом’якшений теплою порцією молока.',ingredients:['Еспресо','Гаряча вода','Молоко']),
  Product(id:'americanomilk250',name:'Американо з молоком',volume:'250 мл',category:'Кава',image:'assets/products/americano_milk_250.jpg',description:'Велика порція м’якого американо з молоком.',ingredients:['Еспресо','Гаряча вода','Молоко']),
  Product(id:'americanomilkdoppio',name:'Американо з молоком Doppio',volume:'250 мл',category:'Кава',image:'assets/products/americano_milk_doppio.jpg',description:'Подвійний еспресо з водою та молоком.',ingredients:['Подвійна порція еспресо','Гаряча вода','Молоко']),
  Product(id:'latte330',name:'Лате',volume:'330 мл',category:'Кава',image:'assets/products/latte_330.jpg',description:'Ніжний еспресо з молоком і м’якою молочною пінкою.',ingredients:['Еспресо','Молоко','Молочна пінка']),
  Product(id:'latte430',name:'Лате',volume:'430 мл',category:'Кава',image:'assets/products/latte_430.jpg',description:'Велика порція ніжного лате для тривалої насолоди.',ingredients:['Еспресо','Молоко','Молочна пінка']),
  Product(id:'lattealmond330',name:'Лате з мигдалем',volume:'330 мл',category:'Кава',image:'assets/products/latte_almond_330.jpg',description:'Ніжне лате з ароматними мигдальними пластівцями.',ingredients:['Еспресо','Молоко','Молочна пінка','Мигдальні пластівці']),
  Product(id:'lattealmond430',name:'Лате з мигдалем',volume:'430 мл',category:'Кава',image:'assets/products/latte_almond_430.jpg',description:'Велика порція вершкового лате з мигдалем.',ingredients:['Еспресо','Молоко','Молочна пінка','Мигдальні пластівці']),
  Product(id:'cap250',name:'Капучино',volume:'250 мл',category:'Кава',image:'assets/products/cappuccino_250.jpg',description:'Класичний капучино з ніжною молочною пінкою.',ingredients:['Еспресо','Молоко','Молочна пінка']),
  Product(id:'cap430',name:'Капучино',volume:'430 мл',category:'Кава',image:'assets/products/cappuccino_430.jpg',description:'Більша порція улюбленого капучино.',ingredients:['Еспресо','Молоко','Молочна пінка']),
  Product(id:'capnuts250',name:'Капучино з кедровими горішками',volume:'250 мл',category:'Кава',image:'assets/products/cappuccino_nuts_250.jpg',description:'Капучино з ароматними кедровими горішками.',ingredients:['Еспресо','Молоко','Молочна пінка','Кедрові горішки']),
  Product(id:'capnuts430',name:'Капучино з кедровими горішками',volume:'430 мл',category:'Кава',image:'assets/products/cappuccino_nuts_430.jpg',description:'Великий капучино з кедровими горішками.',ingredients:['Еспресо','Молоко','Молочна пінка','Кедрові горішки']),
  Product(id:'raf250',name:'Раф',volume:'250 мл',category:'Кава',image:'assets/products/raf_250.jpg',description:'Ніжний кавовий напій із вершками та ваніллю.',ingredients:['Еспресо','Вершки','Ванільний цукор']),
  Product(id:'raf430',name:'Раф',volume:'430 мл',category:'Кава',image:'assets/products/raf_430.jpg',description:'Велика порція вершкового рафу.',ingredients:['Еспресо','Вершки','Ванільний цукор']),
  Product(id:'viennese',name:'Кава по-віденськи',volume:'250 мл',category:'Кава',image:'assets/products/viennese.jpg',description:'Класична кава з ніжною вершковою шапкою.',ingredients:['Еспресо','Гаряча вода','Збиті вершки']),
  Product(id:'capuorange',name:'Капуоранж',volume:'250 мл',category:'Кава',image:'assets/products/capuorange.jpg',description:'Поєднання еспресо та апельсинового соку.',ingredients:['Еспресо','Апельсиновий сік']),
  Product(id:'frappe',name:'Фрапе',volume:'400 мл',category:'Холодні',image:'assets/products/frappe.jpg',description:'Холодний кавовий напій із морозивом.',ingredients:['Кава','Молоко','Морозиво','Лід']),
  Product(id:'frappechoc',name:'Фрапе шоколадний',volume:'400 мл',category:'Холодні',image:'assets/products/frappe_chocolate.jpg',description:'Вершковий фрапе з шоколадним смаком.',ingredients:['Кавовий фрапе','Шоколадний топінг','Шоколадний сироп','Лід']),
  Product(id:'frappecaramel',name:'Фрапе карамельний',volume:'400 мл',category:'Холодні',image:'assets/products/frappe_caramel.jpg',description:'Холодний кавовий фрапе з карамеллю.',ingredients:['Кавовий фрапе','Карамельний топінг','Карамельний сироп','Лід']),
  Product(id:'tonic',name:'Кофе-тонік',volume:'400 мл',category:'Холодні',image:'assets/products/coffee_tonic.jpg',description:'Освіжаючий тонік із насиченим еспресо.',ingredients:['Еспресо','Тонік','Лід']),
  Product(id:'tonicdoppio',name:'Кофе-тонік Doppio',volume:'400 мл',category:'Холодні',image:'assets/products/coffee_tonic_doppio.jpg',description:'Кофе-тонік з подвійним еспресо.',ingredients:['Подвійний еспресо','Тонік','Лід']),
  Product(id:'jmil',name:'Джміль',volume:'400 мл',category:'Холодні',image:'assets/products/jmil.jpg',description:'Кава, апельсиновий сік і карамель.',ingredients:['Подвійний еспресо','Апельсиновий сік','Карамельний сироп','Лід']),
  Product(id:'icelatte',name:'Айс лате',volume:'400 мл',category:'Холодні',image:'assets/products/ice_latte.jpg',description:'Холодне молочне лате з еспресо.',ingredients:['Подвійний еспресо','Молоко','Лід']),
  Product(id:'iceraf',name:'Айс раф',volume:'400 мл',category:'Холодні',image:'assets/products/ice_raf.jpg',description:'Холодний раф із вершками та ваніллю.',ingredients:['Подвійний еспресо','Вершки','Молоко','Ванільний цукор','Лід']),
  Product(id:'matcha330',name:'Матча лате',volume:'330 мл',category:'Матча',image:'assets/products/matcha_latte_330.jpg',description:'Ніжний молочний напій із матча.',ingredients:['Матча','Молоко']),
  Product(id:'matcha430',name:'Матча лате',volume:'430 мл',category:'Матча',image:'assets/products/matcha_latte_430.jpg',description:'Велика порція вершкового матча лате.',ingredients:['Матча','Молоко']),
  Product(id:'icematcha',name:'Айс матча лате',volume:'400 мл',category:'Матча',image:'assets/products/ice_matcha_latte.jpg',description:'Освіжаючий молочний напій з льодом.',ingredients:['Матча','Молоко','Лід']),
  Product(id:'tea330',name:'Чай заварний',volume:'330 мл',category:'Чай',image:'assets/products/tea_330.jpg',description:'Ароматний листовий чай на вибір.',ingredients:['Чай на вибір','Гаряча вода']),
  Product(id:'tea430',name:'Чай заварний',volume:'430 мл',category:'Чай',image:'assets/products/tea_430.jpg',description:'Велика порція ароматного листового чаю.',ingredients:['Чай на вибір','Гаряча вода']),
  Product(id:'berry330',name:'Чай ягідний пиріг',volume:'330 мл',category:'Чай',image:'assets/products/berry_tea_330.jpg',description:'Насичений ягідний чай.',ingredients:['Ягідна суміш','Чайна основа','Гаряча вода']),
  Product(id:'berry430',name:'Чай ягідний пиріг',volume:'430 мл',category:'Чай',image:'assets/products/berry_tea_430.jpg',description:'Велика порція ароматного ягідного чаю.',ingredients:['Ягідна суміш','Чайна основа','Гаряча вода']),
  Product(id:'mango',name:'Смузі манговий',volume:'400 мл',category:'Смузі',image:'assets/products/smoothie_mango.jpg',description:'Ніжний тропічний смузі з манго.',ingredients:['Манго','Фруктова основа','Лід']),
  Product(id:'strawberry',name:'Смузі полуничний',volume:'400 мл',category:'Смузі',image:'assets/products/smoothie_strawberry.jpg',description:'Яскравий смузі зі стиглої полуниці.',ingredients:['Полуниця','Фруктова основа','Лід']),
  Product(id:'strawberrybanana',name:'Смузі полунично-банановий',volume:'400 мл',category:'Смузі',image:'assets/products/smoothie_strawberry_banana.jpg',description:'Поєднання банана та полуниці.',ingredients:['Полуниця','Банан','Фруктова основа','Лід']),
];

class PremiumMenuScreen extends StatefulWidget {
  const PremiumMenuScreen({super.key});
  @override
  State<PremiumMenuScreen> createState() => _PremiumMenuScreenState();
}

class _PremiumMenuScreenState extends State<PremiumMenuScreen> {
  String category = 'Усі';
  final Set<String> favorites = {};
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    final shown = category == 'Усі'
        ? products
        : products.where((p) => p.category == category).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _header()),
            SliverToBoxAdapter(child: _categories()),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverLayoutBuilder(
                builder: (context, c) {
                  final w = c.crossAxisExtent;
                  final cols = w >= 1200 ? 5 : w >= 900 ? 4 : w >= 620 ? 3 : 2;
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: .78,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _card(shown[i]),
                      childCount: shown.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() => Padding(
    padding: const EdgeInsets.fromLTRB(18, 16, 14, 10),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFF171717),
          child: Icon(Icons.coffee_rounded, color: Color(0xFFD4A45B)),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("JULIAM'S COFFEE", style: TextStyle(fontSize: 21,fontWeight: FontWeight.w800,letterSpacing: 1.4)),
              Text('Обирайте свій особливий смак', style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
        Badge(
          isLabelVisible: cartCount > 0,
          label: Text('$cartCount'),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ),
      ],
    ),
  );

  Widget _categories() {
    const cats = ['Усі','Кава','Холодні','Матча','Чай','Смузі'];
    return SizedBox(
      height: 58,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        separatorBuilder: (_,__) => const SizedBox(width: 8),
        itemBuilder: (_,i) {
          final selected = category == cats[i];
          return ChoiceChip(
            selected: selected,
            label: Text(cats[i]),
            onSelected: (_) => setState(() => category = cats[i]),
            selectedColor: const Color(0xFFD4A45B),
            backgroundColor: const Color(0xFF111111),
            labelStyle: TextStyle(color: selected ? Colors.black : Colors.white),
          );
        },
      ),
    );
  }

  Widget _card(Product p) => InkWell(
    borderRadius: BorderRadius.circular(22),
    onTap: () => _openProduct(p),
    child: Hero(
      tag: p.id,
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(p.image, fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xDD000000)],
                    stops: [.45,1],
                  ),
                ),
              ),
              Positioned(
                top: 10,right: 10,
                child: IconButton.filledTonal(
                  onPressed: () => setState(() {
                    favorites.contains(p.id) ? favorites.remove(p.id) : favorites.add(p.id);
                  }),
                  icon: Icon(favorites.contains(p.id) ? Icons.favorite : Icons.favorite_border,
                      color: favorites.contains(p.id) ? const Color(0xFFD4A45B) : Colors.white),
                ),
              ),
              Positioned(
                left: 16,right: 16,bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name.toUpperCase(),maxLines:2,overflow:TextOverflow.ellipsis,
                      style: const TextStyle(fontSize:18,fontWeight:FontWeight.w800,height:1.05)),
                    const SizedBox(height:8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal:12,vertical:6),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFD4A45B)),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black54,
                      ),
                      child: Text(p.volume,style:const TextStyle(color:Color(0xFFEAC582))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void _openProduct(Product p) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Закрити',
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 420),
      pageBuilder: (_,__,___) {
        final desktop = MediaQuery.sizeOf(context).width > 820;
        final image = Hero(tag:p.id,child:Image.asset(p.image,fit:BoxFit.cover));
        final panel = _panel(p);
        return Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth:1400,maxHeight:900),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: desktop
                          ? Row(children:[Expanded(flex:7,child:image),Expanded(flex:3,child:panel)])
                          : Column(children:[Expanded(flex:5,child:image),Expanded(flex:5,child:panel)]),
                      ),
                    ),
                  ),
                  Positioned(
                    left:12,top:12,
                    child: IconButton.filledTonal(
                      onPressed:()=>Navigator.pop(context),
                      icon:const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_,a,__,child) => FadeTransition(opacity:a,child:ScaleTransition(
        scale:Tween(begin:.97,end:1.0).animate(CurvedAnimation(parent:a,curve:Curves.easeOutCubic)),
        child:child,
      )),
    );
  }

  Widget _panel(Product p) => ClipRRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX:18,sigmaY:18),
      child: Container(
        color: const Color(0xF2111111),
        padding: const EdgeInsets.fromLTRB(24,30,24,22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name.toUpperCase(),style:const TextStyle(fontSize:30,fontWeight:FontWeight.w800)),
                    const SizedBox(height:14),
                    Container(width:80,height:2,color:const Color(0xFFD4A45B)),
                    const SizedBox(height:18),
                    Text(p.volume,style:const TextStyle(color:Color(0xFFEAC582),fontSize:18)),
                    const SizedBox(height:22),
                    Text(p.description,style:const TextStyle(color:Colors.white70,fontSize:16,height:1.5)),
                    const SizedBox(height:26),
                    const Text('СКЛАД',style:TextStyle(color:Color(0xFFD4A45B),fontWeight:FontWeight.w700,letterSpacing:1.2)),
                    const SizedBox(height:12),
                    ...p.ingredients.map((e)=>Padding(
                      padding:const EdgeInsets.only(bottom:10),
                      child:Row(children:[const Text('•  ',style:TextStyle(color:Color(0xFFD4A45B))),Expanded(child:Text(e,style:const TextStyle(color:Colors.white70)))]),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(
              width:double.infinity,height:56,
              child:FilledButton(
                onPressed:(){
                  setState(()=>cartCount++);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('${p.name} додано до кошика')));
                },
                style:FilledButton.styleFrom(backgroundColor:const Color(0xFFD4A45B),foregroundColor:Colors.black),
                child:const Text('ДОДАТИ В КОШИК',style:TextStyle(fontWeight:FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
