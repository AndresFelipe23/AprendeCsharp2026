-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Encapsulación y Modificadores de Acceso"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Encapsulación y Modificadores de Acceso" en la ruta con RutaId = 2
DECLARE @CursoId INT;
DECLARE @RutaId INT = 2; -- RutaId de "Programación Orientada a Objetos"
DECLARE @NombreCurso NVARCHAR(100) = 'Encapsulación y Modificadores de Acceso';

-- Buscar el curso "Encapsulación y Modificadores de Acceso" en la ruta con RutaId = 2
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
        'Aprende a controlar el acceso a los miembros de una clase usando modificadores de acceso y propiedades',
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
-- LECCIÓN 1: Introducción a la Encapsulación
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a la Encapsulación',
    'Comprende qué es la encapsulación y por qué es fundamental en la Programación Orientada a Objetos.',
    'La **encapsulación** es uno de los cuatro pilares fundamentales de la Programación Orientada a Objetos (POO), junto con la herencia, el polimorfismo y la abstracción. Es el mecanismo que permite ocultar los detalles internos de una clase y exponer solo lo necesario.

**¿Qué es la Encapsulación?**

La encapsulación es el proceso de:
- **Ocultar** los detalles de implementación internos de una clase
- **Proteger** los datos de acceso no autorizado
- **Controlar** cómo se accede y modifica la información
- **Exponer** solo una interfaz pública bien definida

**Analogía del Mundo Real:**

Piensa en un automóvil:
- **Interfaz pública**: Volante, pedales, palanca de cambios (lo que puedes usar)
- **Implementación oculta**: Motor, transmisión, sistema eléctrico (detalles internos)
- No necesitas saber cómo funciona el motor para conducir, solo necesitas saber usar la interfaz

**Beneficios de la Encapsulación:**

1. **Seguridad de Datos**: Previene modificaciones accidentales o maliciosas
2. **Mantenibilidad**: Puedes cambiar la implementación interna sin afectar el código que usa la clase
3. **Flexibilidad**: Permite validación y transformación de datos antes de almacenarlos
4. **Abstracción**: Simplifica el uso de la clase ocultando la complejidad
5. **Reutilización**: Facilita la creación de componentes reutilizables y confiables

**Principio de Menor Privilegio:**

Siempre usa el modificador de acceso más restrictivo posible:
- Si no necesita ser público, hazlo privado
- Si no necesita ser accesible desde fuera, hazlo interno
- Expón solo lo que es absolutamente necesario

**Ejemplo Básico:**

```csharp
// MAL: Todo es público
public class CuentaBancaria
{
    public double saldo;  // Cualquiera puede modificar directamente
}

// BIEN: Encapsulación correcta
public class CuentaBancaria
{
    private double saldo;  // Privado: solo accesible dentro de la clase
    
    public double ObtenerSaldo()  // Método público para leer
    {
        return saldo;
    }
    
    public void Depositar(double cantidad)  // Método público para modificar con validación
    {
        if (cantidad > 0)
            saldo += cantidad;
    }
}
```

**En Resumen:**

La encapsulación protege los datos y controla el acceso, haciendo que tu código sea más seguro, mantenible y fácil de usar.',
    'using System;

// Ejemplo SIN encapsulación (mal diseño)
public class CuentaBancariaMala
{
    public double saldo;  // Accesible desde cualquier lugar - PELIGROSO
    
    public void MostrarSaldo()
    {
        Console.WriteLine($"Saldo: ${saldo:F2}");
    }
}

// Ejemplo CON encapsulación (buen diseño)
public class CuentaBancariaBuena
{
    private double saldo;  // Privado: solo accesible dentro de la clase
    
    // Constructor para inicializar
    public CuentaBancariaBuena(double saldoInicial)
    {
        if (saldoInicial >= 0)
            saldo = saldoInicial;
        else
            saldo = 0;
    }
    
    // Método público para leer el saldo
    public double ObtenerSaldo()
    {
        return saldo;
    }
    
    // Método público para depositar (con validación)
    public void Depositar(double cantidad)
    {
        if (cantidad > 0)
        {
            saldo += cantidad;
            Console.WriteLine($"Depositado: ${cantidad:F2}. Nuevo saldo: ${saldo:F2}");
        }
        else
        {
            Console.WriteLine("Error: La cantidad debe ser positiva");
        }
    }
    
    // Método público para retirar (con validación)
    public bool Retirar(double cantidad)
    {
        if (cantidad <= 0)
        {
            Console.WriteLine("Error: La cantidad debe ser positiva");
            return false;
        }
        
        if (cantidad > saldo)
        {
            Console.WriteLine("Error: Saldo insuficiente");
            return false;
        }
        
        saldo -= cantidad;
        Console.WriteLine($"Retirado: ${cantidad:F2}. Nuevo saldo: ${saldo:F2}");
        return true;
    }
    
