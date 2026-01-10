-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Métodos y Funciones"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Métodos y Funciones"
-- NOTA: Reemplaza @CursoId con el ID real del curso "Métodos y Funciones"
-- Puedes obtenerlo ejecutando: SELECT CursoId FROM Cursos WHERE Nombre = 'Métodos y Funciones'

DECLARE @CursoId INT;
SELECT @CursoId = CursoId 
FROM Cursos 
WHERE Nombre = 'Métodos y Funciones';

-- Verificar que el curso existe
IF @CursoId IS NULL
BEGIN
    PRINT 'ERROR: No se encontró el curso "Métodos y Funciones"';
    PRINT 'Por favor, asegúrate de que el curso existe en la base de datos.';
    PRINT 'Puedes crearlo primero o usar el CursoId directamente en las inserciones.';
    RETURN;
END

PRINT 'Insertando lecciones para el curso "Métodos y Funciones" (CursoId: ' + CAST(@CursoId AS VARCHAR) + ')';

-- ============================================
-- LECCIÓN 1: Introducción a Métodos y Funciones
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Métodos y Funciones',
    'Aprende qué son los métodos y funciones, y por qué son fundamentales para organizar y reutilizar código.',
    'Los **métodos** (también llamados funciones) son bloques de código que realizan una tarea específica y pueden ser llamados desde otras partes del programa. Son fundamentales para la programación modular y la reutilización de código.

**¿Qué es un método?**

Un método es un conjunto de instrucciones agrupadas que:
- Tiene un nombre único
- Puede recibir parámetros (datos de entrada)
- Puede devolver un valor (resultado)
- Puede ser llamado múltiples veces desde diferentes lugares

**Ventajas de usar métodos:**

1. **Reutilización**: Escribe el código una vez, úsalo muchas veces
2. **Organización**: Divide el programa en partes lógicas y manejables
3. **Mantenimiento**: Facilita la corrección y actualización del código
4. **Legibilidad**: Hace el código más fácil de entender
5. **Pruebas**: Permite probar partes del código de forma independiente

**Componentes de un método:**

- **Nombre**: Identificador único del método
- **Parámetros**: Datos que recibe el método (opcional)
- **Tipo de retorno**: Tipo de dato que devuelve (void si no devuelve nada)
- **Cuerpo**: Código que ejecuta el método

**Sintaxis básica:**

```csharp
tipoRetorno NombreMetodo(tipoParametro1 parametro1, tipoParametro2 parametro2)
{
    // Código del método
    return valor; // Si devuelve algo
}
```',
    'using System;

class Program
{
    // Método sin parámetros ni retorno
    static void Saludar()
    {
        Console.WriteLine("¡Hola desde el método!");
    }
    
    // Método con parámetros
    static void SaludarPersona(string nombre)
    {
        Console.WriteLine($"¡Hola, {nombre}!");
    }
    
    // Método que devuelve un valor
    static int Sumar(int a, int b)
    {
        return a + b;
    }
    
    // Método con múltiples parámetros
    static void MostrarInformacion(string nombre, int edad, string ciudad)
    {
        Console.WriteLine($"Nombre: {nombre}");
        Console.WriteLine($"Edad: {edad}");
        Console.WriteLine($"Ciudad: {ciudad}");
    }
    
