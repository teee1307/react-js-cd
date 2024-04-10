add-content -path c:/users/TanayaSharma/.ssh/config -value @'


Host ${hostname}
 Hostname ${hostname}
 User ${user}
 IdentityFile ${identityfile}
 '@