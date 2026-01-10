# Endpoints de Progreso - Documentación

## Endpoints necesarios para el sistema de progreso

### 1. Progreso de Lecciones

#### Marcar lección como completada
```
POST /progreso/lecciones/:leccionId/completar
Headers: Authorization: Bearer <token>
Body: {
  "completada": true
}
Response: ProgresoLeccion
```

#### Actualizar último acceso
```
PUT /progreso/lecciones/:leccionId/acceso
Headers: Authorization: Bearer <token>
Response: 200 OK
```

#### Obtener progreso de una lección
```
GET /progreso/lecciones/:leccionId
Headers: Authorization: Bearer <token>
Response: ProgresoLeccion | 404 Not Found
```

#### Obtener todas las lecciones completadas
```
GET /progreso/lecciones/completadas
Headers: Authorization: Bearer <token>
Response: int[] (array de IDs de lecciones completadas)
```

### 2. Progreso de Prácticas (Futuro)
```
POST /progreso/practicas/:practicaId/completar
GET /progreso/practicas/:practicaId
```

### 3. Progreso de Retos (Futuro)
```
POST /progreso/retos/:retoId/completar
GET /progreso/retos/:retoId
```

### 4. Progreso de Cursos (Calculado automáticamente)
```
GET /progreso/cursos/:cursoId
Response: {
  "porcentajeCompletado": 45.5,
  "leccionesCompletadas": 3,
  "totalLecciones": 7,
  "practicasCompletadas": 2,
  "totalPracticas": 5
}
```

### 5. Progreso de Rutas (Calculado automáticamente)
```
GET /progreso/rutas/:rutaId
Response: {
  "porcentajeCompletado": 30.0,
  "cursosCompletados": 1,
  "totalCursos": 5
}
```

## Cuándo se guarda el progreso

### Lecciones
- **Al marcar como completada**: Cuando el usuario presiona "Marcar como completada"
- **Al avanzar a la siguiente**: Cuando el usuario presiona "Siguiente lección" (implica que completó la actual)
- **Al acceder**: Se actualiza `FechaUltimoAcceso` cada vez que se abre una lección

### Prácticas
- **Al responder correctamente**: Se guarda el progreso con puntos obtenidos
- **Al responder incorrectamente**: Se incrementa el contador de intentos

### Retos
- **Al resolver correctamente**: Se guarda el progreso con puntos obtenidos
- **Al fallar**: Se incrementa el contador de intentos

## Lógica de cálculo de progreso

### Progreso de Curso
```
Porcentaje = (
  (LeccionesCompletadas * 50 / TotalLecciones) +
  (PracticasCompletadas * 30 / TotalPracticas) +
  (RetosCompletados * 20 / TotalRetos)
)
```

### Progreso de Ruta
```
Porcentaje = (CursosCompletados * 100 / TotalCursos)
```

## Puntos y Nivel

- **Puntos por lección completada**: 10 puntos
- **Puntos por práctica completada**: 20 puntos (30 si es en primer intento)
- **Puntos por reto completado**: 50 puntos (75 si es en primer intento)
- **Nivel**: Se calcula basado en puntos totales (ej: 100 puntos = Nivel 2)

