-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Operadores y Expresiones"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Operadores y Expresiones"
-- NOTA: Reemplaza @CursoId con el ID real del curso "Operadores y Expresiones"
-- Puedes obtenerlo ejecutando: SELECT CursoId FROM Cursos WHERE Nombre = 'Operadores y Expresiones'

DECLARE @CursoId INT;
SELECT @CursoId = CursoId 
FROM Cursos 
WHERE Nombre = 'Operadores y Expresiones';

-- Verificar que el curso existe
IF @CursoId IS NULL
BEGIN
    PRINT 'ERROR: No se encontró el curso "Operadores y Expresiones"';
    PRINT 'Por favor, asegúrate de que el curso existe en la base de datos.';
    PRINT 'Puedes crearlo primero o usar el CursoId directamente en las inserciones.';
    RETURN;
END

PRINT 'Insertando lecciones para el curso "Operadores y Expresiones" (CursoId: ' + CAST(@CursoId AS VARCHAR) + ')';

-- ============================================
-- LECCIÓN 1: Introducción a Operadores
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Operadores',
    'Aprende qué son los operadores en C# y cómo se utilizan para realizar operaciones con variables y valores.',
    'Los operadores en C# son símbolos especiales que permiten realizar operaciones sobre uno o más operandos (valores o variables). Son fundamentales para cualquier programa, ya que permiten realizar cálculos, comparaciones y asignaciones.

Los operadores en C# se clasifican en diferentes categorías según su función:
- Operadores aritméticos: para realizar operaciones matemáticas
- Operadores de comparación: para comparar valores
- Operadores lógicos: para operaciones booleanas
- Operadores de asignación: para asignar valores a variables
- Operadores de incremento/decremento: para modificar valores

Cada operador tiene una precedencia específica que determina el orden en que se evalúan las expresiones cuando hay múltiples operadores.',
    'using System;

