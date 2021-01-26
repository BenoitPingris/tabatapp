import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/global.dart';
import 'package:tabatapp/models/workout.dart';
import 'package:tabatapp/widgets/appbar.dart';

class CreateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateScreenState();
  }
}

class CreateScreenState extends State<CreateScreen> {
  String name = translate("placeholder name");
  int prepare = 20;
  int nbSeries = 5;
  int serieDuration = 30;
  int nbCycles = 1;
  int rest = 25;

  Widget _buildField(
      String labelText, int initialValue, void Function(int) onSaved) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: labelText),
      initialValue: initialValue.toString(),
      validator: (v) {
        if (v.isEmpty) {
          return translate('fill in the field');
        }
        return null;
      },
      onSaved: (String v) {
        onSaved(int.parse(v));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: CustomAppBar(
          title: translate('create new workout'),
        ),
        body: Consumer(
          builder: (ctx, watch, _) {
            return Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: translate('name')),
                          initialValue: name,
                          validator: (v) {
                            if (v.isEmpty) {
                              return translate('fill in the field');
                            }
                            return null;
                          },
                          onSaved: (String v) {
                            name = v;
                          },
                        ),
                        _buildField(translate('preparation'), prepare, (v) {
                          prepare = v;
                        }),
                        _buildField(translate('number series'), nbSeries, (v) {
                          nbSeries = v;
                        }),
                        _buildField(translate('serie duration'), serieDuration,
                            (v) {
                          serieDuration = v;
                        }),
                        _buildField(translate('number cycles'), nbCycles, (v) {
                          nbCycles = v;
                        }),
                        _buildField(translate('rest'), rest, (v) {
                          rest = v;
                        }),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              var t = Workout(
                                  name: name,
                                  rest: rest,
                                  prepare: prepare,
                                  nbSeries: nbSeries,
                                  serieDuration: serieDuration,
                                  nbCycles: nbCycles);
                              await t.create();
                              Scaffold.of(ctx).showSnackBar(SnackBar(
                                content: Text(translate('workout created',
                                    args: {'name': name})),
                              ));
                              Navigator.pushNamed(context, '/workouts');
                            }
                          },
                          icon: Icon(Icons.add),
                          label: Text(translate('create')),
                        )
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
