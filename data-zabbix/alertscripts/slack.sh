#!/bin/bash

# Slack incoming web-hook URL and user name
url='https://hooks.slack.com/services/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'
username='zabbix-oregonc'

url='https://hooks.slack.com/services/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'
username='zabbix-oregonm'

## Values received by this script:
# To = $1 (Slack channel or user to send the message to, specified in the Zabbix web interface; "@username" or "#channel")
# Subject = $2 (usually either PROBLEM or RECOVERY/OK)
# Message = $3 (whatever message the Zabbix action sends, preferably something like "Zabbix server is unreachable for 5 minutes - Zabbix server (127.0.0.1)")

# Get the Slack channel or user ($1) and Zabbix subject ($2 - hopefully either PROBLEM or RECOVERY/OK)

to="$1"
subject=$(echo $2|cut -d' ' -f1) # The alert type is before the space, server after, eg
server=$(echo $2|cut -d' ' -f2-) #      "Subject: PROBLEM SomeDatabaseServer01":

# Set up the alert type (future flexibility)
if [ "$subject" == 'RECOVERY' ]; then
	        type="R"
	elif [ "$subject" == 'PROBLEM' ]; then
	       type="P"
	else
	       type="N"
	fi

			# Change message emoji, color, and (friendly) status depending on the subject
	if [ $type == 'R' ]; then  # Triggered by 'RECOVERY' above
	        emoji=':resolvido:'    # A smile,
	        color="#20E020"    # and red text
	        status="Recovered"
		elif [ $type == 'P' ]; then  # Triggered by 'PROBLEM' above
                emoji=':rage:'
	        color="#E02020"
	        status="Problem"
		else
	        emoji=':ghost:'
	        color="#808080"
	        status="N/A"
		fi

												# The message that we want to send to Slack is the "subject" value ($2 / $subject - that we got earlier)
												#  followed by the message that Zabbix actually sent us ($3)
	message="$3"

												# Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL
												# See https://api.slack.com/docs/formatting for formatting details
		payload="payload={
	        \"channel\": \"${to}\",
	        \"username\": \"${username}\",
	        \"icon_emoji\": \"${emoji}\",
        \"attachments\": [
          {
																		                   \"title\": \"${server}: ${status}\",
																				                 \"fallback\": \"${message}\",
																				            \"text\": \"${message}\",
																				                  \"color\": \"${color}\",
																				                   \"mrkdwn_in\": [ \"text\" ]
																					              }
																					              ] }"

																			/usr/bin/curl -m 5 --data-urlencode "${payload}" $url											      
																														    #payload="payload={\"channel\": \"${to//\"/\\\"}\", \"username\": \"${username//\"/\\\"}\", \"text\": \"${message//\"/\\\"}\", \"icon_emoji\": \"${emoji}\"}"
#curl -m 5 --data-urlencode "${payload}" $url -A 'zabbix-slack-alertscript / https://github.com/ericoc/zabbix-slack-alertscript'
