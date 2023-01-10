// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:star_bus_project/arguments/my_bookings_arguments.dart';
// import 'package:star_bus_project/arguments/payment_screen_arguments.dart';
// import 'package:star_bus_project/screens/bottomTabsScreens/myBookingTab/my_tickets_provider.dart';
// import 'package:star_bus_project/utils/colors_code.dart';
// import 'package:star_bus_project/utils/common_methods.dart';
// import 'package:star_bus_project/utils/common_widigits.dart';
// import 'package:star_bus_project/utils/hex_color.dart';
// import 'package:star_bus_project/utils/my_routes.dart';
//
// class AllBookingHistoryScreen extends StatefulWidget {
//   const AllBookingHistoryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AllBookingHistoryScreen> createState() => _AllBookingHistoryScreenState();
//
// }
//
// class _AllBookingHistoryScreenState extends State<AllBookingHistoryScreen> {
//
//   late MyTicketsProvider _myTicketsProvider;
//
//   String from = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _myTicketsProvider = Provider.of<MyTicketsProvider>(context, listen: false);
//     // _myTicketsProvider.ticketsList.clear();
//
//     Future.delayed(Duration.zero, () async {
//       if (await CommonMethods.getInternetUsingInternetConnectivity()) {
//          // getArguments();
//         _myTicketsProvider.getTickets();
//       }
//       else {
//         CommonMethods.showNoInternetDialog(context);
//       }
//
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // getArguments();
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: HexColor(MyColors.primaryColor),
//             title: Text("My Bookings"),
//           ),
//           body: bookingHistoryListBuilder(),
//         ));
//   }
//
//   historyListItems(int index){
//
//     return Consumer<MyTicketsProvider>(builder: (_, myTicketsProvider, __) {
//       return Card(
//         elevation: 2,
//         child: Container(
//           padding: EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(myTicketsProvider.ticketsList[index].ticketno!, style: GoogleFonts.nunito(
//                       fontSize: 14,
//                       color: HexColor(MyColors.black),
//                       fontWeight: FontWeight.w600
//                   ),),
//                   Row(
//                     children: [
//                       // Text(myTicketsProvider.checkStatus(index), style: GoogleFonts.nunito(
//                       //     fontSize: 16,
//                       //     color: myTicketsProvider.checkStatusColor(index),
//                       //     fontWeight: FontWeight.w800
//                       // )),
//                     ],
//                   ),
//
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 3),
//                 // child: Text(
//                 //   myTicketsProvider.ticketsList[index].serviceTypeName!+" ("+myTicketsProvider.ticketsList[index].fromstnName!+"-"+myTicketsProvider.ticketsList[index].tostnName!+")", style: GoogleFonts.nunito(
//                 //     fontSize: 16,
//                 //     color: HexColor(MyColors.grey1),
//                 //     fontWeight: FontWeight.w500
//                 // ),),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 3),
//                     child: Row(
//                       children: [
//                         Text("Boarding: ", style: GoogleFonts.nunito(
//                             fontSize: 14,
//                             color: HexColor(MyColors.grey1),
//                             fontWeight: FontWeight.w500
//                         ),),
//                         // Text(myTicketsProvider.ticketsList[index].fromstnName!, style: GoogleFonts.nunito(
//                         //     fontSize: 14,
//                         //     color: HexColor(MyColors.black),
//                         //     fontWeight: FontWeight.w600
//                         // ),),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(right: 3),
//                         child: Image.asset(
//                           'assets/images/cal.png',
//                           height: 18,
//                           color: HexColor(MyColors.orange),
//                           width: 18,
//                         ),
//                       ),
//                       Text(myTicketsProvider.ticketsList[index].journeydate!, style: GoogleFonts.nunito(
//                           fontSize: 14,
//                           color: HexColor(MyColors.grey1),
//                           fontWeight: FontWeight.w600
//                       ),),
//                     ],
//                   )
//                 ],
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Container(
//                   margin: EdgeInsets.only(top: 5),
//                   padding: EdgeInsets.only(top: 3),
//                   child: Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Visibility(
//                         // visible: myTicketsProvider.ticketsResponse.tickets![index].currentStatus=="A"&&myTicketsProvider.ticketsResponse.tickets![index].forCancel=="Y"?true:false,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(
//                                 context,
//                                 MyRoutes.cancelTicketsScreen,
//                                 arguments: PaymentScreenArguments(_myTicketsProvider.ticketsResponse.tickets![index].ticketno!,"BookingTab")).then((value) => _myTicketsProvider.getTickets());
//
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(left: 8, right: 8),
//                             padding: EdgeInsets.only(
//                                 left: 15, right: 15, top: 6, bottom: 6),
//                             decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     "Cancel Ticket",
//                                     style: GoogleFonts.roboto(
//                                         color: Colors.white,
//                                         fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: true,
//                         child: GestureDetector(
//                           onTap: () {
//                             // Navigator.pushNamed(
//                             //     context,
//                             //     MyRoutes.cancelTicketsScreen,
//                             //     arguments: PaymentScreenArguments(_myTicketsProvider.ticketsResponse.tickets![index].ticketno!,"BookingTab")).then((value) => _myTicketsProvider.getTickets());
//
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(left: 8, right: 8),
//                             padding: EdgeInsets.only(
//                                 left: 15, right: 15, top: 6, bottom: 6),
//                             decoration: BoxDecoration(
//                                 color: HexColor(MyColors.green),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     "Download Ticket",
//                                     style: GoogleFonts.roboto(
//                                         color: Colors.white,
//                                         fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(
//                               context,
//                               MyRoutes.bookingHistoryDetailsScreen,
//                               arguments: PaymentScreenArguments(_myTicketsProvider.ticketsResponse.tickets![index].ticketno!,"BookingTab"));
//
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(left: 8, right: 8),
//                           padding: EdgeInsets.only(
//                               left: 15, right: 15, top: 6, bottom: 6),
//                           decoration: BoxDecoration(
//                               color: HexColor(MyColors.orange),
//                               borderRadius: BorderRadius.circular(8)),
//                           child: Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                   "View Details",
//                                   style: GoogleFonts.roboto(
//                                       color: HexColor(MyColors.white),
//                                       fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//
//       );
//     });
//
//   }
//
//   bookingHistoryListBuilder() {
//     return Consumer<MyTicketsProvider>(builder: (_, myTicketsProvider, __) {
//       return Stack(
//         children: [
//           Visibility(
//               visible: myTicketsProvider.isLoading?true:false,
//               child: CommonWidgets.buildCircularProgressIndicatorWidget()),
//           Visibility(
//               visible: myTicketsProvider.isLoading?false:true,
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: myTicketsProvider.ticketsList.length,
//                 // itemCount: 10,
//                 itemBuilder: (BuildContext context, int index) {
//                   return bookingListItems(index);
//                 },
//               )),
//         ],
//       );
//     });
//   }
//
//   void getArguments() {
//     var args = ModalRoute.of(context)!.settings.arguments as MyBookingsArguments?;
//     from = args!.from;
//     print(from);
//     // _myTicketsProvider.getTickets(from);
//
//   }
//
//   bookingListItems(int index){
//
//     return Consumer<MyTicketsProvider>(builder: (_, myTicketsProvider, __) {
//       return Card(
//         elevation: 2,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               flex: 9,
//               child: Container(
//                   margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 3),
//                   height: 180,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("PNR: "+myTicketsProvider.ticketsList[index].ticketno!,style: GoogleFonts.nunito(fontSize: 15),),
//                       Row(
//                         children: [
//                           Container(
//                             height: 50,
//                             margin: EdgeInsets.only(top: 8,right: 12,left: 12),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Container(
//                                   height: 10,
//                                   width: 10,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       border: Border.all(color: HexColor(MyColors.orange))
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 2),
//                                   width: 1,
//                                   height: 2,
//                                   color: HexColor(MyColors.orange),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 2),
//                                   width: 1,
//                                   height: 2,
//                                   color: HexColor(MyColors.orange),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 2),
//                                   width: 1,
//                                   height: 2,
//                                   color: HexColor(MyColors.orange),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 2),
//                                   width: 1,
//                                   height: 2,
//                                   color: HexColor(MyColors.orange),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 2),
//                                   width: 1,
//                                   height: 2,
//                                   color: HexColor(MyColors.orange),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 2,bottom: 2),
//                                   width: 1,
//                                   height: 2,
//                                   color: HexColor(MyColors.orange),
//                                 ),
//                                 Container(
//                                   height: 10,
//                                   width: 10,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       border: Border.all(color: HexColor(MyColors.orange))
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 70,
//                             padding: EdgeInsets.only(top: 10,bottom: 2),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(myTicketsProvider.ticketsList[index].source!,style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 16,fontWeight: FontWeight.bold),),
//                                 Text(myTicketsProvider.ticketsList[index].destination!,style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 16,fontWeight: FontWeight.bold),),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             margin : EdgeInsets.only(left: 8,right: 8,top: 8),
//                             child: Image.asset("assets/images/orangebus.png",height: 18,width: 18,color: HexColor(MyColors.orange),),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(myTicketsProvider.ticketsList[index].busservicetypename!,style: GoogleFonts.nunito(fontSize: 14),),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             margin : EdgeInsets.only(left: 8,top: 10),
//                             padding : EdgeInsets.only(right: 8),
//                             child: Image.asset(
//                               'assets/images/cal.png',
//                               height: 18,
//                               color: HexColor(MyColors.orange),
//                               width: 18,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(myTicketsProvider.ticketsList[index].journeydate!, style: GoogleFonts.nunito(
//                               fontSize: 14,
//                               color: HexColor(MyColors.black),),),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             margin : EdgeInsets.only(left: 8,right: 8,top: 8),
//                             // child: Image.asset(myTicketsProvider.setIconOnStatus(index),height: 18,width: 18),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             // child: Text(myTicketsProvider.checkStatus(index),style: GoogleFonts.nunito(fontSize: 16,color: myTicketsProvider.checkStatusColor(index),fontWeight: FontWeight.bold),),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Container(
//                 height: 180,
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Visibility(
//                         visible: true,
//                         // visible: myTicketsProvider.ticketsResponse.tickets![index].currentStatus=="A"&&myTicketsProvider.ticketsResponse.tickets![index].forCancel=="Y"?true:false,
//                         child: GestureDetector(
//                           onTap: () {
//
//                             Navigator.pushNamed(
//                                 context,
//                                 MyRoutes.cancelTicketsScreen,
//                                 arguments: PaymentScreenArguments(_myTicketsProvider.ticketsResponse.tickets![index].ticketno!,"BookingTab")).then((value) => _myTicketsProvider.getTickets());
//
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               // color: HexColor(MyColors.grey1),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Image.asset("assets/images/notconfirm_status.png",height: 50,width: 50,),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(
//                               context,
//                               MyRoutes.bookingHistoryDetailsScreen,
//                               arguments: PaymentScreenArguments(_myTicketsProvider.ticketsResponse.tickets![index].ticketno!,"BookingTab"));
//
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               // color: HexColor(MyColors.green),
//                               borderRadius: BorderRadius.circular(8)),
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image.asset("assets/images/downloadicon.png",height: 50,width: 50,),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(
//                               context,
//                               MyRoutes.bookingHistoryDetailsScreen,
//                               arguments: PaymentScreenArguments(_myTicketsProvider.ticketsResponse.tickets![index].ticketno!,"BookingTab"));
//
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               // color: HexColor(MyColors.orange),
//                               borderRadius: BorderRadius.circular(8)),
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image.asset("assets/images/viewdeatils.png",height: 30,width: 40,),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//
//       );
//     });
//
//   }
//
// }
