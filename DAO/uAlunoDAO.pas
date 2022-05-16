unit uAlunoDAO;

interface

uses uDAO, uAluno, system.generics.collections, FireDAC.Comp.Client, DB,
  system.sysUtils, uEndereco, uResponsavel, system.DateUtils, uCurso, uAula;

type
  TAlunoDAO = class(TConectDAO)
  protected
    FListaAluno: TobjectList<TAluno>;
    procedure preencherlista(Ds: TFDQuery);
  public
    Constructor Create;
    Destructor Destroy; override;
    function CadastrarAlunoResponsavel(pAluno: TAluno; pEndereco: TEndereco;
      pResponsavel: Tresponsavel): boolean;
    function CadastrarAluno(pAluno: TAluno; pEndereco: TEndereco): boolean;
    function CadastrarResponsavel(pResponsavel: Tresponsavel): boolean;
    function PesquisarAluno(pAluno: TAluno): TobjectList<TAluno>;
    function RetornaID(pAluno: TAluno): integer;
    function RetornaIDResponsavel(pResponsavel : TResponsavel):integer;
    function CadastrarAluno_curso(pAluno: TAluno; pCurso: TCurso): boolean;
    function UpdateAluno_curso(pAula: TAula): boolean;
    function DeleteAluno_curso(pAula: TAula): boolean;
    function RetornaAluno(id: integer): TAluno;
    function RetornaResponsavel(id: integer): Tresponsavel;
    function UpdateResponsavel(pResponsavel: Tresponsavel): boolean;
    function UpdateAlunoResponsavel(pAluno: TAluno): boolean;
    function UpdateAluno(pAluno: TAluno): boolean;
    function DeleteAluno(pAluno: TAluno): boolean;
    function DeleteReponsavel(pAluno: TAluno): boolean;

  end;

implementation

{ TAlunoDAO }

function TAlunoDAO.CadastrarAluno(pAluno: TAluno; pEndereco: TEndereco)
  : boolean;
var
  SQL: string;
begin

  SQL := 'select id_endereco from endereco ' +
    'where id_endereco not in (select id_endereco from aluno) ' +
    'and id_endereco not in (select id_endereco from professor)' +
    'and id_endereco not in (select id_endereco from adm)';

  FQuery := RetornarDataSet(SQL);

  pEndereco.id := FQuery.fieldByName('id_endereco').AsInteger;

  SQL := 'INSERT INTO aluno VALUES(default, ' + QuotedSTR(pAluno.Nome) + ', ' +
    QuotedSTR(InttoStr(pEndereco.id)) + ', null, ' +
    QuotedSTR(FormatDateTime('dd/mm/yyyy', pAluno.DataNasc)) + ', ' +
    QuotedSTR(pAluno.Cpf) + ', ' + QuotedSTR(pAluno.rg) + ', ' +
    QuotedSTR(pAluno.contatocom) + ', ' + QuotedSTR(pAluno.contato) + ', ' +
    QuotedSTR(pAluno.email) + ')';

  result := executarComando(SQL) > 0;
end;

function TAlunoDAO.CadastrarAlunoResponsavel(pAluno: TAluno;
  pEndereco: TEndereco; pResponsavel: Tresponsavel): boolean;
var
  SQL: string;
begin
  SQL := 'select id_endereco from endereco ' +
    'where id_endereco not in (select id_endereco from aluno) ' +
    'and id_endereco not in (select id_endereco from professor)' +
    'and id_endereco not in (select id_endereco from adm)';

  FQuery := RetornarDataSet(SQL);

  pEndereco.id := FQuery.fieldByName('id_endereco').AsInteger;

  SQL := 'SELECT id_responsavel FROM responsavel WHERE id_responsavel not in ' +
    '(Select id_responsavel from aluno where id_responsavel is not  null)';

  FQuery := RetornarDataSet(SQL);

  pResponsavel.id := FQuery.fieldByName('id_responsavel').AsInteger;

  SQL := 'INSERT INTO aluno VALUES(default, ' + QuotedSTR(pAluno.Nome) + ', ' +
    QuotedSTR(InttoStr(pEndereco.id)) + ', ' +
    QuotedSTR(InttoStr(pResponsavel.id)) + ', ' +
    QuotedSTR(FormatDateTime('dd/mm/yyyy', pAluno.DataNasc)) + ', ' +
    QuotedSTR(pAluno.Cpf) + ', ' + QuotedSTR(pAluno.rg) + ', ' +
    QuotedSTR(pAluno.contatocom) + ', ' + QuotedSTR(pAluno.contato) + ', ' +
    QuotedSTR(pAluno.email) + ')';

  result := executarComando(SQL) > 0;
end;

function TAlunoDAO.CadastrarAluno_curso(pAluno: TAluno; pCurso: TCurso)
  : boolean;
