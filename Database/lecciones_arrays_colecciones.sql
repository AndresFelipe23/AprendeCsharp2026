-- ============================================
-- SCRIPT PARA INSERTAR LECCIONES DEL CURSO
-- "Arrays y Colecciones"
-- ============================================

USE LenguajeCsharp
GO

-- Obtener el CursoId del curso "Arrays y Colecciones"
-- NOTA: Reemplaza @CursoId con el ID real del curso "Arrays y Colecciones"
-- Puedes obtenerlo ejecutando: SELECT CursoId FROM Cursos WHERE Nombre = 'Arrays y Colecciones'

DECLARE @CursoId INT;
SELECT @CursoId = CursoId 
FROM Cursos 
WHERE Nombre = 'Arrays y Colecciones';

-- Verificar que el curso existe
IF @CursoId IS NULL
BEGIN
    PRINT 'ERROR: No se encontró el curso "Arrays y Colecciones"';
    PRINT 'Por favor, asegúrate de que el curso existe en la base de datos.';
    PRINT 'Puedes crearlo primero o usar el CursoId directamente en las inserciones.';
    RETURN;
END

PRINT 'Insertando lecciones para el curso "Arrays y Colecciones" (CursoId: ' + CAST(@CursoId AS VARCHAR) + ')';

-- ============================================
-- LECCIÓN 1: Introducción a Arrays
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Introducción a Arrays',
    'Aprende qué son los arrays, cómo declararlos y utilizarlos para almacenar múltiples valores del mismo tipo.',
    'Un **array** (arreglo) es una estructura de datos que almacena una colección de elementos del mismo tipo en posiciones de memoria contiguas. Cada elemento se accede mediante un índice numérico que comienza en 0.

**Características de los arrays:**

- **Tamaño fijo**: Una vez creado, el tamaño no puede cambiar
- **Tipo homogéneo**: Todos los elementos deben ser del mismo tipo
- **Índices basados en 0**: El primer elemento está en el índice 0
- **Acceso rápido**: Acceso directo a cualquier elemento por su índice
- **Memoria contigua**: Los elementos se almacenan en posiciones de memoria consecutivas

**Sintaxis:**

```csharp
// Declaración
tipo[] nombreArray;

// Inicialización con tamaño
tipo[] nombreArray = new tipo[tamaño];

// Inicialización con valores
tipo[] nombreArray = { valor1, valor2, valor3 };
```

**Propiedades importantes:**

- `Length`: Devuelve el número de elementos en el array
- `Rank`: Devuelve el número de dimensiones (1 para arrays unidimensionales)

**Ventajas:**

- Acceso rápido a elementos por índice
- Eficiente en memoria
- Fácil de usar para datos de tamaño conocido

**Desventajas:**

- Tamaño fijo (no se puede redimensionar)
- No hay métodos de búsqueda o inserción integrados',
    'using System;

class Program
{
    static void Main()
    {
        // Declarar e inicializar array de enteros
        int[] numeros = new int[5]; // Array de 5 elementos
        
        // Asignar valores
        numeros[0] = 10;
        numeros[1] = 20;
        numeros[2] = 30;
        numeros[3] = 40;
        numeros[4] = 50;
        
        Console.WriteLine("Array de enteros:");
        for (int i = 0; i < numeros.Length; i++)
        {
            Console.WriteLine($"numeros[{i}] = {numeros[i]}");
        }
        
        // Inicializar array con valores
        int[] numeros2 = { 1, 2, 3, 4, 5 };
        Console.WriteLine("\nArray inicializado con valores:");
        foreach (int num in numeros2)
        {
            Console.WriteLine(num);
        }
        
        // Array de strings
        string[] nombres = { "Ana", "Luis", "María", "Carlos" };
        Console.WriteLine("\nArray de nombres:");
        foreach (string nombre in nombres)
        {
            Console.WriteLine(nombre);
        }
        
        // Array de caracteres
        char[] letras = { ''A'', ''B'', ''C'', ''D'' };
        Console.WriteLine("\nArray de letras:");
        foreach (char letra in letras)
        {
            Console.WriteLine(letra);
        }
        
        // Propiedad Length
        Console.WriteLine($"\nTamaño del array nombres: {nombres.Length}");
        
        // Acceder a elementos
        Console.WriteLine($"Primer elemento: {nombres[0]}");
        Console.WriteLine($"Último elemento: {nombres[nombres.Length - 1]}");
        
        // Modificar elementos
        numeros[0] = 100;
        Console.WriteLine($"\nPrimer número modificado: {numeros[0]}");
    }
}',
    1,
    1
);

-- ============================================
-- LECCIÓN 2: Arrays Multidimensionales
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Arrays Multidimensionales',
    'Aprende a trabajar con arrays de dos y tres dimensiones para representar matrices y estructuras más complejas.',
    'Los **arrays multidimensionales** son arrays que tienen más de una dimensión. Los más comunes son los arrays bidimensionales (matrices) y tridimensionales.

**Tipos de arrays multidimensionales:**

1. **Arrays rectangulares (multidimensionales)**: Todas las filas tienen el mismo número de columnas
2. **Arrays escalonados (jagged)**: Cada fila puede tener diferente número de columnas

**Sintaxis de arrays bidimensionales:**

```csharp
// Declaración
tipo[,] matriz = new tipo[filas, columnas];

// Inicialización con valores
tipo[,] matriz = { {1, 2}, {3, 4} };
```

