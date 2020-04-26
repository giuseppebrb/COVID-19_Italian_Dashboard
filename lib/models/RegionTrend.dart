class RegionTrend {
  final DateTime date;
  final int regionID;
  final String regionName;
  final double latitude;
  final double longitude;
  final int hospitalizedWithSymptoms;
  final int intensiveCare;
  final int totalHospitalized;
  final int homeIsolation;
  final int totalPositives;
  final int deltaTotalPositive;
  final int newPositives;
  final int healed;
  final int deceased;
  final int totalCases;
  final int swabs;
  final int totalTested;

  RegionTrend({
    this.date,
    this.regionID,
    this.regionName,
    this.latitude,
    this.longitude,
    this.hospitalizedWithSymptoms,
    this.intensiveCare,
    this.totalHospitalized,
    this.homeIsolation,
    this.totalPositives,
    this.deltaTotalPositive,
    this.newPositives,
    this.healed,
    this.deceased,
    this.totalCases,
    this.swabs,
    this.totalTested
  });

  factory RegionTrend.fromJson(Map<String, dynamic> json) {
    return RegionTrend(
        date: DateTime.parse((json['data'])),
        regionID: json['codice_regione'],
        regionName: json['denominazione_regione'],
        latitude: double.parse(json['lat'].toString()),
        longitude: double.parse(json['long'].toString()),
        hospitalizedWithSymptoms: json['ricoverati_con_sintomi'],
        intensiveCare: json['terapia_intensiva'],
        totalHospitalized: json['totale_ospedalizzati'],
        homeIsolation: json['isolamento_domiciliare'],
        totalPositives: json['totale_positivi'],
        deltaTotalPositive: json['variazione_totale_positivi'],
        newPositives: json['nuovi_positivi'],
        healed: json['dimessi_guariti'],
        deceased: json['deceduti'],
        totalCases: json['totale_casi'],
        swabs: json['tamponi'],
        totalTested: json['casi_testati'],
    );
  }
}