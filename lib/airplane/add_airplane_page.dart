import 'package:flutter/material.dart';
import 'database_helper.dart';

class AddAirplanePage extends StatefulWidget {
  const AddAirplanePage({super.key});

  @override
  _AddAirplanePageState createState() => _AddAirplanePageState();
}

class _AddAirplanePageState extends State<AddAirplanePage> {
  final _formKey = GlobalKey<FormState>();
  String _type = '';
  int _passengers = 0;
  int _speed = 0;
  int _range = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Airplane'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter airplane type';
                  }
                  return null;
                },
                onSaved: (value) {
                  _type = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Passengers'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of passengers';
                  }
                  return null;
                },
                onSaved: (value) {
                  _passengers = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Maximum Speed'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter maximum speed';
                  }
                  return null;
                },
                onSaved: (value) {
                  _speed = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Range'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter range';
                  }
                  return null;
                },
                onSaved: (value) {
                  _range = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    DatabaseHelper.instance.insertAirplane(Airplane(
                      type: _type,
                      passengers: _passengers,
                      speed: _speed,
                      range: _range,
                    ));
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
