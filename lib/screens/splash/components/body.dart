import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

// TODO: This should be deleted later
import 'package:shop_app/helper/data_gen_script.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Eatify, let’s get your favourite food!",
      "image": "assets/images/Diet-amico.png"
    },
    {
      "text": "Connect with stores",
      "image": "assets/images/Coffee shop-bro.png"
    },
    {
      "text": "Stay at home and get your food",
      "image": "assets/images/Take Away-cuate.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        // Navigator.pushNamed(context, SignInScreen.routeName);
                        Navigator.pushNamed(context, HomeScreen.routeName);

                        User? user =
                            context.read<AuthenticationService>().getUser();
                        print(user);
                        if (user == null) {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        } else {
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        }
                      },
                    ),
                    Spacer(),
                    // TODO: This should be deleted later
                    TextButton(
                      child: Text("Add Data"),
                      onPressed: () {
                        // TODO: Define the list of data
                        // Store
                        List<Map<String, dynamic>> data = [
                          {
                            "title": "Pho Hung",
                            "rating": 4.1,
                            "isPopular": false,
                            "imageURL":
                                "https://www.disneycooking.com/wp-content/uploads/2020/03/hoc-nau-pho-gia-truyen.jpg",
                            "foods": [""],
                            "distance": 1.5,
                            "address":
                                "397a Le Dai Hanh street, ward 11, district 10, Ho Chi Minh city",
                          },
                          {
                            "title": "Banh mi Sai Gon",
                            "rating": 4.8,
                            "isPopular": true,
                            "imageURL":
                                "https://cdnmedia.thethaovanhoa.vn/Upload/tyTrfgkgEUQwPYuvZ4Kn1g/files/2020/03/3203/4w5thy.jpg",
                            "foods": [""],
                            "distance": 4,
                            "address":
                                "1, Bui Thi Xuan street, ward 4, district 1, Ho Chi Minh city"
                          },
                          {
                            "title": "KFC",
                            "rating": 4.1,
                            "isPopular": true,
                            "imageURL":
                                "https://images.foody.vn/res/g1/1488/prof/s640x400/image-3b2daeee-201123110753.jpeg",
                            "foods": [""],
                            "distance": 4.5,
                            "address":
                                "102, Ngo Gia Tu street, ward 6, district 5, Ho Chi Minh city"
                          },
                          {
                            "title": "Hanuri",
                            "rating": 4.7,
                            "isPopular": true,
                            "imageURL":
                                "https://toplist.vn/images/800px/bibimbap-korean-food-quan-han-thich-hop-cho-cac-cap-doi-89319.jpg",
                            "foods": [""],
                            "distance": 1.9,
                            "address":
                                "102, Su Van Hanh street, ward 5, district 10, Ho Chi Minh city"
                          },
                          {
                            "title": "Gong Cha",
                            "rating": 4.8,
                            "isPopular": true,
                            "imageURL":
                                "http://gongcha.com.vn/wp-content/uploads/2018/06/Hinh-Web-OKINAWA-LATTE.png",
                            "foods": [""],
                            "distance": 3.2,
                            "address":
                                "31a, Le Dai Hanh street, ward 11, district 10, Ho Chi Minh city",
                          },
                        ];

                        // TODO: You can change the function parameters
                        mainAddData(
                          collection: "stores",
                          data: data,
                        );
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
