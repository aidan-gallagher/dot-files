all: copy-files copy-secret-files run

# --archive is necessary to ensure files under HOME are owned by aidan and not by root.
copy-files:
	sudo cp --archive ROOT/* /

run:
	sudo apt-get install --yes --no-install-recommends $(cat deb-pkgs.txt)
	systemctl --user enable --now save-docs.timer
	./vscode-extensions.sh
	grep -qxF 'source ~/.bashrc_aidan' ~/.bashrc || echo 'source ~/.bashrc_aidan' >> ~/.bashrc


# ------------------------------- Secret Files ------------------------------- #
copy-secret-files: clone-secret-files decrpyt-secret-files
	cp --recursive dot-files-secret/ROOT-secret/* /

clone-secret-files:
	sudo rm -rf dot-files-secret
	git clone https://github.com/aidan-gallagher/dot-files-secret.git

decrpyt-secret-files:
	gpg -d dot-files-secret/ROOT-secret.tar.gz.gpg | tar xz && rm dot-files-secret/ROOT-secret.tar.gz.gpg

encrypt-secret-files:
	tar cz dot-files-secret/ROOT-secret | gpg --symmetric > dot-files-secret/ROOT-secret.tar.gz.gpg && rm -r dot-files-secret/ROOT-secret
# ---------------------------------------------------------------------------- #