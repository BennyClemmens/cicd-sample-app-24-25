#!/bin/bash
set -euo pipefail

rm -rf tempdir

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

cat > tempdir/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdir || exit
docker build -t sampleapp .
if [ "$(docker ps -q -f name=samplerunning)" ]; then docker stop samplerunning; fi
if [ "$(docker ps -a -q -f name=samplerunning)" ]; then docker remove samplerunning; fi
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
