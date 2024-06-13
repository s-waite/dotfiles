alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias ls='ls -G'
alias iina='open -a iina'
alias backupmovies="sudo rsync -avP /Volumes/local_media/movies/ samwaite@192.168.1.210:/volume1/NAS-2TB/movies"
alias ARWtoPNG='mkdir png-preview; sips -s format png -Z 1000 ./*.ARW --out png-preview'
alias AAXtoM4B='for i in *.aax; do ffmpeg -activation_bytes 84b58509 -i "$i" -c copy ${i%.aax}.m4b; done'
alias resource='source ~/.zshrc'
alias ql='qlmanage -p'
alias imgupscale='/Users/sam/Documents/scripts/misc/realesrgan-ncnn-vulkan -m /Users/sam/Documents/scripts/misc/models'
alias ee="exa --long --icons --no-permissions --no-user --no-time --sort type --level 1"
alias config="/opt/homebrew/bin/git --git-dir=$HOME/.macOS_dotfiles --work-tree=$HOME"

webdev () {
    open -a "Pixea" .
    live-server --browser="Google Chrome" &> /dev/null &
    nvim *.html *.css -c ":tab all"
}

cr () {
    case $1 in
       webdev)
            touch index.html style.css script.js
            mkdir img
            ;;
    esac
}

conf () {
  case $1 in
    sort)
      echo "test"
      ;;

    zsh)
      echo "test2"
      ;;
  esac
}
compdef _function conf
function _function () {
  _arguments '1: :( sort output )'
}

vid2gif () {
    if [ $# -eq 0 ]; then
        echo "Usage: vid2gif <input> <start time in seconds> <length in seconds> <fps> <width in px>"
        return
    fi

    ffmpeg -ss ${2} -t ${3} -i ${1} -vf "fps=${4},scale=${5}:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 output.gif
}
