# Beep on Ctrl-A
#
# Combined with urgentOnBell, it allows a cool trick :
# When a long command (that takes no input) is running, type Ctrl-A.
# As soon as the execution is over, the urgent flag will be set on this window.

beep () {
  printf '\a'
}

bindkey '^A' beep
