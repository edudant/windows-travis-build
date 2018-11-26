export PATH=/cygdrive/c/tools/cygwin/bin:$PATH

url=$(curl -silent https://api.adoptopenjdk.net/openjdk10/nightly/x64_Win/ | grep 'binary_link' | grep -Eo '(http|https)://[^"]+' | head -1)
wget --quiet ${url}
zip_file=$(basename ${url})
target=$(unzip -Z1 ${zip_file} | grep 'bin/javac'  | tr '/' '\n' | tail -3 | head -1)
unzip -q ${zip_file}

export JAVA_HOME=$(cd "${target}"; pwd)
export PATH=${JAVA_HOME}/bin:$PATH 

git config --system core.longpaths true
git config --global core.autocrlf false
mv openjdk-build /openjdk-build
cd /openjdk-build
export LOG=info
./makejdk-any-platform.sh jdk11u

