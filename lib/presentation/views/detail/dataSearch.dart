import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_reader/core/model/Report.dart';
import 'package:news_reader/presentation/result/results.dart';
import 'package:news_reader/presentation/search/search.dart';

class DataSearch extends SearchDelegate<String> {
  final List<String> gouvernoratsName = [
    "Ariana",
    "Béja",
    "Ben Arous",
    "Bizerte",
    "Gabès",
    "Gafsa",
    "Jendouba",
    "Kairouan",
    "Kasserine",
    "Kébili",
    "Kef",
    "Mahdia",
    "Manouba",
    "Médenine",
    "Monastir",
    "Nabeul",
    "Sfax",
    "Sidi Bouzid",
    "Siliana",
    "Sousse",
    "Tataouine",
    "Tozeur",
    "Tunis",
    "Zaghouan",
  ];
  final recentCities = [
    "Sfax",
    "Sidi Bouzid",
    "Siliana",
    "Sousse",
    "Tataouine",
    "Tozeur",
  ];

  Search search = new Search();
  
  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of appbar

    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
search.setItem(this.query);
List<Report> results=search.getResults();
    return Card(
        color: Colors.grey,
        shape: RoundedRectangleBorder(),
        child: Center(
          child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: results.length,
                itemBuilder:(BuildContext context, int index) {
                   final item = results[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1500),
                    child: SlideAnimation(
                      horizontalOffset: -1000.0,
                      //  child: SlideAnimation(
                      child:  ResultRow(item),                    
                    ),
                  );
                })

        ));
    // return(Text(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentCities
        : gouvernoratsName
            .where((p) => p.toUpperCase().startsWith(query.toUpperCase()))
            .toList();
          

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.access_time),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }


 
      
  
}
