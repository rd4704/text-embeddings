FROM elasticsearch:7.3.1
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm

RUN yum clean all && yum update -y && \
    yum install -y \
        python36u \
        python36u-libs \
        python36u-devel \
        python36u-pip

WORKDIR /usr/share/elasticsearch/
COPY . /usr/share/elasticsearch/text-embeddings/
RUN python3.6 -m pip install -r /usr/share/elasticsearch/text-embeddings/requirements.txt