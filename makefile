

all: download-packages dot-files vscode-extensions


download-packages:
	sudo apt-get install --yes --no-install-recommends $(cat packages.txt)

dot-files:
# Extra logic required to copy hidden files
	cp --recursive HOME/.[^.]* ${HOME}/

vscode-extensions:
	./vscode-extensions.sh