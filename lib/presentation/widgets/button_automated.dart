import 'dart:ui';
import 'package:flutter/material.dart';
class ButtonAutomated extends StatefulWidget {
  final VoidCallback onClick;
  final String title;
  final Color color;
  const ButtonAutomated({
    super.key,
    required this.onClick,
    required this.title,
    required this.color
  });

  @override
  State<ButtonAutomated> createState() => _ButtonAutomatedState();
}

class _ButtonAutomatedState extends State<ButtonAutomated> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12,right: 12,top: 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: widget.onClick,
            child: Text(widget.title),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Bordes redondeados
              ),

            )
        ),
      ),
    );
  }
}
