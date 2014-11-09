#!/usr/bin/bash
#set -x
:<<COMMENT

The following scripts need to be in /root/bin

dtrace-running-SQL.sh - this script
total.pl              - total each distict query

COMMENT
sleepTime=$((60 * 5))  # 5 minutes
game_name=slots3
mysql_home=mysql_01
dbroots=/opt/ghc/dbroots
myPid=`cat ${dbroots}/${mysql_home}/data/mysql.pid`

dtrace=/usr/sbin/dtrace
sleep=/usr/bin/sleep
kill=/usr/xpg4/bin/kill
cat=/usr/bin/cat
tr=/usr/xpg4/bin/tr
perl=/opt/local/bin/perl
sort=/usr/xpg4/bin/sort

TMP_DIR=/var/tmp
REPORT_DIR=${dbroots}/${mysql_home}/reports/running-SQL
DATE=`date +%Y-%m-%d_%H%M`

cd /root/bin


$dtrace \
        -qn 'pid$target:mysqld:*mysql_parse*:entry { @queries[copyinstr(arg1)] = count() }' \
        -p $myPid \
         > ${TMP_DIR}/topQueries.${DATE}.txt &
child=$!
$sleep $sleepTime
$kill $child
$sleep 1

$cat ${TMP_DIR}/topQueries.${DATE}.txt \
  |$tr -s ' ' ' ' \
  |$perl -0 -pe 's|(.*?)\s(\d+)\n|$2\t$1\n|gs' \
  |$perl -0 -pe 's|\n | |g' \
  |$sort -nr \
  > ${TMP_DIR}/queryCount.${DATE}.txt

/root/bin/total.pl \
  ${TMP_DIR}/queryCount.${DATE}.txt \
  |$sort -rn \
  > ${REPORT_DIR}/${game_name}.used.tables.${DATE}.dat
