import 'package:flutter/material.dart';
import 'package:flutter_firebase/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  late String _currentName;
  String _currentSugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
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
              decoration: textInputDecoration,
              validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            const SizedBox(height: 10.0),
            DropdownButtonFormField(
                value: _currentSugars,
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
              value: (_currentStrength).toDouble(),
              activeColor: Colors.brown[_currentStrength],
              inactiveColor: Colors.brown[_currentStrength],
              min: 100.0,
              max: 900.0,
              divisions: 8,
              onChanged: (val) =>
                  setState(() => _currentStrength = val.round()),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.pink[400])),
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
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
  }
}
