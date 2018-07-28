/header.slang
div
  nav.navbar.navbar-expand-md.bg-light.navbar-light

    /! Brand
    a.navbar-brand href="/logs"
      img.img-fluid src="/images/logo.png" alt="NetBLog"
      span.navbar-text Maintenance Logger

    /! Toggler/collapsible Button
    button.navbar-toggler type="button" data-toggle="collapse" data-target="#collapsibleNavbar"
      span.navbar-toggler-icon

    /! Navbar links
    == render "src/views/nav.slang"
