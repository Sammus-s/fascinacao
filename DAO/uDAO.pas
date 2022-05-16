unit uDAO;

interface

uses
  uDM, FireDac.Comp.Client, System.SysUtils, FireDac.Dapt;

type
  TConectDAO = class
  Protected
    FQuery: TFDQuery;
    FQuery2: TFDQuery;
    constructor Create;
    Destructor Destroy; override;

    function ExecutarComando(pSQL: string): integer;
    function RetornarDataSet(pSQL: string): TFDQuery;
    function ExecutarOpen(pSQL: string): integer;
    function RetornarDataSet2(pSQL: string): TFDQuery;
  end;

implementation

{ TConectDAO }

constructor TConectDAO.Create;
begin
  inherited Create;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := DM.Connection;
  FQuery2 := TFDQuery.Create(nil);
  FQuery2.Connection := DM.Connection;

end;

destructor TConectDAO.Destroy;
begin
  try
    if Assigned(FQuery) then
      FreeAndNil(FQuery);
    if Assigned(FQuery2) then
      FreeAndNil(FQuery2);
  except
    on e: exception do
      raise exception.Create(e.Message);

  end;
end;

function TConectDAO.ExecutarComando(pSQL: string): integer;
begin
  try
    DM.Connection.StartTransaction;
    FQuery.SQL.Text := pSQL;
    FQuery.ExecSQL;
    Result := FQuery.RowsAffected;
    DM.Connection.Commit;
  except
    DM.Connection.Rollback;

  end;
end;

function TConectDAO.ExecutarOpen(pSQL: string): integer;
begin
  try
    DM.Connection.StartTransaction;
    FQuery.SQL.Text := pSQL;
    FQuery.Open;
    Result := FQuery.RowsAffected;
    DM.Connection.Commit;
  except
    DM.Connection.Rollback;
  end;

  end;

  function TConectDAO.RetornarDataSet(pSQL: string): TFDQuery;
  begin
    FQuery.SQL.Text := pSQL;
    FQuery.Active := True;
    Result := FQuery;
  end;

  function TConectDAO.RetornarDataSet2(pSQL: string): TFDQuery;
  begin
    FQuery2.SQL.Text := pSQL;
    FQuery2.Active := True;
    Result := FQuery2;
  end;

end.
