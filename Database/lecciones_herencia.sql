-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Herencia"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Herencia" en la ruta con RutaId = 2
DECLARE @CursoId INT;
DECLARE @RutaId INT = 2; -- RutaId de "Programación Orientada a Objetos"
DECLARE @NombreCurso NVARCHAR(100) = 'Herencia';

-- Buscar el curso "Herencia" en la ruta con RutaId = 2
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
        'Aprende a crear clases derivadas que heredan características de clases base, permitiendo reutilización de código',
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
-- LECCIÓN 1: Introducción a la Herencia
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a la Herencia',
    'Comprende qué es la herencia, cómo funciona y por qué es fundamental en la Programación Orientada a Objetos.',
    'La **herencia** es uno de los cuatro pilares fundamentales de la Programación Orientada a Objetos (POO). Permite crear nuevas clases basadas en clases existentes, reutilizando código y estableciendo relaciones jerárquicas.

**¿Qué es la Herencia?**

La herencia es un mecanismo que permite a una clase (llamada **clase derivada** o **clase hija**) heredar características y comportamientos de otra clase (llamada **clase base** o **clase padre**).

**Analogía del Mundo Real:**

Piensa en la herencia como la relación entre:
- **Clase Base**: `Vehiculo` (tiene ruedas, motor, puede moverse)
- **Clase Derivada**: `Automovil` (hereda de Vehiculo, pero tiene 4 puertas)
- **Clase Derivada**: `Motocicleta` (hereda de Vehiculo, pero tiene 2 ruedas)

**Sintaxis Básica:**

```csharp
// Clase base (padre)
public class Vehiculo
{
    public string Marca { get; set; }
    public void Arrancar() { }
}

// Clase derivada (hija)
public class Automovil : Vehiculo
{
    public int NumeroPuertas { get; set; }
}
```

**Ventajas de la Herencia:**

1. **Reutilización de Código**: No necesitas reescribir código común
2. **Mantenibilidad**: Cambios en la clase base se reflejan en todas las derivadas
3. **Extensibilidad**: Puedes agregar nuevas funcionalidades sin modificar la clase base
4. **Organización**: Establece relaciones jerárquicas claras
5. **Polimorfismo**: Permite tratar objetos derivados como objetos base

**Terminología:**

- **Clase Base / Superclase / Clase Padre**: La clase de la que se hereda
- **Clase Derivada / Subclase / Clase Hija**: La clase que hereda
- **Herencia Simple**: C# solo permite heredar de una clase (herencia simple)
- **Herencia Múltiple**: No está permitida para clases (solo para interfaces)

**Ejemplo Práctico:**

```csharp
public class Animal
{
    public string Nombre { get; set; }
    public void Comer() { }
}

public class Perro : Animal
{
    public void Ladrar() { }
}

public class Gato : Animal
{
    public void Maullar() { }
}
```

**En Resumen:**

La herencia permite crear jerarquías de clases donde las clases derivadas heredan y extienden el comportamiento de las clases base, promoviendo la reutilización de código y la organización lógica.',
    'using System;

// Clase base (padre)
public class Vehiculo
{
    public string Marca { get; set; }
    public string Modelo { get; set; }
    public int Año { get; set; }
    
    public Vehiculo(string marca, string modelo, int año)
    {
        Marca = marca;
        Modelo = modelo;
        Año = año;
    }
    
    public void Arrancar()
    {
        Console.WriteLine($"{Marca} {Modelo} ha arrancado");
    }
    
    public void Detener()
    {
        Console.WriteLine($"{Marca} {Modelo} se ha detenido");
    }
    
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Vehículo: {Marca} {Modelo} ({Año})");
    }
}

// Clase derivada (hija) - Automovil hereda de Vehiculo
public class Automovil : Vehiculo
{
    public int NumeroPuertas { get; set; }
    
    // Constructor que llama al constructor de la clase base
    public Automovil(string marca, string modelo, int año, int numeroPuertas) 
        : base(marca, modelo, año)
    {
        NumeroPuertas = numeroPuertas;
    }
    
    public void AbrirPuertas()
    {
        Console.WriteLine($"Abriendo {NumeroPuertas} puertas del {Marca} {Modelo}");
    }
    
    // Sobrescribir método de la clase base
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();  // Llama al método de la clase base
        Console.WriteLine($"Número de puertas: {NumeroPuertas}");
    }
}

// Otra clase derivada
public class Motocicleta : Vehiculo
{
    public int Cilindrada { get; set; }
    
    public Motocicleta(string marca, string modelo, int año, int cilindrada) 
        : base(marca, modelo, año)
    {
        Cilindrada = cilindrada;
    }
    
    public void HacerCaballito()
    {
        Console.WriteLine($"{Marca} {Modelo} está haciendo caballito");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Cilindrada: {Cilindrada}cc");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Herencia Básica ===");
        
        // Crear objetos de las clases derivadas
        Automovil auto = new Automovil("Toyota", "Corolla", 2023, 4);
        auto.Arrancar();  // Método heredado de Vehiculo
        auto.AbrirPuertas();  // Método propio de Automovil
        auto.MostrarInformacion();  // Método sobrescrito
        
        Console.WriteLine();
        
