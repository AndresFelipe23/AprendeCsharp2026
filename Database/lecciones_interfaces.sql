-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Interfaces"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Interfaces" en la ruta con RutaId = 2
DECLARE @CursoId INT;
DECLARE @RutaId INT = 2; -- RutaId de "Programación Orientada a Objetos"
DECLARE @NombreCurso NVARCHAR(100) = 'Interfaces';

-- Buscar el curso "Interfaces" en la ruta con RutaId = 2
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
        'Aprende a usar interfaces para definir contratos que las clases deben implementar, permitiendo máxima flexibilidad y desacoplamiento',
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
-- LECCIÓN 1: Introducción a Interfaces
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Interfaces',
    'Comprende qué son las interfaces, cómo funcionan y por qué son fundamentales para el diseño orientado a objetos en C#.',
    'Una **interfaz** define un **contrato** que las clases deben seguir. Es una especificación de qué métodos y propiedades debe tener una clase, sin proporcionar implementación.

**¿Qué es una Interface?**

Una interfaz es un contrato que:
- **Define qué debe hacer** una clase (no cómo)
- **No tiene implementación** (solo firmas de métodos)
- Puede ser **implementada por múltiples clases** (herencia múltiple)
- Permite **polimorfismo** y **desacoplamiento**

**Sintaxis:**

```csharp
public interface IInterface
{
    // Solo firmas de métodos (sin implementación)
    void Metodo1();
    int Metodo2(int valor);
    string Propiedad { get; set; }
}

// Clase que implementa la interfaz
public class Clase : IInterface
{
    // DEBE implementar todos los miembros de la interfaz
    public void Metodo1() { }
    public int Metodo2(int valor) { return valor; }
    public string Propiedad { get; set; }
}
```

**Características de las Interfaces:**

1. **Solo Contratos**: Solo definen qué debe hacer una clase
2. **Sin Implementación**: No pueden tener código en métodos
3. **Públicas por Defección**: Todos los miembros son públicos
4. **Múltiple Herencia**: Una clase puede implementar múltiples interfaces
5. **No se Pueden Instanciar**: No puedes crear objetos de una interfaz directamente

**¿Por qué Usar Interfaces?**

1. **Contrato Claro**: Define exactamente qué debe hacer una clase
2. **Desacoplamiento**: Reduce dependencias entre clases
3. **Flexibilidad**: Permite cambiar implementaciones fácilmente
4. **Polimorfismo**: Trata objetos de diferentes clases de manera uniforme
5. **Testing**: Facilita la creación de mocks y stubs
6. **Herencia Múltiple**: Permite que una clase tenga múltiples contratos

**Convenciones de Nomenclatura:**

- **Siempre comienzan con `I`**: `ISerializable`, `IEnumerable`, `IDisposable`
- **Sustantivos o adjetivos**: `IComparable`, `IReadable`
- **Descriptivos**: Nombres claros que indiquen la capacidad

**Ejemplo del Mundo Real:**

```csharp
// Interface que define capacidad de volar
public interface IVolar
{
    void Volar();
}

// Múltiples clases pueden implementarla
public class Pajaro : IVolar { }
public class Avion : IVolar { }
```

**En Resumen:**

Las interfaces son la forma de C# de definir contratos. Permiten máximo desacoplamiento y flexibilidad, y son fundamentales para el diseño orientado a objetos.',
    'using System;

// Interface que define capacidad de sonido
public interface IHacerSonido
{
    // Solo firma: sin implementación
    void HacerSonido();
}

// Interface que define capacidad de movimiento
public interface IMoverse
{
    void Moverse();
}

// Clase que implementa UNA interfaz
public class Perro : IHacerSonido
{
    private string nombre;
    
    public Perro(string nombre)
    {
        this.nombre = nombre;
    }
    
    // DEBE implementar método de la interfaz
    public void HacerSonido()
    {
        Console.WriteLine($"{nombre} ladra: ¡Guau! ¡Guau!");
    }
    
    // Puede tener métodos propios
    public void MoverCola()
    {
        Console.WriteLine($"{nombre} mueve la cola");
    }
}

// Clase que implementa MÚLTIPLES interfaces
public class Pato : IHacerSonido, IMoverse
{
    private string nombre;
    
    public Pato(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Implementar método de IHacerSonido
    public void HacerSonido()
    {
        Console.WriteLine($"{nombre} grazna: ¡Cuac! ¡Cuac!");
    }
    
    // Implementar método de IMoverse
    public void Moverse()
    {
        Console.WriteLine($"{nombre} está caminando");
    }
    
    // Método propio
    public void Nadar()
    {
        Console.WriteLine($"{nombre} está nadando");
    }
}

// Otra clase que implementa interfaces
public class Gato : IHacerSonido, IMoverse
{
    private string nombre;
    
    public Gato(string nombre)
    {
        this.nombre = nombre;
    }
    
    public void HacerSonido()
    {
        Console.WriteLine($"{nombre} maúlla: ¡Miau! ¡Miau!");
    }
    
    public void Moverse()
    {
        Console.WriteLine($"{nombre} camina sigilosamente");
    }
}

// Clase que NO implementa ninguna interfaz (no tiene esas capacidades)
public class Planta
{
    private string nombre;
    
    public Planta(string nombre)
    {
        this.nombre = nombre;
    }
    
    public void Crecer()
    {
        Console.WriteLine($"{nombre} está creciendo");
    }
    
    // NO puede hacer sonido ni moverse
}

class Program
{
    // Método que acepta cualquier objeto que implemente IHacerSonido
    static void HacerSonarAnimal(IHacerSonido animal)
    {
        // Polimorfismo: trabajar con la interfaz
        animal.HacerSonido();
    }
    
    // Método que acepta cualquier objeto que implemente IMoverse
    static void MoverObjeto(IMoverse objeto)
    {
        objeto.Moverse();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Interfaces ===\n");
        
        // Crear objetos
        Perro perro = new Perro("Max");
        Gato gato = new Gato("Luna");
        Pato pato = new Pato("Donald");
        Planta planta = new Planta("Rosa");
        
        // Usar métodos propios
        perro.MoverCola();
        pato.Nadar();
        planta.Crecer();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo con Interfaces ===");
        
        // Polimorfismo: tratar como IHacerSonido
        IHacerSonido[] animales = new IHacerSonido[]
        {
            perro,
            gato,
            pato
        };
        
        foreach (IHacerSonido animal in animales)
        {
            HacerSonarAnimal(animal);  // Cada uno hace su sonido
        }
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Múltiples Interfaces ===");
        
        // Pato implementa múltiples interfaces
        IMoverse objetoMovible = pato;
        objetoMovible.Moverse();
        
        IHacerSonido objetoSonido = pato;
        objetoSonido.HacerSonido();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Trabajar con Interfaces ===");
        
        // Array de objetos que se mueven
        IMoverse[] objetosMovibles = new IMoverse[]
        {
            new Gato("Mimi"),
            new Pato("Pato")
        };
        
        foreach (IMoverse obj in objetosMovibles)
        {
            MoverObjeto(obj);
        }
        
        Console.WriteLine("\n=== CARACTERÍSTICAS DE INTERFACES ===");
        Console.WriteLine("- Definir contratos (qué debe hacer)");
        Console.WriteLine("- Sin implementación (solo firmas)");
        Console.WriteLine("- Herencia múltiple permitida");
        Console.WriteLine("- Polimorfismo y desacoplamiento");
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Definición e Implementación de Interfaces
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Definición e Implementación de Interfaces',
    'Aprende a definir interfaces y a implementarlas correctamente en tus clases.',
    'Definir e implementar interfaces correctamente es fundamental en C#. Las interfaces definen contratos claros que las clases deben cumplir.

**Definir una Interface:**

```csharp
public interface INombreInterface
{
    // Métodos sin implementación
    void Metodo1();
    int Metodo2(int valor);
    
    // Propiedades
    string Propiedad { get; set; }
    int SoloLectura { get; }
}
```

**Reglas para Definir Interfaces:**

1. **Solo Firmas**: No pueden tener implementación
2. **Públicas por Defecto**: Todos los miembros son públicos
3. **No Constructores**: No pueden tener constructores
4. **No Campos**: No pueden tener campos (antes de C# 8.0)
5. **No Métodos Estáticos**: No pueden tener métodos estáticos (antes de C# 8.0)

**Implementar una Interface:**

```csharp
public class MiClase : INombreInterface
{
    // DEBE implementar todos los miembros de la interfaz
    public void Metodo1()
    {
        // Implementación
    }
    
    public int Metodo2(int valor)
    {
        return valor * 2;
    }
    
    public string Propiedad { get; set; }
    public int SoloLectura { get { return 10; } }
}
```

**Reglas para Implementar Interfaces:**

1. **Debe Implementar Todo**: Todos los miembros de la interfaz deben ser implementados
2. **Firma Exacta**: La firma debe coincidir exactamente
3. **Públicos**: Los miembros implementados deben ser públicos
4. **Usar `public`**: Todos los miembros implementados son públicos

**Ejemplo Completo:**

```csharp
public interface ICalculadora
{
    double Sumar(double a, double b);
    double Restar(double a, double b);
    double Multiplicar(double a, double b);
}

public class CalculadoraSimple : ICalculadora
{
    public double Sumar(double a, double b) => a + b;
    public double Restar(double a, double b) => a - b;
    public double Multiplicar(double a, double b) => a * b;
}
```

**Verificar Implementación:**

Puedes verificar si una clase implementa una interfaz:

```csharp
if (objeto is ICalculadora calc)
{
    // El objeto implementa ICalculadora
}
```

**En Resumen:**

- Define interfaces con nombres claros que empiecen con `I`
- Implementa todos los miembros requeridos
- Usa `public` para todos los miembros implementados
- La firma debe coincidir exactamente',
    'using System;

// ============================================
// DEFINIR INTERFACES
// ============================================

// Interface simple con un método
public interface IReproducible
{
    void Reproducir();
    void Detener();
}

// Interface con métodos y propiedades
public interface IReproductorMusica : IReproducible
{
    // Propiedades
    string CancionActual { get; }
    double Volumen { get; set; }
    bool EstaReproduciendo { get; }
    
    // Métodos
    void SeleccionarCancion(string cancion);
    void CambiarVolumen(double volumen);
}

// Interface con métodos de lectura y escritura
public interface IConfigurable
{
    string Nombre { get; set; }
    int Id { get; }
    void Configurar(string nombre, int id);
}

// ============================================
// IMPLEMENTAR INTERFACES
// ============================================

// Implementar una interfaz simple
public class ReproductorMP3 : IReproductorMusica
{
    private string cancionActual;
    private double volumen;
    private bool estaReproduciendo;
    
    public ReproductorMP3()
    {
        cancionActual = "";
        volumen = 50.0;
        estaReproduciendo = false;
    }
    
    // Implementar método de IReproducible
    public void Reproducir()
    {
        if (string.IsNullOrEmpty(cancionActual))
        {
            Console.WriteLine("No hay canción seleccionada");
            return;
        }
        estaReproduciendo = true;
        Console.WriteLine($"Reproduciendo: {cancionActual}");
    }
    
    // Implementar método de IReproducible
    public void Detener()
    {
        estaReproduciendo = false;
        Console.WriteLine("Reproducción detenida");
    }
    
    // Implementar propiedades de IReproductorMusica
    public string CancionActual => cancionActual;
    
    public double Volumen
    {
        get { return volumen; }
        set
        {
            if (value < 0) volumen = 0;
            else if (value > 100) volumen = 100;
            else volumen = value;
            Console.WriteLine($"Volumen ajustado a: {volumen}%");
        }
    }
    
    public bool EstaReproduciendo => estaReproduciendo;
    
    // Implementar métodos de IReproductorMusica
    public void SeleccionarCancion(string cancion)
    {
        cancionActual = cancion;
        Console.WriteLine($"Canción seleccionada: {cancion}");
    }
    
    public void CambiarVolumen(double volumen)
    {
        Volumen = volumen;
    }
}

// Otra implementación de la misma interfaz
public class ReproductorCD : IReproductorMusica
{
    private string cancionActual;
    private double volumen;
    private bool estaReproduciendo;
    
    public ReproductorCD()
    {
        cancionActual = "";
        volumen = 75.0;
        estaReproduciendo = false;
    }
    
    public void Reproducir()
    {
        if (string.IsNullOrEmpty(cancionActual))
        {
            Console.WriteLine("No hay CD insertado");
            return;
        }
        estaReproduciendo = true;
        Console.WriteLine($"Reproduciendo CD: {cancionActual}");
    }
    
    public void Detener()
    {
        estaReproduciendo = false;
        Console.WriteLine("CD detenido");
    }
    
    public string CancionActual => cancionActual;
    
    public double Volumen
    {
        get { return volumen; }
        set
        {
            volumen = Math.Clamp(value, 0, 100);
            Console.WriteLine($"Volumen del CD ajustado a: {volumen}%");
        }
    }
    
    public bool EstaReproduciendo => estaReproduciendo;
    
    public void SeleccionarCancion(string cancion)
    {
        cancionActual = cancion;
        Console.WriteLine($"Pista del CD seleccionada: {cancion}");
    }
    
    public void CambiarVolumen(double volumen)
    {
        Volumen = volumen;
    }
}

// Implementar múltiples interfaces
public class ReproductorAvanzado : IReproductorMusica, IConfigurable
{
    private string nombre;
    private int id;
    private string cancionActual;
    private double volumen;
    private bool estaReproduciendo;
    
    public ReproductorAvanzado(string nombre, int id)
    {
        this.nombre = nombre;
        this.id = id;
        cancionActual = "";
        volumen = 50.0;
        estaReproduciendo = false;
    }
    
    // Implementar IReproductorMusica
    public void Reproducir()
    {
        if (string.IsNullOrEmpty(cancionActual))
        {
            Console.WriteLine($"[{nombre}] No hay canción seleccionada");
            return;
        }
        estaReproduciendo = true;
        Console.WriteLine($"[{nombre}] Reproduciendo: {cancionActual}");
    }
    
    public void Detener()
    {
        estaReproduciendo = false;
        Console.WriteLine($"[{nombre}] Reproducción detenida");
    }
    
    public string CancionActual => cancionActual;
    
    public double Volumen
    {
        get { return volumen; }
        set { volumen = Math.Clamp(value, 0, 100); }
    }
    
    public bool EstaReproduciendo => estaReproduciendo;
    
    public void SeleccionarCancion(string cancion)
    {
        cancionActual = cancion;
    }
    
    public void CambiarVolumen(double volumen)
    {
        Volumen = volumen;
    }
    
    // Implementar IConfigurable
    public string Nombre
    {
        get { return nombre; }
        set { nombre = value; }
    }
    
    public int Id => id;
    
    public void Configurar(string nombre, int id)
    {
        this.nombre = nombre;
        this.id = id;
        Console.WriteLine($"Reproductor configurado: {nombre} (ID: {id})");
    }
}

class Program
{
    static void UsarReproductor(IReproductorMusica reproductor)
    {
        // Polimorfismo: trabajar con la interfaz
        reproductor.SeleccionarCancion("Canción Ejemplo");
        reproductor.CambiarVolumen(80);
        reproductor.Reproducir();
        Console.WriteLine($"Estado: Reproduciendo = {reproductor.EstaReproduciendo}");
        reproductor.Detener();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Definición e Implementación de Interfaces ===\n");
        
        // Crear objetos que implementan la misma interfaz
        ReproductorMP3 mp3 = new ReproductorMP3();
        ReproductorCD cd = new ReproductorCD();
        ReproductorAvanzado avanzado = new ReproductorAvanzado("Mi Reproductor", 1);
        
        Console.WriteLine("--- Usando ReproductorMP3 ---");
        UsarReproductor(mp3);
        
        Console.WriteLine("\n--- Usando ReproductorCD ---");
        UsarReproductor(cd);
        
        Console.WriteLine("\n--- Usando ReproductorAvanzado ---");
        UsarReproductor(avanzado);
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Múltiples Interfaces ===");
        
        IConfigurable configurable = avanzado;
        configurable.Configurar("Nuevo Nombre", 999);
        Console.WriteLine($"Nombre: {configurable.Nombre}, ID: {configurable.Id}");
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo ===");
        
        IReproductorMusica[] reproductores = new IReproductorMusica[]
        {
            new ReproductorMP3(),
            new ReproductorCD(),
            new ReproductorAvanzado("Reproductor 1", 1)
        };
        
        foreach (IReproductorMusica reproductor in reproductores)
        {
            Console.WriteLine($"\nTipo: {reproductor.GetType().Name}");
            reproductor.SeleccionarCancion("Mi Canción Favorita");
            reproductor.Reproducir();
        }
        
        Console.WriteLine("\n=== VERIFICACIÓN DE IMPLEMENTACIÓN ===");
        
        object obj = new ReproductorMP3();
        if (obj is IReproductorMusica reproductor)
        {
            Console.WriteLine("El objeto implementa IReproductorMusica");
            reproductor.Reproducir();
        }
        
        Console.WriteLine("\n=== CARACTERÍSTICAS ===");
        Console.WriteLine("- Interfaces definen contratos claros");
        Console.WriteLine("- Las clases DEBEN implementar todos los miembros");
        Console.WriteLine("- Múltiples clases pueden implementar la misma interfaz");
        Console.WriteLine("- Una clase puede implementar múltiples interfaces");
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Múltiples Interfaces
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Múltiples Interfaces',
    'Aprende a implementar múltiples interfaces en una sola clase, una de las ventajas clave de las interfaces sobre las clases abstractas.',
    'Una de las ventajas más importantes de las interfaces es que una clase puede implementar **múltiples interfaces** al mismo tiempo. Esto permite que una clase tenga múltiples capacidades o contratos.

**Implementar Múltiples Interfaces:**

```csharp
public interface IInterface1
{
    void Metodo1();
}

public interface IInterface2
{
    void Metodo2();
}

// Una clase puede implementar múltiples interfaces
public class MiClase : IInterface1, IInterface2
{
    public void Metodo1() { }
    public void Metodo2() { }
}
```

**Sintaxis:**

```csharp
public class Clase : IInterface1, IInterface2, IInterface3
{
    // DEBE implementar todos los miembros de todas las interfaces
}
```

**Ventajas de Múltiples Interfaces:**

1. **Flexibilidad**: Una clase puede tener múltiples capacidades
2. **Reutilización**: Interfaces pequeñas y específicas
3. **Composición**: Construir funcionalidad combinando interfaces
4. **Segregación**: Interfaces específicas en lugar de una grande

**Cuándo Usar Múltiples Interfaces:**

✅ **Usa múltiples interfaces cuando:**
- Una clase necesita múltiples capacidades
- Las capacidades son independientes
- Quieres composición en lugar de herencia
- Sigues el principio de segregación de interfaces

**Ejemplo Práctico:**

```csharp
public interface IVolador { void Volar(); }
public interface INadador { void Nadar(); }
public interface ICaminante { void Caminar(); }

// Un pato puede volar, nadar y caminar
public class Pato : IVolador, INadador, ICaminante
{
    public void Volar() { }
    public void Nadar() { }
    public void Caminar() { }
}
```

**En Resumen:**

Las interfaces permiten que una clase implemente múltiples contratos, proporcionando máxima flexibilidad y permitiendo composición de capacidades.',
    'using System;

// Definir múltiples interfaces pequeñas y específicas
public interface IVolador
{
    void Volar();
}

public interface INadador
{
    void Nadar();
}

public interface ICaminante
{
    void Caminar();
}

public interface IReproductor
{
    void Reproducir();
    void Detener();
}

// Clase que implementa UNA interfaz
public class Avion : IVolador
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
    
    public void Aterrizar()
    {
        Console.WriteLine($"Avión {modelo} está aterrizando");
    }
}

// Clase que implementa MÚLTIPLES interfaces
public class Pato : IVolador, INadador, ICaminante
{
    private string nombre;
    
    public Pato(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Implementar IVolador
    public void Volar()
    {
        Console.WriteLine($"{nombre} está volando");
    }
    
    // Implementar INadador
    public void Nadar()
    {
        Console.WriteLine($"{nombre} está nadando");
    }
    
    // Implementar ICaminante
    public void Caminar()
    {
        Console.WriteLine($"{nombre} está caminando");
    }
}

// Otra clase con múltiples interfaces
public class Barco : INadador, IReproductor
{
    private string nombre;
    private bool reproduciendoMusica;
    
    public Barco(string nombre)
    {
        this.nombre = nombre;
        reproduciendoMusica = false;
    }
    
    // Implementar INadador
    public void Nadar()
    {
        Console.WriteLine($"Barco {nombre} está navegando");
    }
    
    // Implementar IReproductor
    public void Reproducir()
    {
        reproduciendoMusica = true;
        Console.WriteLine($"Barco {nombre} está reproduciendo música");
    }
    
    public void Detener()
    {
        reproduciendoMusica = false;
        Console.WriteLine($"Barco {nombre} detuvo la música");
    }
}

// Clase que implementa TODAS las interfaces (máxima flexibilidad)
public class SuperHeroe : IVolador, INadador, ICaminante, IReproductor
{
    private string nombre;
    private bool reproduciendoMusica;
    
    public SuperHeroe(string nombre)
    {
        this.nombre = nombre;
        reproduciendoMusica = false;
    }
    
    public void Volar()
    {
        Console.WriteLine($"{nombre} está volando como superhéroe");
    }
    
    public void Nadar()
    {
        Console.WriteLine($"{nombre} está nadando como superhéroe");
    }
    
    public void Caminar()
    {
        Console.WriteLine($"{nombre} está caminando como superhéroe");
    }
    
    public void Reproducir()
    {
        reproduciendoMusica = true;
        Console.WriteLine($"{nombre} está reproduciendo música épica");
    }
    
    public void Detener()
    {
        reproduciendoMusica = false;
        Console.WriteLine($"{nombre} detuvo la música");
    }
}

class Program
{
    static void HacerVolar(IVolador volador)
    {
        volador.Volar();
    }
    
    static void HacerNadar(INadador nadador)
    {
        nadador.Nadar();
    }
    
    static void HacerCaminar(ICaminante caminante)
    {
        caminante.Caminar();
    }
    
    static void UsarReproductor(IReproductor reproductor)
    {
        reproductor.Reproducir();
        reproductor.Detener();
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Múltiples Interfaces ===\n");
        
        // Crear objetos
        Avion avion = new Avion("Boeing 747");
        Pato pato = new Pato("Donald");
        Barco barco = new Barco("Titanic");
        SuperHeroe heroe = new SuperHeroe("Superman");
        
        Console.WriteLine("--- Avión (solo vuela) ---");
        HacerVolar(avion);
        // HacerNadar(avion); // ERROR: Avion no implementa INadador
        
        Console.WriteLine("\n--- Pato (vuela, nada y camina) ---");
        HacerVolar(pato);
        HacerNadar(pato);
        HacerCaminar(pato);
        
        Console.WriteLine("\n--- Barco (nada y reproduce música) ---");
        HacerNadar(barco);
        UsarReproductor(barco);
        
        Console.WriteLine("\n--- SuperHéroe (todo) ---");
        HacerVolar(heroe);
        HacerNadar(heroe);
        HacerCaminar(heroe);
        UsarReproductor(heroe);
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo con Interfaces ===");
        
        // Array de objetos que vuelan
        IVolador[] voladores = new IVolador[]
        {
            new Avion("Jet"),
            new Pato("Pato Volador"),
            new SuperHeroe("Iron Man")
        };
        
        foreach (IVolador v in voladores)
        {
            Console.WriteLine($"Tipo: {v.GetType().Name}");
            HacerVolar(v);
        }
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Verificar Implementación ===");
        
        Pato otroPato = new Pato("Otro Pato");
        
        // Verificar si implementa una interfaz
        if (otroPato is IVolador volador)
        {
            Console.WriteLine("El pato puede volar");
            volador.Volar();
        }
        
        if (otroPato is INadador nadador)
        {
            Console.WriteLine("El pato puede nadar");
            nadador.Nadar();
        }
        
        if (otroPato is ICaminante caminante)
        {
            Console.WriteLine("El pato puede caminar");
            caminante.Caminar();
        }
        
        Console.WriteLine("\n=== VENTAJAS DE MÚLTIPLES INTERFACES ===");
        Console.WriteLine("- Máxima flexibilidad");
        Console.WriteLine("- Interfaces pequeñas y específicas");
        Console.WriteLine("- Composición de capacidades");
        Console.WriteLine("- Principio de segregación de interfaces");
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Interfaces vs Clases Abstractas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Interfaces vs Clases Abstractas',
    'Comprende las diferencias clave entre interfaces y clases abstractas, y cuándo usar cada una.',
    'Las **interfaces** y las **clases abstractas** son mecanismos similares pero diferentes en C#. Entender sus diferencias es crucial para elegir la herramienta correcta.

**Diferencias Principales:**

| Característica | Interface | Clase Abstracta |
|----------------|-----------|-----------------|
| **Implementación** | Solo firmas (antes de C# 8.0) | Métodos abstractos y concretos |
| **Herencia Múltiple** | ✅ Sí | ❌ No (solo una clase base) |
| **Campos** | ❌ No (antes de C# 8.0) | ✅ Sí (puede tener campos) |
| **Constructores** | ❌ No | ✅ Sí (puede tener constructores) |
| **Modificadores de Acceso** | Públicos por defecto | Private, protected, etc. |
| **Instanciación** | ❌ No se puede instanciar | ❌ No se puede instanciar |
| **Propósito** | Contrato puro | Código común + contrato |

**Cuándo Usar Interface:**

✅ **Usa Interface cuando:**
- Solo necesitas definir un **contrato**
- Una clase necesita implementar **múltiples contratos**
- Las clases no están relacionadas (no hay relación "es un")
- Quieres **máximo desacoplamiento**
- Necesitas **flexibilidad máxima**

**Cuándo Usar Clase Abstracta:**

✅ **Usa Clase Abstracta cuando:**
- Hay una relación clara **"es un"**
- Necesitas **compartir código común**
- Necesitas **campos** o **constructores**
- Las clases derivadas comparten **estructura común**
- Quieres proporcionar **implementación por defecto**

**Ejemplo Comparativo:**

**Interface (máxima flexibilidad):**
```csharp
public interface IVolador
{
    void Volar();
}

// Múltiples clases no relacionadas pueden implementarla
public class Avion : IVolador { }
public class Pajaro : IVolador { }
public class Cohete : IVolador { }
```

**Clase Abstracta (código común):**
```csharp
public abstract class Animal
{
    protected string nombre;  // Campo
    public Animal(string nombre) { }  // Constructor
    public void Comer() { }  // Código común
    public abstract void HacerSonido();  // Contrato
}
```

**Puedes Combinar Ambos:**

```csharp
public abstract class Animal { }
public interface IVolador { }
public interface INadador { }

// Hereda de clase abstracta E implementa interfaces
public class Pato : Animal, IVolador, INadador { }
```

**En Resumen:**

- **Interface**: Para contratos y flexibilidad máxima
- **Clase Abstracta**: Para código común y relaciones "es un"
- **Ambos**: Útiles en diferentes situaciones',
    'using System;

// ============================================
// EJEMPLO: INTERFACE (Contrato puro)
// ============================================

// Interface: solo contrato, sin implementación
public interface IVolador
{
    void Volar();
}

public interface INadador
{
    void Nadar();
}

// Clases NO relacionadas pueden implementar la misma interfaz
public class Avion : IVolador
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
    
    public void Aterrizar()
    {
        Console.WriteLine($"Avión {modelo} está aterrizando");
    }
}

public class Pajaro : IVolador
{
    private string especie;
    
    public Pajaro(string especie)
    {
        this.especie = especie;
    }
    
    public void Volar()
    {
        Console.WriteLine($"{especie} está volando");
    }
    
    public void Anidar()
    {
        Console.WriteLine($"{especie} está anidando");
    }
}

// ============================================
// EJEMPLO: CLASE ABSTRACTA (Código común)
// ============================================

// Clase abstracta: código común + contrato
public abstract class Animal
{
    // Campos: solo en clases abstractas/concretas
    protected string nombre;
    protected int edad;
    
    // Constructor: solo en clases abstractas/concretas
    public Animal(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
    }
    
    // Método concreto: implementación común
    public void Comer()
    {
        Console.WriteLine($"{nombre} está comiendo");
    }
    
    public void Dormir()
    {
        Console.WriteLine($"{nombre} está durmiendo");
    }
    
    // Método abstracto: DEBE ser implementado
    public abstract void HacerSonido();
    
    // Método virtual: puede ser sobrescrito
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Animal: {nombre}, Edad: {edad} años");
    }
}

// Clases relacionadas ("es un" Animal) heredan de clase abstracta
public class Perro : Animal
{
    private string raza;
    
    public Perro(string nombre, int edad, string raza) 
        : base(nombre, edad)
    {
        this.raza = raza;
    }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} ladra: ¡Guau!");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Raza: {raza}");
    }
}

public class Gato : Animal
{
    public Gato(string nombre, int edad) : base(nombre, edad) { }
    
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} maúlla: ¡Miau!");
    }
}

// ============================================
// EJEMPLO: COMBINACIÓN (Hereda + Implementa)
// ============================================

// Clase que hereda de abstracta E implementa interfaces
public class Pato : Animal, IVolador, INadador
{
    public Pato(string nombre, int edad) : base(nombre, edad) { }
    
    // Implementar método abstracto de Animal
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

class Program
{
    static void HacerVolar(IVolador volador)
    {
        // Polimorfismo con interface
        volador.Volar();
    }
    
    static void ProcesarAnimal(Animal animal)
    {
        // Polimorfismo con clase abstracta
        animal.MostrarInformacion();
        animal.Comer();  // Método común
        animal.HacerSonido();  // Método abstracto (implementado)
        animal.Dormir();  // Método común
    }
    
    static void Main()
    {
        Console.WriteLine("=== INTERFACE: Contrato Puro ===\n");
        
        // Clases NO relacionadas implementan la misma interfaz
        IVolador avion = new Avion("Boeing 747");
        IVolador pajaro = new Pajaro("Águila");
        
        HacerVolar(avion);
        HacerVolar(pajaro);
        
        Console.WriteLine("\n=== CLASE ABSTRACTA: Código Común ===\n");
        
        // Clases relacionadas heredan de clase abstracta
        Animal perro = new Perro("Max", 5, "Labrador");
        Animal gato = new Gato("Luna", 3);
        
        ProcesarAnimal(perro);
        Console.WriteLine();
        ProcesarAnimal(gato);
        
        Console.WriteLine("\n=== COMBINACIÓN: Hereda + Implementa ===\n");
        
        Pato pato = new Pato("Donald", 2);
        
        // Puede tratarse como Animal (clase abstracta)
        Animal animal = pato;
        ProcesarAnimal(animal);
        
        // Puede tratarse como IVolador (interface)
        IVolador volador = pato;
        HacerVolar(volador);
        
        // Puede tratarse como INadador (interface)
        INadador nadador = pato;
        nadador.Nadar();
        
        Console.WriteLine("\n=== DIFERENCIAS CLAVE ===\n");
        Console.WriteLine("INTERFACE:");
        Console.WriteLine("  ✅ Herencia múltiple");
        Console.WriteLine("  ✅ Solo contrato (sin implementación)");
        Console.WriteLine("  ✅ Máxima flexibilidad");
        Console.WriteLine("  ❌ No campos ni constructores");
        Console.WriteLine();
        Console.WriteLine("CLASE ABSTRACTA:");
        Console.WriteLine("  ✅ Código común compartido");
        Console.WriteLine("  ✅ Campos y constructores");
        Console.WriteLine("  ✅ Relación es un clara");
        Console.WriteLine("  ❌ Solo una clase base");
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Propiedades en Interfaces
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Propiedades en Interfaces',
    'Aprende a definir propiedades en interfaces y a implementarlas correctamente en tus clases.',
    'Las **propiedades** pueden ser definidas en interfaces. Al igual que los métodos, las propiedades en interfaces solo definen el contrato (get/set) sin implementación.

**Propiedades en Interfaces:**

```csharp
public interface IInterface
{
    // Propiedad de lectura/escritura
    string Nombre { get; set; }
    
    // Propiedad de solo lectura
    int Id { get; }
    
    // Propiedad de solo escritura
    string Clave { set; }
}
```

**Tipos de Propiedades en Interfaces:**

1. **Lectura/Escritura**: `string Nombre { get; set; }`
2. **Solo Lectura**: `int Id { get; }`
3. **Solo Escritura**: `string Clave { set; }`

**Implementar Propiedades:**

```csharp
public class MiClase : IInterface
{
    private string nombre;
    private int id;
    
    // Implementar propiedad lectura/escritura
    public string Nombre
    {
        get { return nombre; }
        set { nombre = value; }
    }
    
    // Implementar propiedad solo lectura
    public int Id => id;
    
    // Implementar propiedad solo escritura
    public string Clave { set { /* guardar */ } }
}
```

**Ventajas:**

- **Contrato Claro**: Define qué propiedades debe tener una clase
- **Flexibilidad**: Cada implementación puede manejarlas diferente
- **Validación**: Puedes agregar validación en las implementaciones

**Ejemplo Práctico:**

```csharp
public interface IProducto
{
    string Nombre { get; set; }
    double Precio { get; set; }
    int Stock { get; }
}
```',
    'using System;

// Interface con propiedades
public interface IProducto
{
    // Propiedad de lectura/escritura
    string Nombre { get; set; }
    
    // Propiedad de lectura/escritura
    double Precio { get; set; }
    
    // Propiedad de solo lectura
    int Stock { get; }
    
    // Propiedad calculada (solo lectura)
    double ValorTotal { get; }
    
    // Método
    void ActualizarStock(int cantidad);
}

// Implementar interface con propiedades
public class ProductoSimple : IProducto
{
    private string nombre;
    private double precio;
    private int stock;
    
    // Implementar propiedad Nombre
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
    
    // Implementar propiedad Precio
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
    
    // Implementar propiedad Stock (solo lectura)
    public int Stock => stock;
    
    // Implementar propiedad ValorTotal (calculada)
    public double ValorTotal => precio * stock;
    
    public ProductoSimple(string nombre, double precio, int stock)
    {
        Nombre = nombre;
        Precio = precio;
        this.stock = stock;
    }
    
    public void ActualizarStock(int cantidad)
    {
        if (stock + cantidad < 0)
            throw new InvalidOperationException("Stock insuficiente");
        stock += cantidad;
    }
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Producto: {Nombre}");
        Console.WriteLine($"Precio: ${Precio:F2}");
        Console.WriteLine($"Stock: {Stock} unidades");
        Console.WriteLine($"Valor Total: ${ValorTotal:F2}");
    }
}

// Otra implementación
public class ProductoDigital : IProducto
{
    private string nombre;
    private double precio;
    private int descargasDisponibles;
    
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
    
    // Para producto digital, stock es infinito
    public int Stock => int.MaxValue;
    
    public double ValorTotal => precio;  // Un solo precio
    
    public ProductoDigital(string nombre, double precio, int descargas)
    {
        Nombre = nombre;
        Precio = precio;
        descargasDisponibles = descargas;
    }
    
    public void ActualizarStock(int cantidad)
    {
        if (descargasDisponibles + cantidad < 0)
            throw new InvalidOperationException("No hay descargas disponibles");
        descargasDisponibles += cantidad;
    }
    
    public int DescargasDisponibles => descargasDisponibles;
    
    public void MostrarInformacion()
    {
        Console.WriteLine($"Producto Digital: {Nombre}");
        Console.WriteLine($"Precio: ${Precio:F2}");
        Console.WriteLine($"Stock: Infinito");
        Console.WriteLine($"Descargas disponibles: {DescargasDisponibles}");
        Console.WriteLine($"Valor Total: ${ValorTotal:F2}");
    }
}

// Interface con propiedad solo escritura
public interface IConfigurable
{
    string Clave { set; }
    void Configurar(string clave);
}

public class SistemaConfigurable : IConfigurable
{
    private string claveInterna;
    
    // Implementar propiedad solo escritura
    public string Clave
    {
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("La clave no puede estar vacía");
            claveInterna = value;
            Console.WriteLine("Clave configurada exitosamente");
        }
    }
    
    public void Configurar(string clave)
    {
        Clave = clave;
    }
    
    // Método para verificar la clave (no parte de la interfaz)
    public bool VerificarClave(string clave)
    {
        return claveInterna == clave;
    }
}

class Program
{
    static void ProcesarProducto(IProducto producto)
    {
        // Polimorfismo: trabajar con la interfaz
        Console.WriteLine($"\n--- Procesando {producto.Nombre} ---");
        Console.WriteLine($"Precio: ${producto.Precio:F2}");
        Console.WriteLine($"Stock: {producto.Stock}");
        Console.WriteLine($"Valor Total: ${producto.ValorTotal:F2}");
        
        // Actualizar stock
        try
        {
            producto.ActualizarStock(-1);
            Console.WriteLine($"Stock después de vender 1 unidad: {producto.Stock}");
        }
        catch (InvalidOperationException e)
        {
            Console.WriteLine($"Error: {e.Message}");
        }
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Propiedades en Interfaces ===\n");
        
        try
        {
            ProductoSimple producto1 = new ProductoSimple("Laptop", 999.99, 10);
            producto1.MostrarInformacion();
            
            Console.WriteLine();
            
            ProductoDigital producto2 = new ProductoDigital("Software", 49.99, 100);
            producto2.MostrarInformacion();
            
            Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo con Propiedades ===");
            
            IProducto[] productos = new IProducto[]
            {
                new ProductoSimple("Mouse", 25.50, 50),
                new ProductoDigital("Ebook", 9.99, 1000),
                new ProductoSimple("Teclado", 75.00, 30)
            };
            
            foreach (IProducto p in productos)
            {
                ProcesarProducto(p);
            }
            
            Console.WriteLine("\n=== DEMOSTRACIÓN: Propiedad Solo Escritura ===");
            
            IConfigurable sistema = new SistemaConfigurable();
            sistema.Configurar("MiClaveSecreta");
            
            SistemaConfigurable configurable = sistema as SistemaConfigurable;
            if (configurable != null)
            {
                bool esValida = configurable.VerificarClave("MiClaveSecreta");
                Console.WriteLine($"Clave verificada: {esValida}");
            }
        }
        catch (ArgumentException e)
        {
            Console.WriteLine($"Error de validación: {e.Message}");
        }
        
        Console.WriteLine("\n=== CARACTERÍSTICAS DE PROPIEDADES EN INTERFACES ===");
        Console.WriteLine("- Pueden ser lectura/escritura, solo lectura o solo escritura");
        Console.WriteLine("- Cada implementación puede manejarlas diferente");
        Console.WriteLine("- Permiten validación en las implementaciones");
        Console.WriteLine("- Facilitan polimorfismo");
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Métodos por Defecto en Interfaces (C# 8.0+)
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Métodos por Defecto en Interfaces',
    'Aprende a usar métodos por defecto en interfaces, una característica introducida en C# 8.0.',
    'Desde **C# 8.0**, las interfaces pueden tener **métodos con implementación por defecto**. Esto permite agregar nuevos miembros a interfaces existentes sin romper las implementaciones existentes.

**¿Qué son los Métodos por Defecto?**

Los métodos por defecto son métodos en interfaces que tienen **implementación**. Esto permite:
- Agregar nuevos miembros sin romper código existente
- Proporcionar implementación común
- Mantener compatibilidad hacia atrás

**Sintaxis:**

```csharp
public interface IInterface
{
    // Método sin implementación (tradicional)
    void MetodoAbstracto();
    
    // Método con implementación por defecto (C# 8.0+)
    void MetodoPorDefecto()
    {
        // Implementación por defecto
    }
}
```

**Implementar:**

```csharp
public class MiClase : IInterface
{
    // DEBE implementar el método abstracto
    public void MetodoAbstracto() { }
    
    // Puede usar el método por defecto O sobrescribirlo
    // public void MetodoPorDefecto() { }  // Opcional
}
```

**Ventajas:**

- **Compatibilidad**: Agregar métodos sin romper implementaciones existentes
- **Reutilización**: Implementación común en la interfaz
- **Flexibilidad**: Las clases pueden usar o sobrescribir la implementación

**Cuándo Usar:**

- Cuando necesitas agregar miembros a interfaces existentes
- Para proporcionar implementación común
- Cuando quieres compatibilidad hacia atrás

**Ejemplo Práctico:**

```csharp
public interface ICalculadora
{
    int Sumar(int a, int b) => a + b;  // Por defecto
    int Restar(int a, int b);  // Abstracto
}
```',
    'using System;

// Interface con métodos por defecto (C# 8.0+)
public interface IReproductor
{
    // Métodos abstractos (tradicionales)
    void Reproducir();
    void Detener();
    
    // Método con implementación por defecto
    void Pausar()
    {
        Detener();  // Implementación por defecto usando otro método de la interfaz
        Console.WriteLine("Reproducción pausada");
    }
    
    // Otro método por defecto
    void Siguiente()
    {
        Detener();
        Console.WriteLine("Reproduciendo siguiente canción");
        Reproducir();
    }
    
    // Método por defecto con lógica más compleja
    void ReproducirEnBucle()
    {
        for (int i = 0; i < 3; i++)
        {
            Reproducir();
            Console.WriteLine($"Repetición {i + 1}");
            Detener();
        }
    }
    
    // Propiedad con implementación por defecto
    bool EstaReproduciendo { get; }
    
    // Método por defecto que usa propiedades
    void MostrarEstado()
    {
        string estado = EstaReproduciendo ? "Reproduciendo" : "Detenido";
        Console.WriteLine($"Estado: {estado}");
    }
}

// Implementación que usa métodos por defecto
public class ReproductorSimple : IReproductor
{
    private bool estaReproduciendo;
    
    public ReproductorSimple()
    {
        estaReproduciendo = false;
    }
    
    // DEBE implementar métodos abstractos
    public void Reproducir()
    {
        estaReproduciendo = true;
        Console.WriteLine("Reproduciendo música");
    }
    
    public void Detener()
    {
        estaReproduciendo = false;
        Console.WriteLine("Reproducción detenida");
    }
    
    // Usa métodos por defecto de la interfaz
    // No necesita implementar Pausar(), Siguiente(), etc.
    
    public bool EstaReproduciendo => estaReproduciendo;
}

// Implementación que sobrescribe métodos por defecto
public class ReproductorAvanzado : IReproductor
{
    private bool estaReproduciendo;
    private string cancionActual;
    
    public ReproductorAvanzado()
    {
        estaReproduciendo = false;
        cancionActual = "";
    }
    
    public void Reproducir()
    {
        if (string.IsNullOrEmpty(cancionActual))
        {
            Console.WriteLine("No hay canción seleccionada");
            return;
        }
        estaReproduciendo = true;
        Console.WriteLine($"Reproduciendo: {cancionActual}");
    }
    
    public void Detener()
    {
        estaReproduciendo = false;
        Console.WriteLine("Reproducción detenida");
    }
    
    // SOBRESCRIBE el método por defecto
    public void Pausar()
    {
        if (estaReproduciendo)
        {
            estaReproduciendo = false;
            Console.WriteLine($"Pausando: {cancionActual}");
        }
        else
        {
            Console.WriteLine("No hay reproducción activa para pausar");
        }
    }
    
    // SOBRESCRIBE otro método por defecto
    public void Siguiente()
    {
        Console.WriteLine("Siguiente canción...");
        Detener();
        cancionActual = "Nueva Canción";
        Reproducir();
    }
    
    public bool EstaReproduciendo => estaReproduciendo;
    
    public void SeleccionarCancion(string cancion)
    {
        cancionActual = cancion;
    }
}

// Interface que extiende otra (herencia de interfaces)
public interface IReproductorMejorado : IReproductor
{
    // Nuevo método abstracto
    void CambiarVolumen(double volumen);
    
    // Nuevo método por defecto
    void SubirVolumen()
    {
        CambiarVolumen(10);  // Aumenta en 10
    }
    
    void BajarVolumen()
    {
        CambiarVolumen(-10);  // Disminuye en 10
    }
}

// Implementar interface extendida
public class ReproductorConVolumen : IReproductorMejorado
{
    private bool estaReproduciendo;
    private double volumen;
    
    public ReproductorConVolumen()
    {
        estaReproduciendo = false;
        volumen = 50.0;
    }
    
    // Implementar métodos de IReproductor
    public void Reproducir()
    {
        estaReproduciendo = true;
        Console.WriteLine($"Reproduciendo a volumen {volumen}%");
    }
    
    public void Detener()
    {
        estaReproduciendo = false;
        Console.WriteLine("Reproducción detenida");
    }
    
    public bool EstaReproduciendo => estaReproduciendo;
    
    // Implementar método de IReproductorMejorado
    public void CambiarVolumen(double volumen)
    {
        this.volumen = Math.Clamp(this.volumen + volumen, 0, 100);
        Console.WriteLine($"Volumen ajustado a: {this.volumen}%");
    }
    
    // Usa métodos por defecto de IReproductorMejorado (SubirVolumen, BajarVolumen)
}

class Program
{
    static void UsarReproductor(IReproductor reproductor)
    {
        reproductor.Reproducir();
        reproductor.MostrarEstado();  // Método por defecto
        
        reproductor.Pausar();  // Método por defecto
        reproductor.MostrarEstado();
        
        reproductor.Reproducir();
        reproductor.Siguiente();  // Método por defecto
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Métodos por Defecto en Interfaces ===\n");
        
        Console.WriteLine("--- ReproductorSimple (usa métodos por defecto) ---");
        IReproductor simple = new ReproductorSimple();
        UsarReproductor(simple);
        
        Console.WriteLine("\n--- ReproductorAvanzado (sobrescribe métodos) ---");
        ReproductorAvanzado avanzado = new ReproductorAvanzado();
        avanzado.SeleccionarCancion("Mi Canción Favorita");
        UsarReproductor(avanzado);
        
        Console.WriteLine("\n--- ReproductorConVolumen (interface extendida) ---");
        IReproductorMejorado conVolumen = new ReproductorConVolumen();
        conVolumen.Reproducir();
        conVolumen.SubirVolumen();  // Método por defecto
        conVolumen.BajarVolumen();  // Método por defecto
        conVolumen.MostrarEstado();  // Método por defecto de IReproductor
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Repetición ===");
        simple.ReproducirEnBucle();  // Método por defecto con lógica compleja
        
        Console.WriteLine("\n=== VENTAJAS DE MÉTODOS POR DEFECTO ===");
        Console.WriteLine("- Compatibilidad hacia atrás");
        Console.WriteLine("- Implementación común");
        Console.WriteLine("- Flexibilidad (usar o sobrescribir)");
        Console.WriteLine("- Herencia de interfaces");
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Interfaces Implícitas y Explícitas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Interfaces Implícitas y Explícitas',
    'Aprende la diferencia entre implementación implícita y explícita de interfaces, y cuándo usar cada una.',
    'En C#, puedes implementar interfaces de dos maneras: **implícitamente** (la forma normal) o **explícitamente** (usando el nombre completo de la interfaz).

**Implementación Implícita:**

La forma normal y más común:

```csharp
public interface IInterface
{
    void Metodo();
}

public class Clase : IInterface
{
    // Implementación implícita: método público normal
    public void Metodo() { }
}

// Uso normal
Clase obj = new Clase();
obj.Metodo();
```

**Implementación Explícita:**

Cuando usas el nombre completo de la interfaz:

```csharp
public class Clase : IInterface
{
    // Implementación explícita: nombre completo de la interfaz
    void IInterface.Metodo() { }
}

// Debe tratarse como la interfaz
IInterface obj = new Clase();
obj.Metodo();
// obj.Metodo(); // ERROR si obj es de tipo Clase
```

**Cuándo Usar Implementación Explícita:**

✅ **Usa implementación explícita cuando:**
- Una clase implementa **múltiples interfaces** con métodos del mismo nombre
- Quieres **ocultar** la implementación de la clase
- Quieres forzar que se use la interfaz para acceder al método
- Hay **conflictos de nombres** entre interfaces

**Ventajas de Implementación Explícita:**

1. **Resuelve Conflictos**: Permite implementar múltiples interfaces con métodos del mismo nombre
2. **Ocultación**: Oculta la implementación de la clase concreta
3. **Claridad**: Deja claro qué interfaz se está implementando
4. **Control**: Fuerza el uso de la interfaz

**Ejemplo Práctico:**

```csharp
public interface IA { void Metodo(); }
public interface IB { void Metodo(); }

public class Clase : IA, IB
{
    void IA.Metodo() { }  // Para IA
    void IB.Metodo() { }  // Para IB
}
```

**En Resumen:**

- **Implícita**: Método público normal, accesible desde la clase
- **Explícita**: Usa nombre completo, solo accesible vía interfaz
- **Útil para**: Resolver conflictos de nombres entre interfaces',
    'using System;

// Definir múltiples interfaces con métodos del mismo nombre
public interface ISaludar
{
    void Saludar();
}

public interface IDespedir
{
    void Saludar();  // Mismo nombre que ISaludar
}

public interface IReproducir
{
    void Reproducir();
}

public interface IDetener
{
    void Reproducir();  // Mismo nombre que IReproducir
}

// ============================================
// IMPLEMENTACIÓN IMPLÍCITA (Normal)
// ============================================

public class ReproductorSimple : IReproducir
{
    // Implementación implícita: método público normal
    public void Reproducir()
    {
        Console.WriteLine("Reproduciendo música");
    }
    
    // Puede ser llamado directamente desde la clase
    public void Detener()
    {
        Console.WriteLine("Deteniendo");
    }
}

// ============================================
// IMPLEMENTACIÓN EXPLÍCITA (Resolver conflictos)
// ============================================

public class Persona : ISaludar, IDespedir
{
    private string nombre;
    
    public Persona(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Implementación explícita para ISaludar
    void ISaludar.Saludar()
    {
        Console.WriteLine($"{nombre} dice: ¡Hola!");
    }
    
    // Implementación explícita para IDespedir
    void IDespedir.Saludar()
    {
        Console.WriteLine($"{nombre} dice: ¡Adiós!");
    }
    
    // Método propio de la clase (diferente nombre)
    public void Presentarse()
    {
        Console.WriteLine($"{nombre} se presenta");
    }
}

// Clase con múltiples interfaces con conflictos
public class ReproductorAvanzado : IReproducir, IDetener
{
    private string nombre;
    
    public ReproductorAvanzado(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Implementación explícita para IReproducir
    void IReproducir.Reproducir()
    {
        Console.WriteLine($"[{nombre}] Iniciando reproducción");
    }
    
    // Implementación explícita para IDetener
    void IDetener.Reproducir()  // Nota: método Reproducir pero actúa como Detener
    {
        Console.WriteLine($"[{nombre}] Deteniendo reproducción");
    }
    
    // Método propio sin conflicto
    public void MostrarEstado()
    {
        Console.WriteLine($"[{nombre}] Estado: Activo");
    }
}

// Clase que combina implícita y explícita
public class ReproductorHibrido : IReproducir, IDetener
{
    private string nombre;
    
    public ReproductorHibrido(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Implementación implícita: accesible directamente
    public void Reproducir()
    {
        Console.WriteLine($"[{nombre}] Reproduciendo");
    }
    
    // Implementación explícita: solo accesible vía interfaz
    void IDetener.Reproducir()
    {
        Console.WriteLine($"[{nombre}] Deteniendo (vía IDetener)");
    }
}

class Program
{
    static void ProcesarSaludo(ISaludar saludar)
    {
        saludar.Saludar();
    }
    
    static void ProcesarDespedida(IDespedir despedir)
    {
        despedir.Saludar();  // Mismo método pero diferente comportamiento
    }
    
    static void UsarReproducir(IReproducir reproducir)
    {
        reproducir.Reproducir();
    }
    
    static void UsarDetener(IDetener detener)
    {
        detener.Reproducir();  // Método Reproducir pero actúa como Detener
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Implementación Implícita ===\n");
        
        ReproductorSimple simple = new ReproductorSimple();
        simple.Reproducir();  // Accesible directamente
        simple.Detener();     // Método propio
        
        IReproducir reproducir = simple;
        reproducir.Reproducir();  // También accesible vía interfaz
        
        Console.WriteLine("\n=== EJEMPLO: Implementación Explícita (Conflictos) ===\n");
        
        Persona persona = new Persona("Juan");
        
        // ERROR: No se puede llamar directamente
        // persona.Saludar();  // No existe en Persona
        
        // Debe tratarse como la interfaz específica
        ISaludar saludar = persona;
        saludar.Saludar();  // Implementación de ISaludar
        
        IDespedir despedir = persona;
        despedir.Saludar();  // Implementación de IDespedir (comportamiento diferente)
        
        persona.Presentarse();  // Método propio sin conflicto
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Métodos con Mismo Nombre ===\n");
        
        Persona otraPersona = new Persona("María");
        ProcesarSaludo(otraPersona);
        ProcesarDespedida(otraPersona);
        
        Console.WriteLine("\n=== EJEMPLO: Múltiples Interfaces con Conflicto ===\n");
        
        ReproductorAvanzado avanzado = new ReproductorAvanzado("Reproductor 1");
        
        // Debe tratarse como la interfaz específica
        IReproducir repro = avanzado;
        repro.Reproducir();  // Implementación de IReproducir
        
        IDetener detener = avanzado;
        detener.Reproducir();  // Implementación de IDetener (comportamiento diferente)
        
        avanzado.MostrarEstado();  // Método propio
        
        Console.WriteLine("\n=== EJEMPLO: Implícita + Explícita ===\n");
        
        ReproductorHibrido hibrido = new ReproductorHibrido("Híbrido");
        
        // Implementación implícita: accesible directamente
        hibrido.Reproducir();
        
        // Implementación explícita: solo vía interfaz
        IDetener detenerHibrido = hibrido;
        detenerHibrido.Reproducir();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo ===\n");
        
        IReproducir[] reproductores = new IReproducir[]
        {
            new ReproductorSimple(),
            new ReproductorAvanzado("Reproductor 2"),
            new ReproductorHibrido("Híbrido 2")
        };
        
        foreach (IReproducir r in reproductores)
        {
            r.Reproducir();
        }
        
        Console.WriteLine("\n=== CARACTERÍSTICAS ===");
        Console.WriteLine("Implementación Implícita:");
        Console.WriteLine("  - Método público normal");
        Console.WriteLine("  - Accesible desde la clase");
        Console.WriteLine();
        Console.WriteLine("Implementación Explícita:");
        Console.WriteLine("  - Usa nombre completo de interfaz");
        Console.WriteLine("  - Solo accesible vía interfaz");
        Console.WriteLine("  - Resuelve conflictos de nombres");
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Mejores Prácticas con Interfaces
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Mejores Prácticas con Interfaces',
    'Aprende las mejores prácticas, principios de diseño y patrones comunes usando interfaces en C#.',
    'Usar interfaces correctamente requiere seguir ciertas prácticas y principios de diseño. Aquí están las mejores prácticas:

**Principios de Diseño:**

1. **Principio de Segregación de Interfaces (ISP)**
   - Interfaces pequeñas y específicas
   - Evitar interfaces grandes con muchos miembros
   - Preferir múltiples interfaces pequeñas

2. **Principio de Inversión de Dependencias (DIP)**
   - Depender de abstracciones (interfaces), no de clases concretas
   - Las clases de alto nivel no deben depender de clases de bajo nivel

3. **Principio de Responsabilidad Única (SRP)**
   - Cada interfaz debe tener una responsabilidad clara
   - Interfaces enfocadas en una capacidad específica

**Buenas Prácticas:**

1. **Nombres Claros**
   - Siempre empiezan con `I`: `ISerializable`, `IEnumerable`
   - Sustantivos o adjetivos: `IComparable`, `IReadable`
   - Descriptivos: `IReproductorMusica`, `IConfigurable`

2. **Interfaces Pequeñas**
   - Una interfaz debe definir una capacidad específica
   - Evitar interfaces con muchos miembros
   - Usar múltiples interfaces pequeñas

3. **Documentación Clara**
   - Documenta qué debe hacer cada método
   - Especifica contratos claros
   - Define comportamientos esperados

4. **Evitar Implementación Innecesaria**
   - Si todos los métodos tienen implementación por defecto, considera clase abstracta
   - Si solo necesitas un contrato, usa interface tradicional

**Patrones de Diseño Comunes:**

1. **Strategy Pattern**: Diferentes algoritmos intercambiables
2. **Factory Pattern**: Crear objetos sin especificar la clase exacta
3. **Adapter Pattern**: Adaptar una interfaz a otra
4. **Dependency Injection**: Inyectar dependencias a través de interfaces

**Errores Comunes:**

❌ **Interface Demasiado Grande:**
```csharp
// MAL: Interface con demasiados miembros
public interface IReproductor
{
    void Reproducir();
    void Detener();
    void Pausar();
    void Siguiente();
    void Anterior();
    void CambiarVolumen();
    void GuardarPlaylist();
    void CargarPlaylist();
    // ... muchos más
}
```

✅ **Interfaces Pequeñas (ISP):**
```csharp
// BIEN: Interfaces pequeñas y específicas
public interface IReproductor { void Reproducir(); void Detener(); }
public interface IVolumen { void CambiarVolumen(); }
public interface IPlaylist { void GuardarPlaylist(); void CargarPlaylist(); }
```

❌ **Depender de Clases Concretas:**
```csharp
// MAL: Depender de implementación concreta
public class Servicio
{
    private ReproductorMP3 reproductor;  // Dependencia concreta
}
```

✅ **Depender de Interfaces (DIP):**
```csharp
// BIEN: Depender de abstracción
public class Servicio
{
    private IReproductor reproductor;  // Dependencia de interfaz
}
```

**Checklist de Mejores Prácticas:**

✅ Interface tiene nombre descriptivo que empieza con `I`
✅ Interface es pequeña y específica (ISP)
✅ Cada método tiene un propósito claro
✅ Se documenta el contrato de la interfaz
✅ Se usa para definir capacidades, no implementación
✅ Se prefieren múltiples interfaces pequeñas sobre una grande
✅ Las clases dependen de interfaces, no de implementaciones concretas (DIP)
✅ Se sigue el principio de responsabilidad única

**En Resumen:**

Las interfaces son una herramienta poderosa para crear código flexible, desacoplado y mantenible. Sigue estos principios y prácticas para sacar el máximo provecho de ellas.',
    'using System;

// ============================================
// EJEMPLO: Principio de Segregación de Interfaces (ISP)
// ============================================

// MAL: Interface grande con muchos miembros
// public interface IReproductorGrande
// {
//     void Reproducir();
//     void Detener();
//     void CambiarVolumen();
//     void GuardarPlaylist();
//     void CargarPlaylist();
//     void Configurar();
// }

// BIEN: Interfaces pequeñas y específicas (ISP)
public interface IReproducir
{
    void Reproducir();
    void Detener();
}

public interface IVolumen
{
    void CambiarVolumen(double volumen);
    double Volumen { get; }
}

public interface IPlaylist
{
    void GuardarPlaylist(string nombre);
    void CargarPlaylist(string nombre);
}

public interface IConfigurable
{
    void Configurar(string configuracion);
}

// Clase implementa múltiples interfaces pequeñas
public class ReproductorCompleto : IReproducir, IVolumen, IPlaylist, IConfigurable
{
    private bool estaReproduciendo;
    private double volumen;
    
    public ReproductorCompleto()
    {
        estaReproduciendo = false;
        volumen = 50.0;
    }
    
    // Implementar IReproducir
    public void Reproducir()
    {
        estaReproduciendo = true;
        Console.WriteLine($"Reproduciendo a volumen {volumen}%");
    }
    
    public void Detener()
    {
        estaReproduciendo = false;
        Console.WriteLine("Reproducción detenida");
    }
    
    // Implementar IVolumen
    public void CambiarVolumen(double volumen)
    {
        this.volumen = Math.Clamp(volumen, 0, 100);
        Console.WriteLine($"Volumen: {this.volumen}%");
    }
    
    public double Volumen => volumen;
    
    // Implementar IPlaylist
    public void GuardarPlaylist(string nombre)
    {
        Console.WriteLine($"Playlist {nombre} guardada");
    }
    
    public void CargarPlaylist(string nombre)
    {
        Console.WriteLine($"Playlist {nombre} cargada");
    }
    
    // Implementar IConfigurable
    public void Configurar(string configuracion)
    {
        Console.WriteLine($"Configuración: {configuracion}");
    }
}

// Clase simple que solo necesita reproducir
public class ReproductorSimple : IReproducir
{
    public void Reproducir()
    {
        Console.WriteLine("Reproduciendo");
    }
    
    public void Detener()
    {
        Console.WriteLine("Detenido");
    }
}

// ============================================
// EJEMPLO: Principio de Inversión de Dependencias (DIP)
// ============================================

// MAL: Depender de clase concreta
// public class ServicioMalo
// {
//     private ReproductorMP3 reproductor;  // Dependencia concreta
//     
//     public ServicioMalo()
//     {
//         reproductor = new ReproductorMP3();  // Acoplamiento fuerte
//     }
// }

// BIEN: Depender de interfaz (DIP)
public interface IReproductorMusica
{
    void Reproducir();
    void Detener();
}

public class ReproductorMP3 : IReproductorMusica
{
    public void Reproducir()
    {
        Console.WriteLine("[MP3] Reproduciendo");
    }
    
    public void Detener()
    {
        Console.WriteLine("[MP3] Detenido");
    }
}

public class ReproductorStreaming : IReproductorMusica
{
    public void Reproducir()
    {
        Console.WriteLine("[Streaming] Reproduciendo");
    }
    
    public void Detener()
    {
        Console.WriteLine("[Streaming] Detenido");
    }
}

// Servicio depende de interfaz, no de implementación
public class ServicioMusica
{
    private IReproductorMusica reproductor;
    
    // Inyección de dependencia: recibe interfaz
    public ServicioMusica(IReproductorMusica reproductor)
    {
        this.reproductor = reproductor;  // Dependencia de abstracción
    }
    
    public void IniciarMusica()
    {
        reproductor.Reproducir();
    }
    
    public void DetenerMusica()
    {
        reproductor.Detener();
    }
}

// ============================================
// EJEMPLO: Strategy Pattern con Interfaces
// ============================================

// Strategy: diferentes algoritmos intercambiables
public interface IAlgoritmoCalculo
{
    double Calcular(double a, double b);
}

public class Suma : IAlgoritmoCalculo
{
    public double Calcular(double a, double b) => a + b;
}

public class Multiplicacion : IAlgoritmoCalculo
{
    public double Calcular(double a, double b) => a * b;
}

public class Resta : IAlgoritmoCalculo
{
    public double Calcular(double a, double b) => a - b;
}

// Contexto que usa estrategias intercambiables
public class Calculadora
{
    private IAlgoritmoCalculo algoritmo;
    
    public Calculadora(IAlgoritmoCalculo algoritmo)
    {
        this.algoritmo = algoritmo;
    }
    
    public void CambiarAlgoritmo(IAlgoritmoCalculo nuevoAlgoritmo)
    {
        algoritmo = nuevoAlgoritmo;
    }
    
    public double Ejecutar(double a, double b)
    {
        return algoritmo.Calcular(a, b);
    }
}

class Program
{
    static void DemostrarISP()
    {
        Console.WriteLine("=== PRINCIPIO DE SEGREGACIÓN DE INTERFACES (ISP) ===\n");
        
        // Reproductor completo con todas las capacidades
        ReproductorCompleto completo = new ReproductorCompleto();
        completo.Reproducir();
        completo.CambiarVolumen(75);
        completo.GuardarPlaylist("Mi Playlist");
        
        // Reproductor simple solo con capacidad básica
        ReproductorSimple simple = new ReproductorSimple();
        simple.Reproducir();
        
        // Usar solo la interfaz específica necesaria
        IVolumen volumen = completo;
        volumen.CambiarVolumen(80);
        Console.WriteLine($"Volumen actual: {volumen.Volumen}%");
    }
    
    static void DemostrarDIP()
    {
        Console.WriteLine("\n=== PRINCIPIO DE INVERSIÓN DE DEPENDENCIAS (DIP) ===\n");
        
        // Inyectar diferentes implementaciones
        IReproductorMusica mp3 = new ReproductorMP3();
        IReproductorMusica streaming = new ReproductorStreaming();
        
        // Servicio funciona con cualquier implementación
        ServicioMusica servicio1 = new ServicioMusica(mp3);
        servicio1.IniciarMusica();
        servicio1.DetenerMusica();
        
        ServicioMusica servicio2 = new ServicioMusica(streaming);
        servicio2.IniciarMusica();
        servicio2.DetenerMusica();
    }
    
    static void DemostrarStrategy()
    {
        Console.WriteLine("\n=== STRATEGY PATTERN ===\n");
        
        // Diferentes estrategias
        Calculadora calcSuma = new Calculadora(new Suma());
        Console.WriteLine($"Suma: {calcSuma.Ejecutar(10, 5)}");
        
        Calculadora calcMulti = new Calculadora(new Multiplicacion());
        Console.WriteLine($"Multiplicación: {calcMulti.Ejecutar(10, 5)}");
        
        // Cambiar estrategia dinámicamente
        Calculadora calculadora = new Calculadora(new Suma());
        Console.WriteLine($"Inicial (Suma): {calculadora.Ejecutar(10, 5)}");
        
        calculadora.CambiarAlgoritmo(new Resta());
        Console.WriteLine($"Cambiado (Resta): {calculadora.Ejecutar(10, 5)}");
    }
    
    static void Main()
    {
        Console.WriteLine("=== MEJORES PRÁCTICAS CON INTERFACES ===\n");
        
        DemostrarISP();
        DemostrarDIP();
        DemostrarStrategy();
        
        Console.WriteLine("\n=== PRINCIPIOS Y PATRONES ===");
        Console.WriteLine("✅ ISP: Interfaces pequeñas y específicas");
        Console.WriteLine("✅ DIP: Depender de abstracciones (interfaces)");
        Console.WriteLine("✅ SRP: Una responsabilidad por interfaz");
        Console.WriteLine("✅ Strategy: Algoritmos intercambiables");
        Console.WriteLine("✅ Dependency Injection: Inyectar interfaces");
        Console.WriteLine();
        Console.WriteLine("=== CHECKLIST ===");
        Console.WriteLine("✅ Nombre descriptivo que empieza con I");
        Console.WriteLine("✅ Interface pequeña y específica");
        Console.WriteLine("✅ Contrato claro y documentado");
        Console.WriteLine("✅ Dependencias en interfaces, no clases concretas");
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
PRINT 'Lecciones del curso "Interfaces":';
PRINT '1. Introducción a Interfaces';
PRINT '2. Definición e Implementación de Interfaces';
PRINT '3. Múltiples Interfaces';
PRINT '4. Interfaces vs Clases Abstractas';
PRINT '5. Propiedades en Interfaces';
PRINT '6. Métodos por Defecto en Interfaces (C# 8.0+)';
PRINT '7. Interfaces Implícitas y Explícitas';
PRINT '8. Mejores Prácticas con Interfaces';
GO
