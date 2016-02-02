# dgpio
dgpio is a tiny GPIO control library for all linux single board computers in D language.
# Install
### If dub is installed
```shell
git clone https://github.com/ozanselte/dgpio.git
cd dgpio

# with dub
sudo dub

# with dmd
cd sources
dmd -lib dgpio.d -oflibdgpio.a

# with gdc
cd sources
gdc -c -o dgpio.o dgpio.d
ar rsc libdgpio.a dgpio.o
```

# Usage
### Import library
```d
import dgpio;
```
### Create new GPIO class
```d
GPIO gpio = new GPIO(17);
```
### Read value from GPIO pin
```d
gpio.setInput();
bool gpioHigh = gpio.isHigh();
bool gpioLow = gpio.isLow();
assert(gpio.isHigh() != gpio.isLow());
```

### Write digital value
```d
gpio.setOutput();
gpio.setHigh();
assert(gpio.isHigh() == true);
gpio.setLow();
assert(gpio.isHigh() == false);
```

### Check GPIO pin
```d
ubyte gpioPin = gpio.gpio;
bool isInput = gpio.isInput();
bool isOutput = gpio.isOutput();
```

### Close GPIO pin
```d
gpio.deactivate();
```
