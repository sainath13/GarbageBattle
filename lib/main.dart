import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:garbage_sorting/app_barcode_scanner_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:confetti/confetti.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ExampleDragAndDrop(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

enum GarbageType { dry, wet, sanitary, ewaste }

enum CollectibleReward { zephyr, kumo, fenrir, ursula }

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

@immutable
class ExampleDragAndDrop extends StatefulWidget {
  const ExampleDragAndDrop({super.key});

  @override
  State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
}

class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
    with TickerProviderStateMixin {
  late ConfettiController _topController;

  @override
  void initState() {
    super.initState();

    // initialize confettiController
    _topController = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    // dispose the controller
    _topController.dispose();
    super.dispose();
  }

  final List<Dustbin> _dustbins = [
    Dustbin(
      name: '    Wet waste    ',
      garbageType: GarbageType.wet,
      color: Colors.green,
      collectibleReward: CollectibleReward.kumo,
      maxLength: 1, //TODO SAI change this lengths to actual counts
      mistakes: 0,
      collectibleType: 'Dog',
      heroImage:
          'https://res.cloudinary.com/parc-india/image/upload/c_pad,b_auto:predominant,fl_preserve_transparency/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
      cardImage:
          'https://res.cloudinary.com/parc-india/image/upload/f_auto,q_auto/x0ghmv4ym4ucg3lklsya',
      cardHeader: 'Kumo',
      cardSubHeader: 'The Roaming Companion',
      cardBody:
          'Kumo, known as the Roaming Companion, trots through the winding streets of the city, his loyal presence a comforting beacon for those in need. With each step, he brings joy and warmth to the hearts of all he encounters, his wagging tail a symbol of unwavering friendship and companionship.',
      icon: const Icon(
        Icons.recycling_rounded,
        color: Colors.white,
        size: 60.0,
      ),
    ),
    Dustbin(
      name: '   Dry waste     ',
      garbageType: GarbageType.dry,
      color: Colors.blue,
      maxLength: 1,
      mistakes: 0,
      collectibleReward: CollectibleReward.zephyr,
      collectibleType: 'Cheetah',
      heroImage:
          'https://res.cloudinary.com/parc-india/image/upload/c_pad,b_auto:predominant,fl_preserve_transparency/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
      cardImage:
          'https://res.cloudinary.com/parc-india/image/upload/f_auto,q_auto/x0ghmv4ym4ucg3lklsya',
      cardHeader: 'Zephyr',
      cardSubHeader: 'The Wanderer',
      cardBody:
          'Zephyr, the Wanderer, roams majestic landscapes, his enigmatic presence a beacon amidst the horizon. His footsteps weave tales of mystery and wonder through the sprawling wilderness.',
      icon: const Icon(
        Icons.recycling_sharp,
        color: Colors.white,
        size: 60.0,
      ),
    ),
    Dustbin(
      name: 'Sanitary waste',
      garbageType: GarbageType.sanitary,
      color: Colors.red,
      maxLength: 1,
      mistakes: 0,
      collectibleReward: CollectibleReward.fenrir,
      collectibleType: 'Wolf',
      heroImage:
          'https://res.cloudinary.com/parc-india/image/upload/c_pad,b_auto:predominant,fl_preserve_transparency/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
      cardImage:
          'https://res.cloudinary.com/parc-india/image/upload/f_auto,q_auto/x0ghmv4ym4ucg3lklsya',
      cardHeader: 'Fenrir',
      cardSubHeader: 'The Silent Stalker',
      cardBody:
          'Fenrir, known as the Silent Stalker, prowls through the moonlit night with unmatched grace and stealth. His piercing gaze cuts through the darkness, his primal instincts guiding him through the untamed wilderness. As he hunts beneath the cloak of night, his howl echoes through the silent woods, a haunting melody that strikes fear into the hearts of prey.',
      icon: const Icon(
        Icons.recycling,
        color: Colors.white,
        size: 60.0,
      ),
    ),
    Dustbin(
      name: '     E waste       ',
      garbageType: GarbageType.ewaste,
      color: Colors.grey,
      maxLength: 1,
      mistakes: 0,
      collectibleReward: CollectibleReward.ursula,
      collectibleType: 'Bear',
      heroImage:
          'https://res.cloudinary.com/parc-india/image/upload/c_pad,b_auto:predominant,fl_preserve_transparency/v1708706668/84823BA6-0E4A-4BFC-B591-2281FB6AF9FA_hb33up.jpg',
      cardImage:
          'https://res.cloudinary.com/parc-india/image/upload/f_auto,q_auto/x0ghmv4ym4ucg3lklsya',
      cardHeader: 'Ursula',
      cardSubHeader: 'The Solitary Sentinel',
      cardBody:
          'Ursula, known as the Solitary Sentinel, stands tall amidst the dense forest, her formidable presence a testament to the strength and resilience of nature. With a watchful eye and a gentle spirit, she guards the secrets of the wilderness, her majestic form a source of awe and admiration for all who behold her.',
      icon: const Icon(
        Icons.recycling_outlined,
        color: Colors.white,
        size: 60.0,
      ),
    ),
  ];

  final GlobalKey _draggableKey = GlobalKey();

  void _itemDroppedOnDustbin({
    required Item item,
    required Dustbin dustbin,
  }) {
    setState(() {
      dustbin.items.add(item);
      _items.removeWhere((element) => element.uid == item.uid);
    });
  }

  void _itemDroppedOnIncorrectDustbin({required Dustbin dustbin}) {
    print("Made a mistake");
    setState(() {
      dustbin.mistakes++;
    });
  }

  void _collectibleCollected({
    required Item item,
    required Dustbin dustbin,
  }) {
    setState(() {
      dustbin.items.add(item);
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
    return Stack(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              flex: 8,
              child: _buildGarbageList(),
            ),
            Expanded(
              flex: 2,
              child: _buildDustbinRow(),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _topController,
            blastDirection: pi / 2,
            maxBlastForce: 5,
            minBlastForce: 1,
            emissionFrequency: 0.03,

            // 10 paticles will pop-up at a time
            numberOfParticles: 10,

            // particles will pop-up
            gravity: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildGarbageList() {
    if (_dustbins[0].items.length == _dustbins[0].maxLength) {
      return _buildCongratulationsScreen(_dustbins[0]);
    } else if (_dustbins[1].items.length == _dustbins[1].maxLength) {
      return _buildCongratulationsScreen(_dustbins[1]);
    } else if (_dustbins[2].items.length == _dustbins[2].maxLength) {
      return _buildCongratulationsScreen(_dustbins[2]);
    } else if (_dustbins[3].items.length == _dustbins[3].maxLength) {
      return _buildCongratulationsScreen(_dustbins[3]);
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

  Widget _buildCongratulationsScreen(Dustbin dustbin) {
    _topController.play();
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
                const SizedBox(width: 20),
                const AnimatedMomSayingCongratsWidget(),
                // const SizedBox(width: 200),
                CollectibleCardWidget(
                    collectibleReward: dustbin.collectibleReward),
                ChatWidget(),
                const SizedBox(height: 20),
              ],
            ),
            // Congratulations message
            const Text(
              'Congratulations! You have won Zephyr the wonder card!',
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
                  dustbin.items = [];
                });
                //Navigator.of(context).restorablePush(_dialogBuilder);
                _launchURL(dustbin);
              },
              child: const Text('Add to Google Wallet'),
            ),
          ],
        ),
      ),
    );
  }

  Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 200,
              width: 200,
              child: AppBarcodeScannerWidget.defaultStyle(
                resultCallback: (String code) {
                  print("Scanned text is " + code);
                  setState(() {});
                },
                openManual: true,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _launchURL(Dustbin dustbin) async {
    final jwt = JWT(
      {
        'iss': 'straw-hat@devposthackathon.iam.gserviceaccount.com',
        'aud': 'google',
        'origins': [],
        'typ': 'savetowallet',
        'payload': {
          'genericObjects': [
            {
              'id': '3388000000022321421.123123123123123229',
              'classId': '3388000000022321421.Starsefdsfs75',
              'genericType': 'GENERIC_TYPE_UNSPECIFIED',
              'hexBackgroundColor': '#4285f4',
              'logo': {
                'sourceUri': {
                  'uri':
                      'https://res.cloudinary.com/parc-india/image/upload/v1642349740/Screen_Shot_2022-01-16_at_9.44.45_PM_hgazpj.png'
                }
              },
              'cardTitle': {
                'defaultValue': {'language': 'en', 'value': 'Strawhat labs'}
              },
              'subheader': {
                'defaultValue': {
                  'language': 'en',
                  'value': dustbin.cardSubHeader
                }
              },
              'header': {
                'defaultValue': {'language': 'en', 'value': dustbin.cardHeader}
              },
              "textModulesData": [
                {
                  "id": "points",
                  "header": "POINTS",
                  "body":
                      "${(100 - dustbin.mistakes * 10) > 10 ? 100 - dustbin.mistakes * 10 : 10}",
                },
                {
                  "id": "type",
                  "header": "type",
                  "body": dustbin.collectibleType,
                },
                {
                  "id": "cardinfo",
                  "header": '${dustbin.cardHeader} ${dustbin.cardSubHeader}',
                  "body": dustbin.cardBody,
                }
              ],
              'heroImage': {
                'sourceUri': {
                  'uri': dustbin.heroImage,
                }
              },
              'imageModulesData': [
                {
                  'mainImage': {
                    'kind': 'sdfd',
                    'sourceUri': {
                      'uri': dustbin.cardImage,
                    },
                    'contentDescription': {
                      'kind': 'dwqeqw',
                      'defaultValue': {
                        'kind': 'dwqeqw1',
                        'language': 'en-US',
                        'value': 'COngasegfsgds'
                      }
                    }
                  },
                  'id': '123123'
                }
              ]
            }
          ]
        }
      },
      issuer: getIssuerForPass,
    );

    String pem = getPrivateKey();

    final pkey = RSAPrivateKey(pem);

    String token = jwt.sign(pkey, algorithm: JWTAlgorithm.RS256);

    final Uri _url = Uri.parse('https://pay.google.com/gp/v/save/$token');
    // print(uri)
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  String get getIssuerForPass =>
      'straw-hat@devposthackathon.iam.gserviceaccount.com';

  String getPrivateKey() {
    const pem = '''-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC5PHHiqp78VQEt
FUrs7WUT8NQmNwGWgot5+cHFmd9zQFP9qxtnFbKJL7ZmybiKbeH+vIGsa+sFpOwB
S3nfvnkyurJfzIoPujY348FmqtCBkUIN+HhW39NIe2hhwN9U6wtWtbRxDaPDXAia
h64j9yWwlO/BAJmMXHtcrKsxPUMWaLtKqqCJpck0t956Nb7SngMoq3Fvwvgc6LMk
iA3Nn5x/CbbrkRxsiDEJMbFTNLAGIhYhugM/Unjv9vMKnrvF2fEgYuBp26i9hSbH
V1xBbcdUuEumL0MZqiWs0KKeezDeJg1oUDXf0T85RzuhA3/CZw/eQCCG+mKNg9F2
37Vfop9JAgMBAAECggEAJ10f+oI1rPvHdzQqKvU74KPyAXj4/moZh786nWpYoN5P
uv1solhrC1o3UdqWO9ykBQU8LU71r8pfWNsYOCL7EHu6Qj9uK29v7CqbQ90S2CXt
OpjNwfBoruOCyBs7mokkbLXKdafnYDGjpmsk54Gy4baUyJf/CWPx1zzeWGVjZ1RX
ix+qv1tuznBUQyt3VkUHMAzEi5j1qe5MwYUK9Wfj+k0tA4/Dxi70Vqr0CEhcXmAY
8h3Vat8XIovLwGeiKQhqyI22wU+okg8fHwtmPTKtVNmFGBUzVpfLQog62XGOmwxm
ROwfIA4P0K3MX4dCp5AUE0gVnADrBm/+QWnVtOBAcQKBgQDpRLiDlplcnjZcOa0O
lzFMC9cqvSOZtCXd6ynFARM0xkFWib2h7E2x04cEkn2AJ8o7WvsubxMhgaNul7N/
iT3VSDGOHv6IGHfizIeQRNAO/OQbH1jaQICWmejBWkLE+rD9Ua0tASY4eRcsgh62
sKbK9AjBSCANS0d94/K5lMRXzQKBgQDLSXnKLUJ2hC1O8KJgYzIWjFnYEh+0PBgz
38MLFXiLyGwv6i9AYR0O9dvjRKa0g8THH13zXnmAK9KxpT2TBbGG02LMh4Psicd8
Xw4fnKXC8Ib4OzXbdgvpgVCXulU0wEZeKtlxdSeLosQVtrIDHx6ODGvj4p901OuQ
QyqdXycxbQKBgCLf2U4jB86nAK2NGehihkY+Ru7m1Bm4qyigbeA8Juju8vnDIgzB
TWRWoYr3c7fjOwLguUjZ5lxOC2cPWxCoLgxi/LWowJkMP3Ay79mL0CdNe7TqXNhU
aGUboYa2veDBMhDNUzy1PUeYIvTOh1T82BLjpSNwawpRxOB3YeSI70nJAoGBAL8v
xz8B+fQEs6f+YHhOUpkqPoUb5n1X11tSItmVw92TDUyy7uWZb/7V84t20WIMW1D6
ix2LyLFmha1VPue6/w9SVyUMfmJD4j1yGJJafPstw4JKDYjtKJ7fY7CPKfuGqad+
nSo7iImm9suFGz4cUlw+Cmo0hMsYRMNUqAuBphaxAoGAOq6IpyYQI0ivSluXwpFV
F8aiZsH6AVadAEMqPl3ue2khYFJHHFFnZb6lm2N3rCwlLct2sJSBu5vYRbhld7qy
EZW1R276C15ZWzTgdiIgd+4YRlAWJbhp7dROf8hlFkUN+R0JDQFL7fk+lGLn2ZoL
9U+gS/j67Cz3C3R1aXe/yss=
-----END PRIVATE KEY-----''';
    return pem;
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

  Widget _buildDustbinRow() {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 2.5,
            vertical: 5,
          ),
          child: Column(
            children: _dustbins.map(_buildDustbinWithDropZone).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDustbinWithDropZone(Dustbin dustbin) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        child: DragTarget<Item>(
          builder: (context, candidateItems, rejectedItems) {
            return DustbinCart(
              hasItems: dustbin.items.isNotEmpty,
              highlighted: candidateItems.isNotEmpty,
              dustbin: dustbin,
            );
          },
          onAccept: (item) {
            if (item.garbageType == dustbin.garbageType) {
              _itemDroppedOnDustbin(
                item: item,
                dustbin: dustbin,
              );
            } else {
              _itemDroppedOnIncorrectDustbin(dustbin: dustbin);
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

class AnimatedMomSayingCongratsWidget extends StatelessWidget {
  const AnimatedMomSayingCongratsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetCircularAnimator(
      size: 350,
      innerIconsSize: 10,
      outerIconsSize: 10,
      innerAnimation: Curves.easeInOutBack,
      outerAnimation: Curves.easeInOutBack,
      innerColor: Colors.deepPurple,
      outerColor: Colors.orangeAccent,
      innerAnimationSeconds: 5,
      outerAnimationSeconds: 5,
      child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
        child: Image.asset(
          'assets/mom_congrats.png',
        ),
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      child: SizedBox(
        width: 300,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                BubbleSpecialTwo(
                  text: 'Mom, who is this stunning cheetah',
                  isSender: true,
                  color: Color.fromARGB(255, 110, 110, 198),
                  tail: true,
                  sent: true,
                ),
                BubbleSpecialOne(
                  text:
                      'Honey he is Zephyr. He roams around planets and eats rabbits. You have got it as a card reward for collecting all sanitary garbage correctly.',
                  isSender: false,
                  color: Color(0xFF1B97F3),
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                BubbleSpecialTwo(
                  text:
                      'WOw mom thats awesome, I dont want to loose him, how do I save him',
                  isSender: true,
                  color: Color.fromARGB(255, 110, 110, 198),
                  tail: true,
                  sent: true,
                ),
                BubbleSpecialOne(
                  text: 'Add it to your google wallet using the button below',
                  isSender: false,
                  color: Color(0xFF1B97F3),
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedBorderPainter extends CustomPainter {
  final Animation<double> _animation;
  final PathType _pathType;
  final double _strokeWidth;
  final Color _strokeColor;
  final Radius _radius;
  final int _startingPercentage;
  final AnimationDirection _animationDirection;

  AnimatedBorderPainter({
    required animation,
    PathType pathType = PathType.rect,
    double strokeWidth = 10.0,
    Color strokeColor = const Color.fromARGB(255, 37, 117, 157),
    Radius radius = const Radius.circular(4.0),
    int startingPercentage = 0,
    AnimationDirection animationDirection = AnimationDirection.clockwise,
  })  : assert(strokeWidth > 0, 'strokeWidth must be greater than 0.'),
        assert(startingPercentage >= 0 && startingPercentage <= 100,
            'startingPercentage must lie between 0 and 100.'),
        _animation = animation,
        _pathType = pathType,
        _strokeWidth = strokeWidth,
        _strokeColor = strokeColor,
        _radius = radius,
        _startingPercentage = startingPercentage,
        _animationDirection = animationDirection,
        super(repaint: animation);

  late Path _originalPath;
  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = _animation.value;

    // Construct original path once when animation starts
    if (animationPercent == 0.0) {
      _originalPath = _createOriginalPath(size);
      _paint = Paint()
        ..strokeWidth = _strokeWidth
        ..style = PaintingStyle.stroke
        ..color = _strokeColor;
    }

    final currentPath = _createAnimatedPath(
      _originalPath,
      animationPercent,
    );

    canvas.drawPath(currentPath, _paint);
  }

  @override
  bool shouldRepaint(AnimatedBorderPainter oldDelegate) => true;

  Path _createOriginalPath(Size size) {
    switch (_pathType) {
      case PathType.rect:
        return _createOriginalPathRect(size);
      case PathType.rRect:
        return _createOriginalPathRRect(size);
      case PathType.circle:
        return _createOriginalPathCircle(size);
    }
  }

  Path _createOriginalPathRect(Size size) {
    Path originalPath = Path()
      ..addRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..lineTo(0, -(_strokeWidth / 2));
    if (_startingPercentage > 0 && _startingPercentage < 100) {
      return _createPathForStartingPercentage(
          originalPath, PathType.rect, size);
    }
    return originalPath;
  }

  Path _createOriginalPathRRect(Size size) {
    Path originalPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          _radius,
        ),
      );
    if (_startingPercentage > 0 && _startingPercentage < 100) {
      return _createPathForStartingPercentage(originalPath, PathType.rRect);
    }
    return originalPath;
  }

  Path _createOriginalPathCircle(Size size) {
    Path originalPath = Path()
      ..addOval(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );
    if (_startingPercentage > 0 && _startingPercentage < 100) {
      return _createPathForStartingPercentage(originalPath, PathType.circle);
    }
    return originalPath;
  }

  Path _createPathForStartingPercentage(Path originalPath, PathType pathType,
      [Size? size]) {
    // Assumes that original path consists of one subpath only
    final pathMetrics = originalPath.computeMetrics().first;
    final pathCutoffPoint = (_startingPercentage / 100) * pathMetrics.length;
    final firstSubPath = pathMetrics.extractPath(0, pathCutoffPoint);
    final secondSubPath =
        pathMetrics.extractPath(pathCutoffPoint, pathMetrics.length);
    if (pathType == PathType.rect) {
      Path path = Path()
        ..addPath(secondSubPath, Offset.zero)
        ..lineTo(0, -(_strokeWidth / 2))
        ..addPath(firstSubPath, Offset.zero);
      switch (_startingPercentage) {
        case 25:
          path.lineTo(size!.width + _strokeWidth / 2, 0);
          break;
        case 50:
          path.lineTo(size!.width - _strokeWidth / 2, size.height);
          break;
        case 75:
          path.lineTo(0, size!.height + _strokeWidth / 2);
          break;
        default:
      }
      return path;
    }
    return Path()
      ..addPath(secondSubPath, Offset.zero)
      ..addPath(firstSubPath, Offset.zero);
  }

  Path _createAnimatedPath(
    Path originalPath,
    double animationPercent,
  ) {
    // ComputeMetrics can only be iterated once!
    final totalLength = originalPath
        .computeMetrics()
        .fold(0.0, (double prev, PathMetric metric) => prev + metric.length);

    final currentLength = totalLength * animationPercent;

    return _extractPathUntilLength(originalPath, currentLength);
  }

  Path _extractPathUntilLength(
    Path originalPath,
    double length,
  ) {
    var currentLength = 0.0;

    final path = Path();

    var metricsIterator = _animationDirection == AnimationDirection.clockwise
        ? originalPath.computeMetrics().iterator
        : originalPath.computeMetrics().toList().reversed.iterator;

    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;

      var nextLength = currentLength + metric.length;

      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = _animationDirection == AnimationDirection.clockwise
            ? metric.extractPath(0.0, remainingLength)
            : metric.extractPath(
                metric.length - remainingLength, metric.length);

        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        // There might be a more efficient way of extracting an entire path
        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }
}

enum PathType {
  rect,
  rRect,
  circle,
}

enum AnimationDirection {
  clockwise,
  counterclockwise,
}

class CollectibleCardWidget extends StatefulWidget {
  final CollectibleReward collectibleReward;

  CollectibleCardWidget({Key? key, required this.collectibleReward})
      : super(key: key);

  @override
  State<CollectibleCardWidget> createState() => _CollectibleCardWidgetState();
}

class _CollectibleCardWidgetState extends State<CollectibleCardWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2000,
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  void _startAnimation1() {
    _controller1.reset();
    _controller1.animateTo(1.0, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: AnimatedBorderPainter(
        animation: _controller1,
        strokeColor: Colors.black54,
        pathType: PathType.rRect,
        animationDirection: AnimationDirection.clockwise,
        startingPercentage: 40,
        radius: const Radius.circular(12),
      ),
      child: SizedBox(
        width: 350,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: GestureDetector(
              onTap: _startAnimation1,
              child: Container(
                  width: 350,
                  height: 500,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            getCardImageFromCardType(widget.collectibleReward),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(170, 19, 31, 194),
                          blurRadius: 28,
                        )
                      ])),
            ),
          ),
          // ),
        ),
      ),
    );
  }

  AssetImage getCardImageFromCardType(collectibleReward) =>
      AssetImage('assets/$collectibleReward.png');
}

class DustbinCart extends StatelessWidget {
  const DustbinCart({
    super.key,
    required this.dustbin,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Dustbin dustbin;
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
            : dustbin.color,
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
                  child: dustbin.icon,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dustbin.name,
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
                    const SizedBox(height: 4),
                    Text(
                      '${dustbin.items.length} item${dustbin.items.length != 1 ? 's' : ''}',
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

class Dustbin {
  Dustbin({
    required this.name,
    required this.garbageType,
    required this.color,
    required this.icon,
    required this.collectibleReward,
    required this.maxLength,
    required this.mistakes,
    required this.collectibleType,
    required this.heroImage,
    required this.cardImage,
    required this.cardHeader,
    required this.cardSubHeader,
    required this.cardBody,
    List<Item>? items,
  }) : items = items ?? [];

  final String name;
  List<Item> items;
  final GarbageType garbageType;
  final Color color;
  final Icon icon;
  final CollectibleReward collectibleReward;
  final int maxLength;
  final String collectibleType;
  final String heroImage;
  final String cardImage;
  final String cardHeader;
  final String cardSubHeader;
  final String cardBody;
  int mistakes;
  String get formattedTotalItemPrice {
    final totalPriceCents =
        items.fold<int>(0, (prev, item) => prev + item.totalPriceCents);
    return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}
