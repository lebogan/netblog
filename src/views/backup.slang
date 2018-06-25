section.container-fluid.well style="height: 500px"
  h4 Backing up the database, netlog.db
  form.form method="POST" action="/backup"
    div.checkbox
      label for="prune"
        input type="checkbox" name="prune" value="true" Prune backups older than 90 days
        input type="hidden" name="prune" value="false"
    div.form-group
      button.btn.btn-default type="submit" Backup
