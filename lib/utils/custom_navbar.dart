// ignore_for_file: library_private_types_in_public_api

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class DefaultCustomNavigationBarStyle {
  static const defaultHeight = kBottomNavigationBarHeight;
  static const defaultColor = Colors.blueAccent;
  static final defaultUnselectedColor = Colors.grey[600];
}

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar(
      {Key? key,
      required this.items,
      this.selectedColor,
      this.unSelectedColor,
      this.onTap,
      this.currentIndex = 0,
      this.iconSize = 24.0,
      this.scaleFactor = 0.2,
      this.elevation = 8.0,
      this.borderRadius = Radius.zero,
      this.backgroundColor = Colors.white,
      this.strokeColor = Colors.white,
      this.bubbleCurve = Curves.linear,
      this.scaleCurve = Curves.linear,
      this.isFloating = false,
      this.blurEffect = false,
      this.opacity = 0.8,
      this.gradient})
      : assert(scaleFactor <= 0.5, 'Scale factor must smaller than 0.5'),
        assert(scaleFactor > 0, 'Scale factor must bigger than 0'),
        assert(0 <= currentIndex && currentIndex < items.length),
        super(key: key);

  ///
  /// gradient color for background
  ///
  final Gradient? gradient;

  ///
  /// scale factor for the icon scale animation effect.
  /// default is `0.2`.
  final double scaleFactor;

  ///
  /// boolean that control if navigation bar perform floating.
  /// default is false
  ///
  final bool isFloating;

  ///
  /// Border radius for naviagtion bar
  ///
  final Radius borderRadius;

  /// The z-coordinate of this [CustomNavigationBar].
  ///
  /// If null, defaults to `8.0`.
  final double elevation;

  ///
  /// Item data in [CustomNavigationBarItem]
  ///
  final List<CustomNavigationBarItem> items;

  ///
  /// [Color] when [CustomNavigationBarItem] is selected.
  ///
  /// default color is [blueAccent].
  final Color? selectedColor;

  ///
  /// [Color] when [CustomNavigationBarItem] is not selected.
  ///
  /// default color is [grey[600]].
  final Color? unSelectedColor;

  ///
  /// callback function when item tapped
  ///
  final Function(int)? onTap;

  ///
  /// current index of navigation bar.
  ///
  final int currentIndex;

  ///
  /// size of icon.
  /// also represent the max radius of bubble effect animation.
  final double iconSize;

  ///
  /// Background color of [CustomNavigationBar]
  ///
  final Color backgroundColor;

  ///
  /// stroke color.
  /// default is [Colors.blueAccent].
  final Color strokeColor;

  ///
  /// animation curve of bubble effect
  ///
  final Curve bubbleCurve;

  ///
  /// animation curve of scale effect
  ///
  final Curve scaleCurve;

  ///
  /// bool to control if navigation bar use blur effect
  /// default is [false]
  ///
  final bool blurEffect;

  ///
  /// When [blurEffect] is [true], control the opacity of navigation bar
  /// default is [0.8]
  ///
  final double opacity;

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> with TickerProviderStateMixin {
  late List<double> _radiuses;
  late List<double> _sizes;
  AnimationController? _controller;
  AnimationController? _scaleController;

  double _bubbleRadius = 0.0;
  double? _maxRadius;

  double _itemPadding = 0.0;

  @override
  void initState() {
    super.initState();
    _bubbleRadius = 0.0;
    _radiuses = List<double>.generate(widget.items.length, (index) {
      return _bubbleRadius;
    });

    _sizes = List<double>.generate(widget.items.length, (index) {
      return 0.0;
    });
    _maxRadius = widget.iconSize;
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _scaleController?.reverse();
      _startAnimation(widget.currentIndex);
      _startScale(widget.currentIndex);
    }
  }

  void _startAnimation(int index) {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _controller!,
      curve: widget.bubbleCurve,
    );
    Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation).addListener(() {
      setState(() {
        _radiuses[index] = _maxRadius! * curvedAnimation.value;
      });
    });
    _controller!.forward();
  }

  void _startScale(int index) {
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scaleController?.reverse();
        }
      });
    CurvedAnimation scaleAnimation = CurvedAnimation(
      parent: _scaleController!,
      curve: widget.scaleCurve,
      reverseCurve: widget.scaleCurve.flipped,
    );

    Tween<double>(begin: 0.0, end: 1.0).animate(scaleAnimation).addListener(() {
      setState(() {
        _sizes[index] = scaleAnimation.value * widget.scaleFactor;
      });
    });
    _scaleController!.forward();
  }

  Widget _buildLabel(int index) {
    // unselected
    if (index != widget.currentIndex) {
      if (widget.items[index].title == null && widget.isFloating) {
        return Container();
      } else {
        return widget.items[index].title ?? Container();
      }
    } else {
      //selected
      if (widget.isFloating && widget.items[index].title == null) {
        return Container();
      } else {
        return widget.items[index].selectedTitle ?? Container();
      }
    }
  }

  Widget _buildIcon(int index) {
    return SizedBox(
      height: widget.iconSize,
      width: widget.iconSize,
      child: CustomPaint(
        painter: BeaconPainter(
            color: widget.strokeColor,
            beaconRadius: _radiuses[index],
            maxRadius: _maxRadius,
            offset: Offset(
              widget.iconSize / 2,
              widget.iconSize / 2,
            )),
        child: _CustomNavigationBarTile(
          iconSize: widget.iconSize,
          scale: _sizes[index],
          selected: index == widget.currentIndex,
          item: widget.items[index],
          selectedColor: widget.selectedColor ?? DefaultCustomNavigationBarStyle.defaultColor,
          unSelectedColor:
              widget.unSelectedColor ?? DefaultCustomNavigationBarStyle.defaultUnselectedColor,
          iconPadding: _itemPadding,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom, 0.0);

    final height = DefaultCustomNavigationBarStyle.defaultHeight +
        (widget.isFloating ? 0.0 : additionalBottomPadding);

    _itemPadding = (MediaQuery.of(context).size.width - widget.items.length * widget.iconSize) /
        (widget.items.length * 2);

    if (widget.isFloating) {
      _itemPadding =
          (MediaQuery.of(context).size.width - widget.items.length * widget.iconSize - 32) /
              (widget.items.length * 2);
    }

    Widget bar = Material(
      color: Colors.transparent,
      elevation: widget.elevation,
      borderRadius: BorderRadius.all(
        widget.borderRadius,
      ),
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.all(
            widget.borderRadius,
          ),
          color: widget.backgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (var i = 0; i < widget.items.length; i++)
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    widget.onTap!(i);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildIcon(i),
                      _buildLabel(i),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (widget.blurEffect) {
      return ClipPath(
        clipper: null,
        child: Padding(
          padding: widget.isFloating
              ? EdgeInsets.only(left: 30.0, right: 30.0, top: 0, bottom: additionalBottomPadding)
              : EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              widget.borderRadius,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 10.0,
              ),
              child: Opacity(
                opacity: 0.7,
                child: bar,
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: widget.isFloating
            ? EdgeInsets.only(left: 30.0, right: 30.0, top: 0, bottom: additionalBottomPadding)
            : EdgeInsets.zero,
        child: bar,
      );
    }
  }
}

class _CustomNavigationBarTile extends StatelessWidget {
  const _CustomNavigationBarTile(
      {Key? key,
      this.selected,
      this.item,
      this.selectedColor,
      this.unSelectedColor,
      this.scale,
      this.iconSize,
      this.iconPadding})
      : super(key: key);

  final bool? selected;

  final CustomNavigationBarItem? item;

  final Color? selectedColor;

  final Color? unSelectedColor;

  final double? scale;

  final double? iconSize;

  final double? iconPadding;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.0 + scale!,
      child: Stack(
        children: [
          IconTheme(
            data: IconThemeData(
              color: selected! ? selectedColor : unSelectedColor,
              size: iconSize,
            ),
            child: selected! ? item!.selectedIcon : item!.icon,
          ),
        ],
      ),
    );
  }
}

class CustomNavigationBarItem {
  /// Create a Custom Navigationbar Item.
  ///
  /// the [selectedIcon] must not be null.
  CustomNavigationBarItem(
      {required this.icon,
      Widget? selectedIcon,
      this.title,
      Text? selectedTitle,
      this.badgeCount = 0,
      this.showBadge = false})
      : selectedIcon = selectedIcon ?? icon,
        selectedTitle = selectedTitle ?? title;

  ///
  /// The icon of the item
  /// Typically the icon is an [Icon].
  ///

  final Widget icon;

  /// An alternative icon displayed when this bottom navigation item is
  /// selected.
  ///
  /// If this icon is not provided, the bottom navigation bar will display
  /// [icon] in either state.
  final Widget selectedIcon;

  ///
  /// Item title under icon
  ///
  final Widget? title;

  ///
  /// Item selected title under icon
  ///
  final Widget? selectedTitle;

  /// Notification badge count
  final int badgeCount;

  /// hide or show badge
  final bool showBadge;
}

class BeaconPainter extends CustomPainter {
  final double? beaconRadius;
  final Color? color;
  final double? maxRadius;
  final Offset? offset;

  const BeaconPainter({
    this.beaconRadius,
    this.color,
    this.maxRadius,
    this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (beaconRadius == maxRadius) return;

    if (beaconRadius! < maxRadius! * 0.5) {
      final Paint paint = Paint()..color = color!;
      canvas.drawCircle(offset!, beaconRadius!, paint);
    } else {
      final Paint paint = Paint()
        ..color = color!
        ..style = PaintingStyle.stroke
        ..strokeWidth = maxRadius! - beaconRadius!;
      canvas.drawCircle(offset!, beaconRadius!, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Path myCustomShapePath(Rect rect) {
  var height = rect.height;
  var width = rect.width;
  var offset = height * .16;
  var base = height * 0.6;

  // return Path()
  //   ..lineTo( width * 0.35, 0)
  //   ..quadraticBezierTo(width * 0.38, 0, width * 0.4, offset)
  //   ..quadraticBezierTo(width * 0.45, base, width * 0.5, base)
  //   ..quadraticBezierTo(width * 0.55, base, width * 0.6, offset)
  // // ..quadraticBezierTo(width * 0.6, 0, width * 0.65, 0)
  // // ..arcToPoint(Offset(width * 0.6, offset), radius: Radius.circular(radius), clockwise: false)
  //   ..quadraticBezierTo(width * 0.64, 0, width * 0.65, 0)
  //   ..lineTo(width, 0)
  //   ..lineTo(width, height)
  //   ..lineTo(0, height)

  return Path()
    ..lineTo(width * 0.38, 0)
    ..quadraticBezierTo(width * 0.41, 0, width * 0.42, offset)
    ..quadraticBezierTo(width * 0.44, base, width * 0.5, base)
    ..quadraticBezierTo(width * 0.56, base, width * 0.58, offset)
    // ..quadraticBezierTo(width * 0.6, 0, width * 0.65, 0)
    // ..arcToPoint(Offset(width * 0.6, offset), radius: Radius.circular(radius), clockwise: false)
    ..quadraticBezierTo(width * 0.59, 0, width * 0.62, 0)
    ..lineTo(width, 0)
    ..lineTo(width, height)
    ..lineTo(0, height)
    ..close();
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => myCustomShapePath(Rect.fromLTRB(0, 0, size.width, size.height));

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CustomShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => myCustomShapePath(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => throw UnimplementedError();
}
