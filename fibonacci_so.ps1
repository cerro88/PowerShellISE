#Script que devolverá tantos números de la serie fibonnaci 
#como el usuario indique

#se pide al usuario un número positivo mayor a uno
[int]$numero = Read-Host "Introduce un número positivo"

#control de error
while($numero -lt 1){
    [int]$numero = Read-Host "Ese es número negativo. Introduce un número positivo" 
}

#El primer número de la serie siempre será uno
Write-Host "Se enseñan los $numero primeros números de la serie";
Write-Host "1";

#si no hay más números hemos acabado
if($numero -eq 1){
    exit;
}

#el segundo número de la serie siempre sera uno
Write-Host "1";

#si no tenemos más números, hemos acabado 
if($numero -eq 2) {
    exit;
}

#si llegamos hasta aquí se necesita inicializar los dos números anteriores
#para realizar la suma
[bigint] $ant = 1;
[bigint] $ant_ant = 1;

#se da una vuelta desde 3 hasta el número que ha indicado el usuario
for([int]$i = 3; $i -le $numero; $i++){
    [bigint]$nuevo_numero = $ant + $ant_ant;
    Write-Host "$nuevo_numero";
    $ant_ant = $ant;
    $ant = $nuevo_numero;
}


#se ha cambiado System.Int128 por bigint