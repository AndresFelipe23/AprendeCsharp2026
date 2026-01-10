SELECT * FROM Usuarios

--DELETE rutas WHERE RutaId = 2
--DELETE cursos WHERE CursoId = 6
--DELETE lecciones WHERE LeccionId = 50


SELECT * FROM rutas
SELECT * FROM Cursos
SELECT * FROM lecciones
SELECT * FROM PracticaOpciones
SELECT * FROM ProgresoPracticas

SELECT * FROM Practicas WHERE LeccionId = 1;
SELECT * FROM PracticaOpciones WHERE PracticaId IN (SELECT PracticaId FROM Practicas WHERE LeccionId = 1);

SELECT * FROM ProgresoCursos
SELECT * FROM ProgresoLecciones