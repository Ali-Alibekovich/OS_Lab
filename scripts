#---------------------------------------------------------------------------------start---------------------------------------------------------------------------------------
RED='\e[31m'
GREEN='\e[32m'
BLUE='\e[34m'
NC='\e[0m'

PID="$(ps -a | grep $1 | grep -Eo "[0-9]*" | head -1)"

#----------------------------------------------------------------------------------first--------------------------------------------------------------------------------------
# 1 Number of Threads and Threads

function first(){
  clear
  top -H -p $PID;
  clear
}

#---------------------------------------------------------------------------------second--------------------------------------------------------------------------------------
# 2 Monitoring procces and his childds

function second(){
echo -e "$RED Enter interval: $NC"
read INTERVAL

if [[ $INTERVAL -lt 0 ]]
then
   INTERVAL="2"
fi

pstree -a -p $PID | cut -d',' -f2 > all_proc

VAR_ALL_PIDS=""

while read p; do
  VAR_ALL_PIDS+="/proc/${p}/fd ";
done < all_proc

while : 
do 
  clear;
  echo -e "$RED INTERVAL : $INTERVAL $NC"
  ls -gG $VAR_ALL_PIDS > info;
  column info -s -t5;
  sleep $INTERVAL;
  clear;
done
}

#----------------------------------------------------------------------------------third--------------------------------------------------------------------------------------
# 3 Map of mem
function third(){
    clear
    sudo pmap -x $PID
}


#------------------------------------------------------------------------------------four-------------------------------------------------------------------------------------
# 4 Data of ethernet
function four(){
    clear
    PORTS="$(sudo netstat -pa | grep "$PID" | grep -Eo ":[0-9]+" | grep -Eo "[0-9]+" | sed -z 's/\n/ or /g;s/ or $/\n/' )"
    while [[ -z "$PORTS" ]]
    do
       PORTS="$(sudo netstat -pa | grep "$PID" | grep -Eo ":[0-9]+" | grep -Eo "[0-9]+" | sed -z 's/\n/ or /g;s/ or $/\n/')"
    done
    echo -e "$RED PORTS: $PORTS $NC"
    sudo tcpdump -A -i "any" port $PORTS
}

#-----------------------------------------------------------------------------Flame Graph-------------------------------------------------------------------------------------
# flameGraph
function flameGraph() {
   clear
   rm -rf ./graphicFlames
   echo -e "$RED Enter seconds of waiting $NC"
   read SECONDS
   echo -e "$GREEN Wait $SECONDS seconds $NC"
   mkdir -p graphicFlames
   cd graphicFlames
   sudo perf record -F 99 -p $PID -g -- sleep $SECONDS
   sudo perf script > ./result
   cd ..
   FlameGraph/stackcollapse-perf.pl ./graphicFlames/result | FlameGraph/flamegraph.pl > ./graphicFlames/result.svg
   xdg-open ./graphicFlames/result.svg
}


#-----------------------------------------------------------------------------start programm----------------------------------------------------------------------------------
# start programm

if [[ -z $PID ]]
then
  echo -e "$RED PID is not exists $NC"
  exit 1
fi

echo -e "$BLUE Welcome to programm monitoring $NC"
echo -e "$GREEN 1.Number of threads $NC"
echo -e "$GREEN 2.List of files and network connections $NC"
echo -e "$GREEN 3.Map of memory $NC"
echo -e "$GREEN 4.Data of ethernet $NC"
echo -e "$GREEN 5.FlameGraph $NC"
echo -e "$RED Enter number: $NC"

read NUMBER

case $NUMBER in

  1) first ;;

  2) second ;;
  
  3) third ;;
  
  4) four ;;
  
  5) flameGraph ;;
  
  *) echo -e "$RED Wrong number $NC" ;;

esac

#----------------------------------------------------------------------------end programm-------------------------------------------------------------------------------------




