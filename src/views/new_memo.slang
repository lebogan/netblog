section.container-fluid.well
  h2 Add a new record
  form.form method="POST" action="/log"
    == render "src/views/memo_form.slang"
