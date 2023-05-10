<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href=".//Estilo/estilo.css">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Control de consulta</title>
</head>

<body>
<div class="wrap">
    <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="post" class="formulario">
            <header>
                <h1><center>Bienvenidos a clinia</center></h1>
                <h1><center>"La Bendicion"</center></h1>
            </header>
            <br>
            <input type="text" name="nombre" placeholder="Ingrese su nombre completo" id="nombre">
            <br>
            <br>
            <input type="text" name="edad" placeholder="ingrese su edad" id="edad">
            <br>
            <br>
            <input type="text" placeholder="Ingrese su correo" name="correo" id="correo">
            <br>
            <br>
            <input type="text" placeholder="Ingrese su telefono" name="telefono" id="telefono">
            <br>
            <label for="genero">Genero:</label>
            <br>
            <br>
            <div class="radio">
                <input type="radio" name="sexo" id="hombre">
                <label for="hombre">Hombre</label>
                <input type="radio" name="sexo" id="mujer">
                <label for="mujer">Mujer</label>
            </div>
            <br>
            <label for="Tipo_consulta">Tipo de consulta</label>
            <select name="Tipo_consulta" id="Tipo_consulta">
            <option value="0">seleccione el tipo de consulta</option>
                <option value="general">Consulta General</option>
                <option value="pediatria">Pediatria</option>
                <option value="odontologia">Odontologia</option>
                <option value="ginecologia">Ginecologia</option>
                <option value="laboratorio">Laboratio</option>
            </select>
            <br>
            <br>
            <div class="datetime">
                <label for="fecha-horaConsulta">Fecha y hora de la consulta:</label>
                <input type="datetime-local" name="fecha-horaConsulta" id="fecha-horaConsulta">
            </div>
            <br>
            <br>
            <div class="checkbox">
                <input type="checkbox" name="efectivo" id="efectivo">
                <label  for="efectivo">Efectivo</label>
                <input type="checkbox" name="tarjeta" id="tarjeta">
                <label  for="tarjeta">Tarjeta</label>
            </div>
            <br>
            <input type="submit" name= "enviar" value="Agendar cita" onclick="return validar()" >
            <?php if(!empty($errores)):  ?>
                    <div class="alert error">
                        <?php echo $errores ?>
                    </div>
                <?php elseif ($enviado): ?>
                    <div class="alert success">
                        <p>Enviado Correctamente</p>
                    </div>
                <?php endif ?>
        </form>
</div>

    <script type="text/javascript" src="./validarregistro.js"></script>
    
</body>
</html>