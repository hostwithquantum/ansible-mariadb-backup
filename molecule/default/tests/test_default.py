import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_mariadb_backup_is_installed(host):
    mariadb_backup = host.file("/usr/bin/mariabackup")

    assert mariadb_backup.exists
