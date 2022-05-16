unit uResponsavel;

interface

uses system.sysUtils;

type
  TResponsavel = class
  private
    FID: integer;
    FNome: string;
    FCpf: string;
    FRG: string;
    FDataNasc: Tdatetime;
    FContato: string;
    FEmail: string;
    FContatoCom: string;

    function getId: integer;
    procedure setId(value: integer);

    function getNome: string;
    procedure setNome(value: string);

    function getCpf: string;
    procedure setCpf(value: string);

    function getRG: string;
    procedure setRG(value: string);

    function getDataNasc: Tdatetime;
    procedure setDataNasc(value: Tdatetime);

    function getContato: string;
    procedure setContato(value: string);

    function getemail: string;
    procedure setemail(value: string);

    function getContatoCom: string;
    procedure setContatoCom(value: string);

  public
    property ID: integer read getId write setId;
    property Nome: string read getNome write setNome;
    property Cpf: string read getCpf write setCpf;
    property RG: string read getRG write setRG;
    property DataNasc: Tdatetime read getDataNasc write setDataNasc;
    property Contato: string read getContato write setContato;
    property Email: string read getemail write setemail;
    property ContatoCom : string read getContatoCom write SetContatoCom;
  end;

implementation

{ TResponsavel }

function TResponsavel.getContato: string;
begin
  Result := FContato
end;

function TResponsavel.getContatoCom: string;
begin
  Result := FContatoCom;
end;

function TResponsavel.getCpf: string;
begin
  Result := FCpf
end;

function TResponsavel.getDataNasc: Tdatetime;
begin
  Result := FDataNasc;
end;

function TResponsavel.getemail: string;
begin
  Result := FEmail;
end;

function TResponsavel.getId: integer;
begin
  Result := FID;
end;

function TResponsavel.getNome: string;
begin
  Result := FNome;
end;

function TResponsavel.getRG: string;
begin
  Result := FRG;
end;

procedure TResponsavel.setContato(value: string);
begin
  FContato := value;
end;

procedure TResponsavel.setContatoCom(value: string);
begin
   FContatoCom := value;
end;

procedure TResponsavel.setCpf(value: string);
begin
  FCpf := value;
end;

procedure TResponsavel.setDataNasc(value: Tdatetime);
begin
  FDataNasc := value;
end;

procedure TResponsavel.setemail(value: string);
begin
  FEmail := value;
end;

procedure TResponsavel.setId(value: integer);
begin
  FID := value;
end;

procedure TResponsavel.setNome(value: string);
begin
  FNome := value;
end;

procedure TResponsavel.setRG(value: string);
begin
  FRG := value;
end;

end.
