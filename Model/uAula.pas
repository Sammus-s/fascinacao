unit uAula;

interface

type
  TAula = class
  private
    Fid: integer;
    Fid_aluno: integer;
    Fid_professor: integer;
    Fid_sala: integer;
    Fid_curso: integer;
    Fhora_inicio: TTime;
    Fdia: string;

    Faluno: string;
    Fprofessor: string;
    Fsala: string;
    Fcurso: string;

  public

    property id: integer read Fid write Fid;
    property id_aluno: integer read Fid_aluno write Fid_aluno;
    property id_professor: integer read Fid_professor write Fid_professor;
    property id_sala: integer read Fid_sala write Fid_sala;
    property id_curso: integer read Fid_curso write Fid_curso;
    property hora_inicio: TTime read Fhora_inicio write Fhora_inicio;
    property dia: string read Fdia write Fdia;

    property aluno: string read Faluno write Faluno;
    property professor: string read Fprofessor write Fprofessor;
    property sala: string read Fsala write Fsala;
    property curso: string read Fcurso write Fcurso;
  end;

implementation

end.
