section.container-fluid style="height: 500px"
  == render "src/views/alerts.slang"
  h4 Edit Log Entry
  form.form
    div.form-group
      label for="category" Category:
      select.form-control name="category" value="#{entry.category}"
        option INFO
        option INSTALL
        option KERNEL
        option UPDATE
        option FIRMWARE
    div.form-group
      label for="memo" Memo:
      input.form-control type="text" name="memo" value="#{entry.memo}"
  form action="/log/#{entry.id}" method="POST"
    input type="hidden" name="_method" value="DELETE"
    input type="submit" value="delete this entry"
    a.btn.btn-default href="/logs" Return to Logs

