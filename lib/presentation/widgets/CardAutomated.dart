
import 'package:flutter/material.dart';
class CardAutomated extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  const CardAutomated({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,

  });

  @override
  State<CardAutomated> createState() => _CardAutomatedState();
}

class _CardAutomatedState extends State<CardAutomated> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        transform: _isPressed ? Matrix4.identity().scaled(0.97) : Matrix4.identity(),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, // Color de fondo
          borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
          border: Border.all(color:  Theme.of(context).colorScheme.outlineVariant, width: 1.0), // Borde
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Alineado al inicio en X
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Text(widget.title.isNotEmpty ? widget.title[0].toUpperCase(): ""),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
                ),
                Text(widget.description)
              ],
            )
          ],
        ),
      ),
    );
  }
}
