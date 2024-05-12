import 'package:ecart/screens/product_details.dart';
import 'package:ecart/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';

class CategoryProducts extends StatelessWidget {
  final String catname;
  final int catid;
  const CategoryProducts(
      {super.key, required this.catname, required this.catid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const HomeScreen(),
        //       ),
        //     );
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new_outlined,
        //     size: 18,
        //   ),
        // ),
        title: Text(
          catname,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Webservice().getCategoryProducts(catid),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(5),
              shrinkWrap: true,
              crossAxisCount: 2,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          name: product.productname!,
                          price: product.price.toString(),
                          image: Webservice().imageurl + product.image!,
                          description: product.description!,
                          id: product.id!,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber,
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(
                              Webservice().imageurl + product.image!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    product.productname!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // maxLines: 2,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Rs. ${product.price!}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
            );
          }
          return const LinearProgressIndicator();
        },
      ),
    );
  }
}
