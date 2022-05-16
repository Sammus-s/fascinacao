unit uFrmCadAluno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Mask,
  System.DateUtils, uEndereco, uAluno, uResponsavel, uAlunoDAO, uDM, FireDAC.Comp.Client,
  uEnderecoDAO, uCursoDAO;

type
  TFrmPrincipal = class(TForm)
    pCadastroAluno: TPanel;
    DTDataNascAluno: TDateTimePicker;
    pNovoAluno: TPanel;
    Label2: TLabel;
    EdtContatoAluno: TEdit;
    EdtEmailAluno: TEdit;
    EdtCpfAluno: TMaskEdit;
    EdtRgAluno: TMaskEdit;
    EdtNomeAluno: TEdit;
    EdtContatoComAluno: TEdit;
    pEndereçoAluno: TPanel;
    EdtRua: TEdit;
    EdtNumero: TEdit;
    EdtCidade: TEdit;
    EdtBairro: TEdit;
    MECep: TMaskEdit;
    Label3: TLabel;
    pResponsavelCad: TPanel;
    Label1: TLabel;
    ScrollBarCadAluno: TScrollBar;
    EdtNomeResponsável: TEdit;
    ContatoResponsavel: TEdit;
    ContatoComResponsavel: TEdit;
    EdtCpfResponsavel: TMaskEdit;
    EdtRgResponsavel: TMaskEdit;
    DTDataNascResponsavel: TDateTimePicker;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    BtnCadastrar: TSpeedButton;
    BtnCancel: TSpeedButton;
    pAula: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label27: TLabel;
    Panel1: TPanel;
    Label5: TLabel;
    CBCurso: TComboBox;
    Panel2: TPanel;
    Label24: TLabel;
    Label26: TLabel;
    CBDia: TComboBox;
    DateTimePicker1: TDateTimePicker;
    Panel3: TPanel;
    Label25: TLabel;
    Label11: TLabel;
    CBSala: TComboBox;
    CBProfessor: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure DTDataNascAlunoExit(Sender: TObject);
    procedure ScrollBarCadAlunoChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure LimparEdits;
    procedure BtnCadastrarClick(Sender: TObject);
    procedure CreateEndereco;
    procedure CreateAluno;
    procedure CreateResponsavel;
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure calculoIdade;
    procedure pNovoAlunoExit(Sender: TObject);
  private
    procedure edits_responsavel(pEdit: TEdit); OverLoad;
    procedure edits_responsavel(pEdit: TMaskEdit); OverLoad;
    procedure edit_clean(pEdit: TEdit); OverLoad;
    procedure edit_clean(pEdit: TMaskEdit); OverLoad;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  Endereco: TEndereco;
  Aluno: TAluno;
  Responsavel: TResponsavel;
  AlunoDAO: TAlunoDAO;
  EnderecoDAO: TEnderecoDAO;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnCadastrarClick(Sender: TObject);
begin
  CreateAluno;
  CreateEndereco;


  if YearsBetween(now, DTDataNascAluno.Date) <= 17 then
  begin

    CreateResponsavel;

    if not enderecoDAO.CadastrarEndereco(Endereco) = true then
    begin
      ShowMessage('Erro no cadastro de endereço');
      abort
    end;

    if not AlunoDAO.CadastrarResponsavel(Responsavel) = true then
    begin
      ShowMessage('Erro no cadastro de responsavel');
      abort
    end;

    if AlunoDAO.CadastrarAlunoResponsavel(Aluno, Endereco, Responsavel) = true then
    begin
      ShowMessage(Aluno.Nome + ' cadastrado(a) com sucesso');
      LimparEdits;
    end;

  end
  else
  begin

    if not EnderecoDAO.CadastrarEndereco(Endereco) = true then
    begin
      ShowMessage('Erro ao cadastro de endereço');
      abort
    end;

    if AlunoDAO.CadastrarAlunoResponsavel(Aluno, Endereco, Responsavel) = true then
    begin
      ShowMessage(Aluno.Nome + ' cadastrado(a) com sucesso');
      LimparEdits;
    end
    else
    begin
      ShowMessage('Falha ao cadastrar aluno' + #13 + #13 +
        'Certifique-se de preencher todos os campos');
    end;
  end;

end;

procedure TFrmPrincipal.BtnCancelClick(Sender: TObject);
begin
  LimparEdits;
  close;
end;

procedure TFrmPrincipal.calculoIdade;
begin
  if YearsBetween(now, DTDataNascAluno.Date) <= 17 then
  begin
    pResponsavelCad.Show;
    ScrollBarCadAluno.Show;
    edits_responsavel(EdtCpfAluno);
    edits_responsavel(EdtRgAluno);
    edits_responsavel(EdtContatoComAluno);
    EdtEmailAluno.TextHint := 'Opcional';
    EdtContatoAluno.TextHint := 'Opcional';
  end
  else
  begin
    pResponsavelCad.Hide;
    ScrollBarCadAluno.Hide;
    edit_clean(EdtCpfAluno);
    edit_clean(EdtRgAluno);
    edit_clean(EdtContatoComAluno);
    EdtEmailAluno.TextHint := '';
    EdtContatoAluno.TextHint := '';
  end;
end;

