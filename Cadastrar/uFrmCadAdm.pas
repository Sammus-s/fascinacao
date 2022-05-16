unit uFrmCadAdm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask,
  Vcl.ExtCtrls, uAdm, uEndereco, uEnderecoDAO, uAdmDAO, FireDac.comp.client;

type
  TFrmCadAdm = class(TForm)
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
    pInfo: TPanel;
    Label2: TLabel;
    Label12: TLabel;
    nome: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    user: TLabel;
    cpf: TLabel;
    rg: TLabel;
    EdtContato: TEdit;
    EdtCpf: TMaskEdit;
    EdtRg: TMaskEdit;
    EdtNome: TEdit;
    DTDataNasc: TDateTimePicker;
    EdtEmail: TEdit;
    EdtUser: TEdit;
    EdtPassw: TEdit;
    senha: TLabel;
    BtnCadastrar: TButton;
    BtnCancel: TButton;
    EdtCidade: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnCadastrarClick(Sender: TObject);
    procedure EdtUserKeyPress(Sender: TObject; var Key: Char);
  private
    procedure LimparEdits;
    procedure CreateAdm;
    procedure CreateEndereco;
    procedure CriaCB(Ds: TFDQuery; CB: TComboBox);
    procedure Obrigatory_edit;
    procedure Obrigatory_edit_clear;
  public
    { Public declarations }
  end;

var
  FrmCadAdm: TFrmCadAdm;
  Adm: TAdm;
  AdmDAO: TAdmDAO;
  Endereco: TEndereco;
  EnderecoDAO: TEnderecoDAO;

implementation

{$R *.dfm}
{ TForm2 }

procedure TFrmCadAdm.BtnCadastrarClick(Sender: TObject);
begin
  CreateEndereco;
  CreateAdm;

  if not EnderecoDAO.CadastrarEndereco(Endereco) = true then
  begin
    ShowMessage('Erro ao cadastro de endereço');
    abort
  end;

  if AdmDAO.CreateAdm(Adm) = true then
  begin
    ShowMessage(Adm.nome + ' cadastrado(a) com sucesso');
    LimparEdits;
    FrmCadAdm.close;
  end
  else
  begin
    ShowMessage('Falha no cadasto de funcionário' + #13 + #13 +
      'Certifique-se de preencher todos os campos');
  end;
  Obrigatory_edit_clear;
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
end;

procedure TFrmCadAdm.BtnCancelClick(Sender: TObject);
begin
  Obrigatory_edit_clear;
  LimparEdits;
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
  close;
end;

procedure TFrmCadAdm.CreateAdm;
begin
  if (EdtUser.Text = '') or (EdtNome.Text = '') or (EdtPassw.Text = '') or
    (EdtCpf.Text = '___.___.___-__') or (EdtRg.Text = '') then
  begin
    MessageDlg('Erro ao cadastrar funcionário', mtError, [mbOK], 0);
    Obrigatory_edit;
    abort
  end;

  Adm.nome := EdtNome.Text;
  Adm.DataNasc := DTDataNasc.Date;
  Adm.cpf := EdtCpf.Text;
  Adm.rg := EdtRg.Text;
  Adm.Contato := EdtContato.Text;
  Adm.Email := EdtEmail.Text;
  Adm.user := EdtUser.Text;
  Adm.Passw := EdtPassw.Text;

end;

procedure TFrmCadAdm.CreateEndereco;
begin

  if (EdtRua.Text = '') or (EdtBairro.Text = '') or (MECep.Text = '_____-___')
    or (EdtCidade.ItemIndex = -1) or (EdtNumero.Text = '') then
  begin
    MessageDlg('Erro ao cadastrar endereco' + #13 + #13 +
      'Certifique-se de preencher todos os dados', mtError, [mbOK], 0);
    Obrigatory_edit;
    abort
  end;

  Endereco := TEndereco.Create;

  Endereco.rua := EdtRua.Text;
  Endereco.numero := StrToInt(EdtNumero.Text);
  Endereco.cidade := EdtCidade.Text;
  Endereco.bairro := EdtBairro.Text;
  Endereco.cep := MECep.Text;

end;

procedure TFrmCadAdm.CriaCB(Ds: TFDQuery; CB: TComboBox);
begin
  CB.Clear;
  while not(Ds.Eof) do
  begin
    CB.Items.Add(Ds.FieldByName('nome').AsString);

    Ds.Next;
  end;
  CB.ItemIndex := -1;
end;

procedure TFrmCadAdm.EdtUserKeyPress(Sender: TObject; var Key: Char);
begin
  if not((Key in ['A' .. 'Z']) or (Key in ['a' .. 'z']) or (Key in ['0' .. '9'])
    or (Key = #08)) then
    Key := #0;
end;

procedure TFrmCadAdm.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  Adm := TAdm.Create;
  AdmDAO := TAdmDAO.Create;
  Endereco := TEndereco.Create;
  EnderecoDAO := TEnderecoDAO.Create;

  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
end;

procedure TFrmCadAdm.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(Adm) then
      FreeAndNil(Adm);

    if Assigned(AdmDAO) then
      FreeAndNil(AdmDAO);

    if Assigned(Endereco) then
      FreeAndNil(Endereco);

    if Assigned(EnderecoDAO) then
      FreeAndNil(EnderecoDAO);
  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmCadAdm.LimparEdits;
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
  EdtUser.Clear;
  EdtPassw.Clear;
  MECep.Clear;
  DTDataNasc.Date := StrToDate('01/01/2000');
end;

procedure TFrmCadAdm.Obrigatory_edit;
begin
  EdtNome.SetFocus;
  nome.Font.Style := [fsBold];
  cpf.Font.Style := [fsBold];
  rg.Font.Style := [fsBold];
  user.Font.Style := [fsBold];
  senha.Font.Style := [fsBold];

  // endereco
  rua.Font.Style := [fsBold];
  bairro.Font.Style := [fsBold];
  cep.Font.Style := [fsBold];
  cidade.Font.Style := [fsBold];
  numero.Font.Style := [fsBold];
end;

procedure TFrmCadAdm.Obrigatory_edit_clear;
begin
  EdtNome.SetFocus;
  nome.Font.Style := [];
  cpf.Font.Style := [];
  rg.Font.Style := [];
  user.Font.Style := [];
  senha.Font.Style := [];

  // endereco
  rua.Font.Style := [];
  bairro.Font.Style := [];
  cep.Font.Style := [];
  cidade.Font.Style := [];
  numero.Font.Style := [];
end;

end.
