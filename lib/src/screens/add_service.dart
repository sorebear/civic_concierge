import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wordpress_api_app/src/models/service_model.dart';
import 'package:wordpress_api_app/src/scoped_models/app_state.dart';
import 'dart:convert';

import '../api/api_provider.dart';
import '../widgets/text_field.dart';
import '../widgets/button.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  ApiProvider apiProvider = new ApiProvider();
  Map<String, String> _serviceData = {
    'title': '',
    'content': '',
  };

  void _updateValue(String inputKey, String inputValue) {
    Map<String, String> serviceData = _serviceData.map((dataKey, dataValue) {
      if (dataKey == inputKey) {
        dataValue = inputValue;
      }

      return MapEntry(dataKey, dataValue);
    });

    setState(() => _serviceData = serviceData);
  }

  void _submit(AppState model, context) async {
    ServiceModel newService = await model.addService(
      _serviceData['title'],
      _serviceData['content'],
    );

    print('[Response]');
    print(newService);

    if (newService != null) {
      Navigator.pop(context);
    }
  }

  bool _isSubmitEnabled() {
    return _serviceData['title'].length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder: (BuildContext context, child, AppState model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Service', style: Theme.of(context).textTheme.display3),
            elevation: 0,
          ),
          body: Material(
            color: Theme.of(context).primaryColor,
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ThemedTextField(
                      onChanged: (val) => _updateValue('title', val),
                      label: 'Service Name',
                    ),
                    ThemedTextField(
                      onChanged: (val) => _updateValue('content', val),
                      minLines: 4,
                      label: 'Content',
                    ),
                    SizedBox(height: 32.0),
                    ThemedButton(
                      action: _isSubmitEnabled()
                          ? () => _submit(model, context)
                          : null,
                      text: 'Create',
                    ),
                    SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
