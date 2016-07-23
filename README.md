## A ocserv server in docker

* How to run
	* Generate your certs and put them in folder `ocserv` and your devices.
	* Run it using `docker run -d --privileged --name ocserv -v ~/ocserv-docker/ocserv:/etc/ocserv -p 443:443 -p 4430:443/udp ihciah/ocserv`, docker will pull it automaticly if you don't have it.
	* Connect the server using the certificate imported in the 1st step.

* Acknowledgment
	* Originally forked from https://github.com/wppurking/ocserv-docker

