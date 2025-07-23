import 'package:covid19_tracker_app/view/world_state.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  final String name;
  final String image;
  final int totalCases,  totalDeaths, totalRecovered, active, critical, todayRecovered, tests;

  DetailScreen({

    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.critical,
    required this.todayRecovered,
    required this.active,
    required this.tests,
    required this.totalRecovered,
    required this.totalDeaths,
  });


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.067,),
                      ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReusableRow(title: 'Recovered', value: widget.todayRecovered.toString()),
                      ReusableRow(title: "Today's Recovered", value: widget.todayRecovered.toString()),
                      ReusableRow(title: 'Death', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'Active', value: widget.active.toString()),
                      ReusableRow(title: 'Critical', value: widget.critical.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      )
    );
  }

}
