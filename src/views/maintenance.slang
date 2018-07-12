section.container-fluid.well
  == render "src/views/alerts.slang"
  div.panel.panel-default
    div.panel-heading
      h4 Backup and restore the database, netlog.db
    div.panel-body
      form.form method="POST" action="/backup"
        div.checkbox
          label for="prune"
            input type="checkbox" name="prune" value="true" Delete backups older than 90 days
            input type="hidden" name="prune" value="false"
        div.form-group
          button.btn.btn-default type="submit" Backup

  div.panel.panel-default
    div.panel-body
      form.form method="POST" action="/restore"
        div.form-group
          label for="restore_file" Restore file:
          input type="file" name="restore_file" accept=".sql, .bak"
        div.form-group
          button.btn.btn-default type="submit" Restore

  div.panel.panel-default
    div.panel-heading
      h4 This check searches for corrupt indexes, malformed records, and other such problems.
    div.panel-body
      form.form method="POST" action="/integrity_check"
        div.form-group
          label for="integrity_check" Integrity check: 
          button.btn.btn-default type="submit" name="integrity_check" Check Now
