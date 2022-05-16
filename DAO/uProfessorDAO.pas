unit uProfessorDAO;

interface

uses system.SysUtils, uDAO, uProfessor, uEndereco, system.Generics.Collections,
  FireDac.comp.Client, Data.db, uAula, system.uitypes;

type
  TProfessorDAO = class(TconectDAO)
  private
    FListaProfessor: TObjectList<TProfessor>;
    FListaHorario: TObjectList<TProfessor>;
    procedure CriaLista(Ds: TFDQuery);
    procedure CriaListaHora(Ds: TFDQuery);
  public
    Constructor Create;
    Destructor Destroy; override;
    function CadastrarProfessor(pProfessor: TProfessor;
      pEndereco: TEndereco): boolean;
    function CadastrarProfessor_Curso(pProfessor: TProfessor): boolean;
    function PesquisaProfessor(pProfessor: TProfessor): TObjectList<TProfessor>;
    function CadastroHorario(pProfessor: TProfessor): boolean;
    function ListarHorario(pProfessor: TProfessor): TObjectList<TProfessor>;
    function EditProfessor(pProfessor: TProfessor): boolean;
    function UpdateProfessor_curso(pProfessor: TProfessor): boolean;
    function Deletar_horario(pProfessor: TProfessor): boolean;
    function HorarioLivre(hora: TDateTime; Dia: string;
      pProfessor: TProfessor): boolean;
    function HorarioLivreUpdate(pAula: TAula): boolean;
    function RetornaID(pProfessor: TProfessor): integer;
    function RetornaProfessor(pProfessor: TProfessor): TProfessor;
    function DeleteProfessor(pProfessor: TProfessor): boolean;
    function DeleteAluno_curso(pProfessor: TProfessor): boolean;

  end;

implementation

{ TProfessorDAO }

function TProfessorDAO.CadastrarProfessor(pProfessor: TProfessor;
  pEndereco: TEndereco): boolean;
var
  SQL: string;
begin

  SQL := 'select id_endereco from endereco ' +
    'where id_endereco not in (select id_endereco from aluno) ' +
    'and id_endereco not in (select id_endereco from professor)' +
    'and id_endereco not in (select id_endereco from adm)';

  FQuery := RetornarDataSet(SQL);

  pEndereco.id := FQuery.fieldByName('id_endereco').AsInteger;

  SQL := 'INSERT INTO professor VALUES(default, ' + QuotedSTR(pProfessor.Nome) +
    ', ' + QuotedSTR(InttoStr(pEndereco.id)) + ', ' +
    QuotedSTR(FormatDateTime('dd/mm/yyyy', pProfessor.DataNasc)) + ', ' +
    QuotedSTR(pProfessor.Cpf) + ', ' + QuotedSTR(pProfessor.rg) + ', ' +
    QuotedSTR(pProfessor.CNPJ) + ', ' + QuotedSTR(pProfessor.contato) + ', ' +
    QuotedSTR(pProfessor.email) + ')';

  result := executarComando(SQL) > 0;
end;

function TProfessorDAO.CadastrarProfessor_Curso(pProfessor: TProfessor)
  : boolean;
var
  I: integer;
  SQL: string;
begin
  for I := 0 to pProfessor.Tamanho - 1 do
    if pProfessor.Cursos[I] <> '' then
    begin
      SQL := 'SELECT id_Professor FROM professor WHERE cpf = ' +
        QuotedSTR(pProfessor.Cpf);
      FQuery := RetornarDataSet(SQL);
      pProfessor.id := FQuery.fieldByName('id_professor').AsInteger;

      SQL := 'SELECT id_curso FROM curso WHERE nome = ' +
        QuotedSTR(pProfessor.Cursos[I]);
      FQuery := RetornarDataSet(SQL);
      pProfessor.Curso := FQuery.fieldByName('id_curso').AsString;

      SQL := 'INSERT INTO professor_curso VALUES (' +
        QuotedSTR(InttoStr(pProfessor.id)) + ', ' +
        QuotedSTR(pProfessor.Curso) + ')';

      result := executarComando(SQL) > 0;
    end;

