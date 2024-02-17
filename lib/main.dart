import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ExampleDragAndDrop(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

enum GarbageType { wet, dry, sanitary, ewaste }

List<Item> _items = [
  const Item(
    name: 'Aluminium can',
    totalPriceCents: 1299,
    uid: '1',
    imageProvider: AssetImage('assets/alum_can.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Band-Aids',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: AssetImage('assets/band_aids.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Burger',
    totalPriceCents: 1499,
    uid: '3',
    imageProvider: AssetImage('assets/burger.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Cardboard Box',
    totalPriceCents: 1499,
    uid: '4',
    imageProvider: AssetImage('assets/cardboard_box.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Charging Cable',
    totalPriceCents: 1499,
    uid: '5',
    imageProvider: AssetImage('assets/charging_cable.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Disposable Cup',
    totalPriceCents: 1499,
    uid: '6',
    imageProvider: AssetImage('assets/disposable_cup.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Egg Shells',
    totalPriceCents: 1499,
    uid: '7',
    imageProvider: AssetImage('assets/egg_shells.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Food Leftover',
    totalPriceCents: 1499,
    uid: '8',
    imageProvider: AssetImage('assets/food_leftover.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Fruit Scraps',
    totalPriceCents: 1499,
    uid: '9',
    imageProvider: AssetImage('assets/fruit_scraps.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Game Console',
    totalPriceCents: 1499,
    uid: '10',
    imageProvider: AssetImage('assets/game_console.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Keyboard',
    totalPriceCents: 1499,
    uid: '11',
    imageProvider: AssetImage('assets/keyboard.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Mask',
    totalPriceCents: 1499,
    uid: '12',
    imageProvider: AssetImage('assets/mask.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Mouse',
    totalPriceCents: 1499,
    uid: '13',
    imageProvider: AssetImage('assets/mouse.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Newspapers',
    totalPriceCents: 1499,
    uid: '14',
    imageProvider: AssetImage('assets/newspaper.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Plastic Bottle',
    totalPriceCents: 1499,
    uid: '15',
    imageProvider: AssetImage('assets/pastic_bottle.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Broken Phone',
    totalPriceCents: 1499,
    uid: '16',
    imageProvider: AssetImage('assets/phone.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Sanitary Napkins',
    totalPriceCents: 1499,
    uid: '17',
    imageProvider: AssetImage('assets/sanitary_napkins.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Tampons',
    totalPriceCents: 1499,
    uid: '18',
    imageProvider: AssetImage('assets/tampons.png'),
    garbageType: GarbageType.dry,
  ),
  const Item(
    name: 'Tea Bags',
    totalPriceCents: 1499,
    uid: '19',
    imageProvider: AssetImage('assets/tea_bags.png'),
    garbageType: GarbageType.dry,
  )
];

@immutable
class ExampleDragAndDrop extends StatefulWidget {
  const ExampleDragAndDrop({super.key});

  @override
  State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
}

class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
    with TickerProviderStateMixin {
  final List<Customer> _people = [
    Customer(
      name: '    Wet waste    ',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg'),
      garbageType: GarbageType.dry,
      color: Colors.green,
      icon: const Icon(
        Icons.recycling_rounded,
        color: Colors.white,
        size: 60.0,
      ),
    ),
    Customer(
      name: '   Dry waste     ',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar2.jpg'),
      garbageType: GarbageType.wet,
      color: Colors.blue,
      icon: const Icon(
        Icons.recycling_sharp,
        color: Colors.white,
        size: 60.0,
      ),
    ),
    Customer(
      name: 'Sanitary waste',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar3.jpg'),
      garbageType: GarbageType.sanitary,
      color: Colors.red,
      icon: const Icon(
        Icons.recycling,
        color: Colors.white,
        size: 60.0,
      ),
    ),
    Customer(
      name: '     E waste       ',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar3.jpg'),
      garbageType: GarbageType.ewaste,
      color: Colors.grey,
      icon: const Icon(
        Icons.recycling_outlined,
        color: Colors.white,
        size: 60.0,
      ),
    ),
  ];

  final GlobalKey _draggableKey = GlobalKey();

  void _itemDroppedOnCustomerCart({
    required Item item,
    required Customer customer,
  }) {
    setState(() {
      customer.items.add(item);
      _items.removeWhere((element) => element.uid == item.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF64209)),
      title: Text(
        'Order Food',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 36,
              color: const Color(0xFFF64209),
              fontWeight: FontWeight.bold,
            ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
    );
  }

  Widget _buildContent() {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: _buildMenuList(),
        ),
        Expanded(
          flex: 2,
          child: _buildPeopleRow(),
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    return GridView.count(
        crossAxisCount: 5,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: List.generate(_items.length, (index) {
          return Center(
            child: _buildMenuItem(item: _items[index]),
          );
        }));
  }

  Widget _buildMenuItem({
    required Item item,
  }) {
    return LongPressDraggable<Item>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        photoProvider: item.imageProvider,
      ),
      child: MenuListItem(
        name: item.name,
        price: item.formattedTotalItemPrice,
        photoProvider: item.imageProvider,
      ),
    );
  }

  Widget _buildPeopleRow() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 2.5,
        vertical: 5,
      ),
      child: Column(
        children: _people.map(_buildPersonWithDropZone).toList(),
      ),
    );
  }

  Widget _buildPersonWithDropZone(Customer customer) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        child: DragTarget<Item>(
          builder: (context, candidateItems, rejectedItems) {
            return CustomerCart(
              hasItems: customer.items.isNotEmpty,
              highlighted: candidateItems.isNotEmpty,
              customer: customer,
            );
          },
          onAccept: (item) {
            if (item.garbageType == customer.garbageType) {
              _itemDroppedOnCustomerCart(
                item: item,
                customer: customer,
              );
            } else {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                      height: 200,
                      // child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Image(
                              image: AssetImage('assets/alum_can.png'),
                              fit: BoxFit.cover,
                            ),
                            const Text(
                                'Thanks not right Emi. This item is used for something else'),
                            ElevatedButton(
                              child: const Text('Thanks'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        // ),
                      ));
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CustomerCart extends StatelessWidget {
  const CustomerCart({
    super.key,
    required this.customer,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Customer customer;
  final bool highlighted;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    final textColor = highlighted ? Colors.black : Colors.white;

    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8 : 4,
        borderRadius: BorderRadius.circular(22),
        color: highlighted
            ? const Color.fromARGB(184, 223, 133, 233)
            : customer.color,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: customer.icon,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                customer.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: textColor,
                      fontWeight:
                          hasItems ? FontWeight.normal : FontWeight.bold,
                    ),
              ),
              Visibility(
                visible: hasItems,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Column(
                  children: [
                    // const SizedBox(height: 4),
                    // Text(
                    //   customer.formattedTotalItemPrice,
                    //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    //         color: textColor,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    const SizedBox(height: 4),
                    Text(
                      '${customer.items.length} item${customer.items.length != 1 ? 's' : ''}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: textColor,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    this.name = '',
    this.price = '',
    required this.photoProvider,
    this.isDepressed = false,
  });

  final String name;
  final String price;
  final ImageProvider photoProvider;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: isDepressed ? 115 : 120,
                    width: isDepressed ? 115 : 120,
                    child: Image(
                      image: photoProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 175,
                  ),
                  Center(
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
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
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoProvider,
  });

  final GlobalKey dragKey;
  final ImageProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 150,
          width: 150,
          child: Opacity(
            opacity: 0.85,
            child: Image(
              image: photoProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class Item {
  const Item(
      {required this.totalPriceCents,
      required this.name,
      required this.uid,
      required this.imageProvider,
      required this.garbageType});
  final int totalPriceCents;
  final String name;
  final String uid;
  final ImageProvider imageProvider;
  final GarbageType garbageType;
  String get formattedTotalItemPrice =>
      '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
}

class Customer {
  Customer({
    required this.name,
    required this.imageProvider,
    required this.garbageType,
    required this.color,
    required this.icon,
    List<Item>? items,
  }) : items = items ?? [];

  final String name;
  final ImageProvider imageProvider;
  final List<Item> items;
  final GarbageType garbageType;
  final Color color;
  final Icon icon;

  String get formattedTotalItemPrice {
    final totalPriceCents =
        items.fold<int>(0, (prev, item) => prev + item.totalPriceCents);
    return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}
