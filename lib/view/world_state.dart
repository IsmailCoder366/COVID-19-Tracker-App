import 'package:covid19_tracker_app/Model/world_state_model.dart';
import 'package:covid19_tracker_app/Services/state_services.dart';
import 'package:covid19_tracker_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}


class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose(); // clean up
    super.dispose();
  }


  final colorList = <Color>  [
    Color(0xff4285F4),
    Color(0xff1aa268),
    Color(0xffde5246),
  ];

    @override
  Widget build(BuildContext context) {
      StateServices stateServices = StateServices();
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height *.1,),

            FutureBuilder(
              future: stateServices.fetchWorldStateRecord(),
              builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        PieChart(
                          dataMap:  {
                            "Total": double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                            "Death": double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .03,
                          ),
                          child: Card(
                            child: Column(
                              children:  [
                                ReusableRow(title: "Total", value: (snapshot.data!.cases!.toString()),),
                                ReusableRow(title: "Recovered", value: (snapshot.data!.recovered!.toString()),),
                                ReusableRow(title: "Death", value: (snapshot.data!.deaths!.toString()),),
                                ReusableRow(title: "Today's Cases", value: (snapshot.data!.todayCases.toString()),),
                                ReusableRow(title: "Today's Death", value: (snapshot.data!.todayDeaths.toString()),),
                                ReusableRow(title: "Today's Recovered", value: (snapshot.data!.todayRecovered.toString()),),
                                ReusableRow(title: "Critical", value: (snapshot.data!.critical.toString()),),

                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => CountriesList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text('Track Countries'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),






          ],
        ),
      ),
    ));
  }
}


class ReusableRow extends StatelessWidget {
  String title, value;

   ReusableRow({Key? key, required this.title, required this.value})  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value)
              ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}

