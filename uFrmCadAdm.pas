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
    procedure CriaCB(Ds : TFDQuery; CB : TComboBox);
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
    ShowMessage(Adm.Nome + ' cadastrado(a) com sucesso');
    LimparEdits;
    FrmCadAdm.close;
  end
  else
  begin
    ShowMessage('Falha no cadasto de funcionário' + #13 + #13 +
      'Certifique-se de preencher todos os campos');
  end;
  Obrigatory_edit_clear;
end;

procedure TFrmCadAdm.BtnCancelClick(Sender: TObject);
begin
  Obrigatory_edit_clear;
  LimparEdits;
  Close;
end;

procedure TFrmCadAdm.CreateAdm;
begin
  try
    if (EdtUser.Text = '') or (EdtNome.Text = '') or (EdtPassw.Text = '') or
      (EdtCpf.Text = '___.___.___-__') or (EdtRg.Text = '') then
    begin
      MessageDlg('Erro ao cadastrar funcionário', mtError, [mbOK], 0);
      Obrigatory_edit;
      abort
    end;

    Adm.Nome := EdtNome.Text;
    Adm.DataNasc := DTDataNasc.Date;
    Adm.Cpf := EdtCpf.Text;
    Adm.RG := EdtRg.Text;
    Adm.Contato := EdtContato.Text;
    Adm.Email := EdtEmail.Text;
    Adm.User := EdtUser.Text;
    Adm.Passw := EdtPassw.Text;

  except
    MessageDlg('Erro ao cadastrar funcionário', mtError, [mbOK], 0);
    Obrigatory_edit;
    abort
  end;
end;

procedure TFrmCadAdm.CreateEndereco;
begin
  try
    if (EdtRua.Text = '') or (EdtBairro.Text = '') or (MECep.Text = '_____-___') or(EdtCidade.ItemIndex = -1) or(EdtNumero.Text = '')
    then
    begin
      MessageDlg('Erro ao cadastrar endereco' + #13 + #13 +
        'Certifique-se de preencher todos os dados', mtError, [mbok],0);
        Obrigatory_edit;
      abort
    end;

    Endereco := TEndereco.Create;

    Endereco.Rua := EdtRua.Text;
    Endereco.Numero := StrToInt(EdtNumero.Text);
    Endereco.Cidade := EdtCidade.Text;
    Endereco.Bairro := EdtBairro.Text;
    Endereco.Cep := MECep.Text;
  except
    MessageDlg('Erro ao cadastrar endereco' + #13 + #13 +
        'Certifique-se de preencher todos os dados', mtError, [mbok],0);
        Obrigatory_edit;
  end;
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
  if not((key in['A'..'Z']) or (key in ['a'..'z']) or (key in ['0'..'9'])or (key = #08)) then
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
end;

procedure TFrmCadAdm.Obrigatory_edit;
begin
  EdtNome.SetFocus;
  nome.Font.Style := [fsBold];
  cpf.Font.Style := [fsBold];
  rg.Font.Style := [fsBold];
  user.Font.Style := [fsBold];
  senha.Font.Style := [fsBold];

  //endereco
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

  //endereco
  rua.Font.Style := [];
  bairro.Font.Style := [];
  cep.Font.Style := [];
  cidade.Font.Style := [];
  numero.Font.Style := [];
end;

end.
