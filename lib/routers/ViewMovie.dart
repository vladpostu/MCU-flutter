// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mcu_floor/entities/Feature.dart';
import 'package:mcu_floor/entities/Superhero.dart';
import 'package:mcu_floor/routers/ViewSuperhero.dart';

class ViewMovie extends StatefulWidget {
  ViewMovie(
      {Key? key,
      required this.id,
      required this.name,
      required this.runningTime,
      required this.releaseDate,
      required this.director,
      required this.findFeatures,
      required this.superheroes,
      required this.deleteSuperhero})
      : super(key: key);

  String name, releaseDate, director;
  int runningTime, id;
  final Stream<List<Feature>> findFeatures;
  final List<Superhero> superheroes;
  final Function deleteSuperhero;

  @override
  State<ViewMovie> createState() => _ViewMovieState();
}

class _ViewMovieState extends State<ViewMovie> {
  final textStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  String convertIds(idFeature) {
    String name = "";
    widget.superheroes.forEach((item) {
      if (item.id == idFeature) {
        name = item.name;
      }
    });

    return name;
  }

  Superhero findSuperhero(int id) {
    for (int i = 0; i < widget.superheroes.length; i++) {
      if (widget.superheroes[i].id == id) {
        return widget.superheroes[i];
      }
    }
    throw '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Name"),
            ),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Running time"),
            ),
            Text(
              "${widget.runningTime}",
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Release date"),
            ),
            Text(
              widget.releaseDate,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Director"),
            ),
            Text(
              widget.director,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Superheroes"),
            ),
            StreamBuilder(
              stream: widget.findFeatures,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List features = snapshot.data as List<Feature>;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: features.length,
                    itemBuilder: (context, index) {
                      // if (features[index].idMovie == widget.id) {
                      //   return Text("${features[index].id}");
                      // } else {
                      //   return Text("no");
                      // }
                      return SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewSuperhero(
                                        superhero: findSuperhero(
                                            features[index].idSuperhero),
                                        deleteSuperhero: widget.deleteSuperhero,
                                      )),
                            );
                          },
                          child: Text(convertIds(features[index].idSuperhero)),
                        ),
                      );
                    },
                  );
                } else {
                  return Text("no data");
                }
              },
            )
          ],
        ));
  }
}
