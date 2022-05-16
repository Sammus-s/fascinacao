unit uFrmEditProfessor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.CheckLst, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, uProfessor, uProfessorDAO,
  uEndereco,
  uEnderecoDAO, uCursoDAO, FireDac.comp.client, System.Generics.Collections;

type
  TFrmEditProfessor = class(TForm)
    pCadProfessor: TPanel;
    pInfo: TPanel;
    Label2: TLabel;
    DataDeNascimento: TLabel;
    Nome: TLabel;
    Email: TLabel;
    Contato: TLabel;
    cnpj: TLabel;
    CPF: TLabel;
    Rg: TLabel;
    EdtContato: TEdit;
    EdtCpf: TMaskEdit;
    EdtRg: TMaskEdit;
    EdtNome: TEdit;
    DTDataNasc: TDateTimePicker;
    EdtEmail: TEdit;
    EdtCnpj: TMaskEdit;
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
    pCursos: TPanel;
    Label1: TLabel;
    BtnEditar: TSpeedButton;
    BtnClose: TSpeedButton;
    CLCursos: TCheckListBox;
    pHorario: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EdtDiaHorario: TComboBox;
    LVHorario: TListView;
    BtnCadHorario: TButton;
    ScrollBar: TScrollBar;
    BtnSave: TSpeedButton;
    EdtHoraInicio: TDateTimePicker;
    EdtHoraFim: TDateTimePicker;
    BtnDeleteHora: TButton;
    EdtCidade: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ScrollBarChange(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnCadHorarioClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure BtnDeleteHoraClick(Sender: TObject);
  private
    procedure CriaLista(pQuery: TFDQuery; pProfessor: TProfessor);
    procedure onlyread;
    procedure editable;
    procedure CreateProfessor;
    procedure CreateEndereco;
    procedure PreencherHorario(pLista: TList<TProfessor>);
    procedure CriaCB(Ds: TFDQuery; CB: TComboBox);
    procedure Obrigatory_edit;
    procedure Obrigatory_edit_clear;
  public
    procedure PreencherEditProfessor(pProfessor: TProfessor);
  end;

var
  FrmEditProfessor: TFrmEditProfessor;
  Professor: TProfessor;
  professorDAO: TProfessorDAO;
  endereco: TEndereco;
  enderecoDAO: TEnderecoDAO;
  cursoDAO: TCursoDAO;

implementation

{$R *.dfm}

uses uFrmListagem;
{ TFrmEditProfessor }

procedure TFrmEditProfessor.BtnEditarClick(Sender: TObject);
begin
  editable;
  BtnEditar.Hide;
  BtnSave.Show;
end;

procedure TFrmEditProfessor.BtnSaveClick(Sender: TObject);
begin
  CreateProfessor;

  professorDAO.EditProfessor(Professor);
  professorDAO.UpdateProfessor_curso(Professor);

  CriaLista(cursoDAO.ListaCurso, Professor);

  CreateEndereco;

  enderecoDAO.UpdateEndereco(endereco);

  Obrigatory_edit_clear;
  CriaCB(enderecoDAO.RetornaCidades, EdtCidade);
  onlyread;
  BtnSave.Hide;
  BtnEditar.Show;
end;

procedure TFrmEditProfessor.BtnDeleteHoraClick(Sender: TObject);
begin
  try
    if MessageDlg('Deseja deletar horário:' + #13 + #13 +
      LVHorario.Selected.Caption + ' ' + LVHorario.Selected.SubItems[0] + ' - '
      + LVHorario.Selected.SubItems[1], mtWarning, [mbYes, mbNo], 1) = mrYes
    then
    begin
      if professorDAO.Deletar_horario(LVHorario.ItemFocused.Data) = true then
      begin
        ShowMessage('Horario deletado com sucesso');
        PreencherHorario(professorDAO.ListarHorario(Professor));
      end
      else
      begin
        ShowMessage('Erro ao deleter horario');
        Abort;
      end;
    end;

  except
    ShowMessage('Selecione um horario para deletar');
    Abort;
  end;

end;

procedure TFrmEditProfessor.BtnCadHorarioClick(Sender: TObject);
var
  I: Integer;
  Linha: TProfessor;
begin
  Professor.HoraInicio := EdtHoraInicio.Time;
  Professor.HoraFim := EdtHoraFim.Time;
  Professor.Dia := EdtDiaHorario.Text;

  for I := 0 to LVHorario.Items.Count - 1 do // verificação
  begin
    Linha := LVHorario.Items[I].Data;

    if Linha.Dia = Professor.Dia then
    begin
      if (Linha.HoraInicio <= Professor.HoraInicio) and
        (Professor.HoraInicio <= Linha.HoraFim) then
      begin
        ShowMessage('Horario de início conflitante com outros horários');
        LVHorario.Items[I].Focused := true;
        Abort;
      end;

      if (Linha.HoraInicio <= Professor.HoraFim) and
        (Professor.HoraFim <= Linha.HoraFim) then
      begin
        ShowMessage('Horario final conflitante com outros horários');
        LVHorario.Items[I].Focused := true;
        Abort;
      end;

      if (Professor.HoraInicio < Linha.HoraInicio) and
        (Professor.HoraFim > Linha.HoraFim) then
      begin
        ShowMessage('Horario sobrepõe outros');
        Abort;
      end;
    end;

    if (Professor.HoraInicio > Professor.HoraFim) or
      (Professor.HoraInicio = Professor.HoraFim) then
    begin
      ShowMessage('Horarios conflitantes');
      Abort;
    end;

  end;

  if professorDAO.CadastroHorario(Professor) = true then
  begin
    PreencherHorario(professorDAO.ListarHorario(Professor));
    ShowMessage('Horário Cadastrado');
  end;
end;

procedure TFrmEditProfessor.BtnCloseClick(Sender: TObject);
begin
  Obrigatory_edit_clear;
  CriaCB(enderecoDAO.RetornaCidades, EdtCidade);
  Close;
end;

procedure TFrmEditProfessor.CreateEndereco;
begin

  if (EdtRua.Text = '') or (EdtBairro.Text = '') or (MECep.Text = '_____-___')
    or (EdtCidade.ItemIndex = -1) or (EdtNumero.Text = '') then
  begin
    MessageDlg('Erro ao editar endereco' + #13 + #13 +
      'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
    Obrigatory_edit;
    Abort
  end;

  endereco := TEndereco.Create;

  endereco.ID := Professor.IDEndereco;
  endereco.rua := EdtRua.Text;
  endereco.numero := StrToInt(EdtNumero.Text);
  endereco.cidade := EdtCidade.Text;
  endereco.bairro := EdtBairro.Text;
  endereco.cep := MECep.Text;

end;

procedure TFrmEditProfessor.CreateProfessor;
var
  I: Integer;
begin
  try
    if (EdtCnpj.Text = '__.___.___/____-__') or (EdtNome.Text = '') or
      (EdtCpf.Text = '___.___.___-__') or (EdtRg.Text = '') then
    begin
      MessageDlg('Erro ao editar professor' + #13 + #13 +
        'Certifique-se de preencher todos os dados', mtError, [mbok], 0);
      Obrigatory_edit;
      Abort
    end;

    Professor.Nome := EdtNome.Text;
    Professor.DataNasc := DTDataNasc.Date;
    Professor.CPF := EdtCpf.Text;
    Professor.Rg := EdtRg.Text;
    Professor.cnpj := EdtCnpj.Text;
    Professor.Contato := EdtContato.Text;
    Professor.Email := EdtEmail.Text;
    Professor.Tamanho := 0;

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
      MessageDlg('Erro ao cadastrar professor', mtError, [mbok], 0);
      Obrigatory_edit;
      Abort;
    end;

  except
    Obrigatory_edit;
    Abort
  end;
end;

procedure TFrmEditProfessor.CriaCB(Ds: TFDQuery; CB: TComboBox);
begin
  CB.Clear;
  while not(Ds.Eof) do
  begin
    CB.Items.Add(Ds.FieldByName('nome').AsString);

    Ds.Next;
  end;
  CB.ItemIndex := -1;
end;

procedure TFrmEditProfessor.CriaLista(pQuery: TFDQuery; pProfessor: TProfessor);
var
  I, Count: Integer;
begin
  Count := 0;
  CLCursos.Clear;
  while not pQuery.Eof do
  begin
    CLCursos.Items.Add(pQuery.FieldByName('nome').AsString);
    pQuery.Next;
  end;

  for I := 0 to CLCursos.Items.Count - 1 do
  begin
    for Count := 0 to pProfessor.Tamanho - 1 do
    begin
      if pProfessor.Cursos[Count] = CLCursos.Items[I] then
        CLCursos.State[I] := cbChecked;
    end;
  end;
end;

procedure TFrmEditProfessor.editable;
begin
  EdtContato.ReadOnly := False;
  EdtCpf.ReadOnly := False;
  EdtRg.ReadOnly := False;
  EdtNome.ReadOnly := False;
  EdtEmail.ReadOnly := False;
  EdtCnpj.ReadOnly := False;
  EdtRua.ReadOnly := False;
  EdtNumero.ReadOnly := False;
  EdtCidade.enabled := true;
  EdtBairro.ReadOnly := False;
  MECep.ReadOnly := False;
  EdtDiaHorario.enabled := true;
  DTDataNasc.enabled := true;
  EdtHoraFim.enabled := true;
  EdtHoraInicio.enabled := true;
  CLCursos.enabled := true;
  BtnCadHorario.Show;
  BtnDeleteHora.Show;
end;

procedure TFrmEditProfessor.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;
  ScrollBar.Position := 0;

  pCadProfessor.Height := 0;
  pCadProfessor.Height := pInfo.Height + pHorario.Height +
    pEndereçoProfessor.Height + pCursos.Height;
  ScrollBar.Max := pCadProfessor.Height - FrmEditProfessor.Height;

  Professor := TProfessor.Create;
  professorDAO := TProfessorDAO.Create;
  endereco := TEndereco.Create;
  enderecoDAO := TEnderecoDAO.Create;
  cursoDAO := TCursoDAO.Create;

  CriaCB(enderecoDAO.RetornaCidades, EdtCidade);

  onlyread;
end;

procedure TFrmEditProfessor.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(Professor) then
      FreeAndNil(Professor);

    if Assigned(professorDAO) then
      FreeAndNil(professorDAO);

    if Assigned(endereco) then
      FreeAndNil(endereco);

    if Assigned(enderecoDAO) then
      FreeAndNil(enderecoDAO);

    if Assigned(cursoDAO) then
      FreeAndNil(cursoDAO);

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmEditProfessor.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar.Position := ScrollBar.Position + 80;
end;

procedure TFrmEditProfessor.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar.Position := ScrollBar.Position - 80;
end;

procedure TFrmEditProfessor.Obrigatory_edit;
begin
  // professor
  EdtNome.SetFocus;
  ScrollBar.Position := 0;
  Nome.Font.Style := [FsBold];
  CPF.Font.Style := [FsBold];
  Rg.Font.Style := [FsBold];
  cnpj.Font.Style := [FsBold];
  DataDeNascimento.Font.Style := [FsBold];
  Contato.Font.Style := [FsBold];
  Email.Font.Style := [FsBold];
  // endereco
  rua.Font.Style := [FsBold];
  cep.Font.Style := [FsBold];
  bairro.Font.Style := [FsBold];
  cidade.Font.Style := [FsBold];
  numero.Font.Style := [FsBold];
end;

procedure TFrmEditProfessor.Obrigatory_edit_clear;
begin
  // professor
  EdtNome.SetFocus;
  ScrollBar.Position := 0;
  Nome.Font.Style := [];
  CPF.Font.Style := [];
  Rg.Font.Style := [];
  cnpj.Font.Style := [];
  DataDeNascimento.Font.Style := [];
  Contato.Font.Style := [];
  Email.Font.Style := [];
  // endereco
  rua.Font.Style := [];
  cep.Font.Style := [];
  bairro.Font.Style := [];
  cidade.Font.Style := [];
  numero.Font.Style := [];
end;

procedure TFrmEditProfessor.onlyread;
begin
  EdtContato.ReadOnly := true;
  EdtCpf.ReadOnly := true;
  EdtRg.ReadOnly := true;
  EdtNome.ReadOnly := true;
  EdtEmail.ReadOnly := true;
  EdtCnpj.ReadOnly := true;
  EdtRua.ReadOnly := true;
  EdtNumero.ReadOnly := true;
  EdtCidade.enabled := False;
  EdtBairro.ReadOnly := true;
  MECep.ReadOnly := true;
  EdtDiaHorario.enabled := False;
  DTDataNasc.enabled := False;
  EdtHoraFim.enabled := False;
  EdtHoraInicio.enabled := False;
  CLCursos.enabled := False;
  BtnCadHorario.Hide;
  BtnDeleteHora.Hide;
end;

procedure TFrmEditProfessor.PreencherEditProfessor(pProfessor: TProfessor);
var
  I: Integer;
begin
  Professor := professorDAO.RetornaProfessor(pProfessor);
  EdtNome.Text := Professor.Nome;
  EdtContato.Text := Professor.Contato;
  EdtCpf.Text := Professor.CPF;
  EdtRg.Text := Professor.Rg;
  EdtEmail.Text := Professor.Email;
  EdtCnpj.Text := Professor.cnpj;
  DTDataNasc.DateTime := Professor.DataNasc;

  endereco.ID := pProfessor.IDEndereco;
  endereco := enderecoDAO.RetornarEndereco(endereco);

  EdtRua.Text := endereco.rua;
  EdtNumero.Text := IntToStr(endereco.numero);
  EdtBairro.Text := endereco.bairro;
  MECep.Text := endereco.cep;

  for I := 0 to EdtCidade.Items.Count - 1 do
    if EdtCidade.Items[I] = endereco.cidade then
      EdtCidade.ItemIndex := I;

  PreencherHorario(professorDAO.ListarHorario(Professor));

  CriaLista(cursoDAO.ListaCurso, pProfessor);
end;

procedure TFrmEditProfessor.PreencherHorario(pLista: TList<TProfessor>);
var
  I: Integer;
  tempItem: TListItem;
begin
  try

    if Assigned(pLista) then
    begin
      LVHorario.Clear;

      for I := 0 to pLista.Count - 1 do
      begin
        tempItem := LVHorario.Items.Add;
        tempItem.Caption := TProfessor(pLista[I]).Dia;
        tempItem.SubItems.Add(FormatDateTime('HH:mm',
          TProfessor(pLista[I]).HoraInicio));
        tempItem.SubItems.Add(FormatDateTime('HH:mm',
          TProfessor(pLista[I]).HoraFim));
        tempItem.Data := TProfessor(pLista[I]);
      end;
    end;

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;

end;

procedure TFrmEditProfessor.ScrollBarChange(Sender: TObject);
begin
  pCadProfessor.top := -ScrollBar.Position;
end;

end.
