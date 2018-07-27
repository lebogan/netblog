/edit_memo.slang
section.container-fluid.card
  h4 Edit log entry
  form.form method="POST" action="/log/#{entry.id}"
    input type="hidden" name="_method" value="PUT"
    == render "src/views/memo_form.slang"

