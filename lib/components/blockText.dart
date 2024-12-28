import 'package:flutter/material.dart';

class BlockquoteList extends StatelessWidget {
  final List<String> items;
  final double indentation;
  final Color borderColor;
  final Color backgroundColor;

  const BlockquoteList({
    super.key,
    required this.items,
    this.indentation = 16.0,
    this.borderColor = Colors.grey,
    this.backgroundColor = const Color(0xFFF5F5F5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: borderColor,
            width: 4.0,
          ),
        ),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => _buildListItem(item)).toList(),
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0, left: indentation),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8.0, right: 8.0),
            width: 6.0,
            height: 6.0,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 20.0,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
