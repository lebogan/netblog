section.container-fluid.well style="height: 500px"
  h4 Searching
  p Search page for simple or complex searches with
    | hyperlinks to print to pdf or printer.
  form.form method="POST" action="/search_by"
    div.checkbox
      label
        input type="checkbox" name="date" value="" Date
    div.form-group
      label for="memo" Date:
      input.form-control type="date" name="date"

    div.checkbox
      label
        input type="checkbox" value="" Categoty
    div.form-group
      label for="category" Category:
      select.form-control name="category" value=""
        option INFO
        option INSTALL
        option KERNEL
        option UPDATE
        option FIRMWARE

    div.form-group
      div.checkbox
        label
          input type="checkbox" value="" Memo text
      div.form-group
        label for="memo" Memo text:
        input.form-control type="text" name="memo"
    input type="submit" value="Search"
