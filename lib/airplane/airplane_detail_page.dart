import 'package:flutter/material.dart';
import 'database_helper.dart';

class AirplaneDetailPage extends StatefulWidget {
  final Airplane airplane;

  const AirplaneDetailPage({Key? key, required this.airplane}) : super(key: key);

  @override
  _AirplaneDetailPageState createState() => _AirplaneDetailPageState();
}

class _AirplaneDetailPageState extends State<AirplaneDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late String _type;
  late int _passengers;
  late int _speed;
  late int _range;

  @override
  void initState() {
    super.initState();
    _type = widget.airplane.type;
    _passengers = widget.airplane.passengers;
    _speed = widget.airplane.speed;
    _range = widget.airplane.range;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await DatabaseHelper.instance.deleteAirplane(widget.airplane.id!);
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: _type,
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
                initialValue: _passengers.toString(),
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
                initialValue: _speed.toString(),
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
                initialValue: _range.toString(),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await DatabaseHelper.instance.updateAirplane(Airplane(
                      id: widget.airplane.id,
                      type: _type,
                      passengers: _passengers,
                      speed: _speed,
                      range: _range,
                    ));
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
