import 'package:flutter/material.dart';

class CreateRadioButtons extends StatefulWidget {
  final Map formData;

  CreateRadioButtons(this.formData);

  @override
  State<StatefulWidget> createState() {
    return _CreateRadioButtons();
  }
}

class _CreateRadioButtons extends State<CreateRadioButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                onChanged: (value) {
                  setState(() {
                    widget.formData['permissions'] = value;
                  });
                },
                groupValue: widget.formData['permissions'],
                value: 'Full',
              ),
              Text('Full permissions')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                onChanged: (value) {
                  setState(() {
                    widget.formData['permissions'] = value;
                  });
                },
                groupValue: widget.formData['permissions'],
                value: 'Partial',
              ),
              Text('Limited permissions')
            ],
          ),
        ],
      ),
    );
  }
}
