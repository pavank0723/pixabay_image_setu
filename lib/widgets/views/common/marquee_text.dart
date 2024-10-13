import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, pauseDuration;
  final double gap;

  const MarqueeWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 300),
    this.pauseDuration = const Duration(milliseconds: 0),
    this.gap = 50.0,
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scroll();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: widget.direction,
      controller: scrollController,
      child: Row(
        children: [
          widget.child,
          SizedBox(width: widget.gap),
          widget.child,
        ],
      ),
    );
  }

  void scroll() async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        final maxScrollExtent = scrollController.position.maxScrollExtent / 2;
        final duration = widget.animationDuration;

        if (scrollController.offset >= maxScrollExtent) {
          scrollController.jumpTo(0.0);
        }

        await scrollController.animateTo(
          scrollController.offset + 1.0, // Adjust the increment value to control the scrolling speed
          duration: Duration(milliseconds: 16), // 60 FPS
          curve: Curves.linear,
        );
      }
    }
  }
}
