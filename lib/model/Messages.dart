class Messages{
  static const String collectionName = 'Message';
  String id ;
  String roomId ;
  String content ;
  String senderId ;
  String senderName ;
  int dateTime ;

  Messages({
   this .id= '',
   required this.roomId,
   required this.content,
   required this.senderId,
   required this.senderName,
   required this.dateTime,
});

  Messages.fromJson(Map<String , dynamic>json):this(
    roomId: json['roomId'] as String ,
    id: json['id'] as String,
    content:  json['content'] as String,
    senderId: json['senderId'] as String,
    senderName: json ['senderName'] as String,
    dateTime: json ['dateTime'] as int ,
  );

  Map<String,dynamic>toJson(){
    return {
      "id" : id ,
      "roomId" : roomId,
      "content" : content,
      "senderId" : senderId,
      "senderName" : senderName,
      "dateTime" : dateTime,

    };
  }
}