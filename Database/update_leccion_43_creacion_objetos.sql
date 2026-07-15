UPDATE Lecciones
SET
  DescripcionCorta = 'Aprende cómo crear objetos a partir de clases usando el operador new y cómo inicializar sus valores.',
  ContenidoBreve = 'Crear un objeto es el proceso de **instanciar** una clase. Esto significa crear una copia concreta de la clase con sus propios valores de datos.

## Sintaxis para crear objetos

```csharp
// Forma 1: Declaración e instanciación separadas
NombreClase objeto;
objeto = new NombreClase();

// Forma 2: Declaración e instanciación en una línea
NombreClase objeto = new NombreClase();
```

## El operador `new`

El operador `new` realiza tres acciones importantes:

1. **Asigna memoria** para el nuevo objeto.
2. **Inicializa los campos** con valores por defecto.
3. **Llama al constructor** de la clase (si existe).

## Valores por defecto

Cuando creas un objeto, los campos se inicializan con valores por defecto:

- `int`, `double`, `float`, etc. -> `0`
- `bool` -> `false`
- `string` y objetos -> `null`
- `char` -> `\0`

## Acceso a miembros

Una vez creado el objeto, puedes acceder a sus miembros públicos usando el operador punto (`.`):

```csharp
objeto.campo = valor;
objeto.Metodo();
```

## Múltiples instancias

Cada objeto es independiente. Puedes crear múltiples instancias de la misma clase, cada una con sus propios valores:

```csharp
Persona persona1 = new Persona();
persona1.Nombre = "Juan";

Persona persona2 = new Persona();
persona2.Nombre = "María";

// persona1 y persona2 son objetos diferentes
```

## Referencias vs valores

Los objetos en C# son tipos de referencia. Cuando asignas un objeto a otra variable, ambas apuntan al mismo objeto en memoria:

```csharp
Persona p1 = new Persona();
Persona p2 = p1; // p2 apunta al mismo objeto que p1
p1.Nombre = "Juan";
Console.WriteLine(p2.Nombre); // Imprime "Juan"
```

## Inicialización de objetos

Puedes inicializar campos públicos directamente al crear el objeto (si la clase lo permite):

```csharp
Persona persona = new Persona
{
    Nombre = "Juan",
    Edad = 25
};
```',
  CodigoEjemplo = 'using System;

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
}'
WHERE LeccionId = 52;
