import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TranslucentCard extends StatefulWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final String? assetPath;
  final VoidCallback onTap;
  final double width;
  final double height;

  const TranslucentCard({
    Key? key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.assetPath,
    required this.onTap,
    this.width = 150,
    this.height = 150,
  }) : assert(imageUrl != null || assetPath != null,
  'Debe proporcionar imageUrl o assetPath'),
        super(key: key);

  @override
  _TranslucentCardState createState() => _TranslucentCardState();
}

class _TranslucentCardState extends State<TranslucentCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(

        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        transform: _isPressed ? Matrix4.identity().scaled(0.97) : Matrix4.identity(),
        width: widget.width,
        height: widget.height,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.greenAccent, // Verde claro
              Colors.teal// Verde fuerte para profundidad
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(12),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Imagen
                if (widget.imageUrl != null)
                  Expanded(
                    child: Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50),
                    ),
                  )
                else if (widget.assetPath != null)
                  Expanded(
                    child: widget.assetPath!.endsWith('.svg')
                        ? SvgPicture.asset(widget.assetPath!,
                        width: 80, height: 80)
                        : Image.asset(widget.assetPath!, fit: BoxFit.contain),
                  ),

                const SizedBox(height: 8),

                // Título
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 4),

                // Descripción

              ],
            ),
          ),
        ),
      ),
    );
  }
}
