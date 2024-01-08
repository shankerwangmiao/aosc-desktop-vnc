FROM localhost/loongnix-ow:20.5

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && \
    apt-get --no-install-recommends -y install iproute2 less tigervnc-standalone-server

RUN mkdir -p /etc/systemd/system/console-getty.service.d/

COPY console-getty.override.conf /etc/systemd/system/console-getty.service.d/override.conf
COPY default.preset /lib/systemd/system-preset/99-default.preset
COPY vnc.preset /lib/systemd/system-preset/70-vnc.preset
COPY lightdm.conf /etc/lightdm/lightdm.conf
RUN userdel -f -r loongson && useradd -m -s /bin/bash user
RUN rm -f /etc/machine-id
RUN systemctl disable ModemManager.service wpa_supplicant.service NetworkManager.service NetworkManager-dispatcher.service systemd-timesyncd.service systemd-resolved.service
RUN echo 'user:shanker' | chpasswd
RUN sed -i '/pam_limits\.so/s/required/optional/' /etc/pam.d/*
RUN sed -i '/pam_loginuid\.so/s/required/optional/' /etc/pam.d/*

CMD [ "/sbin/init" ]
