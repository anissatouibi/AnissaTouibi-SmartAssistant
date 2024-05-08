import 'dart:math';

import 'package:smart_assistant_app/core/extensions/num_extensions.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class GlitchyPrice extends StatefulWidget {
  const GlitchyPrice({
    super.key,
    required this.price,
    required this.textStyle,
    this.priceIncreaseColor = AppColors.ramliColor,
    this.priceDecreaseColor = AppColors.primaryRed8AColor,
  });

  final num price;

  final TextStyle textStyle;

  final Color priceIncreaseColor;

  final Color priceDecreaseColor;

  @override
  State<GlitchyPrice> createState() => _GlitchyPriceState();
}

class _GlitchyPriceState extends State<GlitchyPrice> with SingleTickerProviderStateMixin {
  static const _glitchDistance = 15.0;

  late _PriceGlitchController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _PriceGlitchController(
      vsync: this,
      priceIncreaseColor: widget.priceIncreaseColor,
      priceDecreaseColor: widget.priceDecreaseColor,
    );
  }

  @override
  void didUpdateWidget(GlitchyPrice oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.price != oldWidget.price) {
      if (widget.price < oldWidget.price) {
        _controller.glitchNegative();
      } else {
        _controller.glitchPositive();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Dispose on next frame so that the AnimatedBuilder doesn't throw exception when it de-registers its listener.
      _controller.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencyText = "${widget.price.currencyFormat(withFraction: true)} QAR";

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return _buildLeftGlitchText(currencyText);
          },
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return _buildRightGlitchText(currencyText);
          },
        ),
        _buildPrimaryText(currencyText),
      ],
    );
  }

  Widget _buildLeftGlitchText(String currencyText) {
    return Positioned(
      left: -_glitchDistance * _controller.leftGlitchPercent,
      child: Text(
        currencyText,
        style: widget.textStyle.copyWith(color: _controller.color.withOpacity(0.4)),
      ),
    );
  }

  Widget _buildRightGlitchText(String currencyText) {
    return Positioned(
      left: _glitchDistance * _controller.rightGlitchPercent,
      child: Text(
        currencyText,
        style: widget.textStyle.copyWith(color: _controller.color.withOpacity(0.4)),
      ),
    );
  }

  Widget _buildPrimaryText(String currencyText) {
    return Text(
      currencyText,
      style: widget.textStyle,
    );
  }
}

class _PriceGlitchController with ChangeNotifier {
  _PriceGlitchController({
    required TickerProvider vsync,
    Duration glitchTime = const Duration(milliseconds: 700),
    required Color priceIncreaseColor,
    required Color priceDecreaseColor,
  })  : _glitchTime = glitchTime,
        _priceIncreaseColor = priceIncreaseColor,
        _priceDecreaseColor = priceDecreaseColor,
        _color = priceIncreaseColor {
    _ticker = vsync.createTicker(_onTick);
  }

  @override
  void dispose() {
    _ticker
      ..stop()
      ..dispose();
    super.dispose();
  }

  late final Ticker _ticker;
  final Duration _glitchTime;
  final Color _priceIncreaseColor;
  final Color _priceDecreaseColor;

  Color get color => _color;
  Color _color;

  double get leftGlitchPercent => _leftGlitchPercent;
  double _leftGlitchPercent = 0.0;

  double get rightGlitchPercent => _rightGlitchPercent;
  double _rightGlitchPercent = 0.0;

  Duration _glitchStartTime = Duration.zero;
  Duration? _lastGlitchTime;
  double _leftGlitchJitterAdjustment = 0.0;
  double _rightGlitchJitterAdjustment = 0.0;

  void glitchPositive() {
    _color = _priceIncreaseColor;
    _glitch();
  }

  void glitchNegative() {
    _color = _priceDecreaseColor;
    _glitch();
  }

  void _glitch() {
    if (_lastGlitchTime != null) {
      _glitchStartTime = _lastGlitchTime!;
      return;
    }

    _glitchStartTime = Duration.zero;
    final random = Random();
    _leftGlitchJitterAdjustment = random.nextDouble() * 2;
    _rightGlitchJitterAdjustment = random.nextDouble() * 2;
    _ticker.start();
  }

  void _onTick(Duration elapsedTime) {
    final dt = elapsedTime - _glitchStartTime;

    _leftGlitchPercent = _calculateJitterPercent(dt, _leftGlitchJitterAdjustment);
    _rightGlitchPercent = _calculateJitterPercent(dt, _rightGlitchJitterAdjustment);

    if (elapsedTime - _glitchStartTime > _glitchTime) {
      _ticker.stop();
      _lastGlitchTime = null;
    } else {
      _lastGlitchTime = elapsedTime;
    }

    notifyListeners();
  }

  double _calculateJitterPercent(Duration dt, double jitterPhaseAdjustment) {
    final cyclePercent = dt.inMilliseconds / _glitchTime.inMilliseconds;
    final cycleMotion = sin(cyclePercent * pi);
    final jitterMotion = sin(cyclePercent * 3 * jitterPhaseAdjustment * pi + (pi / 4));

    return cycleMotion * jitterMotion;
  }
}
