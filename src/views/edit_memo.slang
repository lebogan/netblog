section.container-fluid.well
  h4 Edit Log Entry
  form.form method="POST" action="/log/#{entry.id}"
    input type="hidden" name="_method" value="PUT"
    == render "src/views/memo_form.slang"

