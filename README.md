# MariaDB Backup

Installs MariaDB-Backup (or percona-extradebug).

There are a few oddities about MariaDB Server versions and distributions, the following are the distribution defaults (unless you did something otherwise):

| Distribution | Version | `mariadb_backup_package` |
| :------------- | :----------: | -----------: |
| Debian-10 | `10.3` | `mariadb-backup` |
| Debian-9 | `10.2` | `mariadb-backup` |
| RedHat-7 | `~10.1` | `percona-xtrabackup` |

**Note**

> It's generally not possible to install MariaDB(-server) from the distributions repository and then install `mariadb-backup` using MariaDB's repositories.
> Repository discovery is out of scope for this role. You can however influence the source of  `mariadb-backup` by discovering a repository before the role is invoked and overriding `mariadb_backup_package`. See `molecule/all/prepare.yml`.

## Requirements

 - MariaDB server (already installed)

## Role Variables

| Variable | Default | Description |
| :------------- | :----------: | -----------: |
| `mariadb_backup_db_username` | `mariabackup` | Name of the database user |
| `mariadb_backup_db_password` | _empty string_ | Set this to create the user. |
| `mariadb_backup_system_account` | `mariabackup` | Name of the system/linux account |


## Dependencies

n/a

## Example Playbook

```yaml
- hosts: servers
  roles:
    - { role: hostwithquantum.mariadb-backup }
```

## License

BSD-2-Clause

## Author Information

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
