module dgpio;

import std.stdio : File;
import std.conv : to;
import std.string : strip;

class GPIO{
	immutable ubyte gpio;
	bool err = false;

	private void activate(){
		try{
			File pExport = File("/sys/class/gpio/export", "w");
			pExport.writefln("%s", gpio);
			pExport.close();
		}catch(Exception e){
			err = true;
		}
	}

	void deactivate(){
		try{
			File pUnexport = File("/sys/class/gpio/unexport", "w");
			pUnexport.writefln("%s", gpio);
			pUnexport.close();
		}catch(Exception e){
			err = true;
		}
	}

	void setInput(){
		scope(failure){
			err = true;
		}
		File pDirection = File("/sys/class/gpio/gpio" ~ to!string(gpio) ~ "/direction", "w");
		pDirection.writefln("in");
		pDirection.close();
	}

	void setOutput(){
		scope(failure){
			err = true;
		}
		File pDirection = File("/sys/class/gpio/gpio" ~ to!string(gpio) ~ "/direction", "w");
		pDirection.writefln("out");
		pDirection.close();
	}

	bool isInput(){
		scope(failure){
			err = true;
		}
		File pDirection = File("/sys/class/gpio/gpio" ~ to!string(gpio) ~ "/direction", "r");
		string str = strip(pDirection.readln());
		pDirection.close();
		switch(str){
			case "in":
				return(true);
			default:
				return(false);
		}
	}

	bool isOutput(){
		scope(failure){
			err = true;
		}
		File pDirection = File("/sys/class/gpio/gpio" ~ to!string(gpio) ~ "/direction", "r");
		string str = strip(pDirection.readln());
		pDirection.close();
		switch(str){
			case "out":
				return(true);
			default:
				return(false);
		}
	}

	void setHigh(){
		scope(failure){
			err = true;
			return;
		}
		File pValue = File("/sys/class/gpio/gpio" ~ to!string(gpio) ~ "/value", "w");
		pValue.writefln("1");
		pValue.close();
	}

	void setLow(){
		scope(failure){
			err = true;
			return;
		}
		File pValue = File("/sys/class/gpio/gpio" ~ to!string(gpio) ~ "/value", "w");
		pValue.writefln("0");
		pValue.close();
	}

	bool isHigh(){
		scope(failure){
			err = true;
		}
		File pValue = File("/sys/class/gpio/gpio" ~ to!string(gpio) ~ "/value", "r");
		string str = strip(pValue.readln());
		pValue.close();
		switch(str){
			case "0":
				return(false);
			default:
				return(true);
		}
	}

	bool isLow(){
		scope(failure){
			err = true;
		}
		File pValue = File("/sys/class/gpio/gpio" ~ to!string(gpio) ~ "/value", "r");
		string str = strip(pValue.readln());
		pValue.close();
		switch(str){
			case "0":
				return(true);
			default:
				return(false);
		}
	}

	void deleteError(){
		scope(failure){
			err = true;
		}
		err = false;
	}

	this(ubyte gpio){
		scope(failure){
			err = true;
		}
		this.gpio = gpio;
		activate();
	}

	~this(){
		deactivate();
	}
}