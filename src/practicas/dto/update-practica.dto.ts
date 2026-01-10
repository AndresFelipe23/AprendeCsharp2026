import { PartialType } from '@nestjs/swagger';
import { CreatePracticaDto } from './create-practica.dto';

export class UpdatePracticaDto extends PartialType(CreatePracticaDto) {}

