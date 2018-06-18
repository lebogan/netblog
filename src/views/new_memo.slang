section.container-fluid
  h2 Add a new record
  form.form method="POST" action="/memo"
    == render "src/views/memo_form.slang"
