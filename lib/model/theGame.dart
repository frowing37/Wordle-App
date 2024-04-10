class theGame {

  String? u1ID;
  String? u1Name;
  String? u1Target;

  String? u2ID;
  String? u2Name;
  String? u2Target;

  theGame(this.u1ID,this.u1Name,this.u2ID,this.u2Name);

  setU1Target(String word) {
    this.u1Target = word;
  }

  setU2Target(String word) {
    this.u2Target = word;
  }

}