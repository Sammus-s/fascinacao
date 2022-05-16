unit uAulaDAO;

interface

uses uDAO, uAula, FireDac.comp.client, system.sysUtils,
  system.generics.collections, Vcl.ExtCtrls, Vcl.StdCtrls,
  uAluno, uCurso, uSalaDAO, uSala, system.UITypes, Vcl.Graphics;

type
  TAulaDAO = class(TConectDAO)
  private
    FLista: TObjectList<TAula>;
    procedure Crialista(Ds: TFDQuery);
  public
    function CadastroAula(pAula: TAula): boolean;
    constructor Create;
    Destructor Destroy; override;
    function PesquisaAula(pAluno: TAluno): TObjectList<TAula>;
    procedure TrocaID(pAula: TAula);
    function DeletarAula(pAula: TAula): boolean;
    function UpdateAula(pAula: TAula): boolean;
    function RetornaAula(pAula: TAula): TAula;
    function CriaAula( pParent: TPanel; pDia, pSala: string): TPanel;

  end;

var
  SQL: string;
  SalaDAO: TSalaDao;
  Sala: TSala;
  Aula: TAula;

implementation

{ TAulaDAO }

uses uFrmCronograma;

function TAulaDAO.CadastroAula(pAula: TAula): boolean;
begin
  SQL := 'insert into aula values (default, ' +
    QuotedSTR(IntToStr(pAula.id_Aluno)) + ', ' +
    QuotedSTR(IntToStr(pAula.id_professor)) + ', ' +
    QuotedSTR(IntToStr(pAula.id_sala)) + ', ' +
    QuotedSTR(IntToStr(pAula.id_curso)) + ', ' +
    QuotedSTR(FormatDateTime('dd/mm/yyyy HH:mm:ss', pAula.hora_inicio)) + ', ' +
    QuotedSTR(pAula.dia) + ')';

  Result := ExecutarComando(SQL) > 0;
end;

constructor TAulaDAO.Create;
begin
  inherited;
  FLista := TObjectList<TAula>.Create;
  SalaDAO := TSalaDao.Create;
  Sala := TSala.Create;
  Aula := TAula.Create;
end;

function TAulaDAO.CriaAula( pParent: TPanel; pDia, pSala: string): TPanel;
var
  Panel, faixa: TPanel;
  Labels: TLabel;
  I: integer;
  myHour, myMin, mySec, myMilli : Word;
  pSQL: string;
begin
  Result := nil;

  for I := (pParent.ControlCount - 1) downto 0 do
  begin
    if pParent.Controls[i] is TPanel then
    pParent.Controls[i].Free;
  end;

  Sala.Nome := pSala;
  Aula := TAula.Create;
  pSQL := 'select * from aula where id_sala = ' +
    QuotedSTR(IntToStr(SalaDAO.RetornaID(Sala))) + 'and dia = ' +
    QuotedSTR(pDia);
  FQuery := RetornarDataSet(pSQL);

  if not FQuery.IsEmpty then
    while not FQuery.eof do
    begin
      Aula.id := FQuery.FieldByName('id_aula').AsInteger;
      Aula := RetornaAula(Aula);

      Panel := TPanel.Create(FrmCronograma);
      Panel.Parent := pParent;

      Panel.Height := 63;
      Panel.Width := 204;
      DecodeTime(Aula.hora_inicio - StrToTime('09:00'), myHour, myMin, mySec, myMilli);
      Panel.Top := 15 + 63 * myHour ;
      if myMin <> 0 then
      Panel.Top := Panel.Top + Round((pParent.Height / 10) * ((myMin*100)/60) /100);
      Panel.Left := 0;
      Panel.ShowCaption:= false;
      Panel.Caption := IntToStr(Aula.id);
      Panel.OnClick := FrmCronograma.AulaClick;

      Labels := TLabel.Create(Panel);
      Labels.Parent := Panel;
      Labels.Top := 6;
      Labels.Left := 8;
      Labels.Caption := 'Curso: ' + Aula.curso;
      Labels.Font.Style := [TFontStyle.fsBold];

      Labels := TLabel.Create(Panel);
      Labels.Parent := Panel;
      Labels.Top := 28;
      Labels.Left := 8;
      Labels.Caption := 'Aluno: ' + Aula.aluno;

      Labels := TLabel.Create(Panel);
      Labels.Parent := Panel;
      Labels.Top := 44;
      Labels.Left := 8;
      Labels.Caption := 'professor: ' + Aula.professor;

      Labels := TLabel.Create(Panel);
      Labels.Parent := Panel;
      Labels.Top := 5;
      Labels.Left := 170;
      Labels.Caption := FormatDateTime('HH:mm', Aula.hora_inicio);

      faixa := TPanel.Create(Panel);
      faixa.Parent := Panel;
      faixa.Height := 63;
      faixa.Width := 5;
      faixa.Top := 0;
      faixa.Left := 0;
      faixa.ParentBackground := false;
      faixa.ParentColor := false;
      faixa.Color := clSilver;

      FQuery.Next
    end;

end;

