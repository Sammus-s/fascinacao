unit uAluno;

interface
uses sysUtils;

type
  TAluno = class
    private
     FID : integer;
     FIdResponsavel : integer;
     FIdEndereco : integer;
     FNome : String;
     FCpf : string;
     FRG : string;
     FDataNasc : TDateTime;
     FContato : String;
     FEmail : string;
     FContatoCom : string;
     FCurso : String;
     FTamanho: integer;

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

    function getIdResponsavel : integer;
    procedure setIdResponsavel (value : integer);

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
    property IDResponsavel : integer read getIdResponsavel write setIdResponsavel;
    property ContatoCom : string read getContatoCom write setContatoCom;
    property IdEndereco : integer read FIdEndereco write FIdEndereco;
    property Curso : string read FCurso write FCurso;
    property Tamanho: integer read FTamanho write FTamanho;
    var Cursos : array of string;
  end;

implementation

{ TAluno }

function TAluno.getContato: string;
begin
  Result := FContato
end;

function TAluno.getContatoCom: string;
begin
  Result := FContatoCom
end;

function TAluno.getCpf: string;
begin
  Result := FCpf
end;

function TAluno.getDataNasc: Tdatetime;
begin
  Result := FDataNasc;
end;

function TAluno.getemail: string;
begin
  Result := FEmail;
end;

function TAluno.getId: integer;
begin
  Result := FID;
end;

function TAluno.getIdResponsavel: integer;
begin
 Result := FIdResponsavel;
end;

function TAluno.getNome: string;
begin
  Result := FNome;
end;

function TAluno.getRG: string;
begin
  Result := FRG;
end;

procedure TAluno.setContatoCom(value: string);
begin
   FContatoCom := Value;
end;

procedure TAluno.setContato(value: string);
begin
  FContato := value;
end;

procedure TAluno.setCpf(value: string);
begin
  FCpf := value;
end;

procedure TAluno.setDataNasc(value: Tdatetime);
begin
  FDataNasc := value;
end;

procedure TAluno.setemail(value: string);
begin
  FEmail := value;
end;

procedure TAluno.setId(value: integer);
begin
  FID := value;
end;

procedure TAluno.setIdResponsavel(value: integer);
begin
   FIdResponsavel := value;
end;

procedure TAluno.setNome(value: string);
begin
  FNome := value;
end;

procedure TAluno.setRG(value: string);
begin
  FRG := value;
end;



end.
