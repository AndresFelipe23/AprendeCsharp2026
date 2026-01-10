# Estructura de Base de Datos para Ejercicios

## Resumen de Tablas

### Tablas Principales (Estructura de Contenido)
1. **Rutas** - Módulos principales de aprendizaje
2. **Cursos** - Cursos dentro de cada ruta
3. **Lecciones** - Lecciones dentro de cada curso

### Tablas de Ejercicios/Prácticas
4. **Practicas** - Tabla principal que define el ejercicio
5. **PracticaOpciones** - Para ejercicios de respuesta múltiple
6. **PracticaBloques** - Para ejercicios tipo Duolingo (arrastrar bloques)
7. **PracticaCodigo** - Para ejercicios de escribir código

### Tablas de Retos (igual estructura que prácticas)
8. **Retos** - Retos al final de cada curso
9. **RetoOpciones** - Opciones para retos de respuesta múltiple
10. **RetoBloques** - Bloques para retos tipo Duolingo
11. **RetoCodigo** - Código para retos de escribir código

---

## Tipos de Ejercicios

### 1. **MultipleChoice** (Respuesta Múltiple)

**Tablas usadas:**
- `Practicas` (con `TipoEjercicio = 'MultipleChoice'`)
- `PracticaOpciones` (las opciones de respuesta)

**Cómo funciona:**
- El usuario ve una pregunta (`Enunciado` de `Practicas`)
- Ve varias opciones (`TextoOpcion` de `PracticaOpciones`)
- Selecciona una opción
- La app valida si `EsCorrecta = 1`
- Muestra `Explicacion` de la opción seleccionada

**Ejemplo:**
```
Pregunta: "¿Qué tipo de dato usarías para almacenar la edad?"
Opciones:
  - int (correcta)
  - string
  - double
  - bool
```

---

### 2. **CompletarCodigo** (Tipo Duolingo - Arrastrar Bloques)

**Tablas usadas:**
- `Practicas` (con `TipoEjercicio = 'CompletarCodigo'`)
- `PracticaBloques` (los bloques arrastrables)

**Cómo funciona:**
- El usuario ve un código con espacios vacíos (`CodigoBase` de `PracticaBloques`)
- Ve bloques arrastrables con texto (`TextoBloque`)
- Debe arrastrar los bloques correctos a las posiciones correctas
- La app valida que cada bloque esté en su `PosicionCorrecta`
- Los bloques con `EsDistractor = 1` son opciones falsas que confunden

**Ejemplo:**
```
Código base: "[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];"

Bloques disponibles:
  - int (posición correcta: 1)
  - edad (posición correcta: 2)
  - 25 (posición correcta: 3)
  - string (distractor)
  - nombre (distractor)
```

**Resultado esperado:** `int edad = 25;`

---

### 3. **EscribirCodigo** (Editor de Código)

**Tablas usadas:**
- `Practicas` (con `TipoEjercicio = 'EscribirCodigo'`)
- `PracticaCodigo` (el código base y solución)

**Cómo funciona:**
- El usuario ve un enunciado (`Enunciado` de `Practicas`)
- Ve un editor de código (puede tener `CodigoBase` como plantilla)
- Escribe su solución
- La app compara con `SolucionEsperada` (puede ser exacta o usar `CasosPrueba` para validar)
- Puede pedir pista (`PistaOpcional`)

**Ejemplo:**
```
Enunciado: "Escribe código que declare tres variables..."

Código base (opcional):
// Escribe tu código aquí

Solución esperada:
int edad = 20;
string nombre = "María";
double altura = 1.65;
```

---

## Flujo de Datos en la App

### Pantalla de Lección → Lista de Prácticas
```sql
SELECT * FROM Practicas 
WHERE LeccionId = @LeccionId 
ORDER BY Orden;
```

### Cargar Ejercicio Específico

**Si es MultipleChoice:**
```sql
-- Obtener ejercicio
SELECT * FROM Practicas WHERE PracticaId = @PracticaId;

-- Obtener opciones
SELECT * FROM PracticaOpciones 
WHERE PracticaId = @PracticaId 
ORDER BY Orden;
```

**Si es CompletarCodigo:**
```sql
-- Obtener ejercicio
SELECT * FROM Practicas WHERE PracticaId = @PracticaId;

-- Obtener bloques (mezclar correctos y distractores)
SELECT * FROM PracticaBloques 
WHERE PracticaId = @PracticaId 
ORDER BY NEWID(); -- Aleatorio para que no siempre aparezcan en el mismo orden
```

**Si es EscribirCodigo:**
```sql
-- Obtener ejercicio
SELECT * FROM Practicas WHERE PracticaId = @PracticaId;

-- Obtener datos del código
SELECT * FROM PracticaCodigo WHERE PracticaId = @PracticaId;
```

---

## Ventajas de esta Estructura

✅ **Flexible**: Puedes agregar nuevos tipos de ejercicios fácilmente
✅ **Escalable**: Cada tipo tiene su propia tabla especializada
✅ **Mantenible**: Fácil de entender y modificar
✅ **Eficiente**: Consultas rápidas con índices apropiados
✅ **Reutilizable**: La misma estructura funciona para Prácticas y Retos

---

## Notas Importantes

1. **TipoEjercicio** es un campo CHECK que solo permite: `'MultipleChoice'`, `'CompletarCodigo'`, `'EscribirCodigo'`

2. **Cascada de eliminación**: Si eliminas una `Practica`, se eliminan automáticamente sus opciones/bloques/código relacionados (ON DELETE CASCADE)

3. **Orden**: Todas las tablas tienen campos `Orden` para controlar la secuencia de visualización

