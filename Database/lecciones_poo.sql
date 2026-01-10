-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Programación Orientada a Objetos (POO)"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Programación Orientada a Objetos (POO)"
-- NOTA: Reemplaza @CursoId con el ID real del curso
-- Puedes obtenerlo ejecutando: SELECT CursoId FROM Cursos WHERE Nombre = 'Programación Orientada a Objetos (POO)'

DECLARE @CursoId INT;
DECLARE @RutaId INT = 2; -- RutaId de "Programación Orientada a Objetos"
DECLARE @NombreCurso NVARCHAR(100) = 'Programación Orientada a Objetos';

-- Buscar el curso "Programación Orientada a Objetos" en la ruta con RutaId = 2
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
        'Domina las clases, objetos, herencia, polimorfismo, encapsulación e interfaces en C#',
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
-- LECCIÓN 1: Introducción a POO
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Programación Orientada a Objetos',
    'Comprende los conceptos fundamentales de la Programación Orientada a Objetos y por qué es importante en C#.',
    'La **Programación Orientada a Objetos (POO)** es un paradigma de programación que organiza el código en torno a objetos que representan entidades del mundo real o conceptos abstractos.

**¿Qué es un objeto?**

Un objeto es una instancia de una clase que combina:
- **Datos** (atributos/propiedades): Características del objeto
- **Comportamiento** (métodos): Acciones que el objeto puede realizar

**Pilares fundamentales de POO:**

1. **Encapsulación**: Ocultar los detalles internos y exponer solo lo necesario
2. **Herencia**: Crear nuevas clases basadas en clases existentes
3. **Polimorfismo**: Múltiples formas de hacer lo mismo
4. **Abstracción**: Simplificar la complejidad enfocándose en lo esencial

**Ventajas de POO:**

- **Reutilización de código**: Crear clases una vez y usarlas múltiples veces
- **Mantenibilidad**: Código más organizado y fácil de mantener
- **Modularidad**: Dividir problemas complejos en partes manejables
- **Escalabilidad**: Fácil agregar nuevas funcionalidades
- **Modelado del mundo real**: Representar entidades de forma natural

**Conceptos clave:**

- **Clase**: Plantilla o molde para crear objetos
- **Objeto/Instancia**: Ejemplar específico de una clase
- **Atributo/Campo**: Variable que almacena datos del objeto
- **Método**: Función que define el comportamiento del objeto
- **Constructor**: Método especial que inicializa el objeto
- **Propiedad**: Forma controlada de acceder a atributos

**Ejemplo conceptual:**

Piensa en una clase `Automovil`:
- **Atributos**: marca, modelo, color, velocidad
- **Métodos**: acelerar(), frenar(), encender()
- **Objetos**: miAuto, tuAuto (instancias diferentes de Automovil)',
    'using System;

// Definición de una clase
class Persona
{
    // Atributos (campos)
    public string Nombre;
    public int Edad;
    
    // Método
    public void Presentarse()
    {
        Console.WriteLine($"Hola, soy {Nombre} y tengo {Edad} años");
    }
    
