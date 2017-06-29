#!/bin/bash


script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $1 == "" ]] || [[ $2 == "" ]] || [[ $3 == "" ]];then
  echo "Usage: $0 type  pid  time"
  echo "type:(on-cpu or off-cpu)"
  echo "$0 on-cpu 3312 5"
  exit 1
fi

pid=$2

if [[ $1 == "off-cpu" ]];then
  ./$1 -u -t $3 -p $pid -a '-DMAXACTION=100000' -a '-DMAXMAPENTRIES=100000' > out.stap
else
  ./$1 -u -t $3 -p $pid  -a '-DMAXACTION=100000' -a '-DMAXMAPENTRIES=100000'  > out.stap
fi


/home/helingyun/FlameGraph/stackcollapse-stap.pl out.stap > out.folded
/home/helingyun/FlameGraph/flamegraph.pl out.folded  > out.svg

