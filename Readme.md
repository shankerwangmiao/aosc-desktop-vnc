# How to build

```
wget https://pkg.loongnix.cn/loongnix/isos/Loongnix-20.5/Loongnix-20.5.cartoon.gui.loongarch64.cn.qcow2
modprobe nbd
qemu-nbd --connect=/dev/nbd0 Loongnix-20.5.cartoon.gui.loongarch64.cn.qcow2
mount -o ro /dev/nbd0p2 /mnt
tar -C /mnt -cv . | docker image import - loongnix-ow:20.5
umount /mnt
qemu-nbd --disconnect=/dev/nbd0
modprobe -r nbd
docker build --security-opt=seccomp=unconfined  --tag loongnix-ow-vnc:20240109 .
```

# How to run

```
docker run --rm -it -p 127.0.0.1:5901:5900 --cap-add=CAP_SYS_ADMIN,CAP_AUDIT_WRITE,CAP_SYS_NICE,CAP_SYS_RESOURCE,CAP_SYS_PTRACE  --cgroupns=private --security-opt=unmask=/sys/fs/cgroup --security-opt=seccomp=unconfined loongnix-ow-vnc:20240109
```
