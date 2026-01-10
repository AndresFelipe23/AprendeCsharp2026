-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Clases y Objetos"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Clases y Objetos" en la ruta con RutaId = 2
DECLARE @CursoId INT;
DECLARE @RutaId INT = 2; -- RutaId de "Programación Orientada a Objetos"
DECLARE @NombreCurso NVARCHAR(100) = 'Clases y Objetos';

-- Buscar el curso "Clases y Objetos" en la ruta con RutaId = 2
SELECT @CursoId = CursoId 
FROM Cursos 
WHERE Nombre = @NombreCurso 
  AND RutaId = @RutaId;

-- Si el curso no existe, crearlo
IF @CursoId IS NULL
BEGIN
    PRINT 'El curso no existe. Creando curso "' + @NombreCurso + '"...';
    
    -- Obtener el siguiente orden disponible
    DECLARE @SiguienteOrden INT;
    SELECT @SiguienteOrden = ISNULL(MAX(Orden), 0) + 1
    FROM Cursos
    WHERE RutaId = @RutaId;
    
    -- Insertar el nuevo curso
    INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo)
    VALUES (
        @RutaId,
        @NombreCurso,
        'Aprende a definir clases y crear objetos, los bloques fundamentales de la POO en C#',
        @SiguienteOrden,
        1
    );
    
    -- Obtener el CursoId del curso recién creado
    SET @CursoId = SCOPE_IDENTITY();
    
    PRINT 'Curso creado exitosamente con CursoId: ' + CAST(@CursoId AS VARCHAR);
END
ELSE
BEGIN
    PRINT 'Curso encontrado. CursoId: ' + CAST(@CursoId AS VARCHAR);
END

PRINT 'Insertando lecciones para el curso "' + @NombreCurso + '" (CursoId: ' + CAST(@CursoId AS VARCHAR) + ')';
PRINT '';

-- ============================================
-- LECCIÓN 1: Introducción a Clases y Objetos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Clases y Objetos',
    'Comprende los conceptos fundamentales de clases y objetos, la base de la Programación Orientada a Objetos.',
    'La **Programación Orientada a Objetos (POO)** es un paradigma de programación que organiza el código en torno a objetos y clases. Es uno de los paradigmas más utilizados en el desarrollo de software moderno.

**¿Qué es una Clase?**

Una **clase** es una plantilla o molde que define:
- **Atributos (campos)**: Características o propiedades del objeto
- **Métodos**: Comportamientos o acciones que el objeto puede realizar

Piensa en una clase como un plano arquitectónico: define cómo será una casa, pero no es la casa en sí.

**¿Qué es un Objeto?**

Un **objeto** es una instancia concreta de una clase. Es la "casa real" construida a partir del "plano" (clase).

**Ejemplo del mundo real:**

- **Clase**: `Automovil` (el plano)
  - Atributos: marca, modelo, color, velocidad
  - Métodos: acelerar(), frenar(), encender()

- **Objeto**: `miAuto` (un automóvil específico)
  - marca = "Toyota"
  - modelo = "Corolla"
  - color = "Rojo"
  - velocidad = 0

**Ventajas de la POO:**

1. **Modularidad**: El código se organiza en unidades lógicas (clases)
2. **Reutilización**: Puedes crear múltiples objetos de la misma clase
3. **Mantenibilidad**: Es más fácil mantener y actualizar el código
4. **Abstracción**: Ocultas la complejidad y muestras solo lo necesario
5. **Encapsulación**: Proteges los datos internos del objeto

**Sintaxis básica en C#:**

```csharp
// Definir una clase
public class NombreClase
{
    // Campos (atributos)
    public string campo1;
    public int campo2;
    
    // Métodos (comportamientos)
    public void Metodo1()
    {
        // Código del método
    }
}

// Crear un objeto (instancia)
NombreClase objeto = new NombreClase();
```',
    'using System;

// Definición de una clase simple
public class Persona
{
    // Campos (atributos)
    public string Nombre;
    public int Edad;
    
    // Método (comportamiento)
    public void Presentarse()
    {
        Console.WriteLine($"Hola, soy {Nombre} y tengo {Edad} años.");
    }
}

