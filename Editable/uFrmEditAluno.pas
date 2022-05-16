unit uFrmEditAluno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.Mask, Vcl.ExtCtrls, uAluno, uAlunoDAO, uResponsavel,
  uEndereco, System.Generics.Collections,
  uEnderecoDAO, uAulaDAO, uAula, uFrmEditAula, FireDac.comp.client;

type
  TFrmEditAluno = class(TForm)
    pCadastroAluno: TPanel;
    pNovoAluno: TPanel;
    Label2: TLabel;
    DataDeNascimento: TLabel;
    nome: TLabel;
    Label14: TLabel;
    Contato: TLabel;
    Label16: TLabel;
    cpf: TLabel;
    Label18: TLabel;
    EdtContatoAluno: TEdit;
    EdtCpfAluno: TMaskEdit;
    EdtNomeAluno: TEdit;
    EdtContatoComAluno: TEdit;
    DTDataNascAluno: TDateTimePicker;
    EdtEmailAluno: TEdit;
    CBTemResponsavel: TCheckBox;
    pResponsavelCad: TPanel;
    Label1: TLabel;
    NomeResponsavel: TLabel;
    ContatoResponsavel: TLabel;
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
    bairro: TLabel;
    cep: TLabel;
    EdtRua: TEdit;
    EdtNumero: TEdit;
    EdtBairro: TEdit;
    MECep: TMaskEdit;
    pAula: TPanel;
    BtnSave: TSpeedButton;
    BtnCancel: TSpeedButton;
    Label27: TLabel;
    LVAulas: TListView;
    BtnCadAula: TButton;
    BtnDeleteAula: TButton;
    BtnUpdateAula: TButton;
    ScrollBar: TScrollBar;
    BtnEditar: TButton;
    EdtRgAluno: TEdit;
    EdtCidade: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBTemResponsavelExit(Sender: TObject);
    procedure ScrollBarChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnDeleteAulaClick(Sender: TObject);
    procedure BtnUpdateAulaClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure BtnCadAulaClick(Sender: TObject);
  private

    procedure DefinirAltura;
    procedure edits_responsavel(pEdit: TMaskEdit); OverLoad;
    procedure edits_responsavel(pEdit: TEdit); OverLoad;
    procedure edit_clean(pEdit: TMaskEdit); OverLoad;
    procedure edit_clean(pEdit: TEdit); OverLoad;
    procedure PreencherAulas(pListaAulas: TList<TAula>);
    procedure LoadResponsavel;
    procedure OnlyRead;
    procedure Editable;
    procedure CreateAluno;
    procedure CreateEndereco;
    procedure CreateResponsavel;
    procedure CriaCB(Ds: TFDQuery; CB: TComboBox);
    procedure ObrigatoryEdit;
    procedure ObrigatoryEdit_clear;
  public
    procedure PreencherTela(pAluno: TAluno);
  end;

var
  FrmEditAluno: TFrmEditAluno;
  Aluno: TAluno;
  AlunoDAO: TAlunoDAO;
  Endereco: Tendereco;
  EnderecoDAO: TEnderecoDAO;
  Responsavel: TResponsavel;
  AulaDAO: TAulaDAO;
  Aula: TAula;

implementation

{$R *.dfm}

uses uFrmListagem;

procedure TFrmEditAluno.BtnCadAulaClick(Sender: TObject);
begin
  FrmAula.NewAula(Aluno);
  FrmAula.ShowModal;

  PreencherAulas(AulaDAO.PesquisaAula(Aluno));
end;

procedure TFrmEditAluno.BtnCancelClick(Sender: TObject);
begin
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
  ScrollBar.Position := 0;
  BtnSave.Hide;
  BtnEditar.Show;
  close;
end;

procedure TFrmEditAluno.BtnDeleteAulaClick(Sender: TObject);
begin
  if MessageDlg('Deseja deletar aula de ' + LVAulas.Selected.Caption + '?',
    mtWarning, mbYesNo, 1) = mrYes then
    if (AulaDAO.DeletarAula(LVAulas.ItemFocused.Data)) and
      (AlunoDAO.DeleteAluno_curso(LVAulas.ItemFocused.Data)) then
      MessageDlg('Aula deletada com sucesso', mtConfirmation, [mbok], 0);

  PreencherAulas(AulaDAO.PesquisaAula(Aluno));
