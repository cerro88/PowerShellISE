#Script hecho en clase de sistemas operativos en red
#Pedirá la hora y enseñará cada segundo como un reloj

#Se crea una función para agregar un 0 delante en caso de que sea un número mayor que 10
#la funcion se llama agrgarCero y sera una variable de nombre número
#de clase integer
function agregarCero ([int]$numero){
    #convierte el resultado a una string
    $result = $numero.ToString()
    #si el número es menor a 10
    if($numero -lt 10){
        #el resultado es igual a 0xnúmero
        $result = "0$result"
    }
# Devuelve el resultado
    return $result
}

#Se crea la función para sumar un segundo a la hora dada
function sumarTiempo([int]$hora, [int]$minutos, [int]$segundos){
    #se aumentan los segundos
    $segundos++

    #si pasan los segundos aumentamos los min
    if($segundos -gt 59){
        $segundos = 0
        $minutos++
    }
    #si los minutos pasan se aumenta la hora
    if($minutos -gt 59){
        $minutos = 0
        $hora++
    }

    #si se pasan las horas se vuelve a empezar
    if($hora -gt 23){
        $hora = 0
    }

#se crea un objeto con las variables
    [pscustomobject]$horaActual = @{"hora" = $hora; "minutos" = $minutos; "segundos" = $segundos}
    return $horaActual
}

#crear la función para iniciar el reloj
function iniciarReloj([int]$hora, [int]$minutos, [int]$segundos){
    #se pasan a string para regularizar los ceros
    [string]$cadena_hora = agregarCero $hora
    [string]$cadena_min = agregarCero $minutos
    [string]$cadena_seg = agregarCero $segundos

    #escribe la cadena de tiempo
    Write-Host $cadena_hora":"$cadena_min":"$cadena_seg

    #se aplica la función sumar el tiempo
    $horaActual = sumarTiempo $hora $minutos $segundos

    #espera un segundo
    Start-Sleep -s 1

    #se inicia la función que inicia el reloj
    iniciarReloj $horaActual["hora"] $horaActual["minutos"] $horaActual["segundos"]
}

#INICIO DEL SCRIPT

#se ponen los parámetros a 0
[int]$hora = 0
[int]$minutos = 0
[int]$segundos = 0
[string]$horaActual = "";

#
do{
    $horaActual = Read-Host "Indica la hora de inicio del reloj en formato universal hh:mm:ss"
    $horaActual_array = $horaActual -split ":"
    $hora = $horaActual_array[0]
    $minutos = $horaActual_array[1]
    $segundos = $horaActual_array[2]
}

while( ($hora -lt 0 -or $hora -gt 23) -or ($minutos -lt 0 -or $minutos -gt 59) -or ($segundos -lt 0 -or $segundos -gt 59) )

# Iniamos el reloj
iniciarReloj $hora $minutos $segundos