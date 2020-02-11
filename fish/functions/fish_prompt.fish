# based on Simple by Sota Yamashita: https://github.com/sotayamashita/simple

function __git_upstream_configured
    git rev-parse --abbrev-ref @"{u}" >/dev/null 2>&1
end

function __print_color
    set -l color $argv[1]
    set -l string $argv[2]

    set_color $color
    printf $string
    set_color normal
end

function fish_prompt -d "Simple Fish Prompt"
    # notify
    echo -e ""

    # Host
    # set -l host_name (hostname -s)
    # __print_color e88388 "$host_name"

    # Git
    if not set -q __git_cb
        set __git_cb (set_color normal)"("(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)")"
    end


    # Current working directory
    # set -l pwd_glyph " in "
    set -l pwd_string (echo $PWD | sed 's|^'$HOME'\(.*\)$|~\1|') $__git_cb
    __print_color cccccc "$pwd_glyph"
    __print_color a7cc8c "$pwd_string"

    # >
    __print_color e88388 "\n❯ "
end
