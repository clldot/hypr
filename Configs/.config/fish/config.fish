set -g fish_greeting

if status is-interactive
    starship init fish | source
end

# List Directory
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias cleanup='sudo pacman -Rns (pacman -Qtdq)' 
alias jctl="journalctl -p 3 -xb" 
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" 
alias list="sudo pacman -Qqe" 
alias listt="sudo pacman -Qqet" 
alias  listaur="sudo pacman -Qqem" 
alias yta-aac="yt-dlp --extract-audio --audio-format aac "  
alias  yta-best="yt-dlp --extract-audio --audio-format best "  
alias  yta-flac="yt-dlp --extract-audio --audio-format flac " 
alias  yta-mp3="yt-dlp --extract-audio --audio-format mp3 " 
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "
alias mirror="sudo reflector --protocol https --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"
alias mirrorup="sudo reflector --verbose --latest 10  --age 6 --sort rate --save /etc/pacman.d/mirrorlist"

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'
