import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/getAllStation/get_destination_data_source.dart';
import 'package:utc_flutter_app/response/get_stations_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';

class AllStationsProvider extends ChangeNotifier {
  GetDestinationDataSource getDestinationDataSource = GetDestinationDataSource();
  String searchKeyword ="";
  String flag_F_T ="";

  Future<GetStationsResponse> getDestination(BuildContext context) async {
    if(searchKeyword.isEmpty){
      searchKeyword = "D";
    }
    var response = await getDestinationDataSource.getAllDestinationApi(searchKeyword,flag_F_T,AppConstants.IS_APP_ACTIVE_TOKEN);
    GetStationsResponse listresponse = GetStationsResponse.fromJson(response);
    if(listresponse.code=="100"){

    }else if(listresponse.code=="900"){
      CommonMethods.showErrorDialog(context, "Something went wrong, please try again !");
    }
    //print(response);
    searchKeyword ="";
    return listresponse;
  }

}
