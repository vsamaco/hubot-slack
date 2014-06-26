# Description:
#   Counts words
#
# Commands:
#   hubot fake event <event> - Triggers the <event> event for debugging reasons
#
# Events:
#   debug - {user: <user object to send message to>}

util = require 'util'
getDateTime = -> 
  date = new Date()

  hour = date.getHours()
  hour = (hour < 10 ? "0" : "") + hour

  min  = date.getMinutes()
  min = (min < 10 ? "0" : "") + min

  sec  = date.getSeconds()
  sec = (sec < 10 ? "0" : "") + sec

  year = date.getFullYear()

  month = date.getMonth() + 1
  month = (month < 10 ? "0" : "") + month

  day  = date.getDate()
  day = (day < 10 ? "0" : "") + day

  return year + ":" + month + ":" + day + ":" + hour + ":" + min + ":" + sec

module.exports = (robot) ->
  counts = {
    "garvey pls": 0
  }
  startTime = getDateTime()

  console.log("counter!")
  robot.respond /count (.*)/i, (msg) ->
    countPhrase = msg.match[1]
    counts[countPhrase] = counts[countPhrase] || 0
    msg.send "Now counting #{countPhrase}"

  robot.respond /stop counting (.*)/i, (msg) ->
    countPhrase = msg.match[1]
    counts[countPhrase] = null
    msg.send "No longer counting #{countPhrase}"

  robot.hear /(.*)/i, (msg) ->
    for key of counts
      if msg.match[1] == key
        counts[key] += 1

  robot.respond /how many (.*)$/i, (msg) ->
    countPhrase = msg.match[1]
    if counts[countPhrase] == null
      msg.send "Not counting #{countPhrase}"
    else
      msg.send "#{countPhrase} counted #{counts[countPhrase]} times"
