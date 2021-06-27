import 'package:flutter/material.dart';

class Dialoguebox extends StatelessWidget{
  TextEditingController idcontroller= new TextEditingController();
  void _showDialog(context) {
    final _formKey = GlobalKey<FormState>();
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text('Dialogue Box'),
                content: Form(
                  key: _formKey,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 5,
                    children: <Widget>[
                      TextFormField(
                        controller: idcontroller,
                        decoration:
                        new InputDecoration(labelText: 'Text'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Text';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog

                 // joinexambutton(),
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: RaisedButton(
        onPressed: (){_showDialog(context);},
        child: Text("Dialogue Box"),
      ),
    );
  }
}