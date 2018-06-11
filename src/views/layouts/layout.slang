doctype html
html lang="en-US"
  head
    title== title
    meta charset="utf-8"
    meta name="viewport" content="width=device-width, initial-scale=1"
    link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
    link rel="stylesheet" href="/css/styles.css"
    link rel="icon" type="image/png" sizes="32x32" href="images/favicon-32x32.png"
  body
    header.container-fluid
      img src="images/netblog.png" alt="NetBLog"
      h4 Network Logging Utility
      == render "src/views/nav.slang"

    section.container-fluid
      == content

    footer.navbar.navbar-fixed-bottom
      div.container
        p.navbar-text  Copyright ©
          == Time.now.to_s("%Y")
          | Lewis E. Bogan


