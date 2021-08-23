sudo apt install -y git-all
sudo apt-get update
sudo apt-get install -y build-essential
sudo apt install openjdk-8-jdk
sudo apt-get install scala
sudo apt-get install sbt.
cd /usr/local/
wget https://archive.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
sudo wget https://archive.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
sudo tar xzf apache-maven-3.5.4-bin.tar.gz

# Add to this and source : /etc/profile.d/apache-maven.sh
export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=512m"
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export M2_HOME=/usr/local/apache-maven-3.5.4
export MAVEN_HOME=/usr/local/apache-maven-3.5.4
export PATH=${M2_HOME}/bin:${PATH}

git clone https://github.com/$GIT_USER/spark.git
cd spark/
git checkout v2.4.1
./build/mvn -DskipTests clean package


s
