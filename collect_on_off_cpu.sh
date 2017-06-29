#!/bin/bash


if [[ $1 == "" ]];then
  echo "Usage:$0 pid stapname"
  echo "example:$0 3312 cpu_user/cpu_kernel/cpu_all"
  exit 1
fi

pid=$1
stapname=$2
execdir=`readlink /proc/$pid/exe`

stap -v -D MAXSKIPPED=100000 -D MAXBACKTRACE=200 -D MAXSTRINGLEN=2048 -D MAXACTION=10000000 -D MAXMAPENTRIES=300000 -g --suppress-time-limits  --skip-badvars --all-modules -x $pid -d $execdir  --ldd  $stapname.stp > out.stap

/home/helingyun/FlameGraph/stackcollapse-stap.pl out.stap > out.folded
/home/helingyun/FlameGraph/flamegraph.pl out.folded  > out.svg