FROM kingma/ubuntu-xfce-novnc:base

ENV HOME=/home/vncuser

RUN apt update && \
    apt install -y firefox
RUN apt clean -y

ADD ./src/ $HOME/

RUN cd $HOME/ && \
    chmod +x vnc_startup.sh && \
    chown vncuser:vncuser vnc_startup.sh
    
EXPOSE 6080

USER vncuser

ENTRYPOINT ["$HOME/vnc_startup.sh"]
CMD ["--wait"]
