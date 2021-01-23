import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/models/training.dart';
import 'package:tabatapp/store/trainings.dart';
import 'package:tabatapp/widgets/appbar.dart';

class CreateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateScreenState();
  }
}

class CreateScreenState extends State<CreateScreen> {
  String name = "Mon super entrainement";
  int prepare = 20;
  int nbSeries = 5;
  int timeSerie = 30;
  int nbCycle = 1;
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
          title: 'Creer un nouvel entrainement',
        ),
        body: Consumer(
          builder: (ctx, watch, _) {
            final trainings = watch(trainingsProvider.state);
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
                        _buildField('Preparation', prepare, (v) {
                          prepare = v;
                        }),
                        _buildField('Nombre de serie', nbSeries, (v) {
                          nbSeries = v;
                        }),
                        _buildField('Duree d\'une serie', timeSerie, (v) {
                          timeSerie = v;
                        }),
                        _buildField('Nombre de cycle', nbCycle, (v) {
                          nbCycle = v;
                        }),
                        _buildField('Repos', rest, (v) {
                          rest = v;
                        }),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              context.read(trainingsProvider).add(Training(
                                  name: name,
                                  rest: rest,
                                  prepare: prepare,
                                  nbSeries: nbSeries,
                                  timeSerie: timeSerie,
                                  nbCycle: nbCycle));
                              Scaffold.of(ctx).showSnackBar(SnackBar(
                                content: Text('$name a ete cree !'),
                              ));
                            }
                          },
                          child: Text('Creer'),
                        )
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
