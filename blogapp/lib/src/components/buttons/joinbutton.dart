import 'package:flutter/material.dart';

class JoinButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
       // _showDialog();
      },
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Join Classroom',
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}