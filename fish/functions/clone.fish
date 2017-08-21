function clone
  git clone (curl -Ls -o /dev/null -w "%{url_effective}" https://openit.io/$argv[1])
end
