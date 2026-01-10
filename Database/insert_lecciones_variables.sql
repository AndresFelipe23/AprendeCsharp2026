-- ============================================
-- INSERTAR LECCIONES PARA "VARIABLES Y TIPOS DE DATOS"
-- CursoId = 1 (Variables y Tipos de Datos)
-- ============================================

USE LenguajeCsharp
GO

-- Verificar que el Curso 1 existe
IF NOT EXISTS (SELECT 1 FROM Cursos WHERE CursoId = 1)
BEGIN
    PRINT 'ERROR: El Curso con ID 1 no existe. Por favor ejecuta primero insert_cursos_fundamentos.sql';
    RETURN;
END
GO

-- Lección 1: ¿Qué es una variable?
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo) VALUES
(1, 
'¿Qué es una variable?', 
'Introducción al concepto de variable en programación',
'Una variable es un espacio en memoria donde puedes almacenar un valor. Piensa en ella como una caja con un nombre donde guardas información que puedes usar más tarde en tu programa.

En C#, antes de usar una variable, debes declararla especificando su tipo de dato. Esto le dice a la computadora qué tipo de información vas a almacenar.',
'int edad = 25;
string nombre = "María";
double precio = 99.99;',
1, 
1);
GO

-- Lección 2: Tipos de datos numéricos enteros
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo) VALUES
(1, 
'Tipos de datos numéricos enteros', 
'Aprende sobre int, long, byte y otros tipos para números enteros',
'C# ofrece varios tipos para almacenar números enteros, cada uno con un rango diferente:

- byte: números de 0 a 255 (8 bits)
- short: números de -32,768 a 32,767 (16 bits)
- int: números de -2,147,483,648 a 2,147,483,647 (32 bits) - el más común
- long: números muy grandes (64 bits)

El tipo int es el más utilizado para números enteros en la mayoría de situaciones.',
'byte edad = 25;
int cantidad = 1000;
long numeroGrande = 9999999999L;',
2, 
1);
GO

-- Lección 3: Tipos de datos numéricos decimales
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo) VALUES
(1, 
'Tipos de datos numéricos decimales', 
'Aprende sobre float, double y decimal para números con decimales',
'Para números con parte decimal, C# ofrece tres opciones principales:

- float: precisión simple (7 dígitos, usa la letra f al final)
- double: precisión doble (15-16 dígitos) - el más común
- decimal: alta precisión (28-29 dígitos) - ideal para dinero y cálculos financieros

El tipo double es el más usado para números decimales en general, mientras que decimal es preferido para cálculos monetarios.',
'float altura = 1.75f;
double temperatura = 36.5;
decimal precio = 19.99m;',
3, 
1);
GO

-- Lección 4: Tipos de datos de texto
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo) VALUES
(1, 
'Tipos de datos de texto', 
'Aprende sobre string y char para trabajar con texto',
'Para almacenar texto en C#, usamos principalmente dos tipos:

- char: almacena un solo carácter (letra, número o símbolo)
- string: almacena una secuencia de caracteres (texto completo)

El tipo string es el más común y se usa para nombres, mensajes, direcciones, etc. Los strings se escriben entre comillas dobles.

El tipo char almacena un solo carácter y se escribe entre comillas simples.',
'char letra = ''A'';
char numero = ''5'';
string nombre = "Juan";
string mensaje = "Hola, bienvenido a C#";',
4, 
1);
GO

-- Lección 5: Tipo bool y valores nulos
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo) VALUES
(1, 
'Tipo bool y valores nulos', 
'Aprende sobre booleanos y cómo manejar valores nulos',
'El tipo bool almacena solo dos valores: true (verdadero) o false (falso). Es muy útil para tomar decisiones en tu programa.

En C#, también puedes usar tipos que permiten valores nulos agregando ? después del tipo. Esto es útil cuando una variable puede no tener un valor asignado todavía.',
'bool esMayorDeEdad = true;
bool tieneLicencia = false;

// Tipos que permiten valores nulos
int? edad = null;
string? apellido = null;
bool? esActivo = null;',
5, 
1);
GO

-- Lección 6: Declaración e inicialización de variables
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo) VALUES
(1, 
'Declaración e inicialización de variables', 
'Aprende las diferentes formas de declarar e inicializar variables',
'En C# puedes declarar una variable de varias formas:

1. Declaración e inicialización en una línea (recomendado)
2. Declaración primero, inicialización después
3. Declaración múltiple del mismo tipo

También puedes usar var para que C# infiera automáticamente el tipo basándose en el valor asignado.',
'// Forma 1: Declaración e inicialización
int edad = 25;
string nombre = "Ana";

// Forma 2: Declaración separada
int cantidad;
cantidad = 10;

// Forma 3: Múltiples variables
int x = 1, y = 2, z = 3;

// Usando var (inferencia de tipo)
var precio = 99.99; // C# infiere que es double
var activo = true;   // C# infiere que es bool',
6, 
1);
GO

-- Lección 7: Constantes y readonly
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo) VALUES
(1, 
'Constantes y readonly', 
'Aprende a usar const y readonly para valores que no cambian',
'A veces necesitas valores que no deben cambiar durante la ejecución del programa. C# ofrece dos opciones:

- const: valor constante que se debe asignar al declarar y nunca puede cambiar
- readonly: valor que se asigna una vez (en la declaración o en el constructor) y luego no puede cambiar

Las constantes son útiles para valores como PI, días de la semana, etc.',
'// Constantes
const double PI = 3.14159;
const int DIAS_SEMANA = 7;
const string IDIOMA = "español";

// Readonly (se usa principalmente en clases)
readonly int MAX_INTENTOS = 3;
readonly string VERSION = "1.0";',
7, 
1);
GO

-- Verificar las lecciones insertadas
SELECT 
    l.LeccionId,
    l.Titulo,
    l.DescripcionCorta,
    l.Orden,
    l.Activo,
    c.Nombre AS CursoNombre
FROM Lecciones l
INNER JOIN Cursos c ON l.CursoId = c.CursoId
WHERE l.CursoId = 1
ORDER BY l.Orden;
GO

