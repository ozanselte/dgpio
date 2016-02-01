# dgpio
dgpio is a tiny GPIO control library for single board computers in D language.
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

### Write value to GPIO pin
```d
gpio.setOutput();
gpio.setHigh();
assert(gpio.isHigh() == true);
gpio.setLow();
assert(gpio.isHigh() == false);
```

### Check GPIO pin
```d
isInput = gpio.isInput();
isOutput = gpio.isOutput();
```


###  Error control
```d
GPIO gpio2 = new GPIO(99);
gpio.setOutput();
//if there isn't GPIO-99
assert(gpio2.error == true);
```

### Close GPIO pin
```d
gpio.deactivate();
```