    static void Main()
    {
        // Llamar a un método sin parámetros
        Console.WriteLine("Llamando a Saludar():");
        Saludar();
        
        // Llamar a un método con parámetros
        Console.WriteLine("\nLlamando a SaludarPersona():");
        SaludarPersona("Juan");
        SaludarPersona("María");
        
        // Llamar a un método que devuelve un valor
        Console.WriteLine("\nLlamando a Sumar():");
        int resultado = Sumar(5, 3);
        Console.WriteLine($"5 + 3 = {resultado}");
        
        // Usar el resultado directamente
        Console.WriteLine($"10 + 20 = {Sumar(10, 20)}");
        
        // Llamar a un método con múltiples parámetros
        Console.WriteLine("\nLlamando a MostrarInformacion():");
        MostrarInformacion("Ana", 25, "Madrid");
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Métodos con Parámetros
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos con Parámetros',
    'Domina el uso de parámetros para pasar datos a los métodos y hacerlos más flexibles y reutilizables.',
    'Los **parámetros** permiten que los métodos reciban datos externos, haciéndolos más flexibles y reutilizables. Un método puede tener cero, uno o múltiples parámetros.

**Tipos de parámetros:**

1. **Parámetros por valor**: Se pasa una copia del valor
2. **Parámetros por referencia**: Se pasa la referencia a la variable original
3. **Parámetros opcionales**: Tienen un valor por defecto
4. **Parámetros nombrados**: Se especifican por nombre al llamar

**Sintaxis:**

```csharp
void Metodo(tipoParametro nombreParametro)
{
    // Usar nombreParametro
}
```

**Parámetros múltiples:**

```csharp
int Sumar(int a, int b, int c)
{
    return a + b + c;
}
```

**Parámetros opcionales:**

```csharp
void Saludar(string nombre, string saludo = "Hola")
{
    Console.WriteLine($"{saludo}, {nombre}!");
}
```

**Parámetros por referencia:**

- `ref`: La variable debe estar inicializada
- `out`: La variable no necesita estar inicializada, pero el método debe asignarle un valor
- `in`: Solo lectura (C# 7.2+)',
    'using System;

class Program
{
    // Método con un parámetro
    static void MostrarNumero(int numero)
    {
        Console.WriteLine($"El número es: {numero}");
    }
    
    // Método con múltiples parámetros
    static int CalcularArea(int ancho, int alto)
    {
        return ancho * alto;
    }
    
    // Método con parámetros de diferentes tipos
    static void CrearPerfil(string nombre, int edad, double altura, bool activo)
    {
        Console.WriteLine($"Nombre: {nombre}");
        Console.WriteLine($"Edad: {edad}");
        Console.WriteLine($"Altura: {altura} m");
        Console.WriteLine($"Activo: {activo}");
    }
    
    // Método con parámetros opcionales
    static void Saludar(string nombre, string saludo = "Hola", int veces = 1)
    {
        for (int i = 0; i < veces; i++)
        {
            Console.WriteLine($"{saludo}, {nombre}!");
        }
    }
    
    // Método con parámetro por referencia (ref)
    static void Incrementar(ref int numero)
    {
        numero++; // Modifica la variable original
    }
    
    // Método con parámetro de salida (out)
    static bool Dividir(int dividendo, int divisor, out int resultado, out int resto)
    {
        if (divisor == 0)
        {
            resultado = 0;
            resto = 0;
            return false; // División inválida
        }
        resultado = dividendo / divisor;
        resto = dividendo % divisor;
        return true; // División exitosa
    }
    
    static void Main()
    {
        // Llamar con un parámetro
        MostrarNumero(42);
        MostrarNumero(100);
        
        // Llamar con múltiples parámetros
        int area = CalcularArea(5, 10);
        Console.WriteLine($"Área de 5x10: {area}");
        
        // Llamar con parámetros de diferentes tipos
        CrearPerfil("Luis", 30, 1.75, true);
        
        // Llamar con parámetros opcionales (usando valores por defecto)
        Console.WriteLine("\nSaludar con valores por defecto:");
        Saludar("Juan");
        
        // Llamar con parámetros opcionales (especificando algunos)
        Console.WriteLine("\nSaludar especificando saludo:");
        Saludar("María", "Buenos días");
        
        // Llamar con todos los parámetros
        Console.WriteLine("\nSaludar 3 veces:");
        Saludar("Pedro", "¡Hola!", 3);
        
        // Usar parámetro por referencia (ref)
        int valor = 10;
        Console.WriteLine($"\nValor antes: {valor}");
        Incrementar(ref valor);
        Console.WriteLine($"Valor después: {valor}"); // Ahora es 11
        
        // Usar parámetro de salida (out)
        int resultado, resto;
        if (Dividir(17, 5, out resultado, out resto))
        {
            Console.WriteLine($"\n17 / 5 = {resultado} con resto {resto}");
        }
        
        // Parámetros nombrados (C# 4.0+)
        Console.WriteLine("\nUsando parámetros nombrados:");
        CrearPerfil(nombre: "Ana", altura: 1.65, edad: 28, activo: true);
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Métodos que Devuelven Valores
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos que Devuelven Valores',
    'Aprende a crear métodos que devuelven valores usando la palabra clave return.',
    'Los métodos pueden **devolver valores** usando la palabra clave `return`. Esto permite que el método calcule un resultado y lo pase de vuelta al código que lo llamó.

**Sintaxis:**

```csharp
tipoRetorno NombreMetodo()
{
    // Código
    return valor; // Debe ser del tipo tipoRetorno
}
```

**Tipos de retorno:**

- **Tipos primitivos**: `int`, `double`, `bool`, `string`, `char`, etc.
- **Tipos personalizados**: Clases, estructuras, enums
- **void**: No devuelve nada (métodos que solo realizan acciones)

**Palabra clave return:**

- `return valor;` - Devuelve un valor y termina el método
- `return;` - Solo termina el método (en métodos void)
- Puede haber múltiples `return` en un método (uno por cada camino de ejecución)

**Métodos que devuelven múltiples valores:**

En C#, puedes usar:
- `out` parameters
- `ref` parameters
- Tuplas (C# 7.0+)
- Clases o estructuras personalizadas

**Mejores prácticas:**

- Un método debe tener una responsabilidad clara
- El nombre del método debe indicar qué devuelve
- Evita métodos que hacen demasiadas cosas
- Usa tipos de retorno descriptivos',
    'using System;

class Program
{
    // Método que devuelve un int
    static int ObtenerNumero()
    {
        return 42;
    }
    
    // Método que devuelve un double
    static double CalcularPromedio(double a, double b, double c)
    {
        return (a + b + c) / 3.0;
    }
    
    // Método que devuelve un bool
    static bool EsMayorDeEdad(int edad)
    {
        return edad >= 18;
    }
    
    // Método que devuelve un string
    static string ObtenerSaludo(string nombre)
    {
        return $"¡Hola, {nombre}!";
    }
    
    // Método con múltiples return
    static string EvaluarNota(int nota)
    {
        if (nota >= 90)
            return "Excelente";
        else if (nota >= 70)
            return "Bueno";
        else if (nota >= 50)
            return "Regular";
        else
            return "Necesita mejorar";
    }
    
    // Método que devuelve un array
    static int[] GenerarNumeros(int cantidad)
    {
        int[] numeros = new int[cantidad];
        for (int i = 0; i < cantidad; i++)
        {
            numeros[i] = i + 1;
        }
        return numeros;
    }
    
    // Método que devuelve múltiples valores usando tupla (C# 7.0+)
    static (int suma, int producto) CalcularSumaYProducto(int a, int b)
    {
        return (a + b, a * b);
    }
    
    // Método que devuelve null (tipo nullable)
    static string? BuscarNombre(int id)
    {
        if (id == 1)
            return "Juan";
        else if (id == 2)
            return "María";
        else
            return null; // No encontrado
    }
    
    static void Main()
    {
        // Usar método que devuelve int
        int numero = ObtenerNumero();
        Console.WriteLine($"Número obtenido: {numero}");
        
        // Usar método que devuelve double
        double promedio = CalcularPromedio(85, 90, 88);
        Console.WriteLine($"Promedio: {promedio:F2}");
        
        // Usar método que devuelve bool
        int edad = 20;
        if (EsMayorDeEdad(edad))
        {
            Console.WriteLine("Es mayor de edad");
        }
        
        // Usar método que devuelve string
        string saludo = ObtenerSaludo("Ana");
        Console.WriteLine(saludo);
        
        // Usar método con múltiples return
        Console.WriteLine($"Nota 85: {EvaluarNota(85)}");
        Console.WriteLine($"Nota 60: {EvaluarNota(60)}");
        
        // Usar método que devuelve array
        int[] numeros = GenerarNumeros(5);
        Console.WriteLine("Números generados:");
        foreach (int n in numeros)
        {
            Console.WriteLine(n);
        }
        
        // Usar método que devuelve tupla
        var resultado = CalcularSumaYProducto(5, 3);
        Console.WriteLine($"Suma: {resultado.suma}, Producto: {resultado.producto}");
        
        // Usar método que puede devolver null
        string? nombre = BuscarNombre(1);
        if (nombre != null)
        {
            Console.WriteLine($"Nombre encontrado: {nombre}");
        }
        else
        {
            Console.WriteLine("Nombre no encontrado");
        }
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Métodos Estáticos vs Métodos de Instancia
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos Estáticos vs Métodos de Instancia',
    'Comprende la diferencia entre métodos estáticos y métodos de instancia, y cuándo usar cada uno.',
    'En C#, existen dos tipos principales de métodos: **métodos estáticos** y **métodos de instancia**. Entender la diferencia es crucial para escribir código correcto.

**Métodos Estáticos:**

- Se declaran con la palabra clave `static`
- Pertenecen a la clase, no a una instancia específica
- Se llaman usando el nombre de la clase: `Clase.Metodo()`
- No pueden acceder a miembros de instancia (campos, propiedades, métodos no estáticos)
- Útiles para funciones de utilidad que no necesitan estado

**Métodos de Instancia:**

- No tienen la palabra clave `static`
- Pertenecen a una instancia específica de la clase
- Se llaman usando una instancia: `objeto.Metodo()`
- Pueden acceder a todos los miembros de la clase (estáticos y de instancia)
- Útiles cuando el método necesita trabajar con el estado del objeto

**Cuándo usar cada uno:**

- **Métodos estáticos**: Funciones de utilidad, cálculos matemáticos, métodos helper
- **Métodos de instancia**: Operaciones que modifican o usan el estado del objeto

**Ejemplo:**

```csharp
class Calculadora
{
    // Método estático
    public static int Sumar(int a, int b) { return a + b; }
    
    // Método de instancia
    public int Multiplicar(int a, int b) { return a * b; }
}

// Uso:
int resultado1 = Calculadora.Sumar(5, 3); // Estático
Calculadora calc = new Calculadora();
int resultado2 = calc.Multiplicar(5, 3); // Instancia',
    'using System;

class Calculadora
{
    // Método estático: pertenece a la clase
    public static int Sumar(int a, int b)
    {
        return a + b;
    }
    
    public static int Restar(int a, int b)
    {
        return a - b;
    }
    
    // Método estático que no necesita instancia
    public static double CalcularAreaCirculo(double radio)
    {
        return Math.PI * radio * radio;
    }
}

class Persona
{
    // Campos de instancia
    public string Nombre { get; set; }
    public int Edad { get; set; }
    
    // Constructor
    public Persona(string nombre, int edad)
    {
        Nombre = nombre;
        Edad = edad;
    }
    
    // Método de instancia: trabaja con el estado del objeto
    public void MostrarInformacion()
    {
        Console.WriteLine($"Nombre: {Nombre}, Edad: {Edad}");
    }
    
    // Método de instancia que modifica el estado
    public void CumplirAnios()
    {
        Edad++;
        Console.WriteLine($"{Nombre} ahora tiene {Edad} años");
    }
    
    // Método de instancia que usa el estado
    public bool EsMayorDeEdad()
    {
        return Edad >= 18;
    }
}

class Program
{
    static void Main()
    {
        // ===== MÉTODOS ESTÁTICOS =====
        Console.WriteLine("=== MÉTODOS ESTÁTICOS ===");
        
        // Llamar métodos estáticos usando el nombre de la clase
        int suma = Calculadora.Sumar(10, 5);
        Console.WriteLine($"10 + 5 = {suma}");
        
        int resta = Calculadora.Restar(10, 5);
        Console.WriteLine($"10 - 5 = {resta}");
        
        double area = Calculadora.CalcularAreaCirculo(5);
        Console.WriteLine($"Área del círculo (radio=5): {area:F2}");
        
        // No necesitas crear una instancia para usar métodos estáticos
        // Calculadora calc = new Calculadora(); // NO es necesario
        
        // ===== MÉTODOS DE INSTANCIA =====
        Console.WriteLine("\n=== MÉTODOS DE INSTANCIA ===");
        
        // Crear instancias de Persona
        Persona persona1 = new Persona("Juan", 25);
        Persona persona2 = new Persona("María", 17);
        
        // Llamar métodos de instancia usando el objeto
        persona1.MostrarInformacion();
        persona2.MostrarInformacion();
        
        // Los métodos de instancia pueden acceder y modificar el estado
        Console.WriteLine($"\n¿{persona1.Nombre} es mayor de edad? {persona1.EsMayorDeEdad()}");
        Console.WriteLine($"¿{persona2.Nombre} es mayor de edad? {persona2.EsMayorDeEdad()}");
        
        persona1.CumplirAnios();
        persona1.MostrarInformacion();
        
        // ===== DIFERENCIA CLAVE =====
        Console.WriteLine("\n=== DIFERENCIA CLAVE ===");
        Console.WriteLine("Métodos estáticos: Se llaman con Clase.Metodo()");
        Console.WriteLine("Métodos de instancia: Se llaman con objeto.Metodo()");
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Sobrecarga de Métodos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Sobrecarga de Métodos',
    'Aprende a crear múltiples versiones del mismo método con diferentes parámetros usando sobrecarga.',
    'La **sobrecarga de métodos** permite definir múltiples métodos con el mismo nombre pero con diferentes parámetros. El compilador determina qué versión usar basándose en el número, tipo y orden de los parámetros.

**Reglas de sobrecarga:**

1. Los métodos deben tener el **mismo nombre**
2. Deben diferir en:
   - El **número de parámetros**, o
   - El **tipo de parámetros**, o
   - El **orden de los parámetros**
3. El tipo de retorno **NO** puede ser la única diferencia

**Ventajas:**

- Proporciona flexibilidad al llamar métodos
- Permite usar el mismo nombre para operaciones similares
- Hace la API más intuitiva
- Reduce la necesidad de nombres de métodos diferentes

**Cuándo usar sobrecarga:**

- Cuando una operación puede realizarse con diferentes tipos de datos
- Cuando algunos parámetros son opcionales
- Para proporcionar valores por defecto de forma explícita

**Ejemplo común:**

```csharp
int Sumar(int a, int b)
double Sumar(double a, double b)
int Sumar(int a, int b, int c)
```',
    'using System;

class Calculadora
{
    // Sobrecarga 1: Sumar dos enteros
    public static int Sumar(int a, int b)
    {
        Console.WriteLine("Sumando dos enteros");
        return a + b;
    }
    
    // Sobrecarga 2: Sumar tres enteros
    public static int Sumar(int a, int b, int c)
    {
        Console.WriteLine("Sumando tres enteros");
        return a + b + c;
    }
    
    // Sobrecarga 3: Sumar dos doubles
    public static double Sumar(double a, double b)
    {
        Console.WriteLine("Sumando dos doubles");
        return a + b;
    }
    
    // Sobrecarga 4: Sumar array de enteros
    public static int Sumar(int[] numeros)
    {
        Console.WriteLine("Sumando array de enteros");
        int suma = 0;
        foreach (int num in numeros)
        {
            suma += num;
        }
        return suma;
    }
    
    // Sobrecarga 5: Diferente orden de parámetros
    public static void MostrarInfo(string nombre, int edad)
    {
        Console.WriteLine($"Nombre: {nombre}, Edad: {edad}");
    }
    
    public static void MostrarInfo(int edad, string nombre)
    {
        Console.WriteLine($"Edad: {edad}, Nombre: {nombre}");
    }
}

class Program
{
    static void Main()
    {
        // Llamar diferentes sobrecargas
        Console.WriteLine("=== SOBRECARGA DE MÉTODOS ===\n");
        
        // Sobrecarga 1: dos enteros
        int resultado1 = Calculadora.Sumar(5, 3);
        Console.WriteLine($"5 + 3 = {resultado1}\n");
        
        // Sobrecarga 2: tres enteros
        int resultado2 = Calculadora.Sumar(1, 2, 3);
        Console.WriteLine($"1 + 2 + 3 = {resultado2}\n");
        
        // Sobrecarga 3: dos doubles
        double resultado3 = Calculadora.Sumar(5.5, 3.2);
        Console.WriteLine($"5.5 + 3.2 = {resultado3}\n");
        
        // Sobrecarga 4: array
        int[] numeros = { 1, 2, 3, 4, 5 };
        int resultado4 = Calculadora.Sumar(numeros);
        Console.WriteLine($"Suma del array = {resultado4}\n");
        
        // Sobrecarga 5: diferente orden
        Calculadora.MostrarInfo("Juan", 25);
        Calculadora.MostrarInfo(30, "María");
        
        // El compilador elige automáticamente la sobrecarga correcta
        // basándose en los argumentos proporcionados
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Métodos Recursivos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos Recursivos',
    'Aprende a crear métodos que se llaman a sí mismos para resolver problemas de forma elegante.',
    'Un **método recursivo** es un método que se llama a sí mismo. La recursión es una técnica poderosa para resolver problemas que pueden dividirse en subproblemas más pequeños del mismo tipo.

**Componentes de la recursión:**

1. **Caso base**: Condición que detiene la recursión (evita recursión infinita)
2. **Caso recursivo**: Llamada al método con parámetros modificados

**Sintaxis básica:**

```csharp
tipoRetorno MetodoRecursivo(parametro)
{
    // Caso base
    if (condicion)
        return valor;
    
    // Caso recursivo
    return MetodoRecursivo(parametroModificado);
}
```

**Ventajas:**

- Código más elegante para ciertos problemas
- Refleja la naturaleza del problema
- Útil para estructuras de datos recursivas (árboles, listas)

**Desventajas:**

- Puede ser menos eficiente que iteraciones
- Consume más memoria (pila de llamadas)
- Puede ser difícil de depurar

**Problemas comunes resueltos con recursión:**

- Factorial
- Fibonacci
- Potencias
- Búsqueda en árboles
- Algoritmos de ordenamiento (quicksort, mergesort)

**Importante:**

Siempre asegúrate de tener un caso base para evitar recursión infinita.',
    'using System;

class Program
{
    // Recursión: Calcular factorial
    // n! = n * (n-1) * (n-2) * ... * 1
    static int Factorial(int n)
    {
        // Caso base
        if (n <= 1)
            return 1;
        
        // Caso recursivo
        return n * Factorial(n - 1);
    }
    
    // Recursión: Calcular potencia
    static int Potencia(int baseNum, int exponente)
    {
        // Caso base
        if (exponente == 0)
            return 1;
        
        // Caso recursivo
        return baseNum * Potencia(baseNum, exponente - 1);
    }
    
    // Recursión: Serie de Fibonacci
    // F(n) = F(n-1) + F(n-2)
    static int Fibonacci(int n)
    {
        // Casos base
        if (n <= 0)
            return 0;
        if (n == 1)
            return 1;
        
        // Caso recursivo
        return Fibonacci(n - 1) + Fibonacci(n - 2);
    }
    
    // Recursión: Sumar números del 1 al n
    static int SumarHasta(int n)
    {
        // Caso base
        if (n <= 0)
            return 0;
        
        // Caso recursivo
        return n + SumarHasta(n - 1);
    }
    
    // Recursión: Contar dígitos de un número
    static int ContarDigitos(int numero)
    {
        // Caso base
        if (numero < 10)
            return 1;
        
        // Caso recursivo
        return 1 + ContarDigitos(numero / 10);
    }
    
    // Recursión: Invertir un número
    static int InvertirNumero(int numero, int invertido = 0)
    {
        // Caso base
        if (numero == 0)
            return invertido;
        
        // Caso recursivo
        return InvertirNumero(numero / 10, invertido * 10 + numero % 10);
    }
    
    static void Main()
    {
        Console.WriteLine("=== MÉTODOS RECURSIVOS ===\n");
        
        // Factorial
        Console.WriteLine("Factoriales:");
        for (int i = 1; i <= 5; i++)
        {
            Console.WriteLine($"{i}! = {Factorial(i)}");
        }
        
        // Potencia
        Console.WriteLine($"\n2^5 = {Potencia(2, 5)}");
        Console.WriteLine($"3^4 = {Potencia(3, 4)}");
        
        // Fibonacci
        Console.WriteLine("\nSerie de Fibonacci:");
        for (int i = 0; i < 10; i++)
        {
            Console.Write($"{Fibonacci(i)} ");
        }
        Console.WriteLine();
        
        // Sumar hasta n
        Console.WriteLine($"\nSuma de 1 a 10: {SumarHasta(10)}");
        Console.WriteLine($"Suma de 1 a 100: {SumarHasta(100)}");
        
        // Contar dígitos
        Console.WriteLine($"\nDígitos en 12345: {ContarDigitos(12345)}");
        Console.WriteLine($"Dígitos en 987: {ContarDigitos(987)}");
        
        // Invertir número
        Console.WriteLine($"\n12345 invertido: {InvertirNumero(12345)}");
        Console.WriteLine($"987 invertido: {InvertirNumero(987)}");
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Parámetros por Valor, Referencia y Salida
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Parámetros por Valor, Referencia y Salida',
    'Comprende las diferencias entre pasar parámetros por valor, por referencia (ref) y por salida (out).',
    'En C#, hay tres formas principales de pasar parámetros a métodos, cada una con comportamientos diferentes:

**1. Parámetros por Valor (por defecto):**

- Se pasa una **copia** del valor
- Los cambios dentro del método **NO** afectan la variable original
- Es el comportamiento predeterminado
- Usado para tipos de valor (int, double, bool, structs)

**2. Parámetros por Referencia (ref):**

- Se pasa la **referencia** a la variable original
- Los cambios dentro del método **SÍ** afectan la variable original
- La variable debe estar **inicializada** antes de pasarla
- Útil cuando necesitas modificar la variable original

**3. Parámetros de Salida (out):**

- Similar a `ref`, pero la variable **NO** necesita estar inicializada
- El método **DEBE** asignar un valor antes de terminar
- Útil para métodos que devuelven múltiples valores
- La variable se inicializa dentro del método

**Comparación:**

| Característica | Por Valor | ref | out |
|----------------|------------|-----|-----|
| Modifica original | No | Sí | Sí |
| Debe estar inicializada | - | Sí | No |
| Método debe asignar | - | No | Sí |

**Cuándo usar cada uno:**

- **Por valor**: Cuando no necesitas modificar el original (la mayoría de casos)
- **ref**: Cuando necesitas modificar y la variable ya tiene un valor
- **out**: Cuando el método calcula y asigna el valor',
    'using System;

class Program
{
    // Parámetro por valor (comportamiento por defecto)
    static void ModificarPorValor(int numero)
    {
        numero = 100; // Solo modifica la copia local
        Console.WriteLine($"Dentro del método: {numero}");
    }
    
    // Parámetro por referencia (ref)
    static void ModificarPorReferencia(ref int numero)
    {
        numero = 100; // Modifica la variable original
        Console.WriteLine($"Dentro del método: {numero}");
    }
    
    // Parámetro de salida (out)
    static void ObtenerValores(out int valor1, out int valor2)
    {
        // DEBE asignar valores antes de terminar
        valor1 = 10;
        valor2 = 20;
    }
    
    // Método que intenta dividir y devuelve éxito/fracaso
    static bool IntentarDividir(int dividendo, int divisor, out int resultado)
    {
        if (divisor == 0)
        {
            resultado = 0; // DEBE asignar algo
            return false; // División inválida
        }
        resultado = dividendo / divisor;
        return true; // División exitosa
    }
    
    // Método que intercambia dos valores usando ref
    static void Intercambiar(ref int a, ref int b)
    {
        int temporal = a;
        a = b;
        b = temporal;
    }
    
    // Método que calcula múltiples valores usando out
    static void CalcularEstadisticas(int[] numeros, out int suma, out double promedio, out int maximo)
    {
        suma = 0;
        maximo = int.MinValue;
        
        foreach (int num in numeros)
        {
            suma += num;
            if (num > maximo)
                maximo = num;
        }
        
        promedio = numeros.Length > 0 ? (double)suma / numeros.Length : 0;
    }
    
    static void Main()
    {
        Console.WriteLine("=== PARÁMETROS POR VALOR ===\n");
        
        int numero1 = 5;
        Console.WriteLine($"Antes: {numero1}");
        ModificarPorValor(numero1);
        Console.WriteLine($"Después: {numero1}"); // No cambió
        
        Console.WriteLine("\n=== PARÁMETROS POR REFERENCIA (ref) ===\n");
        
        int numero2 = 5;
        Console.WriteLine($"Antes: {numero2}");
        ModificarPorReferencia(ref numero2);
        Console.WriteLine($"Después: {numero2}"); // Cambió a 100
        
        // Intercambiar valores
        int a = 10, b = 20;
        Console.WriteLine($"\nAntes del intercambio: a={a}, b={b}");
        Intercambiar(ref a, ref b);
        Console.WriteLine($"Después del intercambio: a={a}, b={b}");
        
        Console.WriteLine("\n=== PARÁMETROS DE SALIDA (out) ===\n");
        
        // out: la variable no necesita estar inicializada
        int valor1, valor2;
        ObtenerValores(out valor1, out valor2);
        Console.WriteLine($"Valores obtenidos: {valor1}, {valor2}");
        
        // Ejemplo práctico: división con validación
        int resultado;
        if (IntentarDividir(17, 5, out resultado))
        {
            Console.WriteLine($"División exitosa: 17 / 5 = {resultado}");
        }
        else
        {
            Console.WriteLine("División inválida");
        }
        
        // Ejemplo: calcular estadísticas
        int[] numeros = { 10, 20, 30, 40, 50 };
        int suma;
        double promedio;
        int maximo;
        
        CalcularEstadisticas(numeros, out suma, out promedio, out maximo);
        Console.WriteLine($"\nEstadísticas:");
        Console.WriteLine($"Suma: {suma}");
        Console.WriteLine($"Promedio: {promedio:F2}");
        Console.WriteLine($"Máximo: {maximo}");
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Métodos de Extensión
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos de Extensión',
    'Aprende a agregar métodos a tipos existentes sin modificar su código usando métodos de extensión.',
    'Los **métodos de extensión** permiten "agregar" métodos a tipos existentes (incluso tipos que no controlas) sin modificar su código fuente. Son una característica poderosa de C# que mejora la legibilidad y la organización del código.

**Sintaxis:**

```csharp
public static class NombreClaseExtension
{
    public static TipoRetorno NombreMetodo(this TipoExtendido parametro, ...)
    {
        // Código
    }
}
```

**Características:**

- Deben estar en una clase **estática**
- El método debe ser **estático**
- El primer parámetro usa `this` e indica el tipo que se extiende
- Se llaman como si fueran métodos de instancia del tipo extendido

**Ventajas:**

- Agregar funcionalidad a tipos existentes
- Mejorar la legibilidad del código
- Organizar métodos relacionados
- No requiere modificar el código original

**Cuándo usar:**

- Agregar utilidades a tipos del framework (.NET)
- Crear métodos helper para tus propios tipos
- Mejorar la API de clases de terceros
- Hacer el código más expresivo

**Limitaciones:**

- No pueden acceder a miembros privados
- No pueden sobrescribir métodos existentes
- Solo pueden extender tipos, no crear nuevos',
    'using System;
using System.Text;

// Clase estática para métodos de extensión
public static class ExtensionesString
{
    // Método de extensión para contar palabras
    public static int ContarPalabras(this string texto)
    {
        if (string.IsNullOrWhiteSpace(texto))
            return 0;
        
        return texto.Split(new char[] { '' '', ''\t'', ''\n'' }, StringSplitOptions.RemoveEmptyEntries).Length;
    }
    
    // Método de extensión para invertir un string
    public static string Invertir(this string texto)
    {
        char[] caracteres = texto.ToCharArray();
        Array.Reverse(caracteres);
        return new string(caracteres);
    }
    
    // Método de extensión para capitalizar primera letra
    public static string Capitalizar(this string texto)
    {
        if (string.IsNullOrEmpty(texto))
            return texto;
        
        return char.ToUpper(texto[0]) + texto.Substring(1).ToLower();
    }
    
    // Método de extensión para verificar si es email (simple)
    public static bool EsEmail(this string texto)
    {
        return texto.Contains("@") && texto.Contains(".");
    }
}

public static class ExtensionesInt
{
    // Método de extensión para verificar si es par
    public static bool EsPar(this int numero)
    {
        return numero % 2 == 0;
    }
    
    // Método de extensión para verificar si es impar
    public static bool EsImpar(this int numero)
    {
        return numero % 2 != 0;
    }
    
    // Método de extensión para calcular potencia
    public static int Potencia(this int baseNum, int exponente)
    {
        int resultado = 1;
        for (int i = 0; i < exponente; i++)
        {
            resultado *= baseNum;
        }
        return resultado;
    }
    
    // Método de extensión para convertir a string con formato
    public static string AFormatoMoneda(this int numero)
    {
        return $"${numero:N2}";
    }
}

public static class ExtensionesArray
{
    // Método de extensión para imprimir array
    public static void Imprimir<T>(this T[] array)
    {
        Console.WriteLine("[" + string.Join(", ", array) + "]");
    }
    
    // Método de extensión para obtener elemento aleatorio
    public static T ElementoAleatorio<T>(this T[] array)
    {
        Random random = new Random();
        return array[random.Next(array.Length)];
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== MÉTODOS DE EXTENSIÓN ===\n");
        
        // Extensiones de String
        Console.WriteLine("=== Extensiones de String ===");
        string texto = "Hola mundo desde C#";
        Console.WriteLine($"Texto: {texto}");
        Console.WriteLine($"Palabras: {texto.ContarPalabras()}");
        Console.WriteLine($"Invertido: {texto.Invertir()}");
        Console.WriteLine($"Capitalizado: {"hola MUNDO".Capitalizar()}");
        Console.WriteLine($"¿Es email? {"usuario@email.com".EsEmail()}");
        
        // Extensiones de Int
        Console.WriteLine("\n=== Extensiones de Int ===");
        int numero = 8;
        Console.WriteLine($"{numero} es par: {numero.EsPar()}");
        Console.WriteLine($"{numero} es impar: {numero.EsImpar()}");
        Console.WriteLine($"2^5 = {2.Potencia(5)}");
        Console.WriteLine($"Formato moneda: {1234.AFormatoMoneda()}");
        
        // Extensiones de Array
        Console.WriteLine("\n=== Extensiones de Array ===");
        int[] numeros = { 1, 2, 3, 4, 5 };
        numeros.Imprimir();
        Console.WriteLine($"Elemento aleatorio: {numeros.ElementoAleatorio()}");
        
        string[] frutas = { "Manzana", "Banana", "Naranja" };
        frutas.Imprimir();
        Console.WriteLine($"Fruta aleatoria: {frutas.ElementoAleatorio()}");
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