4. **Activo**: Campos `Activo` permiten deshabilitar contenido sin eliminarlo

5. **CasosPrueba**: En `PracticaCodigo` y `RetoCodigo`, el campo `CasosPrueba` puede almacenar JSON para validación automática más compleja

---

## Tablas de Usuarios y Progreso

### Tablas de Usuarios
12. **Usuarios** - Información de los usuarios de la app

### Tablas de Progreso
13. **ProgresoLecciones** - Rastrea qué lecciones ha completado cada usuario
14. **ProgresoPracticas** - Rastrea el progreso en prácticas/ejercicios
15. **ProgresoRetos** - Rastrea el progreso en retos
16. **ProgresoCursos** - Progreso general de cada curso (porcentaje, estadísticas)
17. **ProgresoRutas** - Progreso general de cada ruta (porcentaje, estadísticas)

---

## Sistema de Progreso

### Progreso de Lecciones
- **Tabla**: `ProgresoLecciones`
- **Campos clave**:
  - `Completada`: Si el usuario completó la lección
  - `FechaCompletacion`: Cuándo la completó
  - `FechaUltimoAcceso`: Última vez que accedió a la lección
- **Uso**: Marcar lecciones como completadas cuando el usuario las termine de leer

### Progreso de Prácticas
- **Tabla**: `ProgresoPracticas`
- **Campos clave**:
  - `Completada`: Si completó el ejercicio correctamente
  - `Intentos`: Cuántas veces intentó el ejercicio
  - `CorrectoEnPrimerIntento`: Si lo resolvió bien la primera vez
  - `PuntosObtenidos`: Puntos ganados (más puntos si es en primer intento)
  - `RespuestaUsuario`: Guarda la respuesta del usuario (opcional, útil para revisión)
- **Uso**: Rastrear intentos, dar puntos, mostrar estadísticas

### Progreso de Retos
- **Tabla**: `ProgresoRetos`
- **Estructura similar a `ProgresoPracticas`**
- **Uso**: Rastrear retos completados al final de cada curso

### Progreso de Cursos
- **Tabla**: `ProgresoCursos`
- **Campos clave**:
  - `PorcentajeCompletado`: Porcentaje del curso completado (0-100)
  - `LeccionesCompletadas` / `TotalLecciones`: Contador de lecciones
  - `PracticasCompletadas` / `TotalPracticas`: Contador de prácticas
  - `RetosCompletados` / `TotalRetos`: Contador de retos
- **Uso**: Mostrar barras de progreso, calcular porcentajes, desbloquear siguiente curso

### Progreso de Rutas
- **Tabla**: `ProgresoRutas`
- **Campos clave**:
  - `PorcentajeCompletado`: Porcentaje de la ruta completado
  - `CursosCompletados` / `TotalCursos`: Contador de cursos
- **Uso**: Vista general del progreso del usuario en toda la ruta

---

## Sistema de Usuarios

### Tabla Usuarios
- **Campos principales**:
  - `NombreUsuario`: Nombre único del usuario
  - `Email`: Email único
  - `ContrasenaHash`: Hash de contraseña (NULL si usas autenticación externa)
  - `PuntosTotales`: Puntos acumulados del usuario
  - `Nivel`: Nivel del usuario (basado en puntos)
  - `FotoPerfilUrl`: URL de foto de perfil

---

## Consultas Útiles para Progreso

### Obtener progreso de un usuario en una lección
```sql
SELECT * FROM ProgresoLecciones 
WHERE UsuarioId = @UsuarioId AND LeccionId = @LeccionId;
```

### Obtener todas las lecciones completadas de un usuario
```sql
SELECT l.*, pl.FechaCompletacion 
FROM Lecciones l
INNER JOIN ProgresoLecciones pl ON l.LeccionId = pl.LeccionId
WHERE pl.UsuarioId = @UsuarioId AND pl.Completada = 1
ORDER BY pl.FechaCompletacion DESC;
```

### Calcular porcentaje de progreso de un curso
```sql
-- Actualizar porcentaje basado en lecciones, prácticas y retos
UPDATE ProgresoCursos
SET PorcentajeCompletado = (
    (LeccionesCompletadas * 50.0 / NULLIF(TotalLecciones, 0)) + 
    (PracticasCompletadas * 30.0 / NULLIF(TotalPracticas, 0)) + 
    (RetosCompletados * 20.0 / NULLIF(TotalRetos, 0))
)
WHERE UsuarioId = @UsuarioId AND CursoId = @CursoId;
```

### Obtener estadísticas completas de un usuario
```sql
SELECT 
    u.NombreUsuario,
    u.PuntosTotales,
    u.Nivel,
    (SELECT COUNT(*) FROM ProgresoLecciones WHERE UsuarioId = u.UsuarioId AND Completada = 1) AS LeccionesCompletadas,
    (SELECT COUNT(*) FROM ProgresoPracticas WHERE UsuarioId = u.UsuarioId AND Completada = 1) AS PracticasCompletadas,
    (SELECT COUNT(*) FROM ProgresoRetos WHERE UsuarioId = u.UsuarioId AND Completado = 1) AS RetosCompletados
FROM Usuarios u
WHERE u.UsuarioId = @UsuarioId;
```

---

## Total de Tablas: 17

1. Rutas
2. Cursos
3. Lecciones
4. Practicas
5. PracticaOpciones
6. PracticaBloques
7. PracticaCodigo
8. Retos
9. RetoOpciones
10. RetoBloques
11. RetoCodigo
12. Usuarios
13. ProgresoLecciones
14. ProgresoPracticas
15. ProgresoRetos
16. ProgresoCursos
17. ProgresoRutas

