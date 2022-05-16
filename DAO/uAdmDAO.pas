unit uAdmDAO;

interface

uses uAdm, uDAO, System.SysUtils, uEndereco, System.generics.collections,
  FireDac.comp.client;

type
  TAdmDAO = class(TConectDAO)
  private
    FListaAdm: TObjectList<TAdm>;
    procedure CriaLista(Ds: TFDQuery);
  public
    constructor Create;
    destructor Destroy; override;

    function VerificaLogin(user, passw: string): boolean;
    function CreateAdm(pAdm: TAdm): boolean;
    function PesquisaAdm(pAdm: TAdm): TObjectList<TAdm>;
    function DeleteAdm(pAdm : TAdm): Boolean;
    function UpdateAdm(pAdm :  TAdm):Boolean;
    function RetornaAdm(pAdm : TAdm) : TAdm;
  end;

implementation

{ TAdmDAO }

constructor TAdmDAO.Create;
begin
  inherited;
  FListaAdm := TObjectList<TAdm>.Create;
end;

function TAdmDAO.CreateAdm(pAdm: TAdm): boolean;
var
  SQL: String;
begin
  SQL := 'select id_endereco from endereco ' +
    'where id_endereco not in (select id_endereco from aluno) ' +
    'and id_endereco not in (select id_endereco from professor)' +
    'and id_endereco not in (select id_endereco from adm)';

  FQuery := RetornarDataSet(SQL);

  pAdm.IDEndereco := FQuery.fieldByName('id_endereco').AsInteger;

  SQL := 'insert into adm values(default, ' + QuotedStr(pAdm.Nome) + ', ' +
    QuotedStr(IntToStr(pAdm.IDEndereco)) + ', ' +
    QuotedStr(FormatDateTime('dd/mm/yyyy', pAdm.DataNasc)) + ', ' +
    QuotedStr(pAdm.Cpf) + ', ' + QuotedStr(pAdm.RG) + ', ' +
    QuotedStr(pAdm.Contato) + ', ' + QuotedStr(pAdm.Email) + ', ' +
    QuotedStr(pAdm.user) + ', ' + QuotedStr(pAdm.passw) + ')';

  Result := ExecutarComando(SQL) > 0;
end;

procedure TAdmDAO.CriaLista(Ds: TFDQuery);
var
  I, count: integer;
  SQL: string;
begin
  I := 0;
  FListaAdm.Clear;

  while not Ds.eof do
  begin
    FListaAdm.Add(TAdm.Create);
    FListaAdm[I].id := Ds.fieldByName('id_adm').AsInteger;
    FListaAdm[I].Nome := Ds.fieldByName('nome').AsString;
    FListaAdm[I].IDEndereco := Ds.fieldByName('id_endereco').AsInteger;
    FListaAdm[I].DataNasc := Ds.fieldByName('data_nasc').AsDateTime;
    FListaAdm[I].Cpf := Ds.fieldByName('cpf').AsString;
    FListaAdm[I].RG := Ds.fieldByName('rg').AsString;
    FListaAdm[I].Contato := Ds.fieldByName('telefone').AsString;
    FListaAdm[I].Email := Ds.fieldByName('email').AsString;
    FListaAdm[I].User := Ds.fieldByName('login').AsString;
    FListaAdm[I].Passw := Ds.fieldByName('senha').AsString;

    i := I +1;
    Ds.Next;
  end;
end;

function TAdmDAO.DeleteAdm(pAdm: TAdm): Boolean;
var SQL : string;
begin
  SQL := 'Delete from adm where id_adm = ' + QuotedStr(IntToStr(pAdm.ID));

  Result :=  ExecutarComando(SQL) > 0;
end;

destructor TAdmDAO.Destroy;
begin
  try
    inherited;
    if Assigned(FListaAdm) then
    FreeAndNil(FListaAdm);
  except
    on e: exception do
      raise exception.Create(e.Message);

  end;

end;

function TAdmDAO.PesquisaAdm(pAdm: TAdm): TObjectList<TAdm>;
var
  SQL: string;
begin
  result := nil;
  SQL := 'SELECT * FROM adm WHERE nome LIKE ' +
    QuotedSTR('%' + pAdm.Nome + '%') + 'and email LIKE ' +
    QuotedSTR('%' + pAdm.Email + '%') + ' and telefone LIKE ' +
    QuotedSTR('%' + pAdm.contato + '%') + ' and cpf LIKE ' +
    QuotedSTR('%' + pAdm.Cpf + '%') + 'ORDER by nome';;

  FQuery := RetornarDataSet(SQL);

  if not(FQuery.IsEmpty) then
  begin
    CriaLista(FQuery);
    result := FListaAdm;
  end;
end;

function TAdmDAO.RetornaAdm(pAdm: TAdm): TAdm;
var SQL : string; ADM : TAdm;
begin
  sql := 'select * from adm where id_adm = ' + QuotedStr(IntToStr(pAdm.ID));
  FQuery := RetornarDataSet(SQL);
  ADM := TAdm.Create;

    ADM.id := FQuery.fieldByName('id_adm').AsInteger;
    ADM.Nome := FQuery.fieldByName('nome').AsString;
    ADM.IDEndereco := FQuery.fieldByName('id_endereco').AsInteger;
    ADM.DataNasc := FQuery.fieldByName('data_nasc').AsDateTime;
    ADM.Cpf := FQuery.fieldByName('cpf').AsString;
    ADM.RG := FQuery.fieldByName('rg').AsString;
    ADM.Contato := FQuery.fieldByName('telefone').AsString;
    ADM.Email := FQuery.fieldByName('email').AsString;
    ADM.User := FQuery.fieldByName('login').AsString;
    ADM.Passw := FQuery.fieldByName('senha').AsString;

    Result := ADM;
end;

function TAdmDAO.UpdateAdm(pAdm: TAdm): Boolean;
var SQL : String;
begin
  SQL := 'update adm Set nome = ' + QuotedSTR(pAdm.Nome) +
    ', data_nasc = ' + QuotedSTR(DateToStr(pAdm.DataNasc)) +
    ', cpf = ' + QuotedSTR(pAdm.Cpf) +
    ', rg = ' + QuotedSTR(pAdm.rg) +
    ', telefone = ' + QuotedSTR(pAdm.contato) +
    ', email = ' + QuotedSTR(pAdm.email) +
    ', login = ' + QuotedSTR(pAdm.User) +
    ', senha = ' + QuotedSTR(pAdm.Passw) +
    ' where id_adm = ' + QuotedSTR(InttoStr(pAdm.id));

  result := executarComando(SQL) > 0;
end;

function TAdmDAO.VerificaLogin(user, passw: string): boolean;
var
  SQL: string;
begin
  SQL := 'Select * From adm Where login = ' + QuotedStr(user) + ' and senha = '
    + QuotedStr(passw);

  Result := ExecutarOpen(SQL) > 0;
end;

end.
