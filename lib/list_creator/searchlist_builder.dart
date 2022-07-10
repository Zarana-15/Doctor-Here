import 'package:doctor_here/list_creator/Search_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:doctor_here/model/clinic.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    final clinics = Provider.of<List<Clinic>>(context) ?? [];
    return ListView.builder(
      itemCount: clinics.length,
      itemBuilder: (BuildContext context, int index) {
        return SearchTile(clinic: clinics[index]);
      },
    );
  }
}
