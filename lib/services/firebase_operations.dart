import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

class FirebaseOperations {
  static addEmployee(String name, String ctno, String desig) {
    String resp = '';
    final employee = {
      "emp_name": name,
      "designation": desig,
      "contact_no": ctno,
    };
    db
        .collection("employees")
        .add(employee)
        .whenComplete(() => resp = 'Data Saved')
        .catchError((e) {
      resp = e.toString();
    });
    return resp;
  }

  static Stream<QuerySnapshot> fetchEmployee() {
    return db.collection('employees').snapshots();
  }

  static deleteEmp(String id) {
    String resp = '';
    db
        .collection('employees')
        .doc(id)
        .delete()
        .whenComplete(() => resp = 'Data Deleted')
        .catchError((e) {
      resp = e.toString();
    });
    return resp;
  }
}
