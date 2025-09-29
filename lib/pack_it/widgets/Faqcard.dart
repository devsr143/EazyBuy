import 'package:flutter/material.dart';

class FaqCard extends StatelessWidget {
  final String question;
  final String answer;
  const FaqCard({super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ExpansionTile(
        title: Text(question,
          style: TextStyle(
              fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(padding: EdgeInsets.all(12),
            child: Text(answer,
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ),
        ],
      ),
    );
  }
}