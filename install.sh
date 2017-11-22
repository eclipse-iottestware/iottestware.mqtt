#!/bin/sh
#################################################################################
# Copyright (c) 2017 Relayr GmbH                                                #
# All rights reserved. This program and the accompanying materials              #
# are made available under the terms of the Eclipse Public License v1.0         #
# which accompanies this distribution, and is available at                      #
# http://www.eclipse.org/legal/epl-v10.html                                     #
#                                                                               #
# Contributors:                                                                 #
#   Alexander Kaiser                                                            #
#################################################################################

# This script will clone the required Titan TestPorts, ProtocolModules and Libraries
# from the official Titan repositories. 
# Having these modules in this structure allows you to import these Modules easily with 
# the corresponding .tpd files into the Titan IDE.

#################
# CONFIGURATION #
#################

# base path for the titan protocol modules and test ports
PATH_BASE=~/Titan

# path where you can compile the Test Suite
PATH_CLI_WORKSPACE=~/IoTTestware

# Git flags
GIT_QUIET=-q # remove this flag for complete Git output


################
# INSTALLATION # !! Do not change from here
################
# These are prescribed in the tpd Files!
PATH_CORE=${PATH_BASE}/Core
PATH_SOCKET_API=${PATH_BASE}/TestPorts/Common_Components/Socket_API_CNL113686/
PATH_IPL4=${PATH_BASE}/TestPorts/IPL4asp/

#PATH_COAP=${PATH_BASE}/ProtocolModules/CoAP/
PATH_MQTT=${PATH_BASE}/ProtocolModules/MQTT/
PATH_COMMON=${PATH_BASE}/ProtocolModules/COMMON/
PATH_TCC=${PATH_BASE}/Libraries/TCCUsefulFunctions_CNL113472/

PATH_IOTTESTWARE=${PATH_BASE}/IoTTestware
PATH_MQTT_TW=${PATH_IOTTESTWARE}/iottestware.mqtt/

#####################
# IoT-Testware.MQTT #
#####################
if [ -d "$PATH_MQTT_TW" ]; then
  echo $PATH_MQTT_TW " already exists"

  # goto the directory
  cd $PATH_MQTT_TW

  # make sure you have the latest codebase
  git remote update
  git checkout $GIT_QUIET master
  git pull $GIT_QUIET

  # return back to the last known folder
  cd - > /dev/null
else
  git clone $GIT_QUIET https://github.com/eclipse/iottestware.mqtt.git $PATH_MQTT_TW
fi


##############
# Titan.Core #
##############
if [ -d "$PATH_CORE" ]; then
  echo $PATH_CORE " aready exists"

  # goto the directory 
  cd $PATH_CORE

  # make sure you have the latest codebase
  git remote update
  git checkout  $GIT_QUIET master
  git pull $GIT_QUIET
 
  # return back to the last known folder
  cd - > /dev/null
else
  git clone $GIT_QUIET https://github.com/eclipse/titan.core.git $PATH_CORE
fi

#############
# TestPorts #
#############
if [ -d "$PATH_SOCKET_API" ]; then
  echo $PATH_SOCKET_API " already exists"

  # goto the directory 
  cd $PATH_SOCKET_API

  # make sure you have the latest codebase
  git remote update
  git checkout  $GIT_QUIET master
  git pull $GIT_QUIET
 
  # return back to the last known folder
  cd - > /dev/null
else
  git clone https://github.com/eclipse/titan.TestPorts.Common_Components.Socket-API.git $PATH_SOCKET_API
fi

if [ -d "$PATH_IPL4" ]; then
  echo $PATH_IPL4 " already exists"

  # goto the directory 
  cd $PATH_IPL4

  # make sure you have the latest codebase
  git remote update
  git checkout  $GIT_QUIET master
  git pull $GIT_QUIET
 
  # return back to the last known folder
  cd - > /dev/null
else
  git clone https://github.com/eclipse/titan.TestPorts.IPL4asp.git $PATH_IPL4
fi

###################
# ProtocolModules #
###################
if [ -d "$PATH_MQTT" ]; then
  echo $PATH_MQTT " already exists"

  # goto the directory 
  cd $PATH_MQTT

  # make sure you have the latest codebase
  git remote update
  git checkout  $GIT_QUIET master
  git pull $GIT_QUIET
 
  # return back to the last known folder
  cd - > /dev/null
