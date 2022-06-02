s.boot;
s.scope;
FreqScope.new();
s.plotTree;

////////////
/// INIT ///
////////////

(
s.sendBundle(0.1, [\b_alloc, 0, 4096], [\b_alloc, 1, 4096],	[\b_gen, 0, \sine2, 3, 0.5, 1],	[\b_gen, 1, \sine3, 2, 0.125, 1, 0.25]);
b = Bus.audio(s);
SynthDef("out", { arg master = 1;
	Out.ar([0,1], In.ar(b)*master);
}).send;
)

///////////////
/// PATCHES ///
///////////////

(
// Electric Piano 1

SynthDef(\ep1, {

	arg vol = 1, noteFreq = 440, gate = 1, cutoff = 20000, lfofreq = 0;
	var	env1, env2, env3, env4,	freq1, freq2, freq3, freq4,	amp1, amp2, amp3, amp4,
	op1, op2, op3, op4, sig, lfo;

	// ENVELOPES

	env4 = EnvGen.kr(Env.adsr(0.01, 2, 0, 0.05), gate: gate, doneAction: 2);
	env3 = EnvGen.kr(Env.adsr(0.01, 2, 0, 0.05), gate: gate, doneAction: 2);
	env2 = EnvGen.kr(Env.adsr(0.01, 1, 0, 0.05), gate: gate, doneAction: 2);
	env1 = EnvGen.kr(Env.adsr(0.01, 3, 0.5, 0.05), gate: gate, doneAction: 2);

	// FREQUENCIES

	freq4 = 1 * noteFreq;
	freq3 = 1 * noteFreq;
	freq2 = 14 * noteFreq;
	freq1 = 1 * noteFreq;

	// AMPLITUDES

	amp4 = freq4 * 10*(10**(-4.4/20)); // -4.4dB
	amp3 = 0.2;
	amp2 = freq2 * 10*(10**(-26/20)); // -26dB
	amp1 = 0.2;

	// OPERATORS

	op4 = SinOsc.ar(freq: freq4, mul: amp4*env4);
	op3 = SinOsc.ar(freq: freq3 + op4, mul: amp3*env3);
	op2 = SinOsc.ar(freq: freq2, mul: amp2*env2);
	op1 = SinOsc.ar(freq: freq1 + op2, mul: amp1*env1);
	sig = RLPF.ar(op1+op3, cutoff.lag(0.02), 0.25, 0.2);
	lfo = SinOsc.kr(lfofreq, 1);

	Out.ar(b, sig*vol*lfo);

}).send;

// Electric Piano 2

SynthDef(\ep2, {

	arg vol = 1, noteFreq = 440, gate = 1, cutoff = 20000, lfofreq = 0;
	var	env1, env2, env3, freq1, freq2, freq3, amp1, amp2, amp3, op1, op2, op3, sig,lfo;

	// ENVELOPES

	env3 = EnvGen.kr(Env.adsr(0, 0.01, 0, 0.05), gate: gate, doneAction: 2);
	env2 = EnvGen.kr(Env.adsr(0, 0.6, 1, 0.05), gate: gate, doneAction: 2);
	env1 = EnvGen.kr(Env.adsr(0, 0.9, -13.dbamp, 0.05), gate: gate, doneAction: 2);

	// FREQUENCIES

	freq3 = 10 * noteFreq;
	freq2 = 1 * noteFreq;
	freq1 = 1 * noteFreq;

	// AMPLITUDES

	amp3 = freq3 * 10*(10**(-22/20)); // -22dB
	amp2 = freq2 * 10*(10**(-22/20)); // -22dB
	amp1 = 0.5;

	// OPERATORS

	op3 = SinOsc.ar(freq: freq3, mul: amp3*env3);
	op2 = SinOsc.ar(freq: freq2 + op3, mul: amp2*env2);
	op1 = SinOsc.ar(freq: freq1 + op2, mul: amp1*env1);
	sig = RLPF.ar(op1, cutoff.lag(0.02), 0.25, 0.2);
	lfo = SinOsc.kr(lfofreq, 1);

	Out.ar(b, sig*vol*lfo);

}).send;

// Pluck

SynthDef(\pluck, {

	arg vol = 1, noteFreq = 440, gate = 1, cutoff = 20000, lfofreq = 0;
	var	env1, env2, freq1, freq2, amp1, amp2, op1, op2, sig, lfo;

	// ENVELOPES

	env2 = EnvGen.kr(Env.adsr(0, 0.25, 0.1, 2), gate: gate, doneAction: 2);
	env1 = EnvGen.kr(Env.adsr(0, 0.25, 0.1, 2), gate: gate, doneAction: 2);

	// FREQUENCIES

	freq2 = 1 * noteFreq;
	freq1 = 1 * noteFreq;

	// AMPLITUDES

	amp2 = freq2 * 10*(10**(-6/20)); // -6dB
	amp1 = 0.5;

	// OPERATORS

	op2 = SinOsc.ar(freq: freq2, mul: amp2*env2);
	op1 = SinOsc.ar(freq: freq1 + op2, mul: amp1*env1);

	sig = RLPF.ar(op1, cutoff.lag(0.02), 0.25, 0.2);
	lfo = SinOsc.kr(lfofreq, 1);

	Out.ar(b, sig*vol*lfo);

}).send;

// Organ

SynthDef(\organ, {

	arg vol = 1, noteFreq = 440, gate = 1, cutoff = 20000, lfofreq = 0;
	var	env1, env2, env3, env4,	freq1, freq2, freq3, freq4,	amp1, amp2, amp3, amp4,
	op1, op2, op3, op4, sig, lfo;

	// ENVELOPES

	env4 = EnvGen.kr(Env.adsr(0.1, 0.6, 1, 2), gate: gate, doneAction: 2);
	env3 = EnvGen.kr(Env.adsr(0.1, 0.6, 1, 2), gate: gate, doneAction: 2);
	env2 = EnvGen.kr(Env.adsr(0.1, 0.6, 1, 2), gate: gate, doneAction: 2);
	env1 = EnvGen.kr(Env.adsr(0.1, 0.6, 1, 2), gate: gate, doneAction: 2);

	// FREQUENCIES

	freq4 = 4 * noteFreq;
	freq3 = 2 * noteFreq;
	freq2 = 1 * noteFreq;
	freq1 = 0.5 * noteFreq;

	// AMPLITUDES

	amp4 = 0.1;
	amp3 = 0.1;
	amp2 = 0.1;
	amp1 = 0.1;

	// OPERATORS

	op4 = Saw.ar(freq: freq4, mul: amp4*env4);
	op3 = Saw.ar(freq: freq3, mul: amp3*env3);
	op2 = Saw.ar(freq: freq2, mul: amp2*env2);
	op1 = Saw.ar(freq: freq1, mul: amp1*env1);

	sig = RLPF.ar(op1+op2+op3+op4, cutoff.lag(0.02), 0.25, 0.2);
	lfo = SinOsc.kr(lfofreq, 1);

	Out.ar(b, sig*vol*lfo);

}).send;

// Bass

SynthDef(\bass, {

	arg vol = 1, noteFreq = 440, gate = 1, cutoff = 20000, lfofreq = 0;
	var	env1, env2, env3, env4,	freq1, freq2, freq3, freq4,	amp1, amp2, amp3, amp4,
	op1, op2, op3, op4, sig, lfo;

	// ENVELOPES

	env4 = EnvGen.kr(Env.adsr(0, 0.6, 1, 0.05), gate: gate, doneAction: 2);
	env3 = EnvGen.kr(Env.adsr(0, 0.6, 1, 0.05), gate: gate, doneAction: 2);
	env2 = EnvGen.kr(Env.adsr(0, 0.6, 1, 0.05), gate: gate, doneAction: 2);
	env1 = EnvGen.kr(Env.adsr(0, 0.6, 1, 0.05), gate: gate, doneAction: 2);

	// FREQUENCIES

	freq4 = 1 * noteFreq;
	freq3 = 2 * noteFreq;
	freq2 = 0.5 * noteFreq;
	freq1 = 1 * noteFreq;

	// AMPLITUDES

	amp4 = freq4 * 10*(10**(-13/20)); // -13dB
	amp3 = -5.dbamp;
	amp2 = -9.dbamp;
	amp1 = -12.dbamp;

	// OPERATORS

	op4 = SinOsc.ar(freq: freq4, mul: amp4*env4);
	op3 = SinOsc.ar(freq: freq3 + op4, mul: amp3*env3);
	op2 = SinOsc.ar(freq: freq2, mul: amp2*env2);
	op1 = SinOsc.ar(freq: freq1, mul: amp1*env1);

	sig = RLPF.ar(op1+op2+op3, cutoff.lag(0.02), 0.25, 0.2);
	lfo = SinOsc.kr(lfofreq, 1);

	Out.ar(b, sig*vol*lfo);

}).send;

// MM

SynthDef(\mm, {

	arg vol = 0.15, gate = 1, noteFreq = 440, amp = 1, atk = 0.01, rel = 1, cur =  -2,
	pan = 0, spr = 1, mFq1 = 1000, mAmp1 = 0.1, mFq2 = 2000, mAmp2 = 0.1, cutoff = 20000, lfofreq = 0;
	var env, op1, op2, op3, op4, sig, mod1, mod2, lfo;

	mod1 = Pulse.ar(ExpRand(4,500),mul:Rand(100,1000));
	mod2 = SinOsc.ar(Rand(-0.3,0.3),mul:Rand(100,2000));

	env = EnvGen.kr(Env.adsr(atk, 0.01,1,rel,amp,cur),gate,doneAction:2);

	op1 = SinOsc.ar(mFq1 + SinOsc.ar(Rand(-0.3, 0.3),mul:Rand(100,2000)),mul:mAmp1);
	op2 = SinOsc.ar(mFq2 + rrand(mod1, mod2), op1,mul:mAmp2);
	op3 = SinOsc.ar(noteFreq + 3, op2,mul:env);
	op4 = SinOsc.ar(noteFreq - 3, op3,mul:env);

	sig = Mix.ar({[op3,op4,op4,op3]}!4);
	sig = Splay.ar(sig, spr, env, pan);
	sig = LeakDC.ar(sig);

	sig = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 0.2);
	lfo = SinOsc.kr(lfofreq, 1);

	Out.ar(b, sig*vol*lfo);

}).send;

