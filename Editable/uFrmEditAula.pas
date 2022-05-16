unit uFrmEditAula;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, uAula, uAulaDAO, uSala, uSalaDAO, uProfessor, uProfessorDAO,
  uAluno, uAlunoDAO, uCurso, uCursoDAO, FireDac.Comp.Client;

type
  TFrmAula = class(TForm)
    pAula: TPanel;
    BtnCadastrar: TSpeedButton;
    BtnCancel: TSpeedButton;
    Label27: TLabel;
    Panel1: TPanel;
    Label5: TLabel;
    CBCurso: TComboBox;
    Panel2: TPanel;
    Label24: TLabel;
    Label26: TLabel;
    CBDia: TComboBox;
    DThora: TDateTimePicker;
    Panel3: TPanel;
    Label25: TLabel;
    Label11: TLabel;
    CBSala: TComboBox;
    CBProfessor: TComboBox;
    BtnSave: TButton;
    BtnEdit: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure CBCursoChange(Sender: TObject);
    procedure BtnCadastrarClick(Sender: TObject);
  private
    procedure OnlyRead;
    procedure Editable;
    procedure CriaAulaUpdate;
    procedure CriaCB(Ds: TFDQuery; CB: TComboBox);
    procedure PreencheCB(nome: string; CB: TComboBox);
    procedure CriaAula;
  public
    procedure EditAula(pAula: TAula);
    procedure NewAula(pAluno: TAluno);
  end;

var
  FrmAula: TFrmAula;
  Aluno: TAluno;
  AlunoDAO: TAlunoDAO;
  CursoDAO: TcursoDAO;
  Curso: TCurso;
  SalaDAO: TSalaDao;
  Sala: TSala;
  Aula: TAula;
  ProfessorDAO: TprofessorDAO;
  Professor: Tprofessor;
  AulaDAO: TaulaDAO;

implementation

{$R *.dfm}
{ TFrmAula }

procedure TFrmAula.BtnCadastrarClick(Sender: TObject);
begin
  CriaAula;

  Aluno.id := Aula.id_aluno;
  Curso.id := Aula.id_curso;
  AlunoDAO.CadastrarAluno_curso(Aluno, Curso);

  if AulaDAO.CadastroAula(Aula) = true then
  begin
    ShowMessage('aula cadastrada com sucesso');
  end;
  close;
end;

procedure TFrmAula.BtnCancelClick(Sender: TObject);
begin
  BtnSave.Hide;
  BtnEdit.Hide;
  BtnCadastrar.Hide;
  close;
end;

procedure TFrmAula.BtnEditClick(Sender: TObject);
begin
  Editable;
  BtnSave.Show;
  BtnEdit.Hide;
end;

procedure TFrmAula.BtnSaveClick(Sender: TObject);
begin
  Professor.nome := CBProfessor.Items[CBProfessor.ItemIndex];
  Aula.id_professor := ProfessorDAO.RetornaID(Professor);

  Sala.nome := CBSala.Items[CBSala.ItemIndex];
  Aula.id_sala := SalaDAO.RetornaID(Sala);

  CriaAulaUpdate;

  if (AulaDAO.UpdateAula(Aula) = true) and
    (AlunoDAO.UpdateAluno_curso(Aula) = true) then
  begin
    ShowMessage('aula alterada com sucesso');
  end;
  BtnSave.Hide;
  BtnEdit.Show;
  OnlyRead;
end;

procedure TFrmAula.EditAula(pAula: TAula);
begin
  BtnEdit.Show;
  BtnCadastrar.Hide;
  BtnSave.Hide;

  Aula := AulaDAO.RetornaAula(pAula);
  CriaCB(CursoDAO.ListaCurso, CBCurso);
  PreencheCB(pAula.Curso, CBCurso);
  CriaCB(SalaDAO.PesquisaSalaCurso(CBCurso.Items[CBCurso.ItemIndex]), CBSala);
  CriaCB(SalaDAO.PesquisaSalaProfessor(CBCurso.Items[CBCurso.ItemIndex]),
    CBProfessor);
  PreencheCB(pAula.dia, CBDia);
  PreencheCB(pAula.Sala, CBSala);
  PreencheCB(pAula.Professor, CBProfessor);

  DThora.Time := pAula.hora_inicio;

  OnlyRead;
end;

procedure TFrmAula.CBCursoChange(Sender: TObject);
begin
  CriaCB(SalaDAO.PesquisaSalaCurso(CBCurso.Items[CBCurso.ItemIndex]), CBSala);
  CriaCB(SalaDAO.PesquisaSalaProfessor(CBCurso.Items[CBCurso.ItemIndex]),
    CBProfessor);
end;

