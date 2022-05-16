unit uEndereco;

interface

uses sysUtils;

type
  TEndereco = class
  private
    FID: integer;
    FRua: string;
    FNumero: integer;
    FBairro: string;
    FCidade: string;
    FCEP: string;

    function getID: integer;
    procedure setID(value: integer);

    function getrua: string;
    procedure setrua(value: string);

    function getCidade: string;
    procedure setCidade(value: string);

    function getBairro: string;
    procedure setBairro(value: string);

    function getCEP: string;
    procedure setCEP(value: string);
  public
    property ID:integer read getID write setID;
    property Rua : string read getrua write setrua;
    property Numero : Integer read FNumero write FNumero;
    property Cidade : string read getCidade write setCidade;
    property Bairro :string read getBairro write setBairro;
    property Cep : string read getCEP write setCEP;
  end;

implementation

{ TEndereco }

function TEndereco.getBairro: string;
begin
  result := FBairro
end;

function TEndereco.getCEP: string;
begin
  result := FCEP;
end;

function TEndereco.getCidade: string;
begin
  result := FCidade;
end;

function TEndereco.getID: integer;
begin
  result := FID;
end;

function TEndereco.getrua: string;
begin
  result := FRua;
end;

procedure TEndereco.setBairro(value: string);
begin
  FBairro := value;
end;

procedure TEndereco.setCEP(value: string);
begin
  FCEP := value;
end;

procedure TEndereco.setCidade(value: string);
begin
  FCidade := value;
end;

procedure TEndereco.setID(value: integer);
begin
  FID := value;
end;

procedure TEndereco.setrua(value: string);
begin
  FRua := value;
end;

end.
