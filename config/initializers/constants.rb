NAME = "Matthew Zaharia Bergman"
HANDLE = "FotoVerite"
WEBSITE = "FotoVerite.com"
BRAND = WEBSITE + " :: " + NAME
EMAIL = "matthew@fotoverite.com"
SUPPORT_EMAIL = "info@fotoverite.com"
SYSTEM_EMAIL  = "info@fotoverite.com"
COMPANY = "Fotoverite LLC"

STANDARD_EMAIL_REGEX = /^([a-z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-z0-9\-]+\.)+))([a-z]{2,4}|[0-9]{1,3})(\]?)$/i

Time::DATE_FORMATS[:standard] = "%B %e, %Y at %l:%M %p %Z"