end;

function TProfessorDAO.CadastroHorario(pProfessor: TProfessor): boolean;
var
  SQL: string;
begin
  SQL := 'INSERT INTO horario_professor	VALUES(default, ' +
    QuotedSTR(InttoStr(pProfessor.id)) + ', ' +
    QuotedSTR(FormatDateTime('HH:mm', pProfessor.HoraInicio)) + ', ' +
    QuotedSTR(FormatDateTime('HH:mm', pProfessor.HoraFim)) + ', ' +
    QuotedSTR(pProfessor.Dia) + ')';

  result := executarComando(SQL) > 0;
end;

constructor TProfessorDAO.Create;
begin
  inherited;
  FListaHorario := TObjectList<TProfessor>.Create;
  FListaProfessor := TObjectList<TProfessor>.Create;
end;

procedure TProfessorDAO.CriaLista(Ds: TFDQuery);
var
  I, count: integer;
  SQL: string;
begin
  I := 0;
  FListaProfessor.Clear;

  while not Ds.eof do
  begin
    FListaProfessor.Add(TProfessor.Create);
    FListaProfessor[I].id := Ds.fieldByName('id_professor').AsInteger;
    FListaProfessor[I].Nome := Ds.fieldByName('nome').AsString;
    FListaProfessor[I].IDEndereco := Ds.fieldByName('id_endereco').AsInteger;
    FListaProfessor[I].DataNasc := Ds.fieldByName('data_nasc').AsDateTime;
    FListaProfessor[I].Cpf := Ds.fieldByName('cpf').AsString;
    FListaProfessor[I].rg := Ds.fieldByName('rg').AsString;
    FListaProfessor[I].CNPJ := Ds.fieldByName('cnpj').AsString;
    FListaProfessor[I].contato := Ds.fieldByName('telefone').AsString;
    FListaProfessor[I].email := Ds.fieldByName('email').AsString;

    SQL := 'select nome from curso where id_curso in ' +
      '(select id_curso from professor_curso where id_professor =' +
      QuotedSTR(InttoStr(FListaProfessor[I].id)) + ' )';
    FQuery2 := RetornarDataSet2(SQL);

    while not FQuery2.eof do
    begin
      FListaProfessor[I].Tamanho := FListaProfessor[I].Tamanho + 1;
      SetLength(FListaProfessor[I].Cursos, FListaProfessor[I].Tamanho);
      FListaProfessor[I].Cursos[FListaProfessor[I].Tamanho - 1] :=
        FQuery2.fieldByName('nome').AsString;
      FQuery2.Next;
    end;

    Ds.Next;
    I := I + 1;
  end;

end;

procedure TProfessorDAO.CriaListaHora(Ds: TFDQuery);
var
  I: integer;
begin
  I := 0;
  FListaHorario.Clear;

  while not Ds.eof do
  begin
    FListaHorario.Add(TProfessor.Create);
    FListaHorario[I].IdHora := Ds.fieldByName('id_horario').AsInteger;
    FListaHorario[I].HoraInicio := Ds.fieldByName('hora_inicio').AsDateTime;
    FListaHorario[I].HoraFim := Ds.fieldByName('hora_fim').AsDateTime;
    FListaHorario[I].Dia := Ds.fieldByName('dia').AsString;

    Ds.Next;
    I := I + 1;
  end;
end;

function TProfessorDAO.Deletar_horario(pProfessor: TProfessor): boolean;
var
  SQL: String;
begin
  SQL := 'Delete from horario_professor where id_horario = ' +
    QuotedSTR(InttoStr(pProfessor.IdHora));

  result := executarComando(SQL) > 0;
end;

function TProfessorDAO.DeleteAluno_curso(pProfessor: TProfessor): boolean;
var
  SQL: string;
  Aula: TAula;
