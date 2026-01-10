-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Polimorfismo"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Polimorfismo" en la ruta con RutaId = 2
DECLARE @CursoId INT;
DECLARE @RutaId INT = 2; -- RutaId de "Programación Orientada a Objetos"
DECLARE @NombreCurso NVARCHAR(100) = 'Polimorfismo';

-- Buscar el curso "Polimorfismo" en la ruta con RutaId = 2
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
        'Comprende el polimorfismo, que permite que objetos de diferentes clases sean tratados de forma uniforme',
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
-- LECCIÓN 1: Introducción al Polimorfismo
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción al Polimorfismo',
    'Comprende qué es el polimorfismo, cómo funciona y por qué es fundamental en la Programación Orientada a Objetos.',
    'El **polimorfismo** es uno de los cuatro pilares fundamentales de la Programación Orientada a Objetos (POO), junto con la encapsulación, la herencia y la abstracción. Es la capacidad de objetos de diferentes clases de ser tratados de manera uniforme.

**¿Qué es el Polimorfismo?**

La palabra "polimorfismo" viene del griego y significa "muchas formas". En programación, se refiere a la capacidad de:
- **Un mismo método** puede tener **diferentes implementaciones** en clases diferentes
- **Objetos de diferentes clases** pueden ser tratados como objetos de una **clase base común**
- El código puede trabajar con la **interfaz común** sin conocer el tipo específico

**Analogía del Mundo Real:**

Piensa en un reproductor de medios:
- Todos los dispositivos pueden "reproducir" (método común)
- Un reproductor de CD reproduce CDs
- Un reproductor de MP3 reproduce archivos MP3
- Un reproductor de streaming reproduce desde internet
- Todos tienen la misma interfaz ("reproducir"), pero implementaciones diferentes

**Tipos de Polimorfismo en C#:**

1. **Polimorfismo en Tiempo de Compilación (Sobrecarga)**
   - Múltiples métodos con el mismo nombre pero diferentes parámetros
   - Se resuelve en tiempo de compilación

2. **Polimorfismo en Tiempo de Ejecución (Sobrescritura)**
   - Métodos virtuales/abstractos sobrescritos en clases derivadas
   - Se resuelve en tiempo de ejecución

**Ventajas del Polimorfismo:**

1. **Flexibilidad**: El código puede trabajar con diferentes tipos sin conocer el específico
2. **Extensibilidad**: Puedes agregar nuevos tipos sin modificar código existente
3. **Mantenibilidad**: Cambios en implementaciones no afectan el código que las usa
4. **Reutilización**: El mismo código funciona con múltiples tipos

**Ejemplo Básico:**

```csharp
public class Animal
{
    public virtual void HacerSonido()
    {
        Console.WriteLine("El animal hace un sonido");
    }
}

public class Perro : Animal
{
    public override void HacerSonido()
    {
        Console.WriteLine("El perro ladra: ¡Guau!");
    }
}

// Polimorfismo: tratar Perro como Animal
Animal animal = new Perro();
animal.HacerSonido();  // Llama a la implementación de Perro
```

**En Resumen:**

El polimorfismo permite escribir código más flexible y extensible, donde el mismo código puede trabajar con diferentes tipos de objetos de manera uniforme.',
    'using System;

// Clase base
public class Animal
{
    protected string nombre;
    
    public Animal(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Método virtual que puede ser sobrescrito
    public virtual void HacerSonido()
    {
        Console.WriteLine($"{nombre} hace un sonido genérico");
    }
    
    public virtual void Moverse()
    {
        Console.WriteLine($"{nombre} se está moviendo");
    }
}

// Clases derivadas con diferentes implementaciones
public class Perro : Animal
{
    public Perro(string nombre) : base(nombre) { }
    
    // Sobrescribir método - implementación específica
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} ladra: ¡Guau! ¡Guau!");
    }
    
    public override void Moverse()
    {
        Console.WriteLine($"{nombre} corre a cuatro patas");
    }
}

public class Gato : Animal
{
    public Gato(string nombre) : base(nombre) { }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} maúlla: ¡Miau! ¡Miau!");
    }
    
    public override void Moverse()
    {
        Console.WriteLine($"{nombre} camina sigilosamente");
    }
}

public class Pato : Animal
{
    public Pato(string nombre) : base(nombre) { }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} grazna: ¡Cuac! ¡Cuac!");
    }
    
    public override void Moverse()
    {
        Console.WriteLine($"{nombre} camina y nada");
    }
}

