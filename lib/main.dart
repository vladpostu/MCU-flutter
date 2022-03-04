// ignore_for_file: prefer_const_constructors, await_only_futures

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mcu_floor/dao/FeatureDao.dart';
import 'package:mcu_floor/dao/MovieDao.dart';
import 'package:mcu_floor/dao/SuperheroDao.dart';
import 'package:mcu_floor/database/database.dart';
import 'package:mcu_floor/entities/Feature.dart';
import 'package:mcu_floor/entities/Movie.dart';
import 'package:mcu_floor/entities/Superhero.dart';
import 'package:mcu_floor/routers/AddMovie.dart';
import 'package:mcu_floor/routers/AddSuperhero.dart';
import 'package:mcu_floor/routers/ViewMovie.dart';
import 'package:mcu_floor/routers/ViewSuperhero.dart';
import 'package:restart_app/restart_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database_mcu_12.db').build();

  final movieDao = database.movieDao;
  final superheroDao = database.superheroDao;
  final featureDao = database.featureDao;

  runApp(MyApp(
      movieDao: movieDao, superheroDao: superheroDao, featureDao: featureDao));
}

class MyApp extends StatelessWidget {
  final MovieDao movieDao;
  final SuperheroDao superheroDao;
  final FeatureDao featureDao;

  const MyApp(
      {Key? key,
      required this.movieDao,
      required this.superheroDao,
      required this.featureDao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Cinematic Universe',
      theme: ThemeData(
        accentColor: Colors.red[800],
        brightness: Brightness.dark,
        primaryColor: Colors.red[800],
      ),
      home: MyHomePage(
        title: 'Marvel Cinematic Universe',
        movieDao: movieDao,
        superheroDao: superheroDao,
        featureDao: featureDao,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.movieDao,
      required this.superheroDao,
      required this.featureDao})
      : super(key: key);

  final String title;
  final MovieDao movieDao;
  final SuperheroDao superheroDao;
  final FeatureDao featureDao;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool dialOpen = false; // speed dial state
  late List<Superhero> superheroes = getAllSuperheroes();
  late List<Feature> features;

  int superheroesLength = 10;

  int getLastId() {
    List<Movie> movies = [];
    int lastIdMovie = 0;
    widget.movieDao.getAllMovies().listen((moviesList) {
      if (moviesList.isNotEmpty) {
        lastIdMovie = moviesList.last.id!;
      } else {
        lastIdMovie = 0;
      }
    });

    return lastIdMovie;
  }

  StreamBuilder displayMovies() {
    return StreamBuilder(
      stream: widget.movieDao.getAllMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List movies = snapshot.data as List<Movie>;
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var item = movies[index];
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1.0),
                    right: BorderSide(width: 2.0),
                  )),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewMovie(
                            id: item.id,
                            name: item.name.toString(),
                            runningTime: item.runningTime,
                            releaseDate: item.releaseDate.toString(),
                            director: item.director.toString(),
                            findFeatures:
                                widget.featureDao.findFeatures(item.id),
                            superheroes: superheroes,
                            deleteSuperhero: deleteSuperhero,
                          ),
                        ),
                      );
                    },
                    child: Dismissible(
                      key: UniqueKey(),
                      child: ListTile(
                        title: Text(item.name),
                      ),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        widget.movieDao.deleteMovie(movies[index]);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(item.name + ' movie deleted')));
                      },
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Text("No data avaiable");
        }
      },
    );
  }

  StreamBuilder displaySuperheroes() {
    return StreamBuilder(
      stream: widget.superheroDao.getAllSuperheroes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List superheroes = snapshot.data as List<Superhero>;
          return ListView.builder(
            itemCount: superheroes.length,
            itemBuilder: (context, index) {
              superheroes.add(superheroes[index]);
              return Text("");
            },
          );
        } else {
          return Text("No data avaiable");
        }
      },
    );
  }

  void insertMovie(Movie movie) async {
    await widget.movieDao.insertMovie(movie);
  }

  void insertSuperhero(Superhero superhero) async {
    await widget.superheroDao.insertSuperhero(superhero);
  }

  List<Superhero> getAllSuperheroes() {
    setState(() {
      superheroes = [];
    });
    List<Superhero> superheroesList = [];
    widget.superheroDao.getAllSuperheroes().listen((superheroes) {
      setState(() {
        superheroesLength = superheroes.length;
      });
      for (int i = 0; i < superheroes.length; i++) {
        superheroesList.add(superheroes[i]);
      }
    });

    return superheroesList;
  }

  void insertFeature(Feature feature) async {
    await widget.featureDao.insertFeature(feature);
  }

  Stream<List<Feature>> getAllFeatures() {
    return widget.featureDao.getAllFeatures();
  }

  void deleteSuperhero(Superhero superhero) async {
    await widget.superheroDao.deleteSuperhero(superhero);

    for (var item in superheroes) {
      update();
      if (item.id == superhero.id) {
        superheroes.remove(item);
      }
    }
  }

  void update() async {
    superheroes = await getAllSuperheroes();
  }

  Superhero findSuperhero(int id) {
    for (int i = 0; i < superheroes.length; i++) {
      if (superheroes[i].id == id) {
        return superheroes[i];
      }
    }
    throw '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Restart.restartApp();
                },
                icon: Icon(Icons.restart_alt))
          ],
          title: Image.asset(
            './assets/logo.png',
            width: 200,
            height: 45,
          ),
          centerTitle: true,
        ),
        body: Container(
          key: UniqueKey(),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 300,
              child: ListView(
                children: [
                  Text(
                      "Explore and contribute to the Marvel Cinematic Universe!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset('./assets/front.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "All the movies",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  displayMovies(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "All the superheroes ($superheroesLength)",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CarouselSlider(
                        items: superheroes.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              key: UniqueKey(),
                              alignment: Alignment.center,
                              width: 300,
                              color: Colors.grey,
                              child: GestureDetector(
                                child: Text(
                                  e.name,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewSuperhero(
                                        superhero: findSuperhero((e.id)!),
                                        deleteSuperhero: deleteSuperhero,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 100,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: Icon(Icons.movie),
              label: "Add a movie",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMovie(
                      insertMovie: insertMovie,
                      getAllSuperheroes: superheroes,
                      insertFeature: insertFeature,
                      getAllMovies: widget.movieDao.getAllMovies,
                    ),
                  ),
                );
              },
            ),
            SpeedDialChild(
                child: Icon(Icons.person_add),
                label: "Add a superhero",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSuperhero(
                        insertSuperhero: insertSuperhero,
                      ),
                    ),
                  );
                })
          ],
        ));
  }
}
