import 'package:firebase_authentication_test/screens/list_emp.dart';
import 'package:firebase_authentication_test/services/firebase_operations.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contController = TextEditingController();
  TextEditingController desigController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => ListEmp(),
                    ),
                    (route) => false);
              },
              icon: Icon(Icons.menu),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: contController,
                  decoration: InputDecoration(
                    labelText: 'Contact No',
                  ),
                ),
                TextField(
                  controller: desigController,
                  decoration: InputDecoration(
                    labelText: 'Designation',
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      var r = await FirebaseOperations.addEmployee(
                          nameController.text,
                          contController.text,
                          desigController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(r),
                        ),
                      );
                    },
                    child: Text('Save'))
              ],
            ),
          ),
        ));
  }
}
