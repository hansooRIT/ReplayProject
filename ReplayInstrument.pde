// To make an Instrument we must define a class that implements
// the Instrument interface.
class ReplayInstrument implements Instrument
{
  Oscil wave;      // Need an oscillator to make sound
  Line  ampEnv;    // and a simple envelope to articulate cleanly
  boolean isFlanging, isDampening, isCrushing, isNoisy;
  Flanger flange;
  BitCrush crush;
  Damp damp;
  Noise noise;
  float duration;
  
  ReplayInstrument(int waveType, float frequency)
  {
    // Make a sine wave oscillator with amplitude zero because 
    // we are going to patch a Line envelope generator to it anyway
    wave = null;
    if (waveType == 1) {
       wave = new Oscil(frequency, 0, Waves.SINE);
    }
    else if (waveType == 2) {
       wave = new Oscil(frequency, 0, Waves.SQUARE);
    }
    else if (waveType == 3) {
       wave = new Oscil(frequency, 0, Waves.TRIANGLE);
    }
    else if (waveType == 4) {
       wave = new Oscil(frequency, 0, Waves.SAW);
    }
    else if (waveType == 5) {
       wave = new Oscil(frequency, 0, Waves.PHASOR);
    }
    else if (waveType == 6) {
       wave = new Oscil(frequency, 0, Waves.QUARTERPULSE);
    }
    ampEnv = new Line();
    ampEnv.patch(wave.amplitude);
    flange = new Flanger( 1,     // delay length in milliseconds ( clamped to [0,100] )
                        0.2f,   // lfo rate in Hz ( clamped at low end to 0.001 )
                        1,     // delay depth in milliseconds ( minimum of 0 )
                        0.5f,   // amount of feedback ( clamped to [0,1] )
                        0.5f,   // amount of dry signal ( clamped to [0,1] )
                        0.5f    // amount of wet signal ( clamped to [0,1] )
                       );
     damp = new Damp(0.001, 0.7);
     crush = new BitCrush(1, 1);
     noise = new Noise(0.1, Noise.Tint.WHITE);
     duration = 0.0f;
  }

  // This is called when this instrument should start making sound.
  // The duration is expressed in seconds.
  void noteOn(float duration)
  {
    // Attach the oscil to the output so it makes sound
    if (isDampening) {
      damp.setDampTimeFromDuration(duration);
      damp.activate();
      damp.patch(out);
      wave.patch(damp);
    }
    if (isFlanging) {
      wave.patch(flange);
    }
    if (isCrushing) {
      wave.patch(crush);
      crush.patch(out);
    }
    if (isNoisy) {
      noise.patch(out);
    }
    wave.patch(out);
    // Start the amplitude envelope
    ampEnv.activate(duration, 0.20f, 0);
  }

  // This is called when the instrument should stop making sound.
  // Not used explicitly in this example because of the envelope,
  // but has to be here to implement the Instrument interface.
  void noteOff()
  {
    if (isNoisy) {
      noise.unpatch(out);
    }
    wave.unpatch(out);
  }
}