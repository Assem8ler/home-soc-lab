# Effective audit policy is volatile across reboots - re-apply after VM restart
auditpol /set /category:"Доступ к объектам" /success:enable /failure:enable
auditpol /set /category:"Вход/выход" /success:enable /failure:enable
