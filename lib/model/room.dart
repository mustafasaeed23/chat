class Room{
  static const String collectionName = 'rooms';
  String roomId ;
  String roomTitle ;
  String roomDesc ;
  String categoryId ;

  Room({
    required this.roomId,
    required this.roomTitle,
    required this.roomDesc,
    required this.categoryId,
});

  Room.fromJson(Map<String , dynamic>json): this
  (
   roomId: json['roomId'] as String,
      roomDesc: json['roomDesc'] as String,
      roomTitle: json['roomTitle'] as String,
      categoryId: json['categoryId'] as String,
  );

  Map<String,dynamic>toJson(){
    return{
      "roomId" : roomId,
      "roomDesc" : roomDesc,
      "roomTitle" : roomTitle,
      "categoryId" : categoryId,
    };
  }
}