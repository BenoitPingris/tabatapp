import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/i18n.dart';
import 'package:tabatapp/models/workout.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/widgets/create/number_input.dart';

class CreateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateScreenState();
  }
}

class CreateScreenState extends State<CreateScreen> {
  String name = "placeholder name".i18n;
  int prepare = 20;
  int nbSeries = 5;
  int serieDuration = 30;
  int nbCycles = 1;
  int rest = 25;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: CustomAppBar(
          title: 'create new workout'.i18n,
        ),
        body: Consumer(
          builder: (ctx, watch, _) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'name'.i18n,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          initialValue: name,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'fill in the field'.i18n;
                            }
                            return null;
                          },
                          onSaved: (String v) {
                            name = v;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        NumberInput(
                          label: 'preparation'.i18n,
                          value: '$prepare sec.',
                          enable: [prepare > 1, true],
                          notify: (i) {
                            if (prepare + i > 0)
                              setState(() {
                                prepare += i;
                              });
                          },
                        ),
                        NumberInput(
                          label: 'number series'.i18n,
                          value: '$nbSeries',
                          enable: [nbSeries > 1, true],
                          notify: (i) {
                            if (nbSeries + i > 0)
                              setState(() {
                                nbSeries += i;
                              });
                          },
                        ),
                        NumberInput(
                          label: 'serie duration'.i18n,
                          value: '$serieDuration sec.',
                          enable: [serieDuration > 1, true],
                          notify: (i) {
                            if (serieDuration + i > 0)
                              setState(() {
                                serieDuration += i;
                              });
                          },
                        ),
                        NumberInput(
                          label: 'number cycles'.i18n,
                          value: '$nbCycles',
                          enable: [nbCycles > 1, true],
                          notify: (i) {
                            if (nbCycles + i > 0)
                              setState(() {
                                nbCycles += i;
                              });
                          },
                        ),
                        NumberInput(
                          label: 'rest'.i18n,
                          value: '$rest sec.',
                          enable: [rest > 1, true],
                          separator: false,
                          notify: (i) {
                            if (rest + i > 0)
                              setState(() {
                                rest += i;
                              });
                          },
                        ),
                        SizedBox(height: 10),
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
                              Navigator.pushNamed(context, '/workouts');
                            }
                          },
                          icon: Icon(Icons.add),
                          label: Text('create'.i18n),
                        )
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
