import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/models/training.dart';
import 'package:tabatapp/widgets/appbar.dart';

class CreateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateScreenState();
  }
}

class CreateScreenState extends State<CreateScreen> {
  String name = "Mon super entraînement";
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
          return 'Veuillez renseigner ce champ';
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
          title: 'Créer un nouvel entraînement',
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
                          decoration: InputDecoration(labelText: 'Nom'),
                          initialValue: name,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Veuillez renseigner ce champ';
                            }
                            return null;
                          },
                          onSaved: (String v) {
                            name = v;
                          },
                        ),
                        _buildField('Préparation', prepare, (v) {
                          prepare = v;
                        }),
                        _buildField('Nombre de série', nbSeries, (v) {
                          nbSeries = v;
                        }),
                        _buildField('Durée d\'une série', serieDuration, (v) {
                          serieDuration = v;
                        }),
                        _buildField('Nombre de cycle', nbCycles, (v) {
                          nbCycles = v;
                        }),
                        _buildField('Repos', rest, (v) {
                          rest = v;
                        }),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              var t = Training(
                                  name: name,
                                  rest: rest,
                                  prepare: prepare,
                                  nbSeries: nbSeries,
                                  serieDuration: serieDuration,
                                  nbCycles: nbCycles);
                              await t.create();
                              Scaffold.of(ctx).showSnackBar(SnackBar(
                                content: Text('$name a été crée !'),
                              ));
                              Navigator.pushNamed(context, '/trainings');
                            }
                          },
                          icon: Icon(Icons.add),
                          label: Text('Créer'),
                        )
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
