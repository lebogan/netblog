section.container-fluid style="height: 500px"
  div.form-group
    label for="category" Category:
    select.form-control name="category" value="#{entry.category}"
      option INFO
      option INSTALL
      option KERNEL
      option UPDATE
      option FIRMWARE
  div.form-group
    label for="memo" Memo:
    input.form-control type="text" name="memo" value="#{entry.memo}"
  input type="submit" value="Save Entry"