**Sintaxis de arrays tridimensionales:**

```csharp
tipo[,,] cubo = new tipo[x, y, z];
```

**Arrays escalonados (Jagged Arrays):**

```csharp
tipo[][] arrayEscalonado = new tipo[filas][];
arrayEscalonado[0] = new tipo[columnas1];
arrayEscalonado[1] = new tipo[columnas2];
```

**Cuándo usar cada uno:**

- **Arrays multidimensionales**: Cuando necesitas una estructura rectangular (tablas, matrices)
- **Arrays escalonados**: Cuando cada fila puede tener diferente tamaño (más flexible)

**Propiedades:**

- `GetLength(dimensión)`: Obtiene el tamaño de una dimensión específica
- `Rank`: Devuelve el número de dimensiones',
    'using System;

class Program
{
    static void Main()
    {
        // ===== ARRAYS BIDIMENSIONALES (MATRICES) =====
        Console.WriteLine("=== ARRAYS BIDIMENSIONALES ===\n");
        
        // Declarar matriz 3x4
        int[,] matriz = new int[3, 4];
        
        // Llenar matriz
        int valor = 1;
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                matriz[i, j] = valor++;
            }
        }
        
        // Imprimir matriz
        Console.WriteLine("Matriz 3x4:");
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                Console.Write($"{matriz[i, j],4} ");
            }
            Console.WriteLine();
        }
        
        // Inicializar matriz con valores
        int[,] matriz2 = {
            { 1, 2, 3 },
            { 4, 5, 6 },
            { 7, 8, 9 }
        };
        
        Console.WriteLine("\nMatriz inicializada:");
        for (int i = 0; i < matriz2.GetLength(0); i++)
        {
            for (int j = 0; j < matriz2.GetLength(1); j++)
            {
                Console.Write($"{matriz2[i, j]} ");
            }
            Console.WriteLine();
        }
        
        // ===== ARRAYS TRIDIMENSIONALES =====
        Console.WriteLine("\n=== ARRAYS TRIDIMENSIONALES ===\n");
        
        int[,,] cubo = new int[2, 2, 2];
        int contador = 1;
        
        for (int x = 0; x < 2; x++)
        {
            for (int y = 0; y < 2; y++)
            {
                for (int z = 0; z < 2; z++)
                {
                    cubo[x, y, z] = contador++;
                }
            }
        }
        
        Console.WriteLine("Cubo 2x2x2:");
        for (int x = 0; x < 2; x++)
        {
            Console.WriteLine($"Capa {x}:");
            for (int y = 0; y < 2; y++)
            {
                for (int z = 0; z < 2; z++)
                {
                    Console.Write($"{cubo[x, y, z]} ");
                }
                Console.WriteLine();
            }
        }
        
        // ===== ARRAYS ESCALONADOS (JAGGED) =====
        Console.WriteLine("\n=== ARRAYS ESCALONADOS ===\n");
        
        // Cada fila puede tener diferente tamaño
        int[][] arrayEscalonado = new int[3][];
        arrayEscalonado[0] = new int[] { 1, 2, 3 };
        arrayEscalonado[1] = new int[] { 4, 5 };
        arrayEscalonado[2] = new int[] { 6, 7, 8, 9 };
        
        Console.WriteLine("Array escalonado:");
        for (int i = 0; i < arrayEscalonado.Length; i++)
        {
            Console.Write($"Fila {i}: ");
            for (int j = 0; j < arrayEscalonado[i].Length; j++)
            {
                Console.Write($"{arrayEscalonado[i][j]} ");
            }
            Console.WriteLine();
        }
        
        // Propiedades
        Console.WriteLine($"\nDimensiones de matriz: {matriz.Rank}");
        Console.WriteLine($"Filas de matriz: {matriz.GetLength(0)}");
        Console.WriteLine($"Columnas de matriz: {matriz.GetLength(1)}");
    }
}',
    2,
    1
);

-- ============================================
-- LECCIÓN 3: List<T> - Listas Genéricas
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'List<T> - Listas Genéricas',
    'Domina las listas genéricas, una colección dinámica que puede crecer o reducirse según sea necesario.',
    '**List<T>** es una colección genérica que representa una lista de objetos que pueden ser accedidos por índice. A diferencia de los arrays, las listas pueden cambiar de tamaño dinámicamente.

**Ventajas sobre arrays:**

- **Tamaño dinámico**: Puede crecer o reducirse automáticamente
- **Métodos útiles**: Add, Remove, Contains, Find, etc.
- **Más flexible**: Fácil de agregar, eliminar y buscar elementos

**Sintaxis:**

```csharp
List<tipo> lista = new List<tipo>();
List<tipo> lista = new List<tipo> { valor1, valor2, valor3 };
```

**Métodos comunes:**

- `Add(elemento)`: Agrega un elemento al final
- `Remove(elemento)`: Elimina la primera ocurrencia
- `RemoveAt(índice)`: Elimina el elemento en el índice
- `Contains(elemento)`: Verifica si contiene el elemento
- `Count`: Propiedad que devuelve el número de elementos
- `Clear()`: Elimina todos los elementos
- `IndexOf(elemento)`: Devuelve el índice del elemento
- `Insert(índice, elemento)`: Inserta un elemento en una posición
- `Sort()`: Ordena la lista

