import 'package:flutter/material.dart';

class DeleteHint extends StatelessWidget {
  const DeleteHint();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: const Icon(Icons.delete),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
