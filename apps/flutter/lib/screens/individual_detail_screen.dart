import 'package:flutter/material.dart';

import '../models/individual.dart';

class IndividualDetailScreen extends StatelessWidget {
  const IndividualDetailScreen({
    super.key,
    required this.individual,
  });

  final Individual individual;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('個体詳細'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffe8e8e6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Photo',
                    style: TextStyle(
                      color: Color(0xff888888),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Individual',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff666666),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                individual.name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              _InfoRow(
                label: '識別番号',
                value: individual.id,
              ),
              _InfoRow(
                label: '性別',
                value: 'Unknown',
              ),
              _InfoRow(
                label: 'ステータス',
                value: 'Known individual',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffe5e5e5),
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xff777777),
              ),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}