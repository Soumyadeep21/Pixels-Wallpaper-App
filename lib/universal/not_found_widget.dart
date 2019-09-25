import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline,size: MediaQuery.of(context).size.width / 3.5,),
          Text('Oops! Nothing Found :(',style: TextStyle(fontSize: MediaQuery.of(context).size.width / 17),)
        ],
      );
  }
}