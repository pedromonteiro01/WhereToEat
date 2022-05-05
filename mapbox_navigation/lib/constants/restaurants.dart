import 'package:cloud_firestore/cloud_firestore.dart';

List<Map> restaurants = [];
List<Map> users = [];

void getRes() async{
  CollectionReference _collectionRef =FirebaseFirestore.instance.collection('restaurants');
  restaurants= await getData(_collectionRef); 
  print('RES: $restaurants');
}

void getUsers() async{
  CollectionReference _collectionRef2 =FirebaseFirestore.instance.collection('users');
  users= await getData(_collectionRef2); 
  print('USERS: $users');
}


Future<List<Map>> getData(_collectionRef) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data() as Map);
    Map map = new Map();
    for (var v in allData){
      map = v;
    }
    List<Map> list = [];
    for (final val in map.values){
      list.add(val as Map);
    }
    print('OLA');
    return list;
}
/*
[
  {
    'id': '0',
    'name': 'Ramona',
    'items': 'Francesinha, Hamburguer, Sandes',
    'image': 'https://scontent.fopo4-2.fna.fbcdn.net/v/t1.6435-9/132858036_225383902444943_5548837240534816498_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeEgbxjvOMF62E9xIfTJOlrfZ2v656rb0zhna_rnqtvTOCiXh3_rEpZJQXttfKurORZH3FOFQ-pBhfXgBwgmI072&_nc_ohc=S1XdkgqdDeMAX_2HOAZ&_nc_ht=scontent.fopo4-2.fna&oh=00_AT9dWi6UZZhA4OjCg-XJp58AxSzDAie8yIJWuqcotUe-gQ&oe=627CE4E3',
    'coordinates': {
      'latitude': '40.64823721419626',
      'longitude': '-8.647542077590103',
    },
    'closes': '12PM',
  },
  {
    'id': '0',
    'name': 'Convivio',
    'items': 'Hamburguer, Sandes, Francesinha, Snacks',
    'image':
        'https://indiaeducationdiary.in/wp-content/uploads/2020/10/IMG-20201024-WA0014.jpg',
    'coordinates': {
      'latitude': '40.63418681813457',
      'longitude': '-8.64836730215535',
    },
    'closes': '10PM',
  },
  {
    'id': '0',
    'name': 'Ceboleiros',
    'items': 'Hamburguer, Sandes, Francesinha, Snacks',
    'image':
        'https://www.ceboleiros.com/imgs/logoWhite.png',
    'coordinates': {
      'latitude': '40.63358670364584',
      'longitude': '-8.647931086711022',
    },
    'closes': '11PM',
  },
];
*/