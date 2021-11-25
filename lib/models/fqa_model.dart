class FQAsModel {
  late bool status;
  late Data data;

  FQAsModel.fromJson(Map<String, dynamic>json){
    status=json['status'];
    data=Data.fromJson(json['data']);
  }
}
class Data {
  late int currentPage;
  List<QA>data=[];

  Data.fromJson(Map<String, dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(QA.fromJson(element));
    });
  }
}
class QA{
  late int id;
  late String question;
  late String answer;

  QA.fromJson(Map<String, dynamic>json){
    id=json['id'];
    question=json['question'];
    answer=json['answer'];
  }
}