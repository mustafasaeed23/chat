class Category{
  static const String sportId ="sports";
  static const String musicId ="music";
  static const String moviesId ="movies";

  String id;
  late String title ;
  late String imagePath ;

  Category({
    required this.id,
    required this.title,
    required this.imagePath,

});

  Category.fromId(this.id){  // named constructor based on id
  if(id == sportId){
    title = "Sports";
    imagePath = 'assets/images/sports.png';
  }else if( id == moviesId){
    title = "Movies";
    imagePath = 'assets/images/movies.png';
  }else{
    title ="Music";
    imagePath = "assets/images/music.png";
  }

  }

  static List <Category> getCategory(){
    return[
      Category.fromId(sportId),
    Category.fromId(musicId),
    Category.fromId(moviesId),
    ];
  }
  }

