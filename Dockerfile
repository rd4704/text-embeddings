FROM elasticsearch:7.3.1
RUN yum install -y https://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-2-1.el7.ius.noarch.rpm

RUN yum clean all && yum update -y && \
    yum install -y \
        python36u \
        python36u-libs \
        python36u-devel \
        python36u-pip

WORKDIR /usr/share/elasticsearch/text-embeddings/
COPY . /usr/share/elasticsearch/text-embeddings/
RUN python3.6 -m pip install -r /usr/share/elasticsearch/text-embeddings/requirements.txt