class Program
{
    static void Main()
    {
        // Ejemplo básico de operadores
        int a = 10;
        int b = 5;
        
        // Operador de suma
        int suma = a + b;  // Resultado: 15
        
        // Operador de multiplicación
        int producto = a * b;  // Resultado: 50
        
        // Operador de comparación
        bool esMayor = a > b;  // Resultado: true
        
        Console.WriteLine($"Suma: {suma}");
        Console.WriteLine($"Producto: {producto}");
        Console.WriteLine($"¿a es mayor que b? {esMayor}");
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Operadores Aritméticos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Operadores Aritméticos',
    'Domina los operadores aritméticos básicos: suma, resta, multiplicación, división y módulo.',
    'Los operadores aritméticos en C# permiten realizar operaciones matemáticas básicas. Los operadores principales son:

**Operadores Aritméticos:**
- `+` (Suma): Suma dos valores
- `-` (Resta): Resta el segundo valor del primero
- `*` (Multiplicación): Multiplica dos valores
- `/` (División): Divide el primer valor entre el segundo
- `%` (Módulo): Devuelve el resto de la división

**Características importantes:**
- La división entre enteros devuelve un entero (se trunca la parte decimal)
- Para obtener decimales, al menos uno de los operandos debe ser decimal (float, double, decimal)
- El módulo es útil para determinar si un número es par o impar
- Los operadores aritméticos siguen las reglas matemáticas estándar de precedencia',
    'using System;

class Program
{
    static void Main()
    {
        int a = 15;
        int b = 4;
        
        // Suma
        int suma = a + b;  // 19
        Console.WriteLine($"Suma: {suma}");
        
        // Resta
        int resta = a - b;  // 11
        Console.WriteLine($"Resta: {resta}");
        
        // Multiplicación
        int multiplicacion = a * b;  // 60
        Console.WriteLine($"Multiplicación: {multiplicacion}");
        
        // División (entre enteros)
        int division = a / b;  // 3 (se trunca)
        Console.WriteLine($"División entera: {division}");
        
        // División con decimales
        double divisionDecimal = (double)a / b;  // 3.75
        Console.WriteLine($"División decimal: {divisionDecimal}");
        
        // Módulo (resto de la división)
        int modulo = a % b;  // 3 (15 / 4 = 3 con resto 3)
        Console.WriteLine($"Módulo: {modulo}");
        
        // Verificar si un número es par
        int numero = 8;
        if (numero % 2 == 0)
        {
            Console.WriteLine($"{numero} es par");
        }
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Operadores de Comparación
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Operadores de Comparación',
    'Aprende a comparar valores usando operadores de comparación que devuelven valores booleanos.',
    'Los operadores de comparación en C# permiten comparar dos valores y devuelven un resultado booleano (true o false). Son esenciales para tomar decisiones en el código.

**Operadores de Comparación:**
- `==` (Igual a): Verifica si dos valores son iguales
- `!=` (Diferente de): Verifica si dos valores son diferentes
- `>` (Mayor que): Verifica si el primer valor es mayor que el segundo
- `<` (Menor que): Verifica si el primer valor es menor que el segundo
- `>=` (Mayor o igual que): Verifica si el primer valor es mayor o igual al segundo
- `<=` (Menor o igual que): Verifica si el primer valor es menor o igual al segundo

**Puntos importantes:**
- Los operadores de comparación siempre devuelven un valor booleano
- Para comparar cadenas de texto, se compara el contenido, no la referencia
- Para tipos numéricos, la comparación es directa
- Ten cuidado con la comparación de números decimales debido a la precisión',
    'using System;

class Program
{
    static void Main()
    {
        int a = 10;
        int b = 5;
        int c = 10;
        
        // Igual a
        bool igual = a == c;  // true
        Console.WriteLine($"a == c: {igual}");
        
        // Diferente de
        bool diferente = a != b;  // true
        Console.WriteLine($"a != b: {diferente}");
        
        // Mayor que
        bool mayor = a > b;  // true
        Console.WriteLine($"a > b: {mayor}");
        
        // Menor que
        bool menor = b < a;  // true
        Console.WriteLine($"b < a: {menor}");
        
        // Mayor o igual que
        bool mayorIgual = a >= c;  // true
        Console.WriteLine($"a >= c: {mayorIgual}");
        
        // Menor o igual que
        bool menorIgual = b <= a;  // true
        Console.WriteLine($"b <= a: {menorIgual}");
        
        // Comparación de cadenas
        string texto1 = "Hola";
        string texto2 = "Hola";
        bool textosIguales = texto1 == texto2;  // true
        Console.WriteLine($"texto1 == texto2: {textosIguales}");
        
        // Uso en condicionales
        int edad = 18;
        if (edad >= 18)
        {
            Console.WriteLine("Es mayor de edad");
        }
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Operadores Lógicos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Operadores Lógicos',
    'Utiliza operadores lógicos para combinar condiciones y crear expresiones booleanas complejas.',
    'Los operadores lógicos en C# permiten combinar múltiples condiciones booleanas para crear expresiones más complejas. Son fundamentales para la lógica de control de flujo.

**Operadores Lógicos:**
- `&&` (AND lógico): Devuelve true si ambas condiciones son true
- `||` (OR lógico): Devuelve true si al menos una condición es true
- `!` (NOT lógico): Invierte el valor booleano

**Tabla de verdad:**
- `true && true` = true
- `true && false` = false
- `false && false` = false
- `true || true` = true
- `true || false` = true
- `false || false` = false
- `!true` = false
- `!false` = true

**Evaluación de cortocircuito:**
- Con `&&`, si la primera condición es false, no se evalúa la segunda
- Con `||`, si la primera condición es true, no se evalúa la segunda
- Esto mejora el rendimiento y permite evitar errores',
    'using System;

class Program
{
    static void Main()
    {
        int edad = 25;
        bool tieneLicencia = true;
        bool tieneSeguro = false;
        
        // Operador AND (&&)
        bool puedeConducir = edad >= 18 && tieneLicencia;
        Console.WriteLine($"¿Puede conducir? {puedeConducir}");  // true
        
        // Operador OR (||)
        bool puedeViajar = tieneLicencia || tieneSeguro;
        Console.WriteLine($"¿Puede viajar? {puedeViajar}");  // true
        
        // Operador NOT (!)
        bool noTieneSeguro = !tieneSeguro;
        Console.WriteLine($"¿No tiene seguro? {noTieneSeguro}");  // true
        
        // Combinación de operadores
        bool condicionCompleja = (edad >= 18 && tieneLicencia) || tieneSeguro;
        Console.WriteLine($"Condición compleja: {condicionCompleja}");
        
        // Evaluación de cortocircuito
        int x = 0;
        bool resultado = x != 0 && (10 / x > 5);  // No causa error de división
        Console.WriteLine($"Resultado con cortocircuito: {resultado}");
        
        // Uso práctico
        string nombre = "Juan";
        if (nombre != null && nombre.Length > 0)
        {
            Console.WriteLine($"Nombre válido: {nombre}");
        }
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Operadores de Asignación
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Operadores de Asignación',
    'Aprende a usar los operadores de asignación para modificar valores de variables de forma eficiente.',
    'Los operadores de asignación en C# permiten asignar valores a variables y realizar operaciones al mismo tiempo, haciendo el código más conciso y eficiente.

**Operadores de Asignación:**
- `=` (Asignación simple): Asigna un valor a una variable
- `+=` (Suma y asignación): Suma y asigna el resultado
- `-=` (Resta y asignación): Resta y asigna el resultado
- `*=` (Multiplicación y asignación): Multiplica y asigna el resultado
- `/=` (División y asignación): Divide y asigna el resultado
- `%=` (Módulo y asignación): Calcula el módulo y asigna el resultado

**Ventajas:**
- Código más corto y legible
- Evita repetir el nombre de la variable
- Mejora el rendimiento en algunos casos
- Especialmente útil en bucles y acumuladores',
    'using System;

class Program
{
    static void Main()
    {
        int numero = 10;
        
        // Asignación simple
        int a = 5;
        Console.WriteLine($"a = {a}");  // 5
        
        // Suma y asignación (equivalente a: a = a + 3)
        a += 3;
        Console.WriteLine($"a después de += 3: {a}");  // 8
        
        // Resta y asignación
        a -= 2;
        Console.WriteLine($"a después de -= 2: {a}");  // 6
        
        // Multiplicación y asignación
        a *= 2;
        Console.WriteLine($"a después de *= 2: {a}");  // 12
        
        // División y asignación
        a /= 3;
        Console.WriteLine($"a después de /= 3: {a}");  // 4
        
        // Módulo y asignación
        a %= 3;
        Console.WriteLine($"a después de %= 3: {a}");  // 1
        
        // Con cadenas de texto
        string mensaje = "Hola";
        mensaje += " Mundo";
        Console.WriteLine(mensaje);  // "Hola Mundo"
        
        // Uso en bucles
        int suma = 0;
        for (int i = 1; i <= 5; i++)
        {
            suma += i;  // Más eficiente que suma = suma + i
        }
        Console.WriteLine($"Suma de 1 a 5: {suma}");  // 15
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Operadores de Incremento y Decremento
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Operadores de Incremento y Decremento',
    'Domina los operadores ++ y -- para incrementar o decrementar valores en una unidad.',
    'Los operadores de incremento (`++`) y decremento (`--`) son operadores unarios que aumentan o disminuyen el valor de una variable en 1. Son muy comunes en bucles y contadores.

**Operadores:**
- `++` (Incremento): Aumenta el valor en 1
- `--` (Decremento): Disminuye el valor en 1

**Prefijo vs Sufijo:**
- **Prefijo** (`++x`): Incrementa primero, luego usa el valor
- **Sufijo** (`x++`): Usa el valor primero, luego incrementa

**Diferencia importante:**
Cuando se usa como parte de una expresión, la posición del operador afecta el resultado:
- `int y = ++x;` → x se incrementa primero, luego se asigna a y
- `int y = x++;` → x se asigna a y primero, luego x se incrementa

**Uso común:**
- En bucles for: `for (int i = 0; i < 10; i++)`
- En contadores: `contador++`
- En iteradores: `indice++`',
    'using System;

class Program
{
    static void Main()
    {
        // Incremento prefijo
        int a = 5;
        int b = ++a;  // a se incrementa primero (a = 6), luego se asigna a b
        Console.WriteLine($"a = {a}, b = {b}");  // a = 6, b = 6
        
        // Incremento sufijo
        int c = 5;
        int d = c++;  // c se asigna a d primero (d = 5), luego c se incrementa
        Console.WriteLine($"c = {c}, d = {d}");  // c = 6, d = 5
        
        // Decremento prefijo
        int e = 10;
        int f = --e;  // e se decrementa primero (e = 9), luego se asigna a f
        Console.WriteLine($"e = {e}, f = {f}");  // e = 9, f = 9
        
        // Decremento sufijo
        int g = 10;
        int h = g--;  // g se asigna a h primero (h = 10), luego g se decrementa
        Console.WriteLine($"g = {g}, h = {h}");  // g = 9, h = 10
        
        // Uso en bucles
        Console.WriteLine("Contador del 1 al 5:");
        for (int i = 1; i <= 5; i++)
        {
            Console.WriteLine($"Iteración {i}");
        }
        
        // Contador regresivo
        Console.WriteLine("Contador regresivo del 5 al 1:");
        for (int j = 5; j >= 1; j--)
        {
            Console.WriteLine($"Iteración {j}");
        }
        
        // Acumulador
        int suma = 0;
        for (int k = 0; k < 5; k++)
        {
            suma += k;
            Console.WriteLine($"k = {k}, suma = {suma}");
        }
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Precedencia de Operadores
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Precedencia de Operadores',
    'Comprende el orden en que se evalúan los operadores en una expresión y cómo usar paréntesis para controlarlo.',
    'La precedencia de operadores determina el orden en que se evalúan los operadores en una expresión cuando hay múltiples operadores presentes. Es crucial entender esto para escribir código correcto.

**Orden de Precedencia (de mayor a menor):**
1. Paréntesis `()`
2. Incremento/Decremento `++`, `--`
3. Multiplicación, División, Módulo `*`, `/`, `%`
4. Suma, Resta `+`, `-`
5. Comparación `<`, `>`, `<=`, `>=`
6. Igualdad `==`, `!=`
7. AND lógico `&&`
8. OR lógico `||`
9. Asignación `=`, `+=`, `-=`, etc.

**Reglas importantes:**
- Los operadores con mayor precedencia se evalúan primero
- Los operadores con la misma precedencia se evalúan de izquierda a derecha
- Los paréntesis tienen la mayor precedencia y pueden cambiar el orden de evaluación
- Siempre usa paréntesis cuando tengas dudas sobre el orden de evaluación

**Consejos:**
- Usa paréntesis para hacer el código más legible, incluso cuando no sean estrictamente necesarios
- Evita expresiones demasiado complejas; divídelas en múltiples líneas si es necesario',
    'using System;

class Program
{
    static void Main()
    {
        // Ejemplo 1: Precedencia aritmética
        int resultado1 = 2 + 3 * 4;  // 2 + 12 = 14 (no 20)
        Console.WriteLine($"2 + 3 * 4 = {resultado1}");
        
        // Con paréntesis
        int resultado2 = (2 + 3) * 4;  // 5 * 4 = 20
        Console.WriteLine($"(2 + 3) * 4 = {resultado2}");
        
        // Ejemplo 2: Precedencia de operadores lógicos
        bool a = true;
        bool b = false;
        bool c = true;
        
        bool resultado3 = a || b && c;  // true || (false && true) = true
        Console.WriteLine($"a || b && c = {resultado3}");
        
        // Con paréntesis explícitos
        bool resultado4 = (a || b) && c;  // (true || false) && true = true
        Console.WriteLine($"(a || b) && c = {resultado4}");
        
        // Ejemplo 3: Expresión compleja
        int x = 5;
        int y = 10;
        int z = 3;
        
        // Sin paréntesis (confuso)
        bool resultado5 = x + y > z * 2 && y - x < z;
        Console.WriteLine($"x + y > z * 2 && y - x < z = {resultado5}");
        
        // Con paréntesis (claro)
        bool resultado6 = ((x + y) > (z * 2)) && ((y - x) < z);
        Console.WriteLine($"((x + y) > (z * 2)) && ((y - x) < z) = {resultado6}");
        
        // Ejemplo 4: Asignación con operaciones
        int numero = 10;
        numero = numero * 2 + 5;  // (10 * 2) + 5 = 25
        Console.WriteLine($"numero = {numero}");
        
        // Ejemplo 5: Expresión con múltiples operadores
        int a1 = 2, b1 = 3, c1 = 4;
        int resultado7 = a1 + b1 * c1 / 2 - 1;  // 2 + (3 * 4 / 2) - 1 = 2 + 6 - 1 = 7
        Console.WriteLine($"a1 + b1 * c1 / 2 - 1 = {resultado7}");
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Expresiones y Evaluación
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Expresiones y Evaluación',
    'Aprende cómo C# evalúa las expresiones y cómo construir expresiones complejas de manera efectiva.',
    'Una expresión en C# es una combinación de valores, variables, operadores y llamadas a métodos que se evalúa para producir un resultado. Entender cómo se evalúan las expresiones es fundamental para escribir código correcto.

**Componentes de una Expresión:**
- **Operandos**: Valores o variables sobre los que se opera
- **Operadores**: Símbolos que especifican la operación
- **Resultado**: El valor producido por la evaluación

**Tipos de Expresiones:**
1. **Expresiones Aritméticas**: Producen valores numéricos
2. **Expresiones Booleanas**: Producen valores true o false
3. **Expresiones de Asignación**: Asignan valores a variables
4. **Expresiones de Comparación**: Comparan valores

**Evaluación de Expresiones:**
- Las expresiones se evalúan de izquierda a derecha
- La precedencia de operadores determina el orden
- Los paréntesis pueden cambiar el orden de evaluación
- Algunos operadores tienen evaluación de cortocircuito

**Mejores Prácticas:**
- Divide expresiones complejas en múltiples pasos
- Usa paréntesis para claridad, incluso cuando no sean necesarios
- Evita efectos secundarios en expresiones
- Documenta expresiones complejas con comentarios',
    'using System;

class Program
{
    static void Main()
    {
        // Expresión aritmética simple
        int resultado1 = 10 + 5 * 2;
        Console.WriteLine($"10 + 5 * 2 = {resultado1}");
        
        // Expresión booleana
        int edad = 20;
        bool esMayor = edad >= 18 && edad < 65;
        Console.WriteLine($"¿Es mayor de edad y menor de 65? {esMayor}");
        
        // Expresión de asignación
        int x = 5;
        int y = 10;
        int z = x + y * 2;  // z = 5 + 20 = 25
        Console.WriteLine($"z = {z}");
        
        // Expresión compleja dividida en pasos
        int a = 10;
        int b = 5;
        int c = 3;
        
        // Forma compleja (menos legible)
        int resultado2 = a + b * c - a / b + c;
        Console.WriteLine($"Resultado complejo: {resultado2}");
        
        // Forma clara (más legible)
        int multiplicacion = b * c;
        int division = a / b;
        int resultado3 = a + multiplicacion - division + c;
        Console.WriteLine($"Resultado claro: {resultado3}");
        
        // Expresión con evaluación de cortocircuito
        string texto = null;
        bool resultado4 = texto != null && texto.Length > 0;
        Console.WriteLine($"Resultado con cortocircuito: {resultado4}");
        
        // Expresión en condicional
        int numero = 15;
        if (numero > 10 && numero < 20)
        {
            Console.WriteLine($"{numero} está entre 10 y 20");
        }
        
        // Expresión con operador ternario
        int valor = 7;
        string mensaje = valor > 5 ? "Mayor que 5" : "Menor o igual a 5";
        Console.WriteLine(mensaje);
        
        // Expresión anidada
        int resultado5 = (2 + 3) * (4 - 1) / 3;
        Console.WriteLine($"(2 + 3) * (4 - 1) / 3 = {resultado5}");
    }
}',
    8,
    1
);

-- ============================================
-- FIN DEL SCRIPT
-- ============================================
PRINT '¡Lecciones insertadas exitosamente!';
PRINT 'Total de lecciones insertadas: 8';
GO

