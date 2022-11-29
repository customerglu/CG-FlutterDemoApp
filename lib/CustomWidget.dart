import 'package:flutter/material.dart';
class MyCustomWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyCustomWidgetState();
  }


}
class _MyCustomWidgetState extends State<MyCustomWidget> {
  Color _color = Colors.white;
  String _label = 'Unfocused';

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(
        builder: (context) {
          final bool hasPrimary = Focus.of(context).hasPrimaryFocus;
          print('Building with primary focus: $hasPrimary');
          return const SizedBox(width: 100, height: 100);
        },
      ),
    );

  }
}