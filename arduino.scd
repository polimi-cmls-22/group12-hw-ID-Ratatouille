/* This code sets up the communication between SC, Arduino and Processing */

SerialPort.devices;
~port = SerialPort.new("COM5", 9600); //insert Arduino Serial port
~processing = NetAddr.new("192.168.1.10", 57121); //insert IP address used by Processing

//Read values from Arduino sensors

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

// Receives mssages from Processing to select the desired patch
(
OSCFunc({
	arg msg, time, addr, recvPort;
	~patch = msg[1];
}, '/sferaScelta');
NetAddr.localAddr;
)


// Updates values accordingly to serial reading and sends OSC messages to Processing

(
~control = Routine.new({
	{
		 o.set(\pan,~val2.linlin(107,310,-1,1));
		o.set(\master, ~val4.linlin(0,1023,0,10));
		~notes.do{
			arg item;
			if(item.notNil, {
				item.set(\cutoff,~val1.linexp(0,1023,80,20000));
				item.set(\lfofreq,~val3.linexp(111,313,0.1,20));

			}
		)};

		~val1.postln;
		~processing.sendMsg("/light", ~val1);
		~processing.sendMsg("/cutOff", ~val1.linexp(0,1023,80,20000));
		~val2.postln;
		~processing.sendMsg("/xAxis", ~val2);
		~val3.postln;
		~processing.sendMsg("/yAxis", ~val3);
		~processing.sendMsg("/lfofreq", ~val3.linexp(111,313,0.1,20) );
	    ~processing.sendMsg("/master", ~val4.linlin(0,1023,0,10) );
		0.01.wait;
	}.loop;
}).play;
)
