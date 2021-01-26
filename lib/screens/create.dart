import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/global.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          translate('name'),
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
                              return translate('fill in the field');
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
                          label: translate('preparation'),
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
                          label: translate('number series'),
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
                          label: translate('serie duration'),
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
                          label: translate('number cycles'),
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
                          label: translate('rest'),
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
