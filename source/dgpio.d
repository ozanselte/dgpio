module dgpio;

import std.stdio : File;
import std.conv : to;
import std.string : strip;
import std.file : exists;

class GPIO{
	immutable ubyte gpio;
	private enum string exportFile = "/sys/class/gpio/export";
	private enum string unexportFile = "/sys/class/gpio/unexport";
	private immutable string pinFolder;
	private immutable string directionFile;
	private immutable string valueFile;

	private void writeLine(string file, string str){
		File f = File(file, "w");
		f.writeln(str);
	}

	private string readLine(string file){
		File f = File(file, "r");
		string line = strip(f.readln());
		return(line);
	}

	private void activate(){
		if(!exists(pinFolder)){
			writeLine(exportFile, to!string(gpio));
		}
	}

	void deactivate(){
		if(exists(pinFolder)){
			writeLine(unexportFile, to!string(gpio));
		}
	}

	void setInput(){
		writeLine(directionFile, "in");
	}

	void setOutput(){
		writeLine(directionFile, "out");
	}

	bool isInput(){
		string str = readLine(directionFile);
		return("in" == str)
	}

	bool isOutput(){
		string str = readLine(directionFile);
		return("out" == str)
	}

	void setHigh(){
		writeLine(valueFile, "1");
	}

	void setLow(){
		writeLine(valueFile, "0");
	}

	bool isHigh(){
		string str = readLine(valueFile);
		return("0" != str)
	}

	bool isLow(){
		string str = readLine(valueFile);
		return("0" == str)
	}

	this(ubyte gpio){
		pinFolder = "/sys/class/gpio/gpio" ~ to!string(gpio);
		directionFile = pinFolder ~ "/direction";
		valueFile = pinFolder ~ "/value";
		this.gpio = gpio;
		activate();
	}

	~this(){
		deactivate();
	}
}