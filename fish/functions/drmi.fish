function drmi
    for i in (docker image ls | grep none | tr -s " " | cut -d " " -f 3)

        docker image rm $i

    end
end