// Violin

SynthDef(\violin, {
	arg dur = 3, noteFreq = 440, amp = 0.5, fmindex = 3, fm1rat = 1, fm2rat = 3,
	    fm3rat = 4, noiseamt = 0.1, locate = 0.5, envtab = 0, fmtab = 1, cutoff = 20000, vol = 1, lfofreq = 0;

	var env, modfreq1, modfreq2, modfreq3, index1, index2, index3, dev1, dev2, dev3, noisefreq,
		noiseamp, envdur, chan1, chan2, vib, randvib, vibrate, noise, noiseenv, fmenv, pitchenv,
		mod1, mod2, mod3, modall, car, sig, sig1, sig2, lfo;

	modfreq1 = noteFreq * fm1rat;
	modfreq2 = noteFreq * fm2rat;
	modfreq3 = noteFreq * fm3rat;
	index1 = (7.5 / noteFreq.log) * fmindex;
	index2 = (15.0 / noteFreq.sqrt) * fmindex;
	index3 = (1.25 / noteFreq.sqrt) * fmindex;
	dev1 = index1 * noteFreq;
	dev2 = index2 * noteFreq;
	dev3 = index3 * noteFreq;
	amp = amp * 0.25;
	noisefreq = 1000;
	noiseamp = noiseamt * amp;
	chan1 = locate.sqrt;
	chan2 = (1 - locate).sqrt;

	// Vibrato Section

	randvib = LFNoise1.kr(5, 0.0075);
	vibrate = EnvGen.kr(
		Env([1, 3.5, 4.5, 1], [0.5, dur - 1.0, 0.5], \exp),
		doneAction: 0);
	vib = SinOsc.ar(vibrate, 0, randvib);
	vib = vib + 1;

	// Noise
	// In the book version of the FM-violin, the noise is
	// added to the output signal to simulate bow noise at
	// the beginning of a note. In this instrument the
	// noise is part of the modulation signal creating a
	// band of noise around the carrier frequency.

	noiseenv = EnvGen.kr(
		Env([1, 0.001, 0.001], [dur * 0.25, dur * 0.75], \exp),
		doneAction: 2);
	noise = LFNoise1.ar(noisefreq, noiseenv * noiseamp);

	env = Osc.kr(envtab, dur.reciprocal, 0, 1);
	fmenv = Osc.kr(fmtab, dur.reciprocal, 0, 1);
	pitchenv = XLine.kr(1, 1.001, dur);

	// Modulator section

	mod1 = SinOsc.ar(modfreq1 * pitchenv * vib, 0, dev1 * fmenv);
	mod2 = SinOsc.ar(modfreq2 * pitchenv * vib, 0, dev2 * fmenv);
	mod3 = SinOsc.ar(modfreq3 * pitchenv * vib, 0, dev3 * fmenv);

	modall = mod1 + mod2 + mod3 + noise;

	car = SinOsc.ar((noteFreq + modall) * pitchenv * vib, 0, amp);

	sig = car * env;

	// Make the signal stereo and place somewhere between the channels.
	sig1 = sig * chan1;
	sig2 = sig * chan2;

	sig1 = RLPF.ar(sig1, cutoff.lag(0.02), 0.25, 0.2);
	sig2 = RLPF.ar(sig2, cutoff.lag(0.02), 0.25, 0.2);
	lfo = SinOsc.kr(lfofreq, 1);

	Out.ar(b, [sig1, sig2]*vol*lfo);
}).send;
)

