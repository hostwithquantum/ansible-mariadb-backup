import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_mariadb_backup_is_installed(host):
    redhat = host.file("/etc/redhat-release")

    # depending on weird configuration, the default is to install
    # xtrabackup (which is included in e.g. CentOS' distribution)
    # if however, we have the MariaDB repository already, then we
    # we test for `mariabackup`
    if redhat.exists:
        mariadb_backup = host.file("/usr/bin/xtrabackup")

        if not mariadb_backup.exists:
            mariadb_backup = host.file("/usr/bin/mariabackup")

    else:
        mariadb_backup = host.file("/usr/bin/mariabackup")

    assert mariadb_backup.exists


def test_system_user_is_created(host):
    user = host.user("mariabackup")

    assert user.shell == "/usr/sbin/nologin"
    assert user.group == "mysql"


def test_my_cnf_is_created(host):
    user = host.user("mariabackup")
    f = host.file(user.home + "/.my.cnf")

    assert f.exists
    assert f.user == user.name
    assert f.group == user.group
    assert f.mode == 0o600
    assert f.contains('user=mariabackup')
    assert f.contains('password=123mariadb')


def test_mysql_user_is_created(host):
    cmd = host.run("mysql -u mariabackup -p123mariadb -e 'show databases;'")

    assert cmd.rc == 0
