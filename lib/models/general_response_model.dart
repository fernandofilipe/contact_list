abstract class GeneralResponseModel {
  bool error;
  String title;
  String message;
  dynamic data;

  GeneralResponseModel({
    this.error = false,
    this.title = "",
    this.message = "",
    this.data,
  });
}

class ContactResponse extends GeneralResponseModel {
  ContactResponse({
    bool error = false,
    String title = "",
    String message = "",
    dynamic data,
  }) : super(error: error, title: title, message: message, data: data);
}