////////////
/// MIDI ///
////////////

(
o = Synth(\out);

MIDIClient.init;
MIDIIn.connectAll;
MIDIFunc.trace();

~notes = Array.newClear(128);
~patch = 1;

~on = MIDIFunc.noteOn({ |veloc, num, chan, src|
	switch(~patch,
		1, { ~notes[num] = Synth(\ep1, [\noteFreq, num.midicps, \vol, 1]); },
		2, { ~notes[num] = Synth(\ep2, [\noteFreq, num.midicps, \vol, 1]); },
		3, { ~notes[num] = Synth(\pluck, [\noteFreq, num.midicps, \vol, 1]); },
		4, { ~notes[num] = Synth(\organ, [\noteFreq, num.midicps, \vol, 1]); },
		5, { ~notes[num] = Synth(\bass, [\noteFreq, num.midicps, \vol, 1]); },
		6, { ~notes[num] = Synth(\mm, [\noteFreq, num.midicps, \vol, 1]); },
		7, { ~notes[num] = Synth(\violin, [\noteFreq, num.midicps, \vol, 10]); }
	);
});

~off = MIDIFunc.noteOff({ |veloc, num, chan, src|
	~notes[num].set(\gate, 0);
	~notes[num] = nil;
});

q = { ~on.free; ~off.free; };
)

q.value;

// o.set(\master, 1);