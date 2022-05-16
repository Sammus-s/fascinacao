unit uFrmCadAlunos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ComCtrls, Vcl.Mask,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDac.Comp.Client, uAlunoDAO, uEnderecoDAO,
  uAluno, uResponsavel, uEndereco, uCursoDAO, uSala, uSalaDAO, uAula,
  uProfessorDAO,
  uProfessor, uAulaDAO, uCurso;

type
  TFrmCadAlunos = class(TForm)
    pCadastroAluno: TPanel;
    pNovoAluno: TPanel;
    Label2: TLabel;
    DataDeNascimento: TLabel;
    nome: TLabel;
    Label14: TLabel;
    contato: TLabel;
    Label16: TLabel;
    CPF: TLabel;
    Label18: TLabel;
    EdtContatoAluno: TEdit;
    EdtCpfAluno: TMaskEdit;
    EdtNomeAluno: TEdit;
    EdtContatoComAluno: TEdit;
    DTDataNascAluno: TDateTimePicker;
    EdtEmailAluno: TEdit;
    pResponsavelCad: TPanel;
    Label1: TLabel;
    NomeResponsavel: TLabel;
    LContatoResponsavel: TLabel;
    Label7: TLabel;
    CPFResponsavel: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EdtNomeResponsável: TEdit;
    EdtContatoResponsavel: TEdit;
    EdtContatoComResponsavel: TEdit;
    EdtCpfResponsavel: TMaskEdit;
    EdtRgResponsavel: TMaskEdit;
    DTDataNascResponsavel: TDateTimePicker;
    pEndereçoAluno: TPanel;
    Label3: TLabel;
    rua: TLabel;
    numero: TLabel;
    cidade: TLabel;
    Bairro: TLabel;
    CEP: TLabel;
    EdtRua: TEdit;
    EdtNumero: TEdit;
    EdtBairro: TEdit;
    MECep: TMaskEdit;
    ScrollBar: TScrollBar;
    CBTemResponsavel: TCheckBox;
    pAula: TPanel;
    CBCurso: TComboBox;
    CBProfessor: TComboBox;
    CBDia: TComboBox;
    CBSala: TComboBox;
    DThora: TDateTimePicker;
    Label5: TLabel;
    Label11: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    BtnCadastrar: TSpeedButton;
    BtnCancel: TSpeedButton;
    Label27: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    EdtRGAluno: TEdit;
    EdtCidade: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ScrollBarChange(Sender: TObject);
    procedure CBTemResponsavelClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnCadastrarClick(Sender: TObject);
    procedure CBCursoChange(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);

  private
    procedure DefinirAltura;
    procedure CriaCB(Ds: TFDQuery; CB: TComboBox);
    procedure LimpaEdit;
    procedure CreateAluno;
    procedure CreateResponsavel;
    procedure CreateEndereco;
    procedure CreateAula;
    procedure verificacaoAula;
    procedure edits_responsavel(pEdit: TMaskEdit); OverLoad;
    procedure edits_responsavel(pEdit: TEdit); OverLoad;
    procedure edit_clean(pEdit: TMaskEdit); OverLoad;
    procedure edit_clean(pEdit: TEdit); OverLoad;
    procedure Obrigatory_edit;
    procedure Obrigatory_edit_clar;

  public

  end;

var
  FrmCadAlunos: TFrmCadAlunos;
  Endereco: TEndereco;
  Aluno: TAluno;
  Responsavel: TResponsavel;
  AlunoDAO: TAlunoDAO;
  EnderecoDAO: TEnderecoDAO;
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

uses uFrmListagem;

