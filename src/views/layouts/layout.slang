doctype html
html lang="en-US"
  head
    title== title || "NetBLog"
    meta charset="utf-8"
    meta name="viewport" content="width=device-width, initial-scale=1"
    link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
    link rel="stylesheet" href="/css/styles.css"
    link rel="icon" type="image/png" sizes="32x32" href="/images/favicon.ico"
  body
    header
      h1 Network Logger
      == render "src/views/nav.slang"
    section.container
      == content


