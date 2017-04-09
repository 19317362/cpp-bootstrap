TESTS=(
    isEnvProper_shouldTellIfNotProper
    isEnvProper_shouldTellIfProper
    downloadModule_shouldNotDownloadIfHasntUrl
    downloadModule_shouldDownloadIfHasUrl
    installModule_shouldCallProperCommandForExistingModule
    installModule_shouldNotCallCommandForNotExistingModule
    downloadModules_shouldDownloadAllModules
    main_shouldPrepareEnvironment
)

function isEnvProper_shouldTellIfNotProper() {
    function which() { 
        echo ""
    }

    isEnvProper
    expectFalse $?
}

function isEnvProper_shouldTellIfProper() {
    function which() {
        echo "/path/to/dependency"
    }

    isEnvProper
    expectTrue $?
}

function downloadModule_shouldNotDownloadIfHasntUrl() {
    function wget() {
        echo "Mocked wget call without url parameter"
        return 1
    }

    downloadModule "noUrlModule"
    expectFalse $?
}

function downloadModule_shouldDownloadIfHasUrl() {
    function wget() {
        echo "Mocked wget call for $1"
    }
    
    downloadModule "gtest"
    expectTrue $?
}

function installModule_shouldCallProperCommandForExistingModule() {
    function installGtest {
        echo "Install gtest mocked call"
    }

    installModule "gtest"
    expectTrue $?
}

function installModule_shouldNotCallCommandForNotExistingModule() {
    installModule "notExistingModule"
    expectFalse $?
}

function downloadModules_shouldDownloadAllModules() {
    declare -i count=1
    function wget() {
        echo "Mocked wget call for $1"
        mkdir -p $3
        touch $3/${count}.tar.gz
    }
    
    downloadModules
    declare -i howMany=`ls -l .download/ | wc -l`-1
    
    [ ${howMany} == 2 ]
    expectTrue $?
}

function main_shouldPrepareEnvironment() {
    function installBoost() { 
        echo "Mocked installBoost" 
    }
    function wget() { 
        echo "mocked wget for $1" 
    }
    function installGtest() { 
        echo "mocked installGtest" 
    }
    
    main
    expectTrue $?
}

