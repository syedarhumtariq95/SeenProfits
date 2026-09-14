enum BusinessStatus { active, suspended, pending }

enum BusinessCategory {
  foodAndBeverage,
  technology,
  agriculture,
  manufacturing
}

class BusinessDetails {
  const BusinessDetails({
    required this.id,
    required this.name,
    required this.owner,
    required this.category,
    required this.email,
    required this.status,
    required this.tier,
  });

  final String id;
  final String name;
  final String owner;
  final BusinessCategory category;
  final String email;
  final BusinessStatus status;
  final String tier;
}