procedure TFrmPrincipal.CreateAluno;
begin

  if YearsBetween(now, DTDataNascAluno.Date) <= 17 then
  begin
    if (EdtNomeAluno.Text = '') then
    begin
      ShowMessage('Erro ao cadastrar aluno' + #13 + #13 +
        'Certifique-se de preencher todos os dados');
      abort
    end;
  end
  else
  begin
    if (EdtNomeAluno.Text = '') or (EdtCpfAluno.Text = '___.___.___-__') or
      (EdtContatoAluno.Text = '') then
    begin
      ShowMessage('Erro ao cadastrar aluno' + #13 + #13 +
        'Certifique-se de preencher todos os dados');
      abort
    end;
  end;

  Aluno := TAluno.Create;

  Aluno.Nome := EdtNomeAluno.Text;
  Aluno.Cpf := EdtCpfAluno.Text;
  Aluno.RG := EdtRgAluno.Text;
  Aluno.DataNasc := DTDataNascAluno.Date;
  Aluno.Contato := EdtContatoAluno.Text;
  Aluno.Email := EdtEmailAluno.Text;
  Aluno.ContatoCom := EdtContatoComAluno.Text;

end;

procedure TFrmPrincipal.CreateEndereco;
begin
  try
    if (EdtRua.Text = '') or (EdtBairro.Text = '') or (MECep.Text = '_____-___') then
    begin
      ShowMessage('Erro ao cadastrar endereco' + #13 + #13 +
      'Certifique-se de preencher todos os dados');
      abort
    end;

    Endereco := TEndereco.Create;

    Endereco.Rua := EdtRua.Text;
    Endereco.Numero := StrToInt(EdtNumero.Text);
    Endereco.Cidade := EdtCidade.Text;
    Endereco.Bairro := EdtBairro.Text;
    Endereco.Cep := MECep.Text;
  except
    ShowMessage('Erro ao cadastrar endereco' + #13 + #13 +
      'Certifique-se de preencher todos os dados');
    abort
  end;
end;

procedure TFrmPrincipal.CreateResponsavel;
begin
  if (EdtNomeResponsável.Text = '') or (EdtCpfResponsavel.Text = '') or
    (ContatoResponsavel.Text = '') then
  begin
    ShowMessage('Erro ao cadastrar Responsavel' + #13 + #13 +
      'Certifique-se de preencher todos os dados');
    abort
  end;

  Responsavel := TResponsavel.Create;

  Responsavel.Nome := EdtNomeResponsável.Text;
  Responsavel.Cpf := EdtCpfResponsavel.Text;
  Responsavel.RG := EdtRgAluno.Text;
  Responsavel.DataNasc := DTDataNascResponsavel.Date;
  Responsavel.Contato := ContatoResponsavel.Text;
  Responsavel.ContatoCom := ContatoComResponsavel.Text;
end;

procedure TFrmPrincipal.DTDataNascAlunoExit(Sender: TObject);
begin
  calculoIdade;
end;

procedure TFrmPrincipal.edits_responsavel(pEdit: TMaskEdit);
begin
  pEdit.EditMask := '!999.999.999-99;0;_';
  pEdit.Text := 'RESPONSÁVEL';
  pEdit.ReadOnly := true;

end;

procedure TFrmPrincipal.edit_clean(pEdit: TMaskEdit);
begin
  if pEdit.Text = 'RESPONSÁVEL' then
    pEdit.Clear;
  pEdit.EditMask := '!999.999.999-99;1;_';
  pEdit.ReadOnly := false;
end;

procedure TFrmPrincipal.edit_clean(pEdit: TEdit);
begin
  if pEdit.Text = 'RESPONSÁVEL' then
    pEdit.Clear;

  pEdit.ReadOnly := false;
end;

procedure TFrmPrincipal.edits_responsavel(pEdit: TEdit);
begin
  pEdit.Text := 'RESPONSÁVEL';
  pEdit.ReadOnly := true;

end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;
  ScrollBarCadAluno.Position := 0;

  AlunoDAO := TAlunoDAO.Create;
  EnderecoDAO := TEnderecoDAO.Create;
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(Aluno) then
      FreeAndNil(Aluno);

    if Assigned(Responsavel) then
      FreeAndNil(Responsavel);

    if Assigned(Endereco) then
      FreeAndNil(Endereco);

    if Assigned(EnderecoDAO) then
      FreeAndNil(EnderecoDAO);

    if Assigned(AlunoDAO) then
      FreeAndNil(AlunoDAO);
  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmPrincipal.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if ScrollBarCadAluno.Visible = true then
    ScrollBarCadAluno.Position := ScrollBarCadAluno.Position + 240
end;

procedure TFrmPrincipal.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if ScrollBarCadAluno.Visible = true then
    ScrollBarCadAluno.Position := ScrollBarCadAluno.Position - 240

end;

procedure TFrmPrincipal.LimparEdits;
begin
  EdtContatoAluno.Clear;
  EdtEmailAluno.Clear;
  EdtCpfAluno.Clear;
  EdtRgAluno.Clear;
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
  ContatoResponsavel.Clear;
  DTDataNascAluno.Date := StrToDate('01/01/2000');
  DTDataNascResponsavel.Date := StrToDate('01/01/2000');
end;

procedure TFrmPrincipal.pNovoAlunoExit(Sender: TObject);
begin
  calculoIdade;
end;

procedure TFrmPrincipal.ScrollBarCadAlunoChange(Sender: TObject);
begin
  pCadastroAluno.top := -ScrollBarCadAluno.Position
end;

end.
