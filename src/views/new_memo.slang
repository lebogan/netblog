/new_mamo.slang
section.container-fluid.card
  h2 Add a new log entry
  - entry = Memo.new
  form.form method="POST" action="/log"
    == render "src/views/memo_form.slang"
