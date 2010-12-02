if [ ! -d bin ];
then
   echo "Directory bin does not exist, creating..."
   mkdir bin
fi


iverilog -o bin/alaw_coder alaw_coder.v 
vvp bin/alaw_coder

