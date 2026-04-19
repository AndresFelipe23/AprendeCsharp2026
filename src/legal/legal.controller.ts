import { Controller, Get, Header } from '@nestjs/common';
import { ApiExcludeController } from '@nestjs/swagger';

/**
 * Páginas HTML públicas para cumplimiento de Google Play Console
 * (política de privacidad y eliminación de cuenta).
 */
@ApiExcludeController()
@Controller()
export class LegalController {
  @Get(['politica-de-privacidad', 'privacy-policy'])
  @Header('Content-Type', 'text/html; charset=utf-8')
  @Header('Cache-Control', 'public, max-age=3600')
  politicaDePrivacidad(): string {
    return privacyPolicyHtml();
  }

  @Get(['eliminacion-de-cuenta', 'account-deletion'])
  @Header('Content-Type', 'text/html; charset=utf-8')
  @Header('Cache-Control', 'public, max-age=3600')
  eliminacionDeCuenta(): string {
    return accountDeletionHtml();
  }
}

function escapeHtml(text: string): string {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function privacyPolicyHtml(): string {
  const contacto = escapeHtml(
    process.env.PRIVACY_CONTACT_EMAIL ?? 'afesdev2025@gmail.com',
  );
  const sitio = escapeHtml(
    process.env.PUBLIC_SITE_NAME ?? 'Aprende C# (AprendeCsharp)',
  );

  return `<!DOCTYPE html>
<html lang="es-419">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Política de privacidad — ${sitio}</title>
  <style>
    body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,sans-serif;line-height:1.55;max-width:720px;margin:0 auto;padding:24px;color:#111}
    h1{font-size:1.5rem;margin-top:0}
    h2{font-size:1.1rem;margin-top:1.5rem}
    a{color:#0b57d0}
    .muted{color:#444;font-size:.95rem}
  </style>
</head>
<body>
  <h1>Política de privacidad</h1>
  <p class="muted">Última actualización: 18 de abril de 2026 · ${sitio}</p>

  <p>Esta política describe cómo tratamos la información personal cuando usas la aplicación y los servicios asociados.</p>

  <h2>1. Responsable del tratamiento</h2>
  <p>El responsable del tratamiento de los datos es el titular del proyecto <strong>${sitio}</strong>. Para consultas de privacidad puedes escribir a: <a href="mailto:${contacto}">${contacto}</a>.</p>

  <h2>2. Datos que podemos recoger</h2>
  <ul>
    <li><strong>Cuenta de usuario</strong>: por ejemplo identificador de usuario, nombre o alias, correo electrónico (si el registro lo requiere) y datos necesarios para autenticación.</li>
    <li><strong>Uso del servicio</strong>: progreso en cursos y prácticas, puntuaciones o métricas de aprendizaje asociadas a tu cuenta.</li>
    <li><strong>Técnico</strong>: dirección IP, tipo de dispositivo, registros básicos de seguridad y diagnóstico necesarios para operar el servicio de forma fiable.</li>
  </ul>

  <h2>3. Finalidades</h2>
  <ul>
    <li>Prestar el servicio educativo (acceso a contenidos, prácticas y seguimiento de progreso).</li>
    <li>Mantener la seguridad de la cuenta y del sistema (prevención de abusos, fraude o accesos no autorizados).</li>
    <li>Cumplir obligaciones legales aplicables.</li>
  </ul>

  <h2>4. Base legal</h2>
  <p>Tratamos tus datos según sea necesario para ejecutar el contrato/servicio que solicitas, nuestro interés legítimo en asegurar el funcionamiento y la seguridad del servicio, y cuando corresponda tu consentimiento.</p>

  <h2>5. Conservación</h2>
  <p>Conservamos la información el tiempo necesario para cumplir las finalidades descritas y las obligaciones legales. Si solicitas la eliminación de tu cuenta, procederemos a borrar o anonimizar tus datos personales salvo que debamos conservarlos por obligación legal.</p>

  <h2>6. Compartición con terceros</h2>
  <p>No vendemos tu información personal. Podemos utilizar proveedores de infraestructura (por ejemplo alojamiento, base de datos o analítica) que traten datos en nuestro nombre bajo acuerdos de tratamiento y medidas de seguridad adecuadas.</p>

  <h2>7. Tus derechos</h2>
  <p>Según la normativa aplicable, puedes solicitar acceso, rectificación, supresión, oposición, limitación del tratamiento y portabilidad cuando proceda. Para ejercerlos, contáctanos en <a href="mailto:${contacto}">${contacto}</a>.</p>

  <h2>8. Menores</h2>
  <p>Si el servicio no está dirigido a menores de edad, no deberían registrarse sin autorización parental cuando la ley lo exija.</p>

  <h2>9. Cambios</h2>
  <p>Podemos actualizar esta política. Publicaremos la versión vigente en esta página y, si el cambio es relevante, te lo comunicaremos por medios razonables.</p>

  <p><a href="/eliminacion-de-cuenta">Eliminación de cuenta</a></p>
</body>
</html>`;
}

function accountDeletionHtml(): string {
  const contacto = escapeHtml(
    process.env.PRIVACY_CONTACT_EMAIL ?? 'afesdev2025@gmail.com',
  );
  const sitio = escapeHtml(
    process.env.PUBLIC_SITE_NAME ?? 'Aprende C# (AprendeCsharp)',
  );

  return `<!DOCTYPE html>
<html lang="es-419">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Eliminación de cuenta — ${sitio}</title>
  <style>
    body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,sans-serif;line-height:1.55;max-width:720px;margin:0 auto;padding:24px;color:#111}
    h1{font-size:1.5rem;margin-top:0}
    h2{font-size:1.1rem;margin-top:1.5rem}
    a{color:#0b57d0}
    .box{border:1px solid #ddd;border-radius:10px;padding:16px;background:#fafafa}
    .muted{color:#444;font-size:.95rem}
  </style>
</head>
<body>
  <h1>Eliminación de cuenta</h1>
  <p class="muted">${sitio}</p>

  <p>Si creaste una cuenta en nuestra aplicación, puedes solicitar su eliminación. Al eliminar la cuenta, dejaremos de usar tus datos personales asociados a esa cuenta, salvo obligaciones legales de conservación.</p>

  <div class="box">
    <h2>Cómo solicitar la eliminación</h2>
    <ol>
      <li>Envía un correo a <a href="mailto:${contacto}?subject=Solicitud%20de%20eliminaci%C3%B3n%20de%20cuenta">${contacto}</a> con el asunto <strong>“Solicitud de eliminación de cuenta”</strong>.</li>
      <li>Incluye el <strong>correo electrónico</strong> con el que registraste la cuenta (y, si aplica, tu nombre de usuario o identificador que te muestre la app).</li>
      <li>Responderemos en un plazo razonable (orientativamente entre <strong>7 y 30 días hábiles</strong>) y te confirmaremos cuando el proceso haya finalizado.</li>
    </ol>
  </div>

  <h2>Qué se elimina</h2>
  <p>Procederemos a eliminar o anonimizar los datos vinculados a tu cuenta (por ejemplo perfil, progreso y datos asociados al uso autenticado), salvo información agregada no identificable o registros que debamos conservar por imperativo legal.</p>

  <h2>Antes de eliminar</h2>
  <p>Si tienes datos importantes (por ejemplo progreso), te recomendamos exportarlos o anotarlos antes de solicitar la eliminación, si la app ofrece esa opción.</p>

  <p><a href="/politica-de-privacidad">Política de privacidad</a></p>
</body>
</html>`;
}
