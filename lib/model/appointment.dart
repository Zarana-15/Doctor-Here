class Appointment {
  final String name;
  final String time;
  final String date;
  final String ptuid;
  final String diagnosis;
  final String patientHistory;
  final String id;

  set patientHistory(String history){
    this.patientHistory=history;
  }

  set diagnosis(String diagnosis){
    this.diagnosis=diagnosis;
  }

  Appointment({this.name, this.time, this.date, this.ptuid, this.diagnosis, this.patientHistory, this.id});
}
