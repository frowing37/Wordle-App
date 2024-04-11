class theGame {

  String? gameID;
  String? u1ID;
  String? u1Name;
  String? u1Target = " ";
  bool u1IsReady = false;

  String? u2ID;
  String? u2Name;
  String? u2Target = " ";
  bool u2IsReady = false;

  theGame(this.gameID,this.u1ID,this.u1Name,this.u2ID,this.u2Name);

  theGame.allField(this.gameID,this.u1ID,this.u1Name,this.u1Target,this.u1IsReady,this.u2ID,this.u2Name,this.u2Target,this.u2IsReady);

  theGame.nul();

  setU1Target(String word) {
    this.u1Target = word;
  }

  setU2Target(String word) {
    this.u2Target = word;
  }

  setU1Ready() {
    this.u1IsReady = true;
  }

  setU2Ready() {
    this.u2IsReady = true;
  }

  bool U1IsReady() {
    return this.u1IsReady;
  }

  bool U2IsReady() {
    return this.u2IsReady;
  }

  Map<String, dynamic> toJson() {
    return {
      "gameID": gameID,
      "user1UID": u1ID,
      "user1Name": u1Name,
      "user1Target" : u1Target,
      "user1IsReady" : u1IsReady,
      "user2UID": u2ID,
      "user2Name": u2Name,
      "user2Target" : u2Target,
      "user2IsReady" : u2IsReady,
    };
  }

  factory theGame.fromJson(Map<String, dynamic> json) {
    return theGame.allField(
      json['gameID'].toString(),
      json['user1UID'].toString(),
      json['user1Name'],
      json['user1Target'].toString(),
      json['user1IsReady'],
      json['user2UID'].toString(),
      json['user2Name'],
      json['user2Target'].toString(),
      json['user2IsReady'],
    );
  }

}