**Cuándo usar List<T>:**

- Cuando necesitas agregar/eliminar elementos frecuentemente
- Cuando el tamaño es desconocido al inicio
- Cuando necesitas métodos de búsqueda y manipulación',
    'using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Crear lista vacía
        List<int> numeros = new List<int>();
        
        // Agregar elementos
        numeros.Add(10);
        numeros.Add(20);
        numeros.Add(30);
        numeros.Add(40);
        
        Console.WriteLine("Lista inicial:");
        foreach (int num in numeros)
        {
            Console.WriteLine(num);
        }
        
        // Inicializar lista con valores
        List<string> nombres = new List<string> { "Ana", "Luis", "María" };
        Console.WriteLine($"\nNombres: {string.Join(", ", nombres)}");
        
        // Propiedad Count
        Console.WriteLine($"\nCantidad de números: {numeros.Count}");
        Console.WriteLine($"Cantidad de nombres: {nombres.Count}");
        
        // Acceder por índice
        Console.WriteLine($"\nPrimer número: {numeros[0]}");
        Console.WriteLine($"Último nombre: {nombres[nombres.Count - 1]}");
        
        // Insertar elemento en posición específica
        numeros.Insert(2, 25);
        Console.WriteLine("\nDespués de insertar 25 en índice 2:");
        foreach (int num in numeros)
        {
            Console.WriteLine(num);
        }
        
        // Verificar si contiene un elemento
        Console.WriteLine($"\n¿Contiene 30? {numeros.Contains(30)}");
        Console.WriteLine($"¿Contiene 100? {numeros.Contains(100)}");
        
        // Buscar índice
        int indice = numeros.IndexOf(30);
        Console.WriteLine($"Índice de 30: {indice}");
        
        // Eliminar elemento
        numeros.Remove(25);
        Console.WriteLine("\nDespués de eliminar 25:");
        foreach (int num in numeros)
        {
            Console.WriteLine(num);
        }
        
        // Eliminar por índice
        numeros.RemoveAt(0);
        Console.WriteLine("\nDespués de eliminar el primer elemento:");
        foreach (int num in numeros)
        {
            Console.WriteLine(num);
        }
        
        // Ordenar lista
        List<int> numerosDesordenados = new List<int> { 5, 2, 8, 1, 9, 3 };
        Console.WriteLine("\nLista desordenada:");
        foreach (int num in numerosDesordenados)
        {
            Console.Write($"{num} ");
        }
        
        numerosDesordenados.Sort();
        Console.WriteLine("\nLista ordenada:");
        foreach (int num in numerosDesordenados)
        {
            Console.Write($"{num} ");
        }
        
        // Buscar elementos
        int encontrado = numerosDesordenados.Find(x => x > 5);
        Console.WriteLine($"\nPrimer número mayor que 5: {encontrado}");
        
        // Limpiar lista
        numeros.Clear();
        Console.WriteLine($"\nDespués de Clear(), cantidad: {numeros.Count}");
    }
}',
    3,
    1
);

-- ============================================
-- LECCIÓN 4: Dictionary<TKey, TValue>
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Dictionary<TKey, TValue>',
    'Aprende a usar diccionarios para almacenar pares clave-valor y acceder a datos de forma eficiente.',
    'Un **Dictionary<TKey, TValue>** es una colección que almacena pares clave-valor. A diferencia de las listas que usan índices numéricos, los diccionarios usan claves de cualquier tipo para acceder a los valores.

**Características:**

- **Acceso rápido**: Búsqueda muy eficiente por clave
- **Claves únicas**: Cada clave solo puede aparecer una vez
- **Tipo genérico**: Tanto la clave como el valor pueden ser de cualquier tipo
- **No ordenado**: Los elementos no tienen un orden garantizado (aunque se mantiene el orden de inserción en .NET Core)

**Sintaxis:**

```csharp
Dictionary<tipoClave, tipoValor> diccionario = new Dictionary<tipoClave, tipoValor>();
```

**Métodos y propiedades comunes:**

- `Add(clave, valor)`: Agrega un par clave-valor
- `[clave]`: Accede o asigna un valor por clave
- `ContainsKey(clave)`: Verifica si existe una clave
- `ContainsValue(valor)`: Verifica si existe un valor
- `Remove(clave)`: Elimina un elemento por clave
- `Count`: Número de elementos
- `Keys`: Colección de todas las claves
- `Values`: Colección de todos los valores
- `TryGetValue(clave, out valor)`: Obtiene valor de forma segura

**Cuándo usar Dictionary:**

