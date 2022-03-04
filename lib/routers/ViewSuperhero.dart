// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mcu_floor/entities/Superhero.dart';

class ViewSuperhero extends StatefulWidget {
  const ViewSuperhero(
      {Key? key, required this.superhero, required this.deleteSuperhero})
      : super(key: key);

  final Superhero superhero;
  final Function deleteSuperhero;

  @override
  State<ViewSuperhero> createState() => _ViewSuperheroState();
}

class _ViewSuperheroState extends State<ViewSuperhero> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.superhero.name,
        ),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("Name"),
          ),
          Text(
            widget.superhero.name,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Powers",
            ),
          ),
          Text(
            widget.superhero.powers,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Power ranking",
            ),
          ),
          Text(
            '${widget.superhero.powerRanking}',
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          ElevatedButton(
              onPressed: () {
                widget.deleteSuperhero(widget.superhero);
                Navigator.pop(context);
              },
              child: Text("Delete")),
        ]),
      ),
    );
  }
}
