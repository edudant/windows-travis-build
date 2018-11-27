export PATH=/cygdrive/c/tools/cygwin/bin:$PATH

url=$(curl -silent https://api.adoptopenjdk.net/openjdk10/nightly/x64_Win/ | grep 'binary_link' | grep -Eo '(http|https)://[^"]+' | head -1)
wget --quiet ${url}
zip_file=$(basename ${url})
target=$(unzip -Z1 ${zip_file} | grep 'bin/javac'  | tr '/' '\n' | tail -3 | head -1)
unzip -q ${zip_file}

export JAVA_HOME=$(cd "${target}"; pwd)
export PATH=${JAVA_HOME}/bin:$PATH 

unset -v CC
unset -v CXX
cd ./openjdk-build
export LOG=info
./makejdk-any-platform.sh --tag jdk-11.0.1+12  --configure-args '-disable-warnings-as-errors' --processors 2 jdk11u

