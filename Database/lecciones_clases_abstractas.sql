-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Clases Abstractas"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Clases Abstractas" en la ruta con RutaId = 2
DECLARE @CursoId INT;
DECLARE @RutaId INT = 2; -- RutaId de "Programación Orientada a Objetos"
DECLARE @NombreCurso NVARCHAR(100) = 'Clases Abstractas';

-- Buscar el curso "Clases Abstractas" en la ruta con RutaId = 2
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
        'Aprende a usar clases abstractas para definir plantillas que deben ser implementadas por clases derivadas',
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
-- LECCIÓN 1: Introducción a Clases Abstractas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Clases Abstractas',
    'Comprende qué son las clases abstractas, cómo funcionan y por qué son fundamentales en la Programación Orientada a Objetos.',
    'Una **clase abstracta** es una clase que **no se puede instanciar** directamente. Sirve como plantilla o contrato que las clases derivadas deben seguir. Es un concepto fundamental en la Programación Orientada a Objetos.

**¿Qué es una Clase Abstracta?**

Una clase abstracta es una clase que:
- **No se puede instanciar** directamente
- Puede tener **métodos abstractos** (sin implementación)
- Puede tener **métodos concretos** (con implementación)
- Puede tener **campos y propiedades**
- Debe ser **heredada** para ser útil

**Sintaxis:**

```csharp
public abstract class ClaseAbstracta
{
    // Métodos abstractos (sin implementación)
    public abstract void MetodoAbstracto();
    
    // Métodos concretos (con implementación)
    public void MetodoConcreto()
    {
        Console.WriteLine("Implementación");
    }
}
```

**¿Por qué Usar Clases Abstractas?**

1. **Forzar Implementación**: Garantiza que las clases derivadas implementen métodos específicos
2. **Contrato Claro**: Define qué deben hacer las clases derivadas
3. **Código Común**: Proporciona implementaciones compartidas
4. **Polimorfismo**: Permite tratar objetos derivados uniformemente
5. **Abstracción**: Oculta detalles y muestra solo lo esencial

**Cuándo Usar Clases Abstractas:**

- Cuando quieres **forzar** que las derivadas implementen ciertos métodos
- Cuando la clase base **no tiene sentido** por sí sola
- Cuando necesitas **código común** y **métodos obligatorios**
- Para crear una **jerarquía** de clases relacionadas

**Ejemplo del Mundo Real:**

```csharp
// Clase abstracta: no tiene sentido instanciarla
public abstract class Animal
{
    public abstract void HacerSonido();  // Debe ser implementado
    public void Dormir() { }              // Implementación común
}

// ERROR: No se puede instanciar una clase abstracta
// Animal animal = new Animal();
```

**En Resumen:**

Las clases abstractas proporcionan un equilibrio perfecto entre definir contratos (como las interfaces) y proporcionar implementación común (como las clases concretas).',
    'using System;

// Clase abstracta: no se puede instanciar
public abstract class Animal
{
    protected string nombre;
    protected int edad;
    
    // Constructor: puede existir aunque la clase sea abstracta
    public Animal(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
    }
    
    // Método abstracto: DEBE ser implementado en clases derivadas
    public abstract void HacerSonido();
    
    // Método abstracto
    public abstract void Moverse();
    
    // Método concreto: tiene implementación común
    public void Dormir()
    {
        Console.WriteLine($"{nombre} está durmiendo");
    }
    
    // Método concreto
    public void Comer()
    {
        Console.WriteLine($"{nombre} está comiendo");
    }
    
    // Método virtual: puede ser sobrescrito opcionalmente
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Animal: {nombre}, Edad: {edad} años");
    }
}

// Clase derivada: DEBE implementar métodos abstractos
public class Perro : Animal
{
    private string raza;
    
    public Perro(string nombre, int edad, string raza) 
        : base(nombre, edad)
    {
        this.raza = raza;
    }
    
    // DEBE implementar métodos abstractos
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} ladra: ¡Guau! ¡Guau!");
    }
    
    public override void Moverse()
    {
        Console.WriteLine($"{nombre} corre a cuatro patas");
    }
    
    // Puede sobrescribir métodos virtuales
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Tipo: Perro, Raza: {raza}");
    }
    
    // Puede tener métodos propios
    public void MoverCola()
    {
        Console.WriteLine($"{nombre} mueve la cola");
    }
}

// Otra clase derivada
public class Gato : Animal
{
    private bool esDomestico;
    
