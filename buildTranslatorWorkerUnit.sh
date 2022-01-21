#!/bin/bash

if [ $# -ne 1 ] 
then
	echo "buildUnit.sh called with incorrect number of arguments."
	echo "buildUnit.sh <UnitPath>"
	echo "For example; buildUnit.sh /plm/pnnas/ppic/users/<unit_name>"
	exit 1
fi

UNIT_PATH=$1
/usr/site/devop_tools/bin/unit run ${UNIT_PATH} b product TranslatorWorker
