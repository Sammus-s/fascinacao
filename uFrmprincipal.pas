unit uFrmprincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Menus, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Mask,
  System.DateUtils,
  uEndereco, uAluno, uResponsavel, uAlunoDAO, uDM, FireDAC.Comp.Client;

type
  TFrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    Alunos1: TMenuItem;
    Professor1: TMenuItem;
    Cronograma1: TMenuItem;
    PListaAluno: TPanel;
    LVAlunos: TListView;
    SBCadastroAluno: TSpeedButton;
    Segundafeira1: TMenuItem;
    erafeira1: TMenuItem;
    Quantafeira1: TMenuItem;
    Quintafeira1: TMenuItem;
    Sextafeira1: TMenuItem;
    Sabado1: TMenuItem;
    BtnVisualizar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    pCadastroAluno: TPanel;
    DTDataNascAluno: TDateTimePicker;
    pNovoAluno: TPanel;
    Label2: TLabel;
    EdtContatoAluno: TEdit;
    EdtCursoAluno: TEdit;
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
    EdtEmailResponsavel: TEdit;
    ContatoResponsavel: TEdit;
    ContatoComResponsavel: TEdit;
    EdtCpfResponsavel: TMaskEdit;
    EdtRgResponsavel: TMaskEdit;
    DTDataNascResponsavel: TDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
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
    Label11: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    BtnCadastrar: TSpeedButton;
    BtnCancel: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SBCadastroAlunoClick(Sender: TObject);
    procedure DTDataNascAlunoExit(Sender: TObject);
    procedure ScrollBarCadAlunoChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure LimparEdits;
    procedure BtnCadastrarClick(Sender: TObject);
    procedure CreateEndereco;
    procedure CreateAluno;
    procedure CreateResponsavel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  Endereco: TEndereco;
  Aluno: TAluno;
  Responsavel: TResponsavel;
  AlunoDAO: TAlunoDAO;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnCadastrarClick(Sender: TObject);
begin

  if not YearsBetween(DTDataNascAluno.Date, now) <= 17 then
  begin
    CreateEndereco;
    CreateAluno;
    AlunoDAO := TAlunoDAO.Create;

    if AlunoDAO.CadastrarEndereco(Endereco)= true then
    begin
     ShowMessage('endereço cadstrado');
    end;

    if AlunoDAO.CadastrarAluno(Aluno, Endereco) = true then
    begin
      ShowMessage('Aluno cadastrado com sucesso');
      LimparEdits;
      pCadastroAluno.Hide;
      PListaAluno.Show;
    end
    else
    begin
      ShowMessage('falha ao cadastrar aluno' + #13 + #13 +
        'certifiquese de preencher todos os campos');

    end;

  end;

end;

procedure TFrmPrincipal.BtnCancelClick(Sender: TObject);
begin
  LimparEdits;
  pCadastroAluno.Hide;
  PListaAluno.Show;

end;

procedure TFrmPrincipal.CreateAluno;
begin
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
  Endereco := TEndereco.Create;

  Endereco.Rua := EdtRua.Text;
  Endereco.Numero := StrToInt(EdtNumero.Text);
  Endereco.Cidade := EdtCidade.Text;
  Endereco.Bairro := EdtBairro.Text;
  Endereco.Cep := MECep.Text;
end;

procedure TFrmPrincipal.CreateResponsavel;
begin
  Responsavel := TResponsavel.Create;

  Responsavel.Nome := EdtNomeResponsável.Text;
  Responsavel.Cpf := EdtCpfResponsavel.Text;
  Responsavel.RG := EdtRgAluno.Text;
  Responsavel.DataNasc := DTDataNascResponsavel.Date;
  Responsavel.Contato := ContatoResponsavel.Text;
  Responsavel.ContatoCom := ContatoComResponsavel.Text;
  Responsavel.Email := EdtEmailResponsavel.Text;

end;

procedure TFrmPrincipal.DTDataNascAlunoExit(Sender: TObject);
begin
  if YearsBetween(DTDataNascAluno.Date, now) <= 17 then
  begin
    pResponsavelCad.Show;
    ScrollBarCadAluno.Show;
  end
  else
  begin
    pResponsavelCad.Hide;
    ScrollBarCadAluno.Hide;
  end;

end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;
end;

procedure TFrmPrincipal.LimparEdits;
begin
  EdtContatoAluno.Clear;
  EdtCursoAluno.Clear;
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
  EdtEmailResponsavel.Clear;
  EdtCpfResponsavel.Clear;
  EdtRgResponsavel.Clear;
end;

procedure TFrmPrincipal.SBCadastroAlunoClick(Sender: TObject);
begin
  PListaAluno.Hide;
  pCadastroAluno.Show;
  pResponsavelCad.Hide;
end;

procedure TFrmPrincipal.ScrollBarCadAlunoChange(Sender: TObject);
begin
  pCadastroAluno.top := -ScrollBarCadAluno.Position
end;

end.
