import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  SearchTextField({@required this.controller, @required this.onSubmitted});

  final TextEditingController controller;
  final Function onSubmitted;

  @override
  _SearchTextFieldState createState() =>
      _SearchTextFieldState(controller, onSubmitted);
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool isClearButtonVisible = false;
  final TextEditingController controller;
  final Function onSubmitted;
  _SearchTextFieldState(this.controller, this.onSubmitted);
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        isClearButtonVisible = controller.text.length > 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      borderRadius: BorderRadius.circular(30.0),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Example : flowers,cars,etc',
          contentPadding: EdgeInsets.all(16.0),
          suffixIcon: AnimatedOpacity(
            opacity: isClearButtonVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 100),
            child: GestureDetector(
              child: Icon(Icons.clear,color: Colors.grey,),
              onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) => controller.clear()),
            ),
          ),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
