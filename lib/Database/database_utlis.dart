import 'package:chat_app/model/Messages.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtills{

  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: ((snapshot, options) => MyUser.fromjson(snapshot.data()!)),
        toFirestore: (user,options) => user.toJson());
  }

  static CollectionReference<Room> getRoomCollection(){
    return FirebaseFirestore.instance.collection(Room.collectionName).
    withConverter<Room>
      (fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!) ,
        toFirestore: (room,options)=>room.toJson());
  }

  static CollectionReference<Messages>getMessagesCollection(String roomId){
    return FirebaseFirestore.instance.collection(Room.collectionName).doc(roomId)
        .collection(Messages.collectionName)
        .withConverter<Messages>(
        fromFirestore: (snapshat,options) =>Messages.fromJson(snapshat.data()!),
        toFirestore: (messages , options) =>messages.toJson());
  }

  static Future<void> registerUser(MyUser user) async {
     return getUserCollection().doc(user.id).set(user);
  }

  static Future <MyUser?> getUser(String userId) async{
  var docSnapShot = await getUserCollection().doc(userId).get();
   return docSnapShot.data();
  }

  static Future <void> addRoomToFireStore(Room room) async{
  var docRef =   getRoomCollection().doc();
  room.roomId = docRef.id;
  return   docRef.set(room);
  }

  static Stream<QuerySnapshot<Room>> getRooms(){
    return getRoomCollection().snapshots();
  }

  static Future <void> insertMessage(Messages messages) async{
    var messageCollection = getMessagesCollection(messages.roomId);
    var docRef = messageCollection.doc();
    messages.id = docRef.id ;
    return docRef.set(messages);
  }

  static Stream<QuerySnapshot<Messages>> getMessagesFromFireStore(String roomId){
   return getMessagesCollection(roomId).orderBy('dateTime').snapshots();
  }




}