- Cuando necesitas buscar por una clave específica
- Para representar relaciones uno-a-uno
- Cuando la clave no es un número secuencial
- Para crear índices o mapeos',
    'using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Crear diccionario vacío
        Dictionary<string, int> edades = new Dictionary<string, int>();
        
        // Agregar elementos
        edades.Add("Juan", 25);
        edades.Add("María", 30);
        edades.Add("Pedro", 28);
        
        Console.WriteLine("=== DICCIONARIO BÁSICO ===\n");
        
        // Acceder a valores por clave
        Console.WriteLine($"Edad de Juan: {edades["Juan"]}");
        Console.WriteLine($"Edad de María: {edades["María"]}");
        
        // Agregar usando índice
        edades["Ana"] = 22;
        edades["Luis"] = 35;
        
        // Modificar valor existente
        edades["Juan"] = 26;
        Console.WriteLine($"\nEdad actualizada de Juan: {edades["Juan"]}");
        
        // Verificar si existe una clave
        Console.WriteLine($"\n¿Existe ''Carlos''? {edades.ContainsKey("Carlos")}");
        Console.WriteLine($"¿Existe ''Ana''? {edades.ContainsKey("Ana")}");
        
        // Verificar si existe un valor
        Console.WriteLine($"¿Existe edad 30? {edades.ContainsValue(30)}");
        
        // Obtener valor de forma segura
        if (edades.TryGetValue("Pedro", out int edadPedro))
        {
            Console.WriteLine($"Edad de Pedro: {edadPedro}");
        }
        
        // Iterar sobre el diccionario
        Console.WriteLine("\n=== ITERAR SOBRE DICCIONARIO ===");
        foreach (KeyValuePair<string, int> par in edades)
        {
            Console.WriteLine($"{par.Key}: {par.Value} años");
        }
        
        // Iterar solo sobre claves
        Console.WriteLine("\nClaves:");
        foreach (string nombre in edades.Keys)
        {
            Console.WriteLine(nombre);
        }
        
        // Iterar solo sobre valores
        Console.WriteLine("\nValores:");
        foreach (int edad in edades.Values)
        {
            Console.WriteLine(edad);
        }
        
        // Eliminar elemento
        edades.Remove("Pedro");
        Console.WriteLine($"\nDespués de eliminar Pedro, cantidad: {edades.Count}");
        
        // Diccionario con diferentes tipos
        Dictionary<int, string> codigos = new Dictionary<int, string>
        {
            { 1, "Uno" },
            { 2, "Dos" },
            { 3, "Tres" }
        };
        
        Console.WriteLine("\n=== DICCIONARIO INT-STRING ===");
        foreach (var par in codigos)
        {
            Console.WriteLine($"{par.Key}: {par.Value}");
        }
        
        // Diccionario anidado
        Dictionary<string, Dictionary<string, int>> estudiantes = new Dictionary<string, Dictionary<string, int>>
        {
            { "Matemáticas", new Dictionary<string, int> { { "Juan", 85 }, { "María", 90 } } },
            { "Ciencias", new Dictionary<string, int> { { "Juan", 78 }, { "María", 92 } } }
        };
        
        Console.WriteLine("\n=== DICCIONARIO ANIDADO ===");
        foreach (var materia in estudiantes)
        {
            Console.WriteLine($"{materia.Key}:");
            foreach (var estudiante in materia.Value)
            {
                Console.WriteLine($"  {estudiante.Key}: {estudiante.Value}");
            }
        }
    }
}',
    4,
    1
);

-- ============================================
-- LECCIÓN 5: HashSet<T> y SortedSet<T>
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'HashSet<T> y SortedSet<T>',
    'Aprende a usar conjuntos para almacenar elementos únicos y realizar operaciones de conjunto eficientemente.',
    'Los **conjuntos** son colecciones que almacenan elementos únicos, sin duplicados. C# proporciona `HashSet<T>` y `SortedSet<T>` para trabajar con conjuntos.

**HashSet<T>:**

- Almacena elementos únicos
- No mantiene orden específico
- Operaciones muy rápidas (Add, Remove, Contains)
- Ideal para verificar pertenencia y eliminar duplicados

**SortedSet<T>:**

- Similar a HashSet pero mantiene los elementos ordenados
- Más lento que HashSet pero garantiza orden
- Útil cuando necesitas elementos únicos y ordenados

**Operaciones de conjunto:**

- `UnionWith(otroConjunto)`: Une dos conjuntos
- `IntersectWith(otroConjunto)`: Intersección (elementos comunes)
- `ExceptWith(otroConjunto)`: Diferencia (elementos en A pero no en B)
- `IsSubsetOf(otroConjunto)`: Verifica si es subconjunto
- `IsSupersetOf(otroConjunto)`: Verifica si es superconjunto

**Cuándo usar:**

