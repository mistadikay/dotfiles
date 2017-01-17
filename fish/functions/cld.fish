# cleanup all docker garbage
function cld
    # Stop all containers
    docker stop (docker ps -a -q)

    # Remove all containers
    docker rm (docker ps -a -q)

    # Remove all images
    docker rmi (docker images -q)

    # Remove orphaned volumes
    docker volume rm (docker volume ls -qf dangling=true)
end
