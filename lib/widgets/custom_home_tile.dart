import 'package:barberzlink/widgets/custom_contact_flow_btn.dart';
import 'package:flutter/material.dart';

class CustomHomeTile extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String specialization;
  final bool isVerified;
  final VoidCallback? onEmailPressed;
  final VoidCallback? onContactPressed;
  final VoidCallback onPressed;

  const CustomHomeTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.specialization,
    this.isVerified = true,
    this.onEmailPressed,
    this.onContactPressed,
    required this.onPressed,
  });

  @override
  State<CustomHomeTile> createState() => _CustomHomeTileState();
}

class _CustomHomeTileState extends State<CustomHomeTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _shadowColorAnimation;

  bool isPressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween(begin: 2.0, end: 6.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _shadowColorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0.1),
      end: Colors.black.withOpacity(0.3),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Material(
              elevation: _elevationAnimation.value,
              shadowColor: _shadowColorAnimation.value,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // 🔥 Fix for Carousel overflow
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------- PROFILE ROW ----------------
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            widget.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.name,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (widget.isVerified)
                                    const Icon(Icons.verified,
                                        color: Colors.green, size: 18),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.specialization,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Divider(color: Colors.grey.shade300, height: 1),

                    const SizedBox(height: 12),

                    // ---------------- BUTTON SECTION ----------------
                    CustomContactFlowBtn(phoneNumber: '+923097325208'),

                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
