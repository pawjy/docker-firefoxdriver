CURL = curl

all:

deps:

updatenightly:
	$(CURL) -sSLf https://raw.githubusercontent.com/wakaba/ciconfig/master/ciconfig | RUN_GIT=1 REMOVE_UNUSED=1 perl

test-circleci:
	git clone https://github.com/manakai/perl-web-driver-client
	cd perl-web-driver-client && make test-deps

	docker run -d -it quay.io/wakaba/base:stable bash
	ip route | awk '/docker0/ { print $$NF }' > docker0-ip.txt
	cat docker0-ip.txt

	docker run --name server -d -p 5511:9516 --add-host=dockerhost:`cat docker0-ip.txt` quay.io/wakaba/firefoxdriver:stable /fx
	while [ ! curl -f http://localhost:5511/status ]; do sleep 1; done
	cd perl-web-driver-client && TEST_WD_URL=http://localhost:5511 WEBUA_DEBUG=2 TEST_SERVER_LISTEN_HOST=0.0.0.0 TEST_SERVER_HOSTNAME=dockerhost make test

	docker logs server
	docker kill server

## License: Public Domain.
