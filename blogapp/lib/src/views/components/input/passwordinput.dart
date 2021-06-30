import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool obsecure;
  final Function changeObsecure;
  PasswordInput(this.obsecure, this.textEditingController, this.changeObsecure);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      //color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 8),
              child: Text(
                "Password",
                style: TextStyle(
                  fontFamily: "Lucidasans",
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
              //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //color: Colors.white,
              child: TextFormField(
            obscureText: !obsecure,
            controller: textEditingController,
            style: TextStyle(
                fontFamily: "Lucidasans",
                fontSize: 19,
                color: Color(0xff0962ff),
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    obsecure ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: this.changeObsecure),
              //hintText: widget.inputHint,
              hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[350],
                  fontWeight: FontWeight.w600),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 27, horizontal: 25),
              focusColor: Color(0xff0962ff),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