    public void MostrarSaldo()
    {
        Console.WriteLine($"Saldo actual: ${saldo:F2}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO SIN ENCAPSULACIÓN (MAL) ===");
        CuentaBancariaMala cuentaMala = new CuentaBancariaMala();
        cuentaMala.saldo = 1000;  // Acceso directo - puede ser peligroso
        cuentaMala.saldo = -500;  // Puedo poner valores inválidos
        cuentaMala.MostrarSaldo();
        
        Console.WriteLine("\n=== EJEMPLO CON ENCAPSULACIÓN (BIEN) ===");
        CuentaBancariaBuena cuentaBuena = new CuentaBancariaBuena(1000);
        cuentaBuena.MostrarSaldo();
        
        cuentaBuena.Depositar(500);
        cuentaBuena.Retirar(200);
        cuentaBuena.Retirar(1500);  // Intento retirar más de lo disponible
        
        // No puedo acceder directamente al saldo privado
        // cuentaBuena.saldo = -1000;  // ERROR: saldo es privado
        Console.WriteLine($"\nSaldo obtenido mediante método: ${cuentaBuena.ObtenerSaldo():F2}");
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Modificadores de Acceso Básicos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Modificadores de Acceso Básicos',
    'Aprende los modificadores de acceso fundamentales: public, private, protected e internal.',
    'Los **modificadores de acceso** controlan desde dónde se puede acceder a los miembros de una clase (campos, métodos, propiedades). Son la herramienta principal para implementar la encapsulación.

**Modificadores de Acceso en C#:**

1. **`public`** - Acceso Público
2. **`private`** - Acceso Privado
3. **`protected`** - Acceso Protegido
4. **`internal`** - Acceso Interno
5. **`protected internal`** - Acceso Protegido Interno
6. **`private protected`** - Acceso Privado Protegido

**1. `public` - Acceso Público**

- Accesible desde **cualquier lugar**
- No hay restricciones de acceso
- Usa con precaución: solo para lo que realmente necesita ser público

```csharp
public class Persona
{
    public string Nombre;  // Cualquiera puede leer y modificar
    public void Saludar() { }  // Cualquiera puede llamar
}
```

**2. `private` - Acceso Privado**

- Accesible **solo dentro de la misma clase**
- Es el modificador más restrictivo
- **Recomendado por defecto** para campos y métodos internos

```csharp
public class Persona
{
    private string nombre;  // Solo accesible dentro de Persona
    private void MetodoPrivado() { }  // Solo dentro de Persona
}
```

**3. `protected` - Acceso Protegido**

- Accesible en la **clase y clases derivadas** (herencia)
- No accesible desde fuera de la jerarquía de clases
- Útil para compartir miembros con clases hijas

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

**4. `internal` - Acceso Interno**

- Accesible dentro del **mismo ensamblado** (proyecto)
- No accesible desde otros proyectos
- Útil para APIs internas del proyecto

```csharp
internal class Utilidad  // Solo visible en el mismo proyecto
{
    internal static void Metodo() { }
}
```

**Niveles de Restricción (de menos a más restrictivo):**

```
public > internal > protected > private
```

**Buenas Prácticas:**

- **Campos**: Generalmente `private`
- **Propiedades**: `public` para acceso controlado
- **Métodos públicos**: `public` para la interfaz de la clase
- **Métodos internos**: `private` para lógica interna
- **Miembros compartidos**: `protected` para herencia

**Regla de Oro:**

> "Usa el modificador más restrictivo posible. Si no necesita ser público, hazlo privado."',
    'using System;

// Ejemplo de diferentes modificadores de acceso
public class Persona
{
    // PUBLIC: Accesible desde cualquier lugar
    public string NombrePublico;
    
    // PRIVATE: Solo accesible dentro de esta clase
    private string nombrePrivado;
    private int edadPrivada;
    
    // PROTECTED: Accesible en esta clase y clases derivadas
    protected string apellidoProtegido;
    
    // INTERNAL: Accesible dentro del mismo ensamblado (proyecto)
    internal string documentoInterno;
    
    // Constructor
    public Persona(string nombre, string apellido, int edad)
    {
        nombrePrivado = nombre;
        apellidoProtegido = apellido;
        edadPrivada = edad;
        NombrePublico = nombre;  // Puedo acceder a campos públicos
    }
    
    // Método público
    public void MostrarInformacion()
    {
        Console.WriteLine($"Nombre: {nombrePrivado} {apellidoProtegido}");
        Console.WriteLine($"Edad: {edadPrivada}");
        Console.WriteLine($"Documento: {documentoInterno}");
    }
    
    // Método privado (solo dentro de Persona)
    private void MetodoPrivado()
    {
        Console.WriteLine("Este método es privado");
        // Puedo acceder a campos privados aquí
        nombrePrivado = "Modificado";
    }
    
    // Método protegido (accesible en clases derivadas)
    protected void MetodoProtegido()
    {
        Console.WriteLine("Este método es protegido");
    }
    
    // Método público que usa método privado
    public void UsarMetodoPrivado()
    {
        MetodoPrivado();  // OK: dentro de la misma clase
    }
}

// Clase derivada (herencia)
public class Empleado : Persona
{
    public Empleado(string nombre, string apellido, int edad) 
        : base(nombre, apellido, edad)
    {
        // Puedo acceder a miembros protegidos
        apellidoProtegido = apellido;
        MetodoProtegido();  // OK: método protegido
        
        // NO puedo acceder a miembros privados de la clase base
        // nombrePrivado = "Juan";  // ERROR: privado
        // MetodoPrivado();  // ERROR: privado
    }
}

class Program
{
    static void Main()
    {
        Persona persona = new Persona("Juan", "Pérez", 30);
        
        // Acceso a miembros públicos
        persona.NombrePublico = "Pedro";
        persona.MostrarInformacion();
        persona.UsarMetodoPrivado();
        
        // NO puedo acceder a miembros privados
        // persona.nombrePrivado = "María";  // ERROR: privado
        // persona.MetodoPrivado();  // ERROR: privado
        
        // NO puedo acceder a miembros protegidos desde fuera
        // persona.apellidoProtegido = "García";  // ERROR: protegido
        // persona.MetodoProtegido();  // ERROR: protegido
        
        Console.WriteLine("\n=== CREANDO EMPLEADO ===");
        Empleado empleado = new Empleado("Ana", "García", 25);
        empleado.MostrarInformacion();
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Propiedades y Encapsulación
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Propiedades y Encapsulación',
    'Aprende a usar propiedades para implementar encapsulación de manera elegante y controlar el acceso a los datos.',
    'Las **propiedades** en C# son una forma elegante de encapsular campos, proporcionando acceso controlado a los datos con la posibilidad de agregar validación y lógica adicional.

**¿Qué son las Propiedades?**

Las propiedades son miembros de clase que proporcionan un mecanismo flexible para leer, escribir o calcular valores de campos privados. Son la forma recomendada de exponer datos públicamente en C#.

**Sintaxis Básica:**

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
public class Persona
{
    public string Nombre { get; set; }  // C# crea el campo automáticamente
    public int Edad { get; set; }
}
```

**Propiedades de Solo Lectura:**

```csharp
public class Persona
{
    private string nombre;
    
    // Solo lectura desde fuera
    public string Nombre
    {
        get { return nombre; }
        private set { nombre = value; }  // Solo se puede modificar dentro de la clase
    }
    
    // O usando sintaxis simplificada (C# 6.0+)
    public string Apellido { get; }  // Solo lectura, se inicializa en constructor
}
```

**Propiedades con Validación:**

Las propiedades permiten validar datos antes de asignarlos:

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

Puedes crear propiedades que calculan su valor en lugar de almacenarlo:

```csharp
public string NombreCompleto
{
    get { return $"{Nombre} {Apellido}"; }
}
```

**Ventajas de las Propiedades:**

1. **Encapsulación**: Ocultas los campos internos
2. **Validación**: Puedes validar datos antes de asignarlos
3. **Flexibilidad**: Puedes cambiar la implementación sin afectar el código que usa la clase
4. **Sintaxis Limpia**: Se usan como campos pero con control de acceso

**Cuándo Usar Propiedades vs Campos:**

- **Usa Propiedades** para:
  - Miembros públicos
  - Cuando necesitas validación
  - Cuando necesitas cálculos o transformaciones
  
- **Usa Campos** para:
  - Miembros privados internos
  - Cuando no necesitas validación ni lógica adicional',
    'using System;

public class Producto
{
    // Campos privados (backing fields)
    private string nombre;
    private double precio;
    private int stock;
    private string codigo;
    
    // Propiedad con validación
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
    
    // Propiedad con validación de rango
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
    
    // Propiedad de solo lectura (se establece en constructor)
    public string Codigo
    {
        get { return codigo; }
        private set { codigo = value; }
    }
    
    // Propiedad con get privado (solo lectura desde fuera)
    public int Stock
    {
        get { return stock; }
        private set
        {
            if (value < 0)
                throw new ArgumentException("El stock no puede ser negativo");
            stock = value;
        }
    }
    
    // Propiedad calculada (no almacena valor, lo calcula)
    public double ValorTotal
    {
        get { return precio * stock; }
    }
    
    // Propiedad calculada con lógica
    public string Estado
    {
        get
        {
            if (stock == 0)
                return "Agotado";
            else if (stock < 10)
                return "Bajo stock";
            else
                return "Disponible";
        }
    }
    
    // Constructor
    public Producto(string nombre, double precio, string codigo, int stockInicial)
    {
        Nombre = nombre;  // Usa el setter con validación
        Precio = precio;
        Codigo = codigo;  // Puedo usar el setter privado aquí
        Stock = stockInicial;  // Puedo usar el setter privado aquí
    }
    
    // Métodos para modificar stock (encapsulación)
    public void AgregarStock(int cantidad)
    {
        if (cantidad <= 0)
            throw new ArgumentException("La cantidad debe ser positiva");
        Stock += cantidad;  // Usa el setter privado
    }
    
    public bool Vender(int cantidad)
    {
        if (cantidad <= 0)
            throw new ArgumentException("La cantidad debe ser positiva");
        
        if (cantidad > Stock)
            return false;
        
        Stock -= cantidad;
        return true;
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Producto: {Nombre}");
        Console.WriteLine($"Código: {Codigo}");
        Console.WriteLine($"Precio: ${Precio:F2}");
        Console.WriteLine($"Stock: {Stock} unidades");
        Console.WriteLine($"Valor Total: ${ValorTotal:F2}");
        Console.WriteLine($"Estado: {Estado}");
    }
}

class Program
{
    static void Main()
    {
        try
        {
            Producto producto = new Producto("Laptop", 999.99, "LAP-001", 15);
            
            Console.WriteLine("=== INFORMACIÓN INICIAL ===");
            producto.MostrarInformacion();
            
            Console.WriteLine("\n=== AGREGANDO STOCK ===");
            producto.AgregarStock(10);
            producto.MostrarInformacion();
            
            Console.WriteLine("\n=== REALIZANDO VENTA ===");
            if (producto.Vender(5))
            {
                Console.WriteLine("Venta exitosa");
                producto.MostrarInformacion();
            }
            
            Console.WriteLine("\n=== PROPIEDADES CALCULADAS ===");
            Console.WriteLine($"Valor Total: ${producto.ValorTotal:F2}");
            Console.WriteLine($"Estado: {producto.Estado}");
            
            // Intentar establecer precio negativo
            Console.WriteLine("\n=== INTENTANDO PRECIO NEGATIVO ===");
            try
            {
                producto.Precio = -100;
            }
            catch (ArgumentException e)
            {
                Console.WriteLine($"Error: {e.Message}");
            }
            
            // No puedo modificar el código directamente
            // producto.Codigo = "NUEVO";  // ERROR: set es privado
            // producto.Stock = 100;  // ERROR: set es privado
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Modificadores de Acceso Avanzados
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Modificadores de Acceso Avanzados',
    'Aprende los modificadores de acceso combinados: protected internal y private protected.',
    'Además de los modificadores básicos, C# ofrece **modificadores combinados** que proporcionan control más granular sobre el acceso a los miembros de una clase.

**Modificadores Combinados:**

1. **`protected internal`** - Acceso Protegido Interno
2. **`private protected`** - Acceso Privado Protegido

**1. `protected internal` - Acceso Protegido Interno**

Un miembro con `protected internal` es accesible:
- En la **clase actual**
- En **clases derivadas** (hereda de la clase actual)
- Dentro del **mismo ensamblado** (proyecto)

Es la **unión** de `protected` e `internal` (OR lógico).

```csharp
public class Base
{
    protected internal int valor;  // Accesible en derivadas Y en el mismo proyecto
}

public class Derivada : Base
{
    public void Metodo()
    {
        valor = 10;  // OK: Derivada hereda de Base
    }
}

// En el mismo proyecto
class Program
{
    static void Main()
    {
        Base b = new Base();
        b.valor = 20;  // OK: mismo ensamblado
    }
}
```

**2. `private protected` - Acceso Privado Protegido**

Un miembro con `private protected` es accesible:
- En la **clase actual**
- En **clases derivadas** que están en el **mismo ensamblado**

Es la **intersección** de `private` y `protected` (AND lógico).

```csharp
public class Base
{
    private protected int valor;  // Solo en derivadas del mismo proyecto
}

public class Derivada : Base
{
    public void Metodo()
    {
        valor = 10;  // OK: Derivada en el mismo proyecto
    }
}

// En el mismo proyecto
class Program
{
    static void Main()
    {
        Base b = new Base();
        // b.valor = 20;  // ERROR: no es accesible desde fuera de la jerarquía
    }
}
```

**Tabla de Resumen:**

| Modificador | Misma Clase | Clase Derivada (mismo proyecto) | Clase Derivada (otro proyecto) | Mismo Proyecto | Otro Proyecto |
|------------|-------------|----------------------------------|-------------------------------|----------------|---------------|
| `private` | ✅ | ❌ | ❌ | ❌ | ❌ |
| `protected` | ✅ | ✅ | ✅ | ❌ | ❌ |
| `internal` | ✅ | ❌ | ❌ | ✅ | ❌ |
| `protected internal` | ✅ | ✅ | ✅ | ✅ | ❌ |
| `private protected` | ✅ | ✅ | ❌ | ❌ | ❌ |
| `public` | ✅ | ✅ | ✅ | ✅ | ✅ |

**Cuándo Usar Cada Modificador:**

- **`private`**: Implementación interna, no debe ser accesible desde fuera
- **`protected`**: Compartir con clases derivadas en cualquier proyecto
- **`internal`**: API interna del proyecto, no para uso externo
- **`protected internal`**: Compartir con derivadas Y permitir acceso interno del proyecto
- **`private protected`**: Compartir solo con derivadas del mismo proyecto
- **`public`**: Interfaz pública, accesible desde cualquier lugar

**Buenas Prácticas:**

1. Empieza con `private` y aumenta la visibilidad solo si es necesario
2. Usa `protected` cuando necesites compartir con clases derivadas
3. Usa `internal` para APIs que solo deben usarse dentro del proyecto
4. Evita `public` a menos que sea absolutamente necesario',
    'using System;

// ============================================
// EJEMPLO: protected internal
// ============================================

public class Base
{
    // protected internal: accesible en derivadas Y en el mismo proyecto
    protected internal int valorProtegidoInterno;
    
    // protected: solo en derivadas
    protected int valorProtegido;
    
    // private: solo en esta clase
    private int valorPrivado;
    
    public Base()
    {
        valorProtegidoInterno = 100;
        valorProtegido = 200;
        valorPrivado = 300;
    }
    
    public void MostrarValores()
    {
        Console.WriteLine($"Protegido Interno: {valorProtegidoInterno}");
        Console.WriteLine($"Protegido: {valorProtegido}");
        Console.WriteLine($"Privado: {valorPrivado}");
    }
}

// Clase derivada en el mismo proyecto
public class DerivadaMismoProyecto : Base
{
    public void AccederValores()
    {
        // Puedo acceder a protected internal
        valorProtegidoInterno = 150;
        Console.WriteLine($"Acceso desde derivada: {valorProtegidoInterno}");
        
        // Puedo acceder a protected
        valorProtegido = 250;
        Console.WriteLine($"Acceso a protegido: {valorProtegido}");
        
        // NO puedo acceder a private
        // valorPrivado = 350;  // ERROR
    }
}

// ============================================
// EJEMPLO: private protected
// ============================================

public class BasePrivada
{
    // private protected: solo en derivadas del mismo proyecto
    private protected int valorPrivadoProtegido;
    
    // internal: en el mismo proyecto
    internal int valorInterno;
    
    public BasePrivada()
    {
        valorPrivadoProtegido = 100;
        valorInterno = 200;
    }
}

public class DerivadaPrivada : BasePrivada
{
    public void AccederValores()
    {
        // Puedo acceder a private protected (mismo proyecto)
        valorPrivadoProtegido = 150;
        Console.WriteLine($"Private Protected: {valorPrivadoProtegido}");
        
        // Puedo acceder a internal
        valorInterno = 250;
        Console.WriteLine($"Internal: {valorInterno}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: protected internal ===");
        Base base1 = new Base();
        base1.MostrarValores();
        
        // Puedo acceder a protected internal desde el mismo proyecto
        base1.valorProtegidoInterno = 999;
        Console.WriteLine($"Modificado desde Program: {base1.valorProtegidoInterno}");
        
        // NO puedo acceder a protected desde fuera de la jerarquía
        // base1.valorProtegido = 888;  // ERROR
        
        DerivadaMismoProyecto derivada = new DerivadaMismoProyecto();
        derivada.AccederValores();
        
        Console.WriteLine("\n=== EJEMPLO: private protected ===");
        BasePrivada base2 = new BasePrivada();
        
        // Puedo acceder a internal desde el mismo proyecto
        base2.valorInterno = 777;
        Console.WriteLine($"Internal modificado: {base2.valorInterno}");
        
        // NO puedo acceder a private protected desde fuera de la jerarquía
        // base2.valorPrivadoProtegido = 666;  // ERROR
        
        DerivadaPrivada derivada2 = new DerivadaPrivada();
        derivada2.AccederValores();
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Métodos de Acceso (Getters y Setters)
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos de Acceso (Getters y Setters)',
    'Aprende a crear métodos getter y setter personalizados para controlar el acceso a los datos de manera más flexible.',
    'Aunque las propiedades son la forma moderna y recomendada en C#, también puedes usar **métodos getter y setter** tradicionales para implementar encapsulación. Esto te da más control y flexibilidad en casos específicos.

**Métodos Getter y Setter:**

Los métodos getter y setter son métodos públicos que permiten leer y escribir valores de campos privados:

```csharp
public class Persona
{
    private string nombre;
    
    // Getter: método para leer
    public string GetNombre()
    {
        return nombre;
    }
    
    // Setter: método para escribir
    public void SetNombre(string nuevoNombre)
    {
        if (!string.IsNullOrWhiteSpace(nuevoNombre))
            nombre = nuevoNombre;
    }
}
```

**Ventajas de los Métodos:**

1. **Más Flexibilidad**: Puedes tener múltiples parámetros
2. **Nombres Descriptivos**: Puedes usar nombres más expresivos
3. **Validación Compleja**: Fácil agregar lógica de validación
4. **Sobrecarga**: Puedes tener múltiples versiones del método

**Desventajas:**

1. **Sintaxis Menos Natural**: `persona.GetNombre()` vs `persona.Nombre`
2. **Más Verboso**: Requiere más código
3. **No Compatible con Binding**: Algunas tecnologías requieren propiedades

**Cuándo Usar Métodos vs Propiedades:**

**Usa Métodos cuando:**
- La operación es costosa (puede tardar)
- La operación tiene efectos secundarios
- Necesitas múltiples parámetros
- El nombre del método es más descriptivo

**Usa Propiedades cuando:**
- Es una operación simple de lectura/escritura
- Quieres sintaxis natural
- Necesitas compatibilidad con data binding
- Es un valor que representa un estado

**Ejemplo Comparativo:**

```csharp
// Con Propiedades (recomendado)
public class Persona
{
    private string nombre;
    public string Nombre
    {
        get { return nombre; }
        set { nombre = value; }
    }
}

// Con Métodos (alternativa)
public class Persona
{
    private string nombre;
    public string GetNombre() { return nombre; }
    public void SetNombre(string value) { nombre = value; }
}
```

**Patrón de Nomenclatura:**

- **Getter**: `Get` + nombre del campo (ej: `GetNombre()`)
- **Setter**: `Set` + nombre del campo (ej: `SetNombre()`)
- **Boolean Getter**: `Is` o `Has` + nombre (ej: `IsActivo()`, `HasStock()`)',
    'using System;

public class CuentaBancaria
{
    private double saldo;
    private string numeroCuenta;
    private bool activa;
    private int intentosFallidos;
    
    // Constructor
    public CuentaBancaria(string numero, double saldoInicial)
    {
        numeroCuenta = numero;
        saldo = saldoInicial;
        activa = true;
        intentosFallidos = 0;
    }
    
    // GETTER: Obtener saldo
    public double GetSaldo()
    {
        return saldo;
    }
    
    // GETTER: Obtener número de cuenta
    public string GetNumeroCuenta()
    {
        return numeroCuenta;
    }
    
    // GETTER: Verificar si está activa
    public bool IsActiva()
    {
        return activa;
    }
    
    // GETTER: Verificar si tiene saldo suficiente
    public bool TieneSaldoSuficiente(double cantidad)
    {
        return saldo >= cantidad;
    }
    
    // SETTER: Depositar dinero
    public bool Depositar(double cantidad)
    {
        if (cantidad <= 0)
        {
            Console.WriteLine("Error: La cantidad debe ser positiva");
            return false;
        }
        
        if (!activa)
        {
            Console.WriteLine("Error: La cuenta está inactiva");
            return false;
        }
        
        saldo += cantidad;
        intentosFallidos = 0;  // Resetear intentos fallidos
        Console.WriteLine($"Depositado: ${cantidad:F2}. Nuevo saldo: ${saldo:F2}");
        return true;
    }
    
    // SETTER: Retirar dinero
    public bool Retirar(double cantidad)
    {
        if (cantidad <= 0)
        {
            Console.WriteLine("Error: La cantidad debe ser positiva");
            return false;
        }
        
        if (!activa)
        {
            Console.WriteLine("Error: La cuenta está inactiva");
            return false;
        }
        
        if (!TieneSaldoSuficiente(cantidad))
        {
            intentosFallidos++;
            Console.WriteLine($"Error: Saldo insuficiente. Intentos fallidos: {intentosFallidos}");
            
            if (intentosFallidos >= 3)
            {
                activa = false;
                Console.WriteLine("Cuenta bloqueada por múltiples intentos fallidos");
            }
            return false;
        }
        
        saldo -= cantidad;
        intentosFallidos = 0;
        Console.WriteLine($"Retirado: ${cantidad:F2}. Nuevo saldo: ${saldo:F2}");
        return true;
    }
    
    // SETTER: Activar cuenta
    public void Activar()
    {
        activa = true;
        intentosFallidos = 0;
        Console.WriteLine("Cuenta activada");
    }
    
    // SETTER: Desactivar cuenta
    public void Desactivar()
    {
        activa = false;
        Console.WriteLine("Cuenta desactivada");
    }
    
    // Método para mostrar información
    public void MostrarInformacion()
    {
        Console.WriteLine($"Cuenta: {GetNumeroCuenta()}");
        Console.WriteLine($"Saldo: ${GetSaldo():F2}");
        Console.WriteLine($"Estado: {(IsActiva() ? "Activa" : "Inactiva")}");
    }
}

class Program
{
    static void Main()
    {
        CuentaBancaria cuenta = new CuentaBancaria("12345", 1000.0);
        
        Console.WriteLine("=== INFORMACIÓN INICIAL ===");
        cuenta.MostrarInformacion();
        
        Console.WriteLine("\n=== OPERACIONES ===");
        cuenta.Depositar(500);
        cuenta.Retirar(200);
        
        Console.WriteLine("\n=== VERIFICACIONES ===");
        Console.WriteLine($"¿Tiene saldo suficiente para $500? {cuenta.TieneSaldoSuficiente(500)}");
        Console.WriteLine($"¿Tiene saldo suficiente para $2000? {cuenta.TieneSaldoSuficiente(2000)}");
        
        Console.WriteLine("\n=== INTENTOS FALLIDOS ===");
        cuenta.Retirar(5000);  // Intento fallido 1
        cuenta.Retirar(5000);  // Intento fallido 2
        cuenta.Retirar(5000);  // Intento fallido 3 - cuenta bloqueada
        
        Console.WriteLine("\n=== ESTADO DESPUÉS DE BLOQUEO ===");
        cuenta.MostrarInformacion();
        
        // Intentar operar con cuenta bloqueada
        cuenta.Depositar(100);
        
        // Reactivar cuenta
        cuenta.Activar();
        cuenta.Depositar(100);
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Encapsulación en la Práctica
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Encapsulación en la Práctica',
    'Aprende a aplicar la encapsulación en escenarios reales y casos de uso comunes.',
    'La encapsulación no es solo teoría; es una práctica esencial en el desarrollo de software. Veamos cómo aplicarla en situaciones reales.

**Principios de Encapsulación:**

1. **Oculta lo que no necesita ser visible**
2. **Expone solo una interfaz clara y bien definida**
3. **Valida y protege los datos**
4. **Facilita el mantenimiento futuro**

**Casos de Uso Comunes:**

**1. Validación de Datos:**

```csharp
public class Email
{
    private string direccion;
    
    public string Direccion
    {
        get { return direccion; }
        set
        {
            if (IsValidEmail(value))
                direccion = value;
            else
                throw new ArgumentException("Email inválido");
        }
    }
    
    private bool IsValidEmail(string email)
    {
        return email.Contains("@") && email.Contains(".");
    }
}
```

**2. Cálculos Automáticos:**

```csharp
public class Rectangulo
{
    private double ancho;
    private double alto;
    
    public double Ancho
    {
        get { return ancho; }
        set { ancho = value > 0 ? value : 0; }
    }
    
    public double Alto
    {
        get { return alto; }
        set { alto = value > 0 ? value : 0; }
    }
    
    // Propiedad calculada
    public double Area { get { return ancho * alto; } }
    public double Perimetro { get { return 2 * (ancho + alto); } }
}
```

**3. Estados y Transiciones:**

```csharp
public class Pedido
{
    private EstadoPedido estado;
    
    public EstadoPedido Estado
    {
        get { return estado; }
    }
    
    public void Confirmar()
    {
        if (estado == EstadoPedido.Pendiente)
            estado = EstadoPedido.Confirmado;
        else
            throw new InvalidOperationException("Solo se pueden confirmar pedidos pendientes");
    }
}
```

**4. Lazy Loading (Carga Perezosa):**

```csharp
public class Producto
{
    private string descripcionCompleta;
    private bool descripcionCargada = false;
    
    public string DescripcionCompleta
    {
        get
        {
            if (!descripcionCargada)
            {
                descripcionCompleta = CargarDescripcionDesdeBD();
                descripcionCargada = true;
            }
            return descripcionCompleta;
        }
    }
    
    private string CargarDescripcionDesdeBD()
    {
        // Simular carga desde base de datos
        return "Descripción completa del producto...";
    }
}
```

**5. Contadores y Estadísticas:**

```csharp
public class Contador
{
    private int valor;
    private int maximo;
    
    public int Valor { get { return valor; } }
    public int Maximo { get { return maximo; } }
    
    public void Incrementar()
    {
        if (valor < maximo)
            valor++;
    }
    
    public void Reset()
    {
        valor = 0;
    }
}
```

**Buenas Prácticas:**

1. **Siempre valida en los setters**
2. **Usa propiedades calculadas cuando sea apropiado**
3. **Mantén los campos privados**
4. **Documenta la interfaz pública**
5. **Piensa en el futuro**: ¿qué podría cambiar?

**Errores Comunes a Evitar:**

❌ **Exponer campos públicos directamente**
```csharp
public class Persona
{
    public string nombre;  // MAL
}
```

✅ **Usar propiedades con validación**
```csharp
public class Persona
{
    private string nombre;
    public string Nombre
    {
        get { return nombre; }
        set { nombre = value ?? ""; }
    }
}
```',
    'using System;
using System.Collections.Generic;

// Ejemplo 1: Validación de datos
public class Usuario
{
    private string email;
    private int edad;
    
    public string Email
    {
        get { return email; }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("El email no puede estar vacío");
            if (!value.Contains("@"))
                throw new ArgumentException("El email debe contener @");
            email = value;
        }
    }
    
    public int Edad
    {
        get { return edad; }
        set
        {
            if (value < 0 || value > 120)
                throw new ArgumentException("La edad debe estar entre 0 y 120");
            edad = value;
        }
    }
}

// Ejemplo 2: Cálculos automáticos
public class Circulo
{
    private double radio;
    
    public double Radio
    {
        get { return radio; }
        set { radio = value > 0 ? value : 0; }
    }
    
    // Propiedades calculadas
    public double Area
    {
        get { return Math.PI * radio * radio; }
    }
    
    public double Perimetro
    {
        get { return 2 * Math.PI * radio; }
    }
    
    public double Diametro
    {
        get { return 2 * radio; }
    }
}

// Ejemplo 3: Estados y transiciones
public enum EstadoTarea
{
    Pendiente,
    EnProceso,
    Completada,
    Cancelada
}

public class Tarea
{
    private EstadoTarea estado;
    
    public EstadoTarea Estado
    {
        get { return estado; }
    }
    
    public string Titulo { get; set; }
    
    public Tarea(string titulo)
    {
        Titulo = titulo;
        estado = EstadoTarea.Pendiente;
    }
    
    public void Iniciar()
    {
        if (estado == EstadoTarea.Pendiente)
            estado = EstadoTarea.EnProceso;
        else
            throw new InvalidOperationException("Solo se pueden iniciar tareas pendientes");
    }
    
    public void Completar()
    {
        if (estado == EstadoTarea.EnProceso)
            estado = EstadoTarea.Completada;
        else
            throw new InvalidOperationException("Solo se pueden completar tareas en proceso");
    }
    
    public void Cancelar()
    {
        if (estado != EstadoTarea.Completada)
            estado = EstadoTarea.Cancelada;
        else
            throw new InvalidOperationException("No se pueden cancelar tareas completadas");
    }
}

// Ejemplo 4: Contador con límites
public class ContadorConLimite
{
    private int valor;
    private readonly int limite;
    
    public int Valor { get { return valor; } }
    public int Limite { get { return limite; } }
    public bool AlcanzoLimite { get { return valor >= limite; } }
    
    public ContadorConLimite(int limite)
    {
        this.limite = limite;
        valor = 0;
    }
    
    public void Incrementar()
    {
        if (valor < limite)
            valor++;
        else
            Console.WriteLine("El contador ha alcanzado su límite");
    }
    
    public void Decrementar()
    {
        if (valor > 0)
            valor--;
    }
    
    public void Reset()
    {
        valor = 0;
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO 1: Validación de Datos ===");
        try
        {
            Usuario usuario = new Usuario();
            usuario.Email = "juan@example.com";
            usuario.Edad = 25;
            Console.WriteLine($"Usuario: {usuario.Email}, Edad: {usuario.Edad}");
            
            // Intentar email inválido
            usuario.Email = "email-invalido";
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
        
        Console.WriteLine("\n=== EJEMPLO 2: Cálculos Automáticos ===");
        Circulo circulo = new Circulo();
        circulo.Radio = 5;
        Console.WriteLine($"Radio: {circulo.Radio}");
        Console.WriteLine($"Área: {circulo.Area:F2}");
        Console.WriteLine($"Perímetro: {circulo.Perimetro:F2}");
        Console.WriteLine($"Diámetro: {circulo.Diametro}");
        
        Console.WriteLine("\n=== EJEMPLO 3: Estados y Transiciones ===");
        Tarea tarea = new Tarea("Implementar login");
        Console.WriteLine($"Estado inicial: {tarea.Estado}");
        
        tarea.Iniciar();
        Console.WriteLine($"Estado después de iniciar: {tarea.Estado}");
        
        tarea.Completar();
        Console.WriteLine($"Estado después de completar: {tarea.Estado}");
        
        Console.WriteLine("\n=== EJEMPLO 4: Contador con Límites ===");
        ContadorConLimite contador = new ContadorConLimite(5);
        
        for (int i = 0; i < 7; i++)
        {
            contador.Incrementar();
            Console.WriteLine($"Valor: {contador.Valor}, Límite: {contador.Limite}, ¿Alcanzó límite? {contador.AlcanzoLimite}");
        }
        
        contador.Reset();
        Console.WriteLine($"Después de reset: {contador.Valor}");
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Propiedades de Solo Lectura y Solo Escritura
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Propiedades de Solo Lectura y Solo Escritura',
    'Aprende a crear propiedades que solo se pueden leer o solo se pueden escribir, según tus necesidades.',
    'C# permite crear propiedades con diferentes niveles de acceso para los getters y setters, dándote control granular sobre cómo se accede a los datos.

**Propiedades de Solo Lectura (Read-Only):**

Una propiedad de solo lectura solo permite leer el valor, no modificarlo desde fuera de la clase.

**Forma 1: Setter Privado**

```csharp
public class Persona
{
    private string nombre;
    
    public string Nombre
    {
        get { return nombre; }
        private set { nombre = value; }  // Solo se puede modificar dentro de la clase
    }
    
    public Persona(string nombre)
    {
        Nombre = nombre;  // OK: dentro del constructor
    }
}
```

**Forma 2: Propiedad Auto-Implementada de Solo Lectura (C# 6.0+)**

```csharp
public class Persona
{
    public string Nombre { get; }  // Solo lectura, se inicializa en constructor
    
    public Persona(string nombre)
    {
        Nombre = nombre;  // Inicialización en constructor
    }
}
```

**Propiedades de Solo Escritura (Write-Only):**

Una propiedad de solo escritura solo permite escribir el valor, no leerlo.

```csharp
public class Configuracion
{
    private string clave;
    
    public string Clave
    {
        private get { return clave; }  // Solo lectura interna
        set { clave = value; }  // Escritura pública
    }
    
    public bool ValidarClave(string claveIngresada)
    {
        return claveIngresada == Clave;  // OK: acceso interno
    }
}
```

**Casos de Uso:**

**Solo Lectura:**
- IDs de entidades (no deben cambiar después de la creación)
- Valores calculados
- Constantes de instancia
- Información histórica

**Solo Escritura:**
- Contraseñas (solo se establecen, no se leen)
- Configuraciones sensibles
- Logs de auditoría

**Ejemplo Práctico:**

```csharp
public class Producto
{
    // ID de solo lectura (se establece una vez)
    public int Id { get; private set; }
    
    // Nombre modificable
    public string Nombre { get; set; }
    
    // Fecha de creación de solo lectura
    public DateTime FechaCreacion { get; }
    
    // Contraseña de solo escritura
    private string contraseña;
    public string Contraseña
    {
        private get { return contraseña; }
        set { contraseña = HashPassword(value); }
    }
    
    public Producto(int id, string nombre)
    {
        Id = id;
        Nombre = nombre;
        FechaCreacion = DateTime.Now;
    }
    
    public bool VerificarContraseña(string input)
    {
        return HashPassword(input) == Contraseña;
    }
}
```',
    'using System;

// Ejemplo 1: Propiedades de solo lectura
public class Empleado
{
    // ID de solo lectura (se establece en constructor)
    public int Id { get; private set; }
    
    // Nombre completo de solo lectura (calculado)
    private string nombre;
    private string apellido;
    
    public string Nombre
    {
        get { return nombre; }
        set { nombre = value; }
    }
    
    public string Apellido
    {
        get { return apellido; }
        set { apellido = value; }
    }
    
    // Propiedad calculada de solo lectura
    public string NombreCompleto
    {
        get { return $"{nombre} {apellido}"; }
    }
    
    // Fecha de contratación de solo lectura
    public DateTime FechaContratacion { get; }
    
    // Salario con setter privado
    private double salario;
    public double Salario
    {
        get { return salario; }
        private set
        {
            if (value >= 0)
                salario = value;
        }
    }
    
    public Empleado(int id, string nombre, string apellido, double salarioInicial)
    {
        Id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        Salario = salarioInicial;
        FechaContratacion = DateTime.Now;
    }
    
    // Método para aumentar salario (controlado)
    public void AumentarSalario(double porcentaje)
    {
        if (porcentaje > 0)
        {
            Salario *= (1 + porcentaje / 100);
            Console.WriteLine($"Salario aumentado. Nuevo salario: ${Salario:F2}");
        }
    }
}

// Ejemplo 2: Propiedades de solo escritura
public class SistemaSeguro
{
    private string claveSecreta;
    private int intentos = 0;
    
    // Clave de solo escritura (no se puede leer directamente)
    public string Clave
    {
        private get { return claveSecreta; }
        set
        {
            if (!string.IsNullOrWhiteSpace(value))
            {
                claveSecreta = Encriptar(value);
                intentos = 0;
                Console.WriteLine("Clave establecida correctamente");
            }
        }
    }
    
    // Método para verificar clave (sin exponerla)
    public bool VerificarClave(string claveIngresada)
    {
        string claveEncriptada = Encriptar(claveIngresada);
        bool esCorrecta = claveEncriptada == Clave;
        
        if (!esCorrecta)
        {
            intentos++;
            Console.WriteLine($"Clave incorrecta. Intentos: {intentos}");
        }
        else
        {
            intentos = 0;
            Console.WriteLine("Clave correcta");
        }
        
        return esCorrecta;
    }
    
    private string Encriptar(string texto)
    {
        // Simulación simple de encriptación
        return texto.GetHashCode().ToString();
    }
}

// Ejemplo 3: Combinación de solo lectura y escritura
public class Configuracion
{
    // Configuración de solo lectura (se establece al crear)
    public string NombreAplicacion { get; }
    
    // Configuración modificable
    public string Idioma { get; set; }
    
    // Token de solo escritura
    private string token;
    public string Token
    {
        private get { return token; }
        set
        {
            if (!string.IsNullOrWhiteSpace(value))
                token = value;
        }
    }
    
    // Método para verificar token
    public bool TieneToken()
    {
        return !string.IsNullOrEmpty(Token);
    }
    
    public Configuracion(string nombreApp)
    {
        NombreAplicacion = nombreApp;
        Idioma = "es";
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO 1: Propiedades de Solo Lectura ===");
        Empleado empleado = new Empleado(1, "Juan", "Pérez", 50000);
        
        Console.WriteLine($"ID: {empleado.Id}");
        Console.WriteLine($"Nombre Completo: {empleado.NombreCompleto}");
        Console.WriteLine($"Fecha Contratación: {empleado.FechaContratacion}");
        Console.WriteLine($"Salario: ${empleado.Salario:F2}");
        
        // No puedo modificar el ID
        // empleado.Id = 2;  // ERROR: set es privado
        
        // No puedo modificar la fecha
        // empleado.FechaContratacion = DateTime.Now;  // ERROR: solo lectura
        
        // Puedo modificar el nombre
        empleado.Nombre = "Pedro";
        Console.WriteLine($"Nombre Completo actualizado: {empleado.NombreCompleto}");
        
        // Puedo aumentar el salario mediante método
        empleado.AumentarSalario(10);
        
        Console.WriteLine("\n=== EJEMPLO 2: Propiedades de Solo Escritura ===");
        SistemaSeguro sistema = new SistemaSeguro();
        sistema.Clave = "miClaveSecreta123";
        
        // No puedo leer la clave directamente
        // string clave = sistema.Clave;  // ERROR: get es privado
        
        // Puedo verificar la clave
        sistema.VerificarClave("claveIncorrecta");
        sistema.VerificarClave("miClaveSecreta123");
        
        Console.WriteLine("\n=== EJEMPLO 3: Combinación ===");
        Configuracion config = new Configuracion("Mi App");
        Console.WriteLine($"Aplicación: {config.NombreAplicacion}");
        Console.WriteLine($"Idioma: {config.Idioma}");
        
        config.Token = "token123";
        Console.WriteLine($"¿Tiene token? {config.TieneToken()}");
        
        // No puedo leer el token directamente
        // string token = config.Token;  // ERROR: get es privado
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Mejores Prácticas de Encapsulación
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Mejores Prácticas de Encapsulación',
    'Aprende las mejores prácticas y patrones comunes para implementar encapsulación efectiva en tus clases.',
    'Implementar encapsulación correctamente requiere seguir ciertas prácticas y patrones establecidos. Aquí están las mejores prácticas:

**1. Principio de Menor Privilegio**

Siempre usa el modificador de acceso más restrictivo posible:

```csharp
// MAL
public class Persona
{
    public string nombre;
    public int edad;
}

// BIEN
public class Persona
{
    private string nombre;
    private int edad;
    
    public string Nombre { get; set; }
    public int Edad { get; set; }
}
```

**2. Campos Privados por Defecto**

Todos los campos deben ser privados a menos que haya una razón específica para que sean públicos:

```csharp
public class Cuenta
{
    private double saldo;  // Siempre privado
    private string numero;  // Siempre privado
}
```

**3. Propiedades Públicas para Acceso**

Usa propiedades públicas en lugar de campos públicos:

```csharp
// MAL
public string nombre;

// BIEN
private string nombre;
public string Nombre { get; set; }
```

**4. Validación en Setters**

Siempre valida los datos en los setters:

```csharp
public int Edad
{
    get { return edad; }
    set
    {
        if (value < 0 || value > 120)
            throw new ArgumentException("Edad inválida");
        edad = value;
    }
}
```

**5. Inmutabilidad cuando sea Apropiado**

Haz las propiedades de solo lectura cuando el valor no debe cambiar:

```csharp
public class Producto
{
    public int Id { get; }  // No cambia después de la creación
    public string Nombre { get; set; }
}
```

**6. Nombres Descriptivos**

Usa nombres claros y descriptivos:

```csharp
// MAL
public int a;
public string n;

// BIEN
public int edad;
public string nombre;
```

**7. Documentación**

Documenta la interfaz pública:

```csharp
/// <summary>
/// Representa una cuenta bancaria con saldo protegido
/// </summary>
public class CuentaBancaria
{
    /// <summary>
    /// Obtiene el saldo actual de la cuenta
    /// </summary>
    public double Saldo { get; private set; }
}
```

**8. Evitar Exponer Implementación Interna**

No expongas detalles de implementación:

```csharp
// MAL
public class Lista
{
    public List<string> items;  // Expone la implementación
}

// BIEN
public class Lista
{
    private List<string> items;
    
    public void Agregar(string item) { items.Add(item); }
    public int Contar() { return items.Count; }
}
```

**9. Usar Métodos para Operaciones**

Usa métodos para operaciones que no son simples get/set:

```csharp
// MAL
public bool activo;
if (cuenta.activo) { }

// BIEN
public bool EstaActiva() { return activo; }
if (cuenta.EstaActiva()) { }
```

**10. Consistencia**

Mantén un estilo consistente en toda la aplicación:

```csharp
// Todas las propiedades usan el mismo patrón
public class Persona
{
    private string nombre;
    private int edad;
    
    public string Nombre { get; set; }
    public int Edad { get; set; }
}
```

**Patrones Comunes:**

1. **Backing Field Pattern**: Campo privado + propiedad pública
2. **Lazy Initialization**: Cargar valores solo cuando se necesitan
3. **Validation Pattern**: Validar en setters
4. **Read-Only Pattern**: Propiedades de solo lectura para valores inmutables

**Checklist de Encapsulación:**

✅ Todos los campos son privados
✅ Propiedades públicas para acceso
✅ Validación en setters
✅ Documentación clara
✅ Nombres descriptivos
✅ Consistencia en el estilo
✅ Principio de menor privilegio aplicado',
    'using System;
using System.Collections.Generic;

// ============================================
// EJEMPLO: Implementación siguiendo mejores prácticas
// ============================================

/// <summary>
/// Representa una cuenta bancaria con encapsulación adecuada
/// </summary>
public class CuentaBancaria
{
    // Campos privados (backing fields)
    private double saldo;
    private string numeroCuenta;
    private string titular;
    private bool activa;
    private DateTime fechaCreacion;
    
    // Propiedades públicas con validación
    public string NumeroCuenta
    {
        get { return numeroCuenta; }
        private set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("El número de cuenta no puede estar vacío");
            numeroCuenta = value;
        }
    }
    
    public string Titular
    {
        get { return titular; }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("El titular no puede estar vacío");
            titular = value;
        }
    }
    
    // Propiedad de solo lectura
    public double Saldo
    {
        get { return saldo; }
    }
    
    // Propiedad de solo lectura (inmutable)
    public DateTime FechaCreacion
    {
        get { return fechaCreacion; }
    }
    
    // Propiedad calculada
    public bool EstaActiva
    {
        get { return activa; }
    }
    
    // Constructor
    public CuentaBancaria(string numero, string titular, double saldoInicial)
    {
        NumeroCuenta = numero;
        Titular = titular;
        saldo = saldoInicial >= 0 ? saldoInicial : 0;
        activa = true;
        fechaCreacion = DateTime.Now;
    }
    
    // Métodos públicos para operaciones
    public bool Depositar(double cantidad)
    {
        if (!activa)
        {
            Console.WriteLine("Error: La cuenta está inactiva");
            return false;
        }
        
        if (cantidad <= 0)
        {
            Console.WriteLine("Error: La cantidad debe ser positiva");
            return false;
        }
        
        saldo += cantidad;
        Console.WriteLine($"Depositado: ${cantidad:F2}. Nuevo saldo: ${saldo:F2}");
        return true;
    }
    
    public bool Retirar(double cantidad)
    {
        if (!activa)
        {
            Console.WriteLine("Error: La cuenta está inactiva");
            return false;
        }
        
        if (cantidad <= 0)
        {
            Console.WriteLine("Error: La cantidad debe ser positiva");
            return false;
        }
        
        if (cantidad > saldo)
        {
            Console.WriteLine("Error: Saldo insuficiente");
            return false;
        }
        
        saldo -= cantidad;
        Console.WriteLine($"Retirado: ${cantidad:F2}. Nuevo saldo: ${saldo:F2}");
        return true;
    }
    
    public void Desactivar()
    {
        activa = false;
        Console.WriteLine("Cuenta desactivada");
    }
    
    public void Activar()
    {
        activa = true;
        Console.WriteLine("Cuenta activada");
    }
    
    // Método para mostrar información
    public void MostrarInformacion()
    {
        Console.WriteLine($"Cuenta: {NumeroCuenta}");
        Console.WriteLine($"Titular: {Titular}");
        Console.WriteLine($"Saldo: ${Saldo:F2}");
        Console.WriteLine($"Estado: {(EstaActiva ? "Activa" : "Inactiva")}");
        Console.WriteLine($"Fecha Creación: {FechaCreacion:yyyy-MM-dd}");
    }
}

// ============================================
// EJEMPLO: Lista encapsulada
// ============================================

/// <summary>
/// Lista personalizada que oculta la implementación interna
/// </summary>
public class ListaPersonalizada
{
    // Implementación interna oculta
    private List<string> items;
    
    // Propiedad de solo lectura para contar
    public int Cantidad
    {
        get { return items.Count; }
    }
    
    // Propiedad calculada
    public bool EstaVacia
    {
        get { return items.Count == 0; }
    }
    
    public ListaPersonalizada()
    {
        items = new List<string>();
    }
    
    // Métodos públicos para operaciones
    public void Agregar(string item)
    {
        if (string.IsNullOrWhiteSpace(item))
            throw new ArgumentException("El item no puede estar vacío");
        items.Add(item);
    }
    
    public bool Contiene(string item)
    {
        return items.Contains(item);
    }
    
    public void Limpiar()
    {
        items.Clear();
    }
    
    public void Mostrar()
    {
        if (EstaVacia)
        {
            Console.WriteLine("La lista está vacía");
            return;
        }
        
        Console.WriteLine("Elementos en la lista:");
        for (int i = 0; i < items.Count; i++)
        {
            Console.WriteLine($"  {i + 1}. {items[i]}");
        }
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Cuenta Bancaria ===");
        try
        {
            CuentaBancaria cuenta = new CuentaBancaria("12345", "Juan Pérez", 1000);
            cuenta.MostrarInformacion();
            
            Console.WriteLine("\n=== Operaciones ===");
            cuenta.Depositar(500);
            cuenta.Retirar(200);
            
            // No puedo modificar el saldo directamente
            // cuenta.Saldo = 5000;  // ERROR: solo lectura
            
            // No puedo modificar la fecha de creación
            // cuenta.FechaCreacion = DateTime.Now;  // ERROR: solo lectura
            
            Console.WriteLine("\n=== EJEMPLO: Lista Encapsulada ===");
            ListaPersonalizada lista = new ListaPersonalizada();
            
            Console.WriteLine($"¿Está vacía? {lista.EstaVacia}");
            Console.WriteLine($"Cantidad: {lista.Cantidad}");
            
            lista.Agregar("Item 1");
            lista.Agregar("Item 2");
            lista.Agregar("Item 3");
            
            Console.WriteLine($"\nCantidad después de agregar: {lista.Cantidad}");
            Console.WriteLine($"¿Está vacía? {lista.EstaVacia}");
            Console.WriteLine($"¿Contiene Item 2? {lista.Contiene("Item 2")}");
            
            lista.Mostrar();
            
            // No puedo acceder a la implementación interna
            // lista.items.Add("Item 4");  // ERROR: items es privado
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error: {e.Message}");
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
PRINT 'Lecciones del curso "Encapsulación y Modificadores de Acceso":';
PRINT '1. Introducción a la Encapsulación';
PRINT '2. Modificadores de Acceso Básicos';
PRINT '3. Propiedades y Encapsulación';
PRINT '4. Modificadores de Acceso Avanzados';
PRINT '5. Métodos de Acceso (Getters y Setters)';
PRINT '6. Encapsulación en la Práctica';
PRINT '7. Propiedades de Solo Lectura y Solo Escritura';
PRINT '8. Mejores Prácticas de Encapsulación';
GO

