unit uFrmEditAdm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, uAdm, uAdmDAO, uEndereco, uEnderecoDAO, FireDac.comp.client;

type
  TFrmEdtAdm = class(TForm)
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
    BtnSave: TButton;
    BtnCancel: TButton;
    pInfo: TPanel;
    Label2: TLabel;
    Label12: TLabel;
    nome: TLabel;
    Label14: TLabel;
    contato: TLabel;
    user: TLabel;
    cpf: TLabel;
    rg: TLabel;
    senha: TLabel;
    EdtContato: TEdit;
    EdtCpf: TMaskEdit;
    EdtRg: TMaskEdit;
    EdtNome: TEdit;
    DTDataNasc: TDateTimePicker;
    EdtEmail: TEdit;
    EdtUser: TEdit;
    EdtPassw: TEdit;
    BtnDelete: TButton;
    BtnEditar: TButton;
    EdtCidade: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure EdtUserKeyPress(Sender: TObject; var Key: Char);
  private
    procedure CreateAdm;
    procedure CreateEndereco;
    procedure Editable;
    procedure Onlyread;
    procedure CriaCB(Ds: TFDQuery; CB: TComboBox);
    procedure Obrigatory_edit;
    procedure Obrigatory_edit_clear;
  public
    Procedure PreencherEdits(pAdm: TAdm);
  end;

var
  FrmEdtAdm: TFrmEdtAdm;
  Adm: TAdm;
  AdmDAO: TAdmDAO;
  Endereco: TEndereco;
  EnderecoDAO: TEnderecoDAO;

implementation

{$R *.dfm}

procedure TFrmEdtAdm.BtnEditarClick(Sender: TObject);
begin
  BtnEditar.Hide;
  BtnSave.Show;
  Editable;
end;

procedure TFrmEdtAdm.BtnSaveClick(Sender: TObject);
begin
  CreateAdm;
  if AdmDAO.UpdateAdm(Adm) = true then
  begin
    CreateEndereco;
    if EnderecoDAO.UpdateEndereco(Endereco) then
    begin
      MessageDlg(Adm.nome + ' Editado com sucesso', mtConfirmation, [mbOK], 0);
      Onlyread;
      BtnSave.Hide;
      BtnEditar.Show
    end
    else
    begin
      MessageDlg(Adm.nome + 'Erro ao Edtiar Functionário', mtConfirmation,
        [mbOK], 0);
      abort;
    end;
  end;
  Obrigatory_edit_clear;
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
end;

procedure TFrmEdtAdm.BtnCancelClick(Sender: TObject);
begin
  Close;
  Obrigatory_edit_clear;
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
end;

procedure TFrmEdtAdm.BtnDeleteClick(Sender: TObject);
begin
  if MessageDlg('Deseja deletar a Conta?', mtWarning, [mbYes, mbNo], 1) = mrYes
  then
  begin
    if AdmDAO.DeleteAdm(Adm) = true then
    begin
      MessageDlg(Adm.nome + ' Deletado com sucesso', mtConfirmation, [mbOK], 0);
      Close;
    end
    else
    begin
      MessageDlg('Erro ao deletar funcionário', mtWarning, [mbYes, mbNo], 1);
      abort;
    end;
  end;
  Obrigatory_edit_clear;
end;

procedure TFrmEdtAdm.CreateAdm;
begin
  if (EdtUser.Text = '') or (EdtNome.Text = '') or (EdtPassw.Text = '') or
    (EdtCpf.Text = '___.___.___-__') or (EdtRg.Text = '') then
  begin
    MessageDlg('Erro ao editar funcionário', mtError, [mbOK], 0);
    Obrigatory_edit;
    abort
  end;

  Adm.nome := EdtNome.Text;
  Adm.DataNasc := DTDataNasc.Date;
  Adm.cpf := EdtCpf.Text;
  Adm.rg := EdtRg.Text;
  Adm.contato := EdtContato.Text;
  Adm.Email := EdtEmail.Text;
  Adm.user := EdtUser.Text;
  Adm.Passw := EdtPassw.Text;

end;

