import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/custom_user.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  var _currentName;
  var _currentSugars;
  var _currentStrength;

  @override
  Widget build(BuildContext context) {
    CustomUser user = Provider.of<CustomUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Update your brew settings",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userData!.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButtonFormField(
                        value: _currentSugars ?? userData.sugars,
                        items: sugars
                            .map((sugar) => DropdownMenuItem(
                                  value: sugar,
                                  child: Text("$sugar sugars"),
                                ))
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _currentSugars = val.toString())),
                    const SizedBox(height: 10.0),
                    Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink[400])),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
