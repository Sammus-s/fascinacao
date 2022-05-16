unit uFrmCadProfessor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, System.DateUtils, uProfessorDAO,
  uFrmCadCurso, uEnderecoDAO, uEndereco, uProfessor, FireDac.Comp.Client,
  uCursoDAO;

type
  TFrmCadProfessor = class(TForm)
    pCadProfessor: TPanel;
    pInfo: TPanel;
    Label2: TLabel;
    DataDeNascimento: TLabel;
    nome: TLabel;
    email: TLabel;
    contato: TLabel;
    CNPJ: TLabel;
    CPF: TLabel;
    RG: TLabel;
    EdtContato: TEdit;
    EdtCpf: TMaskEdit;
    EdtRg: TMaskEdit;
    EdtNome: TEdit;
    DTDataNasc: TDateTimePicker;
    EdtEmail: TEdit;
    pEndereçoProfessor: TPanel;
    Label3: TLabel;
    rua: TLabel;
    numero: TLabel;
    cidade: TLabel;
    bairro: TLabel;
    cep: TLabel;
    EdtRua: TEdit;
    EdtNumero: TEdit;
    EdtBairro: TEdit;
    MECep: TMaskEdit;
    EdtCnpj: TMaskEdit;
    pCursos: TPanel;
    CLCursos: TCheckListBox;
    Label1: TLabel;
    BtnNewCourse: TButton;
    BtnCadastrar: TSpeedButton;
    BtnCancel: TSpeedButton;
    ScrollBar: TScrollBar;
    EdtCidade: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ScrollBarChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnNewCourseClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure BtnCadastrarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure LimparEdits;
    Procedure Crialista(pQuery: TFDQuery);
    procedure CreateProfessor;
    procedure CreateEndereco;
    procedure CriaCB(Ds: TFDQuery; CB: TComboBox);
    procedure Obrigatory_edit;
    procedure Obrigatory_edit_clear;
  public
    { Public declarations }
  end;

var
  FrmCadProfessor: TFrmCadProfessor;
  ProfessorDAO: TProfessorDAO;
  EnderecoDAO: TEnderecoDAO;
  CursoDAO: TCursoDAO;
  Endereco: Tendereco;
  Professor: Tprofessor;

implementation

{$R *.dfm}

procedure TFrmCadProfessor.BtnCadastrarClick(Sender: TObject);
begin
  CreateEndereco;
  CreateProfessor;

  if not EnderecoDAO.CadastrarEndereco(Endereco) = true then
  begin
    ShowMessage('Erro ao cadastro de endereço');
    abort
  end;

  if ProfessorDAO.CadastrarProfessor(Professor, Endereco) = true then
  begin
    ShowMessage(Professor.nome + ' cadastrado(a) com sucesso');
    LimparEdits;
    FrmCadProfessor.close;
  end
  else
  begin
    ShowMessage('Falha no cadasto de Professor' + #13 + #13 +
      'Certifique-se de preencher todos os campos');
  end;

  if ProfessorDAO.CadastrarProfessor_Curso(Professor) = false then
  begin
    ShowMessage('Erro ao associar Cursos');
  end;

  Obrigatory_edit_clear;
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
end;

procedure TFrmCadProfessor.BtnCancelClick(Sender: TObject);
begin
  LimparEdits;
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
  Obrigatory_edit_clear;
  FrmCadProfessor.close;
end;

procedure TFrmCadProfessor.BtnNewCourseClick(Sender: TObject);
begin
  FrmNovoCurso.showmodal;
  Crialista(CursoDAO.ListaCurso);
end;

procedure TFrmCadProfessor.CreateEndereco;
begin

  if (EdtRua.Text = '') or (EdtBairro.Text = '') or (MECep.Text = '_____-___')
    or (EdtCidade.ItemIndex = -1) or (EdtNumero.Text = '') then
  begin
    ShowMessage('Erro ao cadastrar endereco' + #13 + #13 +
      'Certifique-se de preencher todos os dados');
    Obrigatory_edit;
    abort
  end;

  Endereco := Tendereco.Create;

  Endereco.rua := EdtRua.Text;
  Endereco.numero := StrToInt(EdtNumero.Text);
  Endereco.cidade := EdtCidade.Text;
  Endereco.bairro := EdtBairro.Text;
  Endereco.cep := MECep.Text;

end;

procedure TFrmCadProfessor.CreateProfessor;
var
  I: integer;