var
  SQL: string;
begin
  SQL := 'insert into aluno_curso values(' + QuotedSTR(InttoStr(pAluno.id)) +
    ', ' + QuotedSTR(InttoStr(pCurso.id)) + ')';

  result := executarComando(SQL) > 0;
end;

function TAlunoDAO.CadastrarResponsavel(pResponsavel: Tresponsavel): boolean;
Var
  SQL: string;
begin
  SQL := 'INSERT INTO responsavel VALUES (Default, ' +
    QuotedSTR(pResponsavel.Nome) + ', ' + QuotedSTR(pResponsavel.Cpf) + ', ' +
    QuotedSTR(pResponsavel.rg) + ', ' + QuotedSTR(pResponsavel.contato) + ', ' +
    QuotedSTR(pResponsavel.contatocom) + ', ' +
    QuotedSTR(FormatDateTime('dd/mm/yyyy', pResponsavel.DataNasc)) + ')';

  result := executarComando(SQL) > 0;
end;

constructor TAlunoDAO.Create;
begin
  inherited;
  FListaAluno := TobjectList<TAluno>.Create;
end;

function TAlunoDAO.DeleteAluno(pAluno: TAluno): boolean;
var
  SQL: string;
begin
  SQL := 'delete from aluno_curso where id_aluno = ' +
    QuotedSTR(InttoStr(pAluno.id)) + '; ';
  result := executarComando(SQL) > 0;

  SQL := 'delete from aula where id_aluno = ' +
    QuotedSTR(InttoStr(pAluno.id)) + '; ';
  result := executarComando(SQL) > 0;

  SQL := 'delete from aluno where id_aluno = ' +
    QuotedSTR(InttoStr(pAluno.id)) + '; ';
  result := executarComando(SQL) > 0;

  DeleteReponsavel(pAluno);

  SQL := 'delete from endereco where id_endereco = ' +
    QuotedSTR(InttoStr(pAluno.IdEndereco)) + '; ';
  result := executarComando(SQL) > 0;

end;

function TAlunoDAO.DeleteAluno_curso(pAula: TAula): boolean;
var
  SQL: string;
begin
  SQL := 'delete from aluno_curso where ctid in(select ctid from aluno_curso where id_aluno = ' +
    QuotedSTR(InttoStr(pAula.id_aluno)) + ' and id_curso = ' +
    QuotedSTR(InttoStr(pAula.id_curso)) + ' limit 1)';

  result := executarComando(SQL) > 0;
end;

function TAlunoDAO.DeleteReponsavel(pAluno: TAluno): boolean;
var
  SQL: string;
begin
  SQL := 'delete from responsavel where id_responsavel = ' +
    QuotedSTR(InttoStr(pAluno.IDResponsavel)) + '; ';
  result := executarComando(SQL) > 0;
end;

destructor TAlunoDAO.Destroy;
begin
  try
    inherited;

    if Assigned(FListaAluno) then
      FreeAndNil(FListaAluno);

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

function TAlunoDAO.PesquisarAluno(pAluno: TAluno): TobjectList<TAluno>;
var
  SQL: string;
begin
  result := nil;
  SQL := 'SELECT * FROM aluno WHERE nome LIKE ' +
    QuotedSTR('%' + pAluno.Nome + '%') + 'and cpf LIKE ' +
    QuotedSTR('%' + pAluno.Cpf + '%') + ' and telefone LIKE ' +
    QuotedSTR('%' + pAluno.contato + '%') +
    ' or id_aluno in (select id_aluno from aluno_curso where id_curso in ' +
    '(select id_curso from curso where nome like ' +
    QuotedSTR('%' + pAluno.Curso + '%') + ')) order by nome';

  FQuery := RetornarDataSet(SQL);

  if not(FQuery.IsEmpty) then
  begin
    preencherlista(FQuery);
    result := FListaAluno;
  end;
end;

procedure TAlunoDAO.preencherlista(Ds: TFDQuery);
var
  I: integer;
  SQL: String;
