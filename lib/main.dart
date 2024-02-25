import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:garbage_sorting/app_barcode_scanner_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

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
  final List<Dustbin> _dustbins = [
    Dustbin(
      name: '    Wet waste    ',
      garbageType: GarbageType.wet,
      color: Colors.green,
      collectibleReward: CollectibleReward.kumo,
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
      collectibleReward: CollectibleReward.zephyr,
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
      collectibleReward: CollectibleReward.fenrir,
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
      collectibleReward: CollectibleReward.ursula,
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

  void _collectibleCollected({
    required Item item,
    required Dustbin customer,
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
          child: _buildGarbageList(),
        ),
        Expanded(
          flex: 2,
          child: _buildDustbinRow(),
        ),
      ],
    );
  }

  Widget _buildGarbageList() {
    //TODO change these lengths to actual counts
    if (_dustbins[0].items.length == 1) {
      return _buildCongratulationsScreen(_dustbins[0]);
    } else if (_dustbins[1].items.length == 1) {
      return _buildCongratulationsScreen(_dustbins[1]);
    } else if (_dustbins[2].items.length == 1) {
      return _buildCongratulationsScreen(_dustbins[2]);
    } else if (_dustbins[3].items.length == 1) {
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
                Navigator.of(context).restorablePush(_dialogBuilder);
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

  Widget _buildDustbinRow() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 2.5,
        vertical: 5,
      ),
      child: Column(
        children: _dustbins.map(_buildPersonWithDropZone).toList(),
      ),
    );
  }

  Widget _buildPersonWithDropZone(Dustbin customer) {
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
              _itemDroppedOnDustbin(
                item: item,
                dustbin: customer,
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

class CustomerCart extends StatelessWidget {
  const CustomerCart({
    super.key,
    required this.customer,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Dustbin customer;
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

class Dustbin {
  Dustbin({
    required this.name,
    required this.garbageType,
    required this.color,
    required this.icon,
    required this.collectibleReward,
    List<Item>? items,
  }) : items = items ?? [];

  final String name;
  List<Item> items;
  final GarbageType garbageType;
  final Color color;
  final Icon icon;
  final CollectibleReward collectibleReward;

  String get formattedTotalItemPrice {
    final totalPriceCents =
        items.fold<int>(0, (prev, item) => prev + item.totalPriceCents);
    return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}
