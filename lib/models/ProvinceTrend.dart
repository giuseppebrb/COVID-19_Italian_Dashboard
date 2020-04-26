class ProvinceTrend {
  final DateTime date;
  final int regionID;
  final String regionName;
  final int provinceID;
  final String provinceName;
  final String provinceAbbreviation;
  final double latitude;
  final double longitude;
  final int totalCases;

  ProvinceTrend({
    this.date,
    this.regionID,
    this.regionName,
    this.provinceID,
    this.provinceName,
    this.provinceAbbreviation,
    this.latitude,
    this.longitude,
    this.totalCases
  });

  factory ProvinceTrend.fromJson(Map<String, dynamic> json) {
    return ProvinceTrend(
      date: DateTime.parse((json['data'])),
      regionID: json['codice_regione'],
      regionName: json['denominazione_regione'],
      provinceID: json['codice_provincia'],
      provinceName: json['denominazione_provincia'],
      provinceAbbreviation: json['sigla_provincia'],
      latitude: double.parse(json['lat'].toString()),
      longitude: double.parse(json['long'].toString()),
      totalCases: json['totale_casi']
    );
  }
}