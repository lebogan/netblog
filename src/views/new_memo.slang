section.container-fluid.well
  h2 Add a new record
  - entry = Memo.new
  form.form method="POST" action="/log"
    == render "src/views/memo_form.slang"