begin

  I := 0;
  FListaAluno.Clear;

  while not Ds.eof do
  begin
    if Ds.fieldByName('id_responsavel').AsInteger = 0 then
    begin
      FListaAluno.Add(TAluno.Create);
      FListaAluno[I].id := Ds.fieldByName('id_aluno').AsInteger;
      FListaAluno[I].Nome := Ds.fieldByName('nome').AsString;
      FListaAluno[I].IdEndereco := Ds.fieldByName('id_endereco').AsInteger;
      FListaAluno[I].IDResponsavel := Ds.fieldByName('id_responsavel')
        .AsInteger;
      FListaAluno[I].DataNasc := Ds.fieldByName('data_nasc').AsDateTime;
      FListaAluno[I].Cpf := Ds.fieldByName('cpf').AsString;
      FListaAluno[I].rg := Ds.fieldByName('rg').AsString;
      FListaAluno[I].contatocom := Ds.fieldByName('telefone_comercial')
        .AsString;
      FListaAluno[I].contato := Ds.fieldByName('telefone').AsString;
      FListaAluno[I].email := Ds.fieldByName('email').AsString;

      SQL := 'select nome from curso where id_curso in' +
        '(select id_curso from aluno_curso where id_aluno ' +
        'in (select id_aluno from aluno where id_aluno =' +
        QuotedSTR(Ds.fieldByName('id_aluno').AsString) + ' ))';

      FQuery2 := RetornarDataSet2(SQL);
      while not FQuery2.eof do
      begin
        FListaAluno[I].Tamanho := FListaAluno[I].Tamanho + 1;
        SetLength(FListaAluno[I].Cursos, FListaAluno[I].Tamanho);
        FListaAluno[I].Cursos[FListaAluno[I].Tamanho - 1] :=
          FQuery2.fieldByName('nome').AsString;
        FQuery2.Next;
      end;

      Ds.Next;
      I := I + 1;
    end
    else
    begin
      FListaAluno.Add(TAluno.Create);
      FListaAluno[I].id := Ds.fieldByName('id_aluno').AsInteger;
      FListaAluno[I].Nome := Ds.fieldByName('nome').AsString;
      FListaAluno[I].IdEndereco := Ds.fieldByName('id_endereco').AsInteger;
      FListaAluno[I].IDResponsavel := Ds.fieldByName('id_responsavel')
        .AsInteger;
      FListaAluno[I].email := Ds.fieldByName('email').AsString;

      SQL := 'select * from responsavel where id_responsavel in ' +
        '(select id_responsavel from aluno where id_aluno = ' +
        QuotedSTR(Ds.fieldByName('id_aluno').AsString) + ' )';
      FQuery2 := RetornarDataSet2(SQL);

      FListaAluno[I].DataNasc := FQuery2.fieldByName('data_nasc').AsDateTime;
      FListaAluno[I].Cpf := FQuery2.fieldByName('cpf').AsString;
      FListaAluno[I].rg := FQuery2.fieldByName('rg').AsString;
      FListaAluno[I].contatocom :=
        FQuery2.fieldByName('telefone_comercial').AsString;
      FListaAluno[I].contato := FQuery2.fieldByName('telefone').AsString;

      SQL := 'select nome from curso where id_curso in' +
        '(select id_curso from aluno_curso where id_aluno ' +
        'in (select id_aluno from aluno where id_aluno =' +
        QuotedSTR(Ds.fieldByName('id_aluno').AsString) + ' ))';

      FQuery2 := RetornarDataSet2(SQL);
      while not FQuery2.eof do
      begin
        FListaAluno[I].Tamanho := FListaAluno[I].Tamanho + 1;
        SetLength(FListaAluno[I].Cursos, FListaAluno[I].Tamanho);
        FListaAluno[I].Cursos[FListaAluno[I].Tamanho - 1] :=
          FQuery2.fieldByName('nome').AsString;
        FQuery2.Next;
      end;

      Ds.Next;
      I := I + 1;
    end;
  end;
end;

function TAlunoDAO.RetornaAluno(id: integer): TAluno;
var
  SQL: string;
  aluno: TAluno;
begin
  SQL := 'Select * from Aluno where id_aluno = ' + QuotedSTR(InttoStr(id));

  FQuery := RetornarDataSet(SQL);

  aluno := TAluno.Create;
  aluno.id := id;
  aluno.Nome := FQuery.fieldByName('nome').AsString;
  aluno.Cpf := FQuery.fieldByName('cpf').AsString;
  aluno.rg := FQuery.fieldByName('rg').AsString;
  aluno.DataNasc := FQuery.fieldByName('data_nasc').AsDateTime;
  aluno.contato := FQuery.fieldByName('telefone').AsString;
  aluno.email := FQuery.fieldByName('email').AsString;
  aluno.IDResponsavel := FQuery.fieldByName('id_responsavel').AsInteger;
  aluno.contatocom := FQuery.fieldByName('telefone_comercial').AsString;
  aluno.IdEndereco := FQuery.fieldByName('id_endereco').AsInteger;

  result := aluno;
end;

function TAlunoDAO.RetornaID(pAluno: TAluno): integer;
var
  SQL: string;
begin
  SQL := 'select id_aluno from aluno where cpf = ' + QuotedSTR(pAluno.Cpf) +
    ' and nome = ' + QuotedSTR(pAluno.Nome);

  FQuery := RetornarDataSet(SQL);

  result := FQuery.fieldByName('id_aluno').AsInteger;
end;