- Eliminar duplicados de una colección
- Verificar pertenencia rápidamente
- Operaciones matemáticas de conjuntos
- Cuando el orden no importa (HashSet) o cuando sí importa (SortedSet)',
    'using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    static void Main()
    {
        // ===== HASHSET =====
        Console.WriteLine("=== HASHSET<T> ===\n");
        
        HashSet<int> numeros = new HashSet<int>();
        
        // Agregar elementos (duplicados se ignoran)
        numeros.Add(1);
        numeros.Add(2);
        numeros.Add(3);
        numeros.Add(2); // Duplicado, se ignora
        numeros.Add(4);
        
        Console.WriteLine("Elementos del HashSet:");
        foreach (int num in numeros)
        {
            Console.WriteLine(num);
        }
        
        // Verificar pertenencia
        Console.WriteLine($"\n¿Contiene 3? {numeros.Contains(3)}");
        Console.WriteLine($"¿Contiene 5? {numeros.Contains(5)}");
        
        // Eliminar duplicados de una lista
        List<int> listaConDuplicados = new List<int> { 1, 2, 2, 3, 3, 3, 4, 5 };
        HashSet<int> sinDuplicados = new HashSet<int>(listaConDuplicados);
        
        Console.WriteLine("\nLista original:");
        foreach (int num in listaConDuplicados)
        {
            Console.Write($"{num} ");
        }
        
        Console.WriteLine("\nSin duplicados:");
        foreach (int num in sinDuplicados)
        {
            Console.Write($"{num} ");
        }
        
        // ===== SORTEDSET =====
        Console.WriteLine("\n\n=== SORTEDSET<T> ===\n");
        
        SortedSet<int> numerosOrdenados = new SortedSet<int> { 5, 2, 8, 1, 9, 3 };
        
        Console.WriteLine("Elementos ordenados automáticamente:");
        foreach (int num in numerosOrdenados)
        {
            Console.Write($"{num} ");
        }
        
        // ===== OPERACIONES DE CONJUNTO =====
        Console.WriteLine("\n\n=== OPERACIONES DE CONJUNTO ===\n");
        
        HashSet<int> conjuntoA = new HashSet<int> { 1, 2, 3, 4, 5 };
        HashSet<int> conjuntoB = new HashSet<int> { 4, 5, 6, 7, 8 };
        
        Console.WriteLine("Conjunto A: " + string.Join(", ", conjuntoA));
        Console.WriteLine("Conjunto B: " + string.Join(", ", conjuntoB));
        
        // Unión (elementos en A o B)
        HashSet<int> union = new HashSet<int>(conjuntoA);
        union.UnionWith(conjuntoB);
        Console.WriteLine($"\nUnión (A ∪ B): {string.Join(", ", union)}");
        
        // Intersección (elementos en A y B)
        HashSet<int> interseccion = new HashSet<int>(conjuntoA);
        interseccion.IntersectWith(conjuntoB);
        Console.WriteLine($"Intersección (A ∩ B): {string.Join(", ", interseccion)}");
        
        // Diferencia (elementos en A pero no en B)
        HashSet<int> diferencia = new HashSet<int>(conjuntoA);
        diferencia.ExceptWith(conjuntoB);
        Console.WriteLine($"Diferencia (A - B): {string.Join(", ", diferencia)}");
        
        // Verificar subconjunto
        HashSet<int> subconjunto = new HashSet<int> { 2, 3 };
        Console.WriteLine($"\n¿{{2, 3}} es subconjunto de A? {subconjunto.IsSubsetOf(conjuntoA)}");
        Console.WriteLine($"¿A es superconjunto de {{2, 3}}? {conjuntoA.IsSupersetOf(subconjunto)}");
        
        // ===== HASHSET CON STRINGS =====
        Console.WriteLine("\n=== HASHSET CON STRINGS ===\n");
        
        HashSet<string> nombres = new HashSet<string> { "Ana", "Luis", "María" };
        nombres.Add("Ana"); // Duplicado, se ignora
        
        Console.WriteLine("Nombres únicos:");
        foreach (string nombre in nombres)
        {
            Console.WriteLine(nombre);
        }
        
        // Verificar si un nombre ya existe antes de agregar
        string nuevoNombre = "Carlos";
        if (nombres.Add(nuevoNombre))
        {
            Console.WriteLine($"{nuevoNombre} agregado exitosamente");
        }
        else
        {
            Console.WriteLine($"{nuevoNombre} ya existe");
        }
    }
}',
    5,
    1
);

-- ============================================
-- LECCIÓN 6: Queue<T> y Stack<T>
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Queue<T> y Stack<T>',
    'Aprende a usar colas (FIFO) y pilas (LIFO) para manejar datos en orden específico.',
    '**Queue<T>** (Cola) y **Stack<T>** (Pila) son estructuras de datos especializadas que siguen principios específicos de ordenamiento.

**Queue<T> - Cola (FIFO - First In, First Out):**

- El primer elemento en entrar es el primero en salir
- Como una fila de personas: quien llega primero, se atiende primero
- Operaciones: `Enqueue` (agregar al final), `Dequeue` (quitar del inicio), `Peek` (ver sin quitar)

**Stack<T> - Pila (LIFO - Last In, First Out):**

- El último elemento en entrar es el primero en salir
- Como una pila de platos: el último que pones es el primero que sacas
- Operaciones: `Push` (agregar arriba), `Pop` (quitar de arriba), `Peek` (ver sin quitar)

**Cuándo usar Queue:**

- Procesamiento de tareas en orden
- Simulación de filas
- Algoritmos de búsqueda en amplitud (BFS)
- Buffers de datos

**Cuándo usar Stack:**

