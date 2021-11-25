class NotificationsModel {
  late bool status;
  late NotificationsData notData;

  NotificationsModel.fromJson(Map<String, dynamic>json){
    status=json['status'];
    notData=NotificationsData.fromJson(json['data']);
  }
}

class NotificationsData{
  late int currentPage;
  List<Data>data=[];

  NotificationsData.fromJson(Map<String, dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}

class Data{
  late int id;
  late String title;
  late String message;

  Data.fromJson(Map<String, dynamic>json){
    id=json['id'];
    title=json['title'];
    message=json['message'];
  }
}