function TAlunoDAO.RetornaIDResponsavel(pResponsavel: TResponsavel): integer;
var SQL : string;
begin
  SQL := 'select id_responsavel from responsavel where cpf = ' + QuotedSTR(pResponsavel.Cpf) +
    ' and nome = ' + QuotedSTR(pResponsavel.Nome);

  FQuery := RetornarDataSet(SQL);

  result := FQuery.fieldByName('id_responsavel').AsInteger;
end;

function TAlunoDAO.RetornaResponsavel(id: integer): Tresponsavel;
var
  SQL: string;
  Responsavel: Tresponsavel;
begin
  SQL := 'Select * from responsavel where id_responsavel = ' +
    QuotedSTR(InttoStr(id));

  FQuery := RetornarDataSet(SQL);

  Responsavel := Tresponsavel.Create;
  Responsavel.id := id;
  Responsavel.Nome := FQuery.fieldByName('nome').AsString;
  Responsavel.Cpf := FQuery.fieldByName('cpf').AsString;
  Responsavel.rg := FQuery.fieldByName('rg').AsString;
  Responsavel.DataNasc := FQuery.fieldByName('data_nasc').AsDateTime;
  Responsavel.contato := FQuery.fieldByName('telefone').AsString;
  Responsavel.contatocom := FQuery.fieldByName('telefone_comercial').AsString;

  result := Responsavel;
end;

function TAlunoDAO.UpdateAluno(pAluno: TAluno): boolean;
var
  SQL: string;
begin
  SQL := 'update aluno set nome = ' + QuotedSTR(pAluno.Nome) +
    ', id_endereco = ' + QuotedSTR(InttoStr(pAluno.IdEndereco)) +
    ', id_responsavel = null' + ', cpf = ' + QuotedSTR(pAluno.Cpf) + ', rg = ' +
    QuotedSTR(pAluno.rg) + ', telefone = ' + QuotedSTR(pAluno.contato) +
    ', telefone_comercial = ' + QuotedSTR(pAluno.contatocom) + ', data_nasc = '
    + QuotedSTR(DateToStr(pAluno.DataNasc)) + ', email = ' +
    QuotedSTR(pAluno.email) + ' where id_aluno = ' +
    QuotedSTR(InttoStr(pAluno.id));

  result := executarComando(SQL) > 0;
end;

function TAlunoDAO.UpdateAlunoResponsavel(pAluno: TAluno): boolean;
var
  SQL: string;
begin

  SQL := 'update aluno set nome = ' + QuotedSTR(pAluno.Nome) +
    ', id_endereco = ' + QuotedSTR(InttoStr(pAluno.IdEndereco)) +
    ', id_responsavel = ' + QuotedSTR(InttoStr(pAluno.IDResponsavel)) +
    ', cpf = ' + QuotedSTR(pAluno.Cpf) + ', rg = ' + QuotedSTR(pAluno.rg) +
    ', telefone = ' + QuotedSTR(pAluno.contato) + ', telefone_comercial = ' +
    QuotedSTR(pAluno.contatocom) + ', data_nasc = ' +
    QuotedSTR(DateToStr(pAluno.DataNasc)) + ', email = ' +
    QuotedSTR(pAluno.email) + ' where id_aluno = ' +
    QuotedSTR(InttoStr(pAluno.id));

  result := executarComando(SQL) > 0;
end;

function TAlunoDAO.UpdateAluno_curso(pAula: TAula): boolean;
var
  SQL: string;
begin
  SQL := 'update aluno_curso set id_aluno = ' +
    QuotedSTR(InttoStr(pAula.id_aluno)) + ', id_curso = ' +
    QuotedSTR(InttoStr(pAula.id_curso)) + 'where id_aluno = (select id_aluno' +
    ' from aluno where nome = ' + QuotedSTR(pAula.aluno) +
    ') and id_curso = (select id_curso ' + 'from curso where nome = ' +
    QuotedSTR(pAula.Curso) + ')';

  result := executarComando(SQL) > 0;
end;

function TAlunoDAO.UpdateResponsavel(pResponsavel: Tresponsavel): boolean;
var
  SQL: string;
begin
  SQL := 'update responsavel set nome = ' + QuotedSTR(pResponsavel.Nome) +
    ', cpf = ' + QuotedSTR(pResponsavel.Cpf) + ', rg = ' +
    QuotedSTR(pResponsavel.rg) + ', telefone = ' +
    QuotedSTR(pResponsavel.contato) + ', telefone_comercial = ' +
    QuotedSTR(pResponsavel.contatocom) + ', data_nasc = ' +
    QuotedSTR(DateToStr(pResponsavel.DataNasc)) + ' where id_responsavel =' +
    QuotedSTR(InttoStr(pResponsavel.id));

  result := executarComando(SQL) > 0;
end;

end.