- Evaluación de expresiones
- Algoritmos de búsqueda en profundidad (DFS)
- Deshacer/Rehacer funcionalidades
- Navegación de historial
- Validación de paréntesis y expresiones',
    'using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // ===== QUEUE (COLA) - FIFO =====
        Console.WriteLine("=== QUEUE<T> - COLA (FIFO) ===\n");
        
        Queue<string> cola = new Queue<string>();
        
        // Enqueue: Agregar al final de la cola
        cola.Enqueue("Primera persona");
        cola.Enqueue("Segunda persona");
        cola.Enqueue("Tercera persona");
        
        Console.WriteLine("Personas en la cola:");
        foreach (string persona in cola)
        {
            Console.WriteLine($"  - {persona}");
        }
        
        // Peek: Ver el primero sin quitarlo
        Console.WriteLine($"\nPrimero en la cola (sin quitar): {cola.Peek()}");
        
        // Dequeue: Quitar y devolver el primero
        Console.WriteLine("\nAtendiendo personas:");
        while (cola.Count > 0)
        {
            string persona = cola.Dequeue();
            Console.WriteLine($"Atendiendo: {persona}");
        }
        
        // ===== STACK (PILA) - LIFO =====
        Console.WriteLine("\n=== STACK<T> - PILA (LIFO) ===\n");
        
        Stack<string> pila = new Stack<string>();
        
        // Push: Agregar arriba de la pila
        pila.Push("Plato 1");
        pila.Push("Plato 2");
        pila.Push("Plato 3");
        
        Console.WriteLine("Platos en la pila:");
        foreach (string plato in pila)
        {
            Console.WriteLine($"  - {plato}");
        }
        
        // Peek: Ver el de arriba sin quitarlo
        Console.WriteLine($"\nPlato de arriba (sin quitar): {pila.Peek()}");
        
        // Pop: Quitar y devolver el de arriba
        Console.WriteLine("\nSacando platos:");
        while (pila.Count > 0)
        {
            string plato = pila.Pop();
            Console.WriteLine($"Sacando: {plato}");
        }
        
        // ===== EJEMPLO PRÁCTICO: VALIDAR PARÉNTESIS =====
        Console.WriteLine("\n=== VALIDAR PARÉNTESIS CON STACK ===\n");
        
        bool ValidarParentesis(string expresion)
        {
            Stack<char> pila = new Stack<char>();
            
            foreach (char caracter in expresion)
            {
                if (caracter == ''('' || caracter == ''['' || caracter == ''{'')
                {
                    pila.Push(caracter);
                }
                else if (caracter == '')'' || caracter == '']'' || caracter == ''}'')
                {
                    if (pila.Count == 0)
                        return false;
                    
                    char abierto = pila.Pop();
                    if ((caracter == '')'' && abierto != ''('') ||
                        (caracter == '']'' && abierto != ''['') ||
                        (caracter == ''}'' && abierto != ''{''))
                    {
                        return false;
                    }
                }
            }
            
            return pila.Count == 0;
        }
        
        string[] expresiones = { "()", "(())", "([{}])", "([)]", "(((" };
        
        foreach (string expr in expresiones)
        {
            bool valida = ValidarParentesis(expr);
            Console.WriteLine($"{expr}: {(valida ? "Válida" : "Inválida")}");
        }
        
        // ===== EJEMPLO: PROCESAMIENTO DE TAREAS CON QUEUE =====
        Console.WriteLine("\n=== PROCESAMIENTO DE TAREAS ===\n");
        
        Queue<string> tareas = new Queue<string>();
        tareas.Enqueue("Tarea 1: Revisar código");
        tareas.Enqueue("Tarea 2: Escribir documentación");
        tareas.Enqueue("Tarea 3: Probar aplicación");
        
        Console.WriteLine("Procesando tareas en orden:");
        int numeroTarea = 1;
        while (tareas.Count > 0)
        {
            string tarea = tareas.Dequeue();
            Console.WriteLine($"{numeroTarea}. {tarea}");
            numeroTarea++;
        }
        
        // ===== EJEMPLO: HISTORIAL CON STACK =====
        Console.WriteLine("\n=== HISTORIAL DE NAVEGACIÓN ===\n");
        
        Stack<string> historial = new Stack<string>();
        historial.Push("Página Inicio");
        historial.Push("Página Productos");
        historial.Push("Página Detalles");
        
        Console.WriteLine("Navegando hacia atrás:");
        while (historial.Count > 0)
        {
            string pagina = historial.Pop();
            Console.WriteLine($"Volviendo a: {pagina}");
        }
    }
}',
    6,
    1
);

-- ============================================
-- LECCIÓN 7: Operaciones con Colecciones
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Operaciones con Colecciones',
    'Aprende a realizar operaciones comunes como ordenar, buscar, filtrar y transformar colecciones.',
    'Las colecciones en C# proporcionan muchos métodos útiles para manipular y consultar datos. Aprender estos métodos te permitirá trabajar eficientemente con colecciones.

**Operaciones comunes:**

1. **Ordenamiento:**
   - `Sort()`: Ordena una lista in-place
   - `OrderBy()`: Ordena y devuelve una nueva secuencia
   - `OrderByDescending()`: Ordena descendente

2. **Búsqueda:**
   - `Find()`: Encuentra el primer elemento que cumple condición
   - `FindAll()`: Encuentra todos los elementos que cumplen condición
   - `Where()`: Filtra elementos (LINQ)
   - `First()`, `Last()`: Primer/último elemento
   - `Any()`, `All()`: Verifica si algún/todos cumplen condición

3. **Transformación:**
   - `Select()`: Transforma cada elemento
   - `SelectMany()`: Aplana colecciones anidadas

4. **Agregación:**
   - `Sum()`, `Average()`, `Max()`, `Min()`: Operaciones matemáticas
   - `Count()`: Cuenta elementos
   - `Aggregate()`: Operación personalizada

5. **Agrupación:**
   - `GroupBy()`: Agrupa elementos por clave

**LINQ (Language Integrated Query):**