procedure TFrmCadAlunos.BtnCadastrarClick(Sender: TObject);
begin
  if CBTemResponsavel.State = cbChecked then
  begin

    CreateAluno;
    CreateResponsavel;
    CreateEndereco;
    verificacaoAula;

    EnderecoDAO.CadastrarEndereco(Endereco);

    AlunoDAO.CadastrarResponsavel(Responsavel);

    AlunoDAO.CadastrarAlunoResponsavel(Aluno, Endereco, Responsavel);

    CreateAula;

    Aluno.id := Aula.id_aluno;
    Curso.id := Aula.id_curso;
    AlunoDAO.CadastrarAluno_curso(Aluno, Curso);

    if AulaDAO.CadastroAula(Aula) = true then
    begin
      ShowMessage(Aluno.nome + ' cadastrado(a) com sucesso');
      LimpaEdit;
    end;

  end
  else
  begin

    CreateAluno;
    CreateEndereco;
    verificacaoAula;

    EnderecoDAO.CadastrarEndereco(Endereco);

    AlunoDAO.CadastrarAluno(Aluno, Endereco);

    CreateAula;

    Aluno.id := Aula.id_aluno;
    Curso.id := Aula.id_curso;
    AlunoDAO.CadastrarAluno_curso(Aluno, Curso);

    if AulaDAO.CadastroAula(Aula) = true then
    begin
      ShowMessage(Aluno.nome + ' cadastrado(a) com sucesso');
      LimpaEdit;
    end;

  end;
end;

procedure TFrmCadAlunos.BtnCancelClick(Sender: TObject);
begin
  LimpaEdit;
  ScrollBar.Position := 0;
  Obrigatory_edit_clar;
  Close;
end;

procedure TFrmCadAlunos.CBCursoChange(Sender: TObject);
begin
  CriaCB(SalaDAO.PesquisaSalaCurso(CBCurso.Items[CBCurso.ItemIndex]), CBSala);
  CriaCB(SalaDAO.PesquisaSalaProfessor(CBCurso.Items[CBCurso.ItemIndex]),
    CBProfessor);
end;

procedure TFrmCadAlunos.CBTemResponsavelClick(Sender: TObject);
begin
  if CBTemResponsavel.State = cbChecked then
  begin
    pResponsavelCad.Show;
    edits_responsavel(EdtCpfAluno);
    edits_responsavel(EdtRGAluno);
    EdtEmailAluno.TextHint := 'Opcional';
    EdtContatoAluno.TextHint := 'Opcional';
    EdtContatoComAluno.TextHint := 'Opcional';
    contato.Font.Style := [];
    pResponsavelCad.Show;
    DefinirAltura;
  end
  else
  begin
    pResponsavelCad.Hide;
    DefinirAltura;
    pResponsavelCad.Hide;
    edit_clean(EdtCpfAluno);
    edit_clean(EdtRGAluno);
    EdtEmailAluno.TextHint := '';
    EdtContatoAluno.TextHint := '';
    EdtContatoComAluno.TextHint := '';
  end;

end;

