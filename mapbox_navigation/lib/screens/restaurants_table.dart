import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';
import 'package:mapbox_navigation/screens/detail_page.dart';

import '../helpers/shared_prefs.dart';

class RestaurantsTable extends StatefulWidget {
  const RestaurantsTable({Key? key}) : super(key: key);

  @override
  State<RestaurantsTable> createState() => _RestaurantsTableState();
}

class _RestaurantsTableState extends State<RestaurantsTable> {
  /// Add handlers to buttons later on
  /// For call and maps we can use url_launcher package.
  /// We can also create a turn-by-turn navigation for a particular restaurant.
  /// 🔥 Let's look at it in the next video!!

  Widget cardButtons(IconData iconData, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: ElevatedButton(
        onPressed: () {
          if (label == "Details"){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DetailPage(name: 'ola',)));
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(5),
          minimumSize: Size.zero,
        ),
        child: Row(
          children: [
            Icon(iconData, size: 16),
            const SizedBox(width: 2),
            Text(label)
          ],
        ),
      ),
    );
  }

  List<Map> res = [];

  @override
  initState() {
    res = restaurants;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = restaurants;
    } else {
      results = restaurants
          .where((rest) =>
              rest["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      res = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabela de Restaurantes'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoTextField(
                prefix: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Icon(Icons.search),
                ),
                onChanged: (value) => _runFilter(value),
                padding: EdgeInsets.all(15),
                placeholder: 'Procurar por restaurante',
                style: TextStyle(color: Colors.white),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              const SizedBox(height: 5),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: res.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (() {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DetailPage(name: res[index]['name'],)));
                    }),
                    child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: 175,
                          width: 140,
                          fit: BoxFit.cover,
                          imageUrl: res[index]['image'],
                        ),
                        Expanded(
                          child: Container(
                            height: 175,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  res[index]['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(res[index]['items']),
                                const SizedBox(height: 10,),
                                Text(
                                  'Aberto até ${res[index]['closes']}',
                                  style:
                                      TextStyle(color: Colors.redAccent[100]),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    //cardButtons(Icons.details, 'Details'),
                                    //cardButtons(Icons.location_on, 'Map'),
                                    Text("Distancia até ao local:"),
                                    const Spacer(),
                                    Text(
                                        '${(getDistanceFromSharedPrefs(index) / 1000).toStringAsFixed(2)}km'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
