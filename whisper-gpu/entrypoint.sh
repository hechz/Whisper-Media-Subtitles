#!/bin/bash

#Set processing defaults
OMP_NUM_THREADS=${OMP_NUM_THREADS:-16}
MKL_NUM_THREADS=${MKL_NUM_THREADS:-16}
MODEL=${MODEL:-base}
OUTPUT_FORMAT=${OUTPUT_FORMAT:-srt}
SOURCE_LANG=${SOURCE_LANG:-en}
TASK=${TASK:=transcribe}
FILE="${FILE}"
SMB=${SMB:-0}
SMB_USERNAME=${SMB_USER_NAME}
SMB_PASSWORD="${SMB_PASSWORD}"
SMB_SERVER="${SMB_SERVER}"
SMB_PATH="${SMB_PATH}"
WHISPER_OPTS="${WHISPER_OPTS}"
date

# Fail loudly instead of silently falling back to CPU (large on 2 cores is ~20x realtime)
if ! python3 -c "import torch,sys; sys.exit(0 if torch.cuda.is_available() else 1)"; then
    echo "ERROR: CUDA not visible inside container - refusing to run on CPU." >&2
    echo "       Check 'docker run --gpus', nvidia-container-toolkit, and host driver." >&2
    [ "${ALLOW_CPU:-0}" = "1" ] || exit 1
    echo "       ALLOW_CPU=1 set, continuing on CPU anyway." >&2
fi

if [ ${SMB} -eq 1 ]; then
	mkdir /app
    mount //${SMB_SERVER}/${SMB_PATH} /app -orw,domainauto,username="${SMB_USERNAME}",password="${SMB_PASSWORD}"
    [ -e "/app${FILE}" ] && echo "File: ${FILE} found in cifs://${SMB_SERVER}/${SMB_PATH}/${FILE}"
fi

echo "Starting: ${TASK} on file: /app${FILE}"
outPath=$(dirname "/app${FILE}")
fileTest=$(ls -l "/app${FILE}")
if [ -n "${fileTest}" ];then
    echo  -ne "whisper  \x22/app${FILE}\x22 --model ${MODEL} --language ${SOURCE_LANG} --output_format ${OUTPUT_FORMAT} --output_dir  \x22${outPath}\x22 --task ${TASK} --threads ${OMP_NUM_THREADS} ${WHISPER_OPTS}\n\n\n\n" 1>&2 
    whisper  "/app${FILE}" --model ${MODEL} --language ${SOURCE_LANG} --output_format ${OUTPUT_FORMAT} --output_dir  "${outPath}" --task ${TASK} --threads ${OMP_NUM_THREADS} ${WHISPER_OPTS}
    #Rename output file to contain language
    SRT_FILE_SOURCE="$(echo  ${FILE%%.*}.srt )"
    SRT_FILE_DEST="$(echo ${FILE%%.*}.$SOURCE_LANG.srt )"
    if [ -e "/app${SRT_FILE_SOURCE}" ]; then
        mv -vf "/app${SRT_FILE_SOURCE}" "/app${SRT_FILE_DEST}"
    fi
else
    echo "File: ${FILE} not found in /app"
    ls -l /app/ 1>&2
    mount 1>&2 
    sleep 300
    exit 1
fi
date