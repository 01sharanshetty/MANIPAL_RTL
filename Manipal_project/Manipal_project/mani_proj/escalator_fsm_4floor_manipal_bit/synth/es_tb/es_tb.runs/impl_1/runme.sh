#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/tools1/Xilinx/Vitis/2020.2/bin:/tools1/Xilinx/Vivado/2020.2/ids_lite/ISE/bin/lin64:/tools1/Xilinx/Vivado/2020.2/bin
else
  PATH=/tools1/Xilinx/Vitis/2020.2/bin:/tools1/Xilinx/Vivado/2020.2/ids_lite/ISE/bin/lin64:/tools1/Xilinx/Vivado/2020.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/pradeepjairam/ramanujamIP/other_rnd/fpga_demo_escalator/traffic_escalator_bit/escalator_fsm_4floor_bit/synth/es_tb/es_tb.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log elevator.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source elevator.tcl -notrace

