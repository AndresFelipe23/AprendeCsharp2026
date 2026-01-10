-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Constructores y Destructores"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Constructores y Destructores" en la ruta con RutaId = 2
DECLARE @CursoId INT;
DECLARE @RutaId INT = 2; -- RutaId de "Programación Orientada a Objetos"
DECLARE @NombreCurso NVARCHAR(100) = 'Constructores y Destructores';

-- Buscar el curso "Constructores y Destructores" en la ruta con RutaId = 2
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
        'Aprende a usar constructores para inicializar objetos y destructores para limpiar recursos',
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
-- LECCIÓN 1: Introducción a Constructores
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Constructores',
    'Comprende qué son los constructores, cómo funcionan y por qué son esenciales en la creación de objetos.',
    'Un **constructor** es un método especial de una clase que se ejecuta automáticamente cuando se crea una instancia (objeto) de esa clase. Su propósito principal es **inicializar** el objeto con valores apropiados.

**¿Qué es un Constructor?**

Un constructor es un método que:
- Tiene el **mismo nombre** que la clase
- **No tiene tipo de retorno** (ni siquiera `void`)
- Se ejecuta **automáticamente** cuando se crea un objeto
- Puede recibir **parámetros** para inicializar el objeto

**Sintaxis Básica:**

```csharp
public class Persona
{
    private string nombre;
    private int edad;
    
    // Constructor
    public Persona(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
    }
}
```

**¿Por qué Necesitamos Constructores?**

1. **Inicialización Garantizada**: Asegura que el objeto tenga valores válidos desde el inicio
2. **Encapsulación**: Permite validar datos antes de asignarlos
3. **Flexibilidad**: Puedes tener múltiples formas de crear un objeto
4. **Simplicidad**: Evita tener que llamar métodos de inicialización manualmente

**Constructor por Defecto:**

Si no defines un constructor, C# crea automáticamente un **constructor sin parámetros** (constructor por defecto):

```csharp
public class Persona
{
    public string Nombre { get; set; }
    // C# crea automáticamente: public Persona() { }
}

// Puedes crear objetos sin parámetros
Persona p = new Persona();
```

**Constructor Personalizado:**

Cuando defines tu propio constructor, el constructor por defecto **ya no está disponible** a menos que lo definas explícitamente:

```csharp
public class Persona
{
    public Persona(string nombre)  // Constructor personalizado
    {
        Nombre = nombre;
    }
    // Ya no hay constructor sin parámetros
}

// Persona p = new Persona();  // ERROR: no existe constructor sin parámetros
Persona p = new Persona("Juan");  // OK
```

**Ventajas de los Constructores:**

- **Inicialización Automática**: Los objetos se crean en un estado válido
- **Validación**: Puedes validar datos antes de asignarlos
- **Flexibilidad**: Múltiples constructores para diferentes escenarios
- **Código Limpio**: Evita métodos de inicialización adicionales

**Ejemplo Práctico:**

```csharp
public class CuentaBancaria
{
    private double saldo;
    
    public CuentaBancaria(double saldoInicial)
    {
        if (saldoInicial < 0)
            throw new ArgumentException("El saldo inicial no puede ser negativo");
        saldo = saldoInicial;
    }
}
```',
    'using System;

// Ejemplo 1: Clase sin constructor (usa constructor por defecto)
public class PersonaSinConstructor
{
    public string Nombre { get; set; }
    public int Edad { get; set; }
    
    // C# crea automáticamente: public PersonaSinConstructor() { }
}

// Ejemplo 2: Clase con constructor personalizado
public class PersonaConConstructor
{
    private string nombre;
    private int edad;
    
    // Constructor personalizado
    public PersonaConConstructor(string nombre, int edad)
    {
        // Validación en el constructor
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        if (edad < 0 || edad > 120)
            throw new ArgumentException("La edad debe estar entre 0 y 120");
        
        this.nombre = nombre;
        this.edad = edad;
        
        Console.WriteLine($"Persona creada: {nombre}, {edad} años");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Nombre: {nombre}, Edad: {edad}");
    }
}

// Ejemplo 3: Constructor con validación
public class CuentaBancaria
{
    private double saldo;
    private string numeroCuenta;
    
    public CuentaBancaria(string numero, double saldoInicial)
    {
        if (string.IsNullOrWhiteSpace(numero))
            throw new ArgumentException("El número de cuenta no puede estar vacío");
        
        if (saldoInicial < 0)
            throw new ArgumentException("El saldo inicial no puede ser negativo");
        
        numeroCuenta = numero;
        saldo = saldoInicial;
        
        Console.WriteLine($"Cuenta {numeroCuenta} creada con saldo inicial: ${saldo:F2}");
    }
    
