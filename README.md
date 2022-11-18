# Ignite a new invenio instance
after creating your own venv just run:
```bash
make app-ignite
```
This Makefile use pip, if you using `pipenv` then you can edit the Make file by replacing `pip` command

- you can change the initial project name and all initial questions in `.invenio` file

# Take DB dump:
´´´bash
script/.backup
´´´
# Restore DB:
´´´bash
script/.restore
´´´