begin
  try
    Aula := TAula.Create;

    SQL := 'select * from aula where id_professor = ' +
      QuotedSTR(InttoStr(pProfessor.id));
    FQuery2 := RetornarDataSet2(SQL);
    while not FQuery2.eof do
    begin
      Aula.id_aluno := FQuery2.fieldByName('id_aluno').AsInteger;
      Aula.id_curso := FQuery2.fieldByName('id_curso').AsInteger;

      SQL := 'delete from aluno_curso where ctid in(select ctid from aluno_curso where id_aluno = '
        + QuotedSTR(InttoStr(Aula.id_aluno)) + ' and id_curso =' +
        QuotedSTR(InttoStr(Aula.id_curso)) + ' limit 1)';
      executarComando(SQL);
      FQuery2.Next;
    end;
  finally
    Aula.Free;
  end;
end;

function TProfessorDAO.DeleteProfessor(pProfessor: TProfessor): boolean;
VAR
  SQL: string;
begin
  DeleteAluno_curso(pProfessor);

  SQL := 'delete from horario_professor where id_professor = ' +
    QuotedSTR(InttoStr(pProfessor.id));
  result := executarComando(SQL) > 0;

  SQL := 'delete from professor_curso where id_professor = ' +
    QuotedSTR(InttoStr(pProfessor.id));
  result := executarComando(SQL) > 0;

  SQL := 'delete from aula where id_professor = ' +
    QuotedSTR(InttoStr(pProfessor.id));
  result := executarComando(SQL) > 0;

  SQL := 'delete from professor where id_professor = ' +
    QuotedSTR(InttoStr(pProfessor.id));
  result := executarComando(SQL) > 0;

  SQL := 'delete from endereco where id_endereco = ' +
    QuotedSTR(InttoStr(pProfessor.IDEndereco));
  result := executarComando(SQL) > 0;
end;

destructor TProfessorDAO.Destroy;
begin
  inherited;
  if Assigned(FListaProfessor) then
    FreeAndNil(FListaProfessor);
  if Assigned(FListaHorario) then
    FreeAndNil(FListaHorario);
end;

function TProfessorDAO.EditProfessor(pProfessor: TProfessor): boolean;
var
  SQL: string;
begin
  SQL := 'update professor Set nome = ' + QuotedSTR(pProfessor.Nome) +
    ', data_nasc = ' + QuotedSTR(DateToStr(pProfessor.DataNasc)) + ', cpf = ' +
    QuotedSTR(pProfessor.Cpf) + ', rg = ' + QuotedSTR(pProfessor.rg) +
    ', cnpj = ' + QuotedSTR(pProfessor.CNPJ) + ', telefone = ' +
    QuotedSTR(pProfessor.contato) + ', email = ' + QuotedSTR(pProfessor.email) +
    ' where id_professor = ' + QuotedSTR(InttoStr(pProfessor.id));

  result := executarComando(SQL) > 0;
end;

function TProfessorDAO.HorarioLivre(hora: TDateTime; Dia: string;
  pProfessor: TProfessor): boolean;
var
  SQL: string;
  Professor: TProfessor;
  hora_Fim_aula, HoraAux: TTime;
begin
  result := true;
  Professor := TProfessor.Create;
  HoraAux := StrToTime('01:00:00');
  hora_Fim_aula := hora + HoraAux;

  SQL := 'select id_professor from professor where nome = ' +
    QuotedSTR(pProfessor.Nome);
  FQuery := RetornarDataSet(SQL);
  pProfessor.id := FQuery.fieldByName('id_professor').AsInteger;

  SQL := 'select hora_inicio, hora_fim, dia from horario_professor ' +
    'where id_professor = ' + QuotedSTR(InttoStr(pProfessor.id));

  FQuery := RetornarDataSet(SQL);

  while not FQuery.eof do
  begin
    Professor.HoraInicio := FQuery.fieldByName('hora_inicio').AsDateTime;
    Professor.HoraFim := FQuery.fieldByName('hora_fim').AsDateTime;
    Professor.Dia := FQuery.fieldByName('dia').AsString;

    if Dia = Professor.Dia then
    begin
      if (Professor.HoraInicio < hora) and (hora < Professor.HoraFim) then
        result := false;

      if (Professor.HoraInicio < hora + HoraAux) and
        (hora + HoraAux < Professor.HoraFim) then
        result := false;

      if (Professor.HoraInicio = hora) and (hora_Fim_aula = Professor.HoraFim)
      then
        result := false;
    end;
    FQuery.Next;
  end;

  SQL := 'select hora_inicio, dia from aula' + ' where id_professor = ' +
    QuotedSTR(InttoStr(pProfessor.id));

  FQuery := RetornarDataSet(SQL);

  while not FQuery.eof do
  begin
    Professor.HoraInicio := FQuery.fieldByName('hora_inicio').AsDateTime;
    Professor.HoraFim := Professor.HoraInicio + HoraAux;
    Professor.Dia := FQuery.fieldByName('dia').AsString;

    if Dia = Professor.Dia then
    begin
      if (Professor.HoraInicio < hora) and (hora < Professor.HoraFim) then
        result := false;

      if (Professor.HoraInicio < hora + HoraAux) and
        (hora + HoraAux < Professor.HoraFim) then
        result := false;

      if (Professor.HoraInicio = hora) and (hora + HoraAux = Professor.HoraFim)
      then
        result := false;
    end;
    FQuery.Next;
  end;

