#!/bin/sh

URL="http://localhost:1313"
echo "1"
cd "${INPUT_WORKING_DIRECTORY}"
eval hugo server "${INPUT_HUGO_OPTIONS}" > /dev/null &
echo "2"
for i in $(seq 0 30); do
    sleep 1
    IS_SERVER_UP=$(curl -IL ${URL} -o /dev/null -w '%{http_code}' -s)
    if [[ "${IS_SERVER_UP}" == "200" ]]; then
        eval muffet "${INPUT_MUFFET_OPTIONS}" ${URL} && exit 0 || exit 1
    fi
done

echo "error: ${URL} did not come up after ${INPUT_TIMEOUT_SECONDS} seconds."
exit 1