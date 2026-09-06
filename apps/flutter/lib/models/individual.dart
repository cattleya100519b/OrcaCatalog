class Individual {
  const Individual({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;
}

const individuals = [
  Individual(
    id: 'K-001',
    name: 'K-001',
    description: 'Adult · Known individual',
  ),
  Individual(
    id: 'K-002',
    name: 'K-002',
    description: 'Adult · Known individual',
  ),
  Individual(
    id: 'K-003',
    name: 'K-003',
    description: 'Juvenile · Known individual',
  ),
  Individual(
    id: 'K-004',
    name: 'K-004',
    description: 'Adult · Known individual',
  ),
];