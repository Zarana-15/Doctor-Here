import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Pharmacies_tile.dart';
import 'package:doctor_here/model/pharmacies.dart';

class PharmaciesList extends StatefulWidget {
  @override
  _PharmaciesListState createState() => _PharmaciesListState();
}

class _PharmaciesListState extends State<PharmaciesList> {
  @override
  Widget build(BuildContext context) {
    final pharmacies = Provider.of<List<Pharmacies>>(context) ?? [];
    return ListView.builder(
      itemCount: pharmacies.length,
      itemBuilder: (BuildContext context, int index) {
        return PharmaciesTile(pharmacies: pharmacies[index]);
      },
    );
  }
}