    public Gato(string nombre, int edad, bool esDomestico) 
        : base(nombre, edad)
    {
        this.esDomestico = esDomestico;
    }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} maúlla: ¡Miau! ¡Miau!");
    }
    
    public override void Moverse()
    {
        Console.WriteLine($"{nombre} camina sigilosamente");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Tipo: Gato, Doméstico: {esDomestico}");
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
        // Polimorfismo: tratar todos como Animal
        animal.MostrarInformacion();
        animal.Comer();      // Método común
        animal.Dormir();     // Método común
        animal.HacerSonido(); // Método abstracto (implementado en derivadas)
        animal.Moverse();     // Método abstracto (implementado en derivadas)
        Console.WriteLine();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Clases Abstractas ===");
        
        // ERROR: No se puede instanciar una clase abstracta
        // Animal animal = new Animal("Genérico", 5);
        
        // OK: Crear objetos de clases derivadas
        Perro perro = new Perro("Max", 5, "Labrador");
        Gato gato = new Gato("Luna", 3, true);
        
        // Usar métodos abstractos implementados
        perro.HacerSonido();
        perro.Moverse();
        
        Console.WriteLine();
        
        gato.HacerSonido();
        gato.Moverse();
        
        // Usar métodos comunes heredados
        perro.Comer();
        perro.Dormir();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Tratar como Animal ===");
        
        // Polimorfismo: tratar como Animal
        Animal animal1 = new Perro("Rex", 4, "Golden");
        Animal animal2 = new Gato("Mimi", 2, true);
        
        ProcesarAnimal(animal1);
        ProcesarAnimal(animal2);
        
        Console.WriteLine("=== DEMOSTRACIÓN: Array Polimórfico ===");
        
        Animal[] animales = new Animal[]
        {
            new Perro("Perro 1", 3, "Beagle"),
            new Gato("Gato 1", 2, true),
            new Perro("Perro 2", 5, "Bulldog"),
            new Gato("Gato 2", 4, false)
        };
        
        foreach (Animal a in animales)
        {
            a.HacerSonido();  // Cada uno usa su propia implementación
            a.Moverse();      // Cada uno usa su propia implementación
            Console.WriteLine();
        }
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Métodos Abstractos
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos Abstractos',
    'Aprende a definir e implementar métodos abstractos que deben ser proporcionados por las clases derivadas.',
    'Un **método abstracto** es un método que se declara en una clase abstracta pero **no tiene implementación**. Las clases derivadas **DEBEN** proporcionar la implementación de todos los métodos abstractos.

**¿Qué es un Método Abstracto?**

Un método abstracto es un método que:
- **No tiene implementación** (solo la firma)
- Solo puede existir en **clases abstractas**
- **DEBE ser implementado** en todas las clases derivadas (no abstractas)
- Usa la palabra clave `abstract`

**Sintaxis:**

```csharp
public abstract class ClaseAbstracta
{
    // Método abstracto: solo firma, sin implementación
    public abstract void MetodoAbstracto();
    
    public abstract int Calcular(int a, int b);
}

public class Derivada : ClaseAbstracta
{
    // DEBE implementar todos los métodos abstractos
    public override void MetodoAbstracto()
    {
        // Implementación requerida
    }
    
    public override int Calcular(int a, int b)
    {
        return a + b;  // Implementación requerida
    }
}
```

**Características:**

1. **Sin Implementación**: Solo la firma del método
2. **Obligatorio**: Debe ser implementado en todas las derivadas
3. **Polimórfico**: Permite comportamiento diferente en cada derivada
4. **Sin Modificadores**: No puede ser `static`, `private`, `virtual` ni `sealed`

**Ventajas:**

- **Forzar Implementación**: Garantiza que todas las derivadas implementen el método
- **Contrato Claro**: Define qué debe hacer cada clase derivada
- **Flexibilidad**: Cada derivada puede tener su propia implementación
- **Polimorfismo**: Permite tratar objetos uniformemente

**Cuándo Usar Métodos Abstractos:**

- Cuando **todas las derivadas** deben implementar un método
- Cuando el comportamiento es **específico** de cada derivada
- Cuando quieres **forzar** un contrato

**Ejemplo Práctico:**

```csharp
public abstract class Forma
{
    public abstract double CalcularArea();
    public abstract double CalcularPerimetro();
}

public class Rectangulo : Forma
{
    public override double CalcularArea() { }
    public override double CalcularPerimetro() { }
}
```

**Reglas:**

1. Solo pueden existir en clases abstractas
2. Deben ser implementados con `override` en derivadas
3. No pueden ser `static`, `private` ni `virtual`
4. La firma debe coincidir exactamente',
    'using System;

// Clase abstracta con métodos abstractos
public abstract class Forma
{
    protected string nombre;
    
    public Forma(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Método abstracto: DEBE ser implementado en derivadas
    public abstract double CalcularArea();
    
    // Método abstracto
    public abstract double CalcularPerimetro();
    
    // Método abstracto con parámetros
    public abstract void Escalar(double factor);
    
    // Método concreto: implementación común
    public void MostrarNombre()
    {
        Console.WriteLine($"Forma: {nombre}");
    }
    
    // Método virtual: puede ser sobrescrito opcionalmente
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Forma: {nombre}");
        Console.WriteLine($"Área: {CalcularArea():F2}");  // Llama al método abstracto
        Console.WriteLine($"Perímetro: {CalcularPerimetro():F2}");
    }
}

// Clase derivada: DEBE implementar TODOS los métodos abstractos
public class Rectangulo : Forma
{
    private double ancho;
    private double alto;
    
    public Rectangulo(double ancho, double alto) : base("Rectángulo")
    {
        this.ancho = ancho;
        this.alto = alto;
    }
    
    // Implementar método abstracto
    public override double CalcularArea()
    {
        return ancho * alto;
    }
    
    // Implementar método abstracto
    public override double CalcularPerimetro()
    {
        return 2 * (ancho + alto);
    }
    
    // Implementar método abstracto
    public override void Escalar(double factor)
    {
        ancho *= factor;
        alto *= factor;
        Console.WriteLine($"Rectángulo escalado por factor {factor}");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
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
    
    public override double CalcularPerimetro()
    {
        return 2 * Math.PI * radio;
    }
    
    public override void Escalar(double factor)
    {
        radio *= factor;
        Console.WriteLine($"Círculo escalado por factor {factor}");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Radio: {radio:F2}");
    }
}

// Otra clase derivada
public class Triangulo : Forma
{
    private double baseTriangulo;
    private double altura;
    private double lado1, lado2;
    
    public Triangulo(double baseTriangulo, double altura, double lado1, double lado2) 
        : base("Triángulo")
    {
        this.baseTriangulo = baseTriangulo;
        this.altura = altura;
        this.lado1 = lado1;
        this.lado2 = lado2;
    }
    
    public override double CalcularArea()
    {
        return (baseTriangulo * altura) / 2;
    }
    
    public override double CalcularPerimetro()
    {
        return baseTriangulo + lado1 + lado2;
    }
    
    public override void Escalar(double factor)
    {
        baseTriangulo *= factor;
        altura *= factor;
        lado1 *= factor;
        lado2 *= factor;
        Console.WriteLine($"Triángulo escalado por factor {factor}");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Base: {baseTriangulo:F2}, Altura: {altura:F2}");
    }
}

class Program
{
    static void ProcesarForma(Forma forma)
    {
        // Polimorfismo: el mismo código funciona con diferentes tipos
        forma.MostrarInformacion();
        forma.Escalar(2.0);  // Cada uno escala de manera diferente
        Console.WriteLine($"Área después de escalar: {forma.CalcularArea():F2}");
        Console.WriteLine();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Métodos Abstractos ===");
        
        // ERROR: No se puede instanciar una clase abstracta
        // Forma forma = new Forma("Genérica");
        
        // OK: Crear objetos de clases derivadas que implementan métodos abstractos
        Rectangulo rect = new Rectangulo(5, 3);
        Circulo circ = new Circulo(4);
        Triangulo tri = new Triangulo(6, 4, 5, 5);
        
        // Cada uno calcula su área de manera diferente
        rect.MostrarInformacion();
        Console.WriteLine();
        
        circ.MostrarInformacion();
        Console.WriteLine();
        
        tri.MostrarInformacion();
        Console.WriteLine();
        
        Console.WriteLine("=== DEMOSTRACIÓN: Polimorfismo ===");
        
        // Polimorfismo: tratar como Forma
        Forma[] formas = new Forma[]
        {
            new Rectangulo(4, 6),
            new Circulo(3),
            new Triangulo(8, 5, 6, 7),
            new Rectangulo(2, 2)
        };
        
        foreach (Forma f in formas)
        {
            ProcesarForma(f);
        }
        
        Console.WriteLine("=== DEMOSTRACIÓN: Método Abstracto en Acción ===");
        Console.WriteLine("Todas las formas pueden calcular su área y perímetro,");
        Console.WriteLine("pero cada una lo hace de manera diferente (polimorfismo).");
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Clases Abstractas vs Interfaces
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Clases Abstractas vs Interfaces',
    'Aprende las diferencias entre clases abstractas e interfaces y cuándo usar cada una.',
    'Las **clases abstractas** y las **interfaces** son dos mecanismos diferentes para definir contratos en C#. Cada una tiene sus ventajas y casos de uso específicos.

**Diferencias Principales:**

| Característica | Clase Abstracta | Interface |
|----------------|----------------|-----------|
| **Implementación** | Puede tener métodos con y sin implementación | Solo métodos sin implementación (antes de C# 8.0) |
| **Herencia Múltiple** | No (solo una clase base) | Sí (múltiples interfaces) |
| **Campos** | Puede tener campos | No puede tener campos |
| **Constructores** | Puede tener constructores | No puede tener constructores |
| **Modificadores de Acceso** | Puede tener private, protected, etc. | Todos los miembros son públicos |
| **Instanciación** | No se puede instanciar | No se puede instanciar |
| **Propósito** | Compartir código común y definir contrato | Definir solo contrato |

**Cuándo Usar Clase Abstracta:**

✅ **Usa Clase Abstracta cuando:**
- Quieres **compartir código común** entre clases derivadas
- Necesitas **campos** o **constructores**
- Las clases derivadas tienen una **relación "es un"** clara
- Necesitas diferentes **modificadores de acceso**
- Quieres proporcionar **implementación por defecto**

**Cuándo Usar Interface:**

✅ **Usa Interface cuando:**
- Solo necesitas definir un **contrato** sin implementación
- Una clase necesita implementar **múltiples contratos**
- Las clases que implementan no están relacionadas
- Quieres **desacoplar** el código
- Necesitas **flexibilidad máxima**

**Ejemplo Comparativo:**

**Clase Abstracta:**
```csharp
public abstract class Vehiculo
{
    protected string marca;  // Campo
    public Vehiculo(string marca) { }  // Constructor
    public void Arrancar() { }  // Implementación común
    public abstract void Detener();  // Método abstracto
}
```

**Interface:**
```csharp
public interface IVehiculo
{
    void Arrancar();  // Solo firma
    void Detener();   // Solo firma
}
```

**Ejemplo Práctico:**

**Clase Abstracta:** Para jerarquías donde hay código común
**Interface:** Para definir capacidades que múltiples clases pueden tener

**Puedes Combinar Ambos:**

Una clase puede heredar de una clase abstracta E implementar múltiples interfaces:

```csharp
public abstract class Animal { }
public interface IVolador { }
public interface INadador { }

public class Pato : Animal, IVolador, INadador { }
```

**En Resumen:**

- **Clase Abstracta**: Para relaciones "es un" con código común
- **Interface**: Para definir capacidades y contratos flexibles
- **Ambos**: Útiles para polimorfismo y extensibilidad',
    'using System;

// ============================================
// EJEMPLO: Clase Abstracta (con código común)
// ============================================

public abstract class Vehiculo
{
    // Campos: solo en clases abstractas o concretas
    protected string marca;
    protected string modelo;
    protected int año;
    
    // Constructor: solo en clases abstractas o concretas
    public Vehiculo(string marca, string modelo, int año)
    {
        this.marca = marca;
        this.modelo = modelo;
        this.año = año;
    }
    
    // Método concreto: implementación común
    public void MostrarInformacion()
    {
        Console.WriteLine($"Vehículo: {marca} {modelo} ({año})");
    }
    
    // Método virtual: puede ser sobrescrito
    public virtual void Mantenimiento()
    {
        Console.WriteLine($"Realizando mantenimiento básico de {marca} {modelo}");
    }
    
    // Método abstracto: DEBE ser implementado
    public abstract void Arrancar();
    public abstract void Detener();
}

// Clase derivada
public class Automovil : Vehiculo
{
    public Automovil(string marca, string modelo, int año) 
        : base(marca, modelo, año) { }
    
    public override void Arrancar()
    {
        Console.WriteLine($"{marca} {modelo} arranca con llave");
    }
    
    public override void Detener()
    {
        Console.WriteLine($"{marca} {modelo} se detiene con frenos");
    }
}

// ============================================
// EJEMPLO: Interface (solo contrato)
// ============================================

public interface IReparable
{
    // Solo firma: sin implementación
    void Reparar();
}

public interface ILimpieza
{
    void Limpiar();
}

// Clase que implementa interfaces (puede ser múltiples)
public class Bicicleta : IReparable, ILimpieza
{
    private string modelo;
    
    public Bicicleta(string modelo)
    {
        this.modelo = modelo;
    }
    
    // DEBE implementar métodos de interfaces
    public void Reparar()
    {
        Console.WriteLine($"Reparando bicicleta {modelo}");
    }
    
    public void Limpiar()
    {
        Console.WriteLine($"Limpiando bicicleta {modelo}");
    }
}

// ============================================
// EJEMPLO: Combinación de Abstracta e Interfaces
// ============================================

// Clase abstracta base
public abstract class Animal
{
    protected string nombre;
    
    public Animal(string nombre)
    {
        this.nombre = nombre;
    }
    
    public void Comer()
    {
        Console.WriteLine($"{nombre} está comiendo");
    }
    
    public abstract void HacerSonido();
}

// Interfaces para capacidades
public interface IVolador
{
    void Volar();
}

public interface INadador
{
    void Nadar();
}

// Clase que hereda de abstracta E implementa interfaces
public class Pato : Animal, IVolador, INadador
{
    public Pato(string nombre) : base(nombre) { }
    
    // Implementar método abstracto
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} grazna: ¡Cuac!");
    }
    
    // Implementar interface IVolador
    public void Volar()
    {
        Console.WriteLine($"{nombre} está volando");
    }
    
    // Implementar interface INadador
    public void Nadar()
    {
        Console.WriteLine($"{nombre} está nadando");
    }
}

// Clase que solo implementa interfaces
public class Avion : IVolador, IReparable
{
    private string modelo;
    
    public Avion(string modelo)
    {
        this.modelo = modelo;
    }
    
    public void Volar()
    {
        Console.WriteLine($"Avión {modelo} está volando");
    }
    
    public void Reparar()
    {
        Console.WriteLine($"Reparando avión {modelo}");
    }
}

class Program
{
    static void ProcesarVehiculo(Vehiculo vehiculo)
    {
        // Polimorfismo con clase abstracta
        vehiculo.MostrarInformacion();
        vehiculo.Arrancar();
        vehiculo.Detener();
        vehiculo.Mantenimiento();
        Console.WriteLine();
    }
    
    static void ProcesarReparable(IReparable reparable)
    {
        // Polimorfismo con interface
        reparable.Reparar();
    }
    
    static void HacerVolar(IVolador volador)
    {
        volador.Volar();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Clase Abstracta (con código común) ===");
        
        Automovil auto = new Automovil("Toyota", "Corolla", 2023);
        ProcesarVehiculo(auto);
        
        Console.WriteLine("=== EJEMPLO: Interface (solo contrato) ===");
        
        Bicicleta bici = new Bicicleta("Mountain Bike");
        ProcesarReparable(bici);
        bici.Limpiar();
        
        Console.WriteLine("\n=== EJEMPLO: Combinación de Abstracta e Interfaces ===");
        
        Pato pato = new Pato("Donald");
        
        // Puede tratarse como Animal (clase abstracta)
        Animal animal = pato;
        animal.Comer();
        animal.HacerSonido();
        
        // Puede tratarse como IVolador (interface)
        IVolador volador = pato;
        volador.Volar();
        
        // Puede tratarse como INadador (interface)
        INadador nadador = pato;
        nadador.Nadar();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Múltiples Interfaces ===");
        
        Avion avion = new Avion("Boeing 747");
        HacerVolar(avion);  // Como IVolador
        ProcesarReparable(avion);  // Como IReparable
        
        Console.WriteLine("\n=== DIFERENCIAS CLAVE ===");
        Console.WriteLine("Clase Abstracta:");
        Console.WriteLine("  - Puede tener campos y constructores");
        Console.WriteLine("  - Puede tener métodos con implementación");
        Console.WriteLine("  - Solo una clase base");
        Console.WriteLine();
        Console.WriteLine("Interface:");
        Console.WriteLine("  - Solo contratos (métodos)");
        Console.WriteLine("  - Múltiples interfaces");
        Console.WriteLine("  - Mayor flexibilidad");
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Propiedades Abstractas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Propiedades Abstractas',
    'Aprende a definir propiedades abstractas que deben ser implementadas por las clases derivadas.',
    'Al igual que los métodos, las **propiedades** también pueden ser abstractas en una clase abstracta. Las propiedades abstractas definen una interfaz sin implementación.

**¿Qué es una Propiedad Abstracta?**

Una propiedad abstracta es una propiedad que:
- **No tiene implementación** (solo la declaración)
- Solo puede existir en **clases abstractas**
- **DEBE ser implementada** en todas las clases derivadas
- Puede ser de solo lectura, solo escritura, o lectura/escritura

**Sintaxis:**

```csharp
public abstract class ClaseAbstracta
{
    // Propiedad abstracta de solo lectura
    public abstract int Valor { get; }
    
    // Propiedad abstracta de lectura/escritura
    public abstract string Nombre { get; set; }
}

public class Derivada : ClaseAbstracta
{
    private string nombre;
    
    // DEBE implementar todas las propiedades abstractas
    public override int Valor { get { return 10; } }
    
    public override string Nombre
    {
        get { return nombre; }
        set { nombre = value; }
    }
}
```

**Tipos de Propiedades Abstractas:**

1. **Solo Lectura:**
```csharp
public abstract int Id { get; }
```

2. **Solo Escritura:**
```csharp
public abstract string Clave { set; }
```

3. **Lectura/Escritura:**
```csharp
public abstract string Nombre { get; set; }
```

**Ventajas:**

- **Contrato Claro**: Define qué propiedades deben tener las derivadas
- **Flexibilidad**: Cada derivada puede implementar como necesite
- **Polimorfismo**: Permite acceso uniforme a propiedades

**Cuándo Usar Propiedades Abstractas:**

- Cuando todas las derivadas deben tener cierta propiedad
- Cuando quieres forzar un contrato sobre las propiedades
- Para crear interfaces consistentes

**Ejemplo Práctico:**

```csharp
public abstract class Producto
{
    public abstract string Nombre { get; set; }
    public abstract double Precio { get; set; }
    public abstract int Stock { get; }
}
```',
    'using System;

// Clase abstracta con propiedades abstractas
public abstract class Producto
{
    // Propiedad abstracta de lectura/escritura
    public abstract string Nombre { get; set; }
    
    // Propiedad abstracta de lectura/escritura
    public abstract double Precio { get; set; }
    
    // Propiedad abstracta de solo lectura
    public abstract int Stock { get; }
    
    // Propiedad abstracta calculada (solo lectura)
    public abstract double ValorTotal { get; }
    
    // Método concreto que usa propiedades abstractas
    public void MostrarInformacion()
    {
        Console.WriteLine($"Producto: {Nombre}");
        Console.WriteLine($"Precio: ${Precio:F2}");
        Console.WriteLine($"Stock: {Stock} unidades");
        Console.WriteLine($"Valor Total: ${ValorTotal:F2}");
    }
    
    // Método abstracto
    public abstract void ActualizarStock(int cantidad);
}

// Clase derivada que implementa propiedades abstractas
public class ProductoSimple : Producto
{
    private string nombre;
    private double precio;
    private int stock;
    
    // Implementar propiedades abstractas
    public override string Nombre
    {
        get { return nombre; }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("El nombre no puede estar vacío");
            nombre = value;
        }
    }
    
    public override double Precio
    {
        get { return precio; }
        set
        {
            if (value < 0)
                throw new ArgumentException("El precio no puede ser negativo");
            precio = value;
        }
    }
    
    public override int Stock
    {
        get { return stock; }
    }
    
    public override double ValorTotal
    {
        get { return precio * stock; }
    }
    
    public ProductoSimple(string nombre, double precio, int stock)
    {
        Nombre = nombre;
        Precio = precio;
        this.stock = stock;
    }
    
    public override void ActualizarStock(int cantidad)
    {
        if (stock + cantidad < 0)
            throw new InvalidOperationException("Stock insuficiente");
        stock += cantidad;
    }
}

// Otra clase derivada
public class ProductoDigital : Producto
{
    private string nombre;
    private double precio;
    private int descargasDisponibles;
    
    public override string Nombre
    {
        get { return nombre; }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("El nombre no puede estar vacío");
            nombre = value;
        }
    }
    
    public override double Precio
    {
        get { return precio; }
        set
        {
            if (value < 0)
                throw new ArgumentException("El precio no puede ser negativo");
            precio = value;
        }
    }
    
    // Stock para producto digital es infinito
    public override int Stock
    {
        get { return int.MaxValue; }
    }
    
    public override double ValorTotal
    {
        get { return precio; }  // Un solo precio, stock infinito
    }
    
    public ProductoDigital(string nombre, double precio, int descargas)
    {
        Nombre = nombre;
        Precio = precio;
        descargasDisponibles = descargas;
    }
    
    public override void ActualizarStock(int cantidad)
    {
        if (descargasDisponibles + cantidad < 0)
            throw new InvalidOperationException("No hay descargas disponibles");
        descargasDisponibles += cantidad;
    }
    
    public int DescargasDisponibles => descargasDisponibles;
}

class Program
{
    static void ProcesarProducto(Producto producto)
    {
        // Polimorfismo: acceder a propiedades abstractas
        Console.WriteLine($"\n--- Procesando {producto.Nombre} ---");
        producto.MostrarInformacion();
        
        // Todas las propiedades están disponibles
        Console.WriteLine($"Valor total: ${producto.ValorTotal:F2}");
        producto.ActualizarStock(-1);
        Console.WriteLine($"Stock después de vender 1 unidad: {producto.Stock}");
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Propiedades Abstractas ===");
        
        ProductoSimple producto1 = new ProductoSimple("Laptop", 999.99, 10);
        producto1.MostrarInformacion();
        
        Console.WriteLine();
        
        ProductoDigital producto2 = new ProductoDigital("Software", 49.99, 100);
        producto2.MostrarInformacion();
        Console.WriteLine($"Descargas disponibles: {producto2.DescargasDisponibles}");
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo con Propiedades ===");
        
        Producto[] productos = new Producto[]
        {
            new ProductoSimple("Mouse", 25.50, 50),
            new ProductoDigital("Ebook", 9.99, 1000),
            new ProductoSimple("Teclado", 75.00, 30)
        };
        
        foreach (Producto p in productos)
        {
            ProcesarProducto(p);
        }
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Acceso a Propiedades Abstractas ===");
        Console.WriteLine("Todas las clases derivadas deben implementar:");
        Console.WriteLine("  - Nombre (get/set)");
        Console.WriteLine("  - Precio (get/set)");
        Console.WriteLine("  - Stock (get)");
        Console.WriteLine("  - ValorTotal (get)");
        Console.WriteLine("Pero cada una puede implementarlas de manera diferente.");
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Constructores en Clases Abstractas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Constructores en Clases Abstractas',
    'Aprende cómo funcionan los constructores en clases abstractas y cómo se llaman desde clases derivadas.',
    'Aunque una clase abstracta **no se puede instanciar**, **sí puede tener constructores**. Los constructores en clases abstractas se usan para inicializar campos y propiedades cuando las clases derivadas se crean.

**¿Pueden las Clases Abstractas Tener Constructores?**

**Sí**, las clases abstractas pueden tener constructores, aunque:
- **No se pueden llamar directamente** (no se puede instanciar)
- Se llaman **automáticamente** cuando se crea una instancia de una clase derivada
- Se usan para **inicializar campos** y **proporcionar valores por defecto**

**Sintaxis:**

```csharp
public abstract class ClaseAbstracta
{
    protected string campo;
    
    // Constructor en clase abstracta
    public ClaseAbstracta(string valor)
    {
        campo = valor;
    }
}

public class Derivada : ClaseAbstracta
{
    // DEBE llamar al constructor de la clase base
    public Derivada(string valor) : base(valor)
    {
        // Inicialización adicional
    }
}
```

**Orden de Ejecución:**

1. Se ejecuta el **constructor de la clase base** (abstracta)
2. Luego se ejecuta el **constructor de la clase derivada**

**Ventajas:**

- **Inicialización Garantizada**: Campos de la clase base se inicializan correctamente
- **Código Común**: Lógica de inicialización compartida
- **Validación**: Puedes validar parámetros en el constructor de la base

**Ejemplo Práctico:**

```csharp
public abstract class Empleado
{
    protected string nombre;
    protected double salarioBase;
    
    public Empleado(string nombre, double salarioBase)
    {
        // Validación común
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        this.nombre = nombre;
        this.salarioBase = salarioBase;
    }
}

public class Desarrollador : Empleado
{
    public Desarrollador(string nombre, double salarioBase) 
        : base(nombre, salarioBase)  // Llama al constructor de Empleado
    {
    }
}
```

**Cuándo Usar Constructores en Abstractas:**

- Para **inicializar campos** comunes
- Para **validar parámetros** antes de asignarlos
- Para proporcionar **valores por defecto**
- Para establecer **estado inicial** común

**Buenas Prácticas:**

1. **Valida parámetros** en el constructor de la clase abstracta
2. **Usa `base()`** para llamar al constructor de la base
3. **Inicializa todos los campos** necesarios
4. **Documenta** los constructores',
    'using System;

// Clase abstracta con constructores
public abstract class Empleado
{
    protected string nombre;
    protected int edad;
    protected double salarioBase;
    protected DateTime fechaContratacion;
    
    // Constructor con parámetros: inicializa campos comunes
    public Empleado(string nombre, int edad, double salarioBase)
    {
        // Validación común para todos los empleados
        if (string.IsNullOrWhiteSpace(nombre))
            throw new ArgumentException("El nombre no puede estar vacío");
        
        if (edad < 18 || edad > 65)
            throw new ArgumentException("La edad debe estar entre 18 y 65");
        
        if (salarioBase < 0)
            throw new ArgumentException("El salario base no puede ser negativo");
        
        this.nombre = nombre;
        this.edad = edad;
        this.salarioBase = salarioBase;
        fechaContratacion = DateTime.Now;
        
        Console.WriteLine($"Empleado base creado: {nombre}");
    }
    
    // Constructor con valores por defecto
    protected Empleado(string nombre)
    {
        this.nombre = nombre;
        edad = 25;
        salarioBase = 30000;
        fechaContratacion = DateTime.Now;
    }
    
    // Método abstracto
    public abstract double CalcularSalario();
    
    // Método concreto que usa campos inicializados
    public void MostrarInformacion()
    {
        Console.WriteLine($"Empleado: {nombre}, Edad: {edad}");
        Console.WriteLine($"Fecha contratación: {fechaContratacion:yyyy-MM-dd}");
        Console.WriteLine($"Salario base: ${salarioBase:F2}");
        Console.WriteLine($"Salario total: ${CalcularSalario():F2}");
    }
}

// Clase derivada: DEBE llamar al constructor de la clase base
public class Desarrollador : Empleado
{
    private double bonoTecnico;
    
    public Desarrollador(string nombre, int edad, double salarioBase, double bonoTecnico) 
        : base(nombre, edad, salarioBase)  // Llama al constructor de Empleado
    {
        this.bonoTecnico = bonoTecnico;
        Console.WriteLine($"Desarrollador {nombre} creado con bono técnico: ${bonoTecnico:F2}");
    }
    
    public override double CalcularSalario()
    {
        return salarioBase + bonoTecnico;
    }
}

// Otra clase derivada
public class Gerente : Empleado
{
    private double bono;
    private int numeroEmpleados;
    
    public Gerente(string nombre, int edad, double salarioBase, double bono, int numeroEmpleados) 
        : base(nombre, edad, salarioBase)
    {
        this.bono = bono;
        this.numeroEmpleados = numeroEmpleados;
        Console.WriteLine($"Gerente {nombre} creado supervisando {numeroEmpleados} empleados");
    }
    
    public override double CalcularSalario()
    {
        return salarioBase + bono + (numeroEmpleados * 100);
    }
}

// Clase derivada usando constructor simplificado
public class Vendedor : Empleado
{
    private double porcentajeComision;
    private double ventas;
    
    public Vendedor(string nombre, double porcentajeComision) 
        : base(nombre)  // Usa el constructor simplificado
    {
        this.porcentajeComision = porcentajeComision;
        ventas = 0;
    }
    
    public void RegistrarVenta(double monto)
    {
        ventas += monto;
    }
    
    public override double CalcularSalario()
    {
        return salarioBase + (ventas * porcentajeComision / 100);
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Constructores en Clases Abstractas ===\n");
        
        try
        {
            // Crear objetos de clases derivadas
            Desarrollador dev = new Desarrollador("Juan", 28, 60000, 15000);
            Console.WriteLine();
            dev.MostrarInformacion();
            
            Console.WriteLine("\n" + new string('-', 50) + "\n");
            
            Gerente gerente = new Gerente("María", 35, 80000, 20000, 5);
            Console.WriteLine();
            gerente.MostrarInformacion();
            
            Console.WriteLine("\n" + new string('-', 50) + "\n");
            
            Vendedor vendedor = new Vendedor("Pedro", 5);
            vendedor.RegistrarVenta(100000);
            Console.WriteLine();
            vendedor.MostrarInformacion();
            
            Console.WriteLine("\n=== DEMOSTRACIÓN: Validación en Constructor ===");
            
            // Intentar crear con datos inválidos (será rechazado en constructor de Empleado)
            try
            {
                Desarrollador devInvalido = new Desarrollador("", 30, 50000, 10000);
            }
            catch (ArgumentException e)
            {
                Console.WriteLine($"Error: {e.Message}");
            }
            
            Console.WriteLine("\n=== ORDEN DE EJECUCIÓN ===");
            Console.WriteLine("1. Se ejecuta constructor de Empleado (clase abstracta)");
            Console.WriteLine("2. Se ejecuta constructor de la clase derivada");
            Console.WriteLine("3. Los campos de la clase base están inicializados");
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error de validación: {e.Message}");
        }
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Métodos Concretos en Clases Abstractas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos Concretos en Clases Abstractas',
    'Aprende a usar métodos concretos (con implementación) en clases abstractas para compartir código común.',
    'Una clase abstracta puede tener **métodos concretos** (con implementación completa) junto con métodos abstractos. Esto permite compartir código común mientras se fuerza la implementación de métodos específicos.

**¿Qué son los Métodos Concretos?**

Los métodos concretos son métodos que tienen **implementación completa** en la clase abstracta. Pueden ser:
- **Métodos normales**: Con implementación completa
- **Métodos virtuales**: Pueden ser sobrescritos opcionalmente
- **Métodos privados/protegidos**: Para lógica interna

**Ventajas de Métodos Concretos:**

1. **Reutilización**: Código común compartido entre derivadas
2. **Mantenibilidad**: Cambios en un lugar afectan a todas las derivadas
3. **Flexibilidad**: Las derivadas pueden usar o sobrescribir métodos concretos
4. **Template Method Pattern**: Patrón común usando métodos concretos y abstractos

**Template Method Pattern:**

El patrón Template Method usa métodos concretos y abstractos:

```csharp
public abstract class ClaseAbstracta
{
    // Método concreto (template)
    public void MetodoTemplate()
    {
        Paso1();        // Concreto
        Paso2();        // Abstracto (debe implementarse)
        Paso3();        // Concreto
    }
    
    protected void Paso1() { }  // Concreto
    protected abstract void Paso2();  // Abstracto
    protected void Paso3() { }  // Concreto
}
```

**Ejemplo Práctico:**

```csharp
public abstract class Procesador
{
    public void Procesar()
    {
        Validar();
        ProcesarDatos();  // Abstracto
        Guardar();
    }
    
    protected void Validar() { }  // Concreto
    protected abstract void ProcesarDatos();  // Abstracto
    protected void Guardar() { }  // Concreto
}
```

**Cuándo Usar Métodos Concretos:**

- Cuando **múltiples derivadas** necesitan la misma lógica
- Para proporcionar **implementación por defecto**
- Para crear **patrones de plantilla**
- Para **validación común** o **lógica compartida**

**Buenas Prácticas:**

1. **Mantén métodos concretos simples**
2. **Documenta** qué hacen
3. **Usa métodos protegidos** para lógica interna
4. **Permite sobrescritura** cuando sea apropiado (métodos virtuales)',
    'using System;

// Clase abstracta con métodos concretos y abstractos
public abstract class ProcesadorDocumento
{
    protected string nombreArchivo;
    protected string contenido;
    
    public ProcesadorDocumento(string nombreArchivo)
    {
        this.nombreArchivo = nombreArchivo;
    }
    
    // Método concreto (template method): define el proceso
    public void Procesar()
    {
        Console.WriteLine($"\n=== Procesando {nombreArchivo} ===");
        
        CargarArchivo();      // Método concreto
        Validar();            // Método virtual (puede sobrescribirse)
        ProcesarContenido();  // Método abstracto (DEBE implementarse)
        GuardarResultado(); // Método concreto
        Guardar();            // Método virtual (puede sobrescribirse)
        
        Console.WriteLine($"=== {nombreArchivo} procesado exitosamente ===\n");
    }
    
    // Método concreto: implementación común
    protected void CargarArchivo()
    {
        Console.WriteLine($"Cargando archivo: {nombreArchivo}");
        contenido = $"Contenido del archivo {nombreArchivo}";
    }
    
    // Método virtual: puede ser sobrescrito
    protected virtual void Validar()
    {
        if (string.IsNullOrEmpty(contenido))
            throw new InvalidOperationException("El archivo está vacío");
        Console.WriteLine("Validación básica completada");
    }
    
    // Método abstracto: DEBE ser implementado
    protected abstract void ProcesarContenido();
    
    // Método concreto: implementación común
    protected void GuardarResultado()
    {
        Console.WriteLine("Guardando resultado del procesamiento");
    }
    
    // Método virtual: puede ser sobrescrito
    protected virtual void Guardar()
    {
        Console.WriteLine($"Guardando archivo procesado: {nombreArchivo}");
    }
    
    // Método concreto público
    public void MostrarInformacion()
    {
        Console.WriteLine($"Procesador: {GetType().Name}");
        Console.WriteLine($"Archivo: {nombreArchivo}");
    }
}

// Clase derivada: implementa método abstracto, usa métodos concretos
public class ProcesadorTexto : ProcesadorDocumento
{
    public ProcesadorTexto(string nombreArchivo) : base(nombreArchivo) { }
    
    // DEBE implementar método abstracto
    protected override void ProcesarContenido()
    {
        Console.WriteLine("Procesando texto: aplicando formato");
        contenido = contenido.ToUpper();
    }
    
    // Opcional: sobrescribir método virtual
    protected override void Validar()
    {
        base.Validar();  // Llama a validación base
        if (!nombreArchivo.EndsWith(".txt"))
            Console.WriteLine("Advertencia: el archivo no tiene extensión .txt");
    }
}

// Otra clase derivada
public class ProcesadorImagen : ProcesadorDocumento
{
    public ProcesadorImagen(string nombreArchivo) : base(nombreArchivo) { }
    
    protected override void ProcesarContenido()
    {
        Console.WriteLine("Procesando imagen: redimensionando y comprimiendo");
    }
    
    protected override void Guardar()
    {
        base.Guardar();
        Console.WriteLine("Generando miniatura de la imagen");
    }
}

// Otra clase derivada
public class ProcesadorPDF : ProcesadorDocumento
{
    public ProcesadorPDF(string nombreArchivo) : base(nombreArchivo) { }
    
    protected override void ProcesarContenido()
    {
        Console.WriteLine("Procesando PDF: extrayendo texto y metadatos");
    }
    
    protected override void Validar()
    {
        if (!nombreArchivo.EndsWith(".pdf"))
            throw new ArgumentException("El archivo debe ser un PDF");
        Console.WriteLine("Validación de PDF completada");
    }
}

class Program
{
    static void ProcesarDocumento(ProcesadorDocumento procesador)
    {
        // Polimorfismo: todos usan el mismo método Procesar() (template method)
        procesador.MostrarInformacion();
        procesador.Procesar();  // Template method: usa métodos concretos y abstractos
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Métodos Concretos en Clases Abstractas ===");
        
        ProcesadorTexto texto = new ProcesadorTexto("documento.txt");
        ProcesarDocumento(texto);
        
        ProcesadorImagen imagen = new ProcesadorImagen("foto.jpg");
        ProcesarDocumento(imagen);
        
        ProcesadorPDF pdf = new ProcesadorPDF("reporte.pdf");
        ProcesarDocumento(pdf);
        
        Console.WriteLine("=== DEMOSTRACIÓN: Template Method Pattern ===");
        Console.WriteLine("El método Procesar() (concreto) define el flujo:");
        Console.WriteLine("  1. CargarArchivo() - Concreto");
        Console.WriteLine("  2. Validar() - Virtual (puede sobrescribirse)");
        Console.WriteLine("  3. ProcesarContenido() - Abstracto (DEBE implementarse)");
        Console.WriteLine("  4. GuardarResultado() - Concreto");
        Console.WriteLine("  5. Guardar() - Virtual (puede sobrescribirse)");
        Console.WriteLine();
        Console.WriteLine("Cada clase derivada implementa ProcesarContenido()");
        Console.WriteLine("pero todas usan el mismo flujo definido en Procesar().");
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Clases Abstractas en Jerarquías
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Clases Abstractas en Jerarquías',
    'Aprende a usar clases abstractas para crear jerarquías complejas con múltiples niveles de abstracción.',
    'Las **clases abstractas** pueden formar parte de jerarquías complejas donde múltiples niveles de abstracción definen contratos específicos. Esto permite crear estructuras muy organizadas y extensibles.

**Jerarquías con Clases Abstractas:**

Puedes tener jerarquías donde:
- Una clase abstracta hereda de otra clase abstracta
- Clases concretas heredan de clases abstractas
- Múltiples niveles de abstracción

**Ejemplo de Jerarquía:**

```
Animal (abstracta)
  ├── Mamifero (abstracta)
  │     ├── Perro (concreta)
  │     └── Gato (concreta)
  └── Ave (abstracta)
        ├── Pato (concreta)
        └── Aguila (concreta)
```

**Sintaxis de Herencia Abstracta:**

```csharp
public abstract class BaseAbstracta
{
    public abstract void Metodo1();
}

public abstract class DerivadaAbstracta : BaseAbstracta
{
    // Puede implementar algunos métodos abstractos
    public override void Metodo1() { }
    
    // Puede agregar nuevos métodos abstractos
    public abstract void Metodo2();
}

public class Concreta : DerivadaAbstracta
{
    // DEBE implementar Metodo2()
    public override void Metodo2() { }
}
```

**Ventajas de Jerarquías Abstractas:**

1. **Organización**: Estructura clara y lógica
2. **Reutilización**: Código común en niveles superiores
3. **Especialización**: Cada nivel agrega funcionalidad específica
4. **Flexibilidad**: Permite diferentes niveles de implementación

**Ejemplo Práctico:**

```csharp
public abstract class Vehiculo
{
    public abstract void Arrancar();
}

public abstract class VehiculoTerrestre : Vehiculo
{
    public override void Arrancar() { }
    public abstract void Frenar();
}

public class Automovil : VehiculoTerrestre
{
    public override void Frenar() { }
}
```

**Buenas Prácticas:**

1. **Mantén niveles simples**: 2-3 niveles de abstracción son suficientes
2. **Cada nivel agrega valor**: No crees niveles innecesarios
3. **Documenta la jerarquía**: Explica la relación entre niveles
4. **Evita abstracción excesiva**: No crees demasiados niveles',
    'using System;

// Nivel 1: Clase abstracta base
public abstract class Animal
{
    protected string nombre;
    protected int edad;
    
    public Animal(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
    }
    
    // Método abstracto: debe ser implementado
    public abstract void HacerSonido();
    
    // Método concreto: implementación común
    public void Comer()
    {
        Console.WriteLine($"{nombre} está comiendo");
    }
    
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Animal: {nombre}, Edad: {edad} años");
    }
}

// Nivel 2: Clase abstracta derivada de otra abstracta
public abstract class Mamifero : Animal
{
    protected bool tienePelo;
    
    public Mamifero(string nombre, int edad, bool tienePelo) 
        : base(nombre, edad)
    {
        this.tienePelo = tienePelo;
    }
    
    // Implementar método abstracto de Animal
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} hace un sonido de mamífero");
    }
    
    // Nuevo método abstracto
    public abstract void Amamantar();
    
    // Método concreto específico de mamíferos
    public void Respirar()
    {
        Console.WriteLine($"{nombre} respira con pulmones");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Tipo: Mamífero, Tiene pelo: {tienePelo}");
    }
}

// Nivel 2: Otra clase abstracta derivada
public abstract class Ave : Animal
{
    protected bool puedeVolar;
    
    public Ave(string nombre, int edad, bool puedeVolar) 
        : base(nombre, edad)
    {
        this.puedeVolar = puedeVolar;
    }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} hace un sonido de ave");
    }
    
    // Nuevo método abstracto
    public abstract void PonerHuevo();
    
    // Método virtual específico de aves
    public virtual void Volar()
    {
        if (puedeVolar)
            Console.WriteLine($"{nombre} está volando");
        else
            Console.WriteLine($"{nombre} no puede volar");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Tipo: Ave, Puede volar: {puedeVolar}");
    }
}

// Nivel 3: Clase concreta derivada de clase abstracta
public class Perro : Mamifero
{
    private string raza;
    
    public Perro(string nombre, int edad, string raza) 
        : base(nombre, edad, true)
    {
        this.raza = raza;
    }
    
    // Sobrescribir método de Animal
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} ladra: ¡Guau! ¡Guau!");
    }
    
    // DEBE implementar método abstracto de Mamifero
    public override void Amamantar()
    {
        Console.WriteLine($"{nombre} está amamantando a sus cachorros");
    }
    
    // Método propio
    public void MoverCola()
    {
        Console.WriteLine($"{nombre} mueve la cola");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Especie: Perro, Raza: {raza}");
    }
}

// Nivel 3: Otra clase concreta
public class Gato : Mamifero
{
    private bool esDomestico;
    
    public Gato(string nombre, int edad, bool esDomestico) 
        : base(nombre, edad, true)
    {
        this.esDomestico = esDomestico;
    }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} maúlla: ¡Miau! ¡Miau!");
    }
    
    public override void Amamantar()
    {
        Console.WriteLine($"{nombre} está amamantando a sus gatitos");
    }
    
    public void Rascar()
    {
        Console.WriteLine($"{nombre} está rascando");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Especie: Gato, Doméstico: {esDomestico}");
    }
}