else
  git clone git://git.eclipse.org/gitroot/titan/titan.ProtocolModules.MQTT.git $PATH_MQTT
fi

if [ -d "$PATH_COMMON" ]; then
  echo $PATH_COMMON " already exists"

  # goto the directory 
  cd $PATH_COMMON

  # make sure you have the latest codebase
  git remote update
  git checkout  $GIT_QUIET master
  git pull $GIT_QUIET
 
  # return back to the last known folder
  cd - > /dev/null
else
  git clone https://github.com/eclipse/titan.ProtocolModules.COMMON.git $PATH_COMMON
fi

#############
# Libraries #
#############
if [ -d "$PATH_TCC" ]; then
  echo $PATH_TCC " already exists"

  # goto the directory 
  cd $PATH_TCC

  # make sure you have the latest codebase
  git remote update
  git checkout  $GIT_QUIET master
  git pull $GIT_QUIET
 
  # return back to the last known folder
  cd - > /dev/null
else
  git clone https://github.com/eclipse/titan.Libraries.TCCUsefulFunctions.git $PATH_TCC
fi


#########################
# create symbolic links #
# and prepare workspace #
#########################
if [ -d "${PATH_CLI_WORKSPACE}/iottestware.mqtt/bin" ]; then
  # clean the bin folder
  rm $PATH_CLI_WORKSPACE/iottestware.mqtt/bin/*
else
  mkdir -p ${PATH_CLI_WORKSPACE}/iottestware.mqtt/bin
fi

cd ${PATH_CLI_WORKSPACE}/iottestware.mqtt/bin

# link to MQTT ProtocolModule
ln -s ${PATH_MQTT}/src/negative_testing/MQTT_v3_1_1_Types.ttcn
ln -s ${PATH_MQTT}/src/negative_testing/MQTT_v3_1_1_IPL4SizeFunction.ttcn
ln -s ${PATH_MQTT}/src/negative_testing/MQTT_v3_1_1_EncDec.cc
ln -s ${PATH_MQTT}/src/negative_testing/MQTT_v3_1_1_Size.cc

# link to IPL4asp TestPort
ln -s ${PATH_IPL4}/src/IPL4asp_Types.ttcn
ln -s ${PATH_IPL4}/src/IPL4asp_Functions.ttcn
ln -s ${PATH_IPL4}/src/IPL4asp_PortType.ttcn
ln -s ${PATH_IPL4}/src/IPL4asp_PT.cc
ln -s ${PATH_IPL4}/src/IPL4asp_PT.hh
ln -s ${PATH_IPL4}/src/IPL4asp_protocol_L234.hh
ln -s ${PATH_IPL4}/src/IPL4asp_discovery.cc

# link to Socket_API_CNL113686
ln -s ${PATH_SOCKET_API}/src/Socket_API_Definitions.ttcn

# link to TTC LIBRARY
ln -s ${PATH_TCC}/src/TCCInterface_Functions.ttcn
ln -s ${PATH_TCC}/src/TCCInterface_ip.h
ln -s ${PATH_TCC}/src/TCCInterface.cc
ln -s ${PATH_TCC}/src/TCCConversion_Functions.ttcn
ln -s ${PATH_TCC}/src/TCCConversion.cc

# link the MQTT TestSuite sources to bin
ln -s ${PATH_MQTT_TW}/src/MQTT_Functions.ttcn
ln -s ${PATH_MQTT_TW}/src/MQTT_Pixits.ttcn
ln -s ${PATH_MQTT_TW}/src/MQTT_Templates.ttcn
ln -s ${PATH_MQTT_TW}/src/MQTT_TestCases.ttcn
ln -s ${PATH_MQTT_TW}/src/MQTT_TestControl.ttcn
ln -s ${PATH_MQTT_TW}/src/MQTT_TestSystem.ttcn
ln -s ${PATH_MQTT_TW}/src/MQTT_TypesAndValues.ttcn

# build the makefile
ttcn3_makefilegen -f -g -c -m -e iottestware.mqtt *.ttcn *.hh *.cc