class Program
{
    static void Main()
    {
        // Crear objetos (instancias) de la clase Persona
        Persona persona1 = new Persona();
        persona1.Nombre = "Juan";
        persona1.Edad = 25;
        persona1.Presentarse();
        
        Persona persona2 = new Persona();
        persona2.Nombre = "María";
        persona2.Edad = 30;
        persona2.Presentarse();
        
        // Cada objeto es independiente
        Console.WriteLine($"\\npersona1: {persona1.Nombre}");
        Console.WriteLine($"persona2: {persona2.Nombre}");
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Definición de Clases
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Definición de Clases',
    'Aprende la sintaxis completa para definir clases en C#, incluyendo campos, métodos y modificadores de acceso.',
    'Definir una clase en C# es crear un nuevo tipo de dato personalizado que agrupa datos relacionados y las operaciones que se pueden realizar con esos datos.

**Estructura de una Clase:**

```csharp
[modificadores] class NombreClase
{
    // Campos (variables de la clase)
    [modificadores] tipo nombreCampo;
    
    // Métodos (funciones de la clase)
    [modificadores] tipoRetorno NombreMetodo([parámetros])
    {
        // Código del método
    }
}
```

**Componentes de una Clase:**

1. **Modificadores de Acceso:**
   - `public`: Accesible desde cualquier lugar
   - `private`: Solo accesible dentro de la misma clase
   - `protected`: Accesible en la clase y clases derivadas
   - `internal`: Accesible dentro del mismo ensamblado

2. **Campos (Fields):**
   - Variables que almacenan datos del objeto
   - Cada instancia tiene su propia copia de los campos

3. **Métodos:**
   - Funciones que definen el comportamiento
   - Pueden acceder y modificar los campos de la clase

**Convenciones de Nomenclatura:**

- **Clases**: PascalCase (primera letra mayúscula)
  - Ejemplo: `Persona`, `Automovil`, `Calculadora`
  
- **Campos**: camelCase (primera letra minúscula) o PascalCase con `public`
  - Ejemplo: `nombre`, `edad`, `Nombre`, `Edad`
  
- **Métodos**: PascalCase
  - Ejemplo: `CalcularTotal()`, `ObtenerNombre()`

**Ejemplo Completo:**

```csharp
public class Calculadora
{
    // Campos privados
    private double resultado;
    
    // Método público
    public void Sumar(double a, double b)
    {
        resultado = a + b;
    }
    
    public double ObtenerResultado()
    {
        return resultado;
    }
}
```

**Buenas Prácticas:**

- Usa nombres descriptivos y claros
- Agrupa campos relacionados
- Mantén los métodos pequeños y enfocados
- Usa `private` para campos internos y `public` para la interfaz',
    'using System;

// Clase con campos y métodos
public class Rectangulo
{
    // Campos privados
    private double ancho;
    private double alto;
    
    // Método para establecer dimensiones
    public void EstablecerDimensiones(double ancho, double alto)
    {
        this.ancho = ancho;
        this.alto = alto;
    }
    
    // Método para calcular el área
    public double CalcularArea()
    {
        return ancho * alto;
    }
    
    // Método para calcular el perímetro
    public double CalcularPerimetro()
    {
        return 2 * (ancho + alto);
    }
    
    // Método para mostrar información
    public void MostrarInformacion()
    {
        Console.WriteLine($"Rectángulo: {ancho} x {alto}");
        Console.WriteLine($"Área: {CalcularArea()}");
        Console.WriteLine($"Perímetro: {CalcularPerimetro()}");
    }
}

class Program
{
    static void Main()
    {
        Rectangulo rect1 = new Rectangulo();
        rect1.EstablecerDimensiones(5.0, 3.0);
        rect1.MostrarInformacion();
        
        Console.WriteLine();
        
        Rectangulo rect2 = new Rectangulo();
        rect2.EstablecerDimensiones(10.0, 7.5);
        rect2.MostrarInformacion();
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Creación de Objetos e Instanciación
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Creación de Objetos e Instanciación',
    'Aprende cómo crear objetos a partir de clases usando el operador new y cómo inicializar sus valores.',
    'Crear un objeto es el proceso de **instanciar** una clase. Esto significa crear una copia concreta de la clase con sus propios valores de datos.

**Sintaxis para Crear Objetos:**

```csharp
// Forma 1: Declaración e instanciación separadas
NombreClase objeto;
objeto = new NombreClase();

// Forma 2: Declaración e instanciación en una línea
NombreClase objeto = new NombreClase();
```

**El Operador `new`:**

El operador `new` realiza tres acciones importantes:
1. **Asigna memoria** para el nuevo objeto
2. **Inicializa los campos** con valores por defecto
3. **Llama al constructor** de la clase (si existe)

**Valores por Defecto:**

Cuando creas un objeto, los campos se inicializan con valores por defecto:
- `int`, `double`, `float`, etc. → `0`
- `bool` → `false`
- `string`, objetos → `null`
- `char` → `\0`

**Acceso a Miembros:**

Una vez creado el objeto, puedes acceder a sus miembros públicos usando el operador punto (`.`):

```csharp
objeto.campo = valor;
objeto.Metodo();
```

**Múltiples Instancias:**

Cada objeto es independiente. Puedes crear múltiples instancias de la misma clase, cada una con sus propios valores:

```csharp
Persona persona1 = new Persona();
persona1.Nombre = "Juan";

Persona persona2 = new Persona();
persona2.Nombre = "María";

// persona1 y persona2 son objetos diferentes
```

**Referencias vs Valores:**

Los objetos en C# son tipos de referencia. Esto significa que cuando asignas un objeto a otra variable, ambas apuntan al mismo objeto en memoria:

```csharp
Persona p1 = new Persona();
Persona p2 = p1; // p2 apunta al mismo objeto que p1
p1.Nombre = "Juan";
Console.WriteLine(p2.Nombre); // Imprime "Juan"
```

**Inicialización de Objetos:**

Puedes inicializar campos públicos directamente al crear el objeto (si la clase lo permite):

```csharp
Persona persona = new Persona
{
    Nombre = "Juan",
    Edad = 25
};
```',
    'using System;

public class Libro
{
    public string Titulo;
    public string Autor;
    public int Paginas;
    public bool Leido;
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Título: {Titulo}");
        Console.WriteLine($"Autor: {Autor}");
        Console.WriteLine($"Páginas: {Paginas}");
        Console.WriteLine($"Leído: {(Leido ? "Sí" : "No")}");
    }
    
    public void MarcarComoLeido()
    {
        Leido = true;
        Console.WriteLine($"El libro \"{Titulo}\" ha sido marcado como leído.");
    }
}

class Program
{
    static void Main()
    {
        // Crear objetos de la clase Libro
        Libro libro1 = new Libro();
        libro1.Titulo = "C# Programming";
        libro1.Autor = "John Doe";
        libro1.Paginas = 350;
        libro1.Leido = false;
        
        Libro libro2 = new Libro();
        libro2.Titulo = "Clean Code";
        libro2.Autor = "Robert Martin";
        libro2.Paginas = 464;
        libro2.Leido = true;
        
        // Mostrar información
        Console.WriteLine("=== LIBRO 1 ===");
        libro1.MostrarInformacion();
        
        Console.WriteLine("\n=== LIBRO 2 ===");
        libro2.MostrarInformacion();
        
        // Marcar libro1 como leído
        Console.WriteLine("\n--- Acción ---");
        libro1.MarcarComoLeido();
        
        Console.WriteLine("\n=== LIBRO 1 (Actualizado) ===");
        libro1.MostrarInformacion();
        
        // Demostrar que son objetos independientes
        Console.WriteLine("\n--- Comparación ---");
        Console.WriteLine($"libro1 y libro2 son el mismo objeto? {ReferenceEquals(libro1, libro2)}");
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Campos y Propiedades
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Campos y Propiedades',
    'Aprende la diferencia entre campos y propiedades, y cuándo usar cada uno para almacenar datos en una clase.',
    'Los **campos** y las **propiedades** son dos formas de almacenar datos en una clase. Aunque pueden parecer similares, tienen diferencias importantes.

**Campos (Fields):**

Los campos son variables declaradas directamente en la clase:

```csharp
public class Persona
{
    public string nombre;  // Campo público
    private int edad;      // Campo privado
}
```

**Propiedades (Properties):**

Las propiedades son una forma más controlada de acceder a los datos. Permiten:
- Validación de datos
- Cálculos automáticos
- Control de acceso

**Sintaxis de Propiedades:**

```csharp
public class Persona
{
    private string nombre;  // Campo privado (backing field)
    
    // Propiedad con get y set
    public string Nombre
    {
        get { return nombre; }
        set { nombre = value; }
    }
}
```

**Propiedades Auto-Implementadas:**

C# permite propiedades simplificadas cuando no necesitas lógica adicional:

```csharp
public string Nombre { get; set; }  // C# crea el campo automáticamente
```

**Propiedades de Solo Lectura:**

```csharp
public string Nombre { get; private set; }  // Solo lectura desde fuera
public int Edad { get; }  // Solo lectura (C# 6.0+)
```

**Propiedades de Solo Escritura:**

```csharp
public string Nombre { private get; set; }  // Solo escritura desde fuera
```

**Propiedades con Validación:**

```csharp
private int edad;

public int Edad
{
    get { return edad; }
    set 
    {
        if (value < 0 || value > 150)
            throw new ArgumentException("La edad debe estar entre 0 y 150");
        edad = value;
    }
}
```

**Propiedades Calculadas:**

```csharp
public string NombreCompleto
{
    get { return $"{Nombre} {Apellido}"; }
}
```

**Cuándo Usar Campos vs Propiedades:**

- **Usa Campos** cuando:
  - Son privados y solo se usan internamente
  - No necesitas validación ni lógica adicional
  
- **Usa Propiedades** cuando:
  - Necesitas validación
  - Quieres controlar el acceso
  - Necesitas cálculos o transformaciones
  - Expones datos públicamente

**Buenas Prácticas:**

- Usa propiedades para miembros públicos
- Usa campos privados como "backing fields" para propiedades
- Valida datos en el `set` de las propiedades
- Usa propiedades auto-implementadas cuando sea posible',
    'using System;

public class CuentaBancaria
{
    // Campo privado (backing field)
    private double saldo;
    private string numeroCuenta;
    
    // Propiedad con validación
    public double Saldo
    {
        get { return saldo; }
        private set  // Solo se puede modificar desde dentro de la clase
        {
            if (value < 0)
                throw new ArgumentException("El saldo no puede ser negativo");
            saldo = value;
        }
    }
    
    // Propiedad auto-implementada
    public string Titular { get; set; }
    
    // Propiedad de solo lectura
    public string NumeroCuenta
    {
        get { return numeroCuenta; }
    }
    
    // Propiedad calculada
    public string Estado
    {
        get
        {
            if (Saldo > 1000)
                return "Cuenta Premium";
            else if (Saldo > 0)
                return "Cuenta Activa";
            else
                return "Cuenta Vacía";
        }
    }
    
    // Constructor para inicializar
    public CuentaBancaria(string numero, string titular, double saldoInicial)
    {
        numeroCuenta = numero;
        Titular = titular;
        Saldo = saldoInicial;  // Usa el setter con validación
    }
    
    // Método para depositar
    public void Depositar(double cantidad)
    {
        if (cantidad <= 0)
            throw new ArgumentException("La cantidad debe ser positiva");
        Saldo += cantidad;  // Usa el setter
    }
    
    // Método para retirar
    public void Retirar(double cantidad)
    {
        if (cantidad <= 0)
            throw new ArgumentException("La cantidad debe ser positiva");
        if (cantidad > Saldo)
            throw new InvalidOperationException("Saldo insuficiente");
        Saldo -= cantidad;  // Usa el setter
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Cuenta: {NumeroCuenta}");
        Console.WriteLine($"Titular: {Titular}");
        Console.WriteLine($"Saldo: ${Saldo:F2}");
        Console.WriteLine($"Estado: {Estado}");
    }
}

class Program
{
    static void Main()
    {
        CuentaBancaria cuenta = new CuentaBancaria("12345", "Juan Pérez", 500.0);
        
        Console.WriteLine("=== INFORMACIÓN INICIAL ===");
        cuenta.MostrarInformacion();
        
        Console.WriteLine("\n=== DEPOSITANDO $200 ===");
        cuenta.Depositar(200);
        cuenta.MostrarInformacion();
        
        Console.WriteLine("\n=== RETIRANDO $100 ===");
        cuenta.Retirar(100);
        cuenta.MostrarInformacion();
        
        // Intentar retirar más de lo disponible
        Console.WriteLine("\n=== INTENTANDO RETIRAR $1000 ===");
        try
        {
            cuenta.Retirar(1000);
        }
        catch (InvalidOperationException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Métodos de Instancia y Estáticos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos de Instancia y Estáticos',
    'Comprende la diferencia entre métodos de instancia (que trabajan con objetos) y métodos estáticos (que pertenecen a la clase).',
    'En C#, existen dos tipos de métodos: **métodos de instancia** y **métodos estáticos**. Cada uno tiene un propósito diferente.

**Métodos de Instancia:**

Los métodos de instancia:
- Pertenecen a un objeto específico
- Pueden acceder a los campos y propiedades de la instancia
- Se llaman usando el nombre del objeto: `objeto.Metodo()`
- Tienen acceso a `this` (referencia al objeto actual)

```csharp
public class Persona
{
    public string Nombre;
    
    // Método de instancia
    public void Saludar()
    {
        Console.WriteLine($"Hola, soy {Nombre}");
    }
}

// Uso
Persona p = new Persona();
p.Nombre = "Juan";
p.Saludar();  // Llama al método de instancia
```

**Métodos Estáticos:**

Los métodos estáticos:
- Pertenecen a la clase, no a una instancia
- No pueden acceder a campos de instancia (solo a campos estáticos)
- Se llaman usando el nombre de la clase: `Clase.Metodo()`
- No tienen acceso a `this`

```csharp
public class Calculadora
{
    // Método estático
    public static int Sumar(int a, int b)
    {
        return a + b;
    }
}

// Uso
int resultado = Calculadora.Sumar(5, 3);  // No necesitas crear un objeto
```

**Cuándo Usar Cada Tipo:**

**Usa Métodos de Instancia cuando:**
- El método necesita trabajar con datos específicos del objeto
- El comportamiento depende del estado del objeto
- Ejemplo: `persona.Saludar()`, `cuenta.Depositar()`

**Usa Métodos Estáticos cuando:**
- El método no necesita datos de una instancia
- El método es una utilidad general
- El método es independiente del estado del objeto
- Ejemplo: `Math.Max()`, `Console.WriteLine()`, `String.IsNullOrEmpty()`

**Campos Estáticos:**

También puedes tener campos estáticos que pertenecen a la clase:

```csharp
public class Contador
{
    private static int totalInstancias = 0;  // Campo estático
    
    public Contador()
    {
        totalInstancias++;  // Incrementa el contador estático
    }
    
    public static int ObtenerTotal()
    {
        return totalInstancias;  // Método estático
    }
}
```

**Ventajas de los Métodos Estáticos:**

- No necesitas crear un objeto para usarlos
- Son más eficientes (no hay overhead de instancia)
- Útiles para funciones de utilidad
- Pueden ser llamados desde cualquier lugar

**Limitaciones de los Métodos Estáticos:**

- No pueden acceder a miembros de instancia
- No pueden usar `this` o `base`
- No pueden ser virtuales, abstractos u override',
    'using System;

public class Persona
{
    // Campos de instancia
    public string Nombre;
    public int Edad;
    
    // Campo estático (compartido por todas las instancias)
    private static int totalPersonas = 0;
    
    // Constructor
    public Persona(string nombre, int edad)
    {
        Nombre = nombre;
        Edad = edad;
        totalPersonas++;  // Incrementa el contador estático
    }
    
    // Método de instancia
    public void Presentarse()
    {
        Console.WriteLine($"Hola, soy {Nombre} y tengo {Edad} años.");
    }
    
    // Método de instancia que usa datos del objeto
    public bool EsMayorDeEdad()
    {
        return Edad >= 18;
    }
    
    // Método estático (pertenece a la clase, no a la instancia)
    public static int ObtenerTotalPersonas()
    {
        return totalPersonas;
    }
    
    // Método estático de utilidad
    public static bool ValidarEdad(int edad)
    {
        return edad >= 0 && edad <= 150;
    }
    
    // Método estático que crea una instancia
    public static Persona CrearPersona(string nombre, int edad)
    {
        if (!ValidarEdad(edad))
            throw new ArgumentException("Edad inválida");
        return new Persona(nombre, edad);
    }
}

class Program
{
    static void Main()
    {
        // Usar método estático sin crear objeto
        Console.WriteLine("=== MÉTODOS ESTÁTICOS ===");
        Console.WriteLine($"Total de personas: {Persona.ObtenerTotalPersonas()}");
        
        bool edadValida = Persona.ValidarEdad(25);
        Console.WriteLine($"¿Edad 25 es válida? {edadValida}");
        
        // Crear objetos usando método estático
        Console.WriteLine("\n=== CREANDO PERSONAS ===");
        Persona persona1 = Persona.CrearPersona("Juan", 25);
        Persona persona2 = Persona.CrearPersona("María", 30);
        Persona persona3 = Persona.CrearPersona("Pedro", 17);
        
        // Usar métodos de instancia
        Console.WriteLine("\n=== MÉTODOS DE INSTANCIA ===");
        persona1.Presentarse();
        Console.WriteLine($"¿Es mayor de edad? {persona1.EsMayorDeEdad()}");
        
        persona2.Presentarse();
        Console.WriteLine($"¿Es mayor de edad? {persona2.EsMayorDeEdad()}");
        
        persona3.Presentarse();
        Console.WriteLine($"¿Es mayor de edad? {persona3.EsMayorDeEdad()}");
        
        // Verificar el contador estático
        Console.WriteLine($"\nTotal de personas creadas: {Persona.ObtenerTotalPersonas()}");
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Modificadores de Acceso
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Modificadores de Acceso',
    'Aprende a controlar la visibilidad de clases, campos, métodos y propiedades usando modificadores de acceso.',
    'Los **modificadores de acceso** controlan desde dónde se puede acceder a los miembros de una clase. Son fundamentales para la **encapsulación**, uno de los pilares de la POO.

**Modificadores de Acceso en C#:**

1. **`public`**: Accesible desde cualquier lugar
2. **`private`**: Solo accesible dentro de la misma clase
3. **`protected`**: Accesible en la clase y clases derivadas (herencia)
4. **`internal`**: Accesible dentro del mismo ensamblado (proyecto)
5. **`protected internal`**: Accesible en clases derivadas o dentro del mismo ensamblado

**Niveles de Acceso:**

```
public > internal > protected > private
```

**`public` - Acceso Público:**

```csharp
public class Persona
{
    public string Nombre;  // Cualquiera puede acceder
    public void Saludar() { }  // Cualquiera puede llamar
}
```

**`private` - Acceso Privado:**

```csharp
public class Persona
{
    private string nombre;  // Solo accesible dentro de Persona
    private void MetodoPrivado() { }  // Solo dentro de Persona
}
```

**`protected` - Acceso Protegido:**

```csharp
public class Persona
{
    protected string nombre;  // Accesible en Persona y clases derivadas
}

public class Empleado : Persona
{
    public void UsarNombre()
    {
        nombre = "Juan";  // OK: Empleado hereda de Persona
    }
}
```

**`internal` - Acceso Interno:**

```csharp
internal class Utilidad  // Solo visible en el mismo proyecto
{
    internal static void Metodo() { }
}
```

**Encapsulación:**

La encapsulación es ocultar los detalles internos y exponer solo lo necesario:

```csharp
public class CuentaBancaria
{
    private double saldo;  // Privado: no se puede acceder directamente
    
    public double Saldo  // Público: acceso controlado
    {
        get { return saldo; }
    }
    
    public void Depositar(double cantidad)
    {
        if (cantidad > 0)
            saldo += cantidad;  // Lógica de validación interna
    }
}
```

**Buenas Prácticas:**

1. **Principio de Menor Privilegio**: Usa el modificador más restrictivo posible
2. **Campos Privados**: Los campos generalmente deben ser `private`
3. **Propiedades Públicas**: Usa propiedades públicas para exponer datos
4. **Métodos Públicos**: Expón solo los métodos necesarios para la interfaz
5. **Métodos Privados**: Usa métodos privados para lógica interna

**Ejemplo de Encapsulación Correcta:**

```csharp
public class Producto
{
    // Campos privados
    private string nombre;
    private double precio;
    
    // Propiedades públicas con validación
    public string Nombre
    {
        get { return nombre; }
        set 
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("El nombre no puede estar vacío");
            nombre = value;
        }
    }
    
    public double Precio
    {
        get { return precio; }
        set
        {
            if (value < 0)
                throw new ArgumentException("El precio no puede ser negativo");
            precio = value;
        }
    }
    
    // Método público
    public double CalcularPrecioConDescuento(double porcentaje)
    {
        return precio * (1 - porcentaje / 100);
    }
}
```',
    'using System;

public class Producto
{
    // Campos privados (encapsulación)
    private string nombre;
    private double precio;
    private int stock;
    
    // Propiedades públicas con validación
    public string Nombre
    {
        get { return nombre; }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("El nombre no puede estar vacío");
            nombre = value;
        }
    }
    
    public double Precio
    {
        get { return precio; }
        set
        {
            if (value < 0)
                throw new ArgumentException("El precio no puede ser negativo");
            precio = value;
        }
    }
    
    // Propiedad de solo lectura
    public int Stock
    {
        get { return stock; }
    }
    
    // Método público
    public void AgregarStock(int cantidad)
    {
        if (cantidad <= 0)
            throw new ArgumentException("La cantidad debe ser positiva");
        stock += cantidad;
        Console.WriteLine($"Stock actualizado: {stock} unidades");
    }
    
    // Método público
    public bool Vender(int cantidad)
    {
        if (cantidad <= 0)
            throw new ArgumentException("La cantidad debe ser positiva");
        
        if (cantidad > stock)
        {
            Console.WriteLine("Stock insuficiente");
            return false;
        }
        
        stock -= cantidad;
        Console.WriteLine($"Venta realizada: {cantidad} unidades. Stock restante: {stock}");
        return true;
    }
    
    // Método privado (solo usado internamente)
    private bool TieneStock()
    {
        return stock > 0;
    }
    
    // Método público que usa método privado
    public void MostrarDisponibilidad()
    {
        if (TieneStock())
            Console.WriteLine($"El producto {Nombre} está disponible ({Stock} unidades)");
        else
            Console.WriteLine($"El producto {Nombre} está agotado");
    }
    
    // Método público
    public double CalcularPrecioTotal(int cantidad)
    {
        if (cantidad <= 0)
            throw new ArgumentException("La cantidad debe ser positiva");
        return precio * cantidad;
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Producto: {Nombre}");
        Console.WriteLine($"Precio: ${Precio:F2}");
        Console.WriteLine($"Stock: {Stock} unidades");
    }
}

class Program
{
    static void Main()
    {
        Producto producto = new Producto();
        
        // Usar propiedades públicas (con validación)
        producto.Nombre = "Laptop";
        producto.Precio = 999.99;
        
        Console.WriteLine("=== INFORMACIÓN DEL PRODUCTO ===");
        producto.MostrarInformacion();
        
        Console.WriteLine("\n=== AGREGANDO STOCK ===");
        producto.AgregarStock(10);
        producto.MostrarDisponibilidad();
        
        Console.WriteLine("\n=== REALIZANDO VENTAS ===");
        producto.Vender(3);
        producto.Vender(5);
        
        Console.WriteLine("\n=== CÁLCULO DE PRECIO ===");
        double total = producto.CalcularPrecioTotal(2);
        Console.WriteLine($"Precio total por 2 unidades: ${total:F2}");
        
        // Intentar acceder a campo privado (esto causaría error)
        // producto.stock = 100;  // Error: stock es inaccesible
        
        // Intentar establecer precio negativo (será rechazado)
        Console.WriteLine("\n=== INTENTANDO PRECIO NEGATIVO ===");
        try
        {
            producto.Precio = -100;
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: El Operador this
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'El Operador this',
    'Aprende a usar la palabra clave this para referenciar la instancia actual de la clase y resolver ambigüedades.',
    'La palabra clave **`this`** es una referencia a la instancia actual de la clase. Te permite acceder a los miembros de la clase y distinguir entre parámetros y campos con el mismo nombre.

**¿Qué es `this`?**

`this` es una referencia implícita al objeto actual. Es como decir "este objeto" o "yo mismo".

**Usos Principales de `this`:**

1. **Resolver Ambigüedades de Nombres:**

Cuando un parámetro tiene el mismo nombre que un campo, `this` distingue entre ambos:

```csharp
public class Persona
{
    private string nombre;
    
    public void EstablecerNombre(string nombre)
    {
        this.nombre = nombre;  // this.nombre es el campo, nombre es el parámetro
    }
}
```

2. **Pasar la Instancia Actual:**

Puedes pasar el objeto actual como parámetro:

```csharp
public class Persona
{
    public void Registrar()
    {
        Servicio.Registrar(this);  // Pasa esta instancia
    }
}
```

3. **Encadenar Constructores:**

Puedes llamar a otro constructor desde un constructor:

```csharp
public class Persona
{
    private string nombre;
    private int edad;
    
    public Persona(string nombre) : this(nombre, 0)
    {
        // Llama al constructor que acepta nombre y edad
    }
    
    public Persona(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
    }
}
```

4. **Indexadores:**

En indexadores, `this` se usa para definir el acceso tipo array:

```csharp
public class Lista
{
    private int[] elementos;
    
    public int this[int index]
    {
        get { return elementos[index]; }
        set { elementos[index] = value; }
    }
}
```

**Cuándo Usar `this`:**

- **Necesario**: Cuando hay ambigüedad entre parámetros y campos
- **Opcional pero útil**: Para claridad en el código
- **Requerido**: En indexadores y para pasar la instancia

**Ejemplo Completo:**

```csharp
public class Rectangulo
{
    private double ancho;
    private double alto;
    
    public Rectangulo(double ancho, double alto)
    {
        this.ancho = ancho;  // Necesario: distingue campo de parámetro
        this.alto = alto;
    }
    
    public Rectangulo Copiar()
    {
        return new Rectangulo(this.ancho, this.alto);  // Opcional pero claro
    }
    
    public bool EsIgual(Rectangulo otro)
    {
        return this.ancho == otro.ancho && this.alto == otro.alto;
    }
}
```

**Buenas Prácticas:**

- Usa `this` cuando sea necesario para resolver ambigüedades
- No abuses de `this` cuando no sea necesario (puede hacer el código verboso)
- Úsalo para claridad cuando mejore la legibilidad
- En constructores, es común usarlo para distinguir parámetros de campos',
    'using System;

public class Estudiante
{
    private string nombre;
    private int edad;
    private double promedio;
    
    // Constructor usando this para distinguir parámetros de campos
    public Estudiante(string nombre, int edad, double promedio)
    {
        this.nombre = nombre;      // this.nombre es el campo, nombre es el parámetro
        this.edad = edad;
        this.promedio = promedio;
    }
    
    // Constructor que llama a otro constructor usando this
    public Estudiante(string nombre) : this(nombre, 0, 0.0)
    {
        // Este constructor llama al constructor principal
        Console.WriteLine($"Estudiante {nombre} creado con valores por defecto");
    }
    
    // Método que usa this para pasar la instancia
    public void RegistrarEnSistema()
    {
        SistemaEducativo.RegistrarEstudiante(this);
    }
    
    // Método que compara esta instancia con otra
    public bool TieneMejorPromedio(Estudiante otro)
    {
        return this.promedio > otro.promedio;
    }
    
    // Método que crea una copia de esta instancia
    public Estudiante Copiar()
    {
        return new Estudiante(this.nombre, this.edad, this.promedio);
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Nombre: {this.nombre}");
        Console.WriteLine($"Edad: {this.edad}");
        Console.WriteLine($"Promedio: {this.promedio:F2}");
    }
    
    // Propiedades usando this (opcional pero claro)
    public string Nombre
    {
        get { return this.nombre; }
        set { this.nombre = value; }
    }
    
    public int Edad
    {
        get { return this.edad; }
        set 
        {
            if (value < 0 || value > 120)
                throw new ArgumentException("Edad inválida");
            this.edad = value;
        }
    }
}

// Clase auxiliar para demostrar pasar this
public static class SistemaEducativo
{
    private static int totalEstudiantes = 0;
    
    public static void RegistrarEstudiante(Estudiante estudiante)
    {
        totalEstudiantes++;
        Console.WriteLine($"Estudiante {estudiante.Nombre} registrado. Total: {totalEstudiantes}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== CREANDO ESTUDIANTES ===");
        
        // Usar constructor completo
        Estudiante estudiante1 = new Estudiante("Juan", 20, 8.5);
        estudiante1.MostrarInformacion();
        
        Console.WriteLine("\n=== USANDO CONSTRUCTOR SIMPLIFICADO ===");
        Estudiante estudiante2 = new Estudiante("María");
        estudiante2.Edad = 19;
        estudiante2.MostrarInformacion();
        
        Console.WriteLine("\n=== REGISTRANDO EN SISTEMA ===");
        estudiante1.RegistrarEnSistema();
        estudiante2.RegistrarEnSistema();
        
        Console.WriteLine("\n=== COMPARANDO PROMEDIOS ===");
        Estudiante estudiante3 = new Estudiante("Pedro", 21, 9.2);
        Console.WriteLine($"¿{estudiante3.Nombre} tiene mejor promedio que {estudiante1.Nombre}?");
        Console.WriteLine(estudiante3.TieneMejorPromedio(estudiante1));
        
        Console.WriteLine("\n=== COPIANDO ESTUDIANTE ===");
        Estudiante copia = estudiante1.Copiar();
        Console.WriteLine("Copia del estudiante 1:");
        copia.MostrarInformacion();
        
        Console.WriteLine("\n=== MODIFICANDO COPIA ===");
        copia.Nombre = "Juan Modificado";
        Console.WriteLine("Estudiante original:");
        estudiante1.MostrarInformacion();
        Console.WriteLine("Copia modificada:");
        copia.MostrarInformacion();
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Clases Anidadas y Clases Parciales
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Clases Anidadas y Clases Parciales',
    'Aprende conceptos avanzados: clases anidadas (clases dentro de clases) y clases parciales (dividir una clase en múltiples archivos).',
    'C# ofrece características avanzadas para organizar clases de manera más flexible: **clases anidadas** y **clases parciales**.

**Clases Anidadas (Nested Classes):**

Una clase anidada es una clase definida dentro de otra clase. Es útil para:
- Agrupar clases relacionadas
- Ocultar implementaciones internas
- Crear clases auxiliares privadas

**Sintaxis:**

```csharp
public class ClaseExterna
{
    // Miembros de la clase externa
    
    public class ClaseAnidadaPublica
    {
        // Miembros de la clase anidada
    }
    
    private class ClaseAnidadaPrivada
    {
        // Solo accesible dentro de ClaseExterna
    }
}
```

**Acceso a Clases Anidadas:**

```csharp
// Clase anidada pública
ClaseExterna.ClaseAnidadaPublica objeto = new ClaseExterna.ClaseAnidadaPublica();

// Clase anidada privada (solo dentro de la clase externa)
ClaseExterna objetoExterno = new ClaseExterna();
objetoExterno.UsarClaseAnidada();  // Método que usa la clase anidada privada
```

**Casos de Uso:**

- **Implementaciones Internas**: Clases auxiliares que no deben ser públicas
- **Agrupación Lógica**: Clases relacionadas que pertenecen juntas
- **Patrones de Diseño**: Como el patrón Builder o Factory

**Clases Parciales (Partial Classes):**

Las clases parciales permiten dividir la definición de una clase en múltiples archivos. Útil para:
- Código generado automáticamente
- Organizar clases grandes
- Separar lógica por responsabilidades

**Sintaxis:**

```csharp
// Archivo 1: Persona.cs
public partial class Persona
{
    public string Nombre { get; set; }
    public int Edad { get; set; }
}

// Archivo 2: Persona.Metodos.cs
public partial class Persona
{
    public void Saludar()
    {
        Console.WriteLine($"Hola, soy {Nombre}");
    }
}

// Archivo 3: Persona.Validacion.cs
public partial class Persona
{
    public bool EsValido()
    {
        return !string.IsNullOrEmpty(Nombre) && Edad > 0;
    }
}
```

**Reglas de Clases Parciales:**

- Todas las partes deben usar `partial`
- Todas las partes deben tener el mismo modificador de acceso
- Solo una parte puede tener la clase base
- Solo una parte puede tener atributos de clase
- El compilador las combina en una sola clase

**Ventajas:**

- **Organización**: Divide clases grandes en archivos más manejables
- **Colaboración**: Múltiples desarrolladores pueden trabajar en la misma clase
- **Código Generado**: Separar código generado del código manual
- **Mantenibilidad**: Más fácil de mantener y navegar

**Ejemplo de Clase Anidada:**

```csharp
public class ListaEnlazada
{
    private Nodo cabeza;
    
    // Clase anidada privada
    private class Nodo
    {
        public int Valor;
        public Nodo Siguiente;
    }
    
    public void Agregar(int valor)
    {
        Nodo nuevo = new Nodo { Valor = valor };
        // Lógica de inserción
    }
}
```',
    'using System;
using System.Collections.Generic;

// ============================================
// EJEMPLO 1: CLASES ANIDADAS
// ============================================

public class Biblioteca
{
    private List<Libro> libros = new List<Libro>();
    
    // Clase anidada pública para representar un libro
    public class Libro
    {
        public string Titulo { get; set; }
        public string Autor { get; set; }
        public int Año { get; set; }
        
        public Libro(string titulo, string autor, int año)
        {
            Titulo = titulo;
            Autor = autor;
            Año = año;
        }
        
        public override string ToString()
        {
            return $"{Titulo} por {Autor} ({Año})";
        }
    }
    
    // Clase anidada privada para el catálogo interno
    private class Catalogo
    {
        private List<Libro> libros;
        
        public Catalogo()
        {
            libros = new List<Libro>();
        }
        
        public void AgregarLibro(Libro libro)
        {
            libros.Add(libro);
        }
        
        public int ContarLibros()
        {
            return libros.Count;
        }
    }
    
    private Catalogo catalogo;
    
    public Biblioteca()
    {
        catalogo = new Catalogo();
    }
    
    public void AgregarLibro(string titulo, string autor, int año)
    {
        Libro nuevoLibro = new Libro(titulo, autor, año);
        libros.Add(nuevoLibro);
        catalogo.AgregarLibro(nuevoLibro);
    }
    
    public void MostrarLibros()
    {
        Console.WriteLine("=== LIBROS EN LA BIBLIOTECA ===");
        foreach (var libro in libros)
        {
            Console.WriteLine($"- {libro}");
        }
        Console.WriteLine($"Total: {catalogo.ContarLibros()} libros");
    }
}

// ============================================
// EJEMPLO 2: CLASES PARCIALES
// ============================================

// Archivo 1: Estudiante.cs (propiedades básicas)
public partial class Estudiante
{
    public string Nombre { get; set; }
    public int Edad { get; set; }
    public string Matricula { get; set; }
}

// Archivo 2: Estudiante.Metodos.cs (métodos de comportamiento)
public partial class Estudiante
{
    public void Presentarse()
    {
        Console.WriteLine($"Hola, soy {Nombre}, tengo {Edad} años y mi matrícula es {Matricula}");
    }
    
    public void Estudiar(string materia)
    {
        Console.WriteLine($"{Nombre} está estudiando {materia}");
    }
}

// Archivo 3: Estudiante.Validacion.cs (métodos de validación)
public partial class Estudiante
{
    public bool EsValido()
    {
        return !string.IsNullOrEmpty(Nombre) && 
               Edad > 0 && 
               !string.IsNullOrEmpty(Matricula);
    }
    
    public bool PuedeVotar()
    {
        return Edad >= 18;
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO 1: CLASES ANIDADAS ===\n");
        
        Biblioteca biblioteca = new Biblioteca();
        biblioteca.AgregarLibro("C# Programming", "John Doe", 2023);
        biblioteca.AgregarLibro("Clean Code", "Robert Martin", 2008);
        biblioteca.AgregarLibro("Design Patterns", "Gang of Four", 1994);
        
        biblioteca.MostrarLibros();
        
        // Acceder a la clase anidada pública desde fuera
        Biblioteca.Libro libroExterno = new Biblioteca.Libro("Nuevo Libro", "Autor", 2024);
        Console.WriteLine($"\nLibro creado externamente: {libroExterno}");
        
        Console.WriteLine("\n=== EJEMPLO 2: CLASES PARCIALES ===\n");
        
        Estudiante estudiante = new Estudiante
        {
            Nombre = "Ana García",
            Edad = 20,
            Matricula = "2024-001"
        };
        
        estudiante.Presentarse();
        estudiante.Estudiar("Programación Orientada a Objetos");
        
        Console.WriteLine($"\n¿Es válido? {estudiante.EsValido()}");
        Console.WriteLine($"¿Puede votar? {estudiante.PuedeVotar()}");
    }
}',
    8,
    1
);

PRINT '';
PRINT '========================================';
PRINT 'LECCIONES INSERTADAS EXITOSAMENTE';
PRINT '========================================';
PRINT 'Total de lecciones insertadas: 8';
PRINT '';
PRINT 'Lecciones del curso "Clases y Objetos":';
PRINT '1. Introducción a Clases y Objetos';
PRINT '2. Definición de Clases';
PRINT '3. Creación de Objetos e Instanciación';
PRINT '4. Campos y Propiedades';
PRINT '5. Métodos de Instancia y Estáticos';
PRINT '6. Modificadores de Acceso';
PRINT '7. El Operador this';
PRINT '8. Clases Anidadas y Clases Parciales';
GO

