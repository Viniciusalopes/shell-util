#!/usr/bin/env bash
# Template proudly created by (Shell-Base)

#-----------HEADER-------------------------------------------------------------|
# AUTHOR      : Vovolinux <suporte@vovolinux.com.br>
# HOMEPAGE    : https://vovolinux.com.br 
# CREATED     : 08/11/2021 às 00:52 
# SOFTWARE    : install
# VERSION     : 1.0.0
# LICENSE     : MIT - © 2021 - Vovolinux
# DESCRIPTION : Install the shell-util-core library.
# PORPOUSE    : Automate library installation.4
#
# CHANGELOG   :
#
#------------------------------------------------------------------------------|


#--------------------------------- VARIÁVEIS ---------------------------------->
#
SU_RAW="https://raw.githubusercontent.com/Viniciusalopes/shell-util/master"
SU_TMP="/tmp/shell-util"
SU_FILE="shell-util-core.su"
SU_CFG="shell-util-core.cfg"

#------------------------------- FIM-VARIÁVEIS --------------------------------<


#----------------------------------- FUNÇÕES ---------------------------------->
#

#--------------------------------- FIM-FUNÇÕES --------------------------------<


#---------------------------------- TESTES ------------------------------------>
#

#--------------------------------- FIM-TESTES ---------------------------------<
        
# Program starts here :)

# Import shell-util-core and its dependencies
# Include in scripts that will use shell-util-core

# Create directory for dependencies
if ! [[ -d "${SU_TMP}" ]]; then
    sudo mkdir -pv "${SU_TMP}" \
    && sudo chown $USER:$USER ${SU_TMP} -Rfv
fi

# Check if the wget program is installed
printf %b "Checking 'wget' -> "
which wget
if [[ $? -ne 0 ]]; then
    printf %b "FAIL!\n'wget' package is not installed.\n"
    printf %b "Trying to install 'wget' -> "
    sudo apt install -y wget
    if [[ $? -ne 0 ]]; then
        printf %b "FAIL!\n'wget' dependency not satisfied.\n" && exit 1
    fi
fi

# shell-util-core download
printf %b "Downloading '${SU_FILE} and ${SU_CFG}' -> "

if [[ -f "${SU_TMP}/${SU_FILE}" && -f "${SU_TMP}/${SU_CFG}" ]]; then
    printf %b "OK\n"
else
    wget -v ${SU_RAW}/${SU_FILE} -O ${SU_TMP}/${SU_FILE} \
    && wget -v ${SU_RAW}/${SU_CFG} -O ${SU_TMP}/${SU_CFG}
    # Exit if unable to install package
    if [[ $? -ne 0 ]]; then
        printf %b "FAIL!\nDependencies '${SU_FILE} and ${SU_CFG}' where not satisfed." \
        && rm -rfv ${SU_TMP}/ \
        && exit 1
    fi
fi

cd "${SU_TMP}" \
&& source "${SU_TMP}/${SU_FILE}" \
&& cd -
printf %b 'shell-util instalation finished.\n'