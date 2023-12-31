FROM localhost/aosc-desktop:20231231

RUN apt-get update && \
    apt-get --no-install-recommends -y install tigervnc xfconf xfwm4 xfdesktop xfce4-panel xfce4-session

RUN sed -i '/XephyrPath/s@=.*$@=/usr/local/bin/myxvnc@' /etc/sddm.conf
RUN mkdir -p /etc/systemd/system/console-getty.service.d/

COPY myxvnc /usr/local/bin/
COPY console-getty.override.conf /etc/systemd/system/console-getty.service.d/override.conf
COPY sddm-vnc.socket /etc/systemd/system/
COPY sddm-vnc@.service /etc/systemd/system/
COPY sddm-vnc.preset /usr/lib/systemd/system-preset/70-sddm-vnc.preset
RUN rm -f /usr/lib/systemd/system-preset/70-aosc-os-plasma.preset /usr/lib/systemd/system-preset/80-aosc-os-base.preset
RUN useradd -m -s /bin/bash user
RUN echo 'user:shanker' | chpasswd
RUN echo "LANG=zh_CN.UTF-8" > /etc/locale.conf
RUN sed -i '/pam_limits\.so/s/required/optional/' /etc/pam.d/system-auth

CMD [ "/sbin/init" ]
