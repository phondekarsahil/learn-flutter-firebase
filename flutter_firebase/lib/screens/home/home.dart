import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/screens/home/brew_list.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: const [],
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: const Text('Brew Crew'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: [
              TextButton.icon(
                  onPressed: () async {
                    _auth.signOut();
                  },
                  icon: const Icon(Icons.person),
                  label: const Text("Logout"))
            ],
          ),
          body: const BrewList()),
    );
  }
}
