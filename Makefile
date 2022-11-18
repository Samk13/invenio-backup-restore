.DEFAULT_GOAL=ls
.ONESHELL: # Applies to every targets in the file!

ls: # List available commands
	@grep '^[^#[:space:]].*:' Makefile

install-cli: # install invenio cli
	@pip install invenio-cli

app-init-master: # install packages
	@invenio-cli init rdm -c master --config .invenio

app-init-v9: # install packages
	@invenio-cli init rdm -c v9.1 --no-input

install-packages: # install packages
	cd my-site && \
	invenio-cli install

setup-services: # setup docker services
	cd my-site && invenio-cli services setup -f -N

run: # start the app
	cd my-site && invenio-cli run

app-ignite:
	@make install-cli
	@make app-init-master
	@make install-packages
	@make setup-services
	@make setup-services # run it one more time in order to work!
	@make run