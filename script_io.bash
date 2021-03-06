#---------------------------------------------------------------------------------start---------------------------------------------------------------------------------------


PID="$(ps -a | grep $1 | grep -Eo "[0-9]*" | head -1)"


> all_io_stats


while read p; do
  VAR_STATE="$(sudo iotop -b -p $p -n 20| grep -Eo "%\s+[0-9]+\.[0-9]+" | grep -Eo "[0-9]+\.[0-9]+")";
  echo "$p : ["$VAR_STATE"]" >> all_io_stats
done < all_proc
#-----------------------------------------------------------------------------------end------------------------------------------------------------------------------------------

