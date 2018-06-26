doctype html
html lang="en-US"
  head
    title== title
    meta charset="utf-8"
    meta name="viewport" content="width=device-width, initial-scale=1"
    link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
    link rel="stylesheet" href="/css/styles.css"
    link rel="icon" type="image/png" sizes="32x32" href="/images/favicon.png"
  body
    header.container-fluid
      img.img-rounded src="/images/netblog-1.png" alt="NetBLog"
      h4 Network Logging Utility
      == render "src/views/nav.slang"

    section.container-fluid
      /== render "src/views/alerts.slang"
      == content

    footer.navbar
      div.container-fluid
        ul.nav.navbar-nav
          li
            p.navbar-text  Copyright ©
              == Time.now.to_s("%Y")
              | Lewis E. Bogan
          li
            a href="/license" License
          li
            a href="/about" About
