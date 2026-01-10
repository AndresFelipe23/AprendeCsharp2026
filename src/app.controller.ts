import { Controller, Get, Redirect } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiExcludeEndpoint } from '@nestjs/swagger';
import { AppService } from './app.service';

@ApiTags('app')
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  @ApiExcludeEndpoint()
  @Redirect('/docs', 302)
  redirectToRoot() {
    // Este método redirige la raíz a /docs
  }

  @Get('api/health')
  @ApiOperation({
    summary: 'Endpoint de salud/verificación',
    description: 'Retorna un mensaje de bienvenida de la API. Útil para verificar que la API está funcionando.'
  })
  @ApiResponse({
    status: 200,
    description: 'API funcionando correctamente',
    schema: {
      type: 'string',
      example: 'Hello World!'
    }
  })
  getHello(): string {
    return this.appService.getHello();
  }
}