end;

procedure TFrmEditAluno.BtnEditarClick(Sender: TObject);
begin
  Editable;
  BtnEditar.Hide;
  BtnSave.Show;
end;

procedure TFrmEditAluno.BtnSaveClick(Sender: TObject);
begin
  if CBTemResponsavel.State = cbChecked then
  begin

    CreateAluno;
    CreateResponsavel;
    CreateEndereco;

    EnderecoDAO.UpdateEndereco(Endereco);

    if Aluno.IDResponsavel <> 0 then
      AlunoDAO.UpdateResponsavel(Responsavel)
    else
      AlunoDAO.CadastrarResponsavel(Responsavel);

    Aluno.IDResponsavel := AlunoDAO.RetornaIDResponsavel(Responsavel);

    if AlunoDAO.UpdateAlunoResponsavel(Aluno) then
      ShowMessage(Aluno.nome + ' atualizado(a) com sucesso');

  end
  else
  begin

    CreateAluno;
    CreateEndereco;

    EnderecoDAO.UpdateEndereco(Endereco);

    if AlunoDAO.UpdateAluno(Aluno) then
      ShowMessage(Aluno.nome + ' atualizado(a) com sucesso');

    if Aluno.IDResponsavel <> 0 then
      AlunoDAO.DeleteReponsavel(Aluno);

  end;

  OnlyRead;
  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);
  ObrigatoryEdit_clear;
  ScrollBar.Position := 0;
  BtnSave.Hide;
  BtnEditar.Show;
end;

procedure TFrmEditAluno.BtnUpdateAulaClick(Sender: TObject);
begin
  try

    FrmAula.EditAula(LVAulas.ItemFocused.Data);
    FrmAula.ShowModal;

    PreencherAulas(AulaDAO.PesquisaAula(Aluno));
  except
    ShowMessage('Escolha uma aula');
  end;
end;

procedure TFrmEditAluno.CBTemResponsavelExit(Sender: TObject);
begin
  LoadResponsavel;
end;

