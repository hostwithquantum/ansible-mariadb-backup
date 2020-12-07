SHELL=/bin/bash

ROLENAME=mariadb-backup
TESTIMAGENAME=molecule-test

docker_cmd:=docker run --rm -it \
	-v '${PWD}':/${ROLENAME} \
	-v ${HOME}/.cache/molecule:/root/.cache/molecule \
	-v /var/run/docker.sock:/var/run/docker.sock:ro \
	-w /${ROLENAME} \
	--env MOLECULE_DISTRO \
	${TESTIMAGENAME}

.PHONY: clean
clean:
	docker stop instance || true
	docker kill instance || true
	docker rm instance || true

.PHONY: build-testimage
build-testimage:
	docker build -t ${TESTIMAGENAME} .

SCENARIO?=--all
DEBUG_OPTS?=

.PHONY: shell
shell: build-testimage
	$(docker_cmd) sh

.PHONY: test
test: build-testimage
	$(docker_cmd) molecule test $(SCENARIO) $(DEBUG_OPTS)

debug: DEBUG_OPTS:=--destroy=never
debug: test

os-centos7: SCENARIO:=--scenario-name all
os-centos7: export MOLECULE_DISTRO=centos7
os-centos7: test

os-debian10: SCENARIO:=--scenario-name all
os-debian10: export MOLECULE_DISTRO=debian10
os-debian10: test

os-ubuntu1804: SCENARIO:=--scenario-name all
os-ubuntu1804: export MOLECULE_DISTRO=ubuntu1804
os-ubuntu1804: test

os-ubuntu2004: SCENARIO:=--scenario-name all
os-ubuntu2004: export MOLECULE_DISTRO=ubuntu2004
os-ubuntu2004: test
