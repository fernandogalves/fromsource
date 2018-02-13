#!/bin/bash
#
# Para obter mais informações sobre o apachetop, consulte o endereço http://hisham.hm/htop/
#
export TMP_DIR="/tmp/apachetop"

#
# Passo 1: Instala as dependências do htop
#
zypper -n in autoconf automake gamin-devel gcc-c++ glibc-devel libadns-devel libtool make ncurses-devel pcre-devel pkgconfig readline-devel

#
# Passo 2: Cria uma área temporária para ser usada durante a instalação
#
mkdir ${TMP_DIR}
cd ${TMP_DIR}

#
# Passo 3: Faz o download da versão desejada
#
wget https://github.com/tessus/apachetop/archive/master.zip
unzip master.zip
cd apachetop-master/

#
# Passo 4: Configura, compila e instala o apachetop
#
./autogen.sh
./configure
make
make install

#
# Passo 5: Execute o apachetop and have fun!
#

# Para visualizar a ajuda do comando htop
apachetop -h

# Para executar o apachetop
apachetop -f /var/log/apache2/access_log

# Para sair, aperte CTRL + C
