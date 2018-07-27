/search.slang
section.container-fluid.card
  h4 Simple search
  p Select one search item and enter search criteria

  form.form method="POST" action="/search_by"
    div.form-check
      label.form-check-label for="search_by_date"
        input.form-check-input type="checkbox" name="search_by_date" value="true" Date
        input type="hidden" name="search_by_date" value="false"
    div.form-group
      label for="entry_date" Enter date:
      input.form-control type="text" name="entry_date" title="Date format: yyyy-mm-dd, yyyy-mm, yyyy" pattern="[0-9]{4}\-[0-9]{2}\-[0-9]{2}|[0-9]{4}\-[0-9]{2}|[0-9]{4}"
        span.help-block Specify a year, month and year, or month and day of a certain year.

    div.form-check
      label.form-check-label for="search_by_category"
        input.form-check-input type="checkbox" name="search_by_category" value="true" Category
        input type="hidden" name="search_by_category" value="false"
    div.form-group
      label for="category" Choose category:
      select.form-control name="category" value=""
        option INFO
        option INSTALL
        option KERNEL
        option UPDATE
        option FIRMWARE

    div.form-check
      label.form-check-label for="search_by_memo"
      input.form-check-input type="checkbox" name="search_by_memo" value="true" Memo text
    div.form-group
      label for="memo" Enter search text:
      input.form-control type="text" name="memo" placeholder="some text to search for"
      input type="hidden" name="search_by_memo" value="false"
      span.help-block This is free-form text search with case ignored.

    button.btn.btn-outline-secondary  type="submit" Search