    public double ObtenerSaldo()
    {
        return saldo;
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Cuenta: {numeroCuenta}, Saldo: ${saldo:F2}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO 1: Sin Constructor (Constructor por Defecto) ===");
        PersonaSinConstructor persona1 = new PersonaSinConstructor();
        persona1.Nombre = "Juan";
        persona1.Edad = 25;
        Console.WriteLine($"{persona1.Nombre}, {persona1.Edad} años");
        
        Console.WriteLine("\n=== EJEMPLO 2: Con Constructor Personalizado ===");
        PersonaConConstructor persona2 = new PersonaConConstructor("María", 30);
        persona2.MostrarInformacion();
        
        // Intentar crear con datos inválidos
        try
        {
            PersonaConConstructor persona3 = new PersonaConConstructor("", 25);
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error al crear persona: {e.Message}");
        }
        
        Console.WriteLine("\n=== EJEMPLO 3: Constructor con Validación ===");
        CuentaBancaria cuenta1 = new CuentaBancaria("12345", 1000.0);
        cuenta1.MostrarInformacion();
        
        // Intentar crear cuenta con saldo negativo
        try
        {
            CuentaBancaria cuenta2 = new CuentaBancaria("67890", -100);
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error al crear cuenta: {e.Message}");
        }
        
        // No puedo crear sin parámetros (no hay constructor por defecto)
        // PersonaConConstructor persona4 = new PersonaConConstructor();  // ERROR
        // CuentaBancaria cuenta3 = new CuentaBancaria();  // ERROR
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Constructores con Parámetros
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Constructores con Parámetros',
    'Aprende a crear constructores que reciben parámetros para inicializar objetos con valores específicos.',
    'Los constructores pueden recibir **parámetros** para inicializar los campos y propiedades de un objeto con valores específicos al momento de su creación.

**Sintaxis de Constructor con Parámetros:**

```csharp
public class Persona
{
    private string nombre;
    private int edad;
    
    // Constructor con parámetros
    public Persona(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
    }
}
```

**Uso del Constructor:**

```csharp
// Crear objeto pasando parámetros
Persona persona = new Persona("Juan", 25);
```

**Ventajas de Constructores con Parámetros:**

1. **Inicialización Inmediata**: El objeto se crea con valores válidos
2. **Validación**: Puedes validar parámetros antes de asignarlos
3. **Flexibilidad**: Diferentes constructores para diferentes escenarios
4. **Código Más Limpio**: No necesitas llamar métodos de inicialización

**Ejemplo con Validación:**

```csharp
public class Producto
{
    private string nombre;
    private double precio;
    
    public Producto(string nombre, double precio)
    {
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        if (precio < 0)
            throw new ArgumentException("El precio no puede ser negativo");
        
        this.nombre = nombre;
        this.precio = precio;
    }
}
```

**Múltiples Parámetros:**

Los constructores pueden recibir múltiples parámetros:

```csharp
public class Estudiante
{
    private string nombre;
    private int edad;
    private string matricula;
    private double promedio;
    
    public Estudiante(string nombre, int edad, string matricula, double promedio)
    {
        this.nombre = nombre;
        this.edad = edad;
        this.matricula = matricula;
        this.promedio = promedio;
    }
}
```

**Usando el Operador `this`:**

El operador `this` ayuda a distinguir entre parámetros y campos con el mismo nombre:

```csharp
public class Persona
{
    private string nombre;  // Campo
    
    public Persona(string nombre)  // Parámetro
    {
        this.nombre = nombre;  // this.nombre es el campo, nombre es el parámetro
    }
}
```

**Buenas Prácticas:**

1. **Valida parámetros** en el constructor
2. **Inicializa todos los campos** necesarios
3. **Usa nombres descriptivos** para los parámetros
4. **Documenta** los constructores con comentarios XML',
    'using System;

// Ejemplo 1: Constructor con un parámetro
public class Persona
{
    private string nombre;
    
    public Persona(string nombre)
    {
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        this.nombre = nombre;
        Console.WriteLine($"Persona {nombre} creada");
    }
    
    public string ObtenerNombre()
    {
        return nombre;
    }
}

// Ejemplo 2: Constructor con múltiples parámetros
public class Estudiante
{
    private string nombre;
    private int edad;
    private string matricula;
    private double promedio;
    
    public Estudiante(string nombre, int edad, string matricula, double promedio)
    {
        // Validación de parámetros
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        if (edad < 0 || edad > 120)
            throw new ArgumentException("La edad debe estar entre 0 y 120");
        
        if (string.IsNullOrWhiteSpace(matricula))
            throw new ArgumentException("La matrícula no puede estar vacía");
        
        if (promedio < 0 || promedio > 10)
            throw new ArgumentException("El promedio debe estar entre 0 y 10");
        
        this.nombre = nombre;
        this.edad = edad;
        this.matricula = matricula;
        this.promedio = promedio;
        
        Console.WriteLine($"Estudiante {nombre} ({matricula}) creado");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Nombre: {nombre}");
        Console.WriteLine($"Edad: {edad}");
        Console.WriteLine($"Matrícula: {matricula}");
        Console.WriteLine($"Promedio: {promedio:F2}");
    }
}

// Ejemplo 3: Constructor con validación compleja
public class Rectangulo
{
    private double ancho;
    private double alto;
    
    public Rectangulo(double ancho, double alto)
    {
        if (ancho <= 0)
            throw new ArgumentException("El ancho debe ser mayor que cero");
        
        if (alto <= 0)
            throw new ArgumentException("La altura debe ser mayor que cero");
        
        this.ancho = ancho;
        this.alto = alto;
        
        Console.WriteLine($"Rectángulo creado: {ancho} x {alto}");
    }
    
    public double CalcularArea()
    {
        return ancho * alto;
    }
    
    public double CalcularPerimetro()
    {
        return 2 * (ancho + alto);
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Ancho: {ancho}, Alto: {alto}");
        Console.WriteLine($"Área: {CalcularArea():F2}");
        Console.WriteLine($"Perímetro: {CalcularPerimetro():F2}");
    }
}

// Ejemplo 4: Constructor con parámetros opcionales usando valores por defecto
public class Configuracion
{
    private string nombre;
    private int puerto;
    private bool activo;
    
    public Configuracion(string nombre, int puerto = 8080, bool activo = true)
    {
        this.nombre = nombre;
        this.puerto = puerto;
        this.activo = activo;
        
        Console.WriteLine($"Configuración {nombre} creada: Puerto {puerto}, Activo: {activo}");
    }
    
    public void MostrarConfiguracion()
    {
        Console.WriteLine($"Nombre: {nombre}, Puerto: {puerto}, Activo: {activo}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO 1: Constructor con un Parámetro ===");
        Persona persona = new Persona("Juan");
        Console.WriteLine($"Nombre: {persona.ObtenerNombre()}");
        
        Console.WriteLine("\n=== EJEMPLO 2: Constructor con Múltiples Parámetros ===");
        Estudiante estudiante = new Estudiante("María", 20, "2024-001", 8.5);
        estudiante.MostrarInformacion();
        
        Console.WriteLine("\n=== EJEMPLO 3: Constructor con Validación ===");
        Rectangulo rectangulo = new Rectangulo(5.0, 3.0);
        rectangulo.MostrarInformacion();
        
        // Intentar crear con valores inválidos
        try
        {
            Rectangulo rectanguloInvalido = new Rectangulo(-5, 3);
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
        
        Console.WriteLine("\n=== EJEMPLO 4: Constructor con Parámetros Opcionales ===");
        Configuracion config1 = new Configuracion("App1");
        config1.MostrarConfiguracion();
        
        Configuracion config2 = new Configuracion("App2", 3000);
        config2.MostrarConfiguracion();
        
        Configuracion config3 = new Configuracion("App3", 5000, false);
        config3.MostrarConfiguracion();
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Constructores Múltiples (Sobrecarga)
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Constructores Múltiples (Sobrecarga)',
    'Aprende a crear múltiples constructores en una clase para diferentes formas de inicializar objetos.',
    'Una clase puede tener **múltiples constructores** con diferentes parámetros. Esto se llama **sobrecarga de constructores** y permite crear objetos de diferentes maneras según tus necesidades.

**¿Qué es la Sobrecarga de Constructores?**

La sobrecarga permite definir varios constructores en la misma clase, cada uno con una firma diferente (diferentes tipos o cantidad de parámetros).

**Sintaxis:**

```csharp
public class Persona
{
    private string nombre;
    private int edad;
    
    // Constructor 1: Sin parámetros
    public Persona()
    {
        nombre = "Sin nombre";
        edad = 0;
    }
    
    // Constructor 2: Con nombre
    public Persona(string nombre)
    {
        this.nombre = nombre;
        edad = 0;
    }
    
    // Constructor 3: Con nombre y edad
    public Persona(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
    }
}
```

**Uso de Constructores Sobrecargados:**

```csharp
Persona p1 = new Persona();  // Usa constructor 1
Persona p2 = new Persona("Juan");  // Usa constructor 2
Persona p3 = new Persona("María", 25);  // Usa constructor 3
```

**Encadenamiento de Constructores:**

Puedes llamar a otro constructor desde un constructor usando `this`:

```csharp
public class Persona
{
    private string nombre;
    private int edad;
    
    public Persona() : this("Sin nombre", 0)
    {
        // Llama al constructor con 2 parámetros
    }
    
    public Persona(string nombre) : this(nombre, 0)
    {
        // Llama al constructor con 2 parámetros
    }
    
    public Persona(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
    }
}
```

**Ventajas:**

1. **Flexibilidad**: Múltiples formas de crear objetos
2. **Conveniencia**: Valores por defecto cuando no se especifican
3. **Código Reutilizable**: Encadenamiento evita duplicación
4. **Compatibilidad**: Soporta diferentes escenarios de uso

**Buenas Prácticas:**

- Usa encadenamiento para evitar duplicación de código
- Proporciona valores por defecto razonables
- Valida parámetros en el constructor principal
- Documenta cada constructor con comentarios',
    'using System;

// Ejemplo: Múltiples constructores para diferentes escenarios
public class Persona
{
    private string nombre;
    private int edad;
    private string email;
    
    // Constructor 1: Sin parámetros (valores por defecto)
    public Persona()
    {
        nombre = "Sin nombre";
        edad = 0;
        email = "";
        Console.WriteLine("Persona creada con valores por defecto");
    }
    
    // Constructor 2: Solo con nombre
    public Persona(string nombre)
    {
        this.nombre = nombre;
        edad = 0;
        email = "";
        Console.WriteLine($"Persona {nombre} creada");
    }
    
    // Constructor 3: Con nombre y edad
    public Persona(string nombre, int edad)
    {
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        if (edad < 0)
            throw new ArgumentException("La edad no puede ser negativa");
        
        this.nombre = nombre;
        this.edad = edad;
        email = "";
        Console.WriteLine($"Persona {nombre}, {edad} años creada");
    }
    
    // Constructor 4: Con todos los parámetros
    public Persona(string nombre, int edad, string email)
    {
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        if (edad < 0)
            throw new ArgumentException("La edad no puede ser negativa");
        
        if (!string.IsNullOrWhiteSpace(email) && !email.Contains("@"))
            throw new ArgumentException("Email inválido");
        
        this.nombre = nombre;
        this.edad = edad;
        this.email = email;
        Console.WriteLine($"Persona {nombre}, {edad} años, {email} creada");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Nombre: {nombre}, Edad: {edad}, Email: {email}");
    }
}

// Ejemplo con encadenamiento de constructores
public class Producto
{
    private string nombre;
    private double precio;
    private int stock;
    
    // Constructor principal (con todos los parámetros)
    public Producto(string nombre, double precio, int stock)
    {
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        if (precio < 0)
            throw new ArgumentException("El precio no puede ser negativo");
        
        if (stock < 0)
            throw new ArgumentException("El stock no puede ser negativo");
        
        this.nombre = nombre;
        this.precio = precio;
        this.stock = stock;
        
        Console.WriteLine($"Producto {nombre} creado: ${precio:F2}, Stock: {stock}");
    }
    
    // Constructor que llama al principal con stock 0
    public Producto(string nombre, double precio) : this(nombre, precio, 0)
    {
        // El código aquí se ejecuta después del constructor principal
        Console.WriteLine("  (Stock inicializado en 0)");
    }
    
    // Constructor que llama al principal con precio y stock en 0
    public Producto(string nombre) : this(nombre, 0, 0)
    {
        Console.WriteLine("  (Precio y stock inicializados en 0)");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Producto: {nombre}, Precio: ${precio:F2}, Stock: {stock}");
    }
}

// Ejemplo: Constructores para diferentes tipos de cuentas
public class CuentaBancaria
{
    private string numeroCuenta;
    private double saldo;
    private string tipo;
    
    // Constructor para cuenta nueva (sin saldo)
    public CuentaBancaria(string numeroCuenta)
    {
        this.numeroCuenta = numeroCuenta;
        saldo = 0;
        tipo = "Corriente";
        Console.WriteLine($"Cuenta {numeroCuenta} creada (nueva)");
    }
    
    // Constructor para cuenta con saldo inicial
    public CuentaBancaria(string numeroCuenta, double saldoInicial)
    {
        if (saldoInicial < 0)
            throw new ArgumentException("El saldo inicial no puede ser negativo");
        
        this.numeroCuenta = numeroCuenta;
        saldo = saldoInicial;
        tipo = "Corriente";
        Console.WriteLine($"Cuenta {numeroCuenta} creada con saldo: ${saldo:F2}");
    }
    
    // Constructor para cuenta con tipo específico
    public CuentaBancaria(string numeroCuenta, double saldoInicial, string tipo)
    {
        if (saldoInicial < 0)
            throw new ArgumentException("El saldo inicial no puede ser negativo");
        
        this.numeroCuenta = numeroCuenta;
        saldo = saldoInicial;
        this.tipo = tipo;
        Console.WriteLine($"Cuenta {tipo} {numeroCuenta} creada con saldo: ${saldo:F2}");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Cuenta: {numeroCuenta}, Tipo: {tipo}, Saldo: ${saldo:F2}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO 1: Múltiples Constructores ===");
        Persona p1 = new Persona();
        p1.MostrarInformacion();
        
        Persona p2 = new Persona("Juan");
        p2.MostrarInformacion();
        
        Persona p3 = new Persona("María", 25);
        p3.MostrarInformacion();
        
        Persona p4 = new Persona("Pedro", 30, "pedro@example.com");
        p4.MostrarInformacion();
        
        Console.WriteLine("\n=== EJEMPLO 2: Encadenamiento de Constructores ===");
        Producto prod1 = new Producto("Laptop", 999.99, 10);
        prod1.MostrarInformacion();
        
        Producto prod2 = new Producto("Mouse", 25.50);
        prod2.MostrarInformacion();
        
        Producto prod3 = new Producto("Teclado");
        prod3.MostrarInformacion();
        
        Console.WriteLine("\n=== EJEMPLO 3: Constructores para Diferentes Escenarios ===");
        CuentaBancaria cuenta1 = new CuentaBancaria("001");
        cuenta1.MostrarInformacion();
        
        CuentaBancaria cuenta2 = new CuentaBancaria("002", 1000);
        cuenta2.MostrarInformacion();
        
        CuentaBancaria cuenta3 = new CuentaBancaria("003", 5000, "Ahorros");
        cuenta3.MostrarInformacion();
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Constructor Estático
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Constructor Estático',
    'Aprende a usar constructores estáticos para inicializar miembros estáticos de una clase.',
    'Un **constructor estático** es un constructor especial que se ejecuta **una sola vez** antes de que se cree cualquier instancia de la clase o se acceda a cualquier miembro estático. Se usa para inicializar miembros estáticos.

**Características del Constructor Estático:**

- Se ejecuta **automáticamente** antes del primer uso de la clase
- Se ejecuta **solo una vez** durante la vida de la aplicación
- **No tiene modificadores de acceso** (siempre privado implícitamente)
- **No puede tener parámetros**
- **No puede ser llamado explícitamente**

**Sintaxis:**

```csharp
public class MiClase
{
    private static int contador;
    private static string mensaje;
    
    // Constructor estático
    static MiClase()
    {
        contador = 0;
        mensaje = "Clase inicializada";
        Console.WriteLine("Constructor estático ejecutado");
    }
    
    // Constructor de instancia
    public MiClase()
    {
        contador++;
    }
}
```

**Cuándo Usar Constructor Estático:**

1. **Inicializar campos estáticos** con valores complejos
2. **Cargar configuración** antes del primer uso
3. **Inicializar recursos compartidos**
4. **Validar condiciones** antes de usar la clase

**Orden de Ejecución:**

1. Constructor estático (una vez)
2. Constructor de instancia (cada vez que se crea un objeto)

**Ejemplo Práctico:**

```csharp
public class Configuracion
{
    private static string nombreAplicacion;
    private static DateTime fechaInicio;
    
    static Configuracion()
    {
        nombreAplicacion = "Mi Aplicación";
        fechaInicio = DateTime.Now;
        Console.WriteLine("Configuración inicializada");
    }
    
    public static string ObtenerNombre()
    {
        return nombreAplicacion;
    }
}
```

**Ventajas:**

- **Inicialización Automática**: No necesitas llamar métodos de inicialización
- **Thread-Safe**: Se ejecuta de forma segura en entornos multi-hilo
- **Una Sola Vez**: Garantiza que la inicialización ocurre solo una vez
- **Automático**: No necesitas recordar inicializar manualmente',
    'using System;
using System.Collections.Generic;

// Ejemplo 1: Constructor estático básico
public class Contador
{
    private static int totalInstancias;
    private static DateTime fechaInicio;
    private static List<string> historial;
    
    // Constructor estático
    static Contador()
    {
        totalInstancias = 0;
        fechaInicio = DateTime.Now;
        historial = new List<string>();
        
        Console.WriteLine("Constructor estático de Contador ejecutado");
        Console.WriteLine($"Fecha de inicio: {fechaInicio:yyyy-MM-dd HH:mm:ss}");
    }
    
    // Constructor de instancia
    public Contador()
    {
        totalInstancias++;
        historial.Add($"Instancia {totalInstancias} creada a las {DateTime.Now:HH:mm:ss}");
        Console.WriteLine($"Contador creado. Total de instancias: {totalInstancias}");
    }
    
    public static int ObtenerTotalInstancias()
    {
        return totalInstancias;
    }
    
    public static DateTime ObtenerFechaInicio()
    {
        return fechaInicio;
    }
    
    public static void MostrarHistorial()
    {
        Console.WriteLine("Historial de creación:");
        foreach (var entrada in historial)
        {
            Console.WriteLine($"  - {entrada}");
        }
    }
}

// Ejemplo 2: Constructor estático para configuración
public class ConfiguracionAplicacion
{
    private static string nombreAplicacion;
    private static string version;
    private static bool modoDebug;
    private static Dictionary<string, string> configuraciones;
    
    static ConfiguracionAplicacion()
    {
        nombreAplicacion = "Mi Aplicación";
        version = "1.0.0";
        modoDebug = true;
        
        configuraciones = new Dictionary<string, string>();
        configuraciones["Idioma"] = "es";
        configuraciones["Tema"] = "oscuro";
        configuraciones["Timeout"] = "30";
        
        Console.WriteLine("Configuración de aplicación inicializada");
        Console.WriteLine($"Aplicación: {nombreAplicacion} v{version}");
    }
    
    public static string ObtenerNombre()
    {
        return nombreAplicacion;
    }
    
    public static string ObtenerVersion()
    {
        return version;
    }
    
    public static bool EstaEnModoDebug()
    {
        return modoDebug;
    }
    
    public static string ObtenerConfiguracion(string clave)
    {
        return configuraciones.ContainsKey(clave) ? configuraciones[clave] : null;
    }
    
    public static void MostrarConfiguraciones()
    {
        Console.WriteLine("Configuraciones:");
        foreach (var config in configuraciones)
        {
            Console.WriteLine($"  {config.Key}: {config.Value}");
        }
    }
}

// Ejemplo 3: Constructor estático para inicialización compleja
public class Calculadora
{
    private static Dictionary<string, Func<double, double, double>> operaciones;
    
    static Calculadora()
    {
        operaciones = new Dictionary<string, Func<double, double, double>>();
        
        // Registrar operaciones
        operaciones["suma"] = (a, b) => a + b;
        operaciones["resta"] = (a, b) => a - b;
        operaciones["multiplicacion"] = (a, b) => a * b;
        operaciones["division"] = (a, b) => b != 0 ? a / b : throw new DivideByZeroException();
        
        Console.WriteLine("Calculadora inicializada con operaciones básicas");
    }
    
    public static double EjecutarOperacion(string operacion, double a, double b)
    {
        if (operaciones.ContainsKey(operacion.ToLower()))
        {
            return operaciones[operacion.ToLower()](a, b);
        }
        throw new ArgumentException($"Operación {operacion} no encontrada");
    }
    
    public static void MostrarOperacionesDisponibles()
    {
        Console.WriteLine("Operaciones disponibles:");
        foreach (var op in operaciones.Keys)
        {
            Console.WriteLine($"  - {op}");
        }
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO 1: Constructor Estático Básico ===");
        // El constructor estático se ejecuta aquí (antes de crear instancias)
        Console.WriteLine($"Total de instancias antes: {Contador.ObtenerTotalInstancias()}");
        
        Contador c1 = new Contador();
        Contador c2 = new Contador();
        Contador c3 = new Contador();
        
        Console.WriteLine($"Total de instancias: {Contador.ObtenerTotalInstancias()}");
        Contador.MostrarHistorial();
        
        Console.WriteLine("\n=== EJEMPLO 2: Constructor Estático para Configuración ===");
        // El constructor estático se ejecuta al acceder a la clase
        Console.WriteLine($"Aplicación: {ConfiguracionAplicacion.ObtenerNombre()}");
        Console.WriteLine($"Versión: {ConfiguracionAplicacion.ObtenerVersion()}");
        Console.WriteLine($"Modo Debug: {ConfiguracionAplicacion.EstaEnModoDebug()}");
        ConfiguracionAplicacion.MostrarConfiguraciones();
        
        Console.WriteLine("\n=== EJEMPLO 3: Constructor Estático para Inicialización Compleja ===");
        Calculadora.MostrarOperacionesDisponibles();
        
        Console.WriteLine($"5 + 3 = {Calculadora.EjecutarOperacion("suma", 5, 3)}");
        Console.WriteLine($"10 - 4 = {Calculadora.EjecutarOperacion("resta", 10, 4)}");
        Console.WriteLine($"6 * 7 = {Calculadora.EjecutarOperacion("multiplicacion", 6, 7)}");
        Console.WriteLine($"15 / 3 = {Calculadora.EjecutarOperacion("division", 15, 3)}");
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Destructores
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Destructores',
    'Aprende qué son los destructores, cuándo se ejecutan y cómo usarlos para limpiar recursos.',
    'Un **destructor** es un método especial que se ejecuta automáticamente cuando un objeto está a punto de ser destruido por el recolector de basura (Garbage Collector). Se usa principalmente para **liberar recursos** no administrados.

**¿Qué es un Destructor?**

Un destructor es un método que:
- Tiene el **mismo nombre** que la clase, precedido por `~`
- **No tiene modificadores de acceso** (siempre privado implícitamente)
- **No tiene parámetros**
- **No puede ser llamado explícitamente**
- Se ejecuta **automáticamente** cuando el objeto es recolectado

**Sintaxis:**

```csharp
public class MiClase
{
    // Destructor
    ~MiClase()
    {
        // Código de limpieza
        Console.WriteLine("Destructor ejecutado");
    }
}
```

**Cuándo se Ejecuta el Destructor:**

El destructor se ejecuta cuando:
- El objeto **ya no es referenciado**
- El **Garbage Collector** decide recolectar el objeto
- **No hay garantía** de cuándo exactamente ocurrirá
- Puede ejecutarse en un **hilo diferente**

**Importante:**

- **No confíes** en el destructor para liberar recursos críticos
- El momento de ejecución **no es determinístico**
- Usa el patrón **IDisposable** para recursos que deben liberarse inmediatamente

**Cuándo Usar Destructores:**

1. **Logging**: Registrar cuando un objeto es destruido
2. **Cerrar conexiones**: Si olvidaste cerrar una conexión
3. **Liberar recursos no administrados**: Como último recurso
4. **Debugging**: Para rastrear el ciclo de vida de objetos

**Ejemplo Básico:**

```csharp
public class Archivo
{
    private string nombre;
    
    public Archivo(string nombre)
    {
        this.nombre = nombre;
        Console.WriteLine($"Archivo {nombre} abierto");
    }
    
    ~Archivo()
    {
        Console.WriteLine($"Archivo {nombre} cerrado (destructor)");
    }
}
```

**Mejores Prácticas:**

- **Evita destructores** si es posible
- Usa **IDisposable** para liberar recursos
- **No lances excepciones** en destructores
- **No hagas trabajo pesado** en destructores
- **No referencies otros objetos** que puedan estar siendo recolectados',
    'using System;

// Ejemplo 1: Destructor básico
public class Recurso
{
    private string nombre;
    private static int totalRecursos = 0;
    
    public Recurso(string nombre)
    {
        this.nombre = nombre;
        totalRecursos++;
        Console.WriteLine($"Recurso {nombre} creado. Total: {totalRecursos}");
    }
    
    // Destructor
    ~Recurso()
    {
        totalRecursos--;
        Console.WriteLine($"Recurso {nombre} destruido. Total restante: {totalRecursos}");
    }
    
    public void Usar()
    {
        Console.WriteLine($"Usando recurso {nombre}");
    }
}

// Ejemplo 2: Destructor para limpieza de recursos
public class ConexionBaseDatos
{
    private string servidor;
    private bool conectado;
    
    public ConexionBaseDatos(string servidor)
    {
        this.servidor = servidor;
        Conectar();
    }
    
    private void Conectar()
    {
        conectado = true;
        Console.WriteLine($"Conectado a {servidor}");
    }
    
    public void Desconectar()
    {
        if (conectado)
        {
            conectado = false;
            Console.WriteLine($"Desconectado de {servidor}");
        }
    }
    
    // Destructor: asegura que la conexión se cierre
    ~ConexionBaseDatos()
    {
        if (conectado)
        {
            Console.WriteLine($"ADVERTENCIA: Conexión a {servidor} no fue cerrada explícitamente. Cerrando en destructor...");
            Desconectar();
        }
    }
    
    public void EjecutarConsulta(string consulta)
    {
        if (!conectado)
            throw new InvalidOperationException("No hay conexión activa");
        
        Console.WriteLine($"Ejecutando: {consulta}");
    }
}

// Ejemplo 3: Destructor con logging
public class Transaccion
{
    private int id;
    private DateTime fechaInicio;
    private static int contador = 0;
    
    public Transaccion()
    {
        contador++;
        id = contador;
        fechaInicio = DateTime.Now;
        Console.WriteLine($"Transacción {id} iniciada a las {fechaInicio:HH:mm:ss}");
    }
    
    public void Completar()
    {
        Console.WriteLine($"Transacción {id} completada");
    }
    
    // Destructor: registra si la transacción no fue completada
    ~Transaccion()
    {
        var duracion = DateTime.Now - fechaInicio;
        Console.WriteLine($"Transacción {id} finalizada (no completada explícitamente). Duración: {duracion.TotalSeconds:F2}s");
    }
}

// Ejemplo 4: Demostración del orden de ejecución
public class OrdenEjecucion
{
    private string nombre;
    
    public OrdenEjecucion(string nombre)
    {
        this.nombre = nombre;
        Console.WriteLine($"Constructor de {nombre} ejecutado");
    }
    
    ~OrdenEjecucion()
    {
        Console.WriteLine($"Destructor de {nombre} ejecutado");
    }
    
    public void Metodo()
    {
        Console.WriteLine($"Método de {nombre} ejecutado");
    }
}

class Program
{
    static void CrearYDestruir()
    {
        Console.WriteLine("=== Creando objeto dentro de método ===");
        Recurso recurso = new Recurso("Temporal");
        recurso.Usar();
        // El objeto será elegible para recolección cuando el método termine
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO 1: Destructor Básico ===");
        Recurso r1 = new Recurso("Recurso 1");
        Recurso r2 = new Recurso("Recurso 2");
        
        r1.Usar();
        r2.Usar();
        
        // Hacer que los objetos sean elegibles para recolección
        r1 = null;
        r2 = null;
        
        // Forzar recolección de basura (solo para demostración)
        Console.WriteLine("\nForzando recolección de basura...");
        GC.Collect();
        GC.WaitForPendingFinalizers();
        
        Console.WriteLine("\n=== EJEMPLO 2: Destructor para Limpieza ===");
        ConexionBaseDatos conexion1 = new ConexionBaseDatos("Servidor1");
        conexion1.EjecutarConsulta("SELECT * FROM usuarios");
        conexion1.Desconectar();  // Cierre explícito
        
        ConexionBaseDatos conexion2 = new ConexionBaseDatos("Servidor2");
        conexion2.EjecutarConsulta("SELECT * FROM productos");
        // No se cierra explícitamente - el destructor lo hará
        
        conexion2 = null;
        GC.Collect();
        GC.WaitForPendingFinalizers();
        
        Console.WriteLine("\n=== EJEMPLO 3: Destructor con Logging ===");
        Transaccion t1 = new Transaccion();
        t1.Completar();
        
        Transaccion t2 = new Transaccion();
        // No se completa explícitamente
        
        t2 = null;
        GC.Collect();
        GC.WaitForPendingFinalizers();
        
        Console.WriteLine("\n=== EJEMPLO 4: Orden de Ejecución ===");
        CrearYDestruir();
        
        Console.WriteLine("\nForzando recolección...");
        GC.Collect();
        GC.WaitForPendingFinalizers();
        
        Console.WriteLine("\n=== NOTA IMPORTANTE ===");
        Console.WriteLine("Los destructores se ejecutan de forma no determinística.");
        Console.WriteLine("Para liberar recursos críticos, usa el patrón IDisposable.");
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Patrón IDisposable
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Patrón IDisposable',
    'Aprende a usar el patrón IDisposable para liberar recursos de manera determinística y controlada.',
    'El patrón **IDisposable** es la forma recomendada en C# para liberar recursos de manera **determinística** y **controlada**. Es superior a los destructores porque garantiza cuándo se ejecuta la limpieza.

**¿Qué es IDisposable?**

`IDisposable` es una interfaz que define un método `Dispose()` para liberar recursos no administrados. Permite liberar recursos **inmediatamente** cuando ya no se necesitan, en lugar de esperar al Garbage Collector.

**Sintaxis:**

```csharp
public class MiClase : IDisposable
{
    private bool disposed = false;
    
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
    
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                // Liberar recursos administrados
            }
            // Liberar recursos no administrados
            disposed = true;
        }
    }
    
    ~MiClase()
    {
        Dispose(false);
    }
}
```

**Uso con `using`:**

C# proporciona la palabra clave `using` para garantizar que `Dispose()` se llame automáticamente:

```csharp
using (var recurso = new MiClase())
{
    // Usar el recurso
} // Dispose() se llama automáticamente aquí
```

**Ventajas sobre Destructores:**

1. **Determinístico**: Se ejecuta cuando tú lo decides
2. **Inmediato**: Libera recursos de inmediato
3. **Controlado**: Tú controlas cuándo se libera
4. **Mejor Rendimiento**: No espera al Garbage Collector

**Cuándo Usar IDisposable:**

- Archivos abiertos
- Conexiones de base de datos
- Streams de red
- Handles del sistema operativo
- Cualquier recurso no administrado

**Patrón Estándar:**

```csharp
public class Recurso : IDisposable
{
    private bool disposed = false;
    
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
    
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                // Liberar recursos administrados
            }
            // Liberar recursos no administrados
            disposed = true;
        }
    }
    
    ~Recurso()
    {
        Dispose(false);
    }
}
```

**Buenas Prácticas:**

1. Implementa `IDisposable` cuando tengas recursos no administrados
2. Usa `using` siempre que sea posible
3. Llama a `Dispose()` explícitamente si no usas `using`
4. Implementa el patrón completo con `disposed` flag
5. Suprime la finalización si implementas `Dispose()` correctamente',
    'using System;
using System.IO;

// Ejemplo 1: Implementación básica de IDisposable
public class ArchivoTemporal : IDisposable
{
    private string rutaArchivo;
    private FileStream stream;
    private bool disposed = false;
    
    public ArchivoTemporal(string ruta)
    {
        rutaArchivo = ruta;
        stream = new FileStream(ruta, FileMode.Create);
        Console.WriteLine($"Archivo {ruta} creado y abierto");
    }
    
    public void Escribir(string contenido)
    {
        if (disposed)
            throw new ObjectDisposedException(nameof(ArchivoTemporal));
        
        byte[] bytes = System.Text.Encoding.UTF8.GetBytes(contenido);
        stream.Write(bytes, 0, bytes.Length);
        Console.WriteLine($"Contenido escrito en {rutaArchivo}");
    }
    
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
    
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                // Liberar recursos administrados
                if (stream != null)
                {
                    stream.Close();
                    stream.Dispose();
                    Console.WriteLine($"Stream de {rutaArchivo} cerrado");
                }
            }
            
            // Liberar recursos no administrados (si los hay)
            // En este caso, el FileStream ya maneja los recursos no administrados
            
            disposed = true;
            Console.WriteLine($"ArchivoTemporal {rutaArchivo} liberado");
        }
    }
    
    ~ArchivoTemporal()
    {
        Dispose(false);
    }
}

// Ejemplo 2: Conexión de base de datos simulada
public class ConexionBD : IDisposable
{
    private string servidor;
    private bool conectado;
    private bool disposed = false;
    
    public ConexionBD(string servidor)
    {
        this.servidor = servidor;
        Conectar();
    }
    
    private void Conectar()
    {
        conectado = true;
        Console.WriteLine($"Conectado a {servidor}");
    }
    
    public void EjecutarConsulta(string consulta)
    {
        if (disposed)
            throw new ObjectDisposedException(nameof(ConexionBD));
        
        if (!conectado)
            throw new InvalidOperationException("No hay conexión activa");
        
        Console.WriteLine($"Ejecutando consulta: {consulta}");
    }
    
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
    
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                // Liberar recursos administrados
                if (conectado)
                {
                    Desconectar();
                }
            }
            
            disposed = true;
        }
    }
    
    private void Desconectar()
    {
        conectado = false;
        Console.WriteLine($"Desconectado de {servidor}");
    }
    
    ~ConexionBD()
    {
        Dispose(false);
    }
}

// Ejemplo 3: Múltiples recursos
public class GestorRecursos : IDisposable
{
    private FileStream archivo;
    private ConexionBD conexion;
    private bool disposed = false;
    
    public GestorRecursos(string rutaArchivo, string servidor)
    {
        archivo = new FileStream(rutaArchivo, FileMode.OpenOrCreate);
        conexion = new ConexionBD(servidor);
        Console.WriteLine("GestorRecursos creado");
    }
    
    public void Procesar()
    {
        if (disposed)
            throw new ObjectDisposedException(nameof(GestorRecursos));
        
        Console.WriteLine("Procesando recursos...");
        conexion.EjecutarConsulta("SELECT * FROM datos");
    }
    
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
    
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                // Liberar recursos administrados
                archivo?.Dispose();
                conexion?.Dispose();
                Console.WriteLine("Todos los recursos liberados");
            }
            
            disposed = true;
        }
    }
    
    ~GestorRecursos()
    {
        Dispose(false);
    }
}

class Program
{
    static void EjemploConUsing()
    {
        Console.WriteLine("=== EJEMPLO: Uso con using ===");
        
        // using garantiza que Dispose() se llame automáticamente
        using (var archivo = new ArchivoTemporal("temp1.txt"))
        {
            archivo.Escribir("Contenido temporal");
            // Dispose() se llama automáticamente al salir del bloque
        }
        
        Console.WriteLine("Bloque using terminado, recurso liberado automáticamente");
    }
    
    static void EjemploSinUsing()
    {
        Console.WriteLine("\n=== EJEMPLO: Uso sin using (llamada explícita) ===");
        
        ConexionBD conexion = new ConexionBD("Servidor1");
        try
        {
            conexion.EjecutarConsulta("SELECT * FROM usuarios");
        }
        finally
        {
            conexion.Dispose();  // Llamada explícita
        }
    }
    
    static void Main()
    {
        EjemploConUsing();
        EjemploSinUsing();
        
        Console.WriteLine("\n=== EJEMPLO: Múltiples Recursos ===");
        using (var gestor = new GestorRecursos("datos.txt", "Servidor2"))
        {
            gestor.Procesar();
        }
        
        Console.WriteLine("\n=== VENTAJAS DE IDisposable ===");
        Console.WriteLine("1. Liberación determinística de recursos");
        Console.WriteLine("2. Uso de la palabra clave using");
        Console.WriteLine("3. Mejor rendimiento que destructores");
        Console.WriteLine("4. Control explícito sobre cuándo liberar recursos");
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Constructores en Herencia
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Constructores en Herencia',
    'Aprende cómo funcionan los constructores cuando una clase hereda de otra y cómo usar base().',
    'Cuando una clase **hereda** de otra, los constructores tienen un comportamiento especial. La clase derivada debe llamar al constructor de la clase base usando la palabra clave `base`.

**Orden de Ejecución:**

Cuando creas una instancia de una clase derivada:
1. Se ejecuta el **constructor de la clase base** primero
2. Luego se ejecuta el **constructor de la clase derivada**

**Sintaxis con `base`:**

```csharp
public class Base
{
    protected string nombre;
    
    public Base(string nombre)
    {
        this.nombre = nombre;
    }
}

public class Derivada : Base
{
    private int edad;
    
    public Derivada(string nombre, int edad) : base(nombre)
    {
        this.edad = edad;
    }
}
```

**Constructor por Defecto:**

Si la clase base tiene un constructor sin parámetros, se llama automáticamente:

```csharp
public class Base
{
    public Base()  // Constructor sin parámetros
    {
        Console.WriteLine("Constructor de Base");
    }
}

public class Derivada : Base
{
    public Derivada()  // Llama automáticamente a Base()
    {
        Console.WriteLine("Constructor de Derivada");
    }
}
```

**Si la Clase Base NO tiene Constructor sin Parámetros:**

Debes llamar explícitamente a un constructor de la clase base:

```csharp
public class Base
{
    public Base(string nombre)  // Solo tiene constructor con parámetros
    {
        // ...
    }
}

public class Derivada : Base
{
    public Derivada(string nombre, int edad) : base(nombre)  // DEBE llamar a base()
    {
        this.edad = edad;
    }
}
```

**Encadenamiento de Constructores:**

Puedes encadenar constructores tanto en la clase base como en la derivada:

```csharp
public class Base
{
    public Base() : this("Sin nombre") { }
    public Base(string nombre) { }
}

public class Derivada : Base
{
    public Derivada() : this(0) { }
    public Derivada(int edad) : base("Sin nombre") { }
    public Derivada(string nombre, int edad) : base(nombre) { }
}
```

**Buenas Prácticas:**

1. **Siempre inicializa la clase base** antes de la derivada
2. **Usa `base()`** cuando la clase base requiere parámetros
3. **Pasa los parámetros necesarios** a la clase base
4. **Documenta** los constructores en jerarquías de herencia',
    'using System;

// Clase base
public class Vehiculo
{
    protected string marca;
    protected string modelo;
    protected int año;
    
    // Constructor de la clase base
    public Vehiculo(string marca, string modelo, int año)
    {
        this.marca = marca;
        this.modelo = modelo;
        this.año = año;
        Console.WriteLine($"Vehiculo base creado: {marca} {modelo} ({año})");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Marca: {marca}, Modelo: {modelo}, Año: {año}");
    }
}

// Clase derivada
public class Automovil : Vehiculo
{
    private int numeroPuertas;
    
    // Constructor que llama al constructor de la clase base
    public Automovil(string marca, string modelo, int año, int numeroPuertas) 
        : base(marca, modelo, año)  // Llama al constructor de Vehiculo
    {
        this.numeroPuertas = numeroPuertas;
        Console.WriteLine($"Automovil creado con {numeroPuertas} puertas");
    }
    
    public void MostrarInformacionCompleta()
    {
        MostrarInformacion();  // Llama al método de la clase base
        Console.WriteLine($"Número de puertas: {numeroPuertas}");
    }
}

// Otra clase derivada
public class Motocicleta : Vehiculo
{
    private int cilindrada;
    
    public Motocicleta(string marca, string modelo, int año, int cilindrada) 
        : base(marca, modelo, año)
    {
        this.cilindrada = cilindrada;
        Console.WriteLine($"Motocicleta creada con {cilindrada}cc");
    }
    
    public void MostrarInformacionCompleta()
    {
        MostrarInformacion();
        Console.WriteLine($"Cilindrada: {cilindrada}cc");
    }
}

// Ejemplo con constructor por defecto
public class Persona
{
    protected string nombre;
    
    // Constructor sin parámetros
    public Persona()
    {
        nombre = "Sin nombre";
        Console.WriteLine("Persona base creada (sin parámetros)");
    }
    
    // Constructor con parámetros
    public Persona(string nombre)
    {
        this.nombre = nombre;
        Console.WriteLine($"Persona base creada: {nombre}");
    }
}

public class Empleado : Persona
{
    private string puesto;
    
    // Llama automáticamente a Persona() (constructor sin parámetros)
    public Empleado()
    {
        puesto = "Sin puesto";
        Console.WriteLine("Empleado creado (sin parámetros)");
    }
    
    // Llama explícitamente a Persona(string)
    public Empleado(string nombre, string puesto) : base(nombre)
    {
        this.puesto = puesto;
        Console.WriteLine($"Empleado creado: {nombre}, {puesto}");
    }
}

// Ejemplo con encadenamiento
public class Animal
{
    protected string nombre;
    protected int edad;
    
    public Animal() : this("Sin nombre", 0)
    {
        Console.WriteLine("Animal() llamado");
    }
    
    public Animal(string nombre) : this(nombre, 0)
    {
        Console.WriteLine($"Animal(string) llamado: {nombre}");
    }
    
    public Animal(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
        Console.WriteLine($"Animal(string, int) llamado: {nombre}, {edad}");
    }
}

public class Perro : Animal
{
    private string raza;
    
    public Perro() : this("Sin raza")
    {
        Console.WriteLine("Perro() llamado");
    }
    
    public Perro(string raza) : base("Sin nombre")
    {
        this.raza = raza;
        Console.WriteLine($"Perro(string) llamado: {raza}");
    }
    
    public Perro(string nombre, int edad, string raza) : base(nombre, edad)
    {
        this.raza = raza;
        Console.WriteLine($"Perro(string, int, string) llamado: {nombre}, {edad}, {raza}");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Perro: {nombre}, {edad} años, Raza: {raza}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO 1: Herencia Básica ===");
        Automovil auto = new Automovil("Toyota", "Corolla", 2023, 4);
        auto.MostrarInformacionCompleta();
        
        Console.WriteLine("\n=== EJEMPLO 2: Otra Clase Derivada ===");
        Motocicleta moto = new Motocicleta("Honda", "CBR", 2023, 600);
        moto.MostrarInformacionCompleta();
        
        Console.WriteLine("\n=== EJEMPLO 3: Constructor por Defecto ===");
        Empleado emp1 = new Empleado();
        Console.WriteLine($"Empleado: {emp1.GetType().Name}");
        
        Empleado emp2 = new Empleado("Juan", "Desarrollador");
        Console.WriteLine($"Empleado: {emp2.GetType().Name}");
        
        Console.WriteLine("\n=== EJEMPLO 4: Encadenamiento Complejo ===");
        Console.WriteLine("--- Creando Perro() ---");
        Perro perro1 = new Perro();
        perro1.MostrarInformacion();
        
        Console.WriteLine("\n--- Creando Perro(string) ---");
        Perro perro2 = new Perro("Labrador");
        perro2.MostrarInformacion();
        
        Console.WriteLine("\n--- Creando Perro(string, int, string) ---");
        Perro perro3 = new Perro("Max", 5, "Golden Retriever");
        perro3.MostrarInformacion();
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Mejores Prácticas con Constructores y Destructores
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Mejores Prácticas con Constructores y Destructores',
    'Aprende las mejores prácticas y patrones comunes para usar constructores y destructores efectivamente.',
    'Usar constructores y destructores correctamente requiere seguir ciertas prácticas establecidas. Aquí están las mejores prácticas:

**Mejores Prácticas para Constructores:**

**1. Valida Parámetros**

Siempre valida los parámetros en el constructor:

```csharp
public class Persona
{
    public Persona(string nombre, int edad)
    {
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        if (edad < 0)
            throw new ArgumentException("La edad no puede ser negativa");
        
        // Inicializar campos
    }
}
```

**2. Inicializa Todos los Campos**

Asegúrate de inicializar todos los campos necesarios:

```csharp
public class Producto
{
    private string nombre;
    private double precio;
    private int stock;
    
    public Producto(string nombre, double precio, int stock)
    {
        this.nombre = nombre;
        this.precio = precio;
        this.stock = stock;  // Inicializar todos los campos
    }
}
```

**3. Usa Encadenamiento para Evitar Duplicación**

```csharp
public class Persona
{
    public Persona() : this("Sin nombre", 0) { }
    public Persona(string nombre) : this(nombre, 0) { }
    public Persona(string nombre, int edad)
    {
        // Lógica común aquí
    }
}
```

**4. Mantén los Constructores Simples**

Evita lógica compleja en constructores:

```csharp
// MAL
public Persona(string nombre)
{
    // Lógica compleja aquí
    CargarDesdeBaseDatos();
    ProcesarDatos();
    EnviarNotificacion();
}

// BIEN
public Persona(string nombre)
{
    this.nombre = nombre;
}

public void Inicializar()
{
    CargarDesdeBaseDatos();
    ProcesarDatos();
    EnviarNotificacion();
}
```

**5. Documenta los Constructores**

```csharp
/// <summary>
/// Inicializa una nueva instancia de Persona
/// </summary>
/// <param name="nombre">El nombre de la persona</param>
/// <param name="edad">La edad de la persona (debe ser >= 0)</param>
public Persona(string nombre, int edad)
{
    // ...
}
```

**Mejores Prácticas para Destructores:**

**1. Evita Destructores si es Posible**

Usa `IDisposable` en su lugar:

```csharp
// MAL
~MiClase()
{
    LiberarRecursos();
}

// BIEN
public class MiClase : IDisposable
{
    public void Dispose()
    {
        LiberarRecursos();
    }
}
```

**2. No Lances Excepciones en Destructores**

```csharp
// MAL
~MiClase()
{
    if (algoFallo)
        throw new Exception();  // NUNCA hacer esto
}

// BIEN
~MiClase()
{
    try
    {
        LiberarRecursos();
    }
    catch
    {
        // Registrar error, pero no lanzar excepción
    }
}
```

**3. No Referencies Otros Objetos**

Los objetos referenciados pueden haber sido recolectados:

```csharp
// MAL
private OtroObjeto otro;

~MiClase()
{
    otro.Metodo();  // otro puede ser null
}

// BIEN
~MiClase()
{
    // Solo liberar recursos propios
}
```

**4. Implementa IDisposable Correctamente**

```csharp
public class Recurso : IDisposable
{
    private bool disposed = false;
    
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
    
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                // Liberar recursos administrados
            }
            // Liberar recursos no administrados
            disposed = true;
        }
    }
    
    ~Recurso()
    {
        Dispose(false);
    }
}
```

**Checklist de Mejores Prácticas:**

✅ Valida parámetros en constructores
✅ Inicializa todos los campos necesarios
✅ Usa encadenamiento para evitar duplicación
✅ Mantén constructores simples
✅ Documenta constructores
✅ Evita destructores cuando sea posible
✅ Usa IDisposable para recursos
✅ No lances excepciones en destructores
✅ Usa `using` para recursos IDisposable',
    'using System;

// Ejemplo: Implementación siguiendo mejores prácticas
public class Producto : IDisposable
{
    private string nombre;
    private double precio;
    private int stock;
    private bool activo;
    private bool disposed = false;
    
    // Constructor principal con validación
    public Producto(string nombre, double precio, int stock)
    {
        // Validación de parámetros
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío", nameof(nombre));
        
        if (precio < 0)
            throw new ArgumentException("El precio no puede ser negativo", nameof(precio));
        
        if (stock < 0)
            throw new ArgumentException("El stock no puede ser negativo", nameof(stock));
        
        // Inicializar todos los campos
        this.nombre = nombre;
        this.precio = precio;
        this.stock = stock;
        activo = true;
        
        Console.WriteLine($"Producto {nombre} creado correctamente");
    }
    
    // Constructor con encadenamiento
    public Producto(string nombre, double precio) : this(nombre, precio, 0)
    {
        Console.WriteLine("  (Stock inicializado en 0)");
    }
    
    // Constructor con valores por defecto
    public Producto(string nombre) : this(nombre, 0, 0)
    {
        Console.WriteLine("  (Precio y stock inicializados en 0)");
    }
    
    // Propiedades
    public string Nombre { get { return nombre; } }
    public double Precio { get { return precio; } }
    public int Stock { get { return stock; } }
    public bool Activo { get { return activo; } }
    
    // Métodos
    public void Desactivar()
    {
        if (disposed)
            throw new ObjectDisposedException(nameof(Producto));
        
        activo = false;
        Console.WriteLine($"Producto {nombre} desactivado");
    }
    
    public void MostrarInformacion()
    {
        if (disposed)
            throw new ObjectDisposedException(nameof(Producto));
        
        Console.WriteLine($"Producto: {nombre}, Precio: ${precio:F2}, Stock: {stock}, Activo: {activo}");
    }
    
    // Implementación de IDisposable
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
    
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                // Liberar recursos administrados
                Console.WriteLine($"Liberando recursos de {nombre}");
            }
            
            // Liberar recursos no administrados (si los hay)
            activo = false;
            disposed = true;
        }
    }
    
    // Destructor (solo como respaldo)
    ~Producto()
    {
        Dispose(false);
    }
}

// Ejemplo: Clase base con constructor bien diseñado
public class Vehiculo
{
    protected string marca;
    protected string modelo;
    protected int año;
    
    // Constructor con validación
    public Vehiculo(string marca, string modelo, int año)
    {
        if (string.IsNullOrWhiteSpace(marca))
            throw new ArgumentException("La marca no puede estar vacía", nameof(marca));
        
        if (string.IsNullOrWhiteSpace(modelo))
            throw new ArgumentException("El modelo no puede estar vacío", nameof(modelo));
        
        if (año < 1900 || año > DateTime.Now.Year + 1)
            throw new ArgumentException("El año no es válido", nameof(año));
        
        this.marca = marca;
        this.modelo = modelo;
        this.año = año;
    }
    
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"{marca} {modelo} ({año})");
    }
}

// Clase derivada siguiendo mejores prácticas
public class Automovil : Vehiculo
{
    private int numeroPuertas;
    
