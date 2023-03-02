import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/web_view_paymwnt_screen_arguments.dart';
import 'package:utc_flutter_app/screens/bottomTabsScreens/walletTab/wallet_tab_provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({Key? key}) : super(key: key);
  @override
  WalletTabState createState() => WalletTabState();
}

class WalletTabState extends State<WalletTab> {
  late WalletTabProvider _walletTabProvider;

  @override
  void initState() {
    super.initState();
    _walletTabProvider = Provider.of<WalletTabProvider>(context, listen: false);
    _walletTabProvider.getUserData(context);
    Future.delayed(Duration.zero, () async {
      if (await CommonMethods.getInternetUsingInternetConnectivity()) {
        await _walletTabProvider.authenticationMethod();
        _walletTabProvider.getWalletDetailsTransactions(AppConstants.USER_MOBILE_NO,context);
      } else {
        CommonMethods.showNoInternetDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletTabProvider>(builder: (_, provider, __) {
      return Scaffold(
          // key: _key,
          endDrawerEnableOpenDragGesture: true,
          endDrawer: NavigationDrawer(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: HexColor(MyColors.primaryColor),
            automaticallyImplyLeading: false,
            title: Text(
              "Wallet",
              style:
                  GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          body: Stack(
            children: [
              Visibility(
                visible: provider.isLoading ? false : true,
                child: userWalletLayout(provider),
              ),
              Visibility(
                  visible: provider.isLoading,
                  child: CommonWidgets.buildCircularProgressIndicatorWidget())
            ],
          ));
    });
  }

  userWalletLayout(WalletTabProvider provider) {
    //print(provider.isLoading);
    return Consumer<WalletTabProvider>(
      builder: (_, provider, __) {
        return SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              walletTopUpSection(provider),
              walletHistorySection(provider)
            ],
          ),
        );
      },
    );
  }

  walletHistorySection(WalletTabProvider provider) {

    return Container(
      margin: EdgeInsets.only(top: 10),
      color: HexColor(MyColors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wallet History (Last 30 days)",
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          walletHistoryListBuilder(provider)
        ],
      ),
    );
  }

  Widget walletHistoryListBuilder(WalletTabProvider provider) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount:
          provider.walletDetailsTransactionsResponse.walletTransactions!.length,
      // itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return walletHistoryListLayout(index, provider);
      },
    );
  }

  Widget walletHistoryListLayout(int index, WalletTabProvider provider) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 3),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.walletDetailsTransactionsResponse
                              .walletTransactions![index].txntype
                              .toString(),
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: HexColor(MyColors.black),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          provider.walletDetailsTransactionsResponse
                              .walletTransactions![index].txndate
                              .toString(),
                          style: GoogleFonts.nunito(
                              fontSize: 14, color: HexColor(MyColors.grey1)),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ],
                ),
                Text(
                  provider.setAmountInWalletList(
                      provider.walletDetailsTransactionsResponse
                          .walletTransactions![index].txntype
                          .toString(),
                      provider.walletDetailsTransactionsResponse
                          .walletTransactions![index].txnamount
                          .toString()),
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: provider.setAmountColorInWalletList(
                          provider.walletDetailsTransactionsResponse
                              .walletTransactions![index].txntype
                              .toString(),
                          provider.walletDetailsTransactionsResponse
                              .walletTransactions![index].txnamount
                              .toString()),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Container(
              color: HexColor(MyColors.grey2),
              height: 1,
            )
          ],
        ));
  }

  walletTopUpSection(WalletTabProvider provider) {
    return Stack(
      children: [
        Container(
          color: HexColor(MyColors.primaryColor),
          height: 80,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Balance",
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: HexColor(MyColors.white),
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "₹ " + provider.amountBalance,
                style: GoogleFonts.nunito(
                    fontSize: 22,
                    color: HexColor(MyColors.white),
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Card(
            elevation: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Topup Wallet",
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "(Between 100-9999)",
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ],
                  ),
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(top: 7),
                    child: TextField(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: provider.enterAmountController,
                      onChanged: (val) {
                        //print(val);
                        provider.setValueInController(val);
                      },
                      cursorColor: HexColor(MyColors.primaryColor),
                      style: GoogleFonts.nunito(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 15, top: 5),
                            child: Text(
                              "₹",
                              style: GoogleFonts.nunito(
                                  fontSize: 28, fontWeight: FontWeight.w600),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(MyColors.primaryColor),
                                width: 3.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(MyColors.grey1), width: 3.0),
                          ),
                          hintText: 'Enter Amount',
                          hintStyle: GoogleFonts.nunito(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "Recommended",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.setValueInController("100");
                        },
                        child: Container(
                          height: 30,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: HexColor(MyColors.primaryColor)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              '₹ 100',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.setValueInController("500");
                        },
                        child: Container(
                          height: 30,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: HexColor(MyColors.primaryColor)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              '₹ 500',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.setValueInController("1000");
                        },
                        child: Container(
                          height: 30,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: HexColor(MyColors.primaryColor)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              '₹ 1000',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: provider.isValueEnter
                        ? () async {
                            if (await CommonMethods.getInternetUsingInternetConnectivity()) {
                              confirmTopUpDilaogBox(_walletTabProvider);
                            } else {
                              CommonMethods.showNoInternetDialog(context);
                            }
                          }
                        : () {},
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: provider.isValueEnter
                              ? HexColor(MyColors.orange)
                              : HexColor(MyColors.grey1),
                          borderRadius: BorderRadius.circular(30)),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "PROCEED TO TOPUP",
                              style: GoogleFonts.nunito(
                                  color: HexColor(MyColors.white),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  walletBalanceSection(WalletTabProvider provider) {
    return Container(
      decoration: BoxDecoration(color: HexColor(MyColors.primaryColor)),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }

  loadPaymentGateways(WalletTabProvider walletTabProvider) async {
    CommonMethods.showLoadingDialog(context);
    await walletTabProvider.getPaymentGateways(context);
    if (walletTabProvider.getPaymentGatewaysResponse.code == "100") {
      showPaymentDialog();
    } else if (walletTabProvider.getPaymentGatewaysResponse.code == "999") {
      CommonMethods.showTokenExpireDialog(context);
    } else if (walletTabProvider.getPaymentGatewaysResponse.code == "999") {
      CommonMethods.showErrorDialog(context, "Something went wrong, please try again");
    } else {
      CommonMethods.showErrorMoveToDashBaordDialog(
          context, "Something went wrong, please try again");
    }
  }

  showPaymentDialog() {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.white,
      // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              paymentDialogToAppBar(),
              totalAmount(),
              // walletBalance(),
              paymentOptionSection(),
            ],
          ),
        );
      },
    );
  }

  paymentDialogToAppBar() {
    return Container(
      height: 80,
      padding: EdgeInsets.only(top: 45, bottom: 10),
      color: HexColor(MyColors.primaryColor),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.leftToRight,
                  //     child: DashboardScreen(),
                  //   ),
                  // );
                },
                child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 22,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select a payment option",
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  totalAmount() {
    return Consumer<WalletTabProvider>(builder: (_, walletTabProvider, __) {
      return Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total payable amount ",
              style: GoogleFonts.nunito(
                  fontSize: 18, color: HexColor(MyColors.black)),
            ),
            Text(
              "₹ " +
                  walletTabProvider.enterAmountController.value.text.toString(),
              style: GoogleFonts.nunito(
                  fontSize: 22,
                  color: HexColor(MyColors.orange),
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
    });
  }

  paymentOptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
          child: Text(
            "Payment Gateway(s)",
            style: GoogleFonts.nunito(
                fontSize: 16, color: HexColor(MyColors.grey6)),
          ),
        ),
        Container(
          color: HexColor(MyColors.grey1),
          height: 1,
        ),
        payByPaymentGateWayListBuilder(),
      ],
    );
  }

  payByPaymentGateWayListBuilder() {
    return ListView.builder(
      // padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _walletTabProvider.paymentGatewaysList.length,
      // itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return paymentGatewaysListItems(index);
      },
    );
  }

  paymentGatewaysListItems(int index) {
    return GestureDetector(
      onTap: () => clickOnPaymentGateway(index),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            height: 50,
            decoration: BoxDecoration(
                // color: HexColor(MyColors.skyBlue),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  height: 60,
                  width: 60,
                  child: Image.network(
                    AppConstants.PG_IMAGE_URL +
                        _walletTabProvider
                            .paymentGatewaysList[index].gatewayname!
                            .toString() +
                        "_M.png",
                    fit: BoxFit.contain,
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      _walletTabProvider.paymentGatewaysList[index].gatewayname!,
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      _walletTabProvider.paymentGatewaysList[index].description!,
                      style: GoogleFonts.nunito(fontSize: 12),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: HexColor(MyColors.orange),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Proceed to pay",
                        style: GoogleFonts.nunito(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            color: HexColor(MyColors.grey2),
            height: 1,
          ),
        ],
      ),
    );
  }

  clickOnPaymentGateway(int index) {
    Navigator.pushNamed(context, MyRoutes.paymentWebViewScreen,
        arguments: WebViewPaymentScreenArguments(
            _walletTabProvider.enterAmountController.text.toString(),
            _walletTabProvider.paymentGatewaysList[index].gatewayid.toString(),
            "Wallet",
            _walletTabProvider.paymentGatewaysList[index].gatewayname
                .toString()));
  }

  confirmTopUpDilaogBox(WalletTabProvider walletTabProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
            height: 140,
            padding: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "You are going to recharge your wallet"+" ₹ " + _walletTabProvider.enterAmountController.text.toString()+".",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                        fontSize: 15, color: HexColor(MyColors.black)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Do you want to proceed ?",
                    style: GoogleFonts.nunito(
                        fontSize: 15, color: HexColor(MyColors.black)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: HexColor(MyColors.orange)),
                          color: HexColor(MyColors.white),
                        ),
                        child: Center(
                            child: Text(
                          "No",
                          style: GoogleFonts.nunito(
                              fontSize: 15, color: HexColor(MyColors.orange)),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(context);
                        loadPaymentGateways(walletTabProvider);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: HexColor(MyColors.orange),
                        ),
                        child: Center(
                            child: Text(
                          "Yes",
                          style: GoogleFonts.nunito(
                              fontSize: 15, color: HexColor(MyColors.white)),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }
}
