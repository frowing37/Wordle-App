class turns {

  String? gameID;

  String? u1ID;
  List<String> u1Turns = [];

  String? u2ID;
  List<String> u2Turns = [];

  turns(this.gameID, this.u1ID, this.u2ID);

  turns.allField(this.gameID, this.u1ID,this.u1Turns,this.u2ID,this.u2Turns);

  turns.nul();

  void addTurn(String uid, String word) {
    if(uid == "u1") {
      u1Turns.add(word);
    } else {
      u2Turns.add(word);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "gameID" : gameID,
      "u1ID" : u1ID,
      "u1Turns" : u1Turns,
      "u2ID" : u2ID,
      "u2Turns" : u2Turns,
    };
  }

  factory turns.fromJson(Map<String, dynamic> json) {
    return turns.allField(json["gameID"].toString(),
                          json["u1ID"].toString(),
                          json["u1Turns"],
                          json["u2ID"].toString(),
                          json["u2Turns"]);
  }
}