LINQ proporciona una sintaxis unificada para consultar diferentes tipos de colecciones. Puedes usar sintaxis de método o sintaxis de consulta.',
    'using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    static void Main()
    {
        List<int> numeros = new List<int> { 5, 2, 8, 1, 9, 3, 7, 4, 6 };
        
        Console.WriteLine("=== OPERACIONES CON COLECCIONES ===\n");
        Console.WriteLine($"Lista original: {string.Join(", ", numeros)}\n");
        
        // ===== ORDENAMIENTO =====
        Console.WriteLine("=== ORDENAMIENTO ===\n");
        
        // Sort in-place
        List<int> copia1 = new List<int>(numeros);
        copia1.Sort();
        Console.WriteLine($"Sort(): {string.Join(", ", copia1)}");
        
        // OrderBy (no modifica la original)
        var ordenados = numeros.OrderBy(x => x);
        Console.WriteLine($"OrderBy(): {string.Join(", ", ordenados)}");
        
        // OrderByDescending
        var descendente = numeros.OrderByDescending(x => x);
        Console.WriteLine($"OrderByDescending(): {string.Join(", ", descendente)}");
        
        // ===== BÚSQUEDA =====
        Console.WriteLine("\n=== BÚSQUEDA ===\n");
        
        // Find: primer elemento que cumple condición
        int mayorQue5 = numeros.Find(x => x > 5);
        Console.WriteLine($"Primer número > 5: {mayorQue5}");
        
        // FindAll: todos los que cumplen condición
        List<int> pares = numeros.FindAll(x => x % 2 == 0);
        Console.WriteLine($"Números pares: {string.Join(", ", pares)}");
        
        // Where (LINQ): similar a FindAll pero más flexible
        var mayoresQue5 = numeros.Where(x => x > 5);
        Console.WriteLine($"Números > 5: {string.Join(", ", mayoresQue5)}");
        
        // First y Last
        Console.WriteLine($"Primer elemento: {numeros.First()}");
        Console.WriteLine($"Último elemento: {numeros.Last()}");
        
        // Any y All
        Console.WriteLine($"¿Hay números > 10? {numeros.Any(x => x > 10)}");
        Console.WriteLine($"¿Todos son > 0? {numeros.All(x => x > 0)}");
        
        // Contains
        Console.WriteLine($"¿Contiene 5? {numeros.Contains(5)}");
        
        // ===== TRANSFORMACIÓN =====
        Console.WriteLine("\n=== TRANSFORMACIÓN ===\n");
        
        // Select: transformar cada elemento
        var cuadrados = numeros.Select(x => x * x);
        Console.WriteLine($"Cuadrados: {string.Join(", ", cuadrados)}");
        
        var comoString = numeros.Select(x => $"Número: {x}");
        foreach (string str in comoString)
        {
            Console.WriteLine(str);
        }
        
        // ===== AGREGACIÓN =====
        Console.WriteLine("\n=== AGREGACIÓN ===\n");
        
        Console.WriteLine($"Suma: {numeros.Sum()}");
        Console.WriteLine($"Promedio: {numeros.Average():F2}");
        Console.WriteLine($"Máximo: {numeros.Max()}");
        Console.WriteLine($"Mínimo: {numeros.Min()}");
        Console.WriteLine($"Cantidad: {numeros.Count()}");
        
        // Aggregate: operación personalizada
        int producto = numeros.Aggregate(1, (acc, x) => acc * x);
        Console.WriteLine($"Producto de todos: {producto}");
        
        // ===== FILTRADO Y TRANSFORMACIÓN COMBINADOS =====
        Console.WriteLine("\n=== FILTRADO Y TRANSFORMACIÓN ===\n");
        
        var paresAlCuadrado = numeros
            .Where(x => x % 2 == 0)
            .Select(x => x * x);
        Console.WriteLine($"Pares al cuadrado: {string.Join(", ", paresAlCuadrado)}");
        
        // ===== AGRUPACIÓN =====
        Console.WriteLine("\n=== AGRUPACIÓN ===\n");
        
        var agrupados = numeros.GroupBy(x => x % 2 == 0 ? "Par" : "Impar");
        foreach (var grupo in agrupados)
        {
            Console.WriteLine($"{grupo.Key}: {string.Join(", ", grupo)}");
        }
        
        // ===== CONVERSIÓN =====
        Console.WriteLine("\n=== CONVERSIÓN ===\n");
        
        // ToArray
        int[] array = numeros.ToArray();
        Console.WriteLine($"Convertido a array: {string.Join(", ", array)}");
        
        // ToList
        List<int> lista = array.ToList();
        Console.WriteLine($"Convertido a lista: {string.Join(", ", lista)}");
        
        // ToDictionary
        Dictionary<int, int> diccionario = numeros.ToDictionary(x => x, x => x * x);
        Console.WriteLine("\nDiccionario (número: cuadrado):");
        foreach (var par in diccionario)
        {
            Console.WriteLine($"  {par.Key}: {par.Value}");
        }
    }
}',
    7,
    1
);

