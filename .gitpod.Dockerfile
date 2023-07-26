FROM gitpod/workspace-full-vnc

USER gitpod


RUN sudo apt-get update
RUN sudo apt-get install patchelf -y
RUN sudo apt-get install npm -y

# aws
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install
# needed for codeartifact
RUN sudo ln /usr/bin/pip3 /usr/bin/pip -s -b && ls /usr/bin/pip -lsa

# SAM
RUN wget https://github.com/aws/aws-sam-cli/releases/download/v1.21.1/aws-sam-cli-linux-x86_64.zip
RUN unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
RUN sudo ./sam-installation/install

# Databases
RUN sudo apt-get -y install postgresql
RUN brew install mysql@8.0

# kubernetes
RUN sudo apt-get update
RUN sudo apt-get install -y apt-transport-https ca-certificates curl
RUN sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
RUN sudo apt-get update
RUN sudo apt-get install -y kubectl

# cypress
RUN echo "XKBMODEL='pc105' XKBLAYOUT='us' XKBVARIANT='' XKBOPTIONS='' BACKSPACE='guess'" > ./keyboard
RUN sudo mv ./keyboard /etc/default/keyboard
# RUN sudo apt-get install libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xvfb xauth -y

# terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
RUN sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN sudo apt-get install terraform=1.1.5 -y

# helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

# node / yarn
RUN sudo npm install -g n
RUN sudo n stable
RUN sudo npm install -g yarn
