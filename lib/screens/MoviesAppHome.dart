import 'package:flutter/material.dart';
import 'package:moviesapp/components/MovieList.dart';
import 'package:moviesapp/services/MovieService.dart';
import 'package:moviesapp/models/Movie.dart';
import 'package:flutter/services.dart';

class MoviesAppHome extends StatefulWidget {
  @override
  MoviesAppHomeState createState() => MoviesAppHomeState();
}

class MoviesAppHomeState extends State<MoviesAppHome> {
  final searchTextController = new TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "  Home",
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.w900),
          ),
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            if (searchText.length == 0)
              Container(
                height: 40,
                child: Center(
                  child: Text("Search for a movie...",style: TextStyle(fontWeight: FontWeight.w300),),
                ),
              ),
            Container(
              child: Row(children: <Widget>[
                
                Flexible(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      setState(() {
                        searchText = searchTextController.text;
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      });
                    },
                    controller: searchTextController,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      labelText: "Search for movies",
                      hintText: "Search",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        tooltip: 'Search Movies',
                        onPressed: () {
                          setState(() {
                            searchText = searchTextController.text;
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ]),
              padding: EdgeInsets.all(10),
            ),
            if (searchText.length > 0)
              FutureBuilder<List<Movie>>(
                  future: searchMovies(searchText),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                          child: MovieList(
                              movies: snapshot.data,));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }),
            
          ],
        ));
  }
}