end;

function TProfessorDAO.HorarioLivreUpdate(pAula: TAula): boolean;
var
  SQL: string;
  HoraAux: TTime;
  Professor: TProfessor;
begin
  result := true;
  Professor := TProfessor.Create;
  HoraAux := StrToTime('01:00:00');

  SQL := 'select hora_inicio, hora_fim, dia from horario_professor ' +
    'where id_professor = ' + QuotedSTR(InttoStr(pAula.id_professor));

  FQuery := RetornarDataSet(SQL);

  while not FQuery.eof do
  begin
    Professor.HoraInicio := FQuery.fieldByName('hora_inicio').AsDateTime;
    Professor.HoraFim := FQuery.fieldByName('hora_fim').AsDateTime;
    Professor.Dia := FQuery.fieldByName('dia').AsString;

    if pAula.Dia = Professor.Dia then
    begin
      if (Professor.HoraInicio < pAula.hora_inicio) and
        (pAula.hora_inicio < Professor.HoraFim) then
        result := false;

      if (Professor.HoraInicio < pAula.hora_inicio + HoraAux) and
        (pAula.hora_inicio + HoraAux < Professor.HoraFim) then
        result := false;

      if (Professor.HoraInicio = pAula.hora_inicio) and
        (pAula.hora_inicio + HoraAux = Professor.HoraFim) then
        result := false;

    end;
    FQuery.Next;
  end;

  SQL := 'select hora_inicio, dia from aula' + ' where id_professor = ' +
    QuotedSTR(InttoStr(pAula.id_professor)) + ' and id_aula <> ' +
    QuotedSTR(InttoStr(pAula.id));
  FQuery := RetornarDataSet(SQL);

  while not FQuery.eof do
  begin
    Professor.HoraInicio := FQuery.fieldByName('hora_inicio').AsDateTime;
    Professor.HoraFim := Professor.HoraInicio + HoraAux;
    Professor.Dia := FQuery.fieldByName('dia').AsString;

    if pAula.Dia = Professor.Dia then
    begin
      if (Professor.HoraInicio < pAula.hora_inicio) and
        (pAula.hora_inicio < Professor.HoraFim) then
        result := false;

      if (Professor.HoraInicio < pAula.hora_inicio + HoraAux) and
        (pAula.hora_inicio + HoraAux < Professor.HoraFim) then
        result := false;

    end;
    FQuery.Next;
  end;

end;

function TProfessorDAO.ListarHorario(pProfessor: TProfessor)
  : TObjectList<TProfessor>;
var
  SQL: string;
begin
  result := nil;
  SQL := 'SELECT * FROM horario_professor WHERE id_professor = ' +
    QuotedSTR(InttoStr(pProfessor.id));

  FQuery := RetornarDataSet(SQL);

  if not(FQuery.IsEmpty) then
  begin
    CriaListaHora(FQuery);
    result := FListaHorario;
  end;
end;

