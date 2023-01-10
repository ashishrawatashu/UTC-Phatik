abstract class SaveRatingApi{
  Future<dynamic> saveRatingApi(
      String userId,
      String ticketNo,
      String portalRating,
      String staffRating,
      String busRating,
      String portalFeedback,
      String staffFeedback,
      String busFeedback,
      String ip_imei,
      String token);

}