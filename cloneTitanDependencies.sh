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

# set your base path for the titan protocol modules and test ports
# !skip the slash at the end
PATH_BASE=~/Titan

# do not change these paths. These are prescribed in the tpd Files!
PATH_CORE=${PATH_BASE}/Core
PATH_SOCKET_API=${PATH_BASE}/TestPorts/Common_Components/Socket_API_CNL113686/
PATH_IPL4=${PATH_BASE}/TestPorts/IPL4asp/
PATH_JSON=${PATH_BASE}/ProtocolModules/JSON_v07_2006/
PATH_COAP=${PATH_BASE}/ProtocolModules/CoAP/
PATH_MQTT=${PATH_BASE}/ProtocolModules/MQTT/
PATH_COMMON=${PATH_BASE}/ProtocolModules/COMMON/
PATH_TCC=${PATH_BASE}/Libraries/TCCUsefulFunctions_CNL113472/

# Git flags
GIT_QUIET=-q # remove this flag for complete Git output

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
if [ -d "$PATH_JSON" ]; then
  echo $PATH_JSON " already exists"

  # goto the directory 
  cd $PATH_JSON

  # make sure you have the latest codebase
  git remote update
  git checkout  $GIT_QUIET master
  git pull $GIT_QUIET
 
  # return back to the last known folder
  cd - > /dev/null
else
  git clone https://github.com/eclipse/titan.ProtocolModules.JSON_v07_2006.git $PATH_JSON
fi

if [ -d "$PATH_COAP" ]; then
  echo $PATH_COAP " already exists"

  # goto the directory 
  cd $PATH_COAP

  # make sure you have the latest codebase
  git remote update
  git checkout  $GIT_QUIET master
  git pull $GIT_QUIET
 
  # return back to the last known folder
  cd - > /dev/null
else
  git clone git://git.eclipse.org/gitroot/titan/titan.ProtocolModules.CoAP.git $PATH_COAP
fi

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
if [ -d "bin" ]; then
  # clean the bin folder
  rm ./bin/*
else
  mkdir bin
fi
cd bin

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
ln -s ../src/MQTT_Functions.ttcn
ln -s ../src/MQTT_Pixits.ttcn
ln -s ../src/MQTT_Templates.ttcn
ln -s ../src/MQTT_TestCases.ttcn
ln -s ../src/MQTT_TestControl.ttcn
ln -s ../src/MQTT_TestSystem.ttcn
ln -s ../src/MQTT_TypesAndValues.ttcn

# build the makefile
ttcn3_makefilegen -f -g -e MqttTestSuite *.ttcn *.hh *.cc
