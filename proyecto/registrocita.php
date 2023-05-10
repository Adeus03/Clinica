<?php
    $errores="";
    $enviado="";

    if(isset($_POST['enviar']))
    {
        $nombre=$_POST['nombre'];
        $edad=$_POST['edad'];
        $fechaConsulta=$_POST['fecha_consulta'];
        $horaConsulta=$_POST['hora_consulta'];
        $tipoConsulta=$_POST['Tipo_consulta'];
        $correo=$_POST['correo'];
        $telefono=$_POST['telefono'];

        if(!empty($nombre))
        {
            $nombre=trim($nombre);
            $nombre=filter_var($nombre, FILTER_SANITIZE_STRING);
        }
        else
        {
            $errores .= 'Por favor ingresar su nombre. <br/>';
        }

        if(!empty($edad))
        {
            $edad=trim($edad);
            $edad=filter_var($edad, FILTER_SANITIZE_STRING);
        }
        else
        {
            $errores .= 'Por favor ingrese su edad. <br/>';
        }
        
        if(!empty($correo))
        {
            $correo =filter_var($correo, FILTER_SANITIZE_EMAIL);
            //VALIDAR QUE SEA CORREO
            $validaemail =filter_var($correo,FILTER_VALIDATE_EMAIL);
            if (!$validaemail)
            {
                $errores .= "Por favor ingresa un correo válido <br/>";
                echo'<br/>';
            }
        }
        else
        {
            $errores .= "Por favor ingresa un correo <br/>";
            echo'<br/>';
        }

        if(!$errores)
        {
            $enviar_a= 'Sergiobonilla@gmail.com';
            $asunto= 'Correo enviado desde mi pagina';
            $mensaje_listo= "De: $nombre \n";
            $mensaje_listo= "Correo:$correo \n";

            //mail($enviar_a,$asunto,$mensaje_listo);
            $enviado= 'true';
        }
    }
    require 'controlconsulta.php';
?>