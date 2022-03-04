// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_const_constructors, must_call_super

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mcu_floor/entities/Feature.dart';
import 'package:mcu_floor/entities/Movie.dart';

import 'package:mcu_floor/entities/Superhero.dart';

class AddMovie extends StatefulWidget {
  AddMovie({
    Key? key,
    required this.insertMovie,
    required this.getAllSuperheroes,
    required this.insertFeature,
    required this.getAllMovies,
  }) : super(key: key);

  final Function insertMovie, getAllMovies;
  final List<Superhero> getAllSuperheroes;
  final Function insertFeature;

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  var nameController = TextEditingController();
  var rtController = TextEditingController();
  var rdController = TextEditingController();
  var directorController = TextEditingController();

  late List<Superhero> superheroes = widget.getAllSuperheroes;
  bool movieInsert = false;
  int lastIdMovie = 0;
  late int idSuperhero;

  @override
  void initState() {
    setState(() {
      idSuperhero = (superheroes.first.id)!;
    });
    super.initState();
  }

  bool formIsValide() {
    if (nameController.text.isNotEmpty &&
        rtController.text.isNotEmpty &&
        rdController.text.isNotEmpty &&
        directorController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void clearControllers() {
    nameController.clear();
    rtController.clear();
    rdController.clear();
    directorController.clear();

    setState(() {
      movieInsert = false;
    });
  }

  Column insertFeature() {
    if (movieInsert) {
      return Column(
        children: [
          DropdownButton(
            value: idSuperhero,
            items: superheroes.map((superhero) {
              return DropdownMenuItem(
                value: superhero.id,
                child: Text(superhero.name.toString()),
              );
            }).toList(),
            onChanged: (dynamic value) {
              setState(() {
                idSuperhero = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              widget.insertFeature(
                  Feature(idMovie: lastIdMovie, idSuperhero: idSuperhero));

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Feature insert with success! '),
              ));
            },
            child: Text("Add feature"),
          ),
        ],
      );
    } else {
      return Column(children: [
        Text("You need to insert a movie before adding his features")
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add movie data'),
        actions: [
          IconButton(
              onPressed: () {
                clearControllers();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: "Name of the movie",
                    hintText: "Iron Man 3",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: rtController,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Running time",
                    hintText: "120",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: rdController,
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: "Release date",
                    hintText: "21-05-2020",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: directorController,
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: "Director",
                    hintText: "Dario Argento",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formIsValide()) {
                      widget.insertMovie(Movie(
                        name: nameController.text,
                        runningTime: int.parse(rtController.text.toString()),
                        releaseDate: rdController.text,
                        director: directorController.text,
                      ));

                      setState(() {
                        movieInsert = true;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            nameController.text + ' insert with success! '),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Input errors, try to review the fields"),
                      ));
                    }
                  },
                  child: const Text('Add movie'),
                ),
              ),
              insertFeature(),
              StreamBuilder(
                  stream: widget.getAllMovies(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      List list = snapshot.data as List<Movie>;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            lastIdMovie = list.last.id;
                            return Container();
                          });
                    } else {
                      return Text("data");
                    }
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
