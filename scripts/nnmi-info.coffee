# Description:
#   Memorizes and replies NNMi information
#
# Dependencies:
#
# Configuration:
#
# Commands:
#   ni <HP NNMi ver (e.g. 8.10P6)> <JP1 NNMi ver (e.g. 09-10)> - Tell the JP1 NNMi version corresponding to the HP NNMi version.
#   ni <HP NNMi ver (e.g. 8.10P6)> <JDK ver (e.g. 1.8.0_121)> - Tell the JDK version which the version of HP NNMi uses.
#   ni del <HP NNMi ver (e.g. 10.10P1)> - Tell to forget about the HP NNMi version
#   ni list - Ask to show entire memory.
#   ni <HP NNMi ver (e.g. 8.10)> - Ask the JP1 NNMi version and JDK version corresponding to the HP NNMi version.
#   ni <JP1 NNMi ver (e.g. 10-50)> - Ask the HP NNMi version and JDK version corresponding to the JP1 NNMi version.
#
# Notes:
#
# Author:
#   kaitoy

STORE_KEY = 'hubot_qb_nnmi_info'

module.exports = (robot) ->

  robot.respond /ni (\d+-\d+)$/i, (res) ->
    target_ver = res.match[1]
    memory = recall robot
    for hp_ver, info of memory
      if info.jp1_ver is target_ver
        msg = hp_ver
        if info.jdk_ver?
          msg += " (JDK #{info.jdk_ver})"
        res.reply msg
        return
    res.reply 'わけがわからないよ。'

  robot.respond /ni (\d+\.\d+(?:P\d)?)$/i, (res) ->
    target_ver = res.match[1].toUpperCase()
    memory = recall robot
    info = memory[target_ver]
    if info?
      msg = ''
      if info.jp1_ver?
        msg = info.jp1_ver
      else
        msg = 'N/A'
      if info.jdk_ver?
        msg += " (JDK #{info.jdk_ver})"
      res.reply msg
    else
      res.reply 'わけがわからないよ。'

  robot.respond /ni (\d+\.\d+(?:P\d)?) (\d+-\d+)(?: ([\d._]+))?$/i, (res) ->
    hp_ver = res.match[1].toUpperCase()
    jp1_ver = res.match[2]
    memory = recall robot
    if memory[hp_ver]?
      memory[hp_ver].jp1_ver = jp1_ver
    else
      memory[hp_ver] = jp1_ver: jp1_ver
    jdk_ver = res.match[3]
    if jdk_ver?
      memory[hp_ver].jdk_ver = jdk_ver

  robot.respond /ni list$/i, (res) ->
    memory = recall robot
    list = ''
    for hp_ver, info of memory
      jp1_ver = if info.jp1_ver? then info.jp1_ver else 'N/A'
      jdk_ver = if info.jdk_ver? then info.jdk_ver else '???'
      list += "#{hp_ver} -> #{jp1_ver} (JDK #{jdk_ver})\n"
    if list.length isnt 0
      res.reply "\n#{list}"
    else
      res.reply 'わけがわからないよ。'

  robot.respond /ni del (\d+\.\d+(?:P\d)?)$/i, (res) ->
    target_ver = res.match[1].toUpperCase()
    memory = recall robot
    delete memory[target_ver]

recall = (robot) ->
  memory = robot.brain.get STORE_KEY
  if not memory?
    memory = {}
    robot.brain.set STORE_KEY, memory
  return memory
