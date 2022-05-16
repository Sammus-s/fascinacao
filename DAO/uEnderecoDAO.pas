unit uEnderecoDAO;

interface
uses uDAO, uEndereco, FireDac.comp.client, sysUtils;

type
  TEnderecoDAO = class (TconectDAO)
    public
    Constructor Create;
    Destructor Destroy; override;
    function CadastrarEndereco(pEndereco : Tendereco):boolean;
    function RetornarEndereco(pEndereco: TEndereco): TEndereco;
    function UpdateEndereco(pEndereco : TEndereco): Boolean;
    function RetornaCidades: TFDQuery;
  end;

implementation

{ TEnderecoDAO }

function TEnderecoDAO.CadastrarEndereco(pEndereco: Tendereco): boolean;
var SQL:string;
begin
SQL := 'select id_cidade from cidade where nome = ' + QuotedStr(pEndereco.Cidade);
FQuery := RetornarDataSet(SQL);
pEndereco.Cidade := FQuery.FieldByName('id_cidade').AsString;

SQL := 'INSERT INTO endereco VALUES(default, ' + QuotedSTR(pEndereco.rua) +
    ', ' + QuotedSTR(IntToStr( pEndereco.Numero)) + ', ' +
    QuotedSTR(pEndereco.bairro) + ', ' +
    QuotedSTR(pEndereco.cep) + ' ,' + QuotedSTR(pEndereco.cidade) + ')';

  result := executarComando(SQL) > 0;
end;

constructor TEnderecoDAO.Create;
begin
  inherited;
end;

destructor TEnderecoDAO.Destroy;
begin
  inherited;
end;

function TEnderecoDAO.RetornaCidades: TFDQuery;
var SQL : string;
begin
  SQL := 'select * from cidade';
  FQuery := RetornarDataSet(SQL);
  Result := FQuery;
end;

function TEnderecoDAO.RetornarEndereco(pEndereco: TEndereco): TEndereco;
var SQL : string;
endereco : TEndereco;
begin
  SQL := 'select * from endereco where id_endereco = '+
  QuotedStr(IntToStr(pEndereco.ID));

  FQuery := RetornarDataSet(SQL);

  endereco := TEndereco.Create;
  endereco.ID := FQuery.FieldByName('id_endereco').AsInteger;
  endereco.Rua := FQuery.FieldByName('rua').AsString;
  endereco.Numero := FQuery.FieldByName('numero').AsInteger;
  endereco.Bairro := FQuery.FieldByName('bairro').AsString;
  endereco.Cep := FQuery.FieldByName('cep').AsString;

  SQL := 'select nome from cidade where id_cidade = ' +
  QuotedStr(FQuery.FieldByName('id_cidade').AsString);
  FQuery2 := RetornarDataSet2(SQL);
  endereco.Cidade := FQuery2.FieldByName('nome').AsString;

  Result := endereco;
end;

function TEnderecoDAO.UpdateEndereco(pEndereco: TEndereco): Boolean;
var SQL : String;
begin
  SQL := 'select id_cidade from cidade where nome = ' + QuotedStr(pEndereco.Cidade);
FQuery := RetornarDataSet(SQL);
pEndereco.Cidade := FQuery.FieldByName('id_cidade').AsString;

  SQL := 'update endereco Set rua = ' + QuotedSTR(pEndereco.Rua) +
    ', numero = ' + QuotedSTR(intToStr(pEndereco.Numero)) +
    ', bairro = ' + QuotedSTR(pEndereco.Bairro) +
    ', cep = ' + QuotedSTR(pEndereco.Cep) +
    ', id_cidade = ' + QuotedSTR(pEndereco.Cidade) +
    ' where id_endereco = ' + QuotedSTR(InttoStr(pEndereco.id));

  result := executarComando(SQL) > 0;
end;

end.
