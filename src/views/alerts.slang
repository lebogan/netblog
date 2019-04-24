- case
- when env.flash["success"]?
    div.alert.alert-success.alert-dismissible
      button[type="button" class="close" data-dismiss="alert"] == "&times"
      == env.flash["success"]?
- when env.flash["info"]?
    div.alert.alert-info
      == env.flash["info"]?
- when env.flash["warning"]?
    div.alert.alert-warning
      == env.flash["warning"]?
- when env.flash["danger"]?
    div.alert.alert-danger
      == env.flash["danger"]?
- end