    // Método que devuelve un valor
    public bool EsMayorDeEdad()
    {
        return Edad >= 18;
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== INTRODUCCIÓN A POO ===\n");
        
        // Crear objetos (instancias de la clase Persona)
        Persona persona1 = new Persona();
        persona1.Nombre = "Juan";
        persona1.Edad = 25;
        
        Persona persona2 = new Persona();
        persona2.Nombre = "María";
        persona2.Edad = 17;
        
        // Usar los métodos de los objetos
        Console.WriteLine("Persona 1:");
        persona1.Presentarse();
        Console.WriteLine($"¿Es mayor de edad? {persona1.EsMayorDeEdad()}");
        
        Console.WriteLine("\nPersona 2:");
        persona2.Presentarse();
        Console.WriteLine($"¿Es mayor de edad? {persona2.EsMayorDeEdad()}");
        
        // Cada objeto tiene su propio estado
        Console.WriteLine($"\n{persona1.Nombre} tiene {persona1.Edad} años");
        Console.WriteLine($"{persona2.Nombre} tiene {persona2.Edad} años");
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Clases y Objetos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Clases y Objetos',
    'Aprende a definir clases y crear objetos, los bloques fundamentales de la POO en C#.',
    'Las **clases** son plantillas que definen la estructura y el comportamiento de los objetos. Los **objetos** son instancias concretas creadas a partir de una clase.

**Definición de una clase:**

```csharp
class NombreClase
{
    // Campos (atributos)
    tipo campo1;
    tipo campo2;
    
    // Métodos
    tipoRetorno Metodo1() { }
    void Metodo2() { }
}
```

**Crear objetos:**

```csharp
// Usando new
NombreClase objeto = new NombreClase();
```

**Componentes de una clase:**

1. **Campos**: Variables que almacenan datos
2. **Métodos**: Funciones que definen comportamiento
3. **Propiedades**: Acceso controlado a campos
4. **Constructores**: Inicializan el objeto
5. **Eventos**: Notificaciones de cambios

**Naming conventions:**

- **Clases**: PascalCase (ej: `MiClase`, `Persona`)
- **Campos**: camelCase o _camelCase (ej: `nombre`, `_edad`)
- **Métodos**: PascalCase (ej: `CalcularTotal()`)
- **Propiedades**: PascalCase (ej: `Nombre`, `Edad`)

**Instanciación:**

- `new` crea una nueva instancia en memoria
- Cada objeto tiene su propio espacio en memoria
- Los objetos son independientes entre sí',
    'using System;

// Clase simple
class Rectangulo
{
    // Campos
    public double ancho;
    public double alto;
    
    // Método para calcular área
    public double CalcularArea()
    {
        return ancho * alto;
    }
    
    // Método para calcular perímetro
    public double CalcularPerimetro()
    {
        return 2 * (ancho + alto);
    }
    
    // Método que devuelve información
    public string ObtenerInformacion()
    {
        return $"Rectángulo: {ancho} x {alto}";
    }
}

// Clase con más funcionalidad
class CuentaBancaria
{
    public string titular;
    public double saldo;
    
    public void Depositar(double cantidad)
    {
        saldo += cantidad;
        Console.WriteLine($"Depositado: ${cantidad}. Nuevo saldo: ${saldo}");
    }
    
    public void Retirar(double cantidad)
    {
        if (cantidad <= saldo)
        {
            saldo -= cantidad;
            Console.WriteLine($"Retirado: ${cantidad}. Nuevo saldo: ${saldo}");
        }
        else
        {
            Console.WriteLine("Fondos insuficientes");
        }
    }
    
    public void MostrarSaldo()
    {
        Console.WriteLine($"Saldo de {titular}: ${saldo}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== CLASES Y OBJETOS ===\n");
        
        // Crear objeto Rectangulo
        Rectangulo rect1 = new Rectangulo();
        rect1.ancho = 5;
        rect1.alto = 10;
        
        Console.WriteLine("Rectángulo 1:");
        Console.WriteLine(rect1.ObtenerInformacion());
        Console.WriteLine($"Área: {rect1.CalcularArea()}");
        Console.WriteLine($"Perímetro: {rect1.CalcularPerimetro()}");
        
        // Crear otro objeto Rectangulo
        Rectangulo rect2 = new Rectangulo();
        rect2.ancho = 3;
        rect2.alto = 7;
        
        Console.WriteLine("\nRectángulo 2:");
        Console.WriteLine(rect2.ObtenerInformacion());
        Console.WriteLine($"Área: {rect2.CalcularArea()}");
        
        // Crear objeto CuentaBancaria
        CuentaBancaria cuenta = new CuentaBancaria();
        cuenta.titular = "Juan Pérez";
        cuenta.saldo = 1000;
        
        Console.WriteLine("\n=== CUENTA BANCARIA ===");
        cuenta.MostrarSaldo();
        cuenta.Depositar(500);
        cuenta.Retirar(200);
        cuenta.Retirar(2000); // Intentar retirar más de lo disponible
        cuenta.MostrarSaldo();
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Constructores y Destructores
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Constructores y Destructores',
    'Aprende a usar constructores para inicializar objetos y destructores para limpiar recursos.',
    'Los **constructores** son métodos especiales que se ejecutan automáticamente cuando se crea un objeto. Permiten inicializar el objeto con valores específicos.

**Características de los constructores:**

- Tienen el mismo nombre que la clase
- No tienen tipo de retorno (ni siquiera void)
- Se ejecutan automáticamente al crear el objeto
- Pueden tener parámetros
- Puede haber múltiples constructores (sobrecarga)

**Tipos de constructores:**

1. **Constructor por defecto**: Sin parámetros (se crea automáticamente si no defines ninguno)
2. **Constructor con parámetros**: Inicializa con valores específicos
3. **Constructor de copia**: Crea un objeto copiando otro
4. **Constructor estático**: Se ejecuta una vez antes de cualquier instancia

**Sintaxis:**

```csharp
class MiClase
{
    // Constructor
    public MiClase()
    {
        // Código de inicialización
    }
    
    // Constructor con parámetros
    public MiClase(tipo parametro)
    {
        // Inicialización con parámetros
    }
}
```

**Destructores:**

- Se ejecutan cuando el objeto se destruye
- Se usan para liberar recursos
- Rara vez necesarios en C# (mejor usar `IDisposable`)
- Sintaxis: `~NombreClase()`

**this:**

- Referencia al objeto actual
- Útil cuando el parámetro tiene el mismo nombre que el campo',
    'using System;

class Persona
{
    public string Nombre;
    public int Edad;
    public string Ciudad;
    
    // Constructor por defecto
    public Persona()
    {
        Nombre = "Sin nombre";
        Edad = 0;
        Ciudad = "Sin ciudad";
        Console.WriteLine("Constructor por defecto ejecutado");
    }
    
    // Constructor con parámetros
    public Persona(string nombre, int edad)
    {
        Nombre = nombre;
        Edad = edad;
        Ciudad = "Sin ciudad";
        Console.WriteLine($"Constructor con nombre y edad ejecutado: {nombre}");
    }
    
    // Constructor con todos los parámetros
    public Persona(string nombre, int edad, string ciudad)
    {
        Nombre = nombre;
        Edad = edad;
        Ciudad = ciudad;
        Console.WriteLine($"Constructor completo ejecutado: {nombre}");
    }
    
    // Constructor usando this
    public Persona(string nombre) : this(nombre, 0, "Sin ciudad")
    {
        // Llama al constructor de 3 parámetros
        Console.WriteLine("Constructor con nombre ejecutado");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Nombre: {Nombre}, Edad: {Edad}, Ciudad: {Ciudad}");
    }
    
    // Destructor (raramente usado)
    ~Persona()
    {
        Console.WriteLine($"Destructor ejecutado para {Nombre}");
    }
}

class Producto
{
    public string Nombre;
    public double Precio;
    public int Stock;
    
    // Constructor con validación
    public Producto(string nombre, double precio, int stock)
    {
        if (precio < 0)
            throw new ArgumentException("El precio no puede ser negativo");
        if (stock < 0)
            throw new ArgumentException("El stock no puede ser negativo");
        
        Nombre = nombre;
        Precio = precio;
        Stock = stock;
    }
    
    public void MostrarInfo()
    {
        Console.WriteLine($"{Nombre} - ${Precio:F2} - Stock: {Stock}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== CONSTRUCTORES ===\n");
        
        // Constructor por defecto
        Persona persona1 = new Persona();
        persona1.MostrarInformacion();
        
        // Constructor con parámetros
        Persona persona2 = new Persona("Juan", 25);
        persona2.MostrarInformacion();
        
        // Constructor completo
        Persona persona3 = new Persona("María", 30, "Madrid");
        persona3.MostrarInformacion();
        
        // Constructor que llama a otro
        Persona persona4 = new Persona("Pedro");
        persona4.MostrarInformacion();
        
        Console.WriteLine("\n=== CONSTRUCTOR CON VALIDACIÓN ===");
        Producto producto = new Producto("Laptop", 999.99, 10);
        producto.MostrarInfo();
        
        // Forzar recolección de basura para ver destructores
        Console.WriteLine("\n=== DESTRUCTORES ===");
        GC.Collect();
        GC.WaitForPendingFinalizers();
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Encapsulación y Modificadores de Acceso
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Encapsulación y Modificadores de Acceso',
    'Aprende a controlar el acceso a los miembros de una clase usando modificadores de acceso para proteger los datos.',
    'La **encapsulación** es uno de los pilares fundamentales de POO. Consiste en ocultar los detalles internos de una clase y exponer solo lo necesario mediante una interfaz controlada.

**Modificadores de acceso:**

1. **public**: Accesible desde cualquier lugar
2. **private**: Solo accesible dentro de la misma clase
3. **protected**: Accesible en la clase y clases derivadas
4. **internal**: Accesible dentro del mismo ensamblado
5. **protected internal**: protected O internal
6. **private protected**: protected Y internal (C# 7.2+)

**¿Por qué usar encapsulación?**

- **Protección de datos**: Evita modificación accidental
- **Control de acceso**: Define qué puede y no puede hacer el código externo
- **Mantenibilidad**: Facilita cambios internos sin afectar código externo
- **Validación**: Permite validar datos antes de asignarlos

**Mejores prácticas:**

- Campos privados por defecto
- Usar propiedades para acceso controlado
- Exponer métodos públicos para operaciones
- Mantener la implementación interna privada

**Propiedades:**

Las propiedades proporcionan una forma controlada de acceder a campos privados:

```csharp
private int _edad;

public int Edad
{
    get { return _edad; }
    set { _edad = value; }
}
```',
    'using System;

class CuentaBancaria
{
    // Campos privados (encapsulados)
    private string _titular;
    private double _saldo;
    private string _numeroCuenta;
    
    // Constructor
    public CuentaBancaria(string titular, string numeroCuenta, double saldoInicial)
    {
        _titular = titular;
        _numeroCuenta = numeroCuenta;
        _saldo = saldoInicial >= 0 ? saldoInicial : 0;
    }
    
    // Propiedad pública con validación
    public string Titular
    {
        get { return _titular; }
        set 
        { 
            if (!string.IsNullOrWhiteSpace(value))
                _titular = value;
        }
    }
    
    // Propiedad de solo lectura
    public string NumeroCuenta
    {
        get { return _numeroCuenta; }
    }
    
    // Propiedad con lógica de negocio
    public double Saldo
    {
        get { return _saldo; }
        private set { _saldo = value; } // Solo se puede modificar desde dentro
    }
    
    // Métodos públicos para operaciones controladas
    public void Depositar(double cantidad)
    {
        if (cantidad > 0)
        {
            Saldo += cantidad;
            Console.WriteLine($"Depositado: ${cantidad:F2}. Nuevo saldo: ${Saldo:F2}");
        }
        else
        {
            Console.WriteLine("La cantidad debe ser positiva");
        }
    }
    
    public bool Retirar(double cantidad)
    {
        if (cantidad > 0 && cantidad <= Saldo)
        {
            Saldo -= cantidad;
            Console.WriteLine($"Retirado: ${cantidad:F2}. Nuevo saldo: ${Saldo:F2}");
            return true;
        }
        else
        {
            Console.WriteLine("Operación no válida: fondos insuficientes o cantidad inválida");
            return false;
        }
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Titular: {Titular}");
        Console.WriteLine($"Cuenta: {NumeroCuenta}");
        Console.WriteLine($"Saldo: ${Saldo:F2}");
    }
}

class Persona
{
    // Campo privado
    private int _edad;
    
    // Propiedad con validación
    public int Edad
    {
        get { return _edad; }
        set 
        {
            if (value >= 0 && value <= 150)
                _edad = value;
            else
                Console.WriteLine("Edad no válida");
        }
    }
    
    // Propiedad auto-implementada (C# 3.0+)
    public string Nombre { get; set; }
    
    // Propiedad de solo lectura
    public string NombreCompleto 
    { 
        get { return $"{Nombre} ({Edad} años)"; }
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== ENCAPSULACIÓN ===\n");
        
        // Crear cuenta bancaria
        CuentaBancaria cuenta = new CuentaBancaria("Juan Pérez", "123456789", 1000);
        
        Console.WriteLine("Información inicial:");
        cuenta.MostrarInformacion();
        
        Console.WriteLine("\nOperaciones:");
        cuenta.Depositar(500);
        cuenta.Retirar(200);
        cuenta.Retirar(2000); // Intento inválido
        
        // No se puede modificar saldo directamente
        // cuenta.Saldo = 5000; // ERROR: No es accesible
        
        // Se puede modificar titular a través de la propiedad
        cuenta.Titular = "Juan Pérez Actualizado";
        Console.WriteLine($"\nNuevo titular: {cuenta.Titular}");
        
        Console.WriteLine("\n=== PROPIEDADES CON VALIDACIÓN ===");
        Persona persona = new Persona();
        persona.Nombre = "Ana";
        persona.Edad = 25;
        Console.WriteLine(persona.NombreCompleto);
        
        persona.Edad = 200; // Intento de edad inválida
        Console.WriteLine($"Edad actual: {persona.Edad}"); // No cambió
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Herencia
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Herencia',
    'Aprende a crear clases derivadas que heredan características de clases base, permitiendo reutilización de código.',
    'La **herencia** permite crear nuevas clases basadas en clases existentes. La clase nueva (derivada) hereda todos los miembros de la clase base (padre).

**Conceptos clave:**

- **Clase base (padre)**: La clase de la que se hereda
- **Clase derivada (hija)**: La clase que hereda
- **Reutilización**: La clase derivada obtiene automáticamente los miembros de la base
- **Extensión**: La clase derivada puede agregar nuevos miembros
- **Sobrescritura**: La clase derivada puede modificar el comportamiento heredado

**Sintaxis:**

```csharp
class ClaseBase
{
    // Miembros de la clase base
}

class ClaseDerivada : ClaseBase
{
    // Miembros adicionales
    // Puede acceder a miembros públicos/protected de ClaseBase
}
```

**Ventajas:**

- **Reutilización de código**: No duplicar código común
- **Organización**: Jerarquía lógica de clases
- **Mantenibilidad**: Cambios en la base afectan a todas las derivadas
- **Polimorfismo**: Base para el polimorfismo

**Modificadores en herencia:**

- `protected`: Accesible en la clase base y derivadas
- `virtual`: Permite sobrescribir en clases derivadas
- `override`: Sobrescribe un método virtual
- `base`: Accede a miembros de la clase base

**Limitaciones en C#:**

- **Herencia simple**: Una clase solo puede heredar de una clase base
- **Sealed**: Impide que una clase sea heredada',
    'using System;

// Clase base
class Vehiculo
{
    public string Marca { get; set; }
    public string Modelo { get; set; }
    public int Anio { get; set; }
    
    public Vehiculo(string marca, string modelo, int anio)
    {
        Marca = marca;
        Modelo = modelo;
        Anio = anio;
    }
    
    // Método que puede ser sobrescrito
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Vehículo: {Marca} {Modelo} ({Anio})");
    }
    
    // Método común
    public void Arrancar()
    {
        Console.WriteLine("El vehículo ha arrancado");
    }
}

// Clase derivada
class Automovil : Vehiculo
{
    public int NumeroPuertas { get; set; }
    
    // Constructor que llama al constructor base
    public Automovil(string marca, string modelo, int anio, int numeroPuertas) 
        : base(marca, modelo, anio)
    {
        NumeroPuertas = numeroPuertas;
    }
    
    // Sobrescribir método
    public override void MostrarInformacion()
    {
        base.MostrarInformacion(); // Llamar al método de la clase base
        Console.WriteLine($"Número de puertas: {NumeroPuertas}");
    }
    
    // Método adicional específico de Automovil
    public void AbrirMaletero()
    {
        Console.WriteLine("Maletero abierto");
    }
}

// Otra clase derivada
class Motocicleta : Vehiculo
{
    public int Cilindrada { get; set; }
    
    public Motocicleta(string marca, string modelo, int anio, int cilindrada) 
        : base(marca, modelo, anio)
    {
        Cilindrada = cilindrada;
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Cilindrada: {Cilindrada}cc");
    }
    
    // Método específico de Motocicleta
    public void HacerCaballito()
    {
        Console.WriteLine("¡Haciendo caballito!");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== HERENCIA ===\n");
        
        // Crear objetos de clases derivadas
        Automovil auto = new Automovil("Toyota", "Corolla", 2023, 4);
        Motocicleta moto = new Motocicleta("Yamaha", "R1", 2023, 1000);
        
        Console.WriteLine("=== AUTOMÓVIL ===");
        auto.MostrarInformacion();
        auto.Arrancar(); // Método heredado
        auto.AbrirMaletero(); // Método propio
        
        Console.WriteLine("\n=== MOTOCICLETA ===");
        moto.MostrarInformacion();
        moto.Arrancar(); // Método heredado
        moto.HacerCaballito(); // Método propio
        
        // Polimorfismo: tratar objetos derivados como base
        Console.WriteLine("\n=== POLIMORFISMO ===");
        Vehiculo[] vehiculos = { auto, moto };
        
        foreach (Vehiculo vehiculo in vehiculos)
        {
            vehiculo.MostrarInformacion(); // Llama a la versión sobrescrita
            Console.WriteLine();
        }
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Polimorfismo
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Polimorfismo',
    'Comprende el polimorfismo, que permite que objetos de diferentes clases sean tratados de forma uniforme.',
    'El **polimorfismo** (muchas formas) permite que objetos de diferentes clases sean tratados a través de una interfaz común. Es uno de los pilares más poderosos de POO.

**Tipos de polimorfismo:**

1. **Polimorfismo en tiempo de compilación (sobrecarga)**:
   - Múltiples métodos con el mismo nombre pero diferentes parámetros
   - El compilador decide qué método llamar

2. **Polimorfismo en tiempo de ejecución (sobrescritura)**:
   - Métodos virtuales/abstractos sobrescritos en clases derivadas
   - El runtime decide qué método ejecutar según el tipo real del objeto

**Palabras clave:**

- `virtual`: Permite que un método sea sobrescrito
- `override`: Sobrescribe un método virtual o abstracto
- `new`: Oculta un miembro de la clase base (no recomendado)
- `abstract`: Método que debe ser implementado en clases derivadas

**Ventajas:**

- **Flexibilidad**: Código que trabaja con la clase base funciona con cualquier derivada
- **Extensibilidad**: Agregar nuevas clases sin modificar código existente
- **Mantenibilidad**: Cambios centralizados en la clase base

**Ejemplo práctico:**

Un método que recibe `Animal` puede trabajar con `Perro`, `Gato`, `Pájaro`, etc., sin conocer el tipo específico.',
    'using System;
using System.Collections.Generic;

// Clase base
abstract class Animal
{
    public string Nombre { get; set; }
    
    public Animal(string nombre)
    {
        Nombre = nombre;
    }
    
    // Método virtual (puede ser sobrescrito)
    public virtual void HacerSonido()
    {
        Console.WriteLine($"{Nombre} hace un sonido");
    }
    
    // Método abstracto (debe ser implementado)
    public abstract void Moverse();
    
    // Método común
    public void Dormir()
    {
        Console.WriteLine($"{Nombre} está durmiendo");
    }
}

// Clase derivada 1
class Perro : Animal
{
    public Perro(string nombre) : base(nombre) { }
    
    // Sobrescribir método virtual
    public override void HacerSonido()
    {
        Console.WriteLine($"{Nombre} dice: ¡Guau guau!");
    }
    
    // Implementar método abstracto
    public override void Moverse()
    {
        Console.WriteLine($"{Nombre} corre con sus cuatro patas");
    }
}

// Clase derivada 2
class Gato : Animal
{
    public Gato(string nombre) : base(nombre) { }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{Nombre} dice: ¡Miau miau!");
    }
    
    public override void Moverse()
    {
        Console.WriteLine($"{Nombre} camina sigilosamente");
    }
}

// Clase derivada 3
class Pajaro : Animal
{
    public Pajaro(string nombre) : base(nombre) { }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{Nombre} canta: ¡Pío pío!");
    }
    
    public override void Moverse()
    {
        Console.WriteLine($"{Nombre} vuela por el aire");
    }
}

class Program
{
    // Método que usa polimorfismo
    static void InteractuarConAnimal(Animal animal)
    {
        Console.WriteLine($"\nInteractuando con {animal.Nombre}:");
        animal.HacerSonido();
        animal.Moverse();
        animal.Dormir();
    }
    
    static void Main()
    {
        Console.WriteLine("=== POLIMORFISMO ===\n");
        
        // Crear objetos de diferentes tipos
        Perro perro = new Perro("Max");
        Gato gato = new Gato("Luna");
        Pajaro pajaro = new Pajaro("Piolín");
        
        // Polimorfismo: tratar todos como Animal
        Animal[] animales = { perro, gato, pajaro };
        
        Console.WriteLine("=== ITERANDO COMO ANIMALES ===");
        foreach (Animal animal in animales)
        {
            animal.HacerSonido(); // Cada uno ejecuta su propia versión
            animal.Moverse();
            Console.WriteLine();
        }
        
        // Usar método que acepta Animal
        Console.WriteLine("=== USANDO MÉTODO POLIMÓRFICO ===");
        InteractuarConAnimal(perro);
        InteractuarConAnimal(gato);
        InteractuarConAnimal(pajaro);
        
        // Verificar tipo en tiempo de ejecución
        Console.WriteLine("\n=== VERIFICACIÓN DE TIPO ===");
        foreach (Animal animal in animales)
        {
            if (animal is Perro)
                Console.WriteLine($"{animal.Nombre} es un perro");
            else if (animal is Gato)
                Console.WriteLine($"{animal.Nombre} es un gato");
            else if (animal is Pajaro)
                Console.WriteLine($"{animal.Nombre} es un pájaro");
        }
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Clases Abstractas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Clases Abstractas',
    'Aprende a usar clases abstractas para definir plantillas que deben ser implementadas por clases derivadas.',
    'Una **clase abstracta** es una clase que no puede ser instanciada directamente. Se usa como base para otras clases y puede contener métodos abstractos (sin implementación) y métodos concretos (con implementación).

**Características:**

- Se declara con `abstract`
- No se puede crear instancias: `new ClaseAbstracta()` no es válido
- Puede tener métodos abstractos (sin cuerpo)
- Puede tener métodos concretos (con implementación)
- Las clases derivadas deben implementar todos los métodos abstractos
- Puede tener campos, propiedades y constructores

**Sintaxis:**

```csharp
abstract class ClaseAbstracta
{
    // Método abstracto (sin implementación)
    public abstract void MetodoAbstracto();
    
    // Método concreto (con implementación)
    public void MetodoConcreto()
    {
        // Código
    }
}
```

**Cuándo usar clases abstractas:**

- Cuando quieres proporcionar una implementación base común
- Cuando necesitas forzar a las clases derivadas a implementar ciertos métodos
- Para crear una jerarquía de clases con comportamiento compartido
- Cuando necesitas campos y constructores en la clase base

**Diferencia con interfaces:**

- Clases abstractas pueden tener implementación
- Clases abstractas pueden tener campos
- Una clase solo puede heredar de una clase abstracta
- Interfaces solo definen contratos (sin implementación por defecto)',
    'using System;

// Clase abstracta
abstract class Forma
{
    // Campo común
    protected string nombre;
    
    // Constructor
    public Forma(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Método abstracto (debe ser implementado)
    public abstract double CalcularArea();
    
    // Método abstracto
    public abstract double CalcularPerimetro();
    
    // Método concreto (compartido)
    public void MostrarInformacion()
    {
        Console.WriteLine($"Forma: {nombre}");
        Console.WriteLine($"Área: {CalcularArea():F2}");
        Console.WriteLine($"Perímetro: {CalcularPerimetro():F2}");
    }
    
    // Método virtual (puede ser sobrescrito)
    public virtual void Dibujar()
    {
        Console.WriteLine($"Dibujando {nombre}");
    }
}

// Clase derivada 1
class Circulo : Forma
{
    private double radio;
    
    public Circulo(double radio) : base("Círculo")
    {
        this.radio = radio;
    }
    
    // Implementar método abstracto
    public override double CalcularArea()
    {
        return Math.PI * radio * radio;
    }
    
    public override double CalcularPerimetro()
    {
        return 2 * Math.PI * radio;
    }
    
    public override void Dibujar()
    {
        Console.WriteLine($"Dibujando un círculo de radio {radio}");
    }
}

// Clase derivada 2
class Rectangulo : Forma
{
    private double ancho;
    private double alto;
    
    public Rectangulo(double ancho, double alto) : base("Rectángulo")
    {
        this.ancho = ancho;
        this.alto = alto;
    }
    
    public override double CalcularArea()
    {
        return ancho * alto;
    }
    
    public override double CalcularPerimetro()
    {
        return 2 * (ancho + alto);
    }
}

// Clase derivada 3
class Triangulo : Forma
{
    private double lado1, lado2, lado3;
    
    public Triangulo(double lado1, double lado2, double lado3) : base("Triángulo")
    {
        this.lado1 = lado1;
        this.lado2 = lado2;
        this.lado3 = lado3;
    }
    
    public override double CalcularArea()
    {
        // Fórmula de Herón
        double s = (lado1 + lado2 + lado3) / 2;
        return Math.Sqrt(s * (s - lado1) * (s - lado2) * (s - lado3));
    }
    
    public override double CalcularPerimetro()
    {
        return lado1 + lado2 + lado3;
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== CLASES ABSTRACTAS ===\n");
        
        // No se puede crear instancia de clase abstracta
        // Forma forma = new Forma(); // ERROR
        
        // Crear instancias de clases derivadas
        Circulo circulo = new Circulo(5);
        Rectangulo rectangulo = new Rectangulo(4, 6);
        Triangulo triangulo = new Triangulo(3, 4, 5);
        
        // Usar polimorfismo
        Forma[] formas = { circulo, rectangulo, triangulo };
        
        Console.WriteLine("=== CALCULANDO ÁREAS Y PERÍMETROS ===\n");
        foreach (Forma forma in formas)
        {
            forma.MostrarInformacion();
            forma.Dibujar();
            Console.WriteLine();
        }
        
        // Demostrar que cada forma implementa los métodos abstractos
        Console.WriteLine("=== MÉTODOS ESPECÍFICOS ===");
        Console.WriteLine($"Área del círculo: {circulo.CalcularArea():F2}");
        Console.WriteLine($"Área del rectángulo: {rectangulo.CalcularArea():F2}");
        Console.WriteLine($"Área del triángulo: {triangulo.CalcularArea():F2}");
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Interfaces
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Interfaces',
    'Aprende a definir e implementar interfaces para crear contratos que las clases deben cumplir.',
    'Una **interfaz** define un contrato que una clase debe cumplir. Especifica qué métodos, propiedades y eventos debe tener una clase, pero no cómo implementarlos.

**Características:**

- Se declara con `interface`
- Solo contiene declaraciones (sin implementación por defecto)
- Una clase puede implementar múltiples interfaces
- Define un "contrato" que las clases deben cumplir
- Permite polimorfismo sin herencia
- Desde C# 8.0, puede tener implementación por defecto

**Sintaxis:**

```csharp
interface INombreInterfaz
{
    // Declaraciones de métodos, propiedades, eventos
    void Metodo();
    int Propiedad { get; set; }
}
```

**Implementación:**

```csharp
class MiClase : INombreInterfaz
{
    // Debe implementar todos los miembros de la interfaz
    public void Metodo() { }
    public int Propiedad { get; set; }
}
```

**Convenciones de nombres:**

- Interfaces suelen comenzar con `I` (ej: `IComparable`, `IDisposable`)

**Ventajas:**

- **Múltiple implementación**: Una clase puede implementar varias interfaces
- **Desacoplamiento**: Código que depende de interfaces, no de clases concretas
- **Contratos claros**: Define exactamente qué debe hacer una clase
- **Polimorfismo**: Permite tratar diferentes clases de forma uniforme

**Cuándo usar interfaces vs clases abstractas:**

- **Interfaces**: Cuando solo necesitas definir un contrato
- **Clases abstractas**: Cuando necesitas implementación compartida y campos',
    'using System;

// Interfaz simple
interface IVolador
{
    void Volar();
    int AlturaMaxima { get; set; }
}

// Otra interfaz
interface INadador
{
    void Nadar();
    int ProfundidadMaxima { get; set; }
}

// Clase que implementa una interfaz
class Pajaro : IVolador
{
    public string Nombre { get; set; }
    public int AlturaMaxima { get; set; }
    
    public Pajaro(string nombre)
    {
        Nombre = nombre;
        AlturaMaxima = 1000;
    }
    
    public void Volar()
    {
        Console.WriteLine($"{Nombre} está volando hasta {AlturaMaxima} metros");
    }
}

// Clase que implementa múltiples interfaces
class Pato : IVolador, INadador
{
    public string Nombre { get; set; }
    public int AlturaMaxima { get; set; }
    public int ProfundidadMaxima { get; set; }
    
    public Pato(string nombre)
    {
        Nombre = nombre;
        AlturaMaxima = 100;
        ProfundidadMaxima = 5;
    }
    
    public void Volar()
    {
        Console.WriteLine($"{Nombre} puede volar hasta {AlturaMaxima} metros");
    }
    
    public void Nadar()
    {
        Console.WriteLine($"{Nombre} puede nadar hasta {ProfundidadMaxima} metros de profundidad");
    }
}

// Interfaz con múltiples métodos
interface IReproductor
{
    void Reproducir();
    void Pausar();
    void Detener();
    bool EstaReproduciendo { get; }
}

class ReproductorMusica : IReproductor
{
    private bool _reproduciendo = false;
    
    public bool EstaReproduciendo => _reproduciendo;
    
    public void Reproducir()
    {
        _reproduciendo = true;
        Console.WriteLine("Reproduciendo música...");
    }
    
    public void Pausar()
    {
        if (_reproduciendo)
        {
            Console.WriteLine("Música pausada");
        }
    }
    
    public void Detener()
    {
        _reproduciendo = false;
        Console.WriteLine("Música detenida");
    }
}

// Interfaz con implementación por defecto (C# 8.0+)
interface ICalculadora
{
    int Sumar(int a, int b);
    
    // Método con implementación por defecto
    int Multiplicar(int a, int b)
    {
        int resultado = 0;
        for (int i = 0; i < b; i++)
        {
            resultado = Sumar(resultado, a);
        }
        return resultado;
    }
}

class CalculadoraBasica : ICalculadora
{
    public int Sumar(int a, int b)
    {
        return a + b;
    }
    // Multiplicar usa la implementación por defecto
}

class Program
{
    static void HacerVolar(IVolador volador)
    {
        volador.Volar();
    }
    
    static void Main()
    {
        Console.WriteLine("=== INTERFACES ===\n");
        
        // Crear objetos
        Pajaro pajaro = new Pajaro("Canario");
        Pato pato = new Pato("Donald");
        
        // Usar como interfaces
        Console.WriteLine("=== USANDO COMO INTERFACES ===");
        HacerVolar(pajaro);
        HacerVolar(pato);
        
        // Pato también puede nadar
        Console.WriteLine("\n=== PATO COMO NADADOR ===");
        INadador nadador = pato;
        nadador.Nadar();
        
        // Implementación múltiple
        Console.WriteLine("\n=== REPRODUCTOR ===");
        IReproductor reproductor = new ReproductorMusica();
        reproductor.Reproducir();
        Console.WriteLine($"¿Está reproduciendo? {reproductor.EstaReproduciendo}");
        reproductor.Pausar();
        reproductor.Detener();
        
        // Interfaz con implementación por defecto
        Console.WriteLine("\n=== CALCULADORA ===");
        ICalculadora calc = new CalculadoraBasica();
        Console.WriteLine($"5 + 3 = {calc.Sumar(5, 3)}");
        Console.WriteLine($"5 * 3 = {calc.Multiplicar(5, 3)}");
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

