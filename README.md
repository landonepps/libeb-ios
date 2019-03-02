# libeb-ios

A static framework for the eb library version 4.3.3. Built for iOS 10.0 - 12.x.
Supports armv7 - arm64e with bitcode enabled.
Feel free to use the compiled framework in your own projects.

### Building

To build library, run ./src/preconf.sh
Compiled library will be located at ./src/build/libeb.a
Move libeb.a to eb.framework/Versions/A/eb

### Note

I didn't create this project, I just updated it and made the framework file.
The license for the original eb library still applies.
I used the source code from https://salsa.debian.org/debian/eb/
