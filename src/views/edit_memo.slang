/edit_memo.slang
section.container-fluid.card
  h4 Edit log entry
  form.form method="post" action="/log/#{entry.id}/edit"
    == render "src/views/memo_form.slang"

