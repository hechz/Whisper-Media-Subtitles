#!/bin/bash

#Set processing defaults
MODEL=${MODEL:-base}
OUTPUT_FORMAT=${OUTPUT_FORMAT:-srt}
SOURCE_LANG=${SOURCE_LANG:-en}
TASK=${TASK:=transcribe}
FILE="${FILE}"
WHIPSER_OPTS=${WHISPER_OPTS}

echo "Starting: ${TASK} on file: ${FILE}"
fileTest=$(ls -l "/app/${FILE}")
if [ -n "${fileTest}" ];then
    echo whisper  "/app/${FILE}" --model ${MODEL} --language ${SOURCE_LANG} --output_format ${OUTPUT_FORMAT} --task ${TASK}  --fp16 False --threads ${OMP_NUM_THREADS} ${WHISPER_OPTS}
    whisper  "/app/${FILE}" --model ${MODEL} --language ${SOURCE_LANG} --output_format ${OUTPUT_FORMAT} --task ${TASK}  --fp16 False --threads ${OMP_NUM_THREADS} ${WHISPER_OPTS}
    if [ -e "/app/${outFile}"];then 
        outFile=$(echo "${FILE}" | sed -r 's/(\.\w+)$/\.srt/g')
        outPath=$(dirname "${FILE}")
        mv -vf "/app/${outfile}" "${outPath}"
    fi
    sleep 180
else
    echo "File: ${FILE} not found in /app/"
    ls -l /app/ 1>&2
    mount 1>&2 
    sleep 300
    return 1
fi