section.container-fluid.well style="height: 500px"
  h4 Searching
  p Select search item and enter search criteria

  form.form method="POST" action="/search_by"
    div.checkbox
      label for="search_by_date"
        input type="checkbox" name="search_by_date" value="true" Date
    div.form-group
      label.control-label for="date" Enter date:
      input.form-control type="date" name="date"

    div.checkbox
      label for="search_by_category"
        input type="checkbox" name="search_by_category" value="true" Category
    div.form-group
      label for="category" Choose category:
      select.form-control name="category" value=""
        option 
        option INFO
        option INSTALL
        option KERNEL
        option UPDATE
        option FIRMWARE

    div.form-group
      div.checkbox
        label for="search_by_memo"
          input type="checkbox" name="search_by_memo" value="true" Memo text
      div.form-group
        label for="memo" Enter search text:
        input.form-control type="text" name="memo" placeholder="some text to search for"

    div.form-group
      button.btn.btn-default type="submit" Search
