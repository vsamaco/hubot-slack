
module.exports = (robot) ->
  robot.respond /why (.*)\?$/i, (msg)->
    msg
      .http("http://www.codingexcuses.com/")
      .header("Accept", "text/plain")
      .get() (err, res, body) ->
        msg.send(body)
