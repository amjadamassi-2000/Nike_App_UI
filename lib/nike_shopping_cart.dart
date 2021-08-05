import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:nike_app/nike_shoes.dart';

const _buttonSizeWidth = 160;
const _buttonSizeHeight = 60;
const _buttonCircularSize = 60.0;
const _FinalImageSize = 30.0;
const _ImageSize = 200.0;

class NikeShoppingCart extends StatefulWidget {
  final NikeShoes shoes;

  const NikeShoppingCart({@required this.shoes});

  @override
  _NikeShoppingCartState createState() => _NikeShoppingCartState();
}

class _NikeShoppingCartState extends State<NikeShoppingCart>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animationResize;
  Animation _animationMovementIn;
  Animation _animationMovementOut;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animationResize = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3),
      ),
    );
    _animationMovementIn = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.35, 0.55 , curve: Curves.fastLinearToSlowEaseIn),
      ),
    );
    _animationMovementOut = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.6,
          1.0,
          curve: Curves.elasticIn,
        ),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(true);
      }
    });
  }

  disposed() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPanel() {
    final size = MediaQuery.of(context).size;
    final currentImageSize = (_ImageSize * _animationResize.value)
        .clamp(_FinalImageSize, _ImageSize);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, value * size.height * 0.6),
          child: child,
        );
      },
      child: Container(
        width: (size.width * _animationResize.value)
            .clamp(_buttonCircularSize, size.width),
        height: (size.height * 0.6 * _animationResize.value)
            .clamp(_buttonCircularSize, size.height * 0.6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: _animationResize.value == 1
                ? Radius.circular(0)
                : Radius.circular(30),
            bottomRight: _animationResize.value == 1
                ? Radius.circular(0)
                : Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: _animationResize.value == 1
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    widget.shoes.images.first,
                    height: currentImageSize,
                  ),
                  if (_animationResize.value == 1) ...[
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.shoes.model,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "\$${widget.shoes.currentPrice.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final buttonSizeWidth =
                  (_buttonSizeWidth * _animationResize.value)
                      .clamp(_buttonCircularSize, _buttonSizeWidth);
              final panelWidth = (size.width * _animationResize.value)
                  .clamp(_buttonCircularSize, size.width);
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Stack(
                      children: [
                        if (_animationMovementIn.value != 1)
                          Positioned(
                            left: size.width / 2 - panelWidth / 2,
                            top: size.height * 0.4 +
                                (_animationMovementIn.value *
                                    size.height *
                                    0.48444),
                            width: panelWidth,
                            child: _buildPanel(),
                          ),
                        Positioned(
                          bottom: 40 - (_animationMovementOut.value * 100),
                          left: size.width / 2 - buttonSizeWidth / 2,
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                            tween: Tween(begin: 1.0, end: 0.0),
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0.0, value * size.height * 0.6),
                                child: child,
                              );
                            },
                            child: InkWell(
                              onTap: () {
                                _controller.forward();
                              },
                              child: Container(
                                width: buttonSizeWidth,
                                height: (_buttonSizeHeight *
                                        _animationResize.value)
                                    .clamp(
                                        _buttonCircularSize, _buttonSizeHeight),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (_animationResize.value == 1) ...[
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "ADD TO CART",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}
