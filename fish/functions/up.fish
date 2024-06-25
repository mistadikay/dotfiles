# update dependencies
function up
    switch (uname)
        case Linux
            if test /etc/redhat-release
                sudo dnf clean all
                sudo dnf upgrade --refresh
                sudo yum update
            else
                sudo apt update
                sudo apt full-upgrade
            end
        case '*'
            # show mac updates
            softwareupdate -l

            # upgrade mac apps
            mas upgrade

            # brew
            brew update
            brew upgrade
            brew cleanup -s

            # https://github.com/rgcr/m-cli
            m --update
    end

    # https://github.com/fish-shell/fish-shell/blob/master/doc_src/fish_update_completions.txt
    fish_update_completions

    # update fishmarks (https://github.com/techwizrd/fishmarks)
    cd ~/.fishmarks
    git fetch --all
    git reset --hard origin/master

    # update fisher
    fisher update

    # update npm and global npm packages
    npm i npm -g
    npm update -g
end
