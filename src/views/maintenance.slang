section.container-fluid.well style="height: 200px"
  == render "src/views/alerts.slang"
  h4 Backing up the database, netlog.db
  form.form method="POST" action="/backup"
    div.checkbox
      label for="prune"
        input type="checkbox" name="prune" value="true" Prune backups older than 90 days
        input type="hidden" name="prune" value="false"
    div.form-group
      button.btn.btn-default type="submit" Backup

section.container-fluid.well style="height: 200px"
  h4 Restoring the database, netlog.db
  form.form method="POST" action="/restore"
    div.form-group
      label for="restore_file" Restore file:
      input type="file" name="restore_file" accept=".sql"
    div.form-group
      button.btn.btn-default type="submit" Restore