procedure TFrmCadAlunos.CreateAluno;
begin
  if CBTemResponsavel.State = cbChecked then
  begin
    if (EdtNomeAluno.Text = '') then
    begin
      MessageDlg('Erro ao cadastrar aluno' + #13 + #13 +
        'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
      Obrigatory_edit;
      abort
    end;
  end
  else
  begin
    if (EdtNomeAluno.Text = '') or (EdtCpfAluno.Text = '___.___.___-__') or
      (EdtContatoAluno.Text = '') then
    begin
      MessageDlg('Erro ao cadastrar aluno' + #13 + #13 +
        'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
      Obrigatory_edit;
      abort
    end;
  end;

  Aluno := TAluno.Create;

  Aluno.nome := EdtNomeAluno.Text;
  Aluno.CPF := EdtCpfAluno.Text;
  Aluno.RG := EdtRGAluno.Text;
  Aluno.DataNasc := DTDataNascAluno.Date;
  Aluno.contato := EdtContatoAluno.Text;
  Aluno.Email := EdtEmailAluno.Text;
  Aluno.ContatoCom := EdtContatoComAluno.Text;
end;

procedure TFrmCadAlunos.CreateAula;
begin

  Aula := TAula.Create;
  Aula.id_aluno := AlunoDAO.RetornaID(Aluno);

  Aula.id_professor := ProfessorDAO.RetornaID(Professor);

  Aula.id_sala := SalaDAO.RetornaID(Sala);

  Curso.nome := CBCurso.Items[CBCurso.ItemIndex];
  Aula.id_curso := CursoDAO.RetornarId(Curso);

  Aula.hora_inicio := DThora.Time;
  Aula.dia := CBDia.Items[CBDia.ItemIndex];

end;

procedure TFrmCadAlunos.CreateEndereco;
begin

  if (EdtRua.Text = '') or (EdtBairro.Text = '') or (MECep.Text = '_____-___')
    or (EdtCidade.ItemIndex = -1) or (EdtNumero.Text = '') then
  begin
    MessageDlg('Erro ao cadastrar endereco' + #13 + #13 +
      'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
    Obrigatory_edit;
    abort
  end;

  Endereco := TEndereco.Create;

  Endereco.rua := EdtRua.Text;
  Endereco.numero := StrToInt(EdtNumero.Text);
  Endereco.cidade := EdtCidade.Text;
  Endereco.Bairro := EdtBairro.Text;
  Endereco.CEP := MECep.Text;

end;

procedure TFrmCadAlunos.CreateResponsavel;
begin
  if (EdtNomeResponsável.Text = '') or (EdtCpfResponsavel.Text = '') or
    (EdtContatoResponsavel.Text = '') then
  begin
    MessageDlg('Erro ao cadastrar responsavel' + #13 + #13 +
      'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
    Obrigatory_edit;
    abort
  end;

  Responsavel := TResponsavel.Create;

  Responsavel.nome := EdtNomeResponsável.Text;
  Responsavel.CPF := EdtCpfResponsavel.Text;
  Responsavel.RG := EdtRgResponsavel.Text;
  Responsavel.DataNasc := DTDataNascResponsavel.Date;
  Responsavel.contato := EdtContatoResponsavel.Text;
  Responsavel.ContatoCom := EdtContatoComResponsavel.Text;
end;

procedure TFrmCadAlunos.CriaCB(Ds: TFDQuery; CB: TComboBox);
begin
  CB.Clear;
  while not(Ds.Eof) do
  begin
    CB.Items.Add(Ds.FieldByName('nome').AsString);

    Ds.Next;
  end;
  CB.ItemIndex := -1;
end;

procedure TFrmCadAlunos.DefinirAltura;
begin
  pCadastroAluno.Height := 0;
  pCadastroAluno.Height := pNovoAluno.Height + pEndereçoAluno.Height +
    pAula.Height;
  if pResponsavelCad.Visible = true then
    pCadastroAluno.Height := pCadastroAluno.Height + pResponsavelCad.Height;

  ScrollBar.max := pCadastroAluno.Height - FrmCadAlunos.Height + 30;
  ScrollBar.Position := 0;
end;

procedure TFrmCadAlunos.edits_responsavel(pEdit: TMaskEdit);
begin
  pEdit.EditMask := '!999.999.999-99;0;_';
  pEdit.Text := 'RESPONSÁVEL';
  pEdit.ReadOnly := true;
end;

procedure TFrmCadAlunos.edit_clean(pEdit: TMaskEdit);
begin
  if pEdit.Text = 'RESPONSÁVEL' then
    pEdit.Clear;
  pEdit.EditMask := '!999.999.999-99;1;_';
  pEdit.ReadOnly := false;
end;

procedure TFrmCadAlunos.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  CursoDAO := TcursoDAO.Create;
  AlunoDAO := TAlunoDAO.Create;
  EnderecoDAO := TEnderecoDAO.Create;
  SalaDAO := TSalaDao.Create;
  ProfessorDAO := TprofessorDAO.Create;
  Professor := Tprofessor.Create;
  AulaDAO := TaulaDAO.Create;
  Sala := TSala.Create;
  Curso := TCurso.Create;

  CriaCB(CursoDAO.ListaCurso, CBCurso);
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);

  DefinirAltura;
end;

procedure TFrmCadAlunos.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar.Position := ScrollBar.Position + 80;
end;

procedure TFrmCadAlunos.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar.Position := ScrollBar.Position - 80;
end;

procedure TFrmCadAlunos.LimpaEdit;
begin
  EdtContatoAluno.Clear;
  EdtEmailAluno.Clear;
  EdtCpfAluno.Clear;
  EdtRGAluno.Clear;
  EdtNomeAluno.Clear;
  EdtContatoComAluno.Clear;
  EdtRua.Clear;
  EdtNumero.Clear;
  EdtCidade.Clear;;
  EdtBairro.Clear;
  EdtNomeResponsável.Clear;
  EdtCpfResponsavel.Clear;
  EdtRgResponsavel.Clear;
  MECep.Clear;
  EdtContatoResponsavel.Clear;
  DTDataNascAluno.Date := StrToDate('01/01/2000');
  DTDataNascResponsavel.Date := StrToDate('01/01/2000');
  CBCurso.ItemIndex := -1;
  CBProfessor.ItemIndex := -1;
  CBDia.ItemIndex := -1;
  CBSala.ItemIndex := -1;
  DThora.Time := StrToTime('00:00');
  CBTemResponsavel.State := cbUnchecked;
end;

procedure TFrmCadAlunos.Obrigatory_edit;
begin
  // aluno
  EdtNomeAluno.SetFocus;
  ScrollBar.Position := 0;
  nome.Font.Style := [fsBold];
  CPF.Font.Style := [fsBold];
  DataDeNascimento.Font.Style := [fsBold];
  contato.Font.Style := [fsBold];
  // responsavel
  NomeResponsavel.Font.Style := [fsBold];
  LContatoResponsavel.Font.Style := [fsBold];
  CPFResponsavel.Font.Style := [fsBold];
  // endereco
  rua.Font.Style := [fsBold];
  Bairro.Font.Style := [fsBold];
  CEP.Font.Style := [fsBold];
  cidade.Font.Style := [fsBold];
  numero.Font.Style := [fsBold];
end;

procedure TFrmCadAlunos.Obrigatory_edit_clar;
begin
  // aluno
  nome.Font.Style := [];
  CPF.Font.Style := [];
  DataDeNascimento.Font.Style := [];
  contato.Font.Style := [];
  // responsavel
  NomeResponsavel.Font.Style := [];
  LContatoResponsavel.Font.Style := [];
  CPFResponsavel.Font.Style := [];
  // endereco
  rua.Font.Style := [];
  Bairro.Font.Style := [];
  CEP.Font.Style := [];
  cidade.Font.Style := [];
  numero.Font.Style := [];
end;

procedure TFrmCadAlunos.ScrollBarChange(Sender: TObject);
begin
  pCadastroAluno.top := -ScrollBar.Position
end;

procedure TFrmCadAlunos.verificacaoAula;
begin

  if not((CBCurso.ItemIndex = -1) or (CBProfessor.ItemIndex = -1) or
    (CBDia.ItemIndex = -1) or (CBSala.ItemIndex = -1)) then
  begin
    Professor.nome := CBProfessor.Items[CBProfessor.ItemIndex];
    if ProfessorDAO.HorarioLivre(DThora.Time, CBDia.Items[CBDia.ItemIndex],
      Professor) = true then
    begin
      Sala.nome := CBSala.Items[CBSala.ItemIndex];
      if SalaDAO.SalaLivre(DThora.Time, CBDia.Items[CBDia.ItemIndex], Sala) = false
      then
      begin
        MessageDlg('A sala não está disponível neste horario', mtWarning,
          [mbok], 0);
        abort
      end;
    end
    else
    begin
      MessageDlg('O professor não está disponível neste horario', mtWarning,
        [mbok], 0);
      abort
    end;
  end
  else
  begin
    MessageDlg('Preencha todos os campos de Aula', mtWarning, [mbok], 0);
    abort
  end;
end;

procedure TFrmCadAlunos.edits_responsavel(pEdit: TEdit);
begin
  pEdit.Text := 'RESPONSÁVEL';
  pEdit.ReadOnly := true;
end;

procedure TFrmCadAlunos.edit_clean(pEdit: TEdit);
begin
  if pEdit.Text = 'RESPONSÁVEL' then
    pEdit.Clear;

  pEdit.ReadOnly := false;
end;

end.