function TProfessorDAO.PesquisaProfessor(pProfessor: TProfessor)
  : TObjectList<TProfessor>;
var
  SQL: string;
begin
  result := nil;
  SQL := 'SELECT * FROM professor WHERE nome LIKE ' +
    QuotedSTR('%' + pProfessor.Nome + '%') + 'and cnpj LIKE ' +
    QuotedSTR('%' + pProfessor.CNPJ + '%') + ' and telefone LIKE ' +
    QuotedSTR('%' + pProfessor.contato + '%') +
    'and id_professor in (select id_professor from professor_curso where id_curso in (select id_curso from curso where nome like '
    + QuotedSTR('%' + pProfessor.Curso + '%') + ')) order by nome';

  FQuery := RetornarDataSet(SQL);

  if not(FQuery.IsEmpty) then
  begin
    CriaLista(FQuery);
    result := FListaProfessor;
  end;
end;

function TProfessorDAO.RetornaID(pProfessor: TProfessor): integer;
var
  SQL: string;
begin
  SQL := 'select id_Professor from professor where nome = ' +
    QuotedSTR(pProfessor.Nome);

  FQuery := RetornarDataSet(SQL);

  result := FQuery.fieldByName('id_Professor').AsInteger;
end;

function TProfessorDAO.RetornaProfessor(pProfessor: TProfessor): TProfessor;
var
  SQL: string;
  Professor: TProfessor;
begin
  SQL := 'select * from professor where id_professor = ' +
    QuotedSTR(InttoStr(pProfessor.id));
  FQuery := RetornarDataSet(SQL);

  Professor := TProfessor.Create;
  Professor.id := FQuery.fieldByName('id_professor').AsInteger;
  Professor.Nome := FQuery.fieldByName('nome').AsString;
  Professor.IDEndereco := FQuery.fieldByName('id_endereco').AsInteger;
  Professor.DataNasc := FQuery.fieldByName('data_nasc').AsDateTime;
  Professor.Cpf := FQuery.fieldByName('cpf').AsString;
  Professor.rg := FQuery.fieldByName('rg').AsString;
  Professor.CNPJ := FQuery.fieldByName('cnpj').AsString;
  Professor.contato := FQuery.fieldByName('telefone').AsString;
  Professor.email := FQuery.fieldByName('email').AsString;

  SQL := 'select nome from curso where id_curso in ' +
    '(select id_curso from professor_curso where id_professor =' +
    QuotedSTR(InttoStr(pProfessor.id)) + ' )';
  FQuery := RetornarDataSet(SQL);

  while not FQuery.eof do
  begin
    Professor.Tamanho := Professor.Tamanho + 1;
    SetLength(Professor.Cursos, Professor.Tamanho);
    Professor.Cursos[Professor.Tamanho - 1] :=
      FQuery.fieldByName('nome').AsString;
    FQuery.Next;
  end;

  result := Professor;
end;

function TProfessorDAO.UpdateProfessor_curso(pProfessor: TProfessor): boolean;
var
  SQL: string;
  I: integer;
begin
  SQL := 'Delete from professor_curso where id_professor = ' +
    QuotedSTR(InttoStr(pProfessor.id));

  executarComando(SQL);

  for I := 0 to pProfessor.Tamanho - 1 do
    if pProfessor.Cursos[I] <> '' then
    begin
      SQL := 'SELECT id_Professor FROM professor WHERE cpf = ' +
        QuotedSTR(pProfessor.Cpf);
      FQuery := RetornarDataSet(SQL);
      pProfessor.id := FQuery.fieldByName('id_professor').AsInteger;

      SQL := 'SELECT id_curso FROM curso WHERE nome = ' +
        QuotedSTR(pProfessor.Cursos[I]);
      FQuery := RetornarDataSet(SQL);
      pProfessor.Curso := FQuery.fieldByName('id_curso').AsString;

      SQL := 'INSERT INTO professor_curso VALUES (' +
        QuotedSTR(InttoStr(pProfessor.id)) + ', ' +
        QuotedSTR(pProfessor.Curso) + ')';

      result := executarComando(SQL) > 0;
    end;
end;

end.
