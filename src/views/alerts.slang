- case
- when env.flash["success"]?
    div.alert.alert-success
      == env.flash["success"]?
- when env.flash["info"]?
    div.alert.alert-info
      == env.flash["info"]?
- when env.flash["warning"]?
    div.alert.alert-warning
      == env.flash["warning"]?
- end
