import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/dataSource/saveRatingDataSource/save_rating_data_source.dart';
import 'package:utc_flutter_app/response/save_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class RateScreenProvider extends ChangeNotifier{

  TextEditingController ourServiceTextEditingController = TextEditingController();
  TextEditingController busDriverTextEditingController = TextEditingController();
  TextEditingController bookingPortalTextEditingController = TextEditingController();


  setTextEditingController(int sectionNo){
    if(sectionNo==1){
      return ourServiceTextEditingController;
    }else if(sectionNo==2){
      return busDriverTextEditingController;
    }else if(sectionNo==3){
      return bookingPortalTextEditingController;
    }
  }


  var _ourServiceFeedback;
  get ourServiceFeedback => _ourServiceFeedback;

  var _busDriverFeedback;
  get busDriverFeedback => _busDriverFeedback;

  var _bookingPortalFeedback;
  get bookingPortalFeedback => _bookingPortalFeedback;


  returnValidation(int sectionNo){
    if(sectionNo==1){
      return ourServiceFeedback;
    }else if(sectionNo==2){
      return busDriverFeedback;
    }else if(sectionNo==3){
      return bookingPortalFeedback;
    }
  }


  String portalFeedback = "";
  String staffFeedback = "";
  String busFeedback = "";
  String ticketNo = "";

  feedbackValidation(String feedback, int sectionNo){
    if(sectionNo==1){
      if(!feedback.isEmpty){
        _ourServiceFeedback = null;
        staffFeedback = feedback;
      } else {
        _ourServiceFeedback = "Please enter your feedback!";
      }
    }else if (sectionNo==2){
      if(!feedback.isEmpty){
        _busDriverFeedback = null;
        busFeedback = feedback;
      } else {
        _busDriverFeedback = "Please enter your feedback!";
      }
    }else if(sectionNo==3){
      if(!feedback.isEmpty){
        _bookingPortalFeedback = null;
        portalFeedback = feedback;
      } else {
        _bookingPortalFeedback = "Please enter your feedback!";
      }
    }

    notifyListeners();

  }



  bool ourServiceEditText = false;
  bool busDriverEditText = false;
  bool bookingPortalEditText = false;

  int sectionNoOneRating = 0;
  int sectionNoTwoRating = 0;
  int sectionNoThreeRating = 0;



  setVisibilityOfEditText(int starRating, int sectionNo){
    if(sectionNo==1){
      if(starRating<=3){
        ourServiceEditText = true;
      }else{
        ourServiceEditText = false;
      }
    }else if(sectionNo==2){
      if(starRating<=3){
        busDriverEditText = true;
      }else{
        busDriverEditText = false;
      }
    }else if(sectionNo==3){
      if(starRating<=3){
        bookingPortalEditText = true;
      }else{
        bookingPortalEditText = false;
      }
    }

    setRatingSectionWise(sectionNo, starRating);
  }

  getVisibilityOfEditText(int sectionNo){
    if(sectionNo==1){
      return ourServiceEditText;
    }else if(sectionNo==2){
      return busDriverEditText;
    }else if(sectionNo==3){
      return bookingPortalEditText;
    }
  }

  setStarRatingBgColor(int sectionNo,int starRating){
    if(sectionNo==1){
      if(sectionNoOneRating==1){
        if(starRating==1){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoOneRating==2){
        if(starRating==1||starRating==2){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoOneRating==3){
        if(starRating==1||starRating==2||starRating==3){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoOneRating==4){
        if(starRating==1||starRating==2||starRating==3||starRating==4){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoOneRating==5){
        if(starRating==1||starRating==2||starRating==3||starRating==4||starRating==5){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else{
        return HexColor(MyColors.grey8);
      }
    }else if(sectionNo==2){
      if(sectionNoTwoRating==1){
        if(starRating==1){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoTwoRating==2){
        if(starRating==1||starRating==2){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoTwoRating==3){
        if(starRating==1||starRating==2||starRating==3){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoTwoRating==4){
        if(starRating==1||starRating==2||starRating==3||starRating==4){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoTwoRating==5){
        if(starRating==1||starRating==2||starRating==3||starRating==4||starRating==5){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else{
        return HexColor(MyColors.grey8);
      }
    } else if(sectionNo==3){
      if(sectionNoThreeRating==1){
        if(starRating==1){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoThreeRating==2){
        if(starRating==1||starRating==2){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoThreeRating==3){
        if(starRating==1||starRating==2||starRating==3){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoThreeRating==4){
        if(starRating==1||starRating==2||starRating==3||starRating==4){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else if(sectionNoThreeRating==5){
        if(starRating==1||starRating==2||starRating==3||starRating==4||starRating==5){
          return HexColor(MyColors.green);
        }else{
          return HexColor(MyColors.grey8);
        }
      }else{
        return HexColor(MyColors.grey8);
      }
    }

  }

  setStarColor(int sectionNo,int starRating){
    if(sectionNo==1){
      if(sectionNoOneRating==1){
        if(starRating==1){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoOneRating==2){
        if(starRating==1||starRating==2){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoOneRating==3){
        if(starRating==1||starRating==2||starRating==3){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoOneRating==4){
        if(starRating==1||starRating==2||starRating==3||starRating==4){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoOneRating==5){
        if(starRating==1||starRating==2||starRating==3||starRating==4||starRating==5){
            return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else {
        return "assets/images/blackstar.png";
      }
    }else if(sectionNo==2){
      if(sectionNoTwoRating==1){
        if(starRating==1){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoTwoRating==2){
        if(starRating==1||starRating==2){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoTwoRating==3){
        if(starRating==1||starRating==2||starRating==3){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoTwoRating==4){
        if(starRating==1||starRating==2||starRating==3||starRating==4){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoTwoRating==5){
        if(starRating==1||starRating==2||starRating==3||starRating==4||starRating==5){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else {
        return "assets/images/blackstar.png";
      }
    } else if(sectionNo==3){
      if(sectionNoThreeRating==1){
        if(starRating==1){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoThreeRating==2){
        if(starRating==1||starRating==2){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoThreeRating==3){
        if(starRating==1||starRating==2||starRating==3){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoThreeRating==4){
        if(starRating==1||starRating==2||starRating==3||starRating==4){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else if(sectionNoThreeRating==5){
        if(starRating==1||starRating==2||starRating==3||starRating==4||starRating==5){
          return "assets/images/whitestar.png";
        }else{
          return "assets/images/blackstar.png";
        }
      }else {
        return "assets/images/blackstar.png";
      }
    }



  }

  setRateColor(int sectionNo,int starRating){

    if(sectionNo==1){
      if(sectionNoOneRating==1){
        if(starRating==1){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoOneRating==2){
        if(starRating==1||starRating==2){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoOneRating==3){
        if(starRating==1||starRating==2||starRating==3){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoOneRating==4){
        if(starRating==1||starRating==2||starRating==3||starRating==4){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoOneRating==5){
        if(starRating==1||starRating==2||starRating==3||starRating==4||starRating==5){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }
    }else if(sectionNo==2){
      if(sectionNoTwoRating==1){
        if(starRating==1){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoTwoRating==2){
        if(starRating==1||starRating==2){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoTwoRating==3){
        if(starRating==1||starRating==2||starRating==3){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoTwoRating==4){
        if(starRating==1||starRating==2||starRating==3||starRating==4){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoTwoRating==5){
        if(starRating==1||starRating==2||starRating==3||starRating==4||starRating==5){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }
    } else if(sectionNo==3){
      if(sectionNoThreeRating==1){
        if(starRating==1){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoThreeRating==2){
        if(starRating==1||starRating==2){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoThreeRating==3){
        if(starRating==1||starRating==2||starRating==3){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoThreeRating==4){
        if(starRating==1||starRating==2||starRating==3||starRating==4){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }else if(sectionNoThreeRating==5){
        if(starRating==1||starRating==2||starRating==3||starRating==4||starRating==5){
          return HexColor(MyColors.white);
        }else{
          return HexColor(MyColors.black);
        }
      }
    }



  }

  setRatingSectionWise(int sectionNo,int starRating){
    if(sectionNo==1){
      sectionNoOneRating = starRating;
    }else if(sectionNo==2){
      sectionNoTwoRating = starRating;
    }else if(sectionNo==3){
      sectionNoThreeRating = starRating;
    }
    notifyListeners();

  }

  checkStarRatingValidation(){
    if(sectionNoOneRating==0||sectionNoTwoRating==0||sectionNoThreeRating==0){
      return true;
    }else{
      return false;
    }
  }


  SaveResponse saveResponse = SaveResponse();
  SaveRatingDataSource saveRatingDataSource = SaveRatingDataSource();
  Future<SaveResponse> saveRating() async {
    var response = await saveRatingDataSource.saveRatingApi(ticketNo, AppConstants.USER_MOBILE_NO, sectionNoThreeRating.toString(), sectionNoOneRating.toString(), sectionNoTwoRating.toString(), portalFeedback, staffFeedback, busFeedback, AppConstants.DEVICE_ID!,AppConstants.MY_TOKEN);
    print(response);
    saveResponse = SaveResponse.fromJson(response);
    return saveResponse;
  }

  @override
  void dispose() {
    super.dispose();
    bookingPortalTextEditingController.dispose();
  }


  clear(){

    ourServiceTextEditingController.clear();
    busDriverTextEditingController.clear();
    bookingPortalTextEditingController.clear();
    sectionNoOneRating = 0;
    sectionNoTwoRating = 0;
    sectionNoThreeRating = 0;

    ourServiceEditText = false;
    busDriverEditText = false;
    bookingPortalEditText = false;
  }


}