import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
    incorrectMessageDescription:
        "Oops! Looks like this can needs a different destination. Think about where you'd recycle it.",
  ),
  const Item(
    name: 'Band-Aids',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: AssetImage('assets/band_aids.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Uh-oh! Seems like this item is more suited for a specific bin. Consider its material and its journey after disposal.",
  ),
];

List<Item> _itemsBackup = [
  const Item(
    name: 'Aluminium can',
    totalPriceCents: 1299,
    uid: '1',
    imageProvider: AssetImage('assets/alum_can.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Oops! Looks like this can needs a different destination. Think about where you'd recycle it.",
  ),
  const Item(
    name: 'Band-Aids',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: AssetImage('assets/band_aids.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Uh-oh! Seems like this item is more suited for a specific bin. Consider its material and its journey after disposal.",
  ),
  const Item(
    name: 'Burger',
    totalPriceCents: 1499,
    uid: '3',
    imageProvider: AssetImage('assets/burger.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Oops, looks like this burger's journey has been cut short! Consider where its remaining 'half' belongs",
  ),
  const Item(
    name: 'Cardboard Box',
    totalPriceCents: 1499,
    uid: '4',
    imageProvider: AssetImage('assets/cardboard_box.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Hmm, this one might need a sturdier home. Think about where you'd put it for a new life.",
  ),
  const Item(
    name: 'Charging Cable',
    totalPriceCents: 1499,
    uid: '5',
    imageProvider: AssetImage('assets/charging_cable.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Whoopsie! This item needs a charge of its own, but in a different bin. Consider its technological nature.",
  ),
  const Item(
    name: 'Disposable Cup',
    totalPriceCents: 1499,
    uid: '6',
    imageProvider: AssetImage('assets/disposable_cup.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Oh dear, this cup's journey might be a bit different than you think. Reflect on its composition.",
  ),
  const Item(
    name: 'Egg Shells',
    totalPriceCents: 1499,
    uid: '7',
    imageProvider: AssetImage('assets/egg_shells.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Hm, this one's a bit 'shell'-shocked! Imagine where it belongs after its 'cracking' adventure.",
  ),
  const Item(
    name: 'Food Leftover',
    totalPriceCents: 1499,
    uid: '8',
    imageProvider: AssetImage('assets/food_leftover.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Ah, leftovers from a journey! But perhaps a different destination awaits them. Consider their origins.",
  ),
  const Item(
    name: 'Fruit Scraps',
    totalPriceCents: 1499,
    uid: '9',
    imageProvider: AssetImage('assets/fruit_scraps.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Hmm, these scraps may lead to a fruitful destination elsewhere. Ponder their potential.",
  ),
  const Item(
    name: 'Game Console',
    totalPriceCents: 1499,
    uid: '10',
    imageProvider: AssetImage('assets/game_console.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Whoa, a gaming device! But its journey might be to a different bin. Imagine where it 'resets'.",
  ),
  const Item(
    name: 'Keyboard',
    totalPriceCents: 1499,
    uid: '11',
    imageProvider: AssetImage('assets/keyboard.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Oops, seems like this keyboard needs a different key to its journey. Reflect on its functionality.",
  ),
  const Item(
    name: 'Mask',
    totalPriceCents: 1499,
    uid: '12',
    imageProvider: AssetImage('assets/mask.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Ah, a mask! But perhaps a different bin awaits it for a new journey. Consider its protective purpose.",
  ),
  const Item(
    name: 'Mouse',
    totalPriceCents: 1499,
    uid: '13',
    imageProvider: AssetImage('assets/mouse.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Squeak! This mouse's journey might lead it to a different bin. Imagine where it 'clicks'.",
  ),
  const Item(
    name: 'Newspapers',
    totalPriceCents: 1499,
    uid: '14',
    imageProvider: AssetImage('assets/newspaper.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Hm, this news needs a new destination. Think about where it belongs after being 'read'.",
  ),
  const Item(
    name: 'Plastic Bottle',
    totalPriceCents: 1499,
    uid: '15',
    imageProvider: AssetImage('assets/pastic_bottle.png'),
    garbageType: GarbageType.dry,
    incorrectMessageDescription:
        "Oh, a bottle! But where does it go after quenching its thirst? Imagine its next adventure.",
  ),
  const Item(
    name: 'Broken Phone',
    totalPriceCents: 1499,
    uid: '16',
    imageProvider: AssetImage('assets/phone.png'),
    garbageType: GarbageType.ewaste,
    incorrectMessageDescription:
        "Uh-oh, this phone's journey might need a new 'connection'. Think about where its 'broken' parts should go for a new life",
  ),
  const Item(
    name: 'Sanitary Napkins',
    totalPriceCents: 1499,
    uid: '17',
    imageProvider: AssetImage('assets/sanitary_napkins.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Whoops, this item might need a different destination. Reflect on its hygiene purpose.",
  ),
  const Item(
    name: 'Tampons',
    totalPriceCents: 1499,
    uid: '18',
    imageProvider: AssetImage('assets/tampons.png'),
    garbageType: GarbageType.sanitary,
    incorrectMessageDescription:
        "Hmm, these might need a different bin for their next 'cycle'. Imagine where they belong.",
  ),
  const Item(
    name: 'Tea Bags',
    totalPriceCents: 1499,
    uid: '19',
    imageProvider: AssetImage('assets/tea_bags.png'),
    garbageType: GarbageType.wet,
    incorrectMessageDescription:
        "Oops, these bags might need a different brew of a bin. Ponder their compostable potential",
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
      garbageType: GarbageType.wet,
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
      garbageType: GarbageType.dry,
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

  void _collectibleCollected({
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
        '',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 36,
              color: Color.fromARGB(255, 0, 0, 0),
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
    if (_people[0].items.length == 1) {
      return _buildCongratulationsScreen(_people[0]);
    } else if (_people[1].items.length == 1) {
      return _buildCongratulationsScreen(_people[1]);
    } else if (_people[2].items.length == 1) {
      return _buildCongratulationsScreen(_people[2]);
    } else if (_people[3].items.length == 1) {
      return _buildCongratulationsScreen(_people[3]);
    }
    if (_items.isEmpty) {
      return const Text("helo");
    } else {
      return AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 5,
          crossAxisSpacing: 25.0,
          mainAxisSpacing: 25.0,
          children: List.generate(
            _items.length,
            (index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 5,
                child: ScaleAnimation(
                  scale: 0.5,
                  child: FadeInAnimation(
                    child: Center(
                      child: _buildMenuItem(item: _items[index]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  Widget _buildCongratulationsScreen(Customer customer) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left side with local image and collectible cards
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Local image on the left
                Image.asset(
                  'assets/mom_congrats.jpeg',
                  width: 450,
                  height: 450,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 20),
                // Collectible cards images on the right
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: List.generate(
                      4,
                      (index) => Image.asset(
                        'assets/collectible_card_$index.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Congratulations message
            const Text(
              'Congratulations! You have collected all the collectible cards!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // Button to add collectibles to Google Wallet
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Collectible collected");
                setState(() {
                  customer.items = [];
                });
              },
              child: const Text('Add to Google Wallet'),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    final Uri _url = Uri.parse(
        'https://pay.google.com/gp/v/save/eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdHJhdy1oYXRAZGV2cG9zdGhhY2thdGhvbi5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImF1ZCI6Imdvb2dsZSIsIm9yaWdpbnMiOltdLCJ0eXAiOiJzYXZldG93YWxsZXQiLCJwYXlsb2FkIjp7ImdlbmVyaWNPYmplY3RzIjpbeyJpZCI6IjMzODgwMDAwMDAwMjIzMjE0MjEubGF0a2Fyc2FpbmF0aF9nbWFpbC5jb20iLCJjbGFzc0lkIjoiMzM4ODAwMDAwMDAyMjMyMTQyMS5jb2RlbGFiX2NsYXNzIiwiZ2VuZXJpY1R5cGUiOiJHRU5FUklDX1RZUEVfVU5TUEVDSUZJRUQiLCJoZXhCYWNrZ3JvdW5kQ29sb3IiOiIjNDI4NWY0IiwibG9nbyI6eyJzb3VyY2VVcmkiOnsidXJpIjoiaHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3dhbGxldC1sYWItdG9vbHMtY29kZWxhYi1hcnRpZmFjdHMtcHVibGljL3Bhc3NfZ29vZ2xlX2xvZ28uanBnIn19LCJjYXJkVGl0bGUiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4iLCJ2YWx1ZSI6Ikdvb2dsZSBJL08gJzIyIn19LCJzdWJoZWFkZXIiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4iLCJ2YWx1ZSI6IkF0dGVuZGVlIn19LCJoZWFkZXIiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4iLCJ2YWx1ZSI6IkFsZXggTWNKYWNvYnMifX0sImJhcmNvZGUiOnsidHlwZSI6IlFSX0NPREUiLCJ2YWx1ZSI6IjMzODgwMDAwMDAwMjIzMjE0MjEubGF0a2Fyc2FpbmF0aF9nbWFpbC5jb20ifSwiaGVyb0ltYWdlIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vd2FsbGV0LWxhYi10b29scy1jb2RlbGFiLWFydGlmYWN0cy1wdWJsaWMvZ29vZ2xlLWlvLWhlcm8tZGVtby1vbmx5LmpwZyJ9fSwidGV4dE1vZHVsZXNEYXRhIjpbeyJoZWFkZXIiOiJQT0lOVFMiLCJib2R5IjoiMTIzNCIsImlkIjoicG9pbnRzIn0seyJoZWFkZXIiOiJDT05UQUNUUyIsImJvZHkiOiIyMCIsImlkIjoiY29udGFjdHMifV19XX0sImlhdCI6MTcwODE4MDA3Nn0.dpGtIcYN3k4o4nnQjakFADw0zWKK6i_sUgLZ-wWwgfwrc9eNTLtklIq9oqtriRViqXBiXeadXtYoNznECFbev_bi8jfKnc918jH9qH_j3y3uNm3kXZtfjYDGe1ApvSu73HZWpWxTVybTaoVbPzzl3wMSeinOfSU5b2VDLkE49-tpj3ZEeKNPhAhIQHIjiIW2vAFcsr9XlTGNH6A6ZIeQIJrx5X4fSnOXUlKDJC-_qAIbmwoINXEOnY_5LcwEimCjafkJTaXBqqAiv3FnhZ94z5nTbfo9WDZJrQX9pvekTZ73sIvAhFH8FUat029Vc2aZC3oaxwoVMqW6Bd3-NuXNSA');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
              showModalBottomSheet<Item>(
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
                            Text(
                              item.incorrectMessageDescription,
                            ),
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
      required this.incorrectMessageDescription,
      required this.garbageType});
  final int totalPriceCents;
  final String name;
  final String uid;
  final ImageProvider imageProvider;
  final GarbageType garbageType;
  final String incorrectMessageDescription;
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
  List<Item> items;
  final GarbageType garbageType;
  final Color color;
  final Icon icon;

  String get formattedTotalItemPrice {
    final totalPriceCents =
        items.fold<int>(0, (prev, item) => prev + item.totalPriceCents);
    return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}
