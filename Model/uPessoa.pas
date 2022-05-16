unit uAdm;

interface

type
  TAdm = class
  private
    FID: integer;
    FNome: string;
    FLogin: string;
    FPassw: string;

    function GetID: integer;
    procedure SetID(value: integer);

    function GetNome: string;
    procedure SetNome(value: String);

    function GetLogin: string;
    procedure SetLogin(value: String);

    function GetPassw: string;
    procedure SetPassw(value: String);

  public
    property IdAdm: integer read GetID write SetID;
    property NomeAdm: string read GetNome write SetNome;
    property LoginAdm: string read GetLogin write SetLogin;
    property PasswAdm: string read GetPassw write SetPassw;

  end;

implementation

{ TAdm }

function TAdm.GetID: integer;
begin
  result := FID;
end;

function TAdm.GetLogin: string;
begin
  result := FLogin;
end;

function TAdm.GetNome: string;
begin
  result := FNome;
end;

function TAdm.GetPassw: string;
begin
  result := FPassw;
end;

procedure TAdm.SetID(value: integer);
begin
  FID := value;
end;

procedure TAdm.SetLogin(value: String);
begin
  FLogin := value;
end;

procedure TAdm.SetNome(value: String);
begin
  FNome := value;
end;

procedure TAdm.SetPassw(value: String);
begin
  FPassw := value;
end;

end.