begin

  if (EdtCnpj.Text = '__.___.___/____-__') or (EdtNome.Text = '') or
    (EdtCpf.Text = '___.___.___-__') or (EdtRg.Text = '') then
  begin
    MessageDlg('Erro ao cadastrar professor', mtError, [mbOK], 0);
    Obrigatory_edit;
    abort;
  end;

  Professor := Tprofessor.Create;

  Professor.nome := EdtNome.Text;
  Professor.DataNasc := DTDataNasc.Date;
  Professor.CPF := EdtCpf.Text;
  Professor.RG := EdtRg.Text;
  Professor.CNPJ := EdtCnpj.Text;
  Professor.contato := EdtContato.Text;
  Professor.email := EdtEmail.Text;

  for I := 0 to CLCursos.Items.Count - 1 do
  begin
    if CLCursos.State[I] = cbChecked then
    begin
      Professor.Tamanho := Professor.Tamanho + 1;
      SetLength(Professor.Cursos, Professor.Tamanho);
      Professor.Cursos[Professor.Tamanho - 1] := CLCursos.Items[I]
    end;
  end;

  if Professor.Tamanho = 0 then
  begin
    MessageDlg('Erro ao cadastrar professor', mtError, [mbOK], 0);
    Obrigatory_edit;
    abort;
  end;

end;

procedure TFrmCadProfessor.CriaCB(Ds: TFDQuery; CB: TComboBox);
begin
  CB.Clear;
  while not(Ds.Eof) do
  begin
    CB.Items.Add(Ds.FieldByName('nome').AsString);

    Ds.Next;
  end;
  CB.ItemIndex := -1;
end;

procedure TFrmCadProfessor.Crialista(pQuery: TFDQuery);
begin
  CLCursos.Clear;
  while not pQuery.Eof do
  begin
    CLCursos.Items.Add(pQuery.FieldByName('nome').AsString);

    pQuery.Next;
  end;
end;

procedure TFrmCadProfessor.FormCreate(Sender: TObject);
begin

  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  pCadProfessor.Height := 0;
  pCadProfessor.Height := pInfo.Height + pEndereçoProfessor.Height +
    pCursos.Height;
  ScrollBar.Max := pCadProfessor.Height - FrmCadProfessor.Height;

  ProfessorDAO := TProfessorDAO.Create;
  EnderecoDAO := TEnderecoDAO.Create;
  CursoDAO := TCursoDAO.Create;

  Crialista(CursoDAO.ListaCurso);
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);

end;

procedure TFrmCadProfessor.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(ProfessorDAO) then
      FreeAndNil(ProfessorDAO);

    if Assigned(EnderecoDAO) then
      FreeAndNil(EnderecoDAO);

    if Assigned(Endereco) then
      FreeAndNil(Endereco);

    if Assigned(Professor) then
      FreeAndNil(Professor);

    if Assigned(CursoDAO) then
      FreeAndNil(CursoDAO);
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

procedure TFrmCadProfessor.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar.Position := ScrollBar.Position + 80;
end;

procedure TFrmCadProfessor.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar.Position := ScrollBar.Position - 80;
end;

procedure TFrmCadProfessor.LimparEdits;
var
  I: integer;
begin
  EdtContato.Clear;
  EdtCpf.Clear;
  EdtRg.Clear;
  EdtNome.Clear;
  EdtEmail.Clear;
  EdtRua.Clear;
  EdtNumero.Clear;
  EdtCidade.Clear;
  EdtBairro.Clear;
  EdtCnpj.Clear;
  MECep.Clear;
  DTDataNasc.Date := StrToDate('01/01/2000');

  for I := 0 to CLCursos.Items.Count - 1 do
    if CLCursos.State[I] = cbChecked then
      CLCursos.State[I] := cbUnchecked;

  ScrollBar.Position := 0;
end;

procedure TFrmCadProfessor.Obrigatory_edit;
begin
  // professor
  EdtNome.SetFocus;
  ScrollBar.Position := 0;
  nome.Font.Style := [FsBold];
  CPF.Font.Style := [FsBold];
  RG.Font.Style := [FsBold];
  CNPJ.Font.Style := [FsBold];
  DataDeNascimento.Font.Style := [FsBold];
  contato.Font.Style := [FsBold];
  email.Font.Style := [FsBold];
  // endereco
  rua.Font.Style := [FsBold];
  cep.Font.Style := [FsBold];
  bairro.Font.Style := [FsBold];
  cidade.Font.Style := [FsBold];
  numero.Font.Style := [FsBold];
end;

procedure TFrmCadProfessor.Obrigatory_edit_clear;
begin
  // professor
  nome.Font.Style := [];
  CPF.Font.Style := [];
  RG.Font.Style := [];
  CNPJ.Font.Style := [];
  DataDeNascimento.Font.Style := [];
  contato.Font.Style := [];
  email.Font.Style := [];
  // endereco
  rua.Font.Style := [];
  cep.Font.Style := [];
  bairro.Font.Style := [];
  cidade.Font.Style := [];
  numero.Font.Style := [];
end;

procedure TFrmCadProfessor.ScrollBarChange(Sender: TObject);
begin
  pCadProfessor.top := -ScrollBar.Position;
end;

end.