procedure TFrmEdtAdm.CreateEndereco;
begin

  if (EdtRua.Text = '') or (EdtBairro.Text = '') or (MECep.Text = '_____-___')
    or (EdtCidade.ItemIndex = -1) or (EdtNumero.Text = '') then
  begin
    MessageDlg('Erro ao editar endereco' + #13 + #13 +
      'Certifique-se de preencher todos os dados', mtError, [mbOK], 0);
    Obrigatory_edit;
    abort
  end;

  Endereco := TEndereco.Create;

  Endereco.ID := Adm.IDEndereco;
  Endereco.rua := EdtRua.Text;
  Endereco.numero := StrToInt(EdtNumero.Text);
  Endereco.cidade := EdtCidade.Text;
  Endereco.bairro := EdtBairro.Text;
  Endereco.cep := MECep.Text;

end;

procedure TFrmEdtAdm.CriaCB(Ds: TFDQuery; CB: TComboBox);
begin
  CB.Clear;
  while not(Ds.Eof) do
  begin
    CB.Items.Add(Ds.FieldByName('nome').AsString);

    Ds.Next;
  end;
  CB.ItemIndex := -1;
end;

procedure TFrmEdtAdm.Editable;
begin
  EdtContato.ReadOnly := False;
  EdtCpf.ReadOnly := False;
  EdtRg.ReadOnly := False;
  EdtNome.ReadOnly := False;
  EdtEmail.ReadOnly := False;
  EdtRua.ReadOnly := False;
  EdtNumero.ReadOnly := False;
  EdtCidade.enabled := true;
  EdtBairro.ReadOnly := False;
  MECep.ReadOnly := False;
  EdtUser.ReadOnly := False;
  EdtPassw.ReadOnly := False;
  DTDataNasc.enabled := true;
end;

procedure TFrmEdtAdm.EdtUserKeyPress(Sender: TObject; var Key: Char);
begin
  if not((Key in ['A' .. 'Z']) or (Key in ['a' .. 'z']) or (Key in ['0' .. '9'])
    or (Key = #08)) then
    Key := #0;
end;

procedure TFrmEdtAdm.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  Adm := TAdm.Create;
  AdmDAO := TAdmDAO.Create;
  Endereco := TEndereco.Create;
  EnderecoDAO := TEnderecoDAO.Create;

  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
end;

procedure TFrmEdtAdm.FormDestroy(Sender: TObject);
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

procedure TFrmEdtAdm.Obrigatory_edit;
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

procedure TFrmEdtAdm.Obrigatory_edit_clear;
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

procedure TFrmEdtAdm.Onlyread;
begin
  EdtContato.ReadOnly := true;
  EdtCpf.ReadOnly := true;
  EdtRg.ReadOnly := true;
  EdtNome.ReadOnly := true;
  EdtEmail.ReadOnly := true;
  EdtRua.ReadOnly := true;
  EdtNumero.ReadOnly := true;
  EdtCidade.enabled := False;
  EdtBairro.ReadOnly := true;
  MECep.ReadOnly := true;
  EdtUser.ReadOnly := true;
  EdtPassw.ReadOnly := true;
  DTDataNasc.enabled := False;
end;

procedure TFrmEdtAdm.PreencherEdits(pAdm: TAdm);
var
  I: integer;
begin
  Onlyread;
  Adm := AdmDAO.RetornaAdm(pAdm);
  EdtNome.Text := Adm.nome;
  EdtContato.Text := Adm.contato;
  EdtCpf.Text := Adm.cpf;
  EdtRg.Text := Adm.rg;
  EdtEmail.Text := Adm.Email;
  DTDataNasc.DateTime := Adm.DataNasc;
  EdtUser.Text := Adm.user;
  EdtPassw.Text := Adm.Passw;

  Endereco.ID := pAdm.IDEndereco;
  Endereco := EnderecoDAO.RetornarEndereco(Endereco);

  EdtRua.Text := Endereco.rua;
  EdtNumero.Text := IntToStr(Endereco.numero);
  EdtBairro.Text := Endereco.bairro;
  MECep.Text := Endereco.cep;

  for I := 0 to EdtCidade.Items.Count - 1 do
    if EdtCidade.Items[I] = Endereco.cidade then
      EdtCidade.ItemIndex := I;
end;

end.
