unit uCursoDAO;

interface

uses uDAO, uCurso, FireDAC.Comp.Client, sysUtils, system.Generics.Collections;

type
  TCursoDAO = class(TconectDAO)
  private
    FListaCurso: TObjectList<TCurso>;
    procedure CriaLista(Ds: TFDQuery);
  public
    Constructor Create;
    Destructor Destroy; override;
    function ListaCurso: TFDQuery;
    function CadastraCurso(pCurso: TCurso): boolean;
    function PesquisaCurso(pCurso: TCurso): TObjectList<TCurso>;
    function UpdateCurso(pCurso: TCurso): boolean;
    function DeletarCurso(pCurso: TCurso): boolean;
    function RetornarId(pCurso: TCurso): integer;
  end;

implementation

{ TCursoDAO }

function TCursoDAO.CadastraCurso(pCurso: TCurso): boolean;
var
  SQL: string;
begin
  SQL := 'insert into curso values (default, ' + QuotedSTR(pCurso.nome) + ', ' +
    QuotedSTR(FloatToStr(pCurso.Preco)) + ')';

  Result := ExecutarComando(SQL) > 0;
end;

constructor TCursoDAO.Create;
begin
  inherited;
  FListaCurso := TObjectList<TCurso>.Create;
end;

procedure TCursoDAO.CriaLista(Ds: TFDQuery);
var
  I, count: integer;
  SQL: string;
begin
  I := 0;

  FListaCurso.Clear;

  while not Ds.eof do
  begin
    count := 0;
    FListaCurso.Add(TCurso.Create);
    FListaCurso[I].id := Ds.fieldByName('id_curso').AsInteger;
    FListaCurso[I].nome := Ds.fieldByName('nome').AsString;
    FListaCurso[I].Preco := Ds.fieldByName('preco').AsFloat;

    SQL := 'select nome from sala where id_sala in ' +
      '(select id_sala from sala_curso where id_curso = ' +
      QuotedSTR(IntToStr(FListaCurso[I].id)) + ')';

    FQuery2 := RetornarDataSet2(SQL);
    while not FQuery2.eof do
    begin
      FListaCurso[I].salas[count] := FQuery2.fieldByName('nome').AsString;
      FQuery2.Next;
      count := count + 1;
    end;

    Ds.Next;
    I := I + 1;
  end;
end;

function TCursoDAO.DeletarCurso(pCurso: TCurso): boolean;
var
  SQL: String;
begin
  try
    try
      SQL := 'Delete from Professor_curso where id_curso = ' +
        QuotedSTR(IntToStr(pCurso.id));
      ExecutarComando(SQL);

      SQL := 'Delete from sala_curso where id_curso = ' +
        QuotedSTR(IntToStr(pCurso.id));
      ExecutarComando(SQL);

      SQL := 'Delete from aluno_curso where id_curso = ' +
        QuotedSTR(IntToStr(pCurso.id));
      ExecutarComando(SQL);
    except

      on e: exception do
        raise exception.Create('Erro ao deletar curso de outras tabelas' + #13 +
          #13 + 'Erro original :' + e.Message);
    end;

  finally

    SQL := 'Delete from curso where id_curso = ' +
      QuotedSTR(IntToStr(pCurso.id));
    Result := ExecutarComando(SQL) > 0;
  end;
end;

destructor TCursoDAO.Destroy;
begin
  inherited;
end;

function TCursoDAO.ListaCurso: TFDQuery;
var
  SQL: string;
begin
  SQL := 'SELECT * FROM curso ORDER BY nome';
  FQuery := RetornarDataSet(SQL);

  Result := FQuery;
end;

function TCursoDAO.PesquisaCurso(pCurso: TCurso): TObjectList<TCurso>;
var
  SQL: string;
begin
  Result := nil;
  SQL := 'select * from curso where nome like ' +
    QuotedSTR('%' + pCurso.nome + '%')+
    ' and id_curso in (select id_curso from sala_curso where id_sala in (select id_sala from sala where nome like' + QuotedStr('%' +pCurso.salas[0] + '%')+ ')) ' + 'ORDER by nome';
  FQuery := RetornarDataSet(SQL);

  if not(FQuery.IsEmpty) then
  begin
    CriaLista(FQuery);
    Result := FListaCurso
  end;
end;

function TCursoDAO.RetornarId(pCurso: TCurso): integer;
var SQL : string;
begin
  SQL := 'select id_Curso from curso where nome like ' + QuotedSTR(pCurso.Nome);

  FQuery := RetornarDataSet(SQL);

  Result := FQuery.fieldByName('id_curso').AsInteger;
end;

function TCursoDAO.UpdateCurso(pCurso: TCurso): boolean;
var
  SQL: String;
begin
  SQL := 'update curso Set nome = ' + QuotedSTR(pCurso.nome) + ', preco = ' +
    QuotedSTR(CurrToStr(pCurso.Preco)) + ' where id_curso = ' +
    QuotedSTR(IntToStr(pCurso.id));

  Result := ExecutarComando(SQL) > 0;
end;

end.
