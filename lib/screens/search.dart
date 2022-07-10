import 'package:doctor_here/list_creator/searchlist_builder.dart';
import 'package:doctor_here/model/clinic.dart';
import 'package:doctor_here/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final txt = TextEditingController();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    box.listen(() {
      setState(() {});
    });
    return StreamProvider<List<Clinic>>.value(
        value: DatabaseService().search,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: GradientAppBar(
            gradient:
                LinearGradient(colors: [Colors.blue[900], Colors.blue[500]]),
            title: Text('Search'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      child: TextFormField(
                        controller: txt,
                        decoration:
                      InputDecoration(labelText: 'Search by Doctor name'),
                        onChanged: (x) {
                          box.write('search', x);
                          DatabaseService().search;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text("Search"))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(child: Container(child: SearchList())),
              ],
            ),
          ),
        ));
  }
}
