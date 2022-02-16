#!/bin/bash

if [ $# -ne 2 ]
then
        echo "deployTranslatorWorkerUnit.sh called with incorrect number of arguments."
        echo "deployTranslatorWorkerUnit.sh <UnitPath> <DeployDir>"
        echo "For example; deployTranslatorWorkerUnit.sh /plm/pnnas/ppic/users/<unit_name> /plm/pnnas/ppic/users/<deploy_dir>"
        exit 1
fi

UNIT_PATH=$1
DEPLOY_BASE_DIR=$2
DEPLOY_DIR=${DEPLOY_BASE_DIR}/TranslatorBinaries/

SOURCE_PATH=${UNIT_PATH}/lnx64/Products/TranslatorWorker
RUN_FILE=${SOURCE_PATH}/pvtrans/run_ugtopv
CONFIG_FILE=${SOURCE_PATH}/pvtrans/tessUG.config

# Copy all 
cp -r ${SOURCE_PATH}/   ${DEPLOY_DIR}/

# Then remove selected iteams
rm -rf ${DEPLOY_DIR}/debug
rm -rf ${DEPLOY_DIR}/license
rm -rf ${DEPLOY_DIR}/dockerfile

cp  ${RUN_FILE}            ${DEPLOY_DIR}/
cp  ${CONFIG_FILE}         ${DEPLOY_BASE_DIR}/

DEPLOYED_CONFIG_FILE=${DEPLOY_BASE_DIR}/tessUG.config
chmod 0755 ${DEPLOYED_CONFIG_FILE}

sed -i 's/UGII_PV_TRANS_MODEL_ANN=1//g' ${DEPLOY_DIR}/run_ugtopv
sed -i 's/export UGII_PV_TRANS_MODEL_ANN//g' ${DEPLOY_DIR}/run_ugtopv
sed -i 's/exec ${APPNAME} "${@}"/exec ${APPNAME} "${@}" -enable_hybrid_saas -single_part/g' ${DEPLOY_DIR}/run_ugtopv

sed -i 's/structureOption =.*/structureOption = "MIMIC"/g' ${DEPLOYED_CONFIG_FILE}
sed -i 's/pmiOption =.*/pmiOption = "THIS_LEVEL_ONLY"/g' ${DEPLOYED_CONFIG_FILE}
sed -i 's/includeBrep =.*/includeBrep = false/g' ${DEPLOYED_CONFIG_FILE}
sed -i 's/autoNameSanitize =.*/autoNameSanitize = false/g' ${DEPLOYED_CONFIG_FILE}
sed -i 's/autoLowLODgeneration =.*/autoLowLODgeneration = false/g' ${DEPLOYED_CONFIG_FILE}
sed -i 's/numLODs =.*/numLODs = 1/g' ${DEPLOYED_CONFIG_FILE}
sed -i 's/AdvCompressionLevel =.*/AdvCompressionLevel = 0.01/g' ${DEPLOYED_CONFIG_FILE}

sed -i 's/numLODs =.*/numLODs = 1/g' ${DEPLOYED_CONFIG_FILE}
sed -i 's/getNXBodyNames =.*/getNXBodyNames = true/g' ${DEPLOYED_CONFIG_FILE}
sed -i 's/getCADProperties =.*/getCADProperties = "NONE"/g' ${DEPLOYED_CONFIG_FILE}

sed -i '/LOD "2" /{:b;$!N;/}$/!bb;s/{.*}//}'  ${DEPLOYED_CONFIG_FILE}
sed -i '/LOD "3" /{:b;$!N;/}$/!bb;s/{.*}//}'  ${DEPLOYED_CONFIG_FILE}

sed -i 's/LOD "2".*//g' ${DEPLOYED_CONFIG_FILE}
sed -i 's/LOD "3".*//g' ${DEPLOYED_CONFIG_FILE}

