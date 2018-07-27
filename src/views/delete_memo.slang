/delete_memo.slang
== render "src/views/alerts.slang"
section.container-fluid.card
  h4 Delete log entry for #{entry.entry_date}
  form
    div.form-group
      label for="category" Category:
      input.form-control type="text" name="category" value="#{entry.category}" disabled=true
    div.form-group
      label for="memo" Memo:
      input.form-control type="text" name="memo" value="#{entry.memo}" disabled=true
  form action="/log/#{entry.id}" method="POST"
    input type="hidden" name="_method" value="DELETE"
    input.btn.btn-outline-danger type="submit" value="Delete Entry"
    a.btn.btn-secondary role="button" href="/logs" Return to Logs

