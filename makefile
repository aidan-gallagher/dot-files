all: copy-system copy-home run

copy-system:
	sudo cp --recursive ROOT/* /
	
copy-home:
# Second copy is necessary to copy hidden files (begining with ".")
	cp --recursive HOME/* ${HOME}/
	cp --recursive HOME/.[^.]* ${HOME}/

run:
	sudo apt-get install --yes --no-install-recommends $(cat deb-pkgs.txt)
	./vscode-extensions.sh