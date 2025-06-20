<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

Este proyecto es una base para pruebas automatizadas usando Karate, Java y Gradle.

# Estándar senior para automatización Karate en este proyecto

- Todos los escenarios deben tener tags claros y obligatorios (por requerimiento, caso, tipo de validación, etc).
- Los datos de entrada (request) y salida (response esperada) deben estar en archivos JSON externos en carpetas organizadas por funcionalidad.
- Los escenarios deben validar la estructura de la respuesta (campos y tipos) usando `schema` salvo que se requiera validar el contenido exacto.
- Si se requiere validar el contenido exacto, definir el objeto esperado en el escenario o en un archivo externo y hacer match exacto.
- Usar variables y lectura de archivos (`read`) para requests y respuestas esperadas.
- Declarar headers y configuraciones de entorno en el `Background`.
- Comentar cada validación relevante para claridad y mantenibilidad.
- Mantener los escenarios atómicos, claros y reutilizables.
- No incluir comentarios en archivos JSON (debe ser JSON válido).
- Priorizar la mantenibilidad y legibilidad sobre la cantidad de validaciones.
