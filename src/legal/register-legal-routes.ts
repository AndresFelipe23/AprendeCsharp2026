import type { Express, Request, Response } from 'express';
import {
  buildAccountDeletionHtml,
  buildPrivacyPolicyHtml,
} from './legal-html';

/**
 * Registra rutas HTML públicas en Express (Google Play Console).
 * Se invoca desde main.ts en el despliegue habitual (VPS + Nginx + Node).
 */
export function registerLegalRoutes(expressApp: Express): void {
  const sendPrivacy = (_req: Request, res: Response) => {
    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    res.setHeader('Cache-Control', 'public, max-age=3600');
    res.send(buildPrivacyPolicyHtml());
  };
  const sendDeletion = (_req: Request, res: Response) => {
    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    res.setHeader('Cache-Control', 'public, max-age=3600');
    res.send(buildAccountDeletionHtml());
  };

  for (const path of ['/politica-de-privacidad', '/privacy-policy']) {
    expressApp.get(path, sendPrivacy);
  }
  for (const path of ['/eliminacion-de-cuenta', '/account-deletion']) {
    expressApp.get(path, sendDeletion);
  }
}
