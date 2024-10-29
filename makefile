

all: download-packages dot-files vscode-extensions


download-packages:
	sudo apt-get install --yes --no-install-recommends $(cat packages.txt)

dot-files:
# Copy HOME directory to HOME
# Second copy is necessary to copy hidden files (begining with ".")
	cp --recursive HOME/* ${HOME}/
	cp --recursive HOME/.[^.]* ${HOME}/

vscode-extensions:
	./vscode-extensions.sh