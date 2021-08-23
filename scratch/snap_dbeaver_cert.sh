
#snap dbeaver location
cd /snap/dbeaver-ce/current/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/



#How to add certificate to snap
sudo snap set system store-certs.certname="$(cat certname.crt)"
sudo snap set system store-certs.cert2="$(cat legacyca.crt)"
sudo snap set system store-certs.cert3="$(cat RH-IT-Root-CA.crt)"
