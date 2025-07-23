import 'package:covid19_tracker_app/Services/state_services.dart';
import 'package:covid19_tracker_app/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';


class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {


  TextEditingController searchController = TextEditingController();
  StateServices stateServices = StateServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value){
                    setState(() {
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                        future: stateServices.fetchCountriesList(),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

                        if (!snapshot.hasData) {
                          return  ListView.builder(
                            itemCount: 4,

                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(

                                        baseColor: Colors.grey.shade700,
                                        highlightColor: Colors.grey.shade100,
                                        child:
                                    Column(
                                      children: [
                                        ListTile(
                                          leading: Container(height: 50,width: 50,color: Colors.grey.shade700),
                                          title: Container(height: 10,width: 50,color: Colors.grey.shade700),
                                          subtitle: Container(height: 10,width: 50,color: Colors.grey.shade700),
                                        )
                                      ],
                                    ));
                                  }
                          );
                        }
                          else{
                            return ListView.builder(

                              itemCount: snapshot.data?.length,

                                itemBuilder: (context, index) {

                                String name = snapshot.data![index]['country'];

                                if(searchController.text.isEmpty) {

                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (){

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailScreen(
                                                image: snapshot.data![index]['countryInfo']['flag'].toString(),
                                                name: snapshot.data![index]['country'].toString(),
                                                totalCases: snapshot.data![index]['cases'] ?? 0,
                                                totalRecovered: snapshot.data![index]['recovered'] ?? 0,
                                                totalDeaths: snapshot.data![index]['deaths'] ?? 0,
                                                active: snapshot.data![index]['active'] ?? 0,
                                                tests: snapshot.data![index]['tests'] ?? 0,
                                                todayRecovered: snapshot.data![index]['todayRecovered'] ?? 0,
                                                critical: snapshot.data![index]['critical'] ?? 0,
                                              ),
                                            ),
                                          );

                                        },
                                        child: ListTile(
                                          leading: Image(
                                              height : 50,
                                              width: 50,
                                              image: NetworkImage(
                                                  snapshot.data![index]['countryInfo']['flag']
                                              )),
                                          title: Text(snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                else if(name.toLowerCase().contains(searchController.text.toLowerCase())) {
                                return Column(
                                children: [
                                InkWell(
                                  onTap : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          image: snapshot.data![index]['countryInfo']['flag'].toString(),
                                          name: snapshot.data![index]['country'].toString(),
                                          totalCases: snapshot.data![index]['cases'] ?? 0,
                                          totalRecovered: snapshot.data![index]['recovered'] ?? 0,
                                          totalDeaths: snapshot.data![index]['deaths'] ?? 0,
                                          active: snapshot.data![index]['active'] ?? 0,
                                          tests: snapshot.data![index]['tests'] ?? 0,
                                          todayRecovered: snapshot.data![index]['todayRecovered'] ?? 0,
                                          critical: snapshot.data![index]['critical'] ?? 0,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                  leading: Image(
                                  height : 50,
                                  width: 50,
                                  image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag']
                                  )),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  ),
                                )
                                ],
                                );

                                }
                                else {
                                    return Container();
                                }
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: Image(
                                          height : 50,
                                            width: 50,
                                            image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                        )),
                                        title: Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      )
                                    ],
                                  );
                                }
                            );
                          }


                      }
                  ))
            ],
          )),
    );
  }
}
