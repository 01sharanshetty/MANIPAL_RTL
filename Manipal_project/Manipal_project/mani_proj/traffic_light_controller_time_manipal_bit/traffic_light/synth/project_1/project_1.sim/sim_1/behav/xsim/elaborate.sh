#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Mon Jul 15 18:53:41 IST 2024
# SW Build 3064766 on Wed Nov 18 09:12:47 MST 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto 0fb839f8a18f4b09bb773d4e4cb5bb0e --incr --debug typical --relax --mt 8 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_traffic_light_cntrl_behav xil_defaultlib.tb_traffic_light_cntrl xil_defaultlib.glbl -log elaborate.log"
xelab -wto 0fb839f8a18f4b09bb773d4e4cb5bb0e --incr --debug typical --relax --mt 8 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_traffic_light_cntrl_behav xil_defaultlib.tb_traffic_light_cntrl xil_defaultlib.glbl -log elaborate.log

