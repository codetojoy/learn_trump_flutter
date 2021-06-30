import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/config.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';

class ConfigForm extends StatefulWidget {
  static const routeName = '/config';

  @override
  ConfigFormState createState() {
    return ConfigFormState();
  }
}

class ConfigFormState extends State<ConfigForm> {
  final _formKey = GlobalKey<FormState>();
  final _numCardsController = TextEditingController();
  String _modeValue = Const.MODE_MIXED_CARDS;

  @override
  Widget build(BuildContext context) {
    var routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    var config = routeArgs[Const.CONFIG_PARAM] as Config;
    return Scaffold(
      appBar: AppBar(
        title: Text('Config'),
      ),
      body: _buildForm(context, config),
    );
  }

  Widget _buildForm(BuildContext context, Config config) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: new InputDecoration(labelText: '# rounds:'),
            keyboardType: TextInputType.number,
            controller: _numCardsController,
            validator: (value) {
              if (!config.isValidNumRounds(value)) {
                return '# rounds must be integer';
              } else {
                config.numRounds = int.parse(value!);
              }
              return null;
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'game mode:'),
            value: Const.MODE_MIXED_CARDS,
            items: <String>[Const.MODE_MIXED_CARDS, Const.MODE_PURE_SUIT]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              L.log('TRACER drop down $value');
              _modeValue = value as String;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  int numRounds = int.parse(_numCardsController.text);
                  config.numRounds = numRounds;
                  var mode = Mode.values
                      .firstWhere((e) => e.toString() == 'Mode.' + _modeValue);
                  ;
                  config.mode = mode;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: const Text('Saved!')));
                }
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}