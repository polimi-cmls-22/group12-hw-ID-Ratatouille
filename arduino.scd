s.boot;
SerialPort.devices;
~port = SerialPort.new("COM5", 9600);
~processing = NetAddr.new("192.168.1.201", 57121);
//iphone "172.20.10.3"


/*

OSCdef('OSCreceiver',
	{
		arg msg;
		x = msg[1];
		y = msg[2];

		x = (x-0.5)/0.5;

		postln("x: "+x+" - y: "+y);

		synth1.set(\amp,y / 2 ,\pan,x);
		synth2.set(\amp, (1-y) / 2,\pan,1-x);

	},
	"/pos");
)*/

(
~charArray = [ ];
~getValues = Routine.new({
	var ascii;
	{
		ascii = ~port.read.asAscii;
		if(ascii.isDecDigit,{~charArray = ~charArray.add(ascii)});
		if(ascii == $a,{
			~val1= ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
		});
		if(ascii == $b,{
			~val2 = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
		});
		if(ascii == $c,{
			~val3 = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
		});
		if(ascii == $d,{
			~val4 = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
		});
	}.loop;
}).play;
)

/* PROVA SENSORI
(
SynthDef.new("signal",{
	arg cutoff = 1000, pan = 0, freq=8, freq1 = 440;
	var sig, lfo;
	lfo = SinOsc.kr(freq);
	sig = SinOsc.ar(freq1, mul:0.1) + SinOsc.ar(freq1) + SinOsc.ar(freq1/2);
	sig = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 0.2);
	Out.ar(0,Pan2.ar(sig*lfo,pan));
}).add;
)


~synth = Synth("signal",[\cutoff7,200,\pan,0]);
~synth.set(\cutoff, 4000);
~synth.free;
*/

(
OSCFunc({
	arg msg, time, addr, recvPort;
	~patch = msg[1];
}, '/sferaScelta');
NetAddr.localAddr;
)

(
~control = Routine.new({
	{
		~notes.do{
			arg item;
			if(item.notNil, {
				item.set(\cutoff,~val1.linexp(0,1023,80,20000));
				item.set(\lfofreq,~val3.linexp(111,313,0.1,20));
			}
		)};
		//~synth.set(\cutoff,~val1.linexp(0,1023,80,4000),\pan,~val2.linlin(107,310,-1,1),\freq,~val3.linexp(111,313,0.1,20));
		~val1.postln;
		~processing.sendMsg("/light", ~val1);
		~processing.sendMsg("/cutOff", ~val1.linexp(0,1023,80,20000));
		~val2.postln;
		~processing.sendMsg("/xAxis", ~val2);
		~val3.postln;
		~processing.sendMsg("/yAxis", ~val3);
		~processing.sendMsg("lfofreq", ~val3.linexp(111,313,0.1,20) );
		0.01.wait;
	}.loop;
}).play;
)


~patch.postln