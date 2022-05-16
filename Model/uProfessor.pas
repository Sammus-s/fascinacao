unit uProfessor;

interface

uses system.sysUtils;

type
  TProfessor = class
  private
    FID: integer;
    Fid_endereco: integer;

    FNome: String;
    FDataNasc: TDateTime;
    FCpf: string;
    FRG: string;
    FCNPJ: string;
    FContato: String;
    FEmail: string;

    FCurso: string;

    FIDHora: integer;
    FHoraInicio: TTime;
    fHoraFim: TTime;
    FDia: String;

  public
    property ID: integer read Fid write FID;
    property Nome: string read FNome write Fnome;
    property IDEndereco: integer read Fid_endereco write Fid_endereco;
    property DataNasc: TDateTime read FDataNasc write FDataNasc;
    property Cpf: string read FCpf write FCpf;
    property RG: string read FRG write FRG;
    property CNPJ: string read FCNPJ write FCNPJ;
    property Contato: string read FContato write FContato;
    property Email: string read Femail write Femail;
    var Cursos: array of string;
    Tamanho : integer;
    property Curso: string read FCurso write FCurso;
    property HoraInicio: TTime read FHoraInicio write FHoraInicio;
    property HoraFim: TTime read fHoraFim write fHoraFim;
    property Dia: string read FDia write FDia;
    property IdHora: integer read FIDHora write FIDHora;
  end;

implementation

end.
