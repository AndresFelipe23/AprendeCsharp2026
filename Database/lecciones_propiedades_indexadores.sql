-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Propiedades e Indexadores"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Propiedades e Indexadores" en la ruta con RutaId = 2
DECLARE @CursoId INT;
DECLARE @RutaId INT = 2; -- RutaId de "Programación Orientada a Objetos"
DECLARE @NombreCurso NVARCHAR(100) = 'Propiedades e Indexadores';

-- Buscar el curso "Propiedades e Indexadores" en la ruta con RutaId = 2
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
        'Aprende a usar propiedades e indexadores en C# para acceder a datos de manera elegante y controlada',
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
-- LECCIÓN 1: Introducción a Propiedades
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Propiedades',
    'Comprende qué son las propiedades, cómo funcionan y por qué son mejores que los campos públicos.',
    'Las **propiedades** en C# son una forma elegante de acceder a los campos privados de una clase. Permiten encapsulación, validación y control de acceso a los datos.

**¿Qué son las Propiedades?**

Una propiedad es un miembro de clase que proporciona un mecanismo flexible para leer, escribir o calcular el valor de un campo privado. Las propiedades pueden usarse como si fueran campos públicos, pero están implementadas mediante métodos especiales llamados **accessors** (getters y setters).

**Sintaxis Básica:**

```csharp
public class Persona
{
    private string nombre;  // Campo privado
    
    // Propiedad
    public string Nombre
    {
        get { return nombre; }      // Getter: lee el valor
        set { nombre = value; }     // Setter: asigna el valor
    }
}
```

**¿Por qué Usar Propiedades en Lugar de Campos Públicos?**

1. **Encapsulación**: Control sobre cómo se accede a los datos
2. **Validación**: Puedes validar valores antes de asignarlos
3. **Cálculo**: Puedes calcular valores sobre la marcha
4. **Compatibilidad**: Puedes cambiar la implementación interna sin afectar el código cliente
5. **Bindings**: Funcionan con data binding en aplicaciones WPF/WinForms

**Tipos de Propiedades:**

1. **Propiedades Auto-Implemented** (C# 3.0+)
   ```csharp
   public string Nombre { get; set; }
   ```

2. **Propiedades con Implementación Personalizada**
   ```csharp
   public string Nombre
   {
       get { return nombre; }
       set { nombre = value; }
   }
   ```

3. **Propiedades de Solo Lectura**
   ```csharp
   public int Id { get; }
   ```

4. **Propiedades de Solo Escritura**
   ```csharp
   public string Clave { set; }
   ```

5. **Propiedades Calculadas**
   ```csharp
   public double Total => precio * cantidad;
   ```

**Ventajas de las Propiedades:**

✅ **Encapsulación**: Ocultas campos privados
✅ **Validación**: Puedes validar valores
✅ **Flexibilidad**: Puedes cambiar la implementación
✅ **Compatibilidad**: API consistente
✅ **Bindings**: Funcionan con data binding

**Ejemplo Práctico:**

```csharp
public class Producto
{
    private double precio;
    
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
}
```

**En Resumen:**

Las propiedades son una forma elegante y poderosa de encapsular datos, proporcionando control sobre el acceso y permitiendo validación y cálculo de valores.',
    'using System;

// Ejemplo básico de propiedades
public class Persona
{
    // Campo privado (encapsulado)
    private string nombre;
    private int edad;
    private string email;
    
    // Propiedad con implementación personalizada
    public string Nombre
    {
        get
        {
            return nombre;
        }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("El nombre no puede estar vacío");
            nombre = value;
        }
    }
    
    // Propiedad con validación
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
    
    // Propiedad auto-implementada (C# 3.0+)
    public string Email { get; set; }
    
    // Propiedad de solo lectura
    public int Id { get; }
    
    // Propiedad calculada (solo lectura)
    public bool EsMayorDeEdad => Edad >= 18;
    
    // Propiedad calculada con lógica
    public string InformacionCompleta
    {
        get
        {
            return $"{Nombre}, {Edad} años, Email: {Email}";
        }
    }
    
    // Constructor
    public Persona(int id, string nombre, int edad)
    {
        Id = id;  // Propiedad de solo lectura se asigna en constructor
        Nombre = nombre;
        Edad = edad;
    }
}

// Ejemplo con propiedades y validación
public class Producto
{
    private double precio;
    private int stock;
    
    public string Nombre { get; set; }  // Auto-implementada
    
    // Propiedad con validación
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
    
    // Propiedad con validación
    public int Stock
    {
        get { return stock; }
        set
        {
            if (value < 0)
                throw new ArgumentException("El stock no puede ser negativo");
            stock = value;
        }
    }
    
    // Propiedad calculada (solo lectura)
    public double ValorTotal => Precio * Stock;
    
    public Producto(string nombre, double precio, int stock)
    {
        Nombre = nombre;
        Precio = precio;  // Usa el setter, que valida
        Stock = stock;
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Producto: {Nombre}");
        Console.WriteLine($"Precio: ${Precio:F2}");
        Console.WriteLine($"Stock: {Stock} unidades");
        Console.WriteLine($"Valor Total: ${ValorTotal:F2}");
    }
}

// Comparación: Campo público vs Propiedad
public class EjemploComparacion
{
    // MAL: Campo público (sin control)
    public string NombreMalo;
    
    // BIEN: Propiedad (con control)
    private string nombreBueno;
    public string NombreBueno
    {
        get { return nombreBueno; }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("El nombre no puede estar vacío");
            nombreBueno = value;
        }
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Introducción a Propiedades ===\n");
        
