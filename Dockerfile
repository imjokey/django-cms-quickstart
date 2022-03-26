FROM python:3.9
WORKDIR /app
COPY . /app
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone
RUN pip config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple \
&& pip config set global.trusted-host mirrors.cloud.tencent.com \
&& pip install --upgrade pip \
&& pip install -r requirements.txt
EXPOSE 80
CMD python manage.py collectstatic --noinput && python manage.py migrate --noinput && uwsgi --http=0.0.0.0:80 --module=backend.wsgi

