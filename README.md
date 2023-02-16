This will only run under Linux.  Windows should be possible, but the volume mount for the config server and the build commands will need to be adjusted.
You need GNU make, Java 17, and docker to run these examples.

To run the examples, just run `make all`

If you want to see the trace logging from ConfigDataEnvironment, add `-eCONFIG_LOGGING=TRACE` to the `docker run ... example` lines

