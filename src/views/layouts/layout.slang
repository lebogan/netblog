/layout.slang
doctype html
html lang="en-US"
  head
    title== title
    meta charset="utf-8"
    meta name="viewport" content="width=device-width, initial-scale=1"
    link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
    link rel="stylesheet" href="/css/styles.css"
    link rel="icon" type="image/png" sizes="32x32" href="/images/favicon.png"
  body style="height: 1400px"
    header.container-fluid
      == render "src/views/header.slang"

    section.container-fluid
      == content

    footer.container-fluid
      == render "src/views/footer.slang"

    script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"
    script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
    script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
