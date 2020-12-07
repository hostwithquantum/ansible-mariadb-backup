FROM r.planetary-quantum.com/quantum-public/ansible-molecule:2.22
RUN apk add --update build-base unzip
RUN pip install --upgrade "pip<20.0"
RUN pip uninstall -y ansible
ADD requirements.txt .
ADD constraints.txt .
RUN pip install -r requirements.txt -c constraints.txt
