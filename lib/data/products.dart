import '../models/product.dart';

const List<Product> allProducts = <Product>[
  // ─────────────────────────────────────────────
  // КАВА
  // ─────────────────────────────────────────────

  Product(
    id: 'espresso_110',
    name: 'Еспресо',
    description: 'Насичений та інтенсивний смак справжнього еспресо.',
    price: 50,
    imagePath: 'assets/images/espresso_110.jpg',
    category: ProductCategory.coffee,
    volume: '110 мл',
    isPopular: true,
  ),

  Product(
    id: 'espresso_lungo_185',
    name: 'Еспресо Лунго',
    description: 'Більш мʼякий смак завдяки більшій кількості води.',
    price: 55,
    imagePath: 'assets/images/espresso_lungo_185.jpg',
    category: ProductCategory.coffee,
    volume: '185 мл',
  ),

  Product(
    id: 'doppio_185',
    name: 'Допіо',
    description: 'Подвійний еспресо для справжніх поціновувачів кави.',
    price: 65,
    imagePath: 'assets/images/doppio_185.jpg',
    category: ProductCategory.coffee,
    volume: '185 мл',
    isPopular: true,
  ),

  Product(
    id: 'americano_185',
    name: 'Американо',
    description: 'Класичний еспресо з додаванням гарячої води.',
    price: 55,
    imagePath: 'assets/images/americano_185.jpg',
    category: ProductCategory.coffee,
    volume: '185 мл',
  ),

  Product(
    id: 'americano_250',
    name: 'Американо',
    description: 'Велика порція класичного американо.',
    price: 65,
    imagePath: 'assets/images/americano_250.jpg',
    category: ProductCategory.coffee,
    volume: '250 мл',
  ),

  Product(
    id: 'americano_doppio_250',
    name: 'Американо Допіо',
    description: 'Американо на основі подвійної порції еспресо.',
    price: 75,
    imagePath: 'assets/images/americano_doppio_250.jpg',
    category: ProductCategory.coffee,
    volume: '250 мл',
  ),

  Product(
    id: 'americano_milk_185',
    name: 'Американо з молоком',
    description: 'Американо з додаванням ніжного молока.',
    price: 65,
    imagePath: 'assets/images/americano_milk_185.jpg',
    category: ProductCategory.coffee,
    volume: '185 мл',
  ),

  Product(
    id: 'americano_milk_250',
    name: 'Американо з молоком',
    description: 'Велика порція американо з молоком.',
    price: 75,
    imagePath: 'assets/images/americano_milk_250.jpg',
    category: ProductCategory.coffee,
    volume: '250 мл',
  ),

  Product(
    id: 'americano_milk_doppio_250',
    name: 'Американо з молоком Допіо',
    description: 'Подвійний еспресо, гаряча вода та молоко.',
    price: 85,
    imagePath: 'assets/images/americano_milk_doppio_250.jpg',
    category: ProductCategory.coffee,
    volume: '250 мл',
  ),

  Product(
    id: 'cappuccino_250',
    name: 'Капучино',
    description: 'Класичний капучино з ніжною молочною пінкою.',
    price: 75,
    imagePath: 'assets/images/cappuccino_250.jpg',
    category: ProductCategory.coffee,
    volume: '250 мл',
    isPopular: true,
  ),

  Product(
    id: 'cappuccino_430',
    name: 'Капучино',
    description: 'Велика порція улюбленого капучино.',
    price: 95,
    imagePath: 'assets/images/cappuccino_430.jpg',
    category: ProductCategory.coffee,
    volume: '430 мл',
  ),

  Product(
    id: 'cappuccino_pine_nuts_250',
    name: 'Капучино з кедровими горішками',
    description: 'Капучино з ароматними кедровими горішками.',
    price: 95,
    imagePath: 'assets/images/cappuccino_pine_nuts_250.jpg',
    category: ProductCategory.coffee,
    volume: '250 мл',
  ),

  Product(
    id: 'cappuccino_pine_nuts_430',
    name: 'Капучино з кедровими горішками',
    description: 'Великий капучино з кедровими горішками.',
    price: 115,
    imagePath: 'assets/images/cappuccino_pine_nuts_430.jpg',
    category: ProductCategory.coffee,
    volume: '430 мл',
    isPopular: true,
  ),

  Product(
    id: 'latte_330',
    name: 'Лате',
    description: 'Ніжний еспресо з молоком та молочною піною.',
    price: 85,
    imagePath: 'assets/images/latte_330.jpg',
    category: ProductCategory.coffee,
    volume: '330 мл',
    isPopular: true,
  ),

  Product(
    id: 'latte_430',
    name: 'Лате',
    description: 'Велика порція ніжного молочного лате.',
    price: 100,
    imagePath: 'assets/images/latte_430.jpg',
    category: ProductCategory.coffee,
    volume: '430 мл',
  ),

  Product(
    id: 'latte_almond_330',
    name: 'Лате з мигдалем',
    description: 'Лате з ніжними мигдалевими пластівцями.',
    price: 100,
    imagePath: 'assets/images/latte_almond_330.jpg',
    category: ProductCategory.coffee,
    volume: '330 мл',
  ),

  Product(
    id: 'latte_almond_430',
    name: 'Лате з мигдалем',
    description: 'Великий лате з мигдалевими пластівцями.',
    price: 115,
    imagePath: 'assets/images/latte_almond_430.jpg',
    category: ProductCategory.coffee,
    volume: '430 мл',
  ),

  Product(
    id: 'raf_250',
    name: 'Раф',
    description: 'Ніжний кавовий напій з вершками та ваніллю.',
    price: 105,
    imagePath: 'assets/images/raf_250.jpg',
    category: ProductCategory.coffee,
    volume: '250 мл',
    isPopular: true,
  ),

  Product(
    id: 'raf_430',
    name: 'Раф',
    description: 'Велика порція вершкового ванільного рафу.',
    price: 125,
    imagePath: 'assets/images/raf_430.jpg',
    category: ProductCategory.coffee,
    volume: '430 мл',
  ),

  Product(
    id: 'coffee_vienna_250',
    name: 'Кава по-віденськи',
    description: 'Класична кава з ніжною вершковою шапкою.',
    price: 95,
    imagePath: 'assets/images/coffee_vienna_250.jpg',
    category: ProductCategory.coffee,
    volume: '250 мл',
  ),

  Product(
    id: 'capuorange_250',
    name: 'Капуоранж',
    description: 'Поєднання еспресо та свіжого апельсинового соку.',
    price: 110,
    imagePath: 'assets/images/capuorange_250.jpg',
    category: ProductCategory.coffee,
    volume: '250 мл',
  ),

  // ─────────────────────────────────────────────
  // МАТЧА
  // ─────────────────────────────────────────────

  Product(
    id: 'matcha_latte_330',
    name: 'Матча Лате',
    description: 'Ніжний молочний напій з японською матчею.',
    price: 110,
    imagePath: 'assets/images/matcha_latte_330.jpg',
    category: ProductCategory.matcha,
    volume: '330 мл',
    isPopular: true,
  ),

  Product(
    id: 'matcha_latte_430',
    name: 'Матча Лате',
    description: 'Велика порція молочного напою з матчею.',
    price: 130,
    imagePath: 'assets/images/matcha_latte_430.jpg',
    category: ProductCategory.matcha,
    volume: '430 мл',
  ),

  Product(
    id: 'ice_matcha_latte_400',
    name: 'Айс Матча Лате',
    description: 'Холодне молоко, японська матча та кубики льоду.',
    price: 125,
    imagePath: 'assets/images/ice_matcha_latte_400.jpg',
    category: ProductCategory.matcha,
    volume: '400 мл',
    isPopular: true,
  ),

  // ─────────────────────────────────────────────
  // ХОЛОДНІ НАПОЇ
  // ─────────────────────────────────────────────

  Product(
    id: 'ice_latte_400',
    name: 'Айс Лате',
    description: 'Допіо, холодне молоко та кубики льоду.',
    price: 110,
    imagePath: 'assets/images/ice_latte.jpg',
    category: ProductCategory.coldDrinks,
    volume: '400 мл',
    isPopular: true,
  ),

  Product(
    id: 'ice_raf_400',
    name: 'Айс Раф',
    description: 'Холодний вершковий раф з ваніллю та льодом.',
    price: 130,
    imagePath: 'assets/images/ice_raf.jpg',
    category: ProductCategory.coldDrinks,
    volume: '400 мл',
  ),

  Product(
    id: 'dzhmil_400',
    name: 'Джміль',
    description: 'Кава, апельсиновий сік та карамельний сироп.',
    price: 120,
    imagePath: 'assets/images/dzhmil.jpg',
    category: ProductCategory.coldDrinks,
    volume: '400 мл',
    isPopular: true,
  ),

  Product(
    id: 'frappe_400',
    name: 'Фрапе',
    description: 'Кава, молоко, морозиво та кубики льоду.',
    price: 115,
    imagePath: 'assets/images/frappe.jpg',
    category: ProductCategory.coldDrinks,
    volume: '400 мл',
  ),

  Product(
    id: 'frappe_chocolate_400',
    name: 'Фрапе шоколадний',
    description: 'Фрапе з шоколадним сиропом та топінгом.',
    price: 130,
    imagePath: 'assets/images/frappe_chocolate.jpg',
    category: ProductCategory.coldDrinks,
    volume: '400 мл',
    isPopular: true,
  ),

  Product(
    id: 'frappe_caramel_400',
    name: 'Фрапе карамельний',
    description: 'Фрапе з карамельним сиропом та топінгом.',
    price: 130,
    imagePath: 'assets/images/frappe_caramel.jpg',
    category: ProductCategory.coldDrinks,
    volume: '400 мл',
  ),

  Product(
    id: 'coffee_tonic_400',
    name: 'Кава-Тонік',
    description: 'Еспресо, тонік, вода та кубики льоду.',
    price: 110,
    imagePath: 'assets/images/coffee_tonic.jpg',
    category: ProductCategory.coldDrinks,
    volume: '400 мл',
  ),

  Product(
    id: 'coffee_tonic_doppio_400',
    name: 'Кава-Тонік Допіо',
    description: 'Подвійний еспресо, тонік та кубики льоду.',
    price: 125,
    imagePath: 'assets/images/coffee_tonic_doppio.jpg',
    category: ProductCategory.coldDrinks,
    volume: '400 мл',
  ),

  // ─────────────────────────────────────────────
  // СМУЗІ
  // ─────────────────────────────────────────────

  Product(
    id: 'smoothie_mango',
    name: 'Смузі Манговий',
    description: 'Ніжний тропічний смузі з манго.',
    price: 125,
    imagePath: 'assets/images/smoothie_mango.jpg',
    category: ProductCategory.smoothies,
    volume: '400 мл',
    isPopular: true,
  ),

  Product(
    id: 'smoothie_strawberry',
    name: 'Смузі Полуничний',
    description: 'Яскравий смузі зі свіжої полуниці.',
    price: 125,
    imagePath: 'assets/images/smoothie_strawberry.jpg',
    category: ProductCategory.smoothies,
    volume: '400 мл',
  ),

  Product(
    id: 'smoothie_strawberry_banana',
    name: 'Смузі Полунично-Банановий',
    description: 'Ніжне поєднання полуниці та банана.',
    price: 130,
    imagePath: 'assets/images/smoothie_strawberry_banana.jpg',
    category: ProductCategory.smoothies,
    volume: '400 мл',
    isPopular: true,
  ),

  // ─────────────────────────────────────────────
  // ЧАЙ
  // ─────────────────────────────────────────────

  Product(
    id: 'tea_brewed_330',
    name: 'Чай заварний',
    description: 'Чорний, зелений, бергамот, альпійський луг або мʼята.',
    price: 65,
    imagePath: 'assets/images/tea_brewed_330.jpg',
    category: ProductCategory.tea,
    volume: '330 мл',
  ),

  Product(
    id: 'tea_brewed_430',
    name: 'Чай заварний',
    description: 'Велика порція ароматного заварного чаю.',
    price: 75,
    imagePath: 'assets/images/tea_brewed_430.jpg',
    category: ProductCategory.tea,
    volume: '430 мл',
  ),

  Product(
    id: 'tea_berry_pie_330',
    name: 'Чай Ягідний пиріг',
    description: 'Авторський напій з насиченим ягідним смаком.',
    price: 80,
    imagePath: 'assets/images/tea_berry_pie_330.jpg',
    category: ProductCategory.tea,
    volume: '330 мл',
    isPopular: true,
  ),

  Product(
    id: 'tea_berry_pie_430',
    name: 'Чай Ягідний пиріг',
    description: 'Велика порція ароматного ягідного чаю.',
    price: 90,
    imagePath: 'assets/images/tea_berry_pie_430.jpg',
    category: ProductCategory.tea,
    volume: '430 мл',
  ),

  // ─────────────────────────────────────────────
  // МАКАРУНИ
  // ─────────────────────────────────────────────

  Product(
    id: 'macaron_vanilla',
    name: 'Макарун Ваніль',
    description: 'Білий шоколад, натуральна ваніль та конфітюр лохини.',
    price: 65,
    imagePath: 'assets/images/macaron_vanilla.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_brownie',
    name: 'Макарун Брауні',
    description: 'Ганаш на чорному шоколаді та шматочки брауні.',
    price: 65,
    imagePath: 'assets/images/macaron_brownie.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_pistachio_raspberry',
    name: 'Макарун Фісташка-Малина',
    description: 'Фісташковий ганаш та малиновий конфітюр.',
    price: 65,
    imagePath: 'assets/images/macaron_pistachio_raspberry.jpg',
    category: ProductCategory.macarons,
    isPopular: true,
  ),

  Product(
    id: 'macaron_lime_lemon',
    name: 'Макарун Лайм-Лимон',
    description: 'Цедра, сік лайма та лимонний смак.',
    price: 65,
    imagePath: 'assets/images/macaron_lime_lemon.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_basil_blackcurrant',
    name: 'Макарун Базилік-Смородина',
    description: 'Білий шоколад, базилік та чорна смородина.',
    price: 65,
    imagePath: 'assets/images/macaron_basil_blackcurrant.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_lavender_blackcurrant',
    name: 'Макарун Лаванда-Смородина',
    description: 'Білий шоколад, лаванда та чорна смородина.',
    price: 65,
    imagePath: 'assets/images/macaron_lavender_blackcurrant.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_latte_caramel_cheesecake',
    name: 'Макарун Лате-Карамель',
    description: 'Кавовий ганаш та карамельний крем-сир.',
    price: 65,
    imagePath: 'assets/images/macaron_latte_caramel_cheesecake.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_mint_strawberry',
    name: 'Макарун Мʼята-Полуниця',
    description: 'Білий шоколад, мʼята та полуничний конфітюр.',
    price: 65,
    imagePath: 'assets/images/macaron_mint_strawberry.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_rose_cranberry',
    name: 'Макарун Троянда-Журавлина',
    description: 'Біла шоколадна начинка, троянда та журавлина.',
    price: 65,
    imagePath: 'assets/images/macaron_rose_cranberry.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_raspberry_cheesecake',
    name: 'Макарун Малина-Чізкейк',
    description: 'Малина та ніжний вершковий чізкейк.',
    price: 65,
    imagePath: 'assets/images/macaron_raspberry_cheesecake.jpg',
    category: ProductCategory.macarons,
    isPopular: true,
  ),

  Product(
    id: 'macaron_banana_strawberry',
    name: 'Макарун Банан-Полуниця',
    description: 'Бананове пюре та полуничний конфітюр.',
    price: 65,
    imagePath: 'assets/images/macaron_banana_strawberry.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_aperol_strawberry',
    name: 'Макарун Апероль-Полуниця',
    description: 'Апероль, апельсин та полуничний конфітюр.',
    price: 65,
    imagePath: 'assets/images/macaron_aperol_strawberry.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_yogurt_passionfruit',
    name: 'Макарун Йогурт-Маракуя',
    description: 'Йогуртовий ганаш та конфітюр маракуї.',
    price: 65,
    imagePath: 'assets/images/macaron_yogurt_passionfruit.jpg',
    category: ProductCategory.macarons,
  ),

  Product(
    id: 'macaron_mango_passionfruit',
    name: 'Макарун Манго-Маракуя',
    description: 'Пюре манго та тропічної маракуї.',
    price: 65,
    imagePath: 'assets/images/macaron_mango_passionfruit.jpg',
    category: ProductCategory.macarons,
    isPopular: true,
  ),

  Product(
    id: 'macaron_raffaello',
    name: 'Макарун Рафаелло',
    description: 'Кокосовий ганаш та ніжний мигдальний крем.',
    price: 65,
    imagePath: 'assets/images/macaron_raffaello.jpg',
    category: ProductCategory.macarons,
    isPopular: true,
  ),
];