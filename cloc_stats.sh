#!/bin/sh
cloc ./ . --exclude-dir=envs --json > cloc.json

graphiteHost=ec2-35-90-12-71.us-west-2.compute.amazonaws.com
graphitePort=8125
repoName=pypiglet

nFiles=`cat cloc.json | jq -r ".Python.nFiles"`
blank=`cat cloc.json | jq -r ".Python.blank"`
comment=`cat cloc.json | jq -r ".Python.comment"`
code=`cat cloc.json | jq -r ".Python.code"`

echo "${repoName}python.code:${code}|g" | nc -w 1 -u ${graphiteHost} ${graphitePort}
echo "${repoName}python.comment:${comment}|g" | nc -w 1 -u ${graphiteHost} ${graphitePort}
echo "${repoName}python.blank:${blank}|g" | nc -w 1 -u ${graphiteHost} ${graphitePort}
echo "${repoName}python.files:${nFiles}|g" | nc -w 1 -u ${graphiteHost} ${graphitePort}
