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

void _resetColor() {
  for (List i in icons) {
    i.forEach((f) => f['color'] = [158, 158, 158]);
  }
}

class _IconChooser extends State<IconChooser> {
  @override
  Widget build(BuildContext context) {
    _resetColor();
    return ListView.builder(
      itemCount: icons.length,
      itemBuilder: (context, int) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][0]['icon'];
                  _resetColor();
                  icons[int][0]['color'] = [100, 181, 246];
                });
              },
              icon: Icon(
                IconData(icons[int][0]['icon'], fontFamily: 'MaterialIcons'),
                color: Color.fromRGBO(icons[int][0]['color'][0],
                    icons[int][0]['color'][1], icons[int][0]['color'][2], 1),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][1]['icon'];
                  _resetColor();
                  icons[int][1]['color'] = [100, 181, 246];
                });
              },
              icon: Icon(
                IconData(icons[int][1]['icon'], fontFamily: 'MaterialIcons'),
                color: Color.fromRGBO(icons[int][1]['color'][0],
                    icons[int][1]['color'][1], icons[int][1]['color'][2], 1),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][2]['icon'];
                  _resetColor();
                  icons[int][2]['color'] = [100, 181, 246];
                });
              },
              icon: Icon(
                IconData(icons[int][2]['icon'], fontFamily: 'MaterialIcons'),
                color: Color.fromRGBO(icons[int][2]['color'][0],
                    icons[int][2]['color'][1], icons[int][2]['color'][2], 1),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][3]['icon'];
                  _resetColor();
                  icons[int][3]['color'] = [100, 181, 246];
                });
              },
              icon: Icon(
                IconData(icons[int][3]['icon'], fontFamily: 'MaterialIcons'),
                color: Color.fromRGBO(icons[int][3]['color'][0],
                    icons[int][3]['color'][1], icons[int][3]['color'][2], 1),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][4]['icon'];
                  _resetColor();
                  icons[int][4]['color'] = [100, 181, 246];
                });
              },
              icon: Icon(
                IconData(icons[int][4]['icon'], fontFamily: 'MaterialIcons'),
                color: Color.fromRGBO(icons[int][4]['color'][0],
                    icons[int][4]['color'][1], icons[int][4]['color'][2], 1),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.formData['icon'] = icons[int][5]['icon'];
                  _resetColor();
                  icons[int][5]['color'] = [100, 181, 246];
                });
              },
              icon: Icon(
                IconData(icons[int][5]['icon'], fontFamily: 'MaterialIcons'),
                color: Color.fromRGBO(icons[int][5]['color'][0],
                    icons[int][5]['color'][1], icons[int][5]['color'][2], 1),
              ),
            ),
          ],
        );
      },
    );
  }
}