        try
        {
            // Crear persona usando propiedades
            Persona persona = new Persona(1, "Juan", 25);
            
            Console.WriteLine($"ID: {persona.Id}");
            Console.WriteLine($"Nombre: {persona.Nombre}");
            Console.WriteLine($"Edad: {persona.Edad}");
            Console.WriteLine($"Es mayor de edad: {persona.EsMayorDeEdad}");
            Console.WriteLine($"Información completa: {persona.InformacionCompleta}");
            
            persona.Email = "juan@example.com";
            Console.WriteLine($"Email: {persona.Email}");
            
            Console.WriteLine("\n--- Modificar propiedades ---");
            persona.Nombre = "Juan Pérez";
            persona.Edad = 30;
            Console.WriteLine($"Nombre actualizado: {persona.Nombre}");
            Console.WriteLine($"Edad actualizada: {persona.Edad}");
            
            Console.WriteLine("\n=== EJEMPLO: Producto con Validación ===");
            
            Producto producto = new Producto("Laptop", 999.99, 10);
            producto.MostrarInformacion();
            
            Console.WriteLine("\n--- Modificar precio ---");
            producto.Precio = 899.99;
            producto.MostrarInformacion();
            
            Console.WriteLine("\n=== DEMOSTRACIÓN: Validación ===");
            
            // Intentar asignar valor inválido
            try
            {
                producto.Precio = -100;  // Esto lanzará excepción
            }
            catch (ArgumentException e)
            {
                Console.WriteLine($"Error al asignar precio: {e.Message}");
            }
            
            try
            {
                Persona personaInvalida = new Persona(2, "", 25);  // Nombre vacío
            }
            catch (ArgumentException e)
            {
                Console.WriteLine($"Error al crear persona: {e.Message}");
            }
            
            Console.WriteLine("\n=== VENTAJAS DE LAS PROPIEDADES ===");
            Console.WriteLine("✅ Encapsulación de datos");
            Console.WriteLine("✅ Validación de valores");
            Console.WriteLine("✅ Cálculo de valores sobre la marcha");
            Console.WriteLine("✅ Compatibilidad con data binding");
            Console.WriteLine("✅ Flexibilidad para cambiar implementación");
        }
        catch (Exception e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Propiedades Auto-Implementadas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Propiedades Auto-Implementadas',
    'Aprende a usar propiedades auto-implementadas para simplificar tu código cuando no necesitas lógica adicional.',
    'Las **propiedades auto-implementadas** (C# 3.0+) son una forma abreviada de declarar propiedades cuando no necesitas lógica adicional en los accessors. El compilador crea automáticamente un campo privado respaldado.

**¿Qué son las Propiedades Auto-Implementadas?**

Son propiedades que declaran automáticamente el campo privado respaldado y crean los accessors `get` y `set` implícitamente. Son una forma más concisa de escribir propiedades simples.

**Sintaxis:**

```csharp
// Propiedad auto-implementada estándar
public string Nombre { get; set; }

// Propiedad auto-implementada de solo lectura (C# 6.0+)
public int Id { get; }

// Propiedad auto-implementada con inicializador (C# 6.0+)
public string Email { get; set; } = "sin-email";
```

**Ventajas:**

✅ **Código más limpio**: Menos código para escribir
✅ **Legibilidad**: Más fácil de leer
✅ **Simplicidad**: Perfecto para propiedades simples
✅ **Inicializadores**: Puedes inicializar directamente

**Cuándo Usar Propiedades Auto-Implementadas:**

✅ **Usa auto-implementadas cuando:**
- No necesitas validación
- No necesitas lógica adicional
- Solo necesitas almacenar y recuperar valores
- Quieres código más conciso

❌ **NO uses auto-implementadas cuando:**
- Necesitas validación
- Necesitas calcular valores
- Necesitas lógica adicional en get/set

**Ejemplo:**

```csharp
// Auto-implementada simple
public string Nombre { get; set; }

// Auto-implementada con inicializador
public int Edad { get; set; } = 18;
```',
    'using System;

// Ejemplo con propiedades auto-implementadas
public class Persona
{
    // Propiedades auto-implementadas estándar
    public string Nombre { get; set; }
    public string Apellido { get; set; }
    public int Edad { get; set; }
    public string Email { get; set; }
    
    // Propiedad auto-implementada con inicializador (C# 6.0+)
    public string EstadoCivil { get; set; } = "Soltero";
    
    // Propiedad auto-implementada de solo lectura (C# 6.0+)
    public int Id { get; }
    
    // Propiedad auto-implementada con inicializador de solo lectura
    public DateTime FechaCreacion { get; } = DateTime.Now;
    
    // Propiedad calculada (no auto-implementada)
    public string NombreCompleto => $"{Nombre} {Apellido}";
    
    public Persona(int id, string nombre, string apellido)
    {
        Id = id;  // Se asigna en constructor
        Nombre = nombre;
        Apellido = apellido;
    }
    
    // Constructor con inicializador de objeto
    public Persona()
    {
        FechaCreacion = DateTime.Now;
    }
}

// Comparación: Auto-implementada vs Implementación personalizada
public class Producto
{
    // Auto-implementada: simple y concisa
    public string Nombre { get; set; }
    public string Categoria { get; set; } = "General";
    
    // Implementación personalizada: con validación
    private double precio;
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
    
    // Auto-implementada: sin validación necesaria
    public string Codigo { get; set; }
    
    public Producto()
    {
        Categoria = "Sin categoría";
    }
}

// Ejemplo con inicializadores de objetos
public class Configuracion
{
    // Auto-implementadas con valores por defecto
    public string NombreAplicacion { get; set; } = "Mi Aplicación";
    public string Version { get; set; } = "1.0.0";
    public bool ModoDebug { get; set; } = false;
    public int Puerto { get; set; } = 8080;
    public string Idioma { get; set; } = "es";
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Propiedades Auto-Implementadas ===\n");
        
        // Crear persona usando propiedades auto-implementadas
        Persona persona1 = new Persona(1, "Juan", "Pérez");
        persona1.Edad = 25;
        persona1.Email = "juan@example.com";
        
        Console.WriteLine($"ID: {persona1.Id}");
        Console.WriteLine($"Nombre completo: {persona1.NombreCompleto}");
        Console.WriteLine($"Edad: {persona1.Edad}");
        Console.WriteLine($"Email: {persona1.Email}");
        Console.WriteLine($"Estado civil: {persona1.EstadoCivil}");
        Console.WriteLine($"Fecha creación: {persona1.FechaCreacion}");
        
        Console.WriteLine("\n--- Modificar propiedades ---");
        persona1.EstadoCivil = "Casado";
        Console.WriteLine($"Estado civil actualizado: {persona1.EstadoCivil}");
        
        Console.WriteLine("\n=== EJEMPLO: Inicializadores ===");
        
        // Usar inicializador de objeto con propiedades auto-implementadas
        Persona persona2 = new Persona(2, "María", "González")
        {
            Edad = 30,
            Email = "maria@example.com",
            EstadoCivil = "Soltera"
        };
        
        Console.WriteLine($"Persona 2: {persona2.NombreCompleto}");
        Console.WriteLine($"Edad: {persona2.Edad}");
        Console.WriteLine($"Email: {persona2.Email}");
        
        Console.WriteLine("\n=== EJEMPLO: Configuración con Valores por Defecto ===");
        
        // Usa valores por defecto automáticamente
        Configuracion config = new Configuracion();
        Console.WriteLine($"Aplicación: {config.NombreAplicacion}");
        Console.WriteLine($"Versión: {config.Version}");
        Console.WriteLine($"Modo Debug: {config.ModoDebug}");
        Console.WriteLine($"Puerto: {config.Puerto}");
        Console.WriteLine($"Idioma: {config.Idioma}");
        
        // Puedes modificar valores
        config.NombreAplicacion = "Mi Nueva Aplicación";
        config.ModoDebug = true;
        config.Puerto = 9000;
        
        Console.WriteLine("\n--- Configuración modificada ---");
        Console.WriteLine($"Aplicación: {config.NombreAplicacion}");
        Console.WriteLine($"Modo Debug: {config.ModoDebug}");
        Console.WriteLine($"Puerto: {config.Puerto}");
        
        Console.WriteLine("\n=== COMPARACIÓN: Auto-implementada vs Personalizada ===");
        
        Producto producto = new Producto
        {
            Nombre = "Laptop",
            Codigo = "LAP-001",
            Precio = 999.99
        };
        
        Console.WriteLine($"Producto: {producto.Nombre}");
        Console.WriteLine($"Código: {producto.Codigo}");
        Console.WriteLine($"Precio: ${producto.Precio:F2}");
        Console.WriteLine($"Categoría: {producto.Categoria}");
        
        // Auto-implementada: sin validación
        producto.Codigo = "NUEVO-CODIGO";  // OK
        
        // Implementación personalizada: con validación
        try
        {
            producto.Precio = -100;  // ERROR: validación
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
        
        Console.WriteLine("\n=== VENTAJAS DE AUTO-IMPLEMENTADAS ===");
        Console.WriteLine("✅ Código más conciso y legible");
        Console.WriteLine("✅ Inicializadores de objetos");
        Console.WriteLine("✅ Valores por defecto");
        Console.WriteLine("✅ Perfectas para propiedades simples");
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Propiedades de Solo Lectura y Escritura
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Propiedades de Solo Lectura y Escritura',
    'Aprende a crear propiedades de solo lectura y solo escritura para controlar el acceso a los datos.',
    'Las propiedades pueden ser configuradas para permitir solo lectura o solo escritura. Esto proporciona control adicional sobre cómo se accede a los datos.

**Propiedades de Solo Lectura:**

Una propiedad de solo lectura solo tiene un accessor `get`. No se puede modificar desde fuera de la clase.

**Sintaxis:**

```csharp
// Propiedad de solo lectura tradicional
public int Id
{
    get { return id; }
}

// Propiedad auto-implementada de solo lectura (C# 6.0+)
public int Id { get; }
```

**Propiedades de Solo Escritura:**

Una propiedad de solo escritura solo tiene un accessor `set`. Se puede escribir pero no leer.

**Sintaxis:**

```csharp
// Propiedad de solo escritura
public string Clave
{
    set { clave = value; }
}
```

**Cuándo Usar Solo Lectura:**

✅ **Usa solo lectura cuando:**
- El valor no debe cambiar después de la inicialización
- El valor es calculado o derivado
- Quieres inmutabilidad
- El valor identifica al objeto (como ID)

**Cuándo Usar Solo Escritura:**

✅ **Usa solo escritura cuando:**
- Solo necesitas establecer un valor (como contraseña)
- El valor se usa internamente pero no se expone
- Necesitas un mecanismo de configuración único

**Ejemplo:**

```csharp
public class Persona
{
    public int Id { get; }  // Solo lectura
    
    public string Clave { set; }  // Solo escritura
}
```',
    'using System;

// Ejemplo con propiedades de solo lectura
public class Producto
{
    // Propiedad de solo lectura tradicional
    private int id;
    public int Id
    {
        get { return id; }
    }
    
    // Propiedad auto-implementada de solo lectura (C# 6.0+)
    public DateTime FechaCreacion { get; }
    
    // Propiedades normales
    public string Nombre { get; set; }
    public double Precio { get; set; }
    
    // Propiedad calculada (solo lectura implícita)
    public double PrecioConIVA => Precio * 1.21;
    
    public Producto(int id, string nombre, double precio)
    {
        this.id = id;  // Se asigna en constructor
        FechaCreacion = DateTime.Now;  // Se asigna en constructor
        Nombre = nombre;
        Precio = precio;
    }
    
    // ERROR: No se puede modificar después de inicialización
    // public void CambiarId(int nuevoId)
    // {
    //     Id = nuevoId;  // ERROR: Id es solo lectura
    // }
}

// Ejemplo con propiedades de solo escritura
public class ConfiguracionSegura
{
    private string contraseña;
    private string token;
    
    // Propiedad de solo escritura
    public string Contraseña
    {
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("La contraseña no puede estar vacía");
            
            // Hash de la contraseña (ejemplo simplificado)
            contraseña = $"HASH_{value}";
            Console.WriteLine("Contraseña configurada exitosamente");
        }
    }
    
    // Propiedad de solo escritura
    public string Token
    {
        set { token = value; }
    }
    
    // Método para verificar contraseña (no expone la contraseña)
    public bool VerificarContraseña(string contraseñaIngresada)
    {
        return contraseña == $"HASH_{contraseñaIngresada}";
    }
    
    public bool TieneToken()
    {
        return !string.IsNullOrEmpty(token);
    }
}

// Ejemplo con propiedades inmutables
public class PersonaInmutable
{
    // Propiedades de solo lectura (inmutables después de construcción)
    public int Id { get; }
    public string Nombre { get; }
    public string Apellido { get; }
    public DateTime FechaNacimiento { get; }
    
    // Propiedad calculada de solo lectura
    public int Edad
    {
        get
        {
            int edad = DateTime.Now.Year - FechaNacimiento.Year;
            if (DateTime.Now.DayOfYear < FechaNacimiento.DayOfYear)
                edad--;
            return edad;
        }
    }
    
    public string NombreCompleto => $"{Nombre} {Apellido}";
    
    // Constructor: único lugar donde se asignan valores
    public PersonaInmutable(int id, string nombre, string apellido, DateTime fechaNacimiento)
    {
        Id = id;
        Nombre = nombre ?? throw new ArgumentNullException(nameof(nombre));
        Apellido = apellido ?? throw new ArgumentNullException(nameof(apellido));
        FechaNacimiento = fechaNacimiento;
    }
}

// Ejemplo con propiedad de solo lectura calculada
public class Rectangulo
{
    public double Ancho { get; set; }
    public double Alto { get; set; }
    
    // Propiedades calculadas de solo lectura
    public double Area => Ancho * Alto;
    
    public double Perimetro => 2 * (Ancho + Alto);
    
    // Propiedad de solo lectura con lógica
    public bool EsCuadrado => Ancho == Alto;
    
    public Rectangulo(double ancho, double alto)
    {
        Ancho = ancho;
        Alto = alto;
    }
}

// Ejemplo combinado
public class CuentaBancaria
{
    // Solo lectura: ID no cambia
    public int NumeroCuenta { get; }
    
    // Propiedades normales
    public string Titular { get; set; }
    public double Saldo { get; private set; }  // Solo lectura desde fuera
    
    // Propiedad de solo escritura para configuración interna
    private string claveInterna;
    public string ClaveInterna
    {
        set { claveInterna = value; }
    }
    
    public CuentaBancaria(int numeroCuenta, string titular)
    {
        NumeroCuenta = numeroCuenta;  // Solo se asigna una vez
        Titular = titular;
        Saldo = 0;
    }
    
    // Métodos para modificar Saldo (que es privado en set)
    public void Depositar(double cantidad)
    {
        if (cantidad > 0)
            Saldo += cantidad;
    }
    
    public bool Retirar(double cantidad)
    {
        if (cantidad > 0 && cantidad <= Saldo)
        {
            Saldo -= cantidad;
            return true;
        }
        return false;
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Cuenta: {NumeroCuenta}");
        Console.WriteLine($"Titular: {Titular}");
        Console.WriteLine($"Saldo: ${Saldo:F2}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Propiedades de Solo Lectura ===\n");
        
        Producto producto = new Producto(1, "Laptop", 999.99);
        
        Console.WriteLine($"ID: {producto.Id}");
        Console.WriteLine($"Fecha creación: {producto.FechaCreacion}");
        Console.WriteLine($"Nombre: {producto.Nombre}");
        Console.WriteLine($"Precio: ${producto.Precio:F2}");
        Console.WriteLine($"Precio con IVA: ${producto.PrecioConIVA:F2}");
        
        // ERROR: No se puede modificar
        // producto.Id = 2;  // ERROR
        // producto.FechaCreacion = DateTime.Now;  // ERROR
        
        // Se puede modificar propiedades normales
        producto.Nombre = "Laptop Actualizada";
        producto.Precio = 899.99;
        
        Console.WriteLine("\n--- Después de modificar ---");
        Console.WriteLine($"Nombre: {producto.Nombre}");
        Console.WriteLine($"Precio: ${producto.Precio:F2}");
        Console.WriteLine($"Precio con IVA: ${producto.PrecioConIVA:F2}");  // Recalculado automáticamente
        
        Console.WriteLine("\n=== EJEMPLO: Propiedades de Solo Escritura ===\n");
        
        ConfiguracionSegura config = new ConfiguracionSegura();
        
        // Se puede escribir
        config.Contraseña = "MiContraseña123";
        config.Token = "token-secreto-123";
        
        // ERROR: No se puede leer directamente
        // string pass = config.Contraseña;  // ERROR
        
        // Se puede verificar usando método
        bool esValida = config.VerificarContraseña("MiContraseña123");
        Console.WriteLine($"Contraseña válida: {esValida}");
        
        bool tieneToken = config.TieneToken();
        Console.WriteLine($"Tiene token: {tieneToken}");
        
        Console.WriteLine("\n=== EJEMPLO: Objeto Inmutable ===\n");
        
        PersonaInmutable persona = new PersonaInmutable(
            1,
            "Juan",
            "Pérez",
            new DateTime(1990, 5, 15)
        );
        
        Console.WriteLine($"ID: {persona.Id}");
        Console.WriteLine($"Nombre completo: {persona.NombreCompleto}");
        Console.WriteLine($"Fecha nacimiento: {persona.FechaNacimiento:yyyy-MM-dd}");
        Console.WriteLine($"Edad: {persona.Edad} años");
        
        // ERROR: Objeto inmutable
        // persona.Nombre = "Otro";  // ERROR
        // persona.Id = 2;  // ERROR
        
        Console.WriteLine("\n=== EJEMPLO: Propiedades Calculadas ===\n");
        
        Rectangulo rect = new Rectangulo(5, 3);
        
        Console.WriteLine($"Ancho: {rect.Ancho}");
        Console.WriteLine($"Alto: {rect.Alto}");
        Console.WriteLine($"Área: {rect.Area}");  // Calculada automáticamente
        Console.WriteLine($"Perímetro: {rect.Perimetro}");
        Console.WriteLine($"Es cuadrado: {rect.EsCuadrado}");
        
        rect.Alto = 5;  // Cambiar alto
        Console.WriteLine($"\nDespués de cambiar alto a 5:");
        Console.WriteLine($"Es cuadrado: {rect.EsCuadrado}");  // Recalculado
        
        Console.WriteLine("\n=== EJEMPLO: Cuenta Bancaria ===\n");
        
        CuentaBancaria cuenta = new CuentaBancaria(12345, "Juan Pérez");
        cuenta.ClaveInterna = "clave-secreta";
        cuenta.MostrarInformacion();
        
        cuenta.Depositar(1000);
        Console.WriteLine("\nDespués de depositar $1000:");
        cuenta.MostrarInformacion();
        
        cuenta.Retirar(300);
        Console.WriteLine("\nDespués de retirar $300:");
        cuenta.MostrarInformacion();
        
        // ERROR: No se puede modificar directamente
        // cuenta.NumeroCuenta = 99999;  // ERROR
        // cuenta.Saldo = 5000;  // ERROR (set es private)
        
        Console.WriteLine("\n=== CARACTERÍSTICAS ===");
        Console.WriteLine("Solo Lectura:");
        Console.WriteLine("  - Solo get accessor");
        Console.WriteLine("  - Inmutabilidad");
        Console.WriteLine("  - Valores calculados");
        Console.WriteLine();
        Console.WriteLine("Solo Escritura:");
        Console.WriteLine("  - Solo set accessor");
        Console.WriteLine("  - Configuración interna");
        Console.WriteLine("  - Valores privados");
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Propiedades Calculadas y Virtuales
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Propiedades Calculadas y Virtuales',
    'Aprende a crear propiedades calculadas que derivan valores y propiedades virtuales que pueden ser sobrescritas.',
    'Las **propiedades calculadas** son propiedades que no almacenan un valor directamente, sino que lo calculan sobre la marcha. Las **propiedades virtuales** pueden ser sobrescritas en clases derivadas.

**Propiedades Calculadas:**

Una propiedad calculada deriva su valor de otros campos o propiedades. No tiene un campo respaldado propio.

**Sintaxis:**

```csharp
// Propiedad calculada con expression body (C# 6.0+)
public double Total => precio * cantidad;

// Propiedad calculada con bloque
public double Total
{
    get { return precio * cantidad; }
}
```

**Propiedades Virtuales:**

Una propiedad virtual puede ser sobrescrita en clases derivadas usando `override`.

**Sintaxis:**

```csharp
public class Base
{
    public virtual string Nombre { get; set; }
}

public class Derivada : Base
{
    public override string Nombre
    {
        get { return base.Nombre.ToUpper(); }
        set { base.Nombre = value; }
    }
}
```

**Ventajas:**

✅ **Propiedades Calculadas**: Valores siempre actualizados
✅ **Propiedades Virtuales**: Polimorfismo y extensibilidad
✅ **Sin Almacenamiento**: Ahorro de memoria
✅ **Flexibilidad**: Cálculo dinámico

**Ejemplo:**

```csharp
public class Rectangulo
{
    public double Ancho { get; set; }
    public double Alto { get; set; }
    
    public double Area => Ancho * Alto;  // Calculada
}
```',
    'using System;

// Ejemplo con propiedades calculadas
public class Producto
{
    public string Nombre { get; set; }
    public double PrecioUnitario { get; set; }
    public int Cantidad { get; set; }
    
    // Propiedad calculada con expression body (C# 6.0+)
    public double Subtotal => PrecioUnitario * Cantidad;
    
    // Propiedad calculada con bloque
    public double Descuento
    {
        get
        {
            if (Cantidad >= 10)
                return Subtotal * 0.10;  // 10% descuento
            else if (Cantidad >= 5)
                return Subtotal * 0.05;  // 5% descuento
            return 0;
        }
    }
    
    // Propiedad calculada más compleja
    public double Total
    {
        get
        {
            return Subtotal - Descuento;
        }
    }
    
    // Propiedad calculada de solo lectura
    public string Informacion
    {
        get
        {
            return $"{Nombre}: {Cantidad} x ${PrecioUnitario:F2} = ${Total:F2}";
        }
    }
    
    public Producto(string nombre, double precio, int cantidad)
    {
        Nombre = nombre;
        PrecioUnitario = precio;
        Cantidad = cantidad;
    }
}

// Ejemplo con propiedades virtuales
public abstract class Forma
{
    protected string nombre;
    
    public Forma(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Propiedad virtual: puede ser sobrescrita
    public virtual string Nombre
    {
        get { return nombre; }
        set { nombre = value; }
    }
    
    // Propiedad abstracta: DEBE ser implementada
    public abstract double Area { get; }
    
    // Propiedad virtual calculada
    public virtual string Descripcion
    {
        get
        {
            return $"{Nombre} con área {Area:F2}";
        }
    }
}

// Clase derivada que sobrescribe propiedades virtuales
public class Rectangulo : Forma
{
    public double Ancho { get; set; }
    public double Alto { get; set; }
    
    public Rectangulo(double ancho, double alto) : base("Rectángulo")
    {
        Ancho = ancho;
        Alto = alto;
    }
    
    // Implementar propiedad abstracta
    public override double Area => Ancho * Alto;
    
    // Sobrescribir propiedad virtual
    public override string Nombre
    {
        get { return base.Nombre + $" ({Ancho}x{Alto})"; }
        set { base.Nombre = value; }
    }
    
    // Opcional: sobrescribir propiedad virtual calculada
    public override string Descripcion
    {
        get
        {
            return base.Descripcion + $" - Dimensiones: {Ancho} x {Alto}";
        }
    }
}

// Otra clase derivada
public class Circulo : Forma
{
    public double Radio { get; set; }
    
    public Circulo(double radio) : base("Círculo")
    {
        Radio = radio;
    }
    
    // Implementar propiedad abstracta
    public override double Area => Math.PI * Radio * Radio;
    
    // No sobrescribe Nombre, usa la implementación base
    // No sobrescribe Descripcion, usa la implementación base
}

// Ejemplo con propiedades calculadas en jerarquía
public class Empleado
{
    public string Nombre { get; set; }
    public double SalarioBase { get; set; }
    public int AñosExperiencia { get; set; }
    
    // Propiedad virtual calculada
    public virtual double Bonificacion
    {
        get
        {
            return SalarioBase * 0.10 * AñosExperiencia;
        }
    }
    
    // Propiedad calculada usando propiedad virtual
    public double SalarioTotal => SalarioBase + Bonificacion;
    
    public Empleado(string nombre, double salarioBase, int añosExperiencia)
    {
        Nombre = nombre;
        SalarioBase = salarioBase;
        AñosExperiencia = añosExperiencia;
    }
    
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Empleado: {Nombre}");
        Console.WriteLine($"Salario Base: ${SalarioBase:F2}");
        Console.WriteLine($"Bonificación: ${Bonificacion:F2}");
        Console.WriteLine($"Salario Total: ${SalarioTotal:F2}");
    }
}

public class Gerente : Empleado
{
    public int NumeroEmpleados { get; set; }
    
    public Gerente(string nombre, double salarioBase, int añosExperiencia, int numeroEmpleados) 
        : base(nombre, salarioBase, añosExperiencia)
    {
        NumeroEmpleados = numeroEmpleados;
    }
    
    // Sobrescribir propiedad virtual calculada
    public override double Bonificacion
    {
        get
        {
            // Bonificación base + bonificación por empleados
            return base.Bonificacion + (NumeroEmpleados * 500);
        }
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Número de empleados supervisados: {NumeroEmpleados}");
    }
}

class Program
{
    static void ProcesarForma(Forma forma)
    {
        // Polimorfismo: trabajar con la clase base
        Console.WriteLine($"Forma: {forma.Nombre}");
        Console.WriteLine($"Área: {forma.Area:F2}");
        Console.WriteLine($"Descripción: {forma.Descripcion}");
        Console.WriteLine();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Propiedades Calculadas ===\n");
        
        Producto producto1 = new Producto("Laptop", 999.99, 3);
        Console.WriteLine($"Producto: {producto1.Informacion}");
        Console.WriteLine($"Subtotal: ${producto1.Subtotal:F2}");
        Console.WriteLine($"Descuento: ${producto1.Descuento:F2}");
        Console.WriteLine($"Total: ${producto1.Total:F2}");
        
        Console.WriteLine("\n--- Con cantidad que genera descuento ---");
        Producto producto2 = new Producto("Laptop", 999.99, 10);
        Console.WriteLine($"Producto: {producto2.Informacion}");
        Console.WriteLine($"Subtotal: ${producto2.Subtotal:F2}");
        Console.WriteLine($"Descuento: ${producto2.Descuento:F2}");
        Console.WriteLine($"Total: ${producto2.Total:F2}");
        
        Console.WriteLine("\n=== EJEMPLO: Propiedades Virtuales ===\n");
        
        Rectangulo rect = new Rectangulo(5, 3);
        ProcesarForma(rect);
        
        Circulo circ = new Circulo(4);
        ProcesarForma(circ);
        
        Console.WriteLine("=== EJEMPLO: Propiedades Virtuales en Jerarquía ===\n");
        
        Empleado empleado = new Empleado("Juan", 50000, 5);
        empleado.MostrarInformacion();
        
        Console.WriteLine();
        
        Gerente gerente = new Gerente("María", 70000, 10, 5);
        gerente.MostrarInformacion();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo ===\n");
        
        Empleado[] empleados = new Empleado[]
        {
            new Empleado("Empleado 1", 40000, 3),
            new Gerente("Gerente 1", 60000, 8, 3),
            new Empleado("Empleado 2", 45000, 4)
        };
        
        foreach (Empleado emp in empleados)
        {
            Console.WriteLine($"{emp.Nombre}: Salario Total = ${emp.SalarioTotal:F2}");
            Console.WriteLine($"  (Bonificación: ${emp.Bonificacion:F2})");
        }
        
        Console.WriteLine("\n=== CARACTERÍSTICAS ===");
        Console.WriteLine("Propiedades Calculadas:");
        Console.WriteLine("  - Valores derivados dinámicamente");
        Console.WriteLine("  - Sin almacenamiento propio");
        Console.WriteLine("  - Siempre actualizados");
        Console.WriteLine();
        Console.WriteLine("Propiedades Virtuales:");
        Console.WriteLine("  - Pueden ser sobrescritas");
        Console.WriteLine("  - Polimorfismo");
        Console.WriteLine("  - Extensibilidad");
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Introducción a Indexadores
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Indexadores',
    'Comprende qué son los indexadores, cómo funcionan y cómo te permiten acceder a objetos como si fueran arrays.',
    'Los **indexadores** permiten que los objetos se indexen como si fueran arrays. Son similares a las propiedades, pero usan parámetros de índice.

**¿Qué son los Indexadores?**

Un indexador es un miembro especial que permite que una instancia de una clase o estructura se indexe de la misma manera que un array. Los indexadores se definen usando la palabra clave `this`.

**Sintaxis:**

```csharp
public class MiClase
{
    private int[] datos = new int[10];
    
    // Indexador
    public int this[int indice]
    {
        get { return datos[indice]; }
        set { datos[indice] = value; }
    }
}

// Uso
MiClase obj = new MiClase();
obj[0] = 10;  // Usa el indexador
int valor = obj[0];  // Lee usando el indexador
```

**Ventajas de los Indexadores:**

✅ **Sintaxis Natural**: Acceso como array
✅ **Encapsulación**: Control sobre acceso a datos
✅ **Flexibilidad**: Puedes implementar lógica personalizada
✅ **Intuitivo**: Fácil de usar y entender

**Cuándo Usar Indexadores:**

✅ **Usa indexadores cuando:**
- Tu clase representa una colección
- Quieres acceso tipo array
- Necesitas encapsular acceso a datos
- Quieres sintaxis más natural

**Ejemplo:**

```csharp
public class ListaPersonalizada
{
    private string[] items = new string[10];
    
    public string this[int i]
    {
        get { return items[i]; }
        set { items[i] = value; }
    }
}
```',
    'using System;

// Ejemplo básico de indexador
public class ArrayPersonalizado
{
    private int[] datos;
    private int tamaño;
    
    public ArrayPersonalizado(int tamaño)
    {
        this.tamaño = tamaño;
        datos = new int[tamaño];
    }
    
    // Indexador básico
    public int this[int indice]
    {
        get
        {
            if (indice < 0 || indice >= tamaño)
                throw new IndexOutOfRangeException($"Índice {indice} fuera de rango");
            return datos[indice];
        }
        set
        {
            if (indice < 0 || indice >= tamaño)
                throw new IndexOutOfRangeException($"Índice {indice} fuera de rango");
            datos[indice] = value;
        }
    }
    
    public int Tamaño => tamaño;
}

// Indexador con string como índice
public class DiccionarioSimple
{
    private string[] claves;
    private string[] valores;
    private int contador;
    
    public DiccionarioSimple(int capacidad)
    {
        claves = new string[capacidad];
        valores = new string[capacidad];
        contador = 0;
    }
    
    // Indexador con string
    public string this[string clave]
    {
        get
        {
            for (int i = 0; i < contador; i++)
            {
                if (claves[i] == clave)
                    return valores[i];
            }
            throw new KeyNotFoundException($"Clave {clave} no encontrada");
        }
        set
        {
            // Buscar si existe
            for (int i = 0; i < contador; i++)
            {
                if (claves[i] == clave)
                {
                    valores[i] = value;
                    return;
                }
            }
            
            // Agregar nuevo si hay espacio
            if (contador < claves.Length)
            {
                claves[contador] = clave;
                valores[contador] = value;
                contador++;
            }
            else
            {
                throw new InvalidOperationException("Diccionario lleno");
            }
        }
    }
    
    public bool ContieneClave(string clave)
    {
        for (int i = 0; i < contador; i++)
        {
            if (claves[i] == clave)
                return true;
        }
        return false;
    }
    
    public int Cantidad => contador;
}

// Indexador de solo lectura
public class MatrizIdentidad
{
    private int tamaño;
    
    public MatrizIdentidad(int tamaño)
    {
        this.tamaño = tamaño;
    }
    
    // Indexador de solo lectura
    public int this[int fila, int columna]
    {
        get
        {
            if (fila < 0 || fila >= tamaño || columna < 0 || columna >= tamaño)
                throw new IndexOutOfRangeException();
            
            // Matriz identidad: 1 en diagonal, 0 en otros lugares
            return (fila == columna) ? 1 : 0;
        }
    }
    
    public int Tamaño => tamaño;
    
    public void Mostrar()
    {
        for (int i = 0; i < tamaño; i++)
        {
            for (int j = 0; j < tamaño; j++)
            {
                Console.Write($"{this[i, j]} ");
            }
            Console.WriteLine();
        }
    }
}

// Indexador virtual (puede ser sobrescrito)
public class ColeccionBase
{
    protected int[] datos;
    protected int tamaño;
    
    public ColeccionBase(int tamaño)
    {
        this.tamaño = tamaño;
        datos = new int[tamaño];
    }
    
    public virtual int this[int indice]
    {
        get
        {
            if (indice < 0 || indice >= tamaño)
                throw new IndexOutOfRangeException();
            return datos[indice];
        }
        set
        {
            if (indice < 0 || indice >= tamaño)
                throw new IndexOutOfRangeException();
            datos[indice] = value;
        }
    }
    
    public int Tamaño => tamaño;
}

public class ColeccionDerivada : ColeccionBase
{
    public ColeccionDerivada(int tamaño) : base(tamaño) { }
    
    // Sobrescribir indexador virtual
    public override int this[int indice]
    {
        get
        {
            // Lógica personalizada: devolver valor absoluto
            return Math.Abs(base[indice]);
        }
        set
        {
            // Lógica personalizada: almacenar valor absoluto
            base[indice] = Math.Abs(value);
        }
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Indexador Básico ===\n");
        
        ArrayPersonalizado array = new ArrayPersonalizado(5);
        
        // Usar indexador para asignar valores
        array[0] = 10;
        array[1] = 20;
        array[2] = 30;
        array[3] = 40;
        array[4] = 50;
        
        // Usar indexador para leer valores
        for (int i = 0; i < array.Tamaño; i++)
        {
            Console.WriteLine($"array[{i}] = {array[i]}");
        }
        
        Console.WriteLine("\n=== EJEMPLO: Indexador con String ===\n");
        
        DiccionarioSimple diccionario = new DiccionarioSimple(10);
        
        // Usar indexador con string
        diccionario["nombre"] = "Juan";
        diccionario["edad"] = "25";
        diccionario["ciudad"] = "Madrid";
        
        Console.WriteLine($"Nombre: {diccionario["nombre"]}");
        Console.WriteLine($"Edad: {diccionario["edad"]}");
        Console.WriteLine($"Ciudad: {diccionario["ciudad"]}");
        Console.WriteLine($"Cantidad de elementos: {diccionario.Cantidad}");
        
        Console.WriteLine("\n=== EJEMPLO: Indexador Multidimensional ===\n");
        
        MatrizIdentidad matriz = new MatrizIdentidad(4);
        
        Console.WriteLine("Matriz Identidad 4x4:");
        matriz.Mostrar();
        
        Console.WriteLine("\nAcceso individual:");
        for (int i = 0; i < matriz.Tamaño; i++)
        {
            for (int j = 0; j < matriz.Tamaño; j++)
            {
                Console.Write($"m[{i},{j}]={matriz[i, j]} ");
            }
            Console.WriteLine();
        }
        
        Console.WriteLine("\n=== EJEMPLO: Indexador Virtual ===\n");
        
        ColeccionBase coleccionBase = new ColeccionBase(5);
        coleccionBase[0] = -10;
        coleccionBase[1] = 20;
        coleccionBase[2] = -30;
        
        Console.WriteLine("Colección Base:");
        for (int i = 0; i < coleccionBase.Tamaño; i++)
        {
            Console.WriteLine($"coleccionBase[{i}] = {coleccionBase[i]}");
        }
        
        ColeccionDerivada coleccionDerivada = new ColeccionDerivada(5);
        coleccionDerivada[0] = -10;  // Se almacena como valor absoluto
        coleccionDerivada[1] = 20;
        coleccionDerivada[2] = -30;
        
        Console.WriteLine("\nColección Derivada (siempre valores absolutos):");
        for (int i = 0; i < coleccionDerivada.Tamaño; i++)
        {
            Console.WriteLine($"coleccionDerivada[{i}] = {coleccionDerivada[i]}");
        }
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Validación ===\n");
        
        try
        {
            array[10] = 100;  // Índice fuera de rango
        }
        catch (IndexOutOfRangeException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
        
        try
        {
            string valor = diccionario["inexistente"];
        }
        catch (KeyNotFoundException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
        
        Console.WriteLine("\n=== CARACTERÍSTICAS DE INDEXADORES ===");
        Console.WriteLine("✅ Sintaxis natural tipo array");
        Console.WriteLine("✅ Encapsulación de acceso");
        Console.WriteLine("✅ Pueden usar diferentes tipos de índice");
        Console.WriteLine("✅ Pueden ser virtuales y sobrescribirse");
        Console.WriteLine("✅ Permiten validación y lógica personalizada");
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Indexadores Multidimensionales
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Indexadores Multidimensionales',
    'Aprende a crear indexadores con múltiples parámetros para acceder a estructuras multidimensionales como matrices.',
    'Los **indexadores multidimensionales** permiten acceder a objetos usando múltiples índices, similar a arrays multidimensionales. Son útiles para representar estructuras como matrices, tablas y grids.

**Sintaxis:**

```csharp
public class Matriz
{
    private int[,] datos;
    
    // Indexador bidimensional
    public int this[int fila, int columna]
    {
        get { return datos[fila, columna]; }
        set { datos[fila, columna] = value; }
    }
}

// Uso
Matriz m = new Matriz();
m[0, 0] = 10;
int valor = m[0, 0];
```

**Ventajas:**

✅ **Sintaxis Natural**: Acceso como array multidimensional
✅ **Encapsulación**: Control sobre acceso
✅ **Flexibilidad**: Lógica personalizada

**Ejemplo:**

```csharp
public class Tabla
{
    private string[,] celdas;
    
    public string this[int fila, int col]
    {
        get { return celdas[fila, col]; }
        set { celdas[fila, col] = value; }
    }
}
```',
    'using System;

// Ejemplo de indexador bidimensional
public class Matriz
{
    private int[,] datos;
    private int filas;
    private int columnas;
    
    public Matriz(int filas, int columnas)
    {
        this.filas = filas;
        this.columnas = columnas;
        datos = new int[filas, columnas];
    }
    
    // Indexador bidimensional
    public int this[int fila, int columna]
    {
        get
        {
            ValidarIndices(fila, columna);
            return datos[fila, columna];
        }
        set
        {
            ValidarIndices(fila, columna);
            datos[fila, columna] = value;
        }
    }
    
    private void ValidarIndices(int fila, int columna)
    {
        if (fila < 0 || fila >= filas)
            throw new IndexOutOfRangeException($"Fila {fila} fuera de rango");
        if (columna < 0 || columna >= columnas)
            throw new IndexOutOfRangeException($"Columna {columna} fuera de rango");
    }
    
    public int Filas => filas;
    public int Columnas => columnas;
    
    public void Mostrar()
    {
        for (int i = 0; i < filas; i++)
        {
            for (int j = 0; j < columnas; j++)
            {
                Console.Write($"{this[i, j],5} ");
            }
            Console.WriteLine();
        }
    }
}

// Ejemplo de indexador con múltiples parámetros de diferentes tipos
public class TablaDatos
{
    private string[,] datos;
    private string[] encabezadosFilas;
    private string[] encabezadosColumnas;
    
    public TablaDatos(int filas, int columnas)
    {
        datos = new string[filas, columnas];
        encabezadosFilas = new string[filas];
        encabezadosColumnas = new string[columnas];
    }
    
    // Indexador con int, int
    public string this[int fila, int columna]
    {
        get { return datos[fila, columna]; }
        set { datos[fila, columna] = value; }
    }
    
    // Indexador sobrecargado con string, string (por nombre)
    public string this[string fila, string columna]
    {
        get
        {
            int f = Array.IndexOf(encabezadosFilas, fila);
            int c = Array.IndexOf(encabezadosColumnas, columna);
            if (f < 0 || c < 0)
                throw new KeyNotFoundException($"Fila {fila} o columna {columna} no encontrada");
            return datos[f, c];
        }
        set
        {
            int f = Array.IndexOf(encabezadosFilas, fila);
            int c = Array.IndexOf(encabezadosColumnas, columna);
            if (f < 0 || c < 0)
                throw new KeyNotFoundException($"Fila {fila} o columna {columna} no encontrada");
            datos[f, c] = value;
        }
    }
    
    public void EstablecerEncabezadoFila(int indice, string nombre)
    {
        encabezadosFilas[indice] = nombre;
    }
    
    public void EstablecerEncabezadoColumna(int indice, string nombre)
    {
        encabezadosColumnas[indice] = nombre;
    }
    
    public void Mostrar()
    {
        // Mostrar encabezados de columnas
        Console.Write("      ");
        foreach (string col in encabezadosColumnas)
        {
            Console.Write($"{col,10} ");
        }
        Console.WriteLine();
        
        // Mostrar datos
        for (int i = 0; i < datos.GetLength(0); i++)
        {
            Console.Write($"{encabezadosFilas[i],5} ");
            for (int j = 0; j < datos.GetLength(1); j++)
            {
                Console.Write($"{datos[i, j],10} ");
            }
            Console.WriteLine();
        }
    }
}

// Ejemplo de indexador tridimensional
public class Cubo
{
    private int[,,] datos;
    private int x, y, z;
    
    public Cubo(int x, int y, int z)
    {
        this.x = x;
        this.y = y;
        this.z = z;
        datos = new int[x, y, z];
    }
    
    // Indexador tridimensional
    public int this[int i, int j, int k]
    {
        get
        {
            ValidarIndices(i, j, k);
            return datos[i, j, k];
        }
        set
        {
            ValidarIndices(i, j, k);
            datos[i, j, k] = value;
        }
    }
    
    private void ValidarIndices(int i, int j, int k)
    {
        if (i < 0 || i >= x || j < 0 || j >= y || k < 0 || k >= z)
            throw new IndexOutOfRangeException("Índices fuera de rango");
    }
    
    public int X => x;
    public int Y => y;
    public int Z => z;
}

// Ejemplo con matriz de productos
public class Inventario
{
    private Producto[,] productos;
    private int filas;
    private int columnas;
    
    public Inventario(int filas, int columnas)
    {
        this.filas = filas;
        this.columnas = columnas;
        productos = new Producto[filas, columnas];
    }
    
    public Producto this[int fila, int columna]
    {
        get
        {
            ValidarIndices(fila, columna);
            return productos[fila, columna];
        }
        set
        {
            ValidarIndices(fila, columna);
            productos[fila, columna] = value;
        }
    }
    
    private void ValidarIndices(int fila, int columna)
    {
        if (fila < 0 || fila >= filas || columna < 0 || columna >= columnas)
            throw new IndexOutOfRangeException("Índices fuera de rango");
    }
    
    public int Filas => filas;
    public int Columnas => columnas;
}

public class Producto
{
    public string Nombre { get; set; }
    public double Precio { get; set; }
    public int Stock { get; set; }
    
    public Producto(string nombre, double precio, int stock)
    {
        Nombre = nombre;
        Precio = precio;
        Stock = stock;
    }
    
    public override string ToString()
    {
        return $"{Nombre} - ${Precio:F2} (Stock: {Stock})";
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Matriz Bidimensional ===\n");
        
        Matriz matriz = new Matriz(3, 4);
        
        // Llenar matriz usando indexador
        for (int i = 0; i < matriz.Filas; i++)
        {
            for (int j = 0; j < matriz.Columnas; j++)
            {
                matriz[i, j] = (i + 1) * 10 + (j + 1);
            }
        }
        
        Console.WriteLine("Matriz 3x4:");
        matriz.Mostrar();
        
        Console.WriteLine("\nAcceso individual:");
        Console.WriteLine($"matriz[0, 0] = {matriz[0, 0]}");
        Console.WriteLine($"matriz[2, 3] = {matriz[2, 3]}");
        
        Console.WriteLine("\n=== EJEMPLO: Tabla con Múltiples Indexadores ===\n");
        
        TablaDatos tabla = new TablaDatos(3, 3);
        
        // Establecer encabezados
        tabla.EstablecerEncabezadoFila(0, "Q1");
        tabla.EstablecerEncabezadoFila(1, "Q2");
        tabla.EstablecerEncabezadoFila(2, "Q3");
        
        tabla.EstablecerEncabezadoColumna(0, "Ventas");
        tabla.EstablecerEncabezadoColumna(1, "Costos");
        tabla.EstablecerEncabezadoColumna(2, "Ganancia");
        
        // Llenar usando índices numéricos
        tabla[0, 0] = "1000";
        tabla[0, 1] = "600";
        tabla[0, 2] = "400";
        
        tabla[1, 0] = "1200";
        tabla[1, 1] = "700";
        tabla[1, 2] = "500";
        
        tabla[2, 0] = "1100";
        tabla[2, 1] = "650";
        tabla[2, 2] = "450";
        
        tabla.Mostrar();
        
        Console.WriteLine("\nAcceso por nombres:");
        Console.WriteLine($"Q1, Ventas = {tabla["Q1", "Ventas"]}");
        Console.WriteLine($"Q2, Ganancia = {tabla["Q2", "Ganancia"]}");
        
        Console.WriteLine("\n=== EJEMPLO: Cubo Tridimensional ===\n");
        
        Cubo cubo = new Cubo(2, 3, 4);
        
        // Llenar cubo
        int valor = 1;
        for (int i = 0; i < cubo.X; i++)
        {
            for (int j = 0; j < cubo.Y; j++)
            {
                for (int k = 0; k < cubo.Z; k++)
                {
                    cubo[i, j, k] = valor++;
                }
            }
        }
        
        Console.WriteLine("Cubo 2x3x4:");
        for (int i = 0; i < cubo.X; i++)
        {
            Console.WriteLine($"Capa {i}:");
            for (int j = 0; j < cubo.Y; j++)
            {
                for (int k = 0; k < cubo.Z; k++)
                {
                    Console.Write($"{cubo[i, j, k],4} ");
                }
                Console.WriteLine();
            }
            Console.WriteLine();
        }
        
        Console.WriteLine("=== EJEMPLO: Inventario de Productos ===\n");
        
        Inventario inventario = new Inventario(2, 3);
        
        inventario[0, 0] = new Producto("Laptop", 999.99, 10);
        inventario[0, 1] = new Producto("Mouse", 25.50, 50);
        inventario[0, 2] = new Producto("Teclado", 75.00, 30);
        
        inventario[1, 0] = new Producto("Monitor", 250.00, 15);
        inventario[1, 1] = new Producto("Auriculares", 50.00, 40);
        inventario[1, 2] = new Producto("Webcam", 80.00, 20);
        
        Console.WriteLine("Inventario:");
        for (int i = 0; i < inventario.Filas; i++)
        {
            for (int j = 0; j < inventario.Columnas; j++)
            {
                Console.WriteLine($"[{i}, {j}] = {inventario[i, j]}");
            }
        }
        
        Console.WriteLine("\n=== CARACTERÍSTICAS ===");
        Console.WriteLine("✅ Acceso natural tipo array multidimensional");
        Console.WriteLine("✅ Múltiples parámetros de índice");
        Console.WriteLine("✅ Diferentes tipos de índice (int, string, etc.)");
        Console.WriteLine("✅ Encapsulación y validación");
        Console.WriteLine("✅ Sobrecarga de indexadores");
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Indexadores con Validación
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Indexadores con Validación',
    'Aprende a agregar validación y lógica personalizada a tus indexadores para mayor seguridad y control.',
    'Los **indexadores con validación** permiten agregar lógica personalizada, validación de índices y valores, y control de acceso. Esto hace que los indexadores sean más robustos y seguros.

**Validación en Indexadores:**

```csharp
public class Coleccion
{
    private int[] datos;
    
    public int this[int indice]
    {
        get
        {
            // Validar índice
            if (indice < 0 || indice >= datos.Length)
                throw new IndexOutOfRangeException();
            return datos[indice];
        }
        set
        {
            // Validar índice y valor
            if (indice < 0 || indice >= datos.Length)
                throw new IndexOutOfRangeException();
            if (value < 0)
                throw new ArgumentException("Valor no puede ser negativo");
            datos[indice] = value;
        }
    }
}
```

**Tipos de Validación:**

1. **Validación de Índices**: Verificar que el índice esté en rango
2. **Validación de Valores**: Verificar que el valor sea válido
3. **Validación de Estado**: Verificar que el objeto esté en estado válido
4. **Lógica Personalizada**: Transformar valores automáticamente

**Ventajas:**

✅ **Seguridad**: Previene errores de índice
✅ **Robustez**: Valida valores antes de asignar
✅ **Control**: Lógica personalizada
✅ **Depuración**: Errores más claros',
    'using System;

// Ejemplo de indexador con validación completa
public class ListaSegura<T>
{
    private T[] items;
    private int capacidad;
    private int contador;
    
    public ListaSegura(int capacidad)
    {
        if (capacidad <= 0)
            throw new ArgumentException("La capacidad debe ser mayor que 0");
        
        this.capacidad = capacidad;
        items = new T[capacidad];
        contador = 0;
    }
    
    // Indexador con validación
    public T this[int indice]
    {
        get
        {
            ValidarIndice(indice);
            return items[indice];
        }
        set
        {
            ValidarIndice(indice);
            ValidarValor(value);
            items[indice] = value;
        }
    }
    
    private void ValidarIndice(int indice)
    {
        if (indice < 0)
            throw new IndexOutOfRangeException($"Índice {indice} no puede ser negativo");
        if (indice >= contador)
            throw new IndexOutOfRangeException($"Índice {indice} fuera de rango. Tamaño actual: {contador}");
    }
    
    protected virtual void ValidarValor(T valor)
    {
        if (valor == null && typeof(T).IsValueType == false)
            throw new ArgumentNullException(nameof(valor), "El valor no puede ser null");
    }
    
    public void Agregar(T item)
    {
        if (contador >= capacidad)
            throw new InvalidOperationException("Lista llena");
        
        ValidarValor(item);
        items[contador] = item;
        contador++;
    }
    
    public int Cantidad => contador;
    public int Capacidad => capacidad;
}

// Ejemplo con validación de valores específicos
public class ListaNumeros
{
    private double[] numeros;
    private int contador;
    private double minimo;
    private double maximo;
    
    public ListaNumeros(int capacidad, double minimo, double maximo)
    {
        if (capacidad <= 0)
            throw new ArgumentException("La capacidad debe ser mayor que 0");
        if (minimo >= maximo)
            throw new ArgumentException("El mínimo debe ser menor que el máximo");
        
        numeros = new double[capacidad];
        contador = 0;
        this.minimo = minimo;
        this.maximo = maximo;
    }
    
    public double this[int indice]
    {
        get
        {
            ValidarIndice(indice);
            return numeros[indice];
        }
        set
        {
            ValidarIndice(indice);
            ValidarValor(value);
            numeros[indice] = value;
        }
    }
    
    private void ValidarIndice(int indice)
    {
        if (indice < 0 || indice >= contador)
            throw new IndexOutOfRangeException($"Índice {indice} fuera de rango [0, {contador - 1}]");
    }
    
    private void ValidarValor(double valor)
    {
        if (double.IsNaN(valor) || double.IsInfinity(valor))
            throw new ArgumentException("El valor no puede ser NaN o infinito");
        if (valor < minimo || valor > maximo)
            throw new ArgumentOutOfRangeException(nameof(valor), 
                $"El valor debe estar entre {minimo} y {maximo}");
    }
    
    public void Agregar(double numero)
    {
        if (contador >= numeros.Length)
            throw new InvalidOperationException("Lista llena");
        
        ValidarValor(numero);
        numeros[contador] = numero;
        contador++;
    }
    
    public int Cantidad => contador;
}

// Ejemplo con validación de estado
public class BufferCircular
{
    private int[] buffer;
    private int tamaño;
    private int inicio;
    private int fin;
    private int contador;
    
    public BufferCircular(int tamaño)
    {
        if (tamaño <= 0)
            throw new ArgumentException("El tamaño debe ser mayor que 0");
        
        this.tamaño = tamaño;
        buffer = new int[tamaño];
        inicio = 0;
        fin = 0;
        contador = 0;
    }
    
    public int this[int indice]
    {
        get
        {
            ValidarEstado();
            ValidarIndice(indice);
            int posicion = (inicio + indice) % tamaño;
            return buffer[posicion];
        }
        set
        {
            ValidarEstado();
            ValidarIndice(indice);
            ValidarValor(value);
            int posicion = (inicio + indice) % tamaño;
            buffer[posicion] = value;
        }
    }
    
    private void ValidarEstado()
    {
        if (buffer == null)
            throw new InvalidOperationException("El buffer ha sido destruido");
    }
    
    private void ValidarIndice(int indice)
    {
        if (indice < 0 || indice >= contador)
            throw new IndexOutOfRangeException($"Índice {indice} fuera de rango [0, {contador - 1}]");
    }
    
    private void ValidarValor(int valor)
    {
        if (valor < 0)
            throw new ArgumentException("El valor no puede ser negativo");
    }
    
    public void Agregar(int valor)
    {
        ValidarValor(valor);
        buffer[fin] = valor;
        fin = (fin + 1) % tamaño;
        
        if (contador < tamaño)
            contador++;
        else
            inicio = (inicio + 1) % tamaño;  // Sobrescribir más antiguo
    }
    
    public int Cantidad => contador;
    public bool EstaLleno => contador == tamaño;
}

// Ejemplo con transformación automática
public class DiccionarioInsensible
{
    private System.Collections.Generic.Dictionary<string, string> datos;
    
    public DiccionarioInsensible()
    {
        datos = new System.Collections.Generic.Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
    }
    
    public string this[string clave]
    {
        get
        {
            ValidarClave(clave);
            if (!datos.ContainsKey(clave))
                throw new KeyNotFoundException($"Clave {clave} no encontrada");
            return datos[clave];
        }
        set
        {
            ValidarClave(clave);
            ValidarValor(value);
            // Normalizar: convertir a minúsculas para almacenar
            datos[clave.ToLower()] = value;
        }
    }
    
    private void ValidarClave(string clave)
    {
        if (string.IsNullOrWhiteSpace(clave))
            throw new ArgumentException("La clave no puede estar vacía");
    }
    
    private void ValidarValor(string valor)
    {
        if (valor == null)
            throw new ArgumentNullException(nameof(valor));
    }
    
    public bool ContieneClave(string clave)
    {
        ValidarClave(clave);
        return datos.ContainsKey(clave.ToLower());
    }
    
    public int Cantidad => datos.Count;
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Lista Segura ===\n");
        
        try
        {
            ListaSegura<string> lista = new ListaSegura<string>(5);
            
            lista.Agregar("Uno");
            lista.Agregar("Dos");
            lista.Agregar("Tres");
            
            Console.WriteLine($"Cantidad: {lista.Cantidad}");
            Console.WriteLine($"lista[0] = {lista[0]}");
            Console.WriteLine($"lista[1] = {lista[1]}");
            Console.WriteLine($"lista[2] = {lista[2]}");
            
            lista[1] = "Dos Modificado";
            Console.WriteLine($"lista[1] después de modificar = {lista[1]}");
            
            // ERROR: Índice fuera de rango
            try
            {
                string valor = lista[10];
            }
            catch (IndexOutOfRangeException e)
            {
                Console.WriteLine($"Error: {e.Message}");
            }
        }
        catch (Exception e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
        
        Console.WriteLine("\n=== EJEMPLO: Lista de Números con Rango ===\n");
        
        try
        {
            ListaNumeros numeros = new ListaNumeros(5, 0, 100);
            
            numeros.Agregar(10);
            numeros.Agregar(50);
            numeros.Agregar(75);
            
            Console.WriteLine($"numeros[0] = {numeros[0]}");
            Console.WriteLine($"numeros[1] = {numeros[1]}");
            Console.WriteLine($"numeros[2] = {numeros[2]}");
            
            numeros[1] = 60;
            Console.WriteLine($"numeros[1] después de modificar = {numeros[1]}");
            
            // ERROR: Valor fuera de rango
            try
            {
                numeros[0] = 150;
            }
            catch (ArgumentOutOfRangeException e)
            {
                Console.WriteLine($"Error: {e.Message}");
            }
            
            // ERROR: Valor negativo
            try
            {
                numeros.Agregar(-10);
            }
            catch (ArgumentOutOfRangeException e)
            {
                Console.WriteLine($"Error: {e.Message}");
            }
        }
        catch (Exception e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
        
        Console.WriteLine("\n=== EJEMPLO: Buffer Circular ===\n");
        
        BufferCircular buffer = new BufferCircular(3);
        
        buffer.Agregar(10);
        buffer.Agregar(20);
        buffer.Agregar(30);
        
        Console.WriteLine($"Cantidad: {buffer.Cantidad}");
        Console.WriteLine($"buffer[0] = {buffer[0]}");
        Console.WriteLine($"buffer[1] = {buffer[1]}");
        Console.WriteLine($"buffer[2] = {buffer[2]}");
        
        // Agregar más, sobrescribe el más antiguo
        buffer.Agregar(40);
        Console.WriteLine("\nDespués de agregar 40 (sobrescribe el primero):");
        Console.WriteLine($"buffer[0] = {buffer[0]}");
        Console.WriteLine($"buffer[1] = {buffer[1]}");
        Console.WriteLine($"buffer[2] = {buffer[2]}");
        
        Console.WriteLine("\n=== EJEMPLO: Diccionario Insensible ===\n");
        
        DiccionarioInsensible diccionario = new DiccionarioInsensible();
        
        diccionario["Nombre"] = "Juan";
        diccionario["EDAD"] = "25";
        diccionario["ciudad"] = "Madrid";
        
        // Acceso insensible a mayúsculas/minúsculas
        Console.WriteLine($"diccionario[nombre] = {diccionario["nombre"]}");
        Console.WriteLine($"diccionario[EDAD] = {diccionario["EDAD"]}");
        Console.WriteLine($"diccionario[CIUDAD] = {diccionario["CIUDAD"]}");
        
        Console.WriteLine("\n=== CARACTERÍSTICAS DE VALIDACIÓN ===");
        Console.WriteLine("✅ Validación de índices");
        Console.WriteLine("✅ Validación de valores");
        Console.WriteLine("✅ Validación de estado");
        Console.WriteLine("✅ Transformación automática");
        Console.WriteLine("✅ Mensajes de error claros");
        Console.WriteLine("✅ Prevención de errores en tiempo de ejecución");
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Mejores Prácticas con Propiedades e Indexadores
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Mejores Prácticas con Propiedades e Indexadores',
    'Aprende las mejores prácticas, principios de diseño y cuándo usar propiedades vs métodos vs indexadores.',
    'Usar propiedades e indexadores correctamente requiere seguir ciertas prácticas y principios. Aquí están las mejores prácticas:

**Mejores Prácticas con Propiedades:**

1. **Usa Propiedades para Acceso a Datos**
   - Propiedades para acceso simple a datos
   - Métodos para operaciones complejas

2. **Validación en Setters**
   - Valida valores antes de asignar
   - Lanza excepciones apropiadas

3. **Propiedades Calculadas**
   - Usa propiedades calculadas cuando el valor deriva de otros
   - Evita propiedades calculadas costosas (usa métodos)

4. **Nombres Descriptivos**
   - Nombres claros y descriptivos
   - Evita abreviaciones

**Mejores Prácticas con Indexadores:**

1. **Usa Indexadores para Colecciones**
   - Indexadores para clases que representan colecciones
   - Métodos para operaciones complejas

2. **Validación de Índices**
   - Siempre valida índices
   - Lanza excepciones apropiadas

3. **Sintaxis Natural**
   - Usa tipos de índice intuitivos
   - Evita indexadores confusos

**Cuándo Usar Propiedades vs Métodos:**

✅ **Usa Propiedades cuando:**
- Acceso simple a datos
- Valor calculado simple
- Operación rápida
- No tiene efectos secundarios importantes

❌ **Usa Métodos cuando:**
- Operación costosa
- Tiene efectos secundarios significativos
- Necesita parámetros
- Retorna múltiples valores

**Cuándo Usar Indexadores:**

✅ **Usa Indexadores cuando:**
- Tu clase es una colección
- Quieres sintaxis tipo array
- El acceso es intuitivo con índices

❌ **NO uses Indexadores cuando:**
- El acceso no es intuitivo
- Necesitas múltiples parámetros complejos
- La operación es costosa

**Buenas Prácticas:**

1. **Inmutabilidad**: Usa propiedades de solo lectura cuando sea apropiado
2. **Encapsulación**: Oculta implementación interna
3. **Validación**: Valida siempre
4. **Rendimiento**: Evita cálculos costosos en propiedades
5. **Documentación**: Documenta contratos claramente',
    'using System;

// ============================================
// EJEMPLO: Diseño Correcto de Propiedades
// ============================================

// BIEN: Clase con propiedades bien diseñadas
public class Producto
{
    // Propiedades auto-implementadas simples
    public string Nombre { get; set; }
    public string Codigo { get; set; }
    
    // Propiedad con validación
    private double precio;
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
    
    // Propiedad de solo lectura (inmutable)
    public int Id { get; }
    
    // Propiedad calculada simple (BIEN)
    public double PrecioConIVA => Precio * 1.21;
    
    // MAL: Propiedad calculada costosa (debería ser método)
    // public List<Producto> ProductosRelacionados
    // {
    //     get
    //     {
    //         // Operación costosa de base de datos
    //         return ConsultarBaseDeDatos();
    //     }
    // }
    
    // BIEN: Método para operación costosa
    public System.Collections.Generic.List<Producto> ObtenerProductosRelacionados()
    {
        // Simular operación costosa
        return new System.Collections.Generic.List<Producto>();
    }
    
    public Producto(int id, string nombre, double precio)
    {
        Id = id;
        Nombre = nombre;
        Precio = precio;
    }
}

// ============================================
// EJEMPLO: Diseño Correcto de Indexadores
// ============================================

// BIEN: Indexador para clase colección
public class Inventario
{
    private Producto[] productos;
    private int contador;
    
    public Inventario(int capacidad)
    {
        productos = new Producto[capacidad];
        contador = 0;
    }
    
    // BIEN: Indexador con validación
    public Producto this[int indice]
    {
        get
        {
            ValidarIndice(indice);
            return productos[indice];
        }
        set
        {
            ValidarIndice(indice);
            if (value == null)
                throw new ArgumentNullException(nameof(value));
            productos[indice] = value;
        }
    }
    
    // BIEN: Método para agregar (no indexador)
    public void Agregar(Producto producto)
    {
        if (contador >= productos.Length)
            throw new InvalidOperationException("Inventario lleno");
        if (producto == null)
            throw new ArgumentNullException(nameof(producto));
        
        productos[contador] = producto;
        contador++;
    }
    
    // BIEN: Método para buscar (no indexador)
    public Producto BuscarPorCodigo(string codigo)
    {
        for (int i = 0; i < contador; i++)
        {
            if (productos[i].Codigo == codigo)
                return productos[i];
        }
        return null;
    }
    
    private void ValidarIndice(int indice)
    {
        if (indice < 0 || indice >= contador)
            throw new IndexOutOfRangeException($"Índice {indice} fuera de rango");
    }
    
    public int Cantidad => contador;
}

// ============================================
// EJEMPLO: Propiedades vs Métodos
// ============================================

public class Calculadora
{
    public double Valor1 { get; set; }
    public double Valor2 { get; set; }
    
    // BIEN: Propiedad calculada simple
    public double Suma => Valor1 + Valor2;
    
    // BIEN: Método para operación con parámetros
    public double Multiplicar(double a, double b)
    {
        return a * b;
    }
    
    // BIEN: Método para operación con efectos secundarios
    public void Limpiar()
    {
        Valor1 = 0;
        Valor2 = 0;
        Console.WriteLine("Calculadora limpiada");
    }
    
    // BIEN: Método para operación costosa
    public double CalcularPotencia(double baseNum, double exponente)
    {
        // Operación más compleja
        return Math.Pow(baseNum, exponente);
    }
}

// ============================================
// EJEMPLO: Buenas Prácticas Combinadas
// ============================================

public class Tienda
{
    private Inventario inventario;
    private string nombre;
    private double descuento;
    
    // Propiedades bien diseñadas
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
    
    public double Descuento
    {
        get { return descuento; }
        set
        {
            if (value < 0 || value > 100)
                throw new ArgumentException("El descuento debe estar entre 0 y 100");
            descuento = value;
        }
    }
    
    // Propiedad calculada
    public int TotalProductos => inventario.Cantidad;
    
    // Propiedad de solo lectura
    public DateTime FechaApertura { get; }
    
    // Indexador delegado al inventario
    public Producto this[int indice] => inventario[indice];
    
    public Tienda(string nombre, double descuento)
    {
        Nombre = nombre;
        Descuento = descuento;
        inventario = new Inventario(100);
        FechaApertura = DateTime.Now;
    }
    
    // Métodos para operaciones complejas
    public void AgregarProducto(Producto producto)
    {
        inventario.Agregar(producto);
    }
    
    public Producto BuscarProducto(string codigo)
    {
        return inventario.BuscarPorCodigo(codigo);
    }
    
    public double CalcularPrecioConDescuento(Producto producto)
    {
        return producto.Precio * (1 - Descuento / 100);
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Buenas Prácticas con Propiedades ===\n");
        
        Producto producto = new Producto(1, "Laptop", 999.99);
        Console.WriteLine($"ID: {producto.Id}");  // Solo lectura
        Console.WriteLine($"Nombre: {producto.Nombre}");
        Console.WriteLine($"Precio: ${producto.Precio:F2}");
        Console.WriteLine($"Precio con IVA: ${producto.PrecioConIVA:F2}");  // Calculada
        
        // Validación en setter
        try
        {
            producto.Precio = -100;  // ERROR
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
        
        Console.WriteLine("\n=== EJEMPLO: Buenas Prácticas con Indexadores ===\n");
        
        Inventario inventario = new Inventario(5);
        
        inventario.Agregar(new Producto(1, "Laptop", 999.99) { Codigo = "LAP-001" });
        inventario.Agregar(new Producto(2, "Mouse", 25.50) { Codigo = "MOU-001" });
        
        // Usar indexador para acceso
        Console.WriteLine($"Producto en índice 0: {inventario[0].Nombre}");
        Console.WriteLine($"Producto en índice 1: {inventario[1].Nombre}");
        
        // Usar método para búsqueda
        Producto encontrado = inventario.BuscarPorCodigo("LAP-001");
        if (encontrado != null)
            Console.WriteLine($"Producto encontrado: {encontrado.Nombre}");
        
        Console.WriteLine("\n=== EJEMPLO: Propiedades vs Métodos ===\n");
        
        Calculadora calc = new Calculadora
        {
            Valor1 = 10,
            Valor2 = 20
        };
        
        // Propiedad: operación simple
        Console.WriteLine($"Suma (propiedad): {calc.Suma}");
        
        // Método: con parámetros
        Console.WriteLine($"Multiplicación (método): {calc.Multiplicar(5, 6)}");
        
        // Método: con efectos secundarios
        calc.Limpiar();
        
        Console.WriteLine("\n=== EJEMPLO: Diseño Completo ===\n");
        
        Tienda tienda = new Tienda("Mi Tienda", 10);
        tienda.AgregarProducto(new Producto(1, "Producto 1", 100) { Codigo = "P1" });
        tienda.AgregarProducto(new Producto(2, "Producto 2", 200) { Codigo = "P2" });
        
        Console.WriteLine($"Tienda: {tienda.Nombre}");
        Console.WriteLine($"Total productos: {tienda.TotalProductos}");
        Console.WriteLine($"Fecha apertura: {tienda.FechaApertura}");
        
        // Usar indexador
        Console.WriteLine($"Producto 0: {tienda[0].Nombre}");
        
        // Usar métodos
        Producto productoEncontrado = tienda.BuscarProducto("P1");
        if (productoEncontrado != null)
        {
            double precioConDescuento = tienda.CalcularPrecioConDescuento(productoEncontrado);
            Console.WriteLine($"Precio con descuento: ${precioConDescuento:F2}");
        }
        
        Console.WriteLine("\n=== MEJORES PRÁCTICAS ===");
        Console.WriteLine("✅ Propiedades para acceso simple");
        Console.WriteLine("✅ Métodos para operaciones complejas");
        Console.WriteLine("✅ Indexadores para colecciones");
        Console.WriteLine("✅ Validación siempre");
        Console.WriteLine("✅ Propiedades de solo lectura para inmutabilidad");
        Console.WriteLine("✅ Documentación clara");
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
PRINT 'Lecciones del curso "Propiedades e Indexadores":';
PRINT '1. Introducción a Propiedades';
PRINT '2. Propiedades Auto-Implementadas';
PRINT '3. Propiedades de Solo Lectura y Escritura';
PRINT '4. Propiedades Calculadas y Virtuales';
PRINT '5. Introducción a Indexadores';
PRINT '6. Indexadores Multidimensionales';
PRINT '7. Indexadores con Validación';
PRINT '8. Mejores Prácticas con Propiedades e Indexadores';
GO


