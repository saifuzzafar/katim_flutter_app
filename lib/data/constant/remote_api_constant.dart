class RemoteApiConstant {
  static String clientId = 'MzM2MTIzOTF8MTY4Mzg5NDI5Ny45Mjk1MTQy';
  static String secreteId =
      '78ec9b9d0f72cee6e2a8080ebf86770dffdccdf57b41768335476e99f6afaca6';
  static const host = "https://api.seatgeek.com/2";
  static String eventListUrl() {
    return "${RemoteApiConstant.host}/events/";
  }
}
