#!/usr/bin/env bash

TEST_CASE_FILE=tests
TEST_VARIABLES_FILE=test-variables.yaml
# -------- Global Variables --------
TEST_VARIABLES=""
TEST_ARTIFACT_DIR="test-output"
EXTRA_ROBOT_ARGS=""
TEST_INCLUDE_TAG=""
TEST_EXCLUDE_TAG=""
SKIP_PIP_INSTALL=0

<<comment
:'
Command Line Parsing as implemented by ODS-ci
while [ "$#" -gt 0 ]; do
  case $1 in
    # Override/Add global variables specified in the test variables file
    --test-variable)
      shift
      TEST_VARIABLES="${TEST_VARIABLES} --variable $1"
      shift
      ;;

    # Specify the test variable file
    --test-variables-file)
      shift
      TEST_VARIABLES_FILE=$1
      shift
      ;;

    # Specify test case to run
    --test-case)
      shift
      TEST_CASE_FILE=$1
      shift
      ;;

    # Specify directory to store artifacts and reports from each test run
    --test-artifact-dir)
      shift
      TEST_ARTIFACT_DIR=$1
      shift
      ;;

    # Specify included tags
    # Example: sanityANDinstall sanityORinstall installNOTsanity
    --include)
      shift
      TEST_INCLUDE_TAG="${TEST_INCLUDE_TAG} --include $1"
      shift
      ;;
    # Specify excluded tags
    --exclude)
      shift
      TEST_EXCLUDE_TAG="${TEST_EXCLUDE_TAG} --exclude $1"
      shift
      ;;
    # Additional arguments to pass to the robot cli
    --extra-robot-args)
      shift
      EXTRA_ROBOT_ARGS=$1
      shift
      ;;

    # Skip the pip install during the execution of this script
    --skip-pip-install)
      shift
      SKIP_PIP_INSTALL=1
      ;;

    *)
      echo "Unknown command line switch: $1"
      exit 1
      ;;
  esac
done
'
comment

# -------- functions -------------

handle_inputs() {
    SPECIFIED_INPUTS=$@
    OPTSTR="d:e:f:hi:r:st:v:"
    while getopts $OPTSTR flag; do
        case "$flag" in
            d) # Specify directory to store artifacts and reports from each test run
                TEST_ARTIFACT_DIR=$OPTARG
                create_artifact_dir
            ;;
            e) # Specify excluded tags
                TEST_EXCLUDE_TAG=$OPTARG
            ;;
            f) # Specify the test variable file
                TEST_VARIABLES_FILE=$OPTARG
            ;;
            h) # Display Usage and exit
                disp_usage $OPTSTR
                exit 0
            ;;
            i) # Specify included tags
               # Example: sanityANDinstall sanityORinstall installNOTsanity
                TEST_INCLUDE_TAG=$OPTARG
            ;;
            r) # Additional arguments to pass to the robot cli
                EXTRA_ROBOT_ARGS=$OPTARG
            ;;
            s) # Skip the pip install during the execution of this script
                SKIP_PIP_INSTALL=1
            ;;
            t) # Specify test case to run
                TEST_CASE_FILE=$TEST_CASE_LOCATION/$OPTARG
            ;;
            v) # Override/Add global variables specified in the test variables file
                TEST_VARIABLES="${TEST_VARIABLES} --variable $OPTARG"
            ;;
            *)
                echo "Invalid Input"
                disp_usage $OPTSTR
                exit 1
            ;;
        esac
    done

    shift $((OPTIND -1))

    # ------ Validate Inputs --------
    if [[ ! -f "${TEST_VARIABLES_FILE}" ]]; then
        echo "---- Robot Framework test variable file (test-variables.yml) is missing"
        exit 1
    fi
}


disp_usage() {
    echo
    echo "Usage:    $0 [$1]"
    echo "Possible inputs: -d -e -f [-h] -i -r [-s] -t -v"
    echo "Specified Inputs: $SPECIFIED_INPUTS"
    echo "Explanation of inputs "
    echo "      -d <TEST_ARTIFACT_DIR>: Specify directory to store artifacts and reports from each test run"
    echo "      -e <TEST_EXCLUDE_TAG>: Specify excluded tags for Robot"
    echo "      -f <TEST_VARIABLES_FILE>: Specify the test variable file"
    echo "      -h: Display Usage and exit"
    echo "      -i <TEST_INCLUDE_TAG>: Specify included tags for Robot"
    echo "      -r <EXTRA_ROBOT_ARGS>: Additional arguments to pass to the robot cli"
    echo "      -s: Skip the installation of required Python Libraries during the execution of this script"
    echo "      -t <TEST_CASE_FILE>: Specify test case to run, should be present under Tests directory"
    echo "      -v <>: Override/Add global variables specified in the test variables file"
}


pip_install() {
    # This is optional so we are not creating/updating the virtualenv everytime we run a test
    echo "--------- Installing required Python Libraries ----------"
    VENV_ROOT=${PWD}/venv
    # setup virtualenv
    python3 -m venv ${VENV_ROOT}
    source ${VENV_ROOT}/bin/activate

    ${VENV_ROOT}/bin/pip install --upgrade pip
    ${VENV_ROOT}/bin/pip install -r requirements.txt
}


create_artifact_dir() {
    # Create a unique directory to store the output for current test run
    if [[ ! -d "${TEST_ARTIFACT_DIR}" ]]; then
      mkdir ${TEST_ARTIFACT_DIR}
    fi
    case "$(uname -s)" in
        Darwin)
            TEST_ARTIFACT_DIR=$(mktemp -d  ${TEST_ARTIFACT_DIR} -t ${TEST_ARTIFACT_DIR}/rhoda-ci-$(date +%Y-%m-%d-%H-%M)-XXXXXXXXXX)
             ;;
        Linux)
            TEST_ARTIFACT_DIR=$(mktemp -d -p ${TEST_ARTIFACT_DIR} -t rhoda-ci-$(date +%Y-%m-%d-%H-%M)-XXXXXXXXXX)
            ;;
    esac
}

if [[ ! -f "${TEST_VARIABLES_FILE}" ]]; then
  echo "Robot Framework test variable file (test-variables.yaml) is missing"
  exit 1
fi

case "$(uname -s)" in
    Darwin)
         echo "MACOS"
         echo "setting driver to $PWD/drivers/MACOS"
         export PATH=$PATH:$PWD/drivers/MACOS
         echo "$PATH"
         ;;
    Linux)
       case "$(lsb_release --id --short)" in
       "Fedora"|"CentOS")
             ## Bootstrap script to setup drivers ##
             echo "setting driver to $PWD/drivers/fedora"
             export PATH=$PATH:$PWD/drivers/fedora
             echo "$PATH"
        ;;
        "Ubuntu")
             echo "Not yet supported, but shouldn't be hard for you to fix :) "
             echo "Please add the driver, test and submit PR"
             exit 1
        ;;
        "openSUSE project"|"SUSE LINUX"|"openSUSE")
             echo "Not yet supported, but shouldn't be hard for you to fix :) "
             echo "Please add the driver, test and submit PR"
             exit 1
        ;;
        esac
        ;;
    * )
          echo "Not yet supported OS, but shouldn't be hard for you to fix :) "
          echo "Please add the driver, test and submit PR"
          exit 1
        ;;
esac

#TODO: Make this optional so we are not creating/updating the virtualenv everytime we run a test
VENV_ROOT=${currentpath}/venv
#setup virtualenv
python3 -m venv ${VENV_ROOT}
source ${VENV_ROOT}/bin/activate

if [[ ${SKIP_PIP_INSTALL} -eq 0 ]]; then
  ${VENV_ROOT}/bin/pip install --upgrade pip
  ${VENV_ROOT}/bin/pip install -r requirements.txt
fi

#Create a unique directory to store the output for current test run
if [[ ! -d "${TEST_ARTIFACT_DIR}" ]]; then
  mkdir ${TEST_ARTIFACT_DIR}
fi
case "$(uname -s)" in
    Darwin)
        TEST_ARTIFACT_DIR=$(mktemp -d  ${TEST_ARTIFACT_DIR} -t ${TEST_ARTIFACT_DIR}/rhoda-ci-$(date +%Y-%m-%d-%H-%M)-XXXXXXXXXX)
         ;;
    Linux)
        TEST_ARTIFACT_DIR=$(mktemp -d -p ${TEST_ARTIFACT_DIR} -t rhoda-ci-$(date +%Y-%m-%d-%H-%M)-XXXXXXXXXX)
        ;;
esac

./venv/bin/robot ${TEST_EXCLUDE_TAG} ${TEST_INCLUDE_TAG} -d ${TEST_ARTIFACT_DIR} -x xunit_test_result.xml -r test_report.html ${TEST_VARIABLES} --variablefile ${TEST_VARIABLES_FILE} --exclude TBC ${EXTRA_ROBOT_ARGS} ${TEST_CASE_FILE}

echo "------------- END ${0}"
