import 'package:flutter/material.dart';

import '../resources/icon_list.dart';

class IconChooser extends StatefulWidget {
  final Map formData;

  final Color highlightColor = Colors.amber;

  IconChooser(this.formData);

  @override
  State<StatefulWidget> createState() {
    return _IconChooser();
  }
}

class _IconChooser extends State<IconChooser> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: icons.length,
      itemBuilder: (context, int) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][0];
                });
              },
              icon: Icon(
                IconData(icons[int][0], fontFamily: 'MaterialIcons'),
                color: null,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][1];
                });
              },
              icon: Icon(
                IconData(icons[int][1], fontFamily: 'MaterialIcons'),
                color: null,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][2];
                });
              },
              icon: Icon(
                IconData(icons[int][2], fontFamily: 'MaterialIcons'),
                color: null,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][3];
                });
              },
              icon: Icon(
                IconData(icons[int][3], fontFamily: 'MaterialIcons'),
                color: null,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][4];
                });
              },
              icon: Icon(
                IconData(icons[int][4], fontFamily: 'MaterialIcons'),
                color: null,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][5];
                });
              },
              icon: Icon(
                IconData(icons[int][5], fontFamily: 'MaterialIcons'),
                color: null,
              ),
            ),
          ],
        );
      },
    );
  }
}
