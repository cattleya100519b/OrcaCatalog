import 'package:flutter/material.dart';

import '../models/individual.dart';
import '../screens/individual_detail_screen.dart';

class IndividualCard extends StatelessWidget {
  const IndividualCard({
    super.key,
    required this.individual,
  });

  final Individual individual;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => IndividualDetailScreen(
                individual: individual,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                color: const Color(0xffe8e8e6),
                alignment: Alignment.center,
                child: const Text(
                  'Photo',
                  style: TextStyle(
                    color: Color(0xff888888),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    individual.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    individual.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff777777),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}