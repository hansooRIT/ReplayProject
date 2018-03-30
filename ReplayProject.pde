
// Magic words to import minim library
import ddf.minim.*;
import ddf.minim.ugens.*;

// Need an object for the Minim system
Minim minim;

// Need an object for the output to the speakers
AudioOutput out;

// Need a unit generator for the oscillator
Oscil wave;
PFont font;
boolean isRecording, isReplaying, isFlanging, isDampening, isCrushing, isReversed, isNoisy;
ReplayInstrument instrument;
ArrayList<ReplayObject> notesToReplay;
float startTime;
int waveType;
String waveTypeString;

void setup()
{
  size(1024, 400);
  font = createFont("Helvetica", 14);
  minim = new Minim(this);
  out = minim.getLineOut();
  notesToReplay = new ArrayList<ReplayObject>();
  startTime = 0.0f;
  waveType = 1;
  waveTypeString = "Sine";
}

void draw()
{
  background(0);
  stroke(255);
  text("'asdf' row: white piano keys. 'qwerty' row: black keys", 20, 20);
  text("Press 1-6 to change the oscillator's wavetables", 750, 20);
  text("Press the space bar to toggle on the recording of user key presses", 20, 40);
  text("Press the enter key to play back the recorded audio with the effects applied", 20, 60);
  text("Press z-b to toggle the effects the playback will have", 20, 80);
  text("Is recording: " + isRecording, 20, 100);
  text("Is flanging: " + isFlanging, 200, 100);
  text("Is dampening: " + isDampening, 20, 120);
  text("Is crunching: " + isCrushing, 200, 120);
  text("Is reversed: " + isReversed, 20, 140);
  text("White noise: " + isNoisy, 200, 140);
  text("Current waveform shape: " + waveTypeString, 750, 40);
  // Draw the waveforms in real time
  for (int i = 0; i < out.bufferSize() - 1; i++)
  {
    line( i, 200 + out.left.get(i)*50, i+1, 200 + out.left.get(i+1)*50 );
  }
}

void replay() {
  if (!isReversed) {
    for (int i = 0; i < notesToReplay.size(); i++) {
      ReplayObject r = notesToReplay.get(i);
      instrument = new ReplayInstrument(waveType, Frequency.ofPitch(r.pitch).asHz());
      if (isFlanging) {
        instrument.isFlanging = true;
      }
      if (isDampening) {
        instrument.isDampening = true;
      }
      if (isCrushing) {
        instrument.isCrushing = true;
      }
      if (isNoisy) {
        instrument.isNoisy = true;
      }
      out.playNote(r.startTime/1000.0, r.endTime/1000.0, instrument);
      print("Note start: " + r.startTime + "\nNote end: " + r.endTime + "\nFrequency: " + r.pitch + "\n");
    }
  }
  else {
    float newStart = 0.0f;
    for (int i = notesToReplay.size() - 1; i > 0; i--) {
      ReplayObject r = notesToReplay.get(i);
      if (i == notesToReplay.size() - 1) {
        newStart = r.endTime;
      }
      instrument = new ReplayInstrument(waveType, Frequency.ofPitch(r.pitch).asHz());
      if (isFlanging) {
        instrument.isFlanging = true;
      }
      if (isDampening) {
        instrument.isDampening = true;
      }
      if (isCrushing) {
        instrument.isCrushing = true;
      }
      if (isNoisy) {
        instrument.isNoisy = true;
      }
      out.playNote((r.endTime - newStart)/-1000.0, (r.startTime - newStart)/-1000.0, instrument);
      print("Note start: " + r.startTime + "\nNote end: " + r.endTime + "\nFrequency: " + r.pitch + "\n");
    }
  }
}

