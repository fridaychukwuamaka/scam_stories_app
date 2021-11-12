class ScamType {
  ScamType({
    required this.label,
  });
  final String label;


  static List<ScamType> kTypeOfScam = [
    ScamType(label: 'All'),
    ScamType(label: 'COVID-19'),
    ScamType(label: 'Love'),
    ScamType(label: 'Fake charities'),
    ScamType(label: 'Job'),
    ScamType(label: 'Threats'),
    ScamType(label: 'Investment'),
    ScamType(label: 'Unexpected money'),
    ScamType(label: 'Unexpected winnings'),
  ];

}
