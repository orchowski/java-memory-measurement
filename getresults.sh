#!/bin/bash
appPid=`jcmd | grep com.orchowskia.memory.Test2|awk '{print $1; exit}'`

echo "PID: $appPid"


jcmd $appPid GC.heap_dump /tmp/dump.hprof

jhat /tmp/dump.hprof > some_file 2>&1 &

while [ -z `cat some_file | grep "Server is ready"` ]; do
   echo "waiting for jhat"
   sleep 2
done

rm some_file

curl http://localhost:7000/oql/?query=select+map%28heap.objects%28%27com.orchowskia.memory.Test1%27%29%2C+++%0D%0Afunction%28it%29%7B%0D%0A++function+contains%28a%2C+obj%29+%7B%0D%0A++++for+%28var+i+%3D+0%3B+i+%3C+a.length%3B+i%2B%2B%29+%7B%0D%0A++++++++if+%28a%5Bi%5D+%3D%3D%3D+obj%29+%7B%0D%0A++++++++++++return+true%3B%0D%0A++++++++%7D%0D%0A++++%7D%0D%0A++++return+false%3B%0D%0A%7D%0D%0A++var+visited+%3D+%5B%5D%3B%0D%0A++function+calc%28instance%29%7B%0D%0A+++++var+result+%3D+sizeof%28instance%29%3B%0D%0A+++++visited.push%28objectid%28instance%29%29%3B%0D%0A+++++referees%28instance%29.forEach%28function%28subinstance%29%7B%0D%0A+++++++if%28contains%28visited%2Cobjectid%28subinstance%29%29%29%7Breturn%3B%7D%0D%0A+++++++result+%3D+result+%2B+calc%28subinstance%29%3B%0D%0A+++++%7D%29%3B%0D%0A+++++return+result%3B%0D%0A++%7D%3B%0D%0A++return+it.toString%28%29+%2B%22+-%3E+%22%2B+calc%28it%29%2B%22B%22%3B%0D%0A%7D%29%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A > result.html

kill %1

firefox result.html
rm /tmp/dump.hprof
#OQL QUERY
#
#
#function(it){
#  function contains(a, obj) {
#    for (var i = 0; i < a.length; i++) {
#        if (a[i] === obj) {
#            return true;
#        }
#    }
#    return false;
#}
#  var visited = [];
#  function calc(instance){
#     var result = sizeof(instance);
#     visited.push(objectid(instance));
#     referees(instance).forEach(function(subinstance){
#       if(contains(visited,objectid(subinstance))){return;}
#       result = result + calc(subinstance);
#     });
#     return result;
#  };
#  return it.toString() +" -> "+ calc(it)+"B";
#})