        Motocicleta moto = new Motocicleta("Honda", "CBR", 2023, 600);
        moto.Arrancar();  // Método heredado de Vehiculo
        moto.HacerCaballito();  // Método propio de Motocicleta
        moto.MostrarInformacion();  // Método sobrescrito
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Acceso a Miembros Heredados ===");
        Console.WriteLine($"Auto - Marca: {auto.Marca}");  // Propiedad heredada
        Console.WriteLine($"Auto - Puertas: {auto.NumeroPuertas}");  // Propiedad propia
        Console.WriteLine($"Moto - Marca: {moto.Marca}");  // Propiedad heredada
        Console.WriteLine($"Moto - Cilindrada: {moto.Cilindrada}");  // Propiedad propia
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Sintaxis y Uso Básico de Herencia
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Sintaxis y Uso Básico de Herencia',
    'Aprende la sintaxis completa para crear clases derivadas y cómo acceder a los miembros heredados.',
    'La sintaxis de herencia en C# es simple pero poderosa. Veamos cómo declarar clases derivadas y trabajar con la herencia.

**Sintaxis de Herencia:**

```csharp
public class ClaseBase
{
    // Miembros de la clase base
}

public class ClaseDerivada : ClaseBase
{
    // Miembros adicionales de la clase derivada
}
```

**El Operador `:` (dos puntos)**

El operador `:` se usa para indicar herencia:
- `public class Derivada : Base` significa "Derivada hereda de Base"

**Acceso a Miembros Heredados:**

Una clase derivada puede acceder a:
- **Miembros públicos** de la clase base
- **Miembros protegidos** de la clase base
- **Miembros internos** de la clase base (si están en el mismo ensamblado)

**No puede acceder a:**
- **Miembros privados** de la clase base

**Ejemplo de Acceso:**

```csharp
public class Base
{
    public int publico;      // Accesible en derivadas
    protected int protegido;  // Accesible en derivadas
    private int privado;     // NO accesible en derivadas
}

public class Derivada : Base
{
    public void Metodo()
    {
        publico = 10;      // OK
        protegido = 20;    // OK
        // privado = 30;   // ERROR: privado no es accesible
    }
}
```

**Constructores en Herencia:**

Cuando una clase deriva de otra, el constructor de la clase base se ejecuta primero:

```csharp
public class Base
{
    public Base() { Console.WriteLine("Base"); }
}

public class Derivada : Base
{
    public Derivada() { Console.WriteLine("Derivada"); }
}

// Al crear Derivada, se imprime: "Base" luego "Derivada"
```

**Usando `base` para Llamar al Constructor:**

```csharp
public class Base
{
    public Base(string nombre) { }
}

public class Derivada : Base
{
    public Derivada(string nombre, int edad) : base(nombre)
    {
        // Inicializar edad
    }
}
```

**Miembros Propios vs Heredados:**

Una clase derivada puede:
- **Usar** miembros heredados
- **Agregar** nuevos miembros
- **Sobrescribir** métodos heredados (con `override`)

**Ejemplo Completo:**

```csharp
public class Persona
{
    public string Nombre { get; set; }
    public void Saludar() { }
}

public class Empleado : Persona
{
    public string Puesto { get; set; }  // Nuevo miembro
    public void Trabajar() { }           // Nuevo método
}
```',
    'using System;

// Clase base
public class Persona
{
    // Miembros públicos (accesibles en derivadas)
    public string Nombre { get; set; }
    public int Edad { get; set; }
    
    // Miembro protegido (accesible en derivadas)
    protected string Documento { get; set; }
    
    // Miembro privado (NO accesible en derivadas)
    private string informacionPrivada;
    
    public Persona(string nombre, int edad)
    {
        Nombre = nombre;
        Edad = edad;
        Documento = "";
        informacionPrivada = "Privada";
    }
    
    public void Saludar()
    {
        Console.WriteLine($"Hola, soy {Nombre}");
    }
    
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Nombre: {Nombre}, Edad: {Edad}");
    }
}

// Clase derivada
public class Empleado : Persona
{
    // Nuevos miembros propios de Empleado
    public string Puesto { get; set; }
    public double Salario { get; set; }
    
    public Empleado(string nombre, int edad, string puesto, double salario) 
        : base(nombre, edad)  // Llama al constructor de Persona
    {
        Puesto = puesto;
        Salario = salario;
    }
    
    // Nuevo método propio
    public void Trabajar()
    {
        Console.WriteLine($"{Nombre} está trabajando como {Puesto}");
    }
    
    // Acceso a miembros heredados
    public void EstablecerDocumento(string documento)
    {
        Documento = documento;  // OK: Documento es protected
        Console.WriteLine($"Documento establecido: {Documento}");
    }
    
    // Sobrescribir método de la clase base
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();  // Llama al método de Persona
        Console.WriteLine($"Puesto: {Puesto}, Salario: ${Salario:F2}");
    }
    
    // Intentar acceder a miembro privado (causaría error)
    // public void AccederPrivado()
    // {
    //     informacionPrivada = "Nuevo";  // ERROR: privado no es accesible
    // }
}

// Otra clase derivada
public class Estudiante : Persona
{
    public string Matricula { get; set; }
    public double Promedio { get; set; }
    
    public Estudiante(string nombre, int edad, string matricula, double promedio) 
        : base(nombre, edad)
    {
        Matricula = matricula;
        Promedio = promedio;
    }
    
