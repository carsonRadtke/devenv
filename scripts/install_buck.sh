git clone https://github.com/facebook/buck.git
cd buck
ant
./bin/buck build buck

ln -s ./bin/buck $1/bin/buck
