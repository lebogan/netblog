/maintenance.slang
section.container-fluid
  div.card
    div.card-header
      p.card-text Backup and restore the database, netlog.db
    div.card-body
      form method="POST" action="/backup"
        div.form-check
          label.form-check-label for="prune"
            input.form-check-input type="checkbox" name="prune" value="true" Delete backups older than 90 days
            input type="hidden" name="prune" value="false"
        div.form-group
          button.btn.btn-outline-secondary type="submit" Backup

    div.card-body
      form method="POST" action="/restore"
        div.form-group
          label for="restore_file" Restore file:
          input.form-control type="file" name="restore_file" accept=".sql, .bak"
        div.form-group
          button.btn.btn-outline-warning type="submit" Restore

  br
  div.card
    div.card-header
      p.card-text This check searches for corrupt indexes, malformed records, and other such problems.
    div.card-body
      form.form method="POST" action="/integrity_check"
        div.form-group
          label for="integrity_check" Integrity check: 
          button.btn.btn-outline-secondary type="submit" name="integrity_check" Check Now
