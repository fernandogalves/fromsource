#!/bin/bash
#
# Para obter mais informações sobre o apache, consulte o endereço http://httpd.apache.org
# http://httpd.apache.org/docs/2.4/install.html
#
export APACHE_VERSION="2.4.29"
export TMP_DIR="/tmp/apache"

echo "=================================================================================="
echo " Iniciando a instalação do apache no Oracle Linux Server 7.4"

#
# Passo 0: Verifica se o sistema operacional está correto
#
OS_VERSION=`cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2`

if [ "${OS_VERSION}" != "Oracle Linux Server 7.4" ]; then

	echo " O ${OS_VERSION} não é suportado por esse script"
	echo "=================================================================================="
	exit

else
	echo " ${OS_VERSION} detectado"
fi

#
# Passo 1: Instale as dependências para compilar o apache
#
echo " Passo 1: Instale as dependências para compilar o apache"
yum -y install wget gcc-c++ libxml2-devel expat-devel perl

#
# Passo 2: Crie uma área temporária para ser usada durante a instalação
#
echo " Passo 2: Crie uma área temporária para ser usada durante a instalação"
mkdir ${TMP_DIR}
cd ${TMP_DIR}

#
# Passo 3: Faça o download da versão desejada
#
echo " Passo 3: Faça o download da versão desejada"
wget http://mirror.nbtelecom.com.br/apache//httpd/httpd-${APACHE_VERSION}.tar.gz
tar xzvf httpd-${APACHE_VERSION}.tar.gz
cd httpd-${APACHE_VERSION}

#
# Passo 4: Baixe as dependências necessárias para a compilação
#
echo " Passo 4: Baixe as dependências necessárias para a compilação"
cd srclib

#
# Passo 4.1: Baixando o apr
#
echo " Passo 4.1: Baixando o apr"
wget http://ftp.unicamp.br/pub/apache//apr/apr-1.6.3.tar.gz
tar xzvf apr-1.6.3.tar.gz
mv apr-1.6.3 apr

#
# Passo 4.2: Baixando o apr-util
#
echo " Passo 4.2: Baixando o apr-util"
wget http://ftp.unicamp.br/pub/apache//apr/apr-util-1.6.1.tar.gz
tar xzvf apr-util-1.6.1.tar.gz
mv apr-util-1.6.1 apr-util

#
# Passo 4.3: Baixando e compilando o pcre
#
echo " Passo 4.3: Baixando e compilando o pcre"
cd ${TMP_DIR}
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.41.tar.gz
tar xzvf pcre-8.41.tar.gz
cd pcre-8.41
./configure
make
make install

#
# Passo 4.4: Atualizando a versão do openssl para trabalhando com ssl
#
echo " Passo 4.4: Atualizando a versão do openssl para trabalhando com ssl"
cd ${TMP_DIR}
wget https://www.openssl.org/source/openssl-1.0.2n.tar.gz
tar xzvf openssl-1.0.2n.tar.gz
cd openssl-1.0.2n
./Configure
./config shared --prefix=/usr/
make
make install

#
# Passo 5: Compilando e instalando o Apache
#
echo " Passo 5: Compilando e instalando o Apache"
cd ${TMP_DIR}/httpd-${APACHE_VERSION}
./configure --prefix=/etc/httpd --enable-ssl=shared --with-ssl=${TMP_DIR}/openssl-1.0.2n --with-included-apr
make 
make install

#
# Passo 6: Executando o apache
#
echo " Passo 6: Executando o apache"
export PATH=/etc/httpd/bin:$PATH
echo "export PATH=/etc/httpd/bin:$PATH" >> /etc/profile
/etc/httpd/bin/apachectl -k start

# Verifique se está no ar
netstat -tuplen | grep 80

/etc/httpd/bin/apachectl -V