procedure TAulaDAO.Crialista(Ds: TFDQuery);
var
  I: integer;
begin

  I := 0;
  FLista.Clear;

  while not(Ds.Eof) do
  begin
    FLista.Add(TAula.Create);
    FLista[I].id := Ds.FieldByName('id_aula').AsInteger;
    FLista[I].id_Aluno := Ds.FieldByName('id_aluno').AsInteger;
    FLista[I].id_professor := Ds.FieldByName('id_professor').AsInteger;
    FLista[I].id_sala := Ds.FieldByName('id_sala').AsInteger;
    FLista[I].id_curso := Ds.FieldByName('id_curso').AsInteger;
    FLista[I].hora_inicio := Ds.FieldByName('hora_inicio').AsDateTime;
    FLista[I].dia := Ds.FieldByName('dia').AsString;

    TrocaID(FLista[I]);

    Ds.Next;
    I := I + 1;
  end;
end;

function TAulaDAO.DeletarAula(pAula: TAula): boolean;
begin
  SQL := 'delete from aula where ctid in(select ctid from aula where id_aluno = ' +
    QuotedSTR(IntToStr(pAula.id_Aluno)) + ' and id_curso = ' +
    QuotedSTR(IntToStr(pAula.id_curso)) + 'limit 1)';

  Result := ExecutarComando(SQL) > 0;
end;

destructor TAulaDAO.Destroy;
begin
  try
    inherited;

    if Assigned(FLista) then
      FreeAndNil(FLista);

    if Assigned(SalaDAO) then
      FreeAndNil(SalaDAO);

    if Assigned(Sala) then
      FreeAndNil(Sala);

    if Assigned(Aula) then
      FreeAndNil(Aula);
  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

function TAulaDAO.PesquisaAula(pAluno: TAluno): TObjectList<TAula>;
var
  SQL: string;
begin
  Result := nil;
  SQL := 'select * from aula where id_aluno = ' +
    QuotedSTR(IntToStr(pAluno.id));
  FQuery := RetornarDataSet(SQL);

  if not FQuery.IsEmpty then
  begin
    Crialista(FQuery);
    Result := FLista;
  end;

end;

function TAulaDAO.RetornaAula(pAula: TAula): TAula;
var
  SQL: string;
  Aula: TAula;
begin
  SQL := 'select * from aula where id_aula = ' + QuotedSTR(IntToStr(pAula.id));
  FQuery2 := RetornarDataSet2(SQL);
  Aula := TAula.Create;

  Aula.id := FQuery2.FieldByName('id_aula').AsInteger;
  Aula.id_Aluno := FQuery2.FieldByName('id_aluno').AsInteger;
  Aula.id_professor := FQuery2.FieldByName('id_professor').AsInteger;
  Aula.id_sala := FQuery2.FieldByName('id_sala').AsInteger;
  Aula.id_curso := FQuery2.FieldByName('id_curso').AsInteger;
  Aula.hora_inicio := FQuery2.FieldByName('hora_inicio').AsDateTime;
  Aula.dia := FQuery2.FieldByName('dia').AsString;

  TrocaID(Aula);

  Result := Aula;

end;

procedure TAulaDAO.TrocaID(pAula: TAula);
var
  SQL: string;
begin
  SQL := 'select nome from aluno where id_aluno = ' +
    QuotedSTR(IntToStr(pAula.id_Aluno));
  FQuery2 := RetornarDataSet2(SQL);
  pAula.aluno := FQuery2.FieldByName('nome').AsString;

  SQL := 'select nome from professor where id_professor = ' +
    QuotedSTR(IntToStr(pAula.id_professor));
  FQuery2 := RetornarDataSet2(SQL);
  pAula.professor := FQuery2.FieldByName('nome').AsString;

  SQL := 'select nome from sala where id_sala = ' +
    QuotedSTR(IntToStr(pAula.id_sala));
  FQuery2 := RetornarDataSet2(SQL);
  pAula.Sala := FQuery2.FieldByName('nome').AsString;

  SQL := 'select nome from curso where id_curso = ' +
    QuotedSTR(IntToStr(pAula.id_curso));
  FQuery2 := RetornarDataSet2(SQL);
  pAula.curso := FQuery2.FieldByName('nome').AsString;

end;

function TAulaDAO.UpdateAula(pAula: TAula): boolean;
var
  SQL: string;
begin
  SQL := 'update aula set id_aluno = ' + QuotedSTR(IntToStr(pAula.id_Aluno)) +
    ', id_professor = ' + QuotedSTR(IntToStr(pAula.id_professor)) +
    ', id_sala = ' + QuotedSTR(IntToStr(pAula.id_sala)) + ', id_curso = ' +
    QuotedSTR(IntToStr(pAula.id_curso)) + ', hora_inicio = ' +
    QuotedSTR(FormatDateTime('dd/mm/yyyy HH:mm', pAula.hora_inicio)) +
    ', dia = ' + QuotedSTR(pAula.dia) + ' where id_aula = ' +
    QuotedSTR(IntToStr(pAula.id));

  Result := ExecutarComando(SQL) > 0;
end;

end.
