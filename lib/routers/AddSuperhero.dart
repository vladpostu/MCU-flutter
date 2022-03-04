// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mcu_floor/entities/Movie.dart';
import 'package:mcu_floor/entities/Superhero.dart';

class AddSuperhero extends StatefulWidget {
  AddSuperhero({
    Key? key,
    required this.insertSuperhero,
  }) : super(key: key);

  final Function insertSuperhero;

  @override
  State<AddSuperhero> createState() => _AddSuperheroState();
}

class _AddSuperheroState extends State<AddSuperhero> {
  var nameController = TextEditingController();
  var powersController = TextEditingController();
  var powerRankingController = TextEditingController();

  bool formIsValide() {
    if (nameController.text.isNotEmpty &&
        powersController.text.isNotEmpty &&
        powerRankingController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void clearControllers() {
    nameController.clear();
    powersController.clear();
    powerRankingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add superhero data'),
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
                    labelText: "Name of the superhero",
                    hintText: "Iron Man",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: powersController,
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: "Powers",
                    hintText: "Flying, shooter...",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: powerRankingController,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Power ranking (1-10)",
                    hintText: "7",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formIsValide()) {
                      widget.insertSuperhero(Superhero(
                          name: nameController.text,
                          powers: powersController.text,
                          powerRanking: int.parse(
                              powerRankingController.text.toString())));

                      clearControllers();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            nameController.text + ' insert with success! '),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                            "Input errors founds, try to review the fields"),
                      ));
                    }
                  },
                  child: const Text('Add superhero'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
