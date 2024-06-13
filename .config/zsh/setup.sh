# SPELLING ERROR PROMPT SETUP 
SPROMPT="correct %B%R%b to %B%r%b? [n]o [y]es [a]bort [e]dit "
# Try to correct the spelling of commands. Note that, when the HASH_LIST_ALL option is not set or when some directories in the path are not readable,
# this may falsely report spelling errors the first time some commands are used.
# The shell variable CORRECT_IGNORE may be set to a pattern to match words that will never be offered as corrections.
setopt CORRECT

# Try to correct the spelling of all arguments in a line.
# The shell variable CORRECT_IGNORE_FILE may be set to a pattern to match file names that will never be offered as corrections.
#setopt CORRECT_ALL

# Whenever a command completion or spelling correction is attempted, make sure the entire command path is hashed first. 
# This makes the first completion slower but avoids false reports of spelling errors.
setopt HASH_LIST_ALL

# Ensure glob is case-insensitive
setopt NO_CASE_GLOB

# CD when directory is provided but CD is forgotton
setopt auto_cd
# enable the next line to use the compinstall
# autoload -U compinstall

setopt PROMPT_SUBST
setopt EXTENDED_GLOB


# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# zstyle :compinstall filename '/Users/sam/.zshrc'
# 
autoload -Uz compinit
compinit
# End of lines added by compinstall

export HISTSIZE=5000
export SAVEHIST=-1