procedure TFrmAula.CriaAula;
begin
  if not((CBCurso.ItemIndex = -1) or (CBProfessor.ItemIndex = -1) or
    (CBDia.ItemIndex = -1) or (CBSala.ItemIndex = -1)
    or (DThora.Time < StrToTime('9:00')) or (DThora.Time > StrToTime('17:01'))) then
  begin
    Professor.nome := CBProfessor.Items[CBProfessor.ItemIndex];
    if ProfessorDAO.HorarioLivre(DThora.Time, CBDia.Items[CBDia.ItemIndex],
      Professor) = true then
    begin
      Sala.nome := CBSala.Items[CBSala.ItemIndex];
      if SalaDAO.SalaLivre(DThora.Time, CBDia.Items[CBDia.ItemIndex], Sala) = true
      then
      begin
        Aula.id_aluno := Aluno.id;

        Professor.nome := CBProfessor.Items[CBProfessor.ItemIndex];
        Aula.id_professor := ProfessorDAO.RetornaID(Professor);

        Sala.nome := CBSala.Items[CBSala.ItemIndex];
        Aula.id_sala := SalaDAO.RetornaID(Sala);

        Curso.nome := CBCurso.Items[CBCurso.ItemIndex];
        Aula.id_curso := CursoDAO.RetornarId(Curso);

        Aula.hora_inicio := DThora.Time;
        Aula.dia := CBDia.Items[CBDia.ItemIndex];
      end
      else
      begin
        MessageDlg('A sala não está disponível neste horario', mtWarning,
          [mbOK], 0);
        abort
      end;
    end
    else
    begin
      MessageDlg('O professor não está disponível neste horario', mtWarning,
        [mbOK], 0);
      abort
    end;
  end
  else
  begin
    MessageDlg('Preencha todos os campos de Aula', mtWarning, [mbOK], 0);
    abort
  end;
end;

procedure TFrmAula.CriaAulaUpdate;
begin
  if not((CBCurso.ItemIndex = -1) or (CBProfessor.ItemIndex = -1) or
    (CBDia.ItemIndex = -1) or (CBSala.ItemIndex = -1) or (DThora.Time < StrToTime('9:00')) or (DThora.Time > StrToTime('17:01'))) then
  begin
    if ProfessorDAO.HorarioLivreUpdate(Aula) = true then
    begin
      if SalaDAO.SalaLivreUpdate(Aula) = true then
      begin

        Professor.nome := CBProfessor.Items[CBProfessor.ItemIndex];
        Aula.id_professor := ProfessorDAO.RetornaID(Professor);

        Sala.nome := CBSala.Items[CBSala.ItemIndex];
        Aula.id_sala := SalaDAO.RetornaID(Sala);

        Curso.nome := CBCurso.Items[CBCurso.ItemIndex];
        Aula.id_curso := CursoDAO.RetornarId(Curso);

        Aula.hora_inicio := DThora.Time;
        Aula.dia := CBDia.Items[CBDia.ItemIndex];
      end
      else
      begin
        MessageDlg('A sala não está disponível neste horario', mtWarning,
          [mbOK], 0);
        abort
      end;
    end
    else
    begin
      MessageDlg('O professor não está disponível neste horario', mtWarning,
        [mbOK], 0);
      abort
    end;
  end
  else
  begin
    MessageDlg('Preencha todos os campos de Aula', mtWarning, [mbOK], 0);
    abort
  end;
end;

procedure TFrmAula.CriaCB(Ds: TFDQuery; CB: TComboBox);
begin
  CB.Clear;
  while not(Ds.Eof) do
  begin
    CB.Items.Add(Ds.FieldByName('nome').AsString);

    Ds.Next;
  end;
  CB.ItemIndex := -1;
end;

procedure TFrmAula.Editable;
begin
  CBCurso.Enabled := true;
  CBDia.Enabled := true;
  CBSala.Enabled := true;
  CBProfessor.Enabled := true;
  DThora.Enabled := true;
end;

procedure TFrmAula.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  Aula := TAula.Create;
  AulaDAO := TaulaDAO.Create;
  Sala := TSala.Create;
  SalaDAO := TSalaDao.Create;
  Professor := Tprofessor.Create;
  ProfessorDAO := TprofessorDAO.Create;
  CursoDAO := TcursoDAO.Create;
  AlunoDAO := TAlunoDAO.Create;
  Aluno := TAluno.Create;
  Curso := TCurso.Create;
end;

procedure TFrmAula.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(Aula) then
      FreeAndNil(Aula);

    if Assigned(AulaDAO) then
      FreeAndNil(AulaDAO);

    if Assigned(Sala) then
      FreeAndNil(Sala);

    if Assigned(SalaDAO) then
      FreeAndNil(SalaDAO);

    if Assigned(Professor) then
      FreeAndNil(Professor);

    if Assigned(ProfessorDAO) then
      FreeAndNil(ProfessorDAO);

    if Assigned(Curso) then
      FreeAndNil(Curso);

    if Assigned(CursoDAO) then
      FreeAndNil(CursoDAO);

    if Assigned(Aluno) then
      FreeAndNil(Aluno);

    if Assigned(AlunoDAO) then
      FreeAndNil(AlunoDAO);
  except
    on E: exception do
      raise exception.Create(E.Message);
  end;
end;

procedure TFrmAula.NewAula(pAluno: TAluno);
begin
  Editable;
  BtnEdit.Hide;
  BtnCadastrar.Show;
  BtnSave.Hide;

  CriaCB(CursoDAO.ListaCurso, CBCurso);
  Aluno.id := pAluno.id
end;

procedure TFrmAula.OnlyRead;
begin
  CBCurso.Enabled := False;
  CBDia.Enabled := False;
  CBSala.Enabled := False;
  CBProfessor.Enabled := False;
  DThora.Enabled := False;
end;

procedure TFrmAula.PreencheCB(nome: string; CB: TComboBox);
var
  I: integer;
begin
  for I := 0 to CB.Items.Count - 1 do
  begin
    if nome = CB.Items[I] then
      CB.ItemIndex := I;
  end;

end;

end.
