import 'package:ecart/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String? username;

  @override
  void initState() {
    loadUsername();
    super.initState();
  }

  void loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username');
    });
    print('isLoggedin: $username');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
            future: Webservice().getOrderDetails(
              username.toString(),
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final orderDetails = snapshot.data![index];
                    print(orderDetails.toString());
                    DateTime dateTime = DateTime.parse(orderDetails.date);
                    return Card(
                      elevation: 0,
                      color: const Color.fromARGB(255, 222, 240, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          iconColor: Colors.blue,
                          collapsedIconColor: Colors.black,
                          trailing: const Icon(Icons.arrow_drop_down),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // DateFormat.yMMMEd().format(orderDetails.date),
                                DateFormat.yMMMEd().format(dateTime),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                orderDetails.paymentmethod.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                orderDetails.totalamount.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  color: const Color.fromRGBO(255, 193, 7, 1),
                                  child: SizedBox(
                                    height: 100,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 80,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    Webservice().imageurl +
                                                        orderDetails
                                                            .products![index]
                                                            .image,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Wrap(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  orderDetails.products![index]
                                                      .productname,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      orderDetails
                                                          .products![index]
                                                          .price
                                                          .toString(),
                                                    ),
                                                    Text(
                                                      orderDetails
                                                          .products![index]
                                                          .quantity
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: orderDetails.products!.length,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                // } else if (snapshot.hasError) {
                //   return Text('Error: ${snapshot.error}');
                // } else {
                //   return const Text('Data not available');
              }
              return const LinearProgressIndicator();
            }),
      ),
    );
  }
}