procedure TFrmEditAluno.CreateAluno;
begin
  if CBTemResponsavel.State = cbChecked then
  begin
    if (EdtNomeAluno.Text = '') then
    begin
      MessageDlg('Erro ao editar aluno' + #13 + #13 +
        'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
      ObrigatoryEdit;
      abort
    end;
  end
  else
  begin
    if (EdtNomeAluno.Text = '') or (EdtCpfAluno.Text = '   .   .   -  ') or
      (EdtContatoAluno.Text = '') then
    begin
      MessageDlg('Erro ao editar aluno' + #13 + #13 +
        'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
      ObrigatoryEdit;
      abort
    end;
  end;

  Aluno.nome := EdtNomeAluno.Text;
  Aluno.cpf := EdtCpfAluno.Text;
  Aluno.RG := EdtRgAluno.Text;
  Aluno.DataNasc := DTDataNascAluno.Date;
  Aluno.Contato := EdtContatoAluno.Text;
  Aluno.Email := EdtEmailAluno.Text;
  Aluno.ContatoCom := EdtContatoComAluno.Text;
end;

procedure TFrmEditAluno.CreateEndereco;
begin

  if (EdtRua.Text = '') or (EdtBairro.Text = '') or (MECep.Text = '     -   ')
    or (EdtCidade.ItemIndex = -1) or (EdtNumero.Text = '') then
  begin
    MessageDlg('Erro ao editar endereco' + #13 + #13 +
      'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
    ObrigatoryEdit;
    abort
  end;

  Endereco.rua := EdtRua.Text;
  Endereco.numero := StrToInt(EdtNumero.Text);
  Endereco.cidade := EdtCidade.Text;
  Endereco.bairro := EdtBairro.Text;
  Endereco.cep := MECep.Text;

end;

procedure TFrmEditAluno.CreateResponsavel;
begin
  if (EdtNomeResponsável.Text = '') or
    (EdtCpfResponsavel.Text = '   .   .   -  ') or
    (EdtContatoResponsavel.Text = '') then
  begin
    MessageDlg('Erro ao editar responsavel' + #13 + #13 +
      'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
    ObrigatoryEdit;
    abort
  end;

  Responsavel.nome := EdtNomeResponsável.Text;
  Responsavel.cpf := EdtCpfResponsavel.Text;
  Responsavel.RG := EdtRgAluno.Text;
  Responsavel.DataNasc := DTDataNascResponsavel.Date;
  Responsavel.Contato := EdtContatoResponsavel.Text;
  Responsavel.ContatoCom := EdtContatoComResponsavel.Text;
end;

procedure TFrmEditAluno.CriaCB(Ds: TFDQuery; CB: TComboBox);
begin
  CB.Clear;
  while not(Ds.Eof) do
  begin
    CB.Items.Add(Ds.FieldByName('nome').AsString);

    Ds.Next;
  end;
  CB.ItemIndex := -1;
end;

procedure TFrmEditAluno.DefinirAltura;
begin
  pCadastroAluno.Height := 0;
  pCadastroAluno.Height := pNovoAluno.Height + pEndereçoAluno.Height +
    pAula.Height;
  if pResponsavelCad.Visible = true then
    pCadastroAluno.Height := pCadastroAluno.Height + pResponsavelCad.Height;

  ScrollBar.Max := pCadastroAluno.Height - FrmEditAluno.Height + 28;
  ScrollBar.Position := 0;
end;

procedure TFrmEditAluno.Editable;
begin
  EdtContatoAluno.ReadOnly := False;
  EdtCpfAluno.ReadOnly := False;
  EdtRgAluno.ReadOnly := False;
  EdtNomeAluno.ReadOnly := False;
  EdtContatoComAluno.ReadOnly := False;
  EdtEmailAluno.ReadOnly := False;
  EdtNomeResponsável.ReadOnly := False;
  EdtContatoResponsavel.ReadOnly := False;
  EdtContatoComResponsavel.ReadOnly := False;
  EdtCpfResponsavel.ReadOnly := False;
  EdtRgResponsavel.ReadOnly := False;
  EdtRua.ReadOnly := False;
  EdtNumero.ReadOnly := False;
  EdtBairro.ReadOnly := False;
  EdtCidade.Enabled := true;
  MECep.ReadOnly := False;
  DTDataNascAluno.Enabled := true;
  CBTemResponsavel.Enabled := true;
  DTDataNascResponsavel.Enabled := true;
  BtnCadAula.Enabled := true;
  BtnDeleteAula.Enabled := true;
  BtnUpdateAula.Enabled := true;
end;

procedure TFrmEditAluno.edits_responsavel(pEdit: TEdit);
begin
  pEdit.Text := 'RESPONSÁVEL';
  pEdit.ReadOnly := true;
end;

procedure TFrmEditAluno.edits_responsavel(pEdit: TMaskEdit);
begin
  begin
    pEdit.EditMask := '!999.999.999-99;0;_';
    pEdit.Text := 'RESPONSÁVEL';
    pEdit.ReadOnly := true;
  end;
end;

procedure TFrmEditAluno.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  Aluno := TAluno.Create;
  AlunoDAO := TAlunoDAO.Create;
  Endereco := Tendereco.Create;
  EnderecoDAO := TEnderecoDAO.Create;
  Responsavel := TResponsavel.Create;
  AulaDAO := TAulaDAO.Create;
  Aula := TAula.Create;

  CriaCB(EnderecoDAO.RetornaCidades, EdtCidade);

  DefinirAltura;
end;

procedure TFrmEditAluno.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(Aluno) then
      FreeAndNil(Aluno);
    if Assigned(AlunoDAO) then
      FreeAndNil(AlunoDAO);
    if Assigned(Endereco) then
      FreeAndNil(Endereco);
    if Assigned(EnderecoDAO) then
      FreeAndNil(EnderecoDAO);
    if Assigned(Responsavel) then
      FreeAndNil(Responsavel);
    if Assigned(AulaDAO) then
      FreeAndNil(AulaDAO);
    if Assigned(Aula) then
      FreeAndNil(Aula);

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmEditAluno.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar.Position := ScrollBar.Position + 80;
end;

procedure TFrmEditAluno.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar.Position := ScrollBar.Position - 80;
end;

procedure TFrmEditAluno.LoadResponsavel;
begin
  if CBTemResponsavel.State = cbChecked then
  begin
    pResponsavelCad.Show;
    edits_responsavel(EdtCpfAluno);
    edits_responsavel(EdtRgAluno);
    EdtEmailAluno.TextHint := 'Opcional';
    EdtContatoAluno.TextHint := 'Opcional';
    EdtContatoComAluno.TextHint := 'Opcional';
    Contato.Font.Style := [];
    pResponsavelCad.Show;
    DefinirAltura;
  end
  else
  begin
    pResponsavelCad.Hide;
    DefinirAltura;
    pResponsavelCad.Hide;
    edit_clean(EdtCpfAluno);
    edit_clean(EdtRgAluno);
    EdtEmailAluno.TextHint := '';
    EdtContatoAluno.TextHint := '';
    EdtContatoComAluno.TextHint := '';
  end;
end;

procedure TFrmEditAluno.ObrigatoryEdit;
begin
  // aluno
  EdtNomeAluno.SetFocus;
  ScrollBar.Position := 0;
  nome.Font.Style := [fsBold];
  cpf.Font.Style := [fsBold];
  DataDeNascimento.Font.Style := [fsBold];
  Contato.Font.Style := [fsBold];
  // responsavel
  NomeResponsavel.Font.Style := [fsBold];
  ContatoResponsavel.Font.Style := [fsBold];
  CPFResponsavel.Font.Style := [fsBold];
  // endereco
  rua.Font.Style := [fsBold];
  bairro.Font.Style := [fsBold];
  cep.Font.Style := [fsBold];
  cidade.Font.Style := [fsBold];
  numero.Font.Style := [fsBold];
end;

procedure TFrmEditAluno.ObrigatoryEdit_clear;
begin
  // aluno
  nome.Font.Style := [];
  cpf.Font.Style := [];
  DataDeNascimento.Font.Style := [];
  Contato.Font.Style := [];
  // responsavel
  NomeResponsavel.Font.Style := [];
  ContatoResponsavel.Font.Style := [];
  CPFResponsavel.Font.Style := [];
  // endereco
  rua.Font.Style := [];
  bairro.Font.Style := [];
  cep.Font.Style := [];
  cidade.Font.Style := [];
  numero.Font.Style := [];
end;

procedure TFrmEditAluno.OnlyRead;
begin
  EdtContatoAluno.ReadOnly := true;
  EdtCpfAluno.ReadOnly := true;
  EdtRgAluno.ReadOnly := true;
  EdtNomeAluno.ReadOnly := true;
  EdtContatoComAluno.ReadOnly := true;
  EdtEmailAluno.ReadOnly := true;
  EdtNomeResponsável.ReadOnly := true;
  EdtContatoResponsavel.ReadOnly := true;
  EdtContatoComResponsavel.ReadOnly := true;
  EdtCpfResponsavel.ReadOnly := true;
  EdtRgResponsavel.ReadOnly := true;
  EdtRua.ReadOnly := true;
  EdtNumero.ReadOnly := true;
  EdtBairro.ReadOnly := true;
  EdtCidade.Enabled := False;
  MECep.ReadOnly := true;
  DTDataNascAluno.Enabled := False;
  CBTemResponsavel.Enabled := False;
  DTDataNascResponsavel.Enabled := False;
  BtnCadAula.Enabled := False;
  BtnDeleteAula.Enabled := False;
  BtnUpdateAula.Enabled := False;
end;

procedure TFrmEditAluno.PreencherAulas(pListaAulas: TList<TAula>);
var
  I: integer;
  tempItem: TListItem;
  HoraAux: TTime;
begin
  try
    HoraAux := StrToTime('01:00:00');

    if Assigned(pListaAulas) then
    begin
      LVAulas.Clear;

      for I := 0 to pListaAulas.Count - 1 do
      begin

        tempItem := LVAulas.Items.Add;
        tempItem.Caption := TAula(pListaAulas[I]).Curso;
        tempItem.SubItems.Add(TAula(pListaAulas[I]).Professor);
        tempItem.SubItems.Add(TAula(pListaAulas[I]).dia);
        tempItem.SubItems.Add(TimeToStr(TAula(pListaAulas[I]).Hora_inicio) +
          ' - ' + TimeToStr(TAula(pListaAulas[I]).Hora_inicio + HoraAux));
        tempItem.SubItems.Add(TAula(pListaAulas[I]).Sala);
        tempItem.Data := TAula(pListaAulas[I]);
      end;
    end
    else
    begin
      LVAulas.Clear;
      if MessageDlg('O(a) aluno(a) ' + Aluno.nome +
        ' não possui aulas cadastradas, gostaria de deleta-lo?', mtWarning,
        [mbYes, mbNo], 1) = mrYes then
        if MessageDlg('Depois de deletar o aluno isso não pode-rá ser revertido'
          + #13 + #13 + 'Continuar?', mtWarning, [mbYes, mbNo], 1) = mrYes then
          AlunoDAO.DeleteAluno(Aluno);
    end;

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmEditAluno.PreencherTela(pAluno: TAluno);
var
  I: integer;
begin
  if pAluno.IDResponsavel = 0 then
    CBTemResponsavel.State := cbUnchecked
  else
    CBTemResponsavel.State := cbChecked;

  LoadResponsavel;

  if pAluno.IDResponsavel = 0 then
  begin
    Aluno := AlunoDAO.RetornaAluno(pAluno.ID);
    EdtNomeAluno.Text := Aluno.nome;
    EdtEmailAluno.Text := Aluno.Email;
    DTDataNascAluno.Date := Aluno.DataNasc;
    EdtContatoAluno.Text := Aluno.Contato;
    EdtContatoComAluno.Text := Aluno.ContatoCom;
    EdtCpfAluno.Text := Aluno.cpf;
    EdtRgAluno.Text := Aluno.RG;

    EdtNomeResponsável.Clear;
    DTDataNascResponsavel.Date := StrToDate('01/01/2000');
    EdtContatoResponsavel.Clear;
    EdtContatoComResponsavel.Clear;
    EdtCpfResponsavel.Clear;
    EdtRgResponsavel.Clear;
  end
  else
  begin
    Aluno := AlunoDAO.RetornaAluno(pAluno.ID);
    EdtNomeAluno.Text := Aluno.nome;
    EdtEmailAluno.Text := Aluno.Email;
    DTDataNascAluno.Date := Aluno.DataNasc;
    EdtContatoAluno.Text := Aluno.Contato;
    EdtContatoComAluno.Text := Aluno.ContatoCom;
    EdtCpfAluno.Text := Aluno.cpf;
    EdtRgAluno.Text := Aluno.RG;

    Responsavel := AlunoDAO.RetornaResponsavel(pAluno.IDResponsavel);
    EdtNomeResponsável.Text := Responsavel.nome;
    DTDataNascResponsavel.Date := Responsavel.DataNasc;
    EdtContatoResponsavel.Text := Responsavel.Contato;
    EdtContatoComResponsavel.Text := Responsavel.ContatoCom;
    EdtCpfResponsavel.Text := Responsavel.cpf;
    EdtRgResponsavel.Text := Responsavel.RG;
  end;

  Endereco.ID := pAluno.IdEndereco;
  Endereco := EnderecoDAO.RetornarEndereco(Endereco);
  EdtRua.Text := Endereco.rua;
  EdtNumero.Text := inttostr(Endereco.numero);
  EdtBairro.Text := Endereco.bairro;
  MECep.Text := Endereco.cep;

  for I := 0 to EdtCidade.Items.Count - 1 do
    if EdtCidade.Items[I] = Endereco.cidade then
      EdtCidade.ItemIndex := I;

  PreencherAulas(AulaDAO.PesquisaAula(Aluno));
  OnlyRead;
end;

procedure TFrmEditAluno.ScrollBarChange(Sender: TObject);
begin
  pCadastroAluno.top := -ScrollBar.Position;
end;

procedure TFrmEditAluno.edit_clean(pEdit: TMaskEdit);
begin
  if pEdit.Text = 'RESPONSÁVEL' then
    pEdit.Clear;
  pEdit.EditMask := '!999.999.999-99;1;_';
  pEdit.ReadOnly := False;
end;

procedure TFrmEditAluno.edit_clean(pEdit: TEdit);
begin
  if pEdit.Text = 'RESPONSÁVEL' then
    pEdit.Clear;

  pEdit.ReadOnly := False;
end;

end.
