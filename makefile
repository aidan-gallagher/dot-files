
download:
	apt-get install --yes --no-install-recommends $(cat packages.txt)

install:
	cp --recursive HOME ${HOME}
