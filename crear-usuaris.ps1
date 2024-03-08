# Defineix el camí de l'arxiu CSV
$csvPath = "full_usuaris.csv"

# Importa el mòdul ActiveDirectory si no està carregat
if (-not (Get-Module -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Llegeix l'arxiu CSV
$users = Import-Csv -Path $csvPath

# Bucle per cada usuari en l'arxiu CSV
foreach ($user in $users) {
    # Construeix el nom complet
    $fullName = "$($user.NOM) $($user.COMNOMS)"
    
    # Construeix el DN (Distinguished Name) per a l'OU on vols crear els usuaris
    # Aquest OU s'ha d'ajustar segons la teva estructura de AD
    $ou = "OU=UO2021,DC=bcc,DC=local"

    Write-host $user.COMPTE;
    Write-Host $fullName;
    
    # Construeix la comanda per crear l'usuari
    $userCommand = @{
        SamAccountName = $user.COMPTE
        UserPrincipalName = "$($user.COMPTE)@bcc.local"
        Name = $fullName
        GivenName = $user.NOM
        Surname = $user.COMNOMS
        Enabled = $true
        DisplayName = $fullName
        Description = $user.DESCRIPCIO
        OfficePhone = $user.TELEFON
        AccountPassword = (ConvertTo-SecureString -AsPlainText $user.PASSWORD -Force)
        Path = $ou
        ChangePasswordAtLogon = $false
        PasswordNeverExpires = $true
    }

    # Intenta crear l'usuari i captura qualsevol error
    try {
        New-ADUser @userCommand -ErrorAction Stop
        Write-Host "Usuari creat: $($user.COMPTE)"
    } catch {
        Write-Host "Error en crear l'usuari: $($user.COMPTE)"
        Write-Host $_.Exception.Message
    }
}

Write-Host "Creació d'usuaris completada."
