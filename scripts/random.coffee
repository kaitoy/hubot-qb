module.exports = (robot) ->

  robot.hear /HOE/i, (res) ->
    res.send res.random [
      '僕と契約して魔法少女になってよ!',
      '君は、本当に神になるつもりかい!?',
      'それは間違いなく実現したじゃないか。',
      'わけがわからないよ。',
      '僕と契約して魔法少女になってほしいんだ。',
      'いつでも声をかけて。',
      '僕が力になってあげられるよ。',
      'わけがわからないよ。',
      '君にはその資格がありそうだ。',
      '君はエントロピーっていう言葉を知ってるかい?',
      '君はこの宇宙の一員では、無くなった。',
      'わけがわからないよ。',
      '遅かれ早かれ、結末は一緒だよ。',
      'まっ、あとは君たち人類の問題だ。',
      '・・・その反応は理不尽だ。',
      'ボクの名前はキュウベぇ！君たちにお願いがあって来たんだ！',
      'わけがわからないよ。',
      '君たちの好きにしていいよ。僕はもうサジを投げた。',
      'もったいないじゃないか！',
    ]