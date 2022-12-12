# 2022

### Day 1 (Racket)
```shell
podman build . -t day01
podman run day01
```

### Day 2 (Swift)
```shell
swift main.swift
```

### Day 3 (Haskell)
```shell
podman build . -t day03
podman run day03
```

### Day 4 (C++)
```shell
podman build . -t day04
podman run day04
```

### Day 5 (C#)
```shell
podman build . -t day05
podman run day05
```

### Day 6 (OCaml)
```shell
# Increase podman mem because OCaml is crazy
podman machine init --cpus 2 --memory 4096
podman machine start
podman build . -t day06
podman run day06
```

### Day 7 (Ruby)
```shell
podman build . -t day07
podman run day07
```

### Day 8 (Dart)
```shell
podman build . -t day08
podman run day08
```

### Day 9 (F#)
```shell
podman build . -t day09
podman run day09
```

### Day 10 (Julia)
```shell
podman build . -t day10
podman run day10
```