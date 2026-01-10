-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Estructuras de Control"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Estructuras de Control"
-- NOTA: Reemplaza @CursoId con el ID real del curso "Estructuras de Control"
-- Puedes obtenerlo ejecutando: SELECT CursoId FROM Cursos WHERE Nombre = 'Estructuras de Control'

DECLARE @CursoId INT;
SELECT @CursoId = CursoId 
FROM Cursos 
WHERE Nombre = 'Estructuras de Control';

-- Verificar que el curso existe
IF @CursoId IS NULL
BEGIN
    PRINT 'ERROR: No se encontró el curso "Estructuras de Control"';
    PRINT 'Por favor, asegúrate de que el curso existe en la base de datos.';
    PRINT 'Puedes crearlo primero o usar el CursoId directamente en las inserciones.';
    RETURN;
END

PRINT 'Insertando lecciones para el curso "Estructuras de Control" (CursoId: ' + CAST(@CursoId AS VARCHAR) + ')';

-- ============================================
-- LECCIÓN 1: Introducción a Estructuras de Control
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Estructuras de Control',
    'Aprende qué son las estructuras de control y cómo permiten dirigir el flujo de ejecución de un programa.',
    'Las **estructuras de control** son elementos fundamentales en la programación que permiten controlar el flujo de ejecución de un programa. Determinan qué código se ejecuta, cuándo se ejecuta y cuántas veces se repite.

**Tipos de Estructuras de Control:**

1. **Estructuras Condicionales**: Permiten ejecutar código basado en condiciones
   - `if`, `if-else`, `if-else if`
   - `switch-case`

2. **Estructuras de Repetición (Bucles)**: Permiten ejecutar código múltiples veces
   - `for`
   - `while`
   - `do-while`
   - `foreach`

3. **Palabras Clave de Control**: Modifican el flujo dentro de bucles
   - `break`: Sale del bucle
   - `continue`: Salta a la siguiente iteración
   - `return`: Sale de la función

**Importancia:**
Sin estructuras de control, un programa ejecutaría todas sus instrucciones de forma secuencial, sin poder tomar decisiones ni repetir operaciones. Estas estructuras son esenciales para crear programas dinámicos y funcionales.',
    'using System;

class Program
{
    static void Main()
    {
        // Ejemplo básico de estructura condicional
        int edad = 20;
        
        if (edad >= 18)
        {
            Console.WriteLine("Es mayor de edad");
        }
        else
        {
            Console.WriteLine("Es menor de edad");
        }
        
        // Ejemplo básico de estructura de repetición
        Console.WriteLine("Contando del 1 al 5:");
        for (int i = 1; i <= 5; i++)
        {
            Console.WriteLine($"Número: {i}");
        }
        
        // Ejemplo de estructura condicional con múltiples condiciones
        int nota = 85;
        if (nota >= 90)
        {
            Console.WriteLine("Excelente");
        }
        else if (nota >= 70)
        {
            Console.WriteLine("Bueno");
        }
        else
        {
            Console.WriteLine("Necesita mejorar");
        }
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Estructura if-else
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Estructura if-else',
    'Domina la estructura condicional if-else para tomar decisiones en tu código.',
    'La estructura **if-else** es la forma más básica de control de flujo condicional en C#. Permite ejecutar diferentes bloques de código según si una condición es verdadera o falsa.

**Sintaxis básica:**

```csharp
if (condicion)
{
    // Código si la condición es true
}
else
{
    // Código si la condición es false
}
```

**Variantes:**

1. **if simple**: Solo ejecuta código si la condición es verdadera
2. **if-else**: Ejecuta un bloque u otro según la condición
3. **if-else if**: Permite múltiples condiciones
4. **if anidados**: if dentro de otro if

**Operadores útiles con if:**
- Operadores de comparación: `==`, `!=`, `>`, `<`, `>=`, `<=`
- Operadores lógicos: `&&` (AND), `||` (OR), `!` (NOT)

**Mejores prácticas:**
- Usa llaves `{}` siempre, incluso para una sola línea
- Mantén las condiciones simples y legibles
- Evita anidaciones excesivas (máximo 2-3 niveles)
- Usa nombres de variables descriptivos en las condiciones',
    'using System;

class Program
{
    static void Main()
    {
        // if simple
        int numero = 10;
        if (numero > 0)
        {
            Console.WriteLine("El número es positivo");
        }
        
        // if-else
        int edad = 17;
        if (edad >= 18)
        {
            Console.WriteLine("Puede votar");
        }
        else
        {
            Console.WriteLine("No puede votar");
        }
        
        // if-else if-else (múltiples condiciones)
        int temperatura = 25;
        if (temperatura > 30)
        {
            Console.WriteLine("Hace mucho calor");
        }
        else if (temperatura > 20)
        {
            Console.WriteLine("Temperatura agradable");
        }
        else if (temperatura > 10)
        {
            Console.WriteLine("Hace frío");
        }
        else
        {
            Console.WriteLine("Hace mucho frío");
        }
        
        // if anidados
        bool esEstudiante = true;
        int edadEstudiante = 20;
        
        if (esEstudiante)
        {
            if (edadEstudiante >= 18)
            {
                Console.WriteLine("Estudiante mayor de edad");
            }
            else
            {
                Console.WriteLine("Estudiante menor de edad");
            }
        }
        
        // Operadores lógicos en condiciones
        int puntuacion = 85;
        bool completado = true;
        
        if (puntuacion >= 80 && completado)
        {
            Console.WriteLine("¡Nivel completado exitosamente!");
        }
        
        // Operador ternario (forma abreviada de if-else)
        int a = 10;
        int b = 5;
        int mayor = a > b ? a : b;
        Console.WriteLine($"El mayor es: {mayor}");
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Estructura switch-case
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Estructura switch-case',
    'Aprende a usar switch-case para manejar múltiples casos de forma elegante y eficiente.',
    'La estructura **switch-case** es una alternativa más elegante al `if-else if` cuando necesitas comparar una variable con múltiples valores específicos.

**Sintaxis:**

```csharp
switch (variable)
{
    case valor1:
        // Código para valor1
        break;
    case valor2:
        // Código para valor2
        break;
    default:
        // Código si no coincide con ningún caso
        break;
}
```

**Características importantes:**

1. **break**: Es obligatorio en cada caso (excepto en switch expressions de C# 8+)
2. **default**: Caso opcional que se ejecuta si ningún caso coincide
3. **case múltiples**: Puedes agrupar varios valores en un mismo caso
4. **Tipos permitidos**: int, char, string, enum, bool

**Ventajas sobre if-else if:**
- Más legible cuando hay muchas condiciones
- Mejor rendimiento en algunos casos
- Más fácil de mantener

**Switch expressions (C# 8.0+):**
Permite una sintaxis más concisa y funcional para casos simples.',
    'using System;

class Program
{
    static void Main()
    {
        // Switch básico con números
        int diaSemana = 3;
        switch (diaSemana)
        {
            case 1:
                Console.WriteLine("Lunes");
                break;
            case 2:
                Console.WriteLine("Martes");
                break;
            case 3:
                Console.WriteLine("Miércoles");
                break;
            case 4:
                Console.WriteLine("Jueves");
                break;
            case 5:
                Console.WriteLine("Viernes");
                break;
            case 6:
            case 7:
                Console.WriteLine("Fin de semana");
                break;
            default:
                Console.WriteLine("Día inválido");
                break;
        }
        
        // Switch con strings
        string operacion = "suma";
        int a = 10, b = 5;
        
        switch (operacion)
        {
            case "suma":
                Console.WriteLine($"Resultado: {a + b}");
                break;
            case "resta":
                Console.WriteLine($"Resultado: {a - b}");
                break;
            case "multiplicacion":
                Console.WriteLine($"Resultado: {a * b}");
                break;
            case "division":
                if (b != 0)
                    Console.WriteLine($"Resultado: {a / b}");
                else
                    Console.WriteLine("No se puede dividir por cero");
                break;
            default:
                Console.WriteLine("Operación no válida");
                break;
        }
        
        // Switch con caracteres
        char calificacion = ''B'';
        switch (calificacion)
        {
            case ''A'':
            case ''a'':
                Console.WriteLine("Excelente");
                break;
            case ''B'':
            case ''b'':
                Console.WriteLine("Bueno");
                break;
            case ''C'':
            case ''c'':
                Console.WriteLine("Regular");
                break;
            default:
                Console.WriteLine("Calificación no válida");
                break;
        }
        
        // Switch expression (C# 8.0+)
        int mes = 2;
        string nombreMes = mes switch
        {
            1 => "Enero",
            2 => "Febrero",
            3 => "Marzo",
            4 => "Abril",
            5 => "Mayo",
            6 => "Junio",
            7 => "Julio",
            8 => "Agosto",
            9 => "Septiembre",
            10 => "Octubre",
            11 => "Noviembre",
            12 => "Diciembre",
            _ => "Mes inválido"
        };
        Console.WriteLine($"Mes: {nombreMes}");
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Bucle for
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Bucle for',
    'Domina el bucle for para repetir código un número específico de veces de forma controlada.',
    'El bucle **for** es una estructura de repetición que permite ejecutar un bloque de código un número específico de veces. Es ideal cuando conoces de antemano cuántas iteraciones necesitas.

**Sintaxis:**

```csharp
for (inicialización; condición; incremento)
{
    // Código a repetir
}
```

**Componentes del for:**

1. **Inicialización**: Se ejecuta una vez al inicio (ej: `int i = 0`)
2. **Condición**: Se evalúa antes de cada iteración (ej: `i < 10`)
3. **Incremento**: Se ejecuta después de cada iteración (ej: `i++`)

**Variantes:**

- **for tradicional**: `for (int i = 0; i < 10; i++)`
- **for con múltiples variables**: `for (int i = 0, j = 10; i < j; i++, j--)`
- **for sin inicialización**: `for (; i < 10; i++)`
- **for infinito**: `for (;;)`

**Casos de uso comunes:**
- Iterar sobre arrays y listas
- Contadores
- Generar secuencias numéricas
- Procesar elementos en orden',
    'using System;

class Program
{
    static void Main()
    {
        // for básico: contar del 1 al 10
        Console.WriteLine("Contando del 1 al 10:");
        for (int i = 1; i <= 10; i++)
        {
            Console.WriteLine($"Número: {i}");
        }
        
        // for con decremento: contar regresivamente
        Console.WriteLine("\nContando regresivamente del 10 al 1:");
        for (int i = 10; i >= 1; i--)
        {
            Console.WriteLine($"Número: {i}");
        }
        
        // for con incremento personalizado
        Console.WriteLine("\nNúmeros pares del 0 al 20:");
        for (int i = 0; i <= 20; i += 2)
        {
            Console.WriteLine($"Par: {i}");
        }
        
        // for anidado: tabla de multiplicar
        Console.WriteLine("\nTabla de multiplicar del 5:");
        for (int i = 1; i <= 10; i++)
        {
            int resultado = 5 * i;
            Console.WriteLine($"5 x {i} = {resultado}");
        }
        
        // for con múltiples variables
        Console.WriteLine("\nContadores simultáneos:");
        for (int i = 0, j = 10; i < j; i++, j--)
        {
            Console.WriteLine($"i = {i}, j = {j}");
        }
        
        // for para iterar sobre un array
        int[] numeros = { 10, 20, 30, 40, 50 };
        Console.WriteLine("\nElementos del array:");
        for (int i = 0; i < numeros.Length; i++)
        {
            Console.WriteLine($"Índice {i}: {numeros[i]}");
        }
        
        // for para sumar elementos
        int suma = 0;
        for (int i = 1; i <= 100; i++)
        {
            suma += i;
        }
        Console.WriteLine($"\nSuma de 1 a 100: {suma}");
        
        // for con break (salir del bucle)
        Console.WriteLine("\nBuscando el primer número divisible por 7:");
        for (int i = 1; i <= 50; i++)
        {
            if (i % 7 == 0)
            {
                Console.WriteLine($"Encontrado: {i}");
                break; // Sale del bucle
            }
        }
        
        // for con continue (saltar iteración)
        Console.WriteLine("\nNúmeros impares del 1 al 20:");
        for (int i = 1; i <= 20; i++)
        {
            if (i % 2 == 0)
            {
                continue; // Salta números pares
            }
            Console.WriteLine($"Impar: {i}");
        }
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Bucle while
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Bucle while',
    'Aprende a usar el bucle while para repetir código mientras se cumpla una condición.',
    'El bucle **while** ejecuta un bloque de código repetidamente mientras una condición sea verdadera. A diferencia del `for`, no tiene una estructura de inicialización e incremento integrada.

**Sintaxis:**

```csharp
while (condición)
{
    // Código a repetir
    // IMPORTANTE: Debes modificar la condición dentro del bucle
}
```

**Características:**

- La condición se evalúa **antes** de cada iteración
- Si la condición es `false` desde el inicio, el bucle no se ejecuta
- Debes asegurarte de modificar la condición dentro del bucle para evitar bucles infinitos
- Ideal cuando no sabes cuántas iteraciones necesitas

**Cuándo usar while:**
- Cuando el número de iteraciones es desconocido
- Validación de entrada del usuario
- Procesamiento hasta encontrar una condición
- Bucles controlados por eventos externos

**Precaución:**
- Siempre asegúrate de que la condición eventualmente se vuelva `false`
- Un bucle infinito puede congelar tu aplicación',
    'using System;

class Program
{
    static void Main()
    {
        // while básico: contar del 1 al 5
        Console.WriteLine("Contando del 1 al 5:");
        int contador = 1;
        while (contador <= 5)
        {
            Console.WriteLine($"Número: {contador}");
            contador++; // IMPORTANTE: modificar la variable
        }
        
        // while para sumar números hasta llegar a un límite
        int suma = 0;
        int numero = 1;
        while (suma < 100)
        {
            suma += numero;
            Console.WriteLine($"Sumando {numero}, total: {suma}");
            numero++;
        }
        Console.WriteLine($"Se necesitaron {numero - 1} números para llegar a 100");
        
        // while para encontrar un número
        int objetivo = 42;
        int actual = 1;
        Console.WriteLine($"\nBuscando el número {objetivo}:");
        while (actual != objetivo)
        {
            Console.WriteLine($"Probando: {actual}");
            actual++;
        }
        Console.WriteLine($"¡Encontrado! {objetivo}");
        
        // while con break
        int valor = 0;
        Console.WriteLine("\nContando hasta encontrar múltiplo de 7:");
        while (true) // Bucle aparentemente infinito
        {
            valor++;
            if (valor % 7 == 0)
            {
                Console.WriteLine($"Encontrado: {valor}");
                break; // Sale del bucle
            }
            if (valor > 50) // Prevención de bucle infinito
            {
                Console.WriteLine("No se encontró en el rango");
                break;
            }
        }
        
        // while con continue
        int i = 0;
        Console.WriteLine("\nNúmeros pares del 0 al 20:");
        while (i <= 20)
        {
            if (i % 2 != 0)
            {
                i++;
                continue; // Salta números impares
            }
            Console.WriteLine($"Par: {i}");
            i++;
        }
        
        // while para validar entrada (simulado)
        int entrada = 0;
        Console.WriteLine("\nSimulación de validación de entrada:");
        while (entrada < 1 || entrada > 10)
        {
            // En un programa real, aquí leerías del usuario
            entrada = 5; // Simulamos una entrada válida
            if (entrada < 1 || entrada > 10)
            {
                Console.WriteLine("Por favor, ingresa un número entre 1 y 10");
            }
        }
        Console.WriteLine($"Entrada válida: {entrada}");
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Bucle do-while
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Bucle do-while',
    'Domina el bucle do-while que garantiza al menos una ejecución del código.',
    'El bucle **do-while** es similar al `while`, pero con una diferencia clave: **siempre ejecuta el código al menos una vez**, ya que la condición se evalúa **después** de cada iteración.

**Sintaxis:**

```csharp
do
{
    // Código a repetir
} while (condición);
```

**Diferencia clave con while:**

- **while**: Evalúa la condición antes → puede no ejecutarse nunca
- **do-while**: Evalúa la condición después → siempre se ejecuta al menos una vez

**Cuándo usar do-while:**

- Menús interactivos que deben mostrarse al menos una vez
- Validación de entrada que requiere al menos un intento
- Procesamiento que debe ejecutarse antes de verificar la condición
- Juegos que necesitan al menos un turno

**Ventajas:**
- Garantiza la ejecución inicial
- Útil para interfaces de usuario
- Simplifica la lógica en algunos casos',
    'using System;

class Program
{
    static void Main()
    {
        // do-while básico
        Console.WriteLine("Contando del 1 al 5:");
        int contador = 1;
        do
        {
            Console.WriteLine($"Número: {contador}");
            contador++;
        } while (contador <= 5);
        
        // do-while: siempre se ejecuta al menos una vez
        int numero = 10;
        Console.WriteLine("\nEjemplo de do-while con condición falsa desde el inicio:");
        do
        {
            Console.WriteLine($"Este mensaje se muestra aunque la condición sea falsa: {numero}");
            numero++;
        } while (numero < 5); // Condición falsa, pero ya se ejecutó una vez
        
        // Comparación: while vs do-while
        Console.WriteLine("\nComparación while vs do-while:");
        
        // while: no se ejecuta si la condición es falsa
        int valor1 = 10;
        while (valor1 < 5)
        {
            Console.WriteLine("Este mensaje NO se muestra (while)");
            valor1++;
        }
        
        // do-while: se ejecuta al menos una vez
        int valor2 = 10;
        do
        {
            Console.WriteLine("Este mensaje SÍ se muestra (do-while)");
            valor2++;
        } while (valor2 < 5);
        
        // do-while para menú (simulado)
        int opcion = 0;
        Console.WriteLine("\nSimulación de menú:");
        do
        {
            Console.WriteLine("1. Opción 1");
            Console.WriteLine("2. Opción 2");
            Console.WriteLine("3. Salir");
            // En un programa real, aquí leerías la opción del usuario
            opcion = 3; // Simulamos seleccionar salir
            Console.WriteLine($"Opción seleccionada: {opcion}");
        } while (opcion != 3);
        Console.WriteLine("¡Hasta luego!");
        
        // do-while para validación de entrada
        int entrada = 0;
        Console.WriteLine("\nValidación de entrada (simulado):");
        do
        {
            // En un programa real, aquí leerías del usuario
            entrada = 15; // Simulamos una entrada inválida primero
            if (entrada < 1 || entrada > 10)
            {
                Console.WriteLine("Entrada inválida. Debe estar entre 1 y 10");
                entrada = 5; // Luego simulamos una entrada válida
            }
        } while (entrada < 1 || entrada > 10);
        Console.WriteLine($"Entrada válida aceptada: {entrada}");
        
        // do-while con break
        int i = 0;
        Console.WriteLine("\nBuscando número divisible por 13:");
        do
        {
            i++;
            if (i % 13 == 0)
            {
                Console.WriteLine($"Encontrado: {i}");
                break;
            }
        } while (i < 100);
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Bucle foreach
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Bucle foreach',
    'Aprende a usar foreach para iterar sobre colecciones de forma simple y elegante.',
    'El bucle **foreach** es una forma simplificada de iterar sobre colecciones (arrays, listas, etc.) sin necesidad de manejar índices manualmente. Es más legible y menos propenso a errores que un `for` tradicional.

**Sintaxis:**

```csharp
foreach (tipo elemento in coleccion)
{
    // Código usando elemento
}
```

**Ventajas:**

- **Más simple**: No necesitas manejar índices
- **Más seguro**: No hay riesgo de índices fuera de rango
- **Más legible**: El código es más claro sobre la intención
- **Menos errores**: Evita errores comunes con índices

**Cuándo usar foreach:**

- Iterar sobre arrays
- Iterar sobre listas (List<T>)
- Iterar sobre colecciones (IEnumerable)
- Cuando no necesitas modificar la colección durante la iteración
- Cuando no necesitas el índice

**Limitaciones:**

- No puedes modificar la colección durante la iteración
- No tienes acceso directo al índice (aunque puedes usar un contador)
- Solo funciona con colecciones que implementan IEnumerable',
    'using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // foreach con array de enteros
        int[] numeros = { 10, 20, 30, 40, 50 };
        Console.WriteLine("Elementos del array:");
        foreach (int numero in numeros)
        {
            Console.WriteLine($"Número: {numero}");
        }
        
        // foreach con array de strings
        string[] nombres = { "Ana", "Luis", "María", "Carlos" };
        Console.WriteLine("\nNombres:");
        foreach (string nombre in nombres)
        {
            Console.WriteLine($"- {nombre}");
        }
        
        // foreach para sumar elementos
        int[] valores = { 5, 10, 15, 20, 25 };
        int suma = 0;
        foreach (int valor in valores)
        {
            suma += valor;
        }
        Console.WriteLine($"\nSuma de valores: {suma}");
        
        // foreach con List
        List<string> frutas = new List<string> { "Manzana", "Banana", "Naranja" };
        Console.WriteLine("\nFrutas:");
        foreach (string fruta in frutas)
        {
            Console.WriteLine($"🍎 {fruta}");
        }
        
        // foreach para encontrar el máximo
        int[] numeros2 = { 45, 12, 78, 23, 56 };
        int maximo = int.MinValue;
        foreach (int num in numeros2)
        {
            if (num > maximo)
            {
                maximo = num;
            }
        }
        Console.WriteLine($"\nMáximo valor: {maximo}");
        
        // foreach con contador (usando Select con índice)
        string[] colores = { "Rojo", "Verde", "Azul", "Amarillo" };
        Console.WriteLine("\nColores con índice:");
        int indice = 0;
        foreach (string color in colores)
        {
            Console.WriteLine($"{indice}: {color}");
            indice++;
        }
        
        // foreach con break
        int[] numeros3 = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
        Console.WriteLine("\nBuscando el primer número mayor que 5:");
        foreach (int num in numeros3)
        {
            if (num > 5)
            {
                Console.WriteLine($"Encontrado: {num}");
                break;
            }
        }
        
        // foreach con continue
        int[] numeros4 = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
        Console.WriteLine("\nNúmeros pares:");
        foreach (int num in numeros4)
        {
            if (num % 2 != 0)
            {
                continue; // Salta números impares
            }
            Console.WriteLine($"Par: {num}");
        }
        
        // foreach con string (itera sobre caracteres)
        string texto = "Hola";
        Console.WriteLine("\nCaracteres del string:");
        foreach (char caracter in texto)
        {
            Console.WriteLine($"Carácter: {caracter}");
        }
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: break y continue
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'break y continue',
    'Aprende a controlar el flujo dentro de bucles usando break para salir y continue para saltar iteraciones.',
    'Las palabras clave **break** y **continue** permiten modificar el flujo de ejecución dentro de bucles, dándote más control sobre cuándo detener o saltar iteraciones.

**break:**
- **Propósito**: Sale inmediatamente del bucle actual
- **Uso**: Cuando encuentras lo que buscas o una condición de salida
- **Alcance**: Solo afecta al bucle más interno si hay bucles anidados

**continue:**
- **Propósito**: Salta el resto de la iteración actual y continúa con la siguiente
- **Uso**: Cuando quieres omitir ciertos elementos pero seguir iterando
- **Alcance**: Solo afecta al bucle más interno si hay bucles anidados

**Cuándo usar break:**
- Buscar un elemento y salir cuando lo encuentres
- Validar condiciones y salir si fallan
- Procesar hasta encontrar un límite
- Evitar procesamiento innecesario

**Cuándo usar continue:**
- Filtrar elementos que no cumplen cierta condición
- Omitir valores específicos (como 0, null, etc.)
- Optimizar procesamiento saltando casos no relevantes

**Mejores prácticas:**
- Usa `break` cuando ya no necesitas más iteraciones
- Usa `continue` cuando solo quieres saltar la iteración actual
- Evita usar `break` y `continue` excesivamente (puede hacer el código difícil de seguir)
- Considera refactorizar si necesitas muchos `break` o `continue`',
    'using System;

class Program
{
    static void Main()
    {
        // break: salir del bucle cuando encuentres algo
        Console.WriteLine("Buscando el primer número divisible por 7:");
        for (int i = 1; i <= 50; i++)
        {
            if (i % 7 == 0)
            {
                Console.WriteLine($"Encontrado: {i}");
                break; // Sale del bucle
            }
        }
        
        // break en while
        Console.WriteLine("\nContando hasta encontrar múltiplo de 11:");
        int numero = 1;
        while (numero <= 100)
        {
            if (numero % 11 == 0)
            {
                Console.WriteLine($"Encontrado: {numero}");
                break;
            }
            numero++;
        }
        
        // continue: saltar números pares
        Console.WriteLine("\nNúmeros impares del 1 al 20:");
        for (int i = 1; i <= 20; i++)
        {
            if (i % 2 == 0)
            {
                continue; // Salta números pares
            }
            Console.WriteLine($"Impar: {i}");
        }
        
        // continue: procesar solo números positivos
        int[] numeros = { -5, 10, -3, 20, -1, 15 };
        Console.WriteLine("\nSumando solo números positivos:");
        int suma = 0;
        foreach (int num in numeros)
        {
            if (num <= 0)
            {
                continue; // Salta números negativos o cero
            }
            suma += num;
            Console.WriteLine($"Agregando {num}, suma parcial: {suma}");
        }
        Console.WriteLine($"Suma total: {suma}");
        
        // break y continue juntos
        Console.WriteLine("\nBuscando números impares, pero parar en 25:");
        for (int i = 1; i <= 50; i++)
        {
            if (i > 25)
            {
                break; // Sale si supera 25
            }
            if (i % 2 == 0)
            {
                continue; // Salta números pares
            }
            Console.WriteLine($"Impar encontrado: {i}");
        }
        
        // break en bucle anidado (solo sale del bucle interno)
        Console.WriteLine("\nBuscando en matriz (break solo sale del bucle interno):");
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 5; j++)
            {
                if (j == 3)
                {
                    break; // Solo sale del bucle de j
                }
                Console.WriteLine($"i={i}, j={j}");
            }
        }
        
        // continue en bucle anidado
        Console.WriteLine("\nProcesando matriz (continue salta iteración interna):");
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 5; j++)
            {
                if (j == 2)
                {
                    continue; // Salta j=2
                }
                Console.WriteLine($"i={i}, j={j}");
            }
        }
        
        // break con etiqueta (no disponible en C#, usar goto o refactorizar)
        // Alternativa: usar una variable de control
        Console.WriteLine("\nBuscando en matriz con control de salida:");
        bool encontrado = false;
        for (int i = 0; i < 3 && !encontrado; i++)
        {
            for (int j = 0; j < 5 && !encontrado; j++)
            {
                if (i == 1 && j == 2)
                {
                    Console.WriteLine($"Encontrado en i={i}, j={j}");
                    encontrado = true;
                    break;
                }
            }
        }
    }
}',
    8,
    1
);

-- ============================================
-- LECCIÓN 9: Bucles Anidados
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Bucles Anidados',
    'Aprende a usar bucles dentro de otros bucles para trabajar con estructuras bidimensionales y problemas complejos.',
    'Los **bucles anidados** son bucles que se encuentran dentro de otros bucles. Son esenciales para trabajar con estructuras de datos bidimensionales como matrices, tablas y problemas que requieren combinaciones.

**Concepto:**
Un bucle anidado tiene un bucle externo y uno o más bucles internos. Por cada iteración del bucle externo, el bucle interno se ejecuta completamente.

**Casos de uso comunes:**
- Trabajar con matrices (arrays bidimensionales)
- Generar tablas de multiplicar
- Procesar datos en formato tabla
- Generar combinaciones
- Algoritmos de búsqueda en estructuras 2D

**Consideraciones de rendimiento:**
- Bucles anidados pueden ser costosos en términos de tiempo
- Un bucle anidado de O(n²) se ejecuta n² veces
- Considera optimizar si el rendimiento es crítico

**Mejores prácticas:**
- Usa nombres de variables descriptivos (i, j, k para índices)
- Limita la profundidad de anidación (máximo 2-3 niveles)
- Considera si realmente necesitas bucles anidados
- Documenta la lógica compleja',
    'using System;

class Program
{
    static void Main()
    {
        // Bucle anidado básico: tabla de multiplicar
        Console.WriteLine("Tabla de multiplicar del 1 al 5:");
        for (int i = 1; i <= 5; i++)
        {
            for (int j = 1; j <= 10; j++)
            {
                Console.WriteLine($"{i} x {j} = {i * j}");
            }
            Console.WriteLine(); // Línea en blanco entre tablas
        }
        
        // Matriz: array bidimensional
        int[,] matriz = new int[3, 4]
        {
            { 1, 2, 3, 4 },
            { 5, 6, 7, 8 },
            { 9, 10, 11, 12 }
        };
        
        Console.WriteLine("Elementos de la matriz:");
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                Console.Write($"{matriz[i, j],4} "); // Formato de 4 espacios
            }
            Console.WriteLine(); // Nueva línea después de cada fila
        }
        
        // Patrón de asteriscos
        Console.WriteLine("\nPatrón de asteriscos:");
        for (int i = 1; i <= 5; i++)
        {
            for (int j = 1; j <= i; j++)
            {
                Console.Write("*");
            }
            Console.WriteLine();
        }
        
        // Buscar en matriz
        int[,] numeros = new int[3, 3]
        {
            { 1, 2, 3 },
            { 4, 5, 6 },
            { 7, 8, 9 }
        };
        
        int objetivo = 5;
        bool encontrado = false;
        Console.WriteLine($"\nBuscando {objetivo} en la matriz:");
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                if (numeros[i, j] == objetivo)
                {
                    Console.WriteLine($"Encontrado en posición [{i}, {j}]");
                    encontrado = true;
                    break; // Sale del bucle interno
                }
            }
            if (encontrado) break; // Sale del bucle externo
        }
        
        // Suma de elementos de matriz
        int[,] valores = new int[2, 3]
        {
            { 10, 20, 30 },
            { 40, 50, 60 }
        };
        
        int suma = 0;
        Console.WriteLine("\nSumando elementos de la matriz:");
        for (int i = 0; i < 2; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                suma += valores[i, j];
                Console.WriteLine($"Agregando {valores[i, j]}, suma parcial: {suma}");
            }
        }
        Console.WriteLine($"Suma total: {suma}");
        
        // Tres bucles anidados (cubo)
        Console.WriteLine("\nCoordenadas de un cubo 2x2x2:");
        for (int x = 0; x < 2; x++)
        {
            for (int y = 0; y < 2; y++)
            {
                for (int z = 0; z < 2; z++)
                {
                    Console.WriteLine($"({x}, {y}, {z})");
                }
            }
        }
    }
}',
    9,
    1
);

-- ============================================
-- FIN DEL SCRIPT
-- ============================================
PRINT '¡Lecciones insertadas exitosamente!';
PRINT 'Total de lecciones insertadas: 9';
GO