-- ============================================
-- LECCIÓN 8: Iteradores y foreach
-- ============================================
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden, Activo)
VALUES (
    @CursoId,
    'Iteradores y foreach',
    'Comprende cómo funcionan los iteradores y el bucle foreach para recorrer colecciones eficientemente.',
    'Los **iteradores** permiten recorrer una colección elemento por elemento. El bucle `foreach` es la forma más común de usar iteradores en C#.

**¿Qué es un iterador?**

Un iterador es un objeto que permite recorrer una colección de forma secuencial, proporcionando acceso a cada elemento uno por uno.

**Bucle foreach:**

```csharp
foreach (tipo elemento in coleccion)
{
    // Usar elemento
}
```

**Ventajas de foreach:**

- **Más simple**: No necesitas manejar índices
- **Más seguro**: No hay riesgo de índices fuera de rango
- **Más legible**: El código es más claro
- **Funciona con cualquier IEnumerable**: Arrays, List, Dictionary, etc.

**Interfaz IEnumerable:**

Las colecciones que implementan `IEnumerable<T>` pueden usarse con `foreach`. Esto incluye:
- Arrays
- List<T>
- Dictionary<TKey, TValue>
- Queue<T>, Stack<T>
- HashSet<T>, SortedSet<T>
- Y muchas más

**Comparación con for:**

- **for**: Necesitas el índice, más control, puede modificar durante iteración
- **foreach**: Más simple, no necesitas índice, no puedes modificar la colección durante iteración

**Cuándo usar cada uno:**

- **foreach**: Cuando solo necesitas leer elementos
- **for**: Cuando necesitas el índice o modificar elementos',
    'using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        Console.WriteLine("=== ITERADORES Y FOREACH ===\n");
        
        // ===== FOREACH CON ARRAY =====
        Console.WriteLine("=== FOREACH CON ARRAY ===\n");
        
        int[] numeros = { 10, 20, 30, 40, 50 };
        
        Console.WriteLine("Recorriendo array:");
        foreach (int numero in numeros)
        {
            Console.WriteLine($"Número: {numero}");
        }
        
        // ===== FOREACH CON LIST =====
        Console.WriteLine("\n=== FOREACH CON LIST ===\n");
        
        List<string> nombres = new List<string> { "Ana", "Luis", "María", "Carlos" };
        
        Console.WriteLine("Recorriendo lista:");
        foreach (string nombre in nombres)
        {
            Console.WriteLine($"Nombre: {nombre}");
        }
        
        // ===== FOREACH CON DICTIONARY =====
        Console.WriteLine("\n=== FOREACH CON DICTIONARY ===\n");
        
        Dictionary<string, int> edades = new Dictionary<string, int>
        {
            { "Juan", 25 },
            { "María", 30 },
            { "Pedro", 28 }
        };
        
        Console.WriteLine("Recorriendo diccionario:");
        foreach (KeyValuePair<string, int> par in edades)
        {
            Console.WriteLine($"{par.Key}: {par.Value} años");
        }
        
        // Forma simplificada con var
        foreach (var par in edades)
        {
            Console.WriteLine($"{par.Key}: {par.Value}");
        }
        
        // Solo claves
        Console.WriteLine("\nSolo claves:");
        foreach (string nombre in edades.Keys)
        {
            Console.WriteLine(nombre);
        }
        
        // Solo valores
        Console.WriteLine("\nSolo valores:");
        foreach (int edad in edades.Values)
        {
            Console.WriteLine(edad);
        }
        
        // ===== FOREACH CON HASHSET =====
        Console.WriteLine("\n=== FOREACH CON HASHSET ===\n");
        
        HashSet<int> conjunto = new HashSet<int> { 1, 2, 3, 4, 5 };
        
        Console.WriteLine("Recorriendo conjunto:");
        foreach (int elemento in conjunto)
        {
            Console.WriteLine(elemento);
        }
        
        // ===== FOREACH CON STRING (caracteres) =====
        Console.WriteLine("\n=== FOREACH CON STRING ===\n");
        
        string texto = "Hola";
        Console.WriteLine("Recorriendo caracteres:");
        foreach (char caracter in texto)
        {
            Console.WriteLine($"Carácter: {caracter}");
        }
        
        // ===== COMPARACIÓN: FOR VS FOREACH =====
        Console.WriteLine("\n=== FOR VS FOREACH ===\n");
        
        int[] valores = { 10, 20, 30, 40, 50 };
        
        Console.WriteLine("Con for (necesitas índice):");
        for (int i = 0; i < valores.Length; i++)
        {
            Console.WriteLine($"Índice {i}: {valores[i]}");
        }
        
        Console.WriteLine("\nCon foreach (más simple):");
        foreach (int valor in valores)
        {
            Console.WriteLine($"Valor: {valor}");
        }
        
        // ===== FOREACH CON BREAK Y CONTINUE =====
        Console.WriteLine("\n=== FOREACH CON BREAK Y CONTINUE ===\n");
        
        int[] numeros2 = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
        
        Console.WriteLine("Números pares (usando continue):");
        foreach (int num in numeros2)
        {
            if (num % 2 != 0)
                continue; // Salta impares
            
            Console.WriteLine(num);
        }
        
        Console.WriteLine("\nBuscando el primer número > 5 (usando break):");
        foreach (int num in numeros2)
        {
            if (num > 5)
            {
                Console.WriteLine($"Encontrado: {num}");
                break; // Sale del bucle
            }
        }
        
        // ===== FOREACH CON COLECCIONES ANIDADAS =====
        Console.WriteLine("\n=== FOREACH CON COLECCIONES ANIDADAS ===\n");
        
        List<List<int>> matriz = new List<List<int>>
        {
            new List<int> { 1, 2, 3 },
            new List<int> { 4, 5, 6 },
            new List<int> { 7, 8, 9 }
        };
        
        Console.WriteLine("Recorriendo matriz:");
        foreach (List<int> fila in matriz)
        {
            foreach (int elemento in fila)
            {
                Console.Write($"{elemento} ");
            }
            Console.WriteLine();
        }
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

