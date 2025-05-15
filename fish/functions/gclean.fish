# cccccbrfghlvtflhrkjdrdubcgekbirujevklljl
function gclean
    git branch --merged \
      | grep -Ev '(^\*|[[:space:]](main|master)$)' \
      | xargs git branch -d
end