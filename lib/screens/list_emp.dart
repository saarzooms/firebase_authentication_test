import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication_test/screens/add_employee.dart';
import 'package:firebase_authentication_test/services/firebase_operations.dart';
import 'package:flutter/material.dart';

class ListEmp extends StatefulWidget {
  const ListEmp({super.key});

  @override
  State<ListEmp> createState() => _ListEmpState();
}

class _ListEmpState extends State<ListEmp> {
  Stream<QuerySnapshot> collection = FirebaseOperations.fetchEmployee();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: collection,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData)
            return ListView(
              children: snapshot.data!.docs
                  .map((emp) => ListTile(
                        trailing: IconButton(
                          onPressed: () async {
                            var r = await FirebaseOperations.deleteEmp(emp.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(r),
                              ),
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                        title: Text(
                          emp['emp_name'],
                        ),
                        subtitle: Text(emp['contact_no']),
                      ))
                  .toList(),
            );
          else
            return Container();
        },
      )),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEmployee(),
        ));
      }),
    );
  }
}
