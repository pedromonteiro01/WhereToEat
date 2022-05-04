import 'package:flutter/material.dart';
import 'package:mapbox_navigation/screens/home_management.dart';
import 'package:mapbox_navigation/screens/restaurants_table.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';

class DetailPage extends StatefulWidget {
  final String name;

  const DetailPage({Key? key, required this.name}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{

  List<Map> res = [];

  @override
  void initState() {
    res = restaurants.where((element) => element['name'].contains(widget.name)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: new NetworkImage(res[0]['image']),
                    fit: BoxFit.cover,
                  ),
                  
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 50, 
              child: Row(
              children: [
                IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomeManagement(res_name: 'null',)));},icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
              ],
              ),
            ),
            Positioned(
              top: 250,
              child:Container(
                padding: const EdgeInsets.only(left: 25, top:40, right: 25),
                width: MediaQuery.of(context).size.width,
                height: 550,
                decoration: const BoxDecoration(
                  color: Color(0xff080808),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name, style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        SizedBox(height: 10,),
                        Text(res[0]['items'], style: TextStyle(color: Color(0xff919296)),),
                        SizedBox(height: 15,),
                        Row(
                          children: const [
                            Text('Description', style: TextStyle(
                              fontFamily: 'Avenir',
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Flexible( 
                              child: Text("A cappuccino is a coffee-based drink made primarily from espresso and milk." ,softWrap: true, style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: 15, 
                                color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: const [
                            Text('Location:', style: TextStyle(
                              fontFamily: 'Avenir',
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            ),
                          ],
                        ),
                        Text('Lat: ${res[0]['coordinates']['latitude']}   Long: ${res[0]['coordinates']['longitude']}', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                        Text('Rua das Abelhas', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                        SizedBox(height: 47,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Price", style: TextStyle(color: Color(0xff919296), fontWeight: FontWeight.bold),),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text(r'€', style: TextStyle(color: Color(0xffd17842), fontSize: 21),),
                                        Text("4.20", style: TextStyle(color: Colors.white, fontSize: 21),)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ButtonTheme(
                              minWidth: 200,
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                color: Color(0xffd17842),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeManagement(res_name: widget.name,)));
                                },
                                child: Text("See route", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17),),
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}