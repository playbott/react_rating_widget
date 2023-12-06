import 'dart:async';

import 'package:flutter/material.dart';

class ReactRatingWidget extends StatelessWidget {
  ReactRatingWidget({
    required this.count,
    required this.initValue,
    required this.onChanged,
    this.inActiveWidget,
    this.activeWidget,
    super.key,
  });

  final int count;
  final int initValue;
  final IconData? inActiveWidget;
  final IconData? activeWidget;
  final ValueChanged<int> onChanged;

  final _reactStreamController = StreamController<int>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (idx) {
        return Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            icon: StreamBuilder<int>(
                stream: _reactStreamController.stream,
                initialData: initValue,
                builder: (context, snapshot) {
                  bool selected = idx < (snapshot.data ?? 0);

                  return Icon(selected ? (inActiveWidget ?? Icons.star_outlined) : (activeWidget ?? Icons.star_border));
                }),
            onPressed: () {
              _reactStreamController.add(idx + 1);
              onChanged(idx + 1);
            },
          ),
        );
      }),
    );
  }
}
