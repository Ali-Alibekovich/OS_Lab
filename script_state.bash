#---------------------------------------------------------------------------------start---------------------------------------------------------------------------------------


PID="$(ps -a | grep $1 | grep -Eo "[0-9]*" | head -1)"


pstree -a -p $PID | cut -d',' -f2 > all_proc

VAR_ALL_PIDS=""

> all_states

while read p; do
  echo -n $p" , " >> all_states  
done < all_proc


for ((i=1; i<=60; i++))
do
  echo "-------------------$i iteration-----------------------" >> all_states
  while read p; do
    VAR_STATE="$(cat /proc/$PID/task/$p/status | grep "State:" | grep -Eo "[A-Z]\s")";
    echo -n $VAR_STATE"  " >> all_states  
  done < all_proc
  sleep 1
done

#-----------------------------------------------------------------------------------end------------------------------------------------------------------------------------------