// Implement a piano keyboard on the computer keyboard with the "asdf" row
// being the white keys and the "qwerty" row being the black keys
// z implements the bit crushing while x handles playing and pausing the mp3.
void keyPressed()
{
  boolean playKey = false;
  String pitch = null;  // Assume the key is not one that maps to a pitch
  ReplayInstrument instrument = null;
  switch (key)
  {
  case 'a': 
    pitch = "C4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("C4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'w':
    pitch = "C#4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("C#4", millis() - startTime));
    }
    playKey = true;
    break;
  case 's': 
    pitch = "D4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("D4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'e':
    pitch = "D#4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("D#4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'd': 
    pitch = "E4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("E4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'f': 
    pitch = "F4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("F4", millis() - startTime));
    }
    playKey = true;
    break;
  case 't':
    pitch = "F#4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("F#4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'g': 
    pitch = "G4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("G4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'y':
    pitch = "G#4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("G#4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'h': 
    pitch = "A4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("A4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'u':
    pitch = "A#4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("A#4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'j': 
    pitch = "B4";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("B4", millis() - startTime));
    }
    playKey = true;
    break;
  case 'k': 
    pitch = "C5";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("C5", millis() - startTime));
    }
    playKey = true;
    break;
  case 'o':
    pitch = "C#5";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("C#5", millis() - startTime));
    }
    playKey = true;
    break;
  case 'l': 
    pitch = "D5";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("D5", millis() - startTime));
    }
    playKey = true;
    break;
  case 'p':
    pitch = "D#5";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("D#5", millis() - startTime));
    }
    playKey = true;
    break;
  case ';': 
    pitch = "E5";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("E5", millis() - startTime));
    }
    playKey = true;
    break;
  case '\'': 
    pitch = "F5";
    if (isRecording) {
      notesToReplay.add(new ReplayObject("F5", millis() - startTime));
    }
    playKey = true;
    break;
  case ' ':
    if (!isRecording) {
      isRecording = true;
      notesToReplay.clear();
      startTime = millis();
    }
    else {
      isRecording = false;
    }
    break;
  case ENTER:
     replay();
   break;
  case 'z':
    if (isFlanging) {
      isFlanging = false;
    }
    else {
      isFlanging = true;
    }
    break;
 case 'x':
    if (isDampening) {
      isDampening = false;
    }
    else {
      isDampening = true;
    }
  break;
  case 'c':
    if (isCrushing) {
      isCrushing = false;
    }
    else {
      isCrushing = true;
    }
    break;
  case 'v':
    if (isReversed) {
      isReversed = false;
    }
    else {
      isReversed = true;
    }
    break;
   case 'b':
    if (isNoisy) {
      isNoisy = false;
    }
    else {
      isNoisy = true;
    }
    break;
  case 49:
    waveType = 1;
    waveTypeString = "Sine";
    break;
  case 50:
    waveType = 2;
    waveTypeString = "Square";
    break;
  case 51:
    waveType = 3;
    waveTypeString = "Traingle";
    break;
  case 52:
    waveType = 4;
    waveTypeString = "Saw";
    break;
  case 53:
    waveType = 5;
    waveTypeString = "Phasor";
    break;
  case 54:
    waveType = 6;
    waveTypeString = "Quarterpulse";
    break;
  }
  if (playKey) {
    instrument = new ReplayInstrument(waveType, Frequency.ofPitch(pitch).asHz());
    out.playNote(0.0, 1.0, instrument);
  }
}

void keyReleased() {
  String pitch = null;
  switch (key)
  {
  case 'a': 
    pitch = "C4";
    break;
  case 'w':
    pitch = "C#4";
    break;
  case 's': 
    pitch = "D4";
    break;
  case 'e':
    pitch = "D#4";
    break;
  case 'd': 
    pitch = "E4";
    break;
  case 'f': 
    pitch = "F4";
    break;
  case 't':
    pitch = "F#4";
    break;
  case 'g': 
    pitch = "G4";
    break;
  case 'y':
    pitch = "G#4";
    break;
  case 'h': 
    pitch = "A4";
    break;
  case 'u':
    pitch = "A#4";
    break;
  case 'j': 
    pitch = "B4";
    break;
  case 'k': 
    pitch = "C5";
    break;
  case 'o':
    pitch = "C#5";
    break;
  case 'l': 
    pitch = "D5";
    break;
  case 'p':
    pitch = "D#5";
    break;
  case ';': 
    pitch = "E5";
    break;
  case '\'': 
    pitch = "F5";
    break;
  }
  if (isRecording && pitch != null) {
     for (int i = 0; i < notesToReplay.size(); i++) {
       if (notesToReplay.get(i).pitch == pitch && notesToReplay.get(i).isFinished == false) {
         notesToReplay.get(i).endTime = millis() - startTime;
         notesToReplay.get(i).isFinished = true;
         print(millis() - startTime + " \n");
       }
     }
  }
}