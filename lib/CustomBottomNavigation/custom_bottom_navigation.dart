import 'package:flutter/material.dart';

class CustomNavigationPage extends StatefulWidget {
  @override
  _CustomNavigationPageState createState() => _CustomNavigationPageState();
}

class _CustomNavigationPageState extends State<CustomNavigationPage> {
  int currentIndex = 0;
  final GlobalKey _mainButtonKey = GlobalKey();
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(
        children: [
          Container(
            color: currentIndex == 0 ? Colors.red : Colors.green,
            height: size.height,
            width: size.width,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  Container(
                    color: Colors.red,
                    child: CustomPaint(
                      size: Size(size.width, 80),
                      painter: BottomNavigationPainter(),
                    ),
                  ),
                  Center(
                      key: _mainButtonKey,
                      heightFactor: 0.6,
                      child: Image.asset(
                        'assets/images/icon.png',
                        width: size.width * 0.10,
                      )),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color: currentIndex == 0
                                ? Colors.orange
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                          },
                          splashColor: Colors.white,
                        ),
                        Container(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: currentIndex == 3
                                  ? Colors.orange
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(3);
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavigationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    double centerOffset = 0.1;
    if (size.width > 720) {
      centerOffset = 0.08;
    }

    Path path = Path(); // Start
    path.lineTo(size.width * (0.5 - centerOffset), 0);
    path.lineTo(size.width * (0.5 - centerOffset), size.height * 0.5);
    path.arcToPoint(Offset(size.width * (0.5 + centerOffset), 0),
        radius: Radius.circular(10.0), clockwise: true);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawShadow(path, Colors.black87, 15, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
