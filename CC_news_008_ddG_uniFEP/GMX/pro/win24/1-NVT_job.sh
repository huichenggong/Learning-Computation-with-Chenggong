#!/bin/bash
base=$PWD
top=../../../topol.top
for i in {0..24};
do
    cd Lambda_$i/NVT
    g_submit -s nvt_$i.tpr -deffnm nvt_$i -nomail -days 0.05
    cd $base

done
