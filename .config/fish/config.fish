source ~/.config/fish/variables.fish
source ~/.config/fish/keybinds.fish
source ~/.config/fish/abbreviations.fish

if status is-interactive
    atuin init fish | source
    source /usr/share/doc/find-the-command/ftc.fish
    colorscript random
end

starship init fish | source
zoxide init fish | source

alias cd='z' # Couldn't create it as a function because of zoxide init