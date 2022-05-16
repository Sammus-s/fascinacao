unit uSalaDAO;

interface

uses sysUtils, uDAO, Vcl.CheckLst, uSala, FireDac.Comp.client, DB, uCurso, uAula;

type
  TSalaDao = class(TConectDAO)
  private
    FCLSalas: TCheckListBox;

  public
    function ListaSAla: TFDQuery;
    function PesquisaSalaCurso(pCurso: String): TFDQuery;
    function PesquisaSalaProfessor(pCurso: String): TFDQuery;
    function CadastroCurso_sala(pCurso: Tcurso): boolean;
    function UpdateSala_curso(pCurso: Tcurso): boolean;
    function SalaLivre(hora: TTime; Dia: string; pSala: TSala): boolean;
    function SalaLivreUpdate(pAula : TAula): Boolean;
    function RetornaID(pSala : TSala): integer;
    Constructor Create;
    Destructor Destroy; override;
  end;

implementation

{ TSalaDao }

function TSalaDao.CadastroCurso_sala(pCurso: Tcurso): boolean;
var
  SQL: string;
  I: Integer;
begin
  for I := 0 to 4 do
    if pCurso.salas[I] <> '' then
    begin
      SQL := 'select id_sala From sala where nome = ' +
        QuotedStr(pCurso.salas[I]);

      FQuery := RetornarDataSet(SQL);

      pCurso.IDSala := FQuery.FieldByName('id_sala').Asinteger;

      SQL := 'select id_curso from curso where nome like ' +
        QuotedStr('%' + pCurso.Nome + '%');

      FQuery := RetornarDataSet(SQL);

      pCurso.id := FQuery.FieldByName('id_curso').Asinteger;

      SQL := 'insert into sala_curso values(' +
        QuotedStr(IntToStr(pCurso.IDSala)) + ', ' +
        QuotedStr(IntToStr(pCurso.id)) + ')';

      Result := ExecutarComando(SQL) > 0;
    end;
end;

constructor TSalaDao.Create;
begin
  inherited;
end;

function TSalaDao.ListaSAla: TFDQuery;
var
  SQL: string;
begin
  SQL := 'SELECT nome FROM sala';
  FQuery := RetornarDataSet(SQL);

  Result := FQuery;
end;

function TSalaDao.PesquisaSalaCurso(pCurso: String): TFDQuery;
var
  SQL: String;
begin
  SQL := 'select nome from sala where id_sala in ' +
    '(select id_sala from sala_curso where id_curso in ' +
    '(Select id_curso from curso where nome like ' + QuotedStr(pCurso) + '))';
  FQuery := RetornarDataSet(SQL);

  Result := FQuery;
end;

function TSalaDao.PesquisaSalaProfessor(pCurso: String): TFDQuery;
var
  SQL: string;
begin
  SQL := 'select nome from professor where id_professor in ' +
    '(select id_professor from professor_curso where id_curso in ' +
    '(Select id_curso from curso where nome like ' + QuotedStr(pCurso) + '))';
  FQuery := RetornarDataSet(SQL);

  Result := FQuery;
end;

function TSalaDao.RetornaID(pSala: TSala): integer;
var SQL : string;
begin
  SQL := 'select id_sala from sala where nome = ' + QuotedStr(pSala.Nome);

  FQuery := RetornarDataSet(SQL);

  Result := FQuery.FieldByName('id_sala').AsInteger;
end;

function TSalaDao.SalaLivre(hora: TTime; Dia: string; pSala: TSala)
  : boolean;
var
  SQL: string;
  Hora_inicio: TTime;
  hora_Fim_aula,Hora_fim: TTime;
  dia_aula: String;
  HoraAux : TTime;

begin
  Result := true;
  HoraAux := StrToTime('01:00:00');
  hora_Fim_aula := hora + HoraAux;

  SQL := 'select id_sala from sala where nome = ' +
    QuotedStr(pSala.Nome);
  FQuery := RetornarDataSet(SQL);
  pSala.id := FQuery.FieldByName('id_sala').Asinteger;

  SQL := 'select hora_inicio, dia from aula where id_sala = ' +
    QuotedStr(IntToStr(pSala.id));

  FQuery := RetornarDataSet(SQL);

  while not FQuery.eof do
  begin
    Hora_inicio := FQuery.FieldByName('hora_inicio').AsDateTime;
    Hora_fim := Hora_inicio + HoraAux;
    dia_aula := FQuery.FieldByName('dia').AsString;

    if Dia = dia_aula then
    begin
      if (Hora_inicio < hora) and (hora < Hora_fim) then
        Result := false;

      if (Hora_inicio < hora + HoraAux) and (hora + HoraAux < Hora_fim) then
        Result := false;

      if (Hora_inicio = hora) and (hora_Fim_aula = Hora_fim) then
        Result := false;
    end;
    FQuery.Next;
  end;
end;

function TSalaDao.SalaLivreUpdate(pAula: TAula): Boolean;
var SQL: string;
  Hora_inicio: TTime;
  Hora_fim: TTime;
  dia_aula: String;
  HoraAux : TTime;
begin
  Result := true;
  HoraAux := StrToTime('01:00:00');

  SQL := 'select hora_inicio, dia from aula where id_sala = ' +
    QuotedStr(IntToStr(pAula.id_sala)) + 'and id_aula <> ' + QuotedStr(IntToStr(pAula.id));

  FQuery := RetornarDataSet(SQL);

  while not FQuery.eof do
  begin
    Hora_inicio := FQuery.FieldByName('hora_inicio').AsDateTime;
    Hora_fim := Hora_inicio + HoraAux;
    dia_aula := FQuery.FieldByName('dia').AsString;

    if pAula.dia = dia_aula then
    begin
      if (Hora_inicio < paula.hora_inicio) and (paula.hora_inicio < Hora_fim) then
        Result := false;

      if (Hora_inicio < paula.hora_inicio + HoraAux) and (paula.hora_inicio + HoraAux < Hora_fim) then
        Result := false;
    end;
    FQuery.Next;
  end;

end;

function TSalaDao.UpdateSala_curso(pCurso: Tcurso): boolean;
var
  SQL: String;
  I: Integer;
begin
  SQL := 'Delete from sala_curso where id_curso = ' +
    QuotedStr(IntToStr(pCurso.id));
  ExecutarComando(SQL);

  for I := 0 to 4 do
    if pCurso.salas[I] <> '' then
    begin
      SQL := 'select id_sala From sala where nome = ' +
        QuotedStr(pCurso.salas[I]);

      FQuery := RetornarDataSet(SQL);

      pCurso.IDSala := FQuery.FieldByName('id_sala').Asinteger;

      SQL := 'select id_curso from curso where nome like ' +
        QuotedStr('%' + pCurso.Nome + '%');

      FQuery := RetornarDataSet(SQL);

      pCurso.id := FQuery.FieldByName('id_curso').Asinteger;

      SQL := 'insert into sala_curso values(' +
        QuotedStr(IntToStr(pCurso.IDSala)) + ', ' +
        QuotedStr(IntToStr(pCurso.id)) + ')';

      Result := ExecutarComando(SQL) > 0;
    end;
end;

destructor TSalaDao.Destroy;
begin
  try
    inherited;

    if Assigned(FCLSalas) then
      FreeAndNil(FCLSalas);

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

end.
