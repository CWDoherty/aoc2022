# 2022

Coming Soon: Dockerfiles
### Day 1 (Racket)
```shell
podman build . -t day1
podman run day1
```

### Day 2 (Swift)
```shell
swift main.swift
```

### Day 3 (Haskell)
```shell
podman build . -t day3
podman run day3
```

### Day 4 (C++)
```shell
podman build . -t day4
podman run day4
```

### Day 5 (C#)
Install .NET: https://learn.microsoft.com/en-us/dotnet/core/install/macos
```shell
podman build . -t day5
podman run day5
```

### Day 6 (OCaml)
```shell
# Increase podman mem because OCaml is crazy
podman machine init --cpus 2 --memory 4096
podman machine start
podman build . -t day6
podman run day6
```