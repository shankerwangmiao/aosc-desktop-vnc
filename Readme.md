# How to build

```
curl -fsSL https://releases.aosc.io/os-loongarch64/desktop/aosc-os_desktop_20240215_loongarch64.tar.xz | xzcat | docker image import - aosc-desktop:20240215
docker build --tag aosc-desktop-vnc:20240215 .
```

# How to run

```
docker run --rm -it -p 127.0.0.1:5900:5900 --cap-add=CAP_SYS_ADMIN --cap-add=CAP_AUDIT_WRITE --cap-add=CAP_SYS_NICE --cap-add=CAP_SYS_RESOURCE --cap-add=CAP_SYS_PTRACE --cgroupns=private --security-opt=unmask=/sys/fs/cgroup --security-opt=seccomp=unconfined aosc-desktop-vnc:20231231
```