// Nivel 3: Clase concreta de otra rama
public class Pato : Ave
{
    public Pato(string nombre, int edad) 
        : base(nombre, edad, true)
    {
    }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} grazna: ¡Cuac! ¡Cuac!");
    }
    
    public override void PonerHuevo()
    {
        Console.WriteLine($"{nombre} está poniendo un huevo");
    }
    
    public void Nadar()
    {
        Console.WriteLine($"{nombre} está nadando");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Especie: Pato");
    }
}

// Nivel 3: Otra clase concreta
public class Aguila : Ave
{
    private double envergadura;
    
    public Aguila(string nombre, int edad, double envergadura) 
        : base(nombre, edad, true)
    {
        this.envergadura = envergadura;
    }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} emite un grito agudo");
    }
    
    public override void PonerHuevo()
    {
        Console.WriteLine($"{nombre} está poniendo un huevo en su nido");
    }
    
    public override void Volar()
    {
        Console.WriteLine($"{nombre} está volando con una envergadura de {envergadura}m");
    }
    
    public void Cazar()
    {
        Console.WriteLine($"{nombre} está cazando desde el aire");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Especie: Águila, Envergadura: {envergadura}m");
    }
}

class Program
{
    static void ProcesarAnimal(Animal animal)
    {
        // Polimorfismo: tratar todos como Animal
        animal.MostrarInformacion();
        animal.Comer();
        animal.HacerSonido();
        Console.WriteLine();
    }
    
    static void Main()
    {
        Console.WriteLine("=== JERARQUÍA CON CLASES ABSTRACTAS ===\n");
        
        Console.WriteLine("Estructura:");
        Console.WriteLine("Animal (abstracta)");
        Console.WriteLine("  ├── Mamifero (abstracta)");
        Console.WriteLine("  │     ├── Perro (concreta)");
        Console.WriteLine("  │     └── Gato (concreta)");
        Console.WriteLine("  └── Ave (abstracta)");
        Console.WriteLine("        ├── Pato (concreta)");
        Console.WriteLine("        └── Aguila (concreta)\n");
        
        Console.WriteLine("=== NIVEL 1: Animal Abstracta ===");
        // ERROR: No se puede instanciar
        // Animal animal = new Animal("Genérico", 5);
        
        Console.WriteLine("=== NIVEL 2: Mamífero Abstracta ===");
        // ERROR: No se puede instanciar
        // Mamifero mamifero = new Mamifero("Genérico", 3, true);
        
        Console.WriteLine("=== NIVEL 3: Clases Concretas ===");
        
        Perro perro = new Perro("Max", 5, "Labrador");
        perro.MostrarInformacion();
        perro.Comer();        // De Animal
        perro.Respirar();     // De Mamifero
        perro.Amamantar();    // De Mamifero (implementado en Perro)
        perro.HacerSonido();  // De Animal (implementado en Perro)
        perro.MoverCola();    // Propio de Perro
        
        Console.WriteLine();
        
        Gato gato = new Gato("Luna", 3, true);
        gato.MostrarInformacion();
        gato.HacerSonido();
        gato.Amamantar();
        gato.Rascar();
        
        Console.WriteLine();
        
        Pato pato = new Pato("Donald", 2);
        pato.MostrarInformacion();
        pato.Comer();       // De Animal
        pato.Volar();       // De Ave
        pato.PonerHuevo();  // De Ave (implementado en Pato)
        pato.HacerSonido(); // De Animal (implementado en Pato)
        pato.Nadar();       // Propio de Pato
        
        Console.WriteLine();
        
        Aguila aguila = new Aguila("Águila Real", 10, 2.1);
        aguila.MostrarInformacion();
        aguila.HacerSonido();
        aguila.PonerHuevo();
        aguila.Volar();     // Sobrescrito en Aguila
        aguila.Cazar();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo en Jerarquía ===");
        
        Animal[] animales = new Animal[]
        {
            new Perro("Perro 1", 4, "Golden"),
            new Gato("Gato 1", 2, true),
            new Pato("Pato 1", 1),
            new Aguila("Águila 1", 8, 1.8)
        };
        
        foreach (Animal a in animales)
        {
            ProcesarAnimal(a);
        }
        
        Console.WriteLine("=== CARACTERÍSTICAS DE LA JERARQUÍA ===");
        Console.WriteLine("- Animal: define contrato básico");
        Console.WriteLine("- Mamífero/Ave: especialización con métodos adicionales");
        Console.WriteLine("- Perro/Gato/Pato/Águila: implementación concreta");
        Console.WriteLine("- Cada nivel agrega funcionalidad específica");
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Mejores Prácticas con Clases Abstractas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Mejores Prácticas con Clases Abstractas',
    'Aprende las mejores prácticas, patrones de diseño y cuándo usar clases abstractas vs interfaces.',
    'Usar clases abstractas correctamente requiere seguir ciertas prácticas y principios. Aquí están las mejores prácticas:

**Principios de Diseño:**

1. **Principio de Responsabilidad Única (SRP)**
   - Una clase abstracta debe tener una responsabilidad clara
   - Los métodos abstractos deben estar relacionados

2. **Principio de Abierto/Cerrado (OCP)**
   - Abierto para extensión
   - Cerrado para modificación
   - Agrega nuevas derivadas sin modificar la abstracta

3. **Principio de Sustitución de Liskov (LSP)**
   - Las derivadas deben ser sustituibles por la abstracta
   - No deben romper el comportamiento esperado

**Cuándo Usar Clase Abstracta:**

✅ **Usa Clase Abstracta cuando:**
- Hay una relación clara "es un"
- Necesitas compartir código común
- Necesitas campos, constructores o métodos con implementación
- Las derivadas comparten estructura común
- Quieres proporcionar implementación por defecto

❌ **NO uses Clase Abstracta cuando:**
- Solo necesitas definir un contrato (usa interface)
- Necesitas herencia múltiple (usa interfaces)
- Las clases no están relacionadas (usa interfaces)

**Cuándo Usar Interface:**

✅ **Usa Interface cuando:**
- Solo necesitas definir un contrato
- Necesitas múltiples contratos
- Las clases no están relacionadas
- Quieres máximo desacoplamiento

**Buenas Prácticas:**

1. **Documenta Métodos Abstractos**
   - Explica qué deben hacer las implementaciones
   - Especifica contratos claros

2. **Proporciona Implementación por Defecto**
   - Usa métodos concretos cuando sea apropiado
   - Permite que las derivadas sobrescriban cuando sea necesario

3. **Usa Template Method Pattern**
   - Define el flujo en métodos concretos
   - Deja pasos específicos como abstractos

4. **Mantén Jerarquías Simples**
   - 2-3 niveles de abstracción son suficientes
   - Evita abstracción excesiva

5. **Valida en Constructores**
   - Aprovecha constructores para validación común
   - Protege el estado de la clase base

**Patrones de Diseño Relacionados:**

- **Template Method**: Define algoritmo con pasos personalizables
- **Factory Method**: Crea objetos sin especificar la clase exacta
- **Strategy**: Diferentes algoritmos intercambiables

**Errores Comunes:**

❌ **Abstracción Excesiva:**
```csharp
// MAL: Demasiados niveles
A -> B -> C -> D -> E (todas abstractas)
```

✅ **Jerarquía Simple:**
```csharp
// BIEN: Pocos niveles
Abstracta -> Concreta
```

❌ **Métodos Abstractos Innecesarios:**
```csharp
// MAL: Todos los métodos son abstractos (usa interface)
public abstract class A
{
    public abstract void M1();
    public abstract void M2();
}
```

✅ **Balance entre Abstracto y Concreto:**
```csharp
// BIEN: Algunos concretos, algunos abstractos
public abstract class A
{
    public void MetodoComun() { }  // Concreto
    public abstract void MetodoEspecifico();  // Abstracto
}
```

**Checklist de Mejores Prácticas:**

✅ La relación "es un" es verdadera
✅ Hay código común que compartir
✅ Necesitas campos o constructores
✅ Los métodos abstractos están bien documentados
✅ Proporcionas implementación por defecto cuando sea apropiado
✅ La jerarquía es simple (2-3 niveles)
✅ Respetas el principio LSP
✅ Usas interfaces cuando sea más apropiado',
    'using System;

// ============================================
// EJEMPLO: Diseño Correcto con Clase Abstracta
// ============================================

// Clase abstracta bien diseñada: balance entre abstracto y concreto
public abstract class ProcesadorPago
{
    protected double monto;
    protected DateTime fecha;
    
    // Constructor: inicialización común
    public ProcesadorPago(double monto)
    {
        if (monto <= 0)
            throw new ArgumentException("El monto debe ser positivo");
        
        this.monto = monto;
        fecha = DateTime.Now;
    }
    
    // Template Method: define el flujo (concreto)
    public void ProcesarPago()
    {
        Console.WriteLine($"\n=== Procesando pago de ${monto:F2} ===");
        Validar();           // Concreto
        Autorizar();         // Abstracto (específico de cada tipo)
        EjecutarPago();      // Abstracto (específico de cada tipo)
        Confirmar();         // Concreto
        RegistrarLog();      // Concreto
        Console.WriteLine($"=== Pago procesado exitosamente ===\n");
    }
    
    // Método concreto: validación común
    protected void Validar()
    {
        if (monto > 10000)
            Console.WriteLine("Advertencia: Monto alto, requiere verificación adicional");
        Console.WriteLine("Validación básica completada");
    }
    
    // Método abstracto: DEBE ser implementado
    protected abstract void Autorizar();
    protected abstract void EjecutarPago();
    
    // Método concreto: confirmación común
    protected void Confirmar()
    {
        Console.WriteLine($"Pago confirmado el {fecha:yyyy-MM-dd HH:mm:ss}");
    }
    
    // Método concreto: logging común
    protected void RegistrarLog()
    {
        Console.WriteLine($"Log: Pago de ${monto:F2} procesado mediante {GetType().Name}");
    }
    
    // Método virtual: puede ser sobrescrito
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Procesador: {GetType().Name}");
        Console.WriteLine($"Monto: ${monto:F2}");
    }
}

// Implementación concreta
public class ProcesadorTarjeta : ProcesadorPago
{
    private string numeroTarjeta;
    
    public ProcesadorTarjeta(double monto, string numeroTarjeta) 
        : base(monto)
    {
        this.numeroTarjeta = numeroTarjeta;
    }
    
    // Implementar método abstracto
    protected override void Autorizar()
    {
        Console.WriteLine($"Autorizando tarjeta {numeroTarjeta} por ${monto:F2}");
        Console.WriteLine("Autorización bancaria exitosa");
    }
    
    // Implementar método abstracto
    protected override void EjecutarPago()
    {
        Console.WriteLine($"Cobrando ${monto:F2} a la tarjeta {numeroTarjeta}");
        Console.WriteLine("Transacción completada");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Método: Tarjeta de Crédito");
    }
}

// Otra implementación
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
        Console.WriteLine($"Autorizando cuenta PayPal {email}");
        Console.WriteLine("Autorización PayPal exitosa");
    }
    
    protected override void EjecutarPago()
    {
        Console.WriteLine($"Cobrando ${monto:F2} desde PayPal ({email})");
        Console.WriteLine("Transferencia PayPal completada");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Método: PayPal");
    }
}

// ============================================
// EJEMPLO: Uso Correcto vs Incorrecto
// ============================================

class Program
{
    static void ProcesarPago(ProcesadorPago procesador)
    {
        // Polimorfismo: todos usan el mismo método ProcesarPago()
        procesador.MostrarInformacion();
        procesador.ProcesarPago();  // Template method
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Diseño Correcto ===");
        
        try
        {
            ProcesadorPago pago1 = new ProcesadorTarjeta(500.0, "1234-5678-9012-3456");
            ProcesarPago(pago1);
            
            ProcesadorPago pago2 = new ProcesadorPayPal(750.0, "usuario@example.com");
            ProcesarPago(pago2);
            
            Console.WriteLine("=== DEMOSTRACIÓN: Array Polimórfico ===");
            
            ProcesadorPago[] pagos = new ProcesadorPago[]
            {
                new ProcesadorTarjeta(100, "1111-2222-3333-4444"),
                new ProcesadorPayPal(200, "test@example.com"),
                new ProcesadorTarjeta(300, "5555-6666-7777-8888")
            };
            
            foreach (ProcesadorPago p in pagos)
            {
                p.ProcesarPago();
            }
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
        
        Console.WriteLine("\n=== MEJORES PRÁCTICAS APLICADAS ===");
        Console.WriteLine("1. Template Method Pattern: flujo definido en método concreto");
        Console.WriteLine("2. Métodos abstractos solo donde es necesario");
        Console.WriteLine("3. Métodos concretos para código común");
        Console.WriteLine("4. Validación en constructor");
        Console.WriteLine("5. Documentación clara del contrato");
        Console.WriteLine("6. Polimorfismo para flexibilidad");
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
PRINT 'Lecciones del curso "Clases Abstractas":';
PRINT '1. Introducción a Clases Abstractas';
PRINT '2. Métodos Abstractos';
PRINT '3. Clases Abstractas vs Interfaces';
PRINT '4. Propiedades Abstractas';
PRINT '5. Constructores en Clases Abstractas';
PRINT '6. Métodos Concretos en Clases Abstractas';
PRINT '7. Clases Abstractas en Jerarquías';
PRINT '8. Mejores Prácticas con Clases Abstractas';
GO

