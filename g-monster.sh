#!/bin/sh

UA="User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36"
MAIL=
PASSWORD=
BASE=
LESSON=
STUDIO=
NG_BAG=
FAVORITE_BAGS=

TMP_FILE=$$

export TOKEN=""
export BAG=""
export ONE_TIME_TOKEN=""
export RESERVED=""

login () {
	DATA="mail_address=${1}&password=${2}"
	curl -v -X POST -H "Accept: application/json, text/javascript" \
	-H "X-Requested-With: XMLHttpRequest" \
	-H ${UA} \
	-H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" \
	--data ${DATA} \
	${BASE}/api/member/signin > ${TMP_FILE} 2>&1

	TOKEN=`cat ${TMP_FILE} | grep Set-Cookie | sed -e 's/^..*auth_token_web=\([^;][^;]*\);..*$/\1/'`
	
	cat ${TMP_FILE} | grep -e '^{"' > ${TMP_FILE}_login
}

get_bag () {
	OFILE=${TMP_FILE}_bag
	curl -s -X GET -H ${UA} \
	-H "Cookie:auth_token_web=${TOKEN}" \
	"${BASE}/reserve/punchbag?lesson_id=${LESSON}&studio_code=${STUDIO}" > ${OFILE}
}

search_favorite_bag () {

	RESULT=`grep -e 'bag[0-9][0-9]*' ${TMP_FILE}_bag | grep -v '^ <' | grep -v disabled | grep -v ${NG_BAG} | sed -e 's/^..*bag\([0-9][0-9]*\)"..*$/\1/'`

	if [ -z ${RESULT} ]; then
		return;
	fi

	for I in ${RESULT}
	do
		BAG=$I
		for J in ${FAVORITE_BAGS}
		do
			if [ "$J" = "$BAG" ]; then
				reserve_bag ${J}
				return;
			fi
		done	
	done

	return;
}

reserve_bag () {
	# echo reserve
	# echo $1
	ONE_TIME_TOKEN=`curl -s -X GET -H ${UA} \
	-H "Cookie:auth_token_web=${TOKEN}" \
	"${BASE}/reserve/confirm?lesson_id=${LESSON}&studio_code=${STUDIO}&punchbag=${1}" | grep one_time_token | sed -e 's/..*value="\([^"][^"]*\)..*$/\1/'`

	# echo ONE_TIME_TOKEN $ONE_TIME_TOKEN
	TRY=`curl -s -X POST -H ${UA} \
	-H "Cookie:auth_token_web=${TOKEN}" \
	-H "X-Requested-With: XMLHttpRequest" \
	--data "onetime_token=${ONE_TIME_TOKEN}&no_and_members=%5B%7B%22no%22%3A%22${1}%22%7D%5D&pay_in_cash=&use_ticket=" \
	"${BASE}/api/reservation/${LESSON}/reserve" | jq -r .data`

	if [ "$TRY" = "null" ]; then
		RESERVED=""
	else
		echo RESERVED!
		RESERVED="TRUE"
	fi

	return;
}

login ${MAIL} ${PASSWORD}

# echo $TOKEN

while [ -z $RESERVED ]
do
	get_bag
	search_favorite_bag

	if [ -z $BAG ]; then
		echo sleeping 5 seconds
		sleep 5
		continue;
	else
		if [ "$RESERVED" = "TRUE" ]; then
			break;
		else
			reserve_bag ${BAG}
		fi
	fi
done

rm -f ${TMP_FILE}*

exit 0


