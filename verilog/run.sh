if [ ! -d bin ];
then
   echo "Directory bin does not exist, creating..."
   mkdir bin
fi

iverilog -o bin/alaw_test alaw_coder.v alaw_decoder.v alaw_test.v
vvp bin/alaw_test
gtkwave bin/out.vcd

