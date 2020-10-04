import 'package:flutter/material.dart';
import '../models/FlightRequest.dart';
import '../services/api_manager.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Result> _Flight;

  @override
  void initState() {
    _Flight = API_Manager().getFlights();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Syncing'),
      ),
      body: Container(
        child: FutureBuilder<Result>(
          future: _Flight,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index) {
                    var flight = snapshot.data.data[index];
                    var formattedTime = DateFormat('dd MMM - HH:mm')
                        .format(flight.createdAt);
                    return InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          ),
                           elevation: 4,
                          margin: EdgeInsets.fromLTRB(10,10,10,0),
                         child: Padding(
                               padding: EdgeInsets.all(12),
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Flight #"+flight.flightNumber,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Requested At :"+formattedTime
                                      ,style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),),
                                  flight.status==200?
                                  Text(
                                    "Request Succeeded",
                                    maxLines: 2,
                                    style:TextStyle(
                                      color: Colors.green,
                                      fontSize: 15
                                    ) ,
                                    overflow: TextOverflow.ellipsis,
                                  ):Text(
                                    "Request Failed",
                                    style:TextStyle(
                                        color: Colors.redAccent
                                    ) ,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                            ),
                             ),
                        ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
