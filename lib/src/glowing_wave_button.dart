import 'package:flutter/material.dart';
import 'dart:math' as Math;

class GlowingWaveButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color primaryColor;
  final Color waveColor;
  final IconData icon;
  final double size;
  final int waveCount;
  final Duration waveDuration;
  final bool isActive;
  final bool showWaves;
  final List<String> floatingWords; // New: words to emit
  final bool emitWords; // New: whether to emit words instead of waves
  final double
      containerSizeMultiplier; // New: dynamic container size multiplier
  final double
      expansionMultiplier; // New: dynamic expansion distance multiplier
  final bool showImageInsteadIcon; // New: flag to show image instead of icon
  final Widget imageWidget; // New: path to the image to show instead of icon
  const GlowingWaveButton({
    Key? key,
    this.onPressed,
    this.primaryColor = const Color(0xFF6B73FF),
    this.waveColor = const Color(0xFF9BA3FF),
    this.icon = Icons.spa,
    this.size = 56.0,
    this.waveCount = 4,
    this.waveDuration = const Duration(seconds: 4),
    this.isActive = true,
    this.showWaves = true,
    this.showImageInsteadIcon = false,
    this.imageWidget = const SizedBox.shrink(),
    this.floatingWords = const [
      'Peace',
      'Calm',
      'Breathe',
      'Relax',
      'Serenity',
    ],
    this.emitWords = false,
    this.containerSizeMultiplier = 3.5, // Default: widget.size * 3.5
    this.expansionMultiplier = 2.0, // Default: expansion distance multiplier
  }) : super(key: key);

  @override
  State<GlowingWaveButton> createState() => _GlowingWaveButtonState();
}

