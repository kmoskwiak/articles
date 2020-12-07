#!/bin/bash

echo "Executing for $1"
TEST=$1

function getStats {
    STATS=$(docker stats --format "{{.Name}};{{.MemUsage}}" --no-stream $1)
    echo $STATS
    if [ -n "$STATS" ];
        then
            getStats $1
        else
            echo Finished
    fi
}

CHUNK_1=5000000
CHUNK_2=10000000
CHUNK_3=15000000
CHUNK_4=20000000
CHUNK_5=25000000
CHUNK_6=30000000

WAIT_1=600
WAIT_2=1400
WAIT_3=1800
WAIT_4=2200
WAIT_5=3000
WAIT_6=4000

if [[ "build" == "$TEST" ]]; then
    echo Build image
    docker build ./app/ -t file-iteration/test
fi

if [[ "cRS" == "$TEST" ]]; then
    echo cRS

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_1 -e WAIT=$WAIT_1 file-iteration/test cRS.js)
    getStats $ID >> crs.$CHUNK_1.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_2 -e WAIT=$WAIT_2 file-iteration/test cRS.js)
    getStats $ID >> crs.$CHUNK_2.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_3 -e WAIT=$WAIT_3 file-iteration/test cRS.js)
    getStats $ID >> crs.$CHUNK_3.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_4 -e WAIT=$WAIT_4 file-iteration/test cRS.js)
    getStats $ID >> crs.$CHUNK_4.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_5 -e WAIT=$WAIT_5 file-iteration/test cRS.js)
    getStats $ID >> crs.$CHUNK_5.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_6 -e WAIT=$WAIT_6 file-iteration/test cRS.js)
    getStats $ID >> crs.$CHUNK_6.report
fi

if [[ "cRS_generator" == "$TEST" ]]; then
    echo cRS_generator

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_1 -e WAIT=$WAIT_1 file-iteration/test cRS_generator.js)
    getStats $ID >> cRS_generator.$CHUNK_1.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_2 -e WAIT=$WAIT_2 file-iteration/test cRS_generator.js)
    getStats $ID >> cRS_generator.$CHUNK_2.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_3 -e WAIT=$WAIT_3 file-iteration/test cRS_generator.js)
    getStats $ID >> cRS_generator.$CHUNK_3.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_4 -e WAIT=$WAIT_4 file-iteration/test cRS_generator.js)
    getStats $ID >> cRS_generator.$CHUNK_4.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_5 -e WAIT=$WAIT_5 file-iteration/test cRS_generator.js)
    getStats $ID >> cRS_generator.$CHUNK_5.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_6 -e WAIT=$WAIT_6 file-iteration/test cRS_generator.js)
    getStats $ID >> cRS_generator.$CHUNK_6.report

fi

if [[ "read" == "$TEST" ]]; then
    echo "read"

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_1 -e WAIT=$WAIT_1 file-iteration/test read.js)
    getStats $ID >> read.$CHUNK_1.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_2 -e WAIT=$WAIT_2 file-iteration/test read.js)
    getStats $ID >> read.$CHUNK_2.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_3 -e WAIT=$WAIT_3 file-iteration/test read.js)
    getStats $ID >> read.$CHUNK_3.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_4 -e WAIT=$WAIT_4 file-iteration/test read.js)
    getStats $ID >> read.$CHUNK_4.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_5 -e WAIT=$WAIT_5 file-iteration/test read.js)
    getStats $ID >> read.$CHUNK_5.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_6 -e WAIT=$WAIT_6 file-iteration/test read.js)
    getStats $ID >> read.$CHUNK_6.report
fi

if [[ "read-no-shared" == "$TEST" ]]; then
    echo "read-no-shared"

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_2 -e WAIT=$WAIT_2 file-iteration/test read-no-shared.js)
    getStats $ID >> read-no-shared.$CHUNK_2.report

fi


if [[ "readFile" == "$TEST" ]]; then
    echo "readFile"

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_1 -e WAIT=$WAIT_1 file-iteration/test readFile.js)
    getStats $ID >> readFile.$CHUNK_1.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_2 -e WAIT=$WAIT_2 file-iteration/test readFile.js)
    getStats $ID >> readFile.$CHUNK_2.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_3 -e WAIT=$WAIT_3 file-iteration/test readFile.js)
    getStats $ID >> readFile.$CHUNK_3.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_4 -e WAIT=$WAIT_4 file-iteration/test readFile.js)
    getStats $ID >> readFile.$CHUNK_4.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_5 -e WAIT=$WAIT_5 file-iteration/test readFile.js)
    getStats $ID >> readFile.$CHUNK_5.report

    ID=$(docker run -d --rm -e CHUNK_SIZE=$CHUNK_6 -e WAIT=$WAIT_6 file-iteration/test readFile.js)
    getStats $ID >> readFile.$CHUNK_6.report

fi