
download:
	apt-get install --yes --no-install-recommends $(cat packages.txt)

install:
# Extra logic required to copy hidden files
	cp --recursive HOME/.[^.]* ${HOME}/