class _GlowingWaveButtonState extends State<GlowingWaveButton>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _breatheController;
  late Animation<double> _waveAnimation;
  late Animation<double> _breatheAnimation;

  bool _manuallyActivated = false; // Track if FAB was manually pressed

  @override
  void initState() {
    super.initState();

    // Continuous wave animation
    _waveController = AnimationController(
      duration: widget.waveDuration,
      vsync: this,
    );

    // Gentle breathing effect for the main button - slower for relaxation
    _breatheController = AnimationController(
      duration: const Duration(
        milliseconds: 4500,
      ), // Increased from 3500 to 4500
      vsync: this,
    );

    _waveAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _waveController, curve: Curves.easeOut));

    _breatheAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOut),
    );

    // Start animations based on initial state
    _updateAnimations();
  }

  @override
  void didUpdateWidget(GlowingWaveButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Force stop animations when tab changes and isActive becomes false
    if (oldWidget.isActive != widget.isActive) {
      if (!widget.isActive) {
        // Force reset manual activation when navigating away
        _manuallyActivated = false;
      }
      _updateAnimations();
    }
  }

  void _updateAnimations() {
    final shouldAnimate = widget.isActive || _manuallyActivated;

    if (shouldAnimate && widget.showWaves) {
      // Start animations
      if (!_waveController.isAnimating) {
        _waveController.repeat();
      }
      if (!_breatheController.isAnimating) {
        _breatheController.repeat(reverse: true);
      }
    } else {
      // Force stop all animations immediately
      if (_waveController.isAnimating) {
        _waveController.stop();
      }
      if (_breatheController.isAnimating) {
        _breatheController.stop();
      }

      // Reset to initial state with a small delay to ensure clean stop
      Future.microtask(() {
        if (mounted) {
          _waveController.reset();
          _breatheController.reset();
        }
      });
    }
  }

  void _handleFABPressed() {
    // Toggle manual activation
    setState(() {
      _manuallyActivated = !_manuallyActivated;
    });

    // Ensure animations update immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateAnimations();
    });

    // Call the original onPressed callback
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _breatheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Always recalculate based on current state
    final shouldShowWaves =
        widget.showWaves && (widget.isActive || _manuallyActivated);

    return AnimatedBuilder(
      animation: Listenable.merge([_waveAnimation, _breatheAnimation]),
      builder: (context, child) {
        return SizedBox(
          width: widget.size * widget.containerSizeMultiplier,
          height: widget.size * widget.containerSizeMultiplier,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Choose between waves or words based on emitWords flag
              if (shouldShowWaves &&
                  (_waveController.isAnimating || _waveController.value > 0))
                if (widget.emitWords)
                  for (int i = 0; i < widget.waveCount; i++)
                    _buildFloatingWord(i)
                else
                  for (int i = 0; i < widget.waveCount; i++)
                    _buildWaveRipple(i),

              // Subtle glow effect - with explicit visibility check
              if (shouldShowWaves &&
                  (_breatheController.isAnimating ||
                      _breatheController.value > 0))
                _buildGlowEffect(),

              // Main FAB with conditional breathing
              Transform.scale(
                scale: shouldShowWaves && _breatheController.isAnimating
                    ? _breatheAnimation.value
                    : 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: shouldShowWaves
                        ? [
                            BoxShadow(
                              color: widget.primaryColor.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: widget.primaryColor.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                  ),
                  child: FloatingActionButton(
                    onPressed: _handleFABPressed,
                    backgroundColor: shouldShowWaves
                        ? widget.primaryColor
                        : widget.primaryColor.withOpacity(0.7),
                    elevation: 0,
                    heroTag: "relaxation_fab",
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: widget.showImageInsteadIcon
                          ? widget.imageWidget
                          : Icon(
                              shouldShowWaves
                                  ? widget.icon
                                  : Icons.spa_outlined,
                              key: ValueKey(shouldShowWaves),
                              color: Colors.white,
                              size: widget.size * 0.4,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingWord(int index) {
    final delay = index * (1.0 / widget.waveCount);
    final adjustedProgress = (_waveAnimation.value + delay) % 1.0;

    // Calculate the radius for this wave circle - dynamic expansion
    final radius = (widget.size * 0.5) +
        (adjustedProgress * widget.size * widget.expansionMultiplier);

    // Fade effect similar to wave
    final opacity = (1.0 - adjustedProgress).clamp(0.0, 1.0) * 0.7;

    // Select word for this wave circle
    final wordIndex = index % widget.floatingWords.length;
    final word = widget.floatingWords[wordIndex];

    // Calculate how many words can fit around the circle
    final circumference = 2 * Math.pi * radius;
    final wordWidth = word.length * 8.0; // Approximate word width
    final wordsAroundCircle = Math.max(
      1,
      (circumference / wordWidth * 1.5).floor(),
    );

    return Stack(
      children: [
        for (int wordPos = 0; wordPos < wordsAroundCircle; wordPos++)
          _buildWordAtPosition(
            word: word,
            radius: radius,
            position: wordPos,
            totalPositions: wordsAroundCircle,
            opacity: opacity,
            progress: adjustedProgress,
          ),
      ],
    );
  }

  Widget _buildWordAtPosition({
    required String word,
    required double radius,
    required int position,
    required int totalPositions,
    required double opacity,
    required double progress,
  }) {
    // Calculate angle for this word position
    final angle = (position * 2 * Math.pi / totalPositions);

    // Calculate x, y coordinates
    final x = radius * Math.cos(angle);
    final y = radius * Math.sin(angle);

    // Scale effect - start small, grow, then shrink
    final scale = 0.6 + (Math.sin(progress * Math.pi) * 0.4);

    return Transform.translate(
      offset: Offset(x, y),
      child: Transform.scale(
        scale: scale,
        child: Transform.rotate(
          angle: angle + Math.pi / 2, // Rotate text to follow circle
          child: Opacity(
            opacity: opacity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: widget.waveColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.waveColor.withOpacity(0.5),
                  width: 0.8,
                ),
              ),
              child: Text(
                word,
                style: TextStyle(
                  color: widget.waveColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWaveRipple(int index) {
    final delay = index * (1.0 / widget.waveCount);
    final adjustedProgress = (_waveAnimation.value + delay) % 1.0;

    final scale = 1.0 + (adjustedProgress * 2.8);
    final opacity = (1.0 - adjustedProgress).clamp(0.0, 1.0) * 0.5;
    final strokeWidth = 2.0 - (adjustedProgress * 1.2);

    return Transform.scale(
      scale: scale,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.waveColor.withOpacity(opacity),
            width: strokeWidth.clamp(0.5, 2.0),
          ),
        ),
      ),
    );
  }

  Widget _buildGlowEffect() {
    return Transform.scale(
      scale: 1.3,
      child: Container(
        width: widget.size * 0.9,
        height: widget.size * 0.9,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [widget.primaryColor.withOpacity(0.15), Colors.transparent],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}
