class ReplayObject {
  float startTime, endTime;
  boolean isFinished;
  String pitch;
  
  ReplayObject(String p, float time) {
    pitch = p;
    startTime = time;
    isFinished = false;
  }
}