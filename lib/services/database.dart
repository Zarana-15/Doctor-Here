import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_here/model/appointment.dart';
import 'package:doctor_here/model/clinic.dart';
import 'package:doctor_here/model/myappointment.dart';
import 'package:doctor_here/model/pharmacies.dart';
import 'package:doctor_here/model/schedule.dart';
import 'package:doctor_here/model/user.dart';
import 'package:doctor_here/model/ambulance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

String ud, druid;

getUid() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User user = auth.currentUser;
  //print(user.uid.toString());
  ud = user.uid.toString();
  print(ud);
}

getDocUid(String drname) async {
  var result = await FirebaseFirestore.instance
      .collection("users")
      .where("name", isEqualTo: "$drname")
      .where("user type", isEqualTo: "doctor")
      .get();

  result.docs.forEach((res) {
    if (res.data()["uid"] != null) return druid = res.data()["uid"];
  });
}

getPatUid(String ptname) async {
  var result = await FirebaseFirestore.instance
      .collection("users")
      .where("name", isEqualTo: "$ptname")
      .where("user type", isEqualTo: "patient")
      .get();

  result.docs.forEach((res) async {
    if (res.data()["uid"] != null) return druid = await res.data()["uid"];
  });
}

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  int pincode = 0;

  // Collection reference
  // final CollectionReference appointmentCollection =
  //     Firestore.instance.collection('doctor/ebyD7i0Xqk7joFlqAh0x/patient log');

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // .then((value) => y = value);
  // final CollectionReference myappointmentCollection = Firestore.instance
  //     .collection('patient')
  //     .doc(ud)
  //     .collection('my appointment');

  final CollectionReference ambulanceCollection =
      FirebaseFirestore.instance.collection('ambulance');

  final CollectionReference clinicCollection =
      FirebaseFirestore.instance.collection('doctor');

  final CollectionReference pharmaciesCollection =
      FirebaseFirestore.instance.collection('pharmacies');

  //  list from snapshot
  List<Appointment> _appointmentListFromSnapshot(QuerySnapshot snapshot) {
    getUid();
    return snapshot.docs.map((doc) {
      return Appointment(
          name: doc.data()['name'] ?? '',
          time: doc.data()['time'] ?? '0:00AM',
          date: doc.data()['date'] ?? '01/01/2020',
          ptuid: doc.data()['ptuid'] ?? '',
          diagnosis: doc.data()['diagnosis'] ?? '',
          patientHistory: doc.data()['patient history'] ?? '',
          id: doc.id);
    }).toList();
  }

  // Get brews stream
  Stream<List<Appointment>> get appointment {
    getUid();
    return FirebaseFirestore.instance
        .collection('doctor/$ud/patient log')
        .orderBy('date')
        .snapshots()
        .map(_appointmentListFromSnapshot);
  }

  List<Schedule> _scheduleListFromSnapshot(QuerySnapshot snapshot) {
    getUid();
    return snapshot.docs.map((doc) {
      return Schedule(
          name: doc.data()['name'] ?? '',
          time: doc.data()['time'] ?? '0:00AM',
          date: doc.data()['date'] ?? '01/01/2020');
    }).toList();
  }

  // Get brews stream
  Stream<List<Schedule>> get schedule {
    getUid();
    // var now = DateTime.now();
    // String today = DateFormat('dd/MM/yyyy').format(now);
    // print(today);
    if (druid != null) {
      return FirebaseFirestore.instance
          .collection('doctor/$druid/patient log')
          //.where('date', isEqualTo: today)
          .snapshots()
          .map(_scheduleListFromSnapshot);
    }
    return null;
  }

  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(uid: uid, name: snapshot.data['name'], usertype: snapshot.data['user type']);
  // }

  // // Get user doc
  // Stream<UserData> get userData {
  //   return userCollection
  //       .doc(uid)
  //       .snapshots()
  //       .map(_userDataFromSnapshot);
  // }
  List<MyAppointment> _myappointmentListFromSnapshot(QuerySnapshot snapshot) {
    //print(ud);
    getUid();
    return snapshot.docs.map((doc) {
      return MyAppointment(
          name: doc.data()['name'] ?? '',
          time: doc.data()['time'] ?? '0:00AM',
          date: doc.data()['date'] ?? '1/1/2020',
          drname: doc.data()['drname'] ?? 'abc',
          druid: doc.data()['druid'] ?? '',
          diagnosis: doc.data()['diagnosis'] ?? '',
          patientHistory: doc.data()['patient history'] ?? '',
          id: doc.id);
    }).toList();
  }

  // Get brews stream
  Stream<List<MyAppointment>> get myappointment {
    getUid();
    return FirebaseFirestore.instance
        .collection('patient')
        .doc(ud)
        .collection('my appointment')
        .snapshots()
        .map(_myappointmentListFromSnapshot);
  }

  List<Ambulance> _ambulanceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Ambulance(
          name: doc.data()['name'] ?? 'XYZ',
          phone: doc.data()['phone'] ?? '0000000000',
          pincode: doc.data()['pincode'] ?? '400000');
    }).toList();
  }

  Stream<List<Ambulance>> get ambulance {
    final pin = GetStorage();
    pincode = pin.read('pincode');
    return ambulanceCollection
        .where("pincode", isLessThan: (pincode + 6))
        .where("pincode", isGreaterThan: (pincode - 6))
        .snapshots()
        .map(_ambulanceListFromSnapshot);
  }

  List<Clinic> _clinicListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Clinic(
          drname: doc.data()['name'] ?? 'XYZ',
          phone: doc.data()['contact no'] ?? '0000000000',
          pincode: doc.data()['pincode'] ?? 400000,
          clinicname: doc.data()['clinic name'] ?? 'ABC',
          address: doc.data()['clinic address'] ?? 'x,y,z',
          speciality: doc.data()['speciality'] ?? 'doctor',
          timing: doc.data()['clinic timing'] ?? '0:00AM',
          druid: doc.data()['id'] ?? '');
    }).toList();
  }

  Stream<List<Clinic>> get clinic {
    final pin = GetStorage();
    pincode = pin.read('pincode');
    //print(pincode);
    return clinicCollection
        .where("ispending", isEqualTo: false)
        .where("pincode", isLessThan: (pincode + 4))
        .where("pincode", isGreaterThan: (pincode - 4))
        .snapshots()
        .map(_clinicListFromSnapshot);
  }

  Stream<List<Clinic>> get search {
    //print(pincode);
    return FirebaseFirestore.instance
        .collection('doctor')
        .where("ispending", isEqualTo: false)
        .snapshots()
        .map(_clinicListFromSnapshot);
  }

  List<Pharmacies> _pharmaciesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Pharmacies(
          name: doc.data()['name'] ?? 'XYZ',
          phone: doc.data()['phone no.'] ?? '0000000000',
          pincode: doc.data()['pincode'] ?? '400000',
          address: doc.data()['address'] ?? '',
          timing: doc.data()['timing'] ?? '0:00AM-0:00AM');
    }).toList();
  }

  Stream<List<Pharmacies>> get pharmacies {
    final pin = GetStorage();
    pincode = pin.read('pincode');
    return pharmaciesCollection
        .where("pincode", isLessThan: (pincode + 4))
        .where("pincode", isGreaterThan: (pincode - 4))
        .snapshots()
        .map(_pharmaciesListFromSnapshot);
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;

Future updateUserData(String name, String usertype) async {
  final User user = auth.currentUser;
  UserData(name: name, uid: user.uid, usertype: usertype);
  return await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
      {'name': name, 'uid': user.uid, 'user type': usertype},
      SetOptions(merge: true));
}

Future<String> userTypeCheck() async {
  final User user = auth.currentUser;
  var uid = user.uid;
  var x;
  await FirebaseFirestore.instance
      .collection("users")
      .doc("$uid")
      .get()
      .then((value) {
    //print("Hello::" + value.data["user type"]);
    if (value.exists) {
      x = value.data()["user type"];
    } else {
      print("No document");
      x = "no";
    }
  });
  return x;
}

Future updateDocData(String name, String phoneno, String speciality,
    String clinicName, String clinicAdd, int pincode, String clinicTime) async {
  final User user = auth.currentUser;
  return await FirebaseFirestore.instance
      .collection('doctor')
      .doc(user.uid)
      .set({
    'name': name,
    'contact no': phoneno,
    'speciality': speciality,
    'clinic name': clinicName,
    'clinic address': clinicAdd,
    'clinic timing': clinicTime,
    'pincode': pincode,
    'ispending': true
  }, SetOptions(merge: true));
}

Future updatePatData(String name, String phoneno) async {
  final User user = auth.currentUser;
  return await FirebaseFirestore.instance
      .collection('patient')
      .doc(user.uid)
      .set({'name': name, 'contact no': phoneno}, SetOptions(merge: true));
}

String xuid = DateTime.now().millisecondsSinceEpoch.toString();
Future updateAppointmentData(
    String name, String time, String date, String drname, String druid) async {
  getUid();
  // String druid;

  // var result = await FirebaseFirestore.instance
  //     .collection("users")
  //     .where("name", isEqualTo: "${drname.trim()}")
  //     .where("user type", isEqualTo: "doctor")
  //     .get();

  // result.docs.forEach((res) {
  //   druid = res.data()["uid"];
  // });
  if (druid != null) {
    return await FirebaseFirestore.instance
        .collection('doctor/$druid/patient log')
        .doc(xuid)
        .set({
      'name': name,
      'time': time,
      'date': date,
      'ptuid': auth.currentUser.uid,
    }, SetOptions(merge: true));
  }
}

// Future getClinicInfo(String uid) async {
//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(uid)
//       .get()
//       .then((value) {
//     return value;
//   });
// }

// Future<String> userCheck(String uid) async {
//   var exists = 'false';
//   try {
//     await FirebaseFirestore.instance
//         .collection("users")
//         .where("uid", isEqualTo: "$uid")
//         .getdocs()
//         .then((doc) {
//       doc.docs.forEach((element) {
//         print(element.data);
//       });
//       if (doc.docs != null) {
//         exists = 'true';
//       } else {
//         exists = 'false';
//       }
//     });
//     return exists;
//   } catch (e) {
//     return 'false';
//   }
// }

Future updateMyAppointment(
    String name, String time, String date, String drname, String drid) async {
  getUid();
  //String druid;

  // var result = await FirebaseFirestore.instance
  //     .collection("users")
  //     .where("name", isEqualTo: "$drname")
  //     .where("user type", isEqualTo: "doctor")
  //     .get();

  // result.docs.forEach((res) {
  //   druid = res.data()["uid"];
  // });

  if (drid != null) {
    return await FirebaseFirestore.instance
        .collection('patient/$ud/my appointment')
        .doc(xuid)
        .set({
      'name': name,
      'time': time,
      'date': date,
      'drname': drname,
      'druid': drid
    }, SetOptions(merge: true));
  }
}

Future updatePatientHistory(String history, String id, String ptuid) async {
  final User user = auth.currentUser;

  await FirebaseFirestore.instance
      .collection('patient')
      .doc(ptuid)
      .collection('my appointment')
      .doc(id)
      .set({'patient history': history}, SetOptions(merge: true));

  return await FirebaseFirestore.instance
      .collection('doctor')
      .doc(user.uid)
      .collection('patient log')
      .doc(id)
      .set({'patient history': history}, SetOptions(merge: true));
}

Future updateDiagnosis(String diagnosis, String id, String ptuid) async {
  final User user = auth.currentUser;

  await FirebaseFirestore.instance
      .collection('patient')
      .doc(ptuid)
      .collection('my appointment')
      .doc(id)
      .set({'diagnosis': diagnosis}, SetOptions(merge: true));

  return await FirebaseFirestore.instance
      .collection('doctor')
      .doc(user.uid)
      .collection('patient log')
      .doc(id)
      .set({'diagnosis': diagnosis}, SetOptions(merge: true));
}
