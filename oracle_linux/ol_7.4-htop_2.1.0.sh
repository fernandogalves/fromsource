#!/bin/bash
#
# Para obter mais informações sobre o htop, consulte o endereço http://hisham.hm/htop/
#
export HTOP_VERSION="2.1.0"
export TMP_DIR="/tmp/htop"

#
# Passo 1: Instala as dependências do htop
#
yum -y install ncurses ncurses-devel wget gcc-c++

#
# Passo 2: Cria uma área temporária para ser usada durante a instalação
#
mkdir ${TMP_DIR}
cd ${TMP_DIR}

#
# Passo 3: Faz o download da versão desejada
#
wget http://hisham.hm/htop/releases/${HTOP_VERSION}/htop-${HTOP_VERSION}.tar.gz
tar -zxvf htop-${HTOP_VERSION}.tar.gz
cd htop-${HTOP_VERSION}

#
# Passo 4: Configura, compila e instala o htop
#
./configure
make
make install

#
# Passo 5: Execute o htop and have fun!
#

# Para visualizar a ajuda do comando htop
htop -h

# Para executar o htop
htop

# Para sair, aperte a tecla q
