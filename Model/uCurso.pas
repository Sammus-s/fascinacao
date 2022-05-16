unit uCurso;

interface

uses sysUtils;

type
  TCurso = class
  private
    FID: integer;
    FNome: string;
    FPreço: currency;
    FIDSala:integer;
  public
    property ID: integer read FID write FID;
    property Nome: string read FNome write FNome;
    property Preco: currency Read FPreço write FPreço;
    property idSala: integer read FIDSala write FIDSala;
    var salas: array[0..4] of string;
  end;

implementation

end.
