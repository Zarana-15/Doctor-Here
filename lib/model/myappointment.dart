class MyAppointment {
  final String name;
  final String time;
  final String date;
  final String drname;
  final String druid;
  final String diagnosis;
  final String patientHistory;
  final String id;

  set patientHistory(String history) {
    this.patientHistory = history;
  }

  set diagnosis(String diagnosis) {
    this.diagnosis = diagnosis;
  }

  MyAppointment(
      {this.name,
      this.time,
      this.date,
      this.drname,
      this.druid,
      this.diagnosis,
      this.patientHistory,
      this.id});
}
