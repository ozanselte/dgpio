import std.stdio;
import dgpio;

void main(){
	GPIO gpio = new GPIO(17);
	gpio.setInput();
	writefln("Is GPIO-17 in input mode? %s", gpio.isInput());
	writefln("Is GPIO-17 in output mode? %s", gpio.isOutput());
	writefln("Is GPIO-17 high? %s", gpio.isHigh());
	writefln("Is GPIO-17 low? %s", gpio.isLow());
	gpio.deactivate();
}