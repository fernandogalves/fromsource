#!/bin/bash
#
# Para obter mais informações sobre o iftop, consulte o endereço http://www.ex-parrot.com/pdw/iftop/
#
export IFTOP_VERSION="0.17"
export TMP_DIR="/tmp/iftop"

#
# Passo 1: Instale as dependências para compilar o iftop
#
# Habilita os repositórios
yum -y install libpcap libpcap-devel ncurses ncurses-devel wget gcc-c++ yum-utils
yum-config-manager --enable ol7_optional_latest

#
# Passo 2: Crie uma área temporária para ser usada durante a instalação
#
mkdir ${TMP_DIR}
cd ${TMP_DIR}

#
# Passo 3: Faça o download da versão desejada
#
wget http://www.ex-parrot.com/pdw/iftop/download/iftop-${IFTOP_VERSION}.tar.gz
tar -zxvf iftop-${IFTOP_VERSION}.tar.gz
cd iftop-${IFTOP_VERSION}

#
# Passo 4: Configure, compile e instale o iftop
#
./configure
make
make install

#
# Passo 5: Execute o iftop and have fun!
#

# Para visualizar a ajuda do comando iftop
iftop -h

# Para executar o iftop
iftop

# Para sair, aperte a tecla q
