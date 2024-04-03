import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/house_model.dart';
import '../../../../utils/common/constants.dart';
import '../../../../utils/widgets/custom_button.dart';
import '../mobile/filter_widget.dart';
import '../mobile/house_ad_widget.dart';

class HomeDesktopPage extends StatefulWidget{

  @override
  State<HomeDesktopPage> createState() => _HomeDesktopPageState();
}

class _HomeDesktopPageState extends State<HomeDesktopPage> {

  final filterList = [
    'Favourites',
    '<\$100.000',
    '<\$500.000',
    '1 bedroom',
    '2 bedrooms',
    '2 bathrooms'
  ];

  String activeFilter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 50),
                  child: CustomButtonWidget(
                    icon: Icons.menu,
                    iconColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text('Imobiliare',
                        style: GoogleFonts.pacifico(
                            fontSize: 56,
                            color: ColorConstant.kBlackColor,
                            fontWeight: FontWeight.w500
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(right: 15.0, top: 50),
                    child: CustomButtonWidget(
                      icon: Icons.refresh,
                      iconColor: Colors.black,
                      backgroundColor: Colors.white,
                      iconSize: 40,
                    )
                )
              ],
            ),
            const SizedBox(height: 30),
            Text('*Cluj-Napoca*',
                style: GoogleFonts.pacifico(
                    fontSize: 23,
                    color: ColorConstant.kBlackColor,
                    fontWeight: FontWeight.w700
                )),
            const SizedBox(height: 30),
            const Divider(color: ColorConstant.kGreyColor, thickness: 0.2),
            Padding(
              padding: EdgeInsets.only(left: 240.0, right: 240.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Text('Filters:',
                                style: GoogleFonts.lato(
                                    fontSize: 30,
                                    color: ColorConstant.kBlackColor,
                                    fontWeight: FontWeight.w500
                                )
                            )
                        ),

                        Expanded( // Wrap ListView.builder in an Expanded widget
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: filterList.length,
                            itemBuilder: (context, index) {
                              return FilterWidget(
                                  filterTxt: filterList[index],
                                  isActive: activeFilter == filterList[index]
                                      ? true
                                      : false,
                                  onBtnTap: () {
                                    setState(() {
                                      if (activeFilter == filterList[index]) {
                                        activeFilter = '';
                                      } else {
                                        activeFilter = filterList[index];
                                      }
                                    });
                                  }
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                      children: List.generate(
                          Constants.houseList.length, (index) {
                        House house = Constants.houseList[index];
                        return isFiltered(
                            house.price, house.bedrooms, house.bathrooms,
                            house.isFavorite) ?
                        Padding(padding: const EdgeInsets.only(top: 16),
                            child: HouseAdWidget(
                              house: house,
                              imgPathIndex: index,
                            )) :
                        const SizedBox();
                      })
                  ),
                ],
              ),
            ),


          ],
        ),

      ),
    );
  }

  bool isFiltered(price, bedrooms, bathrooms, favourite) {
    if (activeFilter.isEmpty) return true;
    if (activeFilter.contains('bedroom')) {
      if (activeFilter[0] == '1' && bedrooms == 1) {
        return true;
      } else if (activeFilter[0] == '2' && bedrooms == 2) {
        return true;
      }
    }
    if (activeFilter.contains('bath')) {
      if (activeFilter[0] == '1' && bathrooms == 1) {
        return true;
      } else if (activeFilter[0] == '2' && bathrooms == 2) {
        return true;
      }
    }
    if (activeFilter.contains('Favourites')) {
      if (activeFilter[0] == 'F' && favourite == true) {
        return true;
      }
    }
      if (activeFilter.contains('\$')) {
        if (activeFilter[2] == '1' && price < 100000) {
          return true;
        }
        if (activeFilter[2] == '5' && price < 500000) {
          return true;
        }
      }

    return false;
  }

}