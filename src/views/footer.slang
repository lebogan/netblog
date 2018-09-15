/footer.slang
div
  nav.navbar.navbar-expand-md.bg-dark.navbar-dark.fixed-bottom
    span.navbar-text  Copyright ©
      == Time.now.to_s("%Y")
      | Lewis E. Bogan
    ul.navbar-nav
      li.nav-item
        a.nav-link href="/about" About
      li.nav-item
        a.nav-link href="/license" License
