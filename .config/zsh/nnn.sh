# dracula colors BLK="0B" CHR="0B" DIR="68" EXE="06" REG="00" HARDLINK="06" SYMLINK="75" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
# gruvbox colors BLK="56" CHR="0B" DIR="42" EXE="06" REG="DF" HARDLINK="06" SYMLINK="6D" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
BLK="56" CHR="0B" DIR="6D" EXE="06" REG="DF" HARDLINK="06" SYMLINK="6D" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SO"
export NNN_PLUG='i:preview-tui'
export NNN_BMS="d:$HOME/Documents/MBP;D:$HOME/Downloads;v:/Volumes/;t:/Volumes/local_media/tv-shows;w:$HOME/WGU;c:$HOME/.config"
export NNN_TMPFILE='/tmp/nnn'
export NNN_TRASH=1
# cd on quit
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

# The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
# To cd on quit only on ^G, remove the "export" as in:
#     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

# Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
# stty start undef
# stty stop undef
# stty lwrap undef
# stty lnext undef

nnn -a -e -o -x

if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
fi
}
