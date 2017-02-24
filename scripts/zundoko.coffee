module.exports = (robot) ->

  robot.hear /ズンドコ|ずんどこ|/i, (res) ->
    kiyoshi 0, res

kiyoshi = (zunCount, res) ->
  zundoko = res.random ['ズン', 'ズン', 'ドコ']
  res.send zundoko
  if zundoko is 'ズン'
    zunCount++
    setTimeout(
      () -> kiyoshi(zunCount, res),
      if zunCount is 1 then 1500 else 750
    )
  else
    if zunCount is 4
      setTimeout(
        () -> res.send 'キ・ヨ・シ！',
        750
      )
    else
      setTimeout(
        () -> kiyoshi(0, res),
        750
      )
