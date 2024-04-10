Add-Content -Path "C:/Users/TanayaSharma/.ssh/config" -Value@"
Host ${hostname}
 Hostname ${hostname}
 User ${user}
 IdentityFile ${identityfile}
 "@