    public void Estudiar()
    {
        Console.WriteLine($"{Nombre} está estudiando");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Matrícula: {Matricula}, Promedio: {Promedio:F2}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Acceso a Miembros Heredados ===");
        
        Empleado empleado = new Empleado("Juan", 30, "Desarrollador", 50000);
        
        // Acceso a miembros heredados
        Console.WriteLine($"Nombre (heredado): {empleado.Nombre}");
        Console.WriteLine($"Edad (heredada): {empleado.Edad}");
        
        // Acceso a miembros propios
        Console.WriteLine($"Puesto (propio): {empleado.Puesto}");
        Console.WriteLine($"Salario (propio): ${empleado.Salario:F2}");
        
        // Uso de métodos heredados
        empleado.Saludar();  // Método heredado
        
        // Uso de métodos propios
        empleado.Trabajar();  // Método propio
        
        // Acceso a miembro protegido mediante método público
        empleado.EstablecerDocumento("12345678");
        
        // Método sobrescrito
        empleado.MostrarInformacion();
        
        Console.WriteLine("\n=== EJEMPLO: Otra Clase Derivada ===");
        Estudiante estudiante = new Estudiante("María", 20, "2024-001", 8.5);
        estudiante.Saludar();  // Método heredado
        estudiante.Estudiar();  // Método propio
        estudiante.MostrarInformacion();  // Método sobrescrito
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Jerarquía de Clases ===");
        Console.WriteLine("Persona (clase base)");
        Console.WriteLine("  ├── Empleado (clase derivada)");
        Console.WriteLine("  └── Estudiante (clase derivada)");
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: Sobrescritura de Métodos (override)
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Sobrescritura de Métodos (override)',
    'Aprende a sobrescribir métodos heredados usando las palabras clave virtual y override.',
    'La **sobrescritura de métodos** permite que una clase derivada proporcione su propia implementación de un método definido en la clase base. Esto es fundamental para el polimorfismo.

**¿Qué es la Sobrescritura?**

La sobrescritura permite redefinir el comportamiento de un método heredado en la clase derivada, manteniendo la misma firma (nombre y parámetros).

**Palabras Clave:**

- **`virtual`**: Se usa en la clase base para indicar que el método puede ser sobrescrito
- **`override`**: Se usa en la clase derivada para sobrescribir el método virtual

**Sintaxis:**

```csharp
public class Base
{
    public virtual void Metodo()
    {
        Console.WriteLine("Método de Base");
    }
}

public class Derivada : Base
{
    public override void Metodo()
    {
        Console.WriteLine("Método de Derivada");
    }
}
```

**Cuándo Usar Sobrescritura:**

- Cuando necesitas **comportamiento diferente** en la clase derivada
- Para implementar **polimorfismo**
- Para **especializar** el comportamiento de la clase base

**Reglas de Sobrescritura:**

1. El método en la clase base debe ser `virtual` o `abstract`
2. El método en la clase derivada debe usar `override`
3. La firma debe ser **exactamente igual** (nombre, parámetros, tipo de retorno)
4. No puedes sobrescribir métodos `static` o `private`

**Llamar al Método de la Clase Base:**

Puedes llamar al método de la clase base usando `base`:

```csharp
public override void Metodo()
{
    base.Metodo();  // Llama al método de la clase base
    // Código adicional
}
```

**Ejemplo Práctico:**

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

public class Gato : Animal
{
    public override void HacerSonido()
    {
        Console.WriteLine("El gato maúlla: ¡Miau!");
    }
}
```

**Ventajas:**

- **Flexibilidad**: Cada clase derivada puede tener su propia implementación
- **Polimorfismo**: Tratar objetos derivados como objetos base
- **Extensibilidad**: Agregar nuevas clases sin modificar código existente',
    'using System;

// Clase base con métodos virtuales
public class Forma
{
    protected string nombre;
    
    public Forma(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Método virtual que puede ser sobrescrito
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
    
    // Método que no es virtual (no puede ser sobrescrito)
    public void MostrarNombre()
    {
        Console.WriteLine($"Forma: {nombre}");
    }
}

// Clase derivada que sobrescribe métodos
public class Rectangulo : Forma
{
    private double ancho;
    private double alto;
    
    public Rectangulo(double ancho, double alto) : base("Rectángulo")
    {
        this.ancho = ancho;
        this.alto = alto;
    }
    
    // Sobrescribir método CalcularArea
    public override double CalcularArea()
    {
        double area = ancho * alto;
        Console.WriteLine($"Área del rectángulo: {area:F2}");
        return area;
    }
    
    // Sobrescribir método Dibujar
    public override void Dibujar()
    {
        base.Dibujar();  // Llama al método de la clase base
        Console.WriteLine($"  Ancho: {ancho}, Alto: {alto}");
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
        double area = Math.PI * radio * radio;
        Console.WriteLine($"Área del círculo: {area:F2}");
        return area;
    }
    
    public override void Dibujar()
    {
        base.Dibujar();
        Console.WriteLine($"  Radio: {radio:F2}");
    }
}

// Clase derivada que no sobrescribe (usa el comportamiento de la base)
public class FormaGenerica : Forma
{
    public FormaGenerica() : base("Forma Genérica")
    {
    }
    
    // No sobrescribe CalcularArea, usa el de la clase base
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Sobrescritura de Métodos ===");
        
        Rectangulo rect = new Rectangulo(5, 3);
        rect.MostrarNombre();  // Método no virtual
        rect.CalcularArea();   // Método sobrescrito
        rect.Dibujar();        // Método sobrescrito
        
        Console.WriteLine();
        
        Circulo circ = new Circulo(5);
        circ.MostrarNombre();
        circ.CalcularArea();   // Método sobrescrito
        circ.Dibujar();
        
        Console.WriteLine();
        
        FormaGenerica forma = new FormaGenerica();
        forma.MostrarNombre();
        forma.CalcularArea();  // Usa el método de la clase base
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo ===");
        Forma[] formas = new Forma[]
        {
            new Rectangulo(4, 6),
            new Circulo(3),
            new FormaGenerica()
        };
        
        foreach (Forma f in formas)
        {
            f.CalcularArea();  // Cada una usa su propia implementación
        }
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Palabras Clave sealed y abstract
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Palabras Clave sealed y abstract',
    'Aprende a usar sealed para prevenir herencia y abstract para crear clases base que no se pueden instanciar.',
    'C# proporciona dos palabras clave importantes para controlar la herencia: **`sealed`** y **`abstract`**. Cada una tiene un propósito específico.

**Palabra Clave `sealed`:**

La palabra clave `sealed` previene que una clase sea heredada o que un método sea sobrescrito.

**Clase `sealed`:**

```csharp
public sealed class NoSePuedeHeredar
{
    // Esta clase no puede ser heredada
}

// ERROR: No se puede heredar de una clase sealed
// public class Derivada : NoSePuedeHeredar { }
```

**Método `sealed`:**

```csharp
public class Base
{
    public virtual void Metodo() { }
}

public class Derivada : Base
{
    public sealed override void Metodo()  // No puede ser sobrescrito más
    {
        // Implementación
    }
}

// ERROR: No se puede sobrescribir un método sealed
// public class SegundaDerivada : Derivada
// {
//     public override void Metodo() { }  // ERROR
// }
```

**Cuándo Usar `sealed`:**

- Cuando una clase es **completa** y no necesita ser extendida
- Para **prevenir modificaciones** no deseadas
- Para **optimización** (el compilador puede optimizar mejor)
- Cuando un método **no debe ser sobrescrito** en clases derivadas

**Palabra Clave `abstract`:**

La palabra clave `abstract` se usa para crear clases y métodos que deben ser implementados en clases derivadas.

**Clase `abstract`:**

```csharp
public abstract class ClaseAbstracta
{
    // No se puede crear una instancia de esta clase
    // Debe ser heredada
}

// ERROR: No se puede instanciar una clase abstracta
// ClaseAbstracta obj = new ClaseAbstracta();
```

**Método `abstract`:**

```csharp
public abstract class Animal
{
    public abstract void HacerSonido();  // Debe ser implementado en derivadas
}

public class Perro : Animal
{
    public override void HacerSonido()  // DEBE implementar el método abstracto
    {
        Console.WriteLine("Guau");
    }
}
```

**Características de Clases Abstractas:**

- **No se pueden instanciar** directamente
- Pueden tener **métodos abstractos** (sin implementación)
- Pueden tener **métodos concretos** (con implementación)
- Pueden tener **campos y propiedades**
- Deben ser **heredadas** para ser útiles

**Cuándo Usar `abstract`:**

- Cuando quieres definir un **contrato** que las clases derivadas deben cumplir
- Para crear **clases base** que no tienen sentido por sí solas
- Para forzar la **implementación** de métodos específicos

**Comparación:**

| Característica | `sealed` | `abstract` |
|---------------|----------|------------|
| ¿Se puede instanciar? | Sí | No |
| ¿Se puede heredar? | No | Sí |
| ¿Puede tener métodos abstractos? | No | Sí |
| Propósito | Prevenir herencia | Forzar herencia |

**Ejemplo Práctico:**

```csharp
public abstract class Vehiculo
{
    public abstract void Arrancar();
}

public sealed class Automovil : Vehiculo
{
    public override void Arrancar() { }
    // No se puede heredar de Automovil
}
```',
    'using System;

// ============================================
// EJEMPLO: Clase abstracta
// ============================================

// Clase abstracta: no se puede instanciar
public abstract class Animal
{
    protected string nombre;
    
    public Animal(string nombre)
    {
        this.nombre = nombre;
    }
    
    // Método abstracto: debe ser implementado en clases derivadas
    public abstract void HacerSonido();
    
    // Método concreto: tiene implementación
    public virtual void Moverse()
    {
        Console.WriteLine($"{nombre} se está moviendo");
    }
    
    // Método concreto
    public void Dormir()
    {
        Console.WriteLine($"{nombre} está durmiendo");
    }
}

// Clase derivada que implementa el método abstracto
public class Perro : Animal
{
    public Perro(string nombre) : base(nombre) { }
    
    // DEBE implementar el método abstracto
    public override void HacerSonido()
    {
        Console.WriteLine($"{nombre} ladra: ¡Guau!");
    }
    
    // Puede sobrescribir métodos virtuales
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
        Console.WriteLine($"{nombre} maúlla: ¡Miau!");
    }
}

// ============================================
// EJEMPLO: Clase sealed
// ============================================

// Clase sealed: no se puede heredar
public sealed class Automovil
{
    public string Marca { get; set; }
    public string Modelo { get; set; }
    
    public void Arrancar()
    {
        Console.WriteLine($"{Marca} {Modelo} ha arrancado");
    }
}

// ERROR: No se puede heredar de una clase sealed
// public class Deportivo : Automovil { }

// ============================================
// EJEMPLO: Método sealed
// ============================================

public class Base
{
    public virtual void MetodoVirtual()
    {
        Console.WriteLine("Método virtual de Base");
    }
}

public class Derivada : Base
{
    // Sobrescribe y sella el método
    public sealed override void MetodoVirtual()
    {
        Console.WriteLine("Método sealed de Derivada");
    }
}

public class SegundaDerivada : Derivada
{
    // ERROR: No se puede sobrescribir un método sealed
    // public override void MetodoVirtual() { }
    
    // Puede tener otros métodos
    public void OtroMetodo()
    {
        Console.WriteLine("Otro método");
    }
}

// ============================================
// EJEMPLO: Combinación de abstract y sealed
// ============================================

public abstract class Forma
{
    public abstract double CalcularArea();
    public abstract void Dibujar();
}

public sealed class Cuadrado : Forma
{
    private double lado;
    
    public Cuadrado(double lado)
    {
        this.lado = lado;
    }
    
    public override double CalcularArea()
    {
        return lado * lado;
    }
    
    public override void Dibujar()
    {
        Console.WriteLine($"Dibujando cuadrado de lado {lado}");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Clases Abstractas ===");
        
        // ERROR: No se puede instanciar una clase abstracta
        // Animal animal = new Animal("Genérico");
        
        Perro perro = new Perro("Max");
        perro.HacerSonido();  // Implementación del método abstracto
        perro.Moverse();      // Método sobrescrito
        perro.Dormir();       // Método heredado
        
        Console.WriteLine();
        
        Gato gato = new Gato("Luna");
        gato.HacerSonido();
        gato.Moverse();  // Usa la implementación de la clase base
        gato.Dormir();
        
        Console.WriteLine("\n=== EJEMPLO: Clase Sealed ===");
        Automovil auto = new Automovil { Marca = "Toyota", Modelo = "Corolla" };
        auto.Arrancar();
        
        Console.WriteLine("\n=== EJEMPLO: Método Sealed ===");
        Derivada derivada = new Derivada();
        derivada.MetodoVirtual();
        
        SegundaDerivada segunda = new SegundaDerivada();
        segunda.MetodoVirtual();  // Usa la implementación sealed
        segunda.OtroMetodo();
        
        Console.WriteLine("\n=== EJEMPLO: Abstract + Sealed ===");
        Cuadrado cuadrado = new Cuadrado(5);
        cuadrado.Dibujar();
        Console.WriteLine($"Área: {cuadrado.CalcularArea():F2}");
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: Herencia Múltiple y Interfaces
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Herencia Múltiple y Interfaces',
    'Comprende por qué C# no permite herencia múltiple de clases y cómo las interfaces solucionan este problema.',
    'C# **no permite herencia múltiple de clases**, pero permite implementar **múltiples interfaces**. Esta es una diferencia importante con otros lenguajes como C++.

**¿Qué es la Herencia Múltiple?**

La herencia múltiple permite que una clase herede de **múltiples clases base** simultáneamente. C# **NO** permite esto para clases.

**¿Por qué C# no Permite Herencia Múltiple de Clases?**

1. **Problema del Diamante**: Conflictos cuando dos clases base tienen el mismo método
2. **Complejidad**: Hace el código más difícil de entender y mantener
3. **Ambigüedad**: No está claro qué implementación usar cuando hay conflictos

**Ejemplo del Problema:**

```csharp
// Si C# permitiera esto (NO lo permite):
public class A { public void Metodo() { } }
public class B { public void Metodo() { } }
public class C : A, B { }  // ERROR: ¿Qué Metodo() usar?

C obj = new C();
obj.Metodo();  // ¿De A o de B?
```

**Solución: Interfaces**

Las **interfaces** permiten lograr funcionalidad similar sin los problemas de la herencia múltiple:

```csharp
public interface IVolador
{
    void Volar();
}

public interface INadador
{
    void Nadar();
}

public class Pato : IVolador, INadador
{
    public void Volar() { }
    public void Nadar() { }
}
```

**Herencia Simple + Múltiples Interfaces:**

Una clase puede:
- Heredar de **una sola clase** (herencia simple)
- Implementar **múltiples interfaces**

```csharp
public class Base { }

public interface IInterface1 { }
public interface IInterface2 { }

public class Derivada : Base, IInterface1, IInterface2
{
    // Hereda de Base e implementa ambas interfaces
}
```

**Ventajas de las Interfaces:**

1. **Sin conflictos**: No hay ambigüedad sobre qué implementación usar
2. **Contratos claros**: Define qué debe hacer, no cómo
3. **Flexibilidad**: Una clase puede implementar múltiples interfaces
4. **Polimorfismo**: Permite tratar objetos por sus capacidades

**Cuándo Usar Interfaces vs Herencia:**

- **Usa Herencia** cuando hay una relación "es un" (is-a)
  - Ejemplo: `Automovil` ES UN `Vehiculo`
  
- **Usa Interfaces** cuando hay una relación "puede hacer" (can-do)
  - Ejemplo: `Pato` PUEDE `Volar` y `Nadar`

**Ejemplo Práctico:**

```csharp
public class Animal { }

public interface IVolador { void Volar(); }
public interface INadador { void Nadar(); }

public class Pato : Animal, IVolador, INadador
{
    public void Volar() { }
    public void Nadar() { }
}
```

**En Resumen:**

- C# permite **herencia simple** de clases
- C# permite **múltiples interfaces**
- Las interfaces evitan los problemas de la herencia múltiple
- Usa interfaces para definir capacidades, herencia para relaciones',
    'using System;

// Clase base
public class Animal
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
}

// Interfaces (definen capacidades)
public interface IVolador
{
    void Volar();
}

public interface INadador
{
    void Nadar();
}

public interface ICorredor
{
    void Correr();
}

// Clase que hereda de Animal e implementa interfaces
public class Pato : Animal, IVolador, INadador
{
    public Pato(string nombre) : base(nombre) { }
    
    // Implementación de IVolador
    public void Volar()
    {
        Console.WriteLine($"{nombre} está volando");
    }
    
    // Implementación de INadador
    public void Nadar()
    {
        Console.WriteLine($"{nombre} está nadando");
    }
}

// Otra clase que implementa múltiples interfaces
public class Perro : Animal, ICorredor, INadador
{
    public Perro(string nombre) : base(nombre) { }
    
    public void Correr()
    {
        Console.WriteLine($"{nombre} está corriendo");
    }
    
    public void Nadar()
    {
        Console.WriteLine($"{nombre} está nadando (aunque no le gusta mucho)");
    }
}

// Clase que solo implementa interfaces (sin herencia de clase)
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
}

// Demostración de polimorfismo con interfaces
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
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Herencia Simple + Múltiples Interfaces ===");
        
        Pato pato = new Pato("Donald");
        pato.Comer();      // Método heredado de Animal
        pato.Volar();      // Método de IVolador
        pato.Nadar();      // Método de INadador
        
        Console.WriteLine();
        
        Perro perro = new Perro("Max");
        perro.Comer();     // Método heredado de Animal
        perro.Correr();    // Método de ICorredor
        perro.Nadar();     // Método de INadador
        
        Console.WriteLine();
        
        Avion avion = new Avion("Boeing 747");
        avion.Volar();     // Método de IVolador
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo con Interfaces ===");
        
        // Tratar objetos por sus capacidades (interfaces)
        IVolador[] voladores = new IVolador[]
        {
            new Pato("Pato 1"),
            new Avion("Airbus A380")
        };
        
        foreach (IVolador volador in voladores)
        {
            HacerVolar(volador);
        }
        
        Console.WriteLine();
        
        INadador[] nadadores = new INadador[]
        {
            new Pato("Pato 2"),
            new Perro("Perro 1")
        };
        
        foreach (INadador nadador in nadadores)
        {
            HacerNadar(nadador);
        }
        
        Console.WriteLine("\n=== NOTA IMPORTANTE ===");
        Console.WriteLine("C# NO permite herencia múltiple de clases:");
        Console.WriteLine("  public class C : A, B { }  // ERROR");
        Console.WriteLine();
        Console.WriteLine("Pero SÍ permite múltiples interfaces:");
        Console.WriteLine("  public class C : A, I1, I2 { }  // OK");
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: El Operador base
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'El Operador base',
    'Aprende a usar el operador base para acceder a miembros de la clase base desde clases derivadas.',
    'El operador **`base`** permite acceder a miembros de la clase base desde una clase derivada. Es especialmente útil para llamar constructores y métodos de la clase base.

**¿Qué es `base`?**

`base` es una palabra clave que hace referencia a la **instancia de la clase base** dentro de una clase derivada. Es similar a `this`, pero apunta a la clase padre.

**Usos de `base`:**

1. **Llamar al constructor de la clase base**
2. **Llamar a métodos de la clase base** (especialmente cuando se sobrescriben)
3. **Acceder a miembros protegidos** de la clase base

**1. Llamar al Constructor de la Clase Base:**

```csharp
public class Base
{
    public Base(string nombre) { }
}

public class Derivada : Base
{
    public Derivada(string nombre, int edad) : base(nombre)
    {
        // base(nombre) llama al constructor de Base
    }
}
```

**2. Llamar a Métodos de la Clase Base:**

Cuando sobrescribes un método, puedes llamar a la versión de la clase base:

```csharp
public class Base
{
    public virtual void Metodo()
    {
        Console.WriteLine("Método de Base");
    }
}

public class Derivada : Base
{
    public override void Metodo()
    {
        base.Metodo();  // Llama al método de Base
        Console.WriteLine("Método de Derivada");
    }
}
```

**3. Acceder a Miembros Protegidos:**

```csharp
public class Base
{
    protected int valor;
}

public class Derivada : Base
{
    public void Metodo()
    {
        base.valor = 10;  // Accede al miembro protegido
    }
}
```

**Ventajas de Usar `base`:**

- **Reutilización**: Evita duplicar código de la clase base
- **Extensión**: Permite agregar funcionalidad sin perder la original
- **Mantenibilidad**: Cambios en la clase base se reflejan automáticamente

**Ejemplo Práctico:**

```csharp
public class Empleado
{
    protected string nombre;
    
    public Empleado(string nombre)
    {
        this.nombre = nombre;
    }
    
    public virtual void Trabajar()
    {
        Console.WriteLine($"{nombre} está trabajando");
    }
}

public class Gerente : Empleado
{
    public Gerente(string nombre) : base(nombre) { }
    
    public override void Trabajar()
    {
        base.Trabajar();  // Llama al método de Empleado
        Console.WriteLine($"{nombre} está supervisando");
    }
}
```

**Buenas Prácticas:**

- Usa `base` para **extender** comportamiento, no reemplazarlo completamente
- Llama a `base` **al inicio** del método cuando quieres agregar funcionalidad
- Llama a `base` **al final** cuando quieres agregar validación o limpieza',
    'using System;

// Clase base
public class Persona
{
    protected string nombre;
    protected int edad;
    
    public Persona(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
        Console.WriteLine($"Persona base creada: {nombre}, {edad} años");
    }
    
    public virtual void Presentarse()
    {
        Console.WriteLine($"Hola, soy {nombre} y tengo {edad} años");
    }
    
    public virtual void Trabajar()
    {
        Console.WriteLine($"{nombre} está trabajando");
    }
    
    protected void MetodoProtegido()
    {
        Console.WriteLine("Método protegido de Persona");
    }
}

// Clase derivada usando base
public class Empleado : Persona
{
    private string puesto;
    
    // Usar base para llamar al constructor de la clase base
    public Empleado(string nombre, int edad, string puesto) 
        : base(nombre, edad)  // Llama al constructor de Persona
    {
        this.puesto = puesto;
        Console.WriteLine($"Empleado creado con puesto: {puesto}");
    }
    
    // Sobrescribir método y llamar a la versión de la clase base
    public override void Presentarse()
    {
        base.Presentarse();  // Llama al método de Persona
        Console.WriteLine($"Trabajo como {puesto}");
    }
    
    // Extender el método Trabajar
    public override void Trabajar()
    {
        base.Trabajar();  // Llama al método de Persona
        Console.WriteLine($"{nombre} está trabajando como {puesto}");
    }
    
    // Acceder a método protegido usando base
    public void UsarMetodoProtegido()
    {
        base.MetodoProtegido();  // Accede al método protegido
    }
    
    // Acceder a miembros protegidos
    public void CambiarEdad(int nuevaEdad)
    {
        base.edad = nuevaEdad;  // Accede al campo protegido
        Console.WriteLine($"Edad actualizada a {nuevaEdad}");
    }
}

// Otra clase derivada
public class Estudiante : Persona
{
    private string matricula;
    
    public Estudiante(string nombre, int edad, string matricula) 
        : base(nombre, edad)
    {
        this.matricula = matricula;
    }
    
    public override void Presentarse()
    {
        base.Presentarse();
        Console.WriteLine($"Soy estudiante con matrícula: {matricula}");
    }
    
    // No sobrescribe Trabajar, usa el de la clase base
    public void Estudiar()
    {
        Console.WriteLine($"{nombre} está estudiando");
    }
}

// Ejemplo con múltiples niveles de herencia
public class Gerente : Empleado
{
    private int numeroEmpleados;
    
    public Gerente(string nombre, int edad, int numeroEmpleados) 
        : base(nombre, edad, "Gerente")
    {
        this.numeroEmpleados = numeroEmpleados;
    }
    
    public override void Trabajar()
    {
        base.Trabajar();  // Llama al método de Empleado (que a su vez llama al de Persona)
        Console.WriteLine($"{nombre} está supervisando {numeroEmpleados} empleados");
    }
    
    public override void Presentarse()
    {
        base.Presentarse();  // Llama al método de Empleado
        Console.WriteLine($"Superviso {numeroEmpleados} empleados");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Uso de base en Constructores ===");
        Empleado empleado = new Empleado("Juan", 30, "Desarrollador");
        
        Console.WriteLine("\n=== EJEMPLO: Uso de base en Métodos ===");
        empleado.Presentarse();
        empleado.Trabajar();
        
        Console.WriteLine("\n=== EJEMPLO: Acceso a Miembros Protegidos ===");
        empleado.UsarMetodoProtegido();
        empleado.CambiarEdad(31);
        
        Console.WriteLine("\n=== EJEMPLO: Otra Clase Derivada ===");
        Estudiante estudiante = new Estudiante("María", 20, "2024-001");
        estudiante.Presentarse();
        estudiante.Trabajar();  // Usa el método de la clase base
        
        Console.WriteLine("\n=== EJEMPLO: Herencia en Múltiples Niveles ===");
        Gerente gerente = new Gerente("Pedro", 45, 10);
        gerente.Presentarse();
        gerente.Trabajar();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Cadena de Llamadas ===");
        Console.WriteLine("Cuando Gerente.Trabajar() llama a base.Trabajar():");
        Console.WriteLine("  1. Se ejecuta Empleado.Trabajar()");
        Console.WriteLine("  2. Que llama a base.Trabajar()");
        Console.WriteLine("  3. Que ejecuta Persona.Trabajar()");
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Jerarquías de Herencia
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Jerarquías de Herencia',
    'Aprende a crear y trabajar con jerarquías complejas de herencia con múltiples niveles.',
    'Una **jerarquía de herencia** es una estructura donde las clases se organizan en niveles, formando una "árbol genealógico" de clases. Cada nivel puede heredar del anterior y agregar nuevas funcionalidades.

**¿Qué es una Jerarquía de Herencia?**

Una jerarquía es una estructura de clases donde:
- Una clase base tiene múltiples clases derivadas
- Las clases derivadas pueden tener sus propias clases derivadas
- Se forma una estructura en forma de árbol

**Ejemplo de Jerarquía:**

```
Animal (clase base)
  ├── Mamifero
  │     ├── Perro
  │     └── Gato
  └── Ave
        ├── Pato
        └── Aguila
```

**Sintaxis de Múltiples Niveles:**

```csharp
public class Animal { }

public class Mamifero : Animal { }

public class Perro : Mamifero { }
```

**Ventajas de las Jerarquías:**

1. **Organización**: Estructura clara y lógica
2. **Reutilización**: Código común en niveles superiores
3. **Especialización**: Cada nivel agrega funcionalidad específica
4. **Mantenibilidad**: Cambios en niveles superiores afectan a todos los descendientes

**Consideraciones:**

- **No abuses de la herencia**: Demasiados niveles pueden ser difíciles de mantener
- **Mantén la jerarquía simple**: Generalmente 2-3 niveles son suficientes
- **Usa composición cuando sea apropiado**: No todo debe ser herencia

**Ejemplo Práctico:**

```csharp
public class Vehiculo { }
public class Terrestre : Vehiculo { }
public class Automovil : Terrestre { }
```

**Buenas Prácticas:**

1. **Límite de Profundidad**: Evita más de 3-4 niveles
2. **Relación Lógica**: Asegúrate de que la relación "es un" sea verdadera
3. **Principio LSP**: Las clases derivadas deben ser sustituibles por la base
4. **Documentación**: Documenta la jerarquía claramente',
    'using System;

// ============================================
// JERARQUÍA DE HERENCIA: Animales
// ============================================

// Nivel 1: Clase base
public class Animal
{
    protected string nombre;
    protected int edad;
    
    public Animal(string nombre, int edad)
    {
        this.nombre = nombre;
        this.edad = edad;
    }
    
    public virtual void Comer()
    {
        Console.WriteLine($"{nombre} está comiendo");
    }
    
    public virtual void Dormir()
    {
        Console.WriteLine($"{nombre} está durmiendo");
    }
    
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Animal: {nombre}, {edad} años");
    }
}

// Nivel 2: Clases derivadas de Animal
public class Mamifero : Animal
{
    protected bool tienePelo;
    
    public Mamifero(string nombre, int edad, bool tienePelo) 
        : base(nombre, edad)
    {
        this.tienePelo = tienePelo;
    }
    
    public virtual void Amamantar()
    {
        Console.WriteLine($"{nombre} está amamantando");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Tipo: Mamífero, Tiene pelo: {tienePelo}");
    }
}

public class Ave : Animal
{
    protected bool puedeVolar;
    
    public Ave(string nombre, int edad, bool puedeVolar) 
        : base(nombre, edad)
    {
        this.puedeVolar = puedeVolar;
    }
    
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

// Nivel 3: Clases derivadas de Mamifero
public class Perro : Mamifero
{
    private string raza;
    
    public Perro(string nombre, int edad, string raza) 
        : base(nombre, edad, true)
    {
        this.raza = raza;
    }
    
    public void Ladrar()
    {
        Console.WriteLine($"{nombre} está ladrando: ¡Guau!");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Especie: Perro, Raza: {raza}");
    }
}

public class Gato : Mamifero
{
    private bool esDomestico;
    
    public Gato(string nombre, int edad, bool esDomestico) 
        : base(nombre, edad, true)
    {
        this.esDomestico = esDomestico;
    }
    
    public void Maullar()
    {
        Console.WriteLine($"{nombre} está maullando: ¡Miau!");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Especie: Gato, Doméstico: {esDomestico}");
    }
}

// Nivel 3: Clases derivadas de Ave
public class Pato : Ave
{
    private bool puedeNadar;
    
    public Pato(string nombre, int edad) 
        : base(nombre, edad, true)
    {
        puedeNadar = true;
    }
    
    public void Nadar()
    {
        Console.WriteLine($"{nombre} está nadando");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Especie: Pato, Puede nadar: {puedeNadar}");
    }
}

public class Aguila : Ave
{
    private double envergadura;
    
    public Aguila(string nombre, int edad, double envergadura) 
        : base(nombre, edad, true)
    {
        this.envergadura = envergadura;
    }
    
    public void Cazar()
    {
        Console.WriteLine($"{nombre} está cazando");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Especie: Águila, Envergadura: {envergadura}m");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("=== JERARQUÍA DE HERENCIA: Animales ===\n");
        
        Console.WriteLine("Estructura:");
        Console.WriteLine("Animal");
        Console.WriteLine("  ├── Mamifero");
        Console.WriteLine("  │     ├── Perro");
        Console.WriteLine("  │     └── Gato");
        Console.WriteLine("  └── Ave");
        Console.WriteLine("        ├── Pato");
        Console.WriteLine("        └── Aguila\n");
        
        Console.WriteLine("=== NIVEL 1: Animal Base ===");
        Animal animal = new Animal("Genérico", 5);
        animal.MostrarInformacion();
        animal.Comer();
        
        Console.WriteLine("\n=== NIVEL 2: Mamíferos ===");
        Mamifero mamifero = new Mamifero("Mamífero Genérico", 3, true);
        mamifero.MostrarInformacion();
        mamifero.Amamantar();
        
        Console.WriteLine("\n=== NIVEL 3: Perro (derivado de Mamífero) ===");
        Perro perro = new Perro("Max", 5, "Labrador");
        perro.MostrarInformacion();
        perro.Comer();      // Heredado de Animal
        perro.Amamantar();  // Heredado de Mamifero
        perro.Ladrar();     // Propio de Perro
        
        Console.WriteLine("\n=== NIVEL 3: Gato (derivado de Mamífero) ===");
        Gato gato = new Gato("Luna", 3, true);
        gato.MostrarInformacion();
        gato.Comer();
        gato.Maullar();
        
        Console.WriteLine("\n=== NIVEL 2: Aves ===");
        Ave ave = new Ave("Ave Genérica", 2, true);
        ave.MostrarInformacion();
        ave.Volar();
        
        Console.WriteLine("\n=== NIVEL 3: Pato (derivado de Ave) ===");
        Pato pato = new Pato("Donald", 1);
        pato.MostrarInformacion();
        pato.Comer();  // Heredado de Animal
        pato.Volar();  // Heredado de Ave
        pato.Nadar();  // Propio de Pato
        
        Console.WriteLine("\n=== NIVEL 3: Águila (derivado de Ave) ===");
        Aguila aguila = new Aguila("Águila Real", 10, 2.1);
        aguila.MostrarInformacion();
        aguila.Volar();
        aguila.Cazar();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo en Jerarquía ===");
        Animal[] animales = new Animal[]
        {
            new Perro("Perro 1", 3, "Golden"),
            new Gato("Gato 1", 2, true),
            new Pato("Pato 1", 1),
            new Aguila("Águila 1", 5, 1.8)
        };
        
        foreach (Animal a in animales)
        {
            a.MostrarInformacion();
            a.Comer();
            Console.WriteLine();
        }
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Mejores Prácticas de Herencia
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Mejores Prácticas de Herencia',
    'Aprende las mejores prácticas, principios de diseño y cuándo usar herencia vs composición.',
    'Usar herencia correctamente requiere seguir ciertos principios y prácticas establecidas. Aquí están las mejores prácticas:

**Principio de Sustitución de Liskov (LSP):**

Las clases derivadas deben ser **sustituibles** por sus clases base sin romper la funcionalidad:

```csharp
// BIEN: Perro puede usarse donde se espera Animal
Animal animal = new Perro();

// MAL: Si Perro rompe el comportamiento esperado de Animal
```

**Cuándo Usar Herencia:**

✅ **Usa Herencia cuando:**
- Hay una relación clara "es un" (is-a)
- Necesitas reutilizar código común
- Las clases derivadas son especializaciones de la base
- El comportamiento base es estable y no cambia frecuentemente

**Cuándo NO Usar Herencia:**

❌ **Evita Herencia cuando:**
- La relación es "tiene un" (has-a) - usa composición
- Solo necesitas reutilizar código - considera composición
- El comportamiento base cambia frecuentemente
- Necesitas herencia múltiple - usa interfaces

**Herencia vs Composición:**

**Herencia (es un):**
```csharp
public class Automovil : Vehiculo  // Automovil ES UN Vehiculo
{
}
```

**Composición (tiene un):**
```csharp
public class Automovil
{
    private Motor motor;  // Automovil TIENE UN Motor
}
```

**Regla de Oro:**

> "Favor composition over inheritance" (Prefiere composición sobre herencia)

**Buenas Prácticas:**

1. **Mantén la Jerarquía Simple**: 2-3 niveles son suficientes
2. **Usa `virtual` y `override` Correctamente**: Para permitir extensión
3. **Documenta la Relación**: Explica por qué una clase hereda de otra
4. **Evita Herencia Profunda**: Demasiados niveles son difíciles de mantener
5. **Usa `sealed` cuando sea Apropiado**: Para prevenir herencia no deseada
6. **Respetar LSP**: Las derivadas deben ser sustituibles

**Errores Comunes:**

❌ **Herencia para Reutilizar Código:**
```csharp
// MAL: Herencia solo para reutilizar código
public class Utilidades : Lista { }
```

✅ **Composición para Reutilizar:**
```csharp
// BIEN: Composición
public class Utilidades
{
    private Lista lista;
}
```

❌ **Herencia Profunda:**
```csharp
// MAL: Demasiados niveles
A -> B -> C -> D -> E -> F
```

✅ **Jerarquía Simple:**
```csharp
// BIEN: Pocos niveles
A -> B -> C
```

**Checklist de Mejores Prácticas:**

✅ La relación "es un" es verdadera
✅ La jerarquía tiene 2-3 niveles máximo
✅ Los métodos virtuales están bien diseñados
✅ Se respeta el principio LSP
✅ Se documenta la relación de herencia
✅ Se usa `sealed` cuando es apropiado
✅ Se prefiere composición cuando la relación es "tiene un"',
    'using System;
using System.Collections.Generic;

// ============================================
// EJEMPLO: Herencia Correcta (relación "es un")
// ============================================

// BIEN: Vehiculo es una clase base apropiada
public abstract class Vehiculo
{
    protected string marca;
    protected string modelo;
    
    public Vehiculo(string marca, string modelo)
    {
        this.marca = marca;
        this.modelo = modelo;
    }
    
    public abstract void Arrancar();
    public abstract void Detener();
    
    public virtual void MostrarInformacion()
    {
        Console.WriteLine($"Vehículo: {marca} {modelo}");
    }
}

// BIEN: Automovil ES UN Vehiculo
public class Automovil : Vehiculo
{
    private int numeroPuertas;
    
    public Automovil(string marca, string modelo, int numeroPuertas) 
        : base(marca, modelo)
    {
        this.numeroPuertas = numeroPuertas;
    }
    
    public override void Arrancar()
    {
        Console.WriteLine($"{marca} {modelo} ha arrancado");
    }
    
    public override void Detener()
    {
        Console.WriteLine($"{marca} {modelo} se ha detenido");
    }
    
    public override void MostrarInformacion()
    {
        base.MostrarInformacion();
        Console.WriteLine($"Puertas: {numeroPuertas}");
    }
}

// ============================================
// EJEMPLO: Composición (relación "tiene un")
// ============================================

// BIEN: Motor es un componente, no una clase base
public class Motor
{
    private int cilindrada;
    
    public Motor(int cilindrada)
    {
        this.cilindrada = cilindrada;
    }
    
    public void Encender()
    {
        Console.WriteLine($"Motor de {cilindrada}cc encendido");
    }
    
    public void Apagar()
    {
        Console.WriteLine("Motor apagado");
    }
}

// BIEN: Usar composición en lugar de herencia
public class VehiculoConMotor
{
    private string marca;
    private Motor motor;  // Composición: tiene un motor
    
    public VehiculoConMotor(string marca, int cilindrada)
    {
        this.marca = marca;
        motor = new Motor(cilindrada);
    }
    
    public void Arrancar()
    {
        Console.WriteLine($"{marca} está arrancando...");
        motor.Encender();
    }
    
    public void Detener()
    {
        motor.Apagar();
        Console.WriteLine($"{marca} se ha detenido");
    }
}

// ============================================
// EJEMPLO: Jerarquía Simple y Bien Diseñada
// ============================================

public class Empleado
{
    protected string nombre;
    protected double salarioBase;
    
    public Empleado(string nombre, double salarioBase)
    {
        this.nombre = nombre;
        this.salarioBase = salarioBase;
    }
    
    public virtual double CalcularSalario()
    {
        return salarioBase;
    }
    
    public virtual void Trabajar()
    {
        Console.WriteLine($"{nombre} está trabajando");
    }
}

// BIEN: Gerente ES UN Empleado (relación clara)
public class Gerente : Empleado
{
    private double bono;
    
    public Gerente(string nombre, double salarioBase, double bono) 
        : base(nombre, salarioBase)
    {
        this.bono = bono;
    }
    
    // Extiende el comportamiento sin romperlo
    public override double CalcularSalario()
    {
        return base.CalcularSalario() + bono;
    }
    
    public override void Trabajar()
    {
        base.Trabajar();
        Console.WriteLine($"{nombre} está supervisando");
    }
}

// BIEN: Desarrollador ES UN Empleado
public class Desarrollador : Empleado
{
    private string lenguaje;
    
    public Desarrollador(string nombre, double salarioBase, string lenguaje) 
        : base(nombre, salarioBase)
    {
        this.lenguaje = lenguaje;
    }
    
    public override void Trabajar()
    {
        base.Trabajar();
        Console.WriteLine($"{nombre} está programando en {lenguaje}");
    }
}

// ============================================
// EJEMPLO: Uso de sealed para Prevenir Herencia
// ============================================

// BIEN: Clase sealed cuando no debe ser heredada
public sealed class Configuracion
{
    private string nombre;
    
    public Configuracion(string nombre)
    {
        this.nombre = nombre;
    }
    
    public void Mostrar()
    {
        Console.WriteLine($"Configuración: {nombre}");
    }
}

class Program
{
    static void DemostrarPolimorfismo(Empleado empleado)
    {
        empleado.Trabajar();
        Console.WriteLine($"Salario: ${empleado.CalcularSalario():F2}");
    }
    
    static void Main()
    {
        Console.WriteLine("=== EJEMPLO: Herencia Correcta (es un) ===");
        Automovil auto = new Automovil("Toyota", "Corolla", 4);
        auto.Arrancar();
        auto.MostrarInformacion();
        
        Console.WriteLine("\n=== EJEMPLO: Composición (tiene un) ===");
        VehiculoConMotor vehiculo = new VehiculoConMotor("Honda", 2000);
        vehiculo.Arrancar();
        vehiculo.Detener();
        
        Console.WriteLine("\n=== EJEMPLO: Jerarquía Simple ===");
        Gerente gerente = new Gerente("Juan", 50000, 10000);
        Desarrollador dev = new Desarrollador("María", 60000, "C#");
        
        gerente.Trabajar();
        dev.Trabajar();
        
        Console.WriteLine("\n=== DEMOSTRACIÓN: Polimorfismo (LSP) ===");
        // Ambos pueden tratarse como Empleado
        DemostrarPolimorfismo(gerente);
        DemostrarPolimorfismo(dev);
        
        Console.WriteLine("\n=== EJEMPLO: Clase Sealed ===");
        Configuracion config = new Configuracion("Producción");
        config.Mostrar();
        
        Console.WriteLine("\n=== MEJORES PRÁCTICAS ===");
        Console.WriteLine("1. Usa herencia para relación es un");
        Console.WriteLine("2. Usa composición para relación tiene un");
        Console.WriteLine("3. Mantén jerarquías simples (2-3 niveles)");
        Console.WriteLine("4. Respeta el principio LSP");
        Console.WriteLine("5. Usa sealed cuando sea apropiado");
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
PRINT 'Lecciones del curso "Herencia":';
PRINT '1. Introducción a la Herencia';
PRINT '2. Sintaxis y Uso Básico de Herencia';
PRINT '3. Sobrescritura de Métodos (override)';
PRINT '4. Palabras Clave sealed y abstract';
PRINT '5. Herencia Múltiple y Interfaces';
PRINT '6. El Operador base';
PRINT '7. Jerarquías de Herencia';
PRINT '8. Mejores Prácticas de Herencia';
GO

