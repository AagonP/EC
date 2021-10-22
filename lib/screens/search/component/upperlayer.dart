import 'package:flutter/material.dart';


class UpperLayer extends StatefulWidget {
  const UpperLayer({Key? key}) : super(key: key);

  @override
  State<UpperLayer> createState() => _UpperLayerState();
}

class _UpperLayerState extends State<UpperLayer> {
  late String selectedPeriod;
  late String selectedCategory;
  late String selectedPrice;

  List<String> timeFilter = [
    'Brand',
    'New',
    'Latest',
    'Trending',
    'Discount',
  ];

  List<String> categoryFilter = [
    'Skull Candy',
    'Boat',
    'JBL',
    'Micromax',
    'Seg',
  ];

  List<String> priceFilter = [
    '\$50-200',
    '\$200-400',
    '\$400-800',
    '\$800-1000',
  ];

  @override
  void initState() {
    selectedPeriod = timeFilter[0];
    selectedCategory = categoryFilter[0];
    selectedPrice = priceFilter[0];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, -3),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          color: Colors.white),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Filters',
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
              const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 16.0),
              child: Text(
                'Sort By',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPeriod = timeFilter[index];
                      });
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      decoration: selectedPeriod == timeFilter[index]
                          ? BoxDecoration(
                          color: Color(0xffFDB846),
                          borderRadius:
                          BorderRadius.all(Radius.circular(45)))
                          : BoxDecoration(),
                      child: Text(
                        timeFilter[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: timeFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = categoryFilter[index];
                      });
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      decoration: selectedCategory == categoryFilter[index]
                          ? BoxDecoration(
                          color: Color(0xffFDB846),
                          borderRadius:
                          BorderRadius.all(Radius.circular(45)))
                          : BoxDecoration(),
                      child: Text(
                        categoryFilter[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: categoryFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPrice = priceFilter[index];
                      });
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      decoration: selectedPrice == priceFilter[index]
                          ? BoxDecoration(
                          color: Color(0xffFDB846),
                          borderRadius:
                          BorderRadius.all(Radius.circular(45)))
                          : BoxDecoration(),
                      child: Text(
                        priceFilter[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: priceFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
