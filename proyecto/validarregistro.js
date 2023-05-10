function validar() 
{
    nombre = document.getElementById("nombre").value;
    edad = document.getElementById("edad").value;
    correo = document.getElementById("correo").value;
    telefono = document.getElementById("telefono").value;
    fecha_consulta = document.getElementById("fecha_consulta");
    hora_consulta = document.getElementById("hora_consulta");
    tipo_consulta = document.getElementById("Tipo_consulta");
    efectivo = document.getElementById("efectivo");
    tarjeta = document.getElementById("tarjeta");
    sexmujer = document.getElementById("mujer");
    sexhombre = document.getElementById("hombre");

    if (nombre == "") 
    {
    alert("Por favor escriba su nombre completo");
    return false;
    }

    if (edad == "") 
    {
    alert("Por favor escriba su edad");
    return false;
    }

    if(correo=="")
    {
        alert("escribe un correo valido")
        return false
    }

    if (telefono == "") 
    {
    alert("Por favor ingrese un numero de telefono");
    return false;
    }

    if (sexmujer.checked == false && sexhombre.checked == false) 
    {
    alert("Seleccione su sexo biológico");
    return false;
    }

    if (tipo_consulta.value == 0) 
    {
    alert("Indique la especialidad de su consulta");
    return false;
    }
    
    if (fecha_consulta==0) 
    {
    alert("Proporcione la fecha a agendar");
    return false;
    }

    if (hora_consulta == false) 
    {
    alert("Proporcione la hora a agendar");
    return false;
    }

    if ((efectivo.checked = false && tarjeta.checked == false)) 
    {
    alert("Indique con qué método de pago cancelará");
    return false;
    } 
    else 
    {
    alert("Cita agendada con exito");
    }
}

