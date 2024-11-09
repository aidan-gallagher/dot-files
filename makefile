all: copy-files run

copy-files:
	sudo cp --recursive ROOT/* /

run:
	sudo apt-get install --yes --no-install-recommends $(cat deb-pkgs.txt)
	./vscode-extensions.sh

