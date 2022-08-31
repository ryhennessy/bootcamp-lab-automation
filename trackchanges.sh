#!/bin/bash
cp breakingpoint-$((${1}-1)).tar breakingpoint-${1}.tar
cd /opt/cribl
git status | grep "/" | grep  "^\s" > /tmp/output
sed -i 's/\s//g' /tmp/output
sed -i 's/modified://g' /tmp/output
for c in `cat /tmp/output`
do
   tar rf /home/cribl/breakingpoint-${1}.tar $c
done