class Program
{
    static void HacerSonarAnimal(Animal animal)
    {
        // Polimorfismo: el mismo código funciona con diferentes tipos
        animal.HacerSonido();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Polimorfismo Básico ===");
        
        // Crear objetos de diferentes tipos
        Perro perro = new Perro("Max");
        Gato gato = new Gato("Luna");
        Pato pato = new Pato("Donald");
        
        // Cada uno tiene su propia implementación
        perro.HacerSonido();
        gato.HacerSonido();
        pato.HacerSonido();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Tratar como Animal ===");
        
        // Polimorfismo: tratar objetos derivados como objetos base
        Animal animal1 = new Perro("Rex");
        Animal animal2 = new Gato("Mimi");
        Animal animal3 = new Pato("Pato");
        
        // El mismo código, diferentes comportamientos
        animal1.HacerSonido();  // Llama a la implementación de Perro
        animal2.HacerSonido();  // Llama a la implementación de Gato
        animal3.HacerSonido();  // Llama a la implementación de Pato
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Array Polimórfico ===");
        
        // Array de Animal que contiene diferentes tipos
        Animal[] animales = new Animal[]
        {
            new Perro("Perro 1"),
            new Gato("Gato 1"),
            new Pato("Pato 1"),
            new Perro("Perro 2")
        };
        
        // El mismo código funciona para todos
        foreach (Animal animal in animales)
        {
            animal.HacerSonido();
            animal.Moverse();
            Console.WriteLine();
        }
        
        Console.WriteLine("=== DEMOSTRACIÓN: Método que Acepta Animal ===");
        
        // Método que acepta Animal pero funciona con cualquier derivada
        HacerSonarAnimal(new Perro("Perro 3"));
        HacerSonarAnimal(new Gato("Gato 2"));
        HacerSonarAnimal(new Pato("Pato 2"));
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Polimorfismo con Métodos Virtuales
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Polimorfismo con Métodos Virtuales',
    'Aprende a usar métodos virtuales y override para implementar polimorfismo en tiempo de ejecución.',
    'Los **métodos virtuales** son la base del polimorfismo en tiempo de ejecución en C#. Permiten que las clases derivadas proporcionen sus propias implementaciones.

**¿Qué son los Métodos Virtuales?**

Un método `virtual` es un método que puede ser **sobrescrito** en clases derivadas. Cuando se llama a través de una referencia de la clase base, se ejecuta la implementación de la clase derivada.

**Sintaxis:**

```csharp
public class Base
{
    public virtual void Metodo()
    {
        // Implementación base
    }
}

public class Derivada : Base
{
    public override void Metodo()
    {
        // Implementación específica
    }
}
```

**Cómo Funciona:**

1. La clase base define un método como `virtual`
2. La clase derivada lo sobrescribe con `override`
3. Cuando se llama a través de una referencia base, se usa la implementación de la derivada

**Ejemplo:**

```csharp
Animal animal = new Perro();
animal.HacerSonido();  // Llama a Perro.HacerSonido(), no a Animal.HacerSonido()
```

**Ventajas:**

- **Flexibilidad**: Cada clase puede tener su propia implementación
- **Extensibilidad**: Puedes agregar nuevas clases sin modificar código existente
- **Polimorfismo**: El mismo código funciona con diferentes tipos

**Cuándo Usar Métodos Virtuales:**

- Cuando diferentes clases derivadas necesitan **comportamiento diferente**
- Cuando quieres permitir que las derivadas **personalicen** el comportamiento
- Para implementar el **patrón Template Method**

**Reglas:**

1. Solo métodos `virtual` pueden ser sobrescritos
2. Debes usar `override` en la clase derivada
3. La firma debe ser **exactamente igual**
4. No puedes hacer `virtual` un método `static` o `private`',
    'using System;

// Clase base con métodos virtuales
public class Forma
{
    protected string nombre;
    
    public Forma(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Método virtual: puede ser sobrescrito
    public virtual double CalcularArea()
    {
        Console.WriteLine("Calculando área de forma genérica");
        return 0;
    }
    
    // Método virtual para dibujar
    public virtual void Dibujar()
    {
        Console.WriteLine($"Dibujando {nombre}");
    }
    
    // Método virtual con implementación por defecto
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Forma: {nombre}");
        Console.WriteLine($"Área: {CalcularArea():F2}");
    }
}

// Clase derivada que sobrescribe métodos virtuales
public class Rectangulo : Forma
{
    private double ancho;
    private double alto;
    
    public Rectangulo(double ancho, double alto) : base("Rectángulo")
    {
        this.ancho = ancho;
        this.alto = alto;
    }
    
    // Sobrescribir método virtual
    public override double CalcularArea()
    {
        return ancho * alto;
    }
    
    public override void Dibujar()
    {
        Console.WriteLine($"Dibujando rectángulo: {ancho} x {alto}");
        for (int i = 0; i < (int)alto; i++)
        {
            Console.WriteLine(new string((char)42, (int)ancho));
        }
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();  // Llama al método de la clase base
        Console.WriteLine($"Dimensiones: {ancho} x {alto}");
    }
}

// Otra clase derivada
public class Circulo : Forma
{
    private double radio;
    
    public Circulo(double radio) : base("Círculo")
    {
        this.radio = radio;
    }
    
    public override double CalcularArea()
    {
        return Math.PI * radio * radio;
    }
    
    public override void Dibujar()
    {
        Console.WriteLine($"Dibujando círculo con radio {radio:F2}");
        Console.WriteLine("    O");
        Console.WriteLine("  O   O");
        Console.WriteLine("    O");
    }
}

// Clase que no sobrescribe (usa la implementación base)
public class FormaGenerica : Forma
{
    public FormaGenerica() : base("Forma Genérica") { }
    
    // No sobrescribe CalcularArea, usa el de la clase base
}

class Program
{
    static void ProcesarForma(Forma forma)
    {
        // Polimorfismo: el mismo código funciona con diferentes tipos
        Console.WriteLine("--- Procesando forma ---");
        forma.MostrarInformacion();
        forma.Dibujar();
        Console.WriteLine();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Polimorfismo con Métodos Virtuales ===");
        
        // Crear objetos de diferentes tipos
        Rectangulo rect = new Rectangulo(5, 3);
        Circulo circ = new Circulo(4);
        FormaGenerica forma = new FormaGenerica();
        
        // Cada uno usa su propia implementación
        rect.MostrarInformacion();
        Console.WriteLine();
        
        circ.MostrarInformacion();
        Console.WriteLine();
        
        forma.MostrarInformacion();
        Console.WriteLine();
        
        Console.WriteLine("=== DEMOSTRACIÓN: Tratar como Forma ===");
        
        // Polimorfismo: tratar como Forma
        Forma forma1 = new Rectangulo(6, 4);
        Forma forma2 = new Circulo(5);
        
        // El mismo código, diferentes comportamientos
        ProcesarForma(forma1);
        ProcesarForma(forma2);
        
        Console.WriteLine("=== DEMOSTRACIÓN: Array Polimórfico ===");
        
        Forma[] formas = new Forma[]
        {
            new Rectangulo(3, 2),
            new Circulo(3),
            new Rectangulo(4, 4),
            new Circulo(2)
        };
        
        double areaTotal = 0;
        foreach (Forma f in formas)
        {
            // Cada forma calcula su área de manera diferente
            areaTotal += f.CalcularArea();
        }
        
        Console.WriteLine($"Área total de todas las formas: {areaTotal:F2}");
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Polimorfismo con Clases Abstractas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Polimorfismo con Clases Abstractas',
    'Aprende a usar clases abstractas y métodos abstractos para implementar polimorfismo puro.',
    'Las **clases abstractas** y los **métodos abstractos** proporcionan una forma más estricta de polimorfismo, forzando a las clases derivadas a implementar métodos específicos.

**¿Qué es una Clase Abstracta?**

Una clase `abstract` es una clase que:
- **No se puede instanciar** directamente
- Puede tener **métodos abstractos** (sin implementación)
- Puede tener **métodos concretos** (con implementación)
- Debe ser **heredada** para ser útil

**¿Qué es un Método Abstracto?**

Un método `abstract` es un método que:
- **No tiene implementación** en la clase abstracta
- **Debe ser implementado** en todas las clases derivadas
- Solo puede existir en clases abstractas

**Sintaxis:**

```csharp
public abstract class ClaseAbstracta
{
    public abstract void MetodoAbstracto();  // Sin implementación
    
    public void MetodoConcreto()  // Con implementación
    {
        // Código
    }
}

public class Derivada : ClaseAbstracta
{
    public override void MetodoAbstracto()  // DEBE implementar
    {
        // Implementación requerida
    }
}
```

**Ventajas de las Clases Abstractas:**

1. **Forzar Implementación**: Garantiza que las derivadas implementen métodos específicos
2. **Contrato Claro**: Define qué debe hacer cada clase derivada
3. **Polimorfismo Puro**: Todas las derivadas tienen los mismos métodos
4. **Código Común**: Puede proporcionar implementaciones compartidas

**Cuándo Usar Clases Abstractas:**

- Cuando quieres **forzar** que las derivadas implementen ciertos métodos
- Cuando la clase base **no tiene sentido** por sí sola
- Cuando necesitas **código común** y **métodos obligatorios**

**Ejemplo Práctico:**

```csharp
public abstract class Vehiculo
{
    public abstract void Arrancar();  // Debe ser implementado
    public void Detener() { }          // Implementación común
}

public class Automovil : Vehiculo
{
    public override void Arrancar() { }  // DEBE implementar
}
```

**Polimorfismo con Abstractas:**

```csharp
Vehiculo[] vehiculos = new Vehiculo[]
{
    new Automovil(),
    new Motocicleta()
};

foreach (Vehiculo v in vehiculos)
{
    v.Arrancar();  // Cada uno usa su propia implementación
}
```',
    'using System;

// Clase abstracta: no se puede instanciar
public abstract class Vehiculo
{
    protected string marca;
    protected string modelo;
    
    public Vehiculo(string marca, string modelo)
    {
        this.marca = marca;
        this.modelo = modelo;
    }
    
    // Método abstracto: DEBE ser implementado en clases derivadas
    public abstract void Arrancar();
    
    // Método abstracto
    public abstract void Detener();
    
    // Método concreto: tiene implementación
    public void MostrarInformacion()
    {
        Console.WriteLine($"Vehículo: {marca} {modelo}");
    }
    
    // Método virtual: puede ser sobrescrito
    public virtual void Mantenimiento()
    {
        Console.WriteLine($"Realizando mantenimiento básico de {marca} {modelo}");
    }
}

// Clase derivada: DEBE implementar métodos abstractos
public class Automovil : Vehiculo
{
    private int numeroPuertas;
    
    public Automovil(string marca, string modelo, int numeroPuertas) 
        : base(marca, modelo)
    {
        this.numeroPuertas = numeroPuertas;
    }
    
    // DEBE implementar método abstracto
    public override void Arrancar()
    {
        Console.WriteLine($"{marca} {modelo} arranca con llave");
    }
    
    // DEBE implementar método abstracto
    public override void Detener()
    {
        Console.WriteLine($"{marca} {modelo} se detiene con frenos");
    }
    
    public override void Mantenimiento()
    {
        base.Mantenimiento();
        Console.WriteLine($"Revisando {numeroPuertas} puertas");
    }
}

// Otra clase derivada
public class Motocicleta : Vehiculo
{
    private int cilindrada;
    
    public Motocicleta(string marca, string modelo, int cilindrada) 
        : base(marca, modelo)
    {
        this.cilindrada = cilindrada;
    }
    
    public override void Arrancar()
    {
        Console.WriteLine($"{marca} {modelo} arranca con botón");
    }
    
    public override void Detener()
    {
        Console.WriteLine($"{marca} {modelo} se detiene con frenos delanteros y traseros");
    }
    
    public override void Mantenimiento()
    {
        base.Mantenimiento();
        Console.WriteLine($"Revisando motor de {cilindrada}cc");
    }
}

// Otra clase derivada
public class Bicicleta : Vehiculo
{
    private int numeroMarchas;
    
    public Bicicleta(string marca, string modelo, int numeroMarchas) 
        : base(marca, modelo)
    {
        this.numeroMarchas = numeroMarchas;
    }
    
    public override void Arrancar()
    {
        Console.WriteLine($"{marca} {modelo} se empieza a pedalear");
    }
    
    public override void Detener()
    {
        Console.WriteLine($"{marca} {modelo} se detiene con frenos de mano");
    }
}

class Program
{
    static void ProcesarVehiculo(Vehiculo vehiculo)
    {
        // Polimorfismo: tratar todos como Vehiculo
        vehiculo.MostrarInformacion();
        vehiculo.Arrancar();
        vehiculo.Detener();
        vehiculo.Mantenimiento();
        Console.WriteLine();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Polimorfismo con Clases Abstractas ===");
        
        // ERROR: No se puede instanciar una clase abstracta
        // Vehiculo vehiculo = new Vehiculo("Marca", "Modelo");
        
        // Crear objetos de clases derivadas
        Automovil auto = new Automovil("Toyota", "Corolla", 4);
        Motocicleta moto = new Motocicleta("Honda", "CBR", 600);
        Bicicleta bici = new Bicicleta("Trek", "Mountain", 21);
        
        // Cada uno implementa los métodos abstractos de manera diferente
        auto.Arrancar();
        auto.Detener();
        
        Console.WriteLine();
        
        moto.Arrancar();
        moto.Detener();
        
        Console.WriteLine();
        
        bici.Arrancar();
        bici.Detener();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Tratar como Vehiculo ===");
        
        // Polimorfismo: tratar como Vehiculo
        Vehiculo vehiculo1 = new Automovil("Ford", "Focus", 4);
        Vehiculo vehiculo2 = new Motocicleta("Yamaha", "R1", 1000);
        Vehiculo vehiculo3 = new Bicicleta("Specialized", "Road", 18);
        
        ProcesarVehiculo(vehiculo1);
        ProcesarVehiculo(vehiculo2);
        ProcesarVehiculo(vehiculo3);
        
        Console.WriteLine("=== DEMOSTRACIÓN: Array Polimórfico ===");
        
        Vehiculo[] vehiculos = new Vehiculo[]
        {
            new Automovil("BMW", "Serie 3", 4),
            new Motocicleta("Ducati", "Panigale", 1200),
            new Bicicleta("Cannondale", "Mountain", 27),
            new Automovil("Mercedes", "Clase C", 4)
        };
        
        Console.WriteLine("Procesando todos los vehículos:");
        foreach (Vehiculo v in vehiculos)
        {
            v.Arrancar();  // Cada uno usa su propia implementación
        }
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Polimorfismo con Interfaces
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Polimorfismo con Interfaces',
    'Aprende a usar interfaces para implementar polimorfismo y definir contratos que múltiples clases pueden cumplir.',
    'Las **interfaces** son otra forma poderosa de implementar polimorfismo en C#. Permiten definir contratos que múltiples clases pueden implementar, independientemente de su jerarquía de herencia.

**¿Qué es una Interface?**

Una interfaz es un **contrato** que define qué métodos y propiedades debe tener una clase, pero no cómo implementarlos. Es como un "plan" que las clases deben seguir.

**Sintaxis:**

```csharp
public interface INombre
{
    void Metodo();
    int Propiedad { get; set; }
}

public class Clase : INombre
{
    public void Metodo() { }  // DEBE implementar
    public int Propiedad { get; set; }  // DEBE implementar
}
```

**Características de las Interfaces:**

- **Solo definen la firma**: No tienen implementación
- **Múltiples interfaces**: Una clase puede implementar varias interfaces
- **Polimorfismo**: Objetos pueden tratarse por sus interfaces
- **Contratos**: Garantizan que las clases tengan ciertos métodos

**Ventajas de las Interfaces:**

1. **Flexibilidad**: No dependen de la jerarquía de herencia
2. **Múltiples Contratos**: Una clase puede implementar varias interfaces
3. **Desacoplamiento**: El código depende de la interfaz, no de la implementación
4. **Testabilidad**: Fácil crear mocks y stubs

**Polimorfismo con Interfaces:**

```csharp
public interface IVolador
{
    void Volar();
}

public class Pajaro : IVolador
{
    public void Volar() { }
}

public class Avion : IVolador
{
    public void Volar() { }
}

// Polimorfismo: tratar ambos como IVolador
IVolador[] voladores = new IVolador[] { new Pajaro(), new Avion() };
```

**Cuándo Usar Interfaces:**

- Cuando quieres definir un **contrato** sin implementación
- Cuando clases **no relacionadas** necesitan el mismo comportamiento
- Cuando necesitas **múltiples contratos** en una clase
- Para **desacoplar** el código

**Interfaces vs Clases Abstractas:**

| Característica | Interface | Clase Abstracta |
|---------------|-----------|----------------|
| Implementación | No | Parcial |
| Herencia Múltiple | Sí | No |
| Campos | No | Sí |
| Constructores | No | Sí |
| Modificadores | Public | Cualquiera |

**Ejemplo Práctico:**

```csharp
public interface IReproductor
{
    void Reproducir();
    void Detener();
}

public class ReproductorCD : IReproductor { }
public class ReproductorMP3 : IReproductor { }
```',
    'using System;
using System.Collections.Generic;

// Interfaces que definen contratos
public interface IReproductor
{
    void Reproducir();
    void Detener();
    void Pausar();
}

public interface IVolumen
{
    void SubirVolumen();
    void BajarVolumen();
    int VolumenActual { get; }
}

public interface IReproducible
{
    string Nombre { get; }
    void Reproducir();
}

// Clase que implementa una interfaz
public class ReproductorCD : IReproductor
{
    private bool reproduciendo;
    
    public void Reproducir()
    {
        if (!reproduciendo)
        {
            reproduciendo = true;
            Console.WriteLine("Reproductor CD: Reproduciendo CD");
        }
    }
    
    public void Detener()
    {
        reproduciendo = false;
        Console.WriteLine("Reproductor CD: Detenido");
    }
    
    public void Pausar()
    {
        if (reproduciendo)
        {
            Console.WriteLine("Reproductor CD: Pausado");
        }
    }
}

// Clase que implementa múltiples interfaces
public class ReproductorMP3 : IReproductor, IVolumen
{
    private bool reproduciendo;
    private int volumen;
    
    public void Reproducir()
    {
        if (!reproduciendo)
        {
            reproduciendo = true;
            Console.WriteLine("Reproductor MP3: Reproduciendo archivo MP3");
        }
    }
    
    public void Detener()
    {
        reproduciendo = false;
        Console.WriteLine("Reproductor MP3: Detenido");
    }
    
    public void Pausar()
    {
        if (reproduciendo)
        {
            Console.WriteLine("Reproductor MP3: Pausado");
        }
    }
    
    public void SubirVolumen()
    {
        if (volumen < 100)
            volumen += 10;
        Console.WriteLine($"Volumen MP3: {volumen}%");
    }
    
    public void BajarVolumen()
    {
        if (volumen > 0)
            volumen -= 10;
        Console.WriteLine($"Volumen MP3: {volumen}%");
    }
    
    public int VolumenActual => volumen;
}

// Clase que implementa múltiples interfaces
public class ReproductorStreaming : IReproductor, IVolumen, IReproducible
{
    private bool reproduciendo;
    private int volumen;
    private string nombreCancion;
    
    public string Nombre => nombreCancion;
    
    public ReproductorStreaming(string cancion)
    {
        nombreCancion = cancion;
    }
    
    public void Reproducir()
    {
        if (!reproduciendo)
        {
            reproduciendo = true;
            Console.WriteLine($"Streaming: Reproduciendo {nombreCancion}");
        }
    }
    
    public void Detener()
    {
        reproduciendo = false;
        Console.WriteLine("Streaming: Detenido");
    }
    
    public void Pausar()
    {
        if (reproduciendo)
        {
            Console.WriteLine("Streaming: Pausado");
        }
    }
    
    public void SubirVolumen()
    {
        if (volumen < 100)
            volumen += 10;
        Console.WriteLine($"Volumen Streaming: {volumen}%");
    }
    
    public void BajarVolumen()
    {
        if (volumen > 0)
            volumen -= 10;
        Console.WriteLine($"Volumen Streaming: {volumen}%");
    }
    
    public int VolumenActual => volumen;
}

class Program
{
    static void ProcesarReproductor(IReproductor reproductor)
    {
        // Polimorfismo: tratar todos como IReproductor
        reproductor.Reproducir();
        reproductor.Pausar();
        reproductor.Detener();
        Console.WriteLine();
    }
    
    static void AjustarVolumen(IVolumen dispositivo)
    {
        // Polimorfismo: tratar como IVolumen
        dispositivo.SubirVolumen();
        dispositivo.SubirVolumen();
        Console.WriteLine($"Volumen actual: {dispositivo.VolumenActual}%");
        Console.WriteLine();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Polimorfismo con Interfaces ===");
        
        ReproductorCD cd = new ReproductorCD();
        ReproductorMP3 mp3 = new ReproductorMP3();
        ReproductorStreaming streaming = new ReproductorStreaming("Canción Popular");
        
        // Cada uno implementa IReproductor de manera diferente
        cd.Reproducir();
        mp3.Reproducir();
        streaming.Reproducir();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Tratar como Interface ===");
        
        // Polimorfismo: tratar como IReproductor
        IReproductor reproductor1 = new ReproductorCD();
        IReproductor reproductor2 = new ReproductorMP3();
        IReproductor reproductor3 = new ReproductorStreaming("Otra Canción");
        
        ProcesarReproductor(reproductor1);
        ProcesarReproductor(reproductor2);
        ProcesarReproductor(reproductor3);
        
        Console.WriteLine("=== DEMOSTRACIÓN: Array Polimórfico ===");
        
        IReproductor[] reproductores = new IReproductor[]
        {
            new ReproductorCD(),
            new ReproductorMP3(),
            new ReproductorStreaming("Canción 1"),
            new ReproductorStreaming("Canción 2")
        };
        
        foreach (IReproductor r in reproductores)
        {
            r.Reproducir();  // Cada uno usa su propia implementación
        }
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Múltiples Interfaces ===");
        
        // Objeto que implementa múltiples interfaces
        ReproductorMP3 mp3Player = new ReproductorMP3();
        
        // Tratar como IReproductor
        IReproductor comoReproductor = mp3Player;
        comoReproductor.Reproducir();
        
        // Tratar como IVolumen
        IVolumen comoVolumen = mp3Player;
        AjustarVolumen(comoVolumen);
        
        // Tratar como IReproducible (si implementa)
        ReproductorStreaming stream = new ReproductorStreaming("Mi Canción");
        IReproducible comoReproducible = stream;
        Console.WriteLine($"Reproduciendo: {comoReproducible.Nombre}");
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Polimorfismo en Tiempo de Compilación (Sobrecarga)
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Polimorfismo en Tiempo de Compilación (Sobrecarga)',
    'Aprende sobre el polimorfismo estático mediante sobrecarga de métodos y operadores.',
    'El **polimorfismo en tiempo de compilación** (también llamado polimorfismo estático o sobrecarga) permite tener múltiples métodos con el mismo nombre pero diferentes parámetros. El compilador decide qué método llamar basándose en los argumentos.

**¿Qué es la Sobrecarga?**

La sobrecarga permite definir **múltiples versiones** del mismo método, cada una con una firma diferente (diferentes tipos o cantidad de parámetros).

**Sintaxis:**

```csharp
public class Calculadora
{
    public int Sumar(int a, int b) { return a + b; }
    public double Sumar(double a, double b) { return a + b; }
    public int Sumar(int a, int b, int c) { return a + b + c; }
}
```

**Cómo Funciona:**

El compilador decide qué método llamar basándose en:
- **Número de parámetros**
- **Tipos de parámetros**
- **Orden de parámetros**

```csharp
Calculadora calc = new Calculadora();
calc.Sumar(5, 3);        // Llama a Sumar(int, int)
calc.Sumar(5.5, 3.2);    // Llama a Sumar(double, double)
calc.Sumar(1, 2, 3);     // Llama a Sumar(int, int, int)
```

**Ventajas:**

1. **Conveniencia**: Mismo nombre para operaciones similares
2. **Flexibilidad**: Diferentes formas de llamar el método
3. **Legibilidad**: Código más claro y expresivo
4. **Compatibilidad**: Soporta diferentes tipos de datos

**Reglas de Sobrecarga:**

1. Los métodos deben diferir en **número o tipo** de parámetros
2. **No pueden diferir** solo en el tipo de retorno
3. Los **modificadores** no cuentan para la sobrecarga

**Ejemplos Comunes:**

```csharp
// Sobrecarga por número de parámetros
public void Metodo(int a) { }
public void Metodo(int a, int b) { }

// Sobrecarga por tipo de parámetros
public void Metodo(int a) { }
public void Metodo(string a) { }

// Sobrecarga de constructores
public Persona() { }
public Persona(string nombre) { }
public Persona(string nombre, int edad) { }
```

**Sobrecarga de Operadores:**

C# permite sobrecargar operadores para tipos personalizados:

```csharp
public static Vector operator +(Vector a, Vector b) { }
```

**Cuándo Usar Sobrecarga:**

- Cuando necesitas el **mismo comportamiento** con diferentes tipos
- Para proporcionar **valores por defecto** mediante múltiples versiones
- Para hacer el código más **intuitivo y legible**',
    'using System;

// Ejemplo: Sobrecarga de métodos
public class Calculadora
{
    // Sobrecarga por número de parámetros
    public int Sumar(int a, int b)
    {
        Console.WriteLine($"Sumar(int, int): {a} + {b}");
        return a + b;
    }
    
    public int Sumar(int a, int b, int c)
    {
        Console.WriteLine($"Sumar(int, int, int): {a} + {b} + {c}");
        return a + b + c;
    }
    
    // Sobrecarga por tipo de parámetros
    public double Sumar(double a, double b)
    {
        Console.WriteLine($"Sumar(double, double): {a} + {b}");
        return a + b;
    }
    
    public string Sumar(string a, string b)
    {
        Console.WriteLine($"Sumar(string, string): {a} + {b}");
        return a + b;
    }
    
    // Sobrecarga con diferentes combinaciones
    public int Multiplicar(int a, int b)
    {
        return a * b;
    }
    
    public double Multiplicar(double a, double b)
    {
        return a * b;
    }
    
    public int Multiplicar(int a, int b, int c)
    {
        return a * b * c;
    }
}

// Ejemplo: Sobrecarga de constructores
public class Persona
{
    private string nombre;
    private int edad;
    private string email;
    
    // Constructor sin parámetros
    public Persona()
    {
        nombre = "Sin nombre";
        edad = 0;
        email = "";
        Console.WriteLine("Persona creada (sin parámetros)");
    }
    
    // Constructor con un parámetro
    public Persona(string nombre)
    {
        this.nombre = nombre;
        edad = 0;
        email = "";
        Console.WriteLine($"Persona creada: {nombre}");
    }
    
    // Constructor con dos parámetros
    public Persona(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
        email = "";
        Console.WriteLine($"Persona creada: {nombre}, {edad} años");
    }
    
    // Constructor con tres parámetros
    public Persona(string nombre, int edad, string email)
    {
        this.nombre = nombre;
        this.edad = edad;
        this.email = email;
        Console.WriteLine($"Persona creada: {nombre}, {edad} años, {email}");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Nombre: {nombre}, Edad: {edad}, Email: {email}");
    }
}

// Ejemplo: Sobrecarga de métodos con diferentes propósitos
public class UtilidadesTexto
{
    // Sobrecarga para diferentes operaciones
    public string Procesar(string texto)
    {
        return texto.ToUpper();
    }
    
    public string Procesar(string texto, bool invertir)
    {
        if (invertir)
        {
            char[] chars = texto.ToCharArray();
            Array.Reverse(chars);
            return new string(chars);
        }
        return texto;
    }
    
    public string Procesar(string texto, int veces)
    {
        return string.Join("", Enumerable.Repeat(texto, veces));
    }
    
    public string Procesar(string texto, string prefijo, string sufijo)
    {
        return $"{prefijo}{texto}{sufijo}";
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Sobrecarga de Métodos ===");
        
        Calculadora calc = new Calculadora();
        
        // El compilador decide qué método llamar basándose en los argumentos
        int resultado1 = calc.Sumar(5, 3);
        Console.WriteLine($"Resultado: {resultado1}\n");
        
        int resultado2 = calc.Sumar(1, 2, 3);
        Console.WriteLine($"Resultado: {resultado2}\n");
        
        double resultado3 = calc.Sumar(5.5, 3.2);
        Console.WriteLine($"Resultado: {resultado3}\n");
        
        string resultado4 = calc.Sumar("Hola", " Mundo");
        Console.WriteLine($"Resultado: {resultado4}\n");
        
        Console.WriteLine("=== EJEMPLO: Sobrecarga de Constructores ===");
        
        Persona p1 = new Persona();
        p1.MostrarInformacion();
        
        Persona p2 = new Persona("Juan");
        p2.MostrarInformacion();
        
        Persona p3 = new Persona("María", 25);
        p3.MostrarInformacion();
        
        Persona p4 = new Persona("Pedro", 30, "pedro@example.com");
        p4.MostrarInformacion();
        
        Console.WriteLine("\n=== EJEMPLO: Sobrecarga con Diferentes Propósitos ===");
        
        UtilidadesTexto util = new UtilidadesTexto();
        
        Console.WriteLine(util.Procesar("hola"));
        Console.WriteLine(util.Procesar("hola", true));
        Console.WriteLine(util.Procesar("hola", 3));
        Console.WriteLine(util.Procesar("hola", "[", "]"));
        
        Console.WriteLine("\n=== NOTA IMPORTANTE ===");
        Console.WriteLine("La sobrecarga se resuelve en tiempo de COMPILACIÓN");
        Console.WriteLine("El compilador decide qué método llamar basándose en:");
        Console.WriteLine("  - Número de parámetros");
        Console.WriteLine("  - Tipos de parámetros");
        Console.WriteLine("  - Orden de parámetros");
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Polimorfismo en Tiempo de Ejecución (Sobrescritura)
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Polimorfismo en Tiempo de Ejecución (Sobrescritura)',
    'Comprende cómo funciona el polimorfismo dinámico mediante la sobrescritura de métodos virtuales.',
    'El **polimorfismo en tiempo de ejecución** (también llamado polimorfismo dinámico) se logra mediante la **sobrescritura** de métodos virtuales. A diferencia de la sobrecarga, la decisión de qué método ejecutar se toma en **tiempo de ejecución**.

**¿Cómo Funciona?**

Cuando tienes un método `virtual` en la clase base y lo sobrescribes con `override` en la derivada, el sistema decide en **tiempo de ejecución** qué implementación usar, basándose en el **tipo real** del objeto, no en el tipo de la referencia.

**Ejemplo:**

```csharp
Animal animal = new Perro();  // Referencia de tipo Animal, objeto de tipo Perro
animal.HacerSonido();  // En tiempo de ejecución, se llama a Perro.HacerSonido()
```

**Diferencia Clave:**

- **Tipo de Referencia**: El tipo de la variable (Animal)
- **Tipo Real**: El tipo del objeto creado (Perro)
- **Polimorfismo**: Se usa el tipo real, no el de la referencia

**Ventajas:**

1. **Flexibilidad**: El mismo código funciona con diferentes tipos
2. **Extensibilidad**: Puedes agregar nuevos tipos sin modificar código existente
3. **Mantenibilidad**: Cambios en implementaciones no afectan el código cliente

**Cuándo se Resuelve:**

- **Compilación**: El compilador verifica que el método existe
- **Ejecución**: Se decide qué implementación usar basándose en el tipo real

**Ejemplo Práctico:**

```csharp
public class Forma
{
    public virtual void Dibujar() { }
}

public class Circulo : Forma
{
    public override void Dibujar() { }
}

Forma forma = new Circulo();
forma.Dibujar();  // Llama a Circulo.Dibujar() en tiempo de ejecución
```

**Binding (Enlace):**

- **Early Binding**: Se resuelve en compilación (sobrecarga)
- **Late Binding**: Se resuelve en ejecución (sobrescritura)

**Ventajas del Late Binding:**

- Permite que el código sea más **flexible**
- Facilita la **extensión** sin modificar código existente
- Hace posible el **polimorfismo verdadero**',
    'using System;

// Clase base con método virtual
public class Empleado
{
    protected string nombre;
    protected double salarioBase;
    
    public Empleado(string nombre, double salarioBase)
    {
        this.nombre = nombre;
        this.salarioBase = salarioBase;
    }
    
    // Método virtual: puede ser sobrescrito
    public virtual double CalcularSalario()
    {
        return salarioBase;
    }
    
    public virtual void Trabajar()
    {
        Console.WriteLine($"{nombre} está trabajando");
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Empleado: {nombre}");
        Console.WriteLine($"Salario: ${CalcularSalario():F2}");  // Polimorfismo aquí
    }
}

// Clase derivada que sobrescribe métodos
public class Desarrollador : Empleado
{
    private double bonoTecnico;
    
    public Desarrollador(string nombre, double salarioBase, double bonoTecnico) 
        : base(nombre, salarioBase)
    {
        this.bonoTecnico = bonoTecnico;
    }
    
    // Sobrescribir: implementación específica
    public override double CalcularSalario()
    {
        return salarioBase + bonoTecnico;
    }
    
    public override void Trabajar()
    {
        Console.WriteLine($"{nombre} está programando");
    }
}

// Otra clase derivada
public class Gerente : Empleado
{
    private double bono;
    private int numeroEmpleados;
    
    public Gerente(string nombre, double salarioBase, double bono, int numeroEmpleados) 
        : base(nombre, salarioBase)
    {
        this.bono = bono;
        this.numeroEmpleados = numeroEmpleados;
    }
    
    public override double CalcularSalario()
    {
        return salarioBase + bono + (numeroEmpleados * 100);
    }
    
    public override void Trabajar()
    {
        Console.WriteLine($"{nombre} está supervisando {numeroEmpleados} empleados");
    }
}

// Otra clase derivada
public class Vendedor : Empleado
{
    private double comision;
    private double ventas;
    
    public Vendedor(string nombre, double salarioBase, double porcentajeComision) 
        : base(nombre, salarioBase)
    {
        this.porcentajeComision = porcentajeComision;
        ventas = 0;
    }
    
    private double porcentajeComision;
    
    public void RegistrarVenta(double monto)
    {
        ventas += monto;
    }
    
    public override double CalcularSalario()
    {
        return salarioBase + (ventas * porcentajeComision / 100);
    }
    
    public override void Trabajar()
    {
        Console.WriteLine($"{nombre} está vendiendo productos");
    }
}

class Program
{
    static void ProcesarEmpleado(Empleado empleado)
    {
        // Polimorfismo en tiempo de ejecución
        // El tipo real del objeto determina qué método se llama
        Console.WriteLine("--- Procesando empleado ---");
        empleado.Trabajar();
        empleado.MostrarInformacion();
        Console.WriteLine();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Polimorfismo en Tiempo de Ejecución ===");
        
        // Crear objetos de diferentes tipos
        Desarrollador dev = new Desarrollador("Juan", 50000, 10000);
        Gerente gerente = new Gerente("María", 70000, 15000, 5);
        Vendedor vendedor = new Vendedor("Pedro", 30000, 5);
        vendedor.RegistrarVenta(100000);
        
        // Cada uno calcula su salario de manera diferente
        dev.MostrarInformacion();
        gerente.MostrarInformacion();
        vendedor.MostrarInformacion();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Tratar como Empleado ===");
        
        // Polimorfismo: tratar como Empleado
        // El tipo REAL del objeto determina qué método se ejecuta
        Empleado emp1 = new Desarrollador("Dev 1", 55000, 12000);
        Empleado emp2 = new Gerente("Gerente 1", 80000, 20000, 10);
        Empleado emp3 = new Vendedor("Vendedor 1", 35000, 7);
        ((Vendedor)emp3).RegistrarVenta(50000);
        
        // En tiempo de EJECUCIÓN, se decide qué implementación usar
        ProcesarEmpleado(emp1);  // Usa Desarrollador.CalcularSalario()
        ProcesarEmpleado(emp2);  // Usa Gerente.CalcularSalario()
        ProcesarEmpleado(emp3);  // Usa Vendedor.CalcularSalario()
        
        Console.WriteLine("=== DEMOSTRACIÓN: Array Polimórfico ===");
        
        Empleado[] empleados = new Empleado[]
        {
            new Desarrollador("Dev A", 60000, 15000),
            new Gerente("Gerente A", 90000, 25000, 8),
            new Vendedor("Vendedor A", 40000, 6),
            new Desarrollador("Dev B", 65000, 18000)
        };
        
        ((Vendedor)empleados[2]).RegistrarVenta(75000);
        
        double salarioTotal = 0;
        foreach (Empleado emp in empleados)
        {
            // Polimorfismo: cada uno calcula su salario de manera diferente
            double salario = emp.CalcularSalario();
            salarioTotal += salario;
            Console.WriteLine($"{emp.GetType().Name}: ${salario:F2}");
        }
        
        Console.WriteLine($"\nSalario total de todos los empleados: ${salarioTotal:F2}");
        
        Console.WriteLine("\n=== NOTA IMPORTANTE ===");
        Console.WriteLine("El polimorfismo en tiempo de ejecución se resuelve");
        Console.WriteLine("basándose en el TIPO REAL del objeto, no en el tipo");
        Console.WriteLine("de la referencia. Esto permite flexibilidad y extensibilidad.");
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Casting y Verificación de Tipos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Casting y Verificación de Tipos',
    'Aprende a convertir entre tipos base y derivados, y cómo verificar el tipo real de un objeto en tiempo de ejecución.',
    'Cuando trabajas con polimorfismo, a veces necesitas **convertir** entre tipos base y derivados, o **verificar** el tipo real de un objeto. C# proporciona varias formas de hacer esto.

**¿Qué es el Casting?**

El casting es la conversión explícita de un tipo a otro. En el contexto de herencia, puedes convertir:
- **Hacia arriba** (upcasting): De derivada a base (implícito)
- **Hacia abajo** (downcasting): De base a derivada (explícito)

**Upcasting (Conversión Implícita):**

```csharp
Perro perro = new Perro();
Animal animal = perro;  // Upcasting: implícito y seguro
```

**Downcasting (Conversión Explícita):**

```csharp
Animal animal = new Perro();
Perro perro = (Perro)animal;  // Downcasting: explícito y puede fallar
```

**Operador `is`:**

El operador `is` verifica si un objeto es de un tipo específico:

```csharp
if (animal is Perro)
{
    Perro perro = (Perro)animal;
}
```

**Operador `as`:**

El operador `as` intenta convertir y devuelve `null` si falla:

```csharp
Perro perro = animal as Perro;
if (perro != null)
{
    // Es un Perro
}
```

**Operador `typeof`:**

Obtiene el tipo en tiempo de compilación:

```csharp
Type tipo = typeof(Perro);
```

**Método `GetType()`:**

Obtiene el tipo real en tiempo de ejecución:

```csharp
Type tipoReal = objeto.GetType();
```

**Comparación:**

- **`is`**: Verifica el tipo, devuelve `bool`
- **`as`**: Intenta convertir, devuelve el objeto o `null`
- **Casting explícito**: Convierte o lanza excepción
- **`GetType()`**: Obtiene el tipo real en ejecución

**Buenas Prácticas:**

1. Usa `as` cuando la conversión puede fallar
2. Usa `is` para verificar antes de convertir
3. Evita casting innecesario cuando el polimorfismo es suficiente
4. Usa `GetType()` para debugging, no para lógica de negocio',
    'using System;

// Clase base
public class Animal
{
    protected string nombre;
    
    public Animal(string nombre)
    {
        this.nombre = nombre;
    }
    
    public virtual void HacerSonido()
    {
        Console.WriteLine($"{nombre} hace un sonido");
    }
}

// Clases derivadas
public class Perro : Animal
{
    public Perro(string nombre) : base(nombre) { }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} ladra: ¡Guau!");
    }
    
    public void MoverCola()
    {
        Console.WriteLine($"{nombre} mueve la cola");
    }
}

public class Gato : Animal
{
    public Gato(string nombre) : base(nombre) { }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} maúlla: ¡Miau!");
    }
    
    public void Rascar()
    {
        Console.WriteLine($"{nombre} está rascando");
    }
}

class Program
{
    static void ProcesarAnimal(Animal animal)
    {
        Console.WriteLine($"\n--- Procesando {animal.GetType().Name} ---");
        animal.HacerSonido();
        
        // Verificar tipo usando operador is
        if (animal is Perro)
        {
            Perro perro = (Perro)animal;  // Downcasting explícito
            perro.MoverCola();
        }
        else if (animal is Gato)
        {
            Gato gato = (Gato)animal;
            gato.Rascar();
        }
    }
    
    static void ProcesarAnimalConAs(Animal animal)
    {
        // Usar as para conversión segura
        Perro perro = animal as Perro;
        if (perro != null)
        {
            Console.WriteLine($"Es un perro: {perro.GetType().Name}");
            perro.MoverCola();
            return;
        }
        
        Gato gato = animal as Gato;
        if (gato != null)
        {
            Console.WriteLine($"Es un gato: {gato.GetType().Name}");
            gato.Rascar();
            return;
        }
        
        Console.WriteLine("Tipo desconocido");
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Upcasting (Conversión Implícita) ===");
        
        Perro perro = new Perro("Max");
        Animal animal = perro;  // Upcasting: implícito y seguro
        
        animal.HacerSonido();  // Llama a Perro.HacerSonido() (polimorfismo)
        
        Console.WriteLine("\n=== EJEMPLO: Downcasting (Conversión Explícita) ===");
        
        Animal animal2 = new Perro("Rex");
        
        // Downcasting explícito
        Perro perro2 = (Perro)animal2;
        perro2.MoverCola();
        
        Console.WriteLine("\n=== EJEMPLO: Operador is ===");
        
        Animal[] animales = new Animal[]
        {
            new Perro("Perro 1"),
            new Gato("Gato 1"),
            new Perro("Perro 2"),
            new Gato("Gato 2")
        };
        
        foreach (Animal a in animales)
        {
            if (a is Perro)
            {
                Console.WriteLine($"{a.GetType().Name} es un Perro");
                ((Perro)a).MoverCola();
            }
            else if (a is Gato)
            {
                Console.WriteLine($"{a.GetType().Name} es un Gato");
                ((Gato)a).Rascar();
            }
        }
        
        Console.WriteLine("\n=== EJEMPLO: Operador as ===");
        
        foreach (Animal a in animales)
        {
            ProcesarAnimalConAs(a);
        }
        
        Console.WriteLine("\n=== EJEMPLO: GetType() ===");
        
        Animal animal3 = new Perro("Max");
        Animal animal4 = new Gato("Luna");
        
        Console.WriteLine($"Tipo de referencia: {typeof(Animal).Name}");
        Console.WriteLine($"Tipo real de animal3: {animal3.GetType().Name}");
        Console.WriteLine($"Tipo real de animal4: {animal4.GetType().Name}");
        
        Console.WriteLine("\n=== EJEMPLO: Comparación de Tipos ===");
        
        Animal animal5 = new Perro("Rex");
        
        // Verificar tipo
        Console.WriteLine($"¿Es Perro? {animal5 is Perro}");
        Console.WriteLine($"¿Es Gato? {animal5 is Gato}");
        Console.WriteLine($"¿Es Animal? {animal5 is Animal}");
        
        // Comparar tipos
        Console.WriteLine($"¿GetType() == typeof(Perro)? {animal5.GetType() == typeof(Perro)}");
        Console.WriteLine($"¿GetType() == typeof(Animal)? {animal5.GetType() == typeof(Animal)}");
        
        Console.WriteLine("\n=== EJEMPLO: Casting Inseguro (puede fallar) ===");
        
        Animal animal6 = new Gato("Mimi");
        
        try
        {
            // Esto fallará porque animal6 es Gato, no Perro
            Perro perro3 = (Perro)animal6;
            perro3.MoverCola();
        }
        catch (InvalidCastException e)
        {
            Console.WriteLine($"Error de casting: {e.Message}");
        }
        
        // Forma segura usando as
        Perro perro4 = animal6 as Perro;
        if (perro4 == null)
        {
            Console.WriteLine("No se pudo convertir a Perro (es seguro, no lanza excepción)");
        }
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Mejores Prácticas de Polimorfismo
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Mejores Prácticas de Polimorfismo',
    'Aprende las mejores prácticas, patrones de diseño y cuándo usar cada tipo de polimorfismo.',
    'Implementar polimorfismo correctamente requiere seguir ciertas prácticas y principios. Aquí están las mejores prácticas:

**Principios de Polimorfismo:**

1. **Principio de Abierto/Cerrado (OCP)**
   - Abierto para extensión
   - Cerrado para modificación
   - Agrega nuevos tipos sin modificar código existente

2. **Principio de Sustitución de Liskov (LSP)**
   - Las clases derivadas deben ser sustituibles por sus bases
   - No deben romper el comportamiento esperado

3. **Principio de Inversión de Dependencias (DIP)**
   - Depende de abstracciones, no de concreciones
   - Usa interfaces y clases abstractas

**Cuándo Usar Cada Tipo de Polimorfismo:**

**Sobrecarga (Compilación):**
- Mismo comportamiento con diferentes tipos
- Valores por defecto
- Conveniencia para el usuario

**Sobrescritura (Ejecución):**
- Comportamiento diferente en clases derivadas
- Extensión de funcionalidad
- Polimorfismo verdadero

**Interfaces:**
- Contratos sin implementación
- Múltiples capacidades
- Desacoplamiento

**Buenas Prácticas:**

1. **Usa `virtual` y `override` Correctamente**
   - Marca métodos como `virtual` cuando deben ser extensibles
   - Usa `override` para proporcionar implementaciones específicas

2. **Evita Casting Innecesario**
   - Usa polimorfismo cuando sea posible
   - Solo haz casting cuando sea absolutamente necesario

3. **Diseña para Extensión**
   - Piensa en cómo se extenderá tu código
   - Usa clases abstractas e interfaces apropiadamente

4. **Documenta el Comportamiento Esperado**
   - Documenta qué deben hacer las clases derivadas
   - Especifica contratos claros

5. **Evita Verificaciones de Tipo**
   - Usa polimorfismo en lugar de `if (obj is Tipo)`
   - El polimorfismo es más elegante y mantenible

**Patrones de Diseño Relacionados:**

- **Strategy Pattern**: Diferentes algoritmos intercambiables
- **Template Method**: Algoritmo con pasos personalizables
- **Factory Pattern**: Crear objetos sin especificar la clase exacta

**Errores Comunes:**

❌ **Verificación de Tipo en lugar de Polimorfismo:**
```csharp
if (animal is Perro) { }
else if (animal is Gato) { }
```

✅ **Usar Polimorfismo:**
```csharp
animal.HacerSonido();  // Cada tipo sabe qué hacer
```

❌ **Casting Innecesario:**
```csharp
Perro perro = (Perro)animal;
perro.MoverCola();
```

✅ **Usar Métodos Virtuales:**
```csharp
animal.RealizarAccion();  // Polimórfico
```

**Checklist de Mejores Prácticas:**

✅ Usas `virtual` y `override` correctamente
✅ Diseñas para extensión, no modificación
✅ Evitas verificaciones de tipo innecesarias
✅ Usas interfaces cuando sea apropiado
✅ Documentas el comportamiento esperado
✅ Respetas el principio LSP
✅ Prefieres polimorfismo sobre casting',
    'using System;
using System.Collections.Generic;

// ============================================
// EJEMPLO: Diseño para Extensión (OCP)
// ============================================

// Clase abstracta: abierta para extensión
public abstract class ProcesadorPago
{
    protected double monto;
    
    public ProcesadorPago(double monto)
    {
        this.monto = monto;
    }
    
    // Template Method Pattern
    public void Procesar()
    {
        Validar();
        Autorizar();
        Ejecutar();
        Confirmar();
    }
    
    protected virtual void Validar()
    {
        if (monto <= 0)
            throw new ArgumentException("El monto debe ser positivo");
    }
    
    protected abstract void Autorizar();
    protected abstract void Ejecutar();
    
    protected virtual void Confirmar()
    {
        Console.WriteLine("Pago procesado exitosamente");
    }
}

// Extensión sin modificar la clase base
public class ProcesadorTarjeta : ProcesadorPago
{
    private string numeroTarjeta;
    
    public ProcesadorTarjeta(double monto, string numeroTarjeta) 
        : base(monto)
    {
        this.numeroTarjeta = numeroTarjeta;
    }
    
    protected override void Autorizar()
    {
        Console.WriteLine($"Autorizando tarjeta {numeroTarjeta} por ${monto:F2}");
    }
    
    protected override void Ejecutar()
    {
        Console.WriteLine($"Cobrando ${monto:F2} a la tarjeta");
    }
}

// Otra extensión
public class ProcesadorPayPal : ProcesadorPago
{
    private string email;
    
    public ProcesadorPayPal(double monto, string email) 
        : base(monto)
    {
        this.email = email;
    }
    
    protected override void Autorizar()
    {
        Console.WriteLine($"Autorizando PayPal {email} por ${monto:F2}");
    }
    
    protected override void Ejecutar()
    {
        Console.WriteLine($"Cobrando ${monto:F2} desde PayPal");
    }
}

// ============================================
// EJEMPLO: Polimorfismo sin Verificación de Tipo
// ============================================

public abstract class Notificador
{
    protected string destinatario;
    
    public Notificador(string destinatario)
    {
        this.destinatario = destinatario;
    }
    
    public abstract void Enviar(string mensaje);
}

public class NotificadorEmail : Notificador
{
    public NotificadorEmail(string email) : base(email) { }
    
    public override void Enviar(string mensaje)
    {
        Console.WriteLine($"Enviando email a {destinatario}: {mensaje}");
    }
}

public class NotificadorSMS : Notificador
{
    public NotificadorSMS(string telefono) : base(telefono) { }
    
    public override void Enviar(string mensaje)
    {
        Console.WriteLine($"Enviando SMS a {destinatario}: {mensaje}");
    }
}

// ============================================
// EJEMPLO: Uso Correcto de Polimorfismo
// ============================================

class Program
{
    // BIEN: Usa polimorfismo, no verificación de tipo
    static void EnviarNotificacion(Notificador notificador, string mensaje)
    {
        notificador.Enviar(mensaje);  // Polimórfico
    }
    
    // MAL: Verificación de tipo (no hacer esto)
    static void EnviarNotificacionMala(Notificador notificador, string mensaje)
    {
        if (notificador is NotificadorEmail)
        {
            ((NotificadorEmail)notificador).Enviar(mensaje);
        }
        else if (notificador is NotificadorSMS)
        {
            ((NotificadorSMS)notificador).Enviar(mensaje);
        }
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Diseño para Extensión (OCP) ===");
        
        ProcesadorPago[] procesadores = new ProcesadorPago[]
        {
            new ProcesadorTarjeta(100.0, "1234-5678-9012-3456"),
            new ProcesadorPayPal(200.0, "usuario@example.com")
        };
        
        foreach (ProcesadorPago p in procesadores)
        {
            p.Procesar();  // Polimorfismo: cada uno procesa de manera diferente
            Console.WriteLine();
        }
        
        Console.WriteLine("=== EJEMPLO: Polimorfismo Correcto ===");
        
        Notificador[] notificadores = new Notificador[]
        {
            new NotificadorEmail("juan@example.com"),
            new NotificadorSMS("555-1234"),
            new NotificadorEmail("maria@example.com")
        };
        
        // BIEN: Usa polimorfismo
        foreach (Notificador n in notificadores)
        {
            EnviarNotificacion(n, "Mensaje importante");
        }
        
        Console.WriteLine("\n=== COMPARACIÓN: Polimorfismo vs Verificación de Tipo ===");
        
        Console.WriteLine("Código con Polimorfismo (RECOMENDADO):");
        Console.WriteLine("  foreach (Notificador n in notificadores)");
        Console.WriteLine("      n.Enviar(mensaje);  // Elegante y extensible");
        
        Console.WriteLine("\nCódigo con Verificación de Tipo (NO RECOMENDADO):");
        Console.WriteLine("  if (n is NotificadorEmail) { ... }");
        Console.WriteLine("  else if (n is NotificadorSMS) { ... }");
        Console.WriteLine("  // Difícil de mantener y extender");
        
        Console.WriteLine("\n=== MEJORES PRÁCTICAS ===");
        Console.WriteLine("1. Usa polimorfismo en lugar de verificación de tipo");
        Console.WriteLine("2. Diseña para extensión (OCP)");
        Console.WriteLine("3. Respetar el principio LSP");
        Console.WriteLine("4. Usa interfaces para desacoplar");
        Console.WriteLine("5. Documenta el comportamiento esperado");
        Console.WriteLine("6. Evita casting innecesario");
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
PRINT 'Lecciones del curso "Polimorfismo":';
PRINT '1. Introducción al Polimorfismo';
PRINT '2. Polimorfismo con Métodos Virtuales';
PRINT '3. Polimorfismo con Clases Abstractas';
PRINT '4. Polimorfismo con Interfaces';
PRINT '5. Polimorfismo en Tiempo de Compilación (Sobrecarga)';
PRINT '6. Polimorfismo en Tiempo de Ejecución (Sobrescritura)';
PRINT '7. Casting y Verificación de Tipos';
PRINT '8. Mejores Prácticas de Polimorfismo';
GO