    // Constructor que llama a la clase base
    public Automovil(string marca, string modelo, int año, int numeroPuertas) 
        : base(marca, modelo, año)
    {
        if (numeroPuertas < 2 || numeroPuertas > 6)
            throw new ArgumentException("El número de puertas debe estar entre 2 y 6", nameof(numeroPuertas));
        
        this.numeroPuertas = numeroPuertas;
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Puertas: {numeroPuertas}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Constructores con Mejores Prácticas ===");
        
        try
        {
            // Constructor principal
            Producto prod1 = new Producto("Laptop", 999.99, 10);
            prod1.MostrarInformacion();
            
            // Constructor encadenado
            Producto prod2 = new Producto("Mouse", 25.50);
            prod2.MostrarInformacion();
            
            // Constructor con valores por defecto
            Producto prod3 = new Producto("Teclado");
            prod3.MostrarInformacion();
            
            // Uso con using (IDisposable)
            Console.WriteLine("\n=== Uso con using ===");
            using (var producto = new Producto("Monitor", 299.99, 5))
            {
                producto.MostrarInformacion();
            } // Dispose() se llama automáticamente
            
            Console.WriteLine("\n=== EJEMPLO: Herencia con Mejores Prácticas ===");
            Automovil auto = new Automovil("Toyota", "Corolla", 2023, 4);
            auto.MostrarInformacion();
            
            // Intentar crear con datos inválidos
            try
            {
                Automovil autoInvalido = new Automovil("", "Modelo", 2023, 4);
            }
            catch (ArgumentException e)
            {
                Console.WriteLine($"Error: {e.Message}");
            }
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error de validación: {e.Message}");
        }
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
PRINT 'Lecciones del curso "Constructores y Destructores":';
PRINT '1. Introducción a Constructores';
PRINT '2. Constructores con Parámetros';
PRINT '3. Constructores Múltiples (Sobrecarga)';
PRINT '4. Constructor Estático';
PRINT '5. Destructores';
PRINT '6. Patrón IDisposable';
PRINT '7. Constructores en Herencia';
PRINT '8. Mejores Prácticas con Constructores y Destructores';
GO

