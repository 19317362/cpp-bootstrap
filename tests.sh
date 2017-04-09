#!/bin/bash

function printGreen() {
    printf "\033[0;32m $1 \033[0m\n"
}

function printRed() {
    printf "\033[0;31m $1 \033[0m\n"
}

function prepareTestEnv() {
    echo PROJ_NAME=test_proj > .config
    echo CPP_STD=14 > .config
}

function cleanTestEnv() {
    rm .config
    rm -rf .download/ modules/ src/ include/ build/ tests/ 
    rm -f CMakeLists.txt Makefile
}

function setupPipe() {
    TEST_PIPE=/tmp/test_pipe

    trap "rm -f $TEST_PIPE" EXIT

    if [[ ! -p $TEST_PIPE ]]; then
        mkfifo $TEST_PIPE
    fi
}

function expectTrue() {
    if [ $1 == 0 ]; then
        echo pass >$TEST_PIPE
    else
        echo fail >$TEST_PIPE
    fi
}

function expectFalse() {
    if [ $1 != 0 ]; then
        echo pass >$TEST_PIPE
    else
        echo fail >$TEST_PIPE
    fi
}

function executeTestCases() {
    declare -i failures=0
    declare -i passed=0
    TEST_LOG=tests.log
    echo "Test execution started at $(date -Iseconds)" > ${TEST_LOG}

    for test_case in ${TESTS[@]}; do
        printf "Executing [${test_case}]" | tee -a ${TEST_LOG}
        ${test_case} &>> tests.log &
        
        read result <$TEST_PIPE
        if [ ${result} != "pass" ]; then
            failures+=1
            printRed "Failed" | tee -a ${TEST_LOG}
        else
            passed+=1
            printGreen "Passed" | tee -a ${TEST_LOG}
        fi
    done

      
    printf "\nTests result:"
    
    [[ ${failures} -gt 0 ]] && printRed "Tests failed!" || printGreen "Tests passed!"
    echo "Failed: ${failures}"
    echo "Passed: ${passed}"
}

setupPipe
prepareTestEnv
source ./cpp-bootstrap
source ./testcases.sh

executeTestCases
cleanTestEnv
