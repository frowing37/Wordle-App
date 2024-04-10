class theGame {

  String? u1ID;
  String? u1Name;
  String? u1Target;
  bool u1IsReady = false;

  String? u2ID;
  String? u2Name;
  String? u2Target;
  bool u2IsReady = false;

  theGame(this.u1ID,this.u1Name,this.u2ID,this.u2Name);

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

}