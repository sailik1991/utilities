#!/bin/bash

SOURCE=
DESTINATION=

# This function is called if there is any error in running the command or you asked for help
showUse() {
    echo "Usage: $0 -s file-name-with-path -d destination"
    echo "eg. $0 -s /home/username/Downloads/gurobi6.0.5_linux64.tar.gz -d /opt/"
    exit 2
}

while getopts s:d:h option
do
    case $option in 
    s)  SOURCE="$OPTARG";;
    d)  DESTINATION="$OPTARG"
        shift;;
    h)  showUse;; 
    ?)  showUse;;
    esac
done

if [ -z "$SOURCE" ]; then
    echo "Source not specified!"
    showUse
fi

if [ -z "$DESTINATION" ]; then
    echo "Destination not specified. Using '/opt/'"
    DESTINATION="/opt"
fi

# Append a '/' to destination just in case the user didn't have a / at the end
DESTINATION="$DESTINATION/"

ZIP_FILE=`basename $SOURCE`

# Use sudo since user may need permissions to run in the destination directory
sudo cp $SOURCE $DESTINATION
echo "Extracting $ZIP_FILE at $DESTINATION"
cd $DESTINATION
sudo tar xvfz $ZIP_FILE

fileName=`ls | grep gurobi | grep -v tar`

# Writes path to .bashrc for the run-user
echo "export GUROBI_HOME=$DESTINATION$fileName/linux64" >> ~/.bashrc 
echo "export PATH=${PATH}:${GUROBI_HOME}/bin" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib" >> ~/.bashrc

echo -----------------------------------------------------------------------
echo "DO NOT FORGET TO RUN : source ~/.bashrc BEFORE RUNNING gurobi COMMANDS"
echo "INSTALLATION COMPLETE!"
echo -----------------------------------------------------------------------
