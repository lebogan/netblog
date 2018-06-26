section.container-fluid.well style="height: 500px"
  h4 Restoring the database, netlog.db
  form.form method="POST" action="/restore"
    div.form-group
      label for="restore_file" Restore file:
      input type="file" name="restore_file" accept=".sql"
    div.form-group
      button.btn.btn-default type="submit" Restore
