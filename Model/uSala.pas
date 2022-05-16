unit uSala;

interface

uses
Vcl.CheckLst;

type
  TSala = class
  private
    FID: integer;
    FNome: string;


  public
    property ID: integer read FID write FID;
    property Nome: string Read FNome write FNome;
  end;

implementation

end.
