unit uFrmListagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, uFrmCadAlunos, uFrmCadCurso,
  Vcl.Mask, uFrmCadProfessor, uProfessor, uProfessorDAO,
  System.Generics.Collections, uAluno, uAlunoDAO, uCurso, uCursoDAO,
  FireDac.Comp.Client, uFrmEditProfessor, uFrmCadAdm, uAdm, uAdmDAO,
  uFrmEditCurso, uFrmEditAdm, System.UITypes, uFrmEditAluno, uFrmCronograma;

type
  TFrmListar = class(TForm)
    PageControl1: TPageControl;
    TabAlunos: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    BtnCadastroAluno: TButton;
    BtnViewAluno: TButton;
    BtnDeleteAluno: TButton;
    LVAluno: TListView;
    EdtNomeAluno: TEdit;
    EdtEmailAluno: TEdit;
    EdtTelefoneAluno: TEdit;
    BtnSearch: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EdtCPFAluno: TMaskEdit;
    TabProfessores: TTabSheet;
    LVProfessor: TListView;
    Panel3: TPanel;
    BtnCadastroProfessor: TButton;
    BtnViewProfessor: TButton;
    BtnDeleteProfessor: TButton;
    Panel4: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EdtNomeProfessor: TEdit;
    EdtContatoProfessor: TEdit;
    BtnPesquisaProfessor: TButton;
    EdtCnpj: TMaskEdit;
    TabCursos: TTabSheet;
    LVCurso: TListView;
    Panel5: TPanel;
    BtnNovoCurso: TButton;
    BtnViewCurso: TButton;
    BtnExcluirCurso: TButton;
    Panel6: TPanel;
    Label10: TLabel;
    EdtNomeCurso: TEdit;
    PesquisaCurso: TButton;
    EdtCursoProfessor: TComboBox;
    EdtCursoAluno: TComboBox;
    BtnClearAluno: TButton;
    BtnClearProfessor: TButton;
    Funcionarios: TTabSheet;
    Panel7: TPanel;
    Panel8: TPanel;
    BtnCadAdm: TButton;
    BtnViewAdm: TButton;
    BtnExcluirAdm: TButton;
    LVAdm: TListView;
    BtnCLeanAdm: TButton;
    BtnPesquisarAdm: TButton;
    EdtCpfAdm: TMaskEdit;
    EdtEmailAdm: TEdit;
    EdtNomeAdm: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    EdtTelefoneAdm: TEdit;
    CBSala: TComboBox;
    Sala: TLabel;
    BrnClearCurso: TButton;
    Cronograma: TTabSheet;
    procedure BtnCadastroAlunoClick(Sender: TObject);
    procedure BtnCadastroProfessorClick(Sender: TObject);
    procedure BtnNovoCursoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnPesquisaProfessorClick(Sender: TObject);
    procedure PesquisaCursoClick(Sender: TObject);
    procedure PesquisaAdmClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnClearAlunoClick(Sender: TObject);
    procedure BtnClearAdmClick(Sender: TObject);
    procedure BtnClearProfessorClick(Sender: TObject);
    procedure BtnViewProfessorClick(Sender: TObject);
    procedure BtnCadastroAdmClick(Sender: TObject);
    procedure BtnViewCursoClick(Sender: TObject);
    procedure BtnViewAdmClick(Sender: TObject);
    procedure BtnExcluirAdmClick(Sender: TObject);
    procedure BtnExcluirCursoClick(Sender: TObject);
    procedure BtnViewAlunoClick(Sender: TObject);
    procedure BtnDeleteAlunoClick(Sender: TObject);
    procedure BtnDeleteProfessorClick(Sender: TObject);
    procedure LVAlunoDblClick(Sender: TObject);
    procedure BrnClearCursoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure LVProfessorDblClick(Sender: TObject);
    procedure LVCursoDblClick(Sender: TObject);
    procedure LVAdmDblClick(Sender: TObject);
  private
    procedure PreencherProfessor(pListaProfessor: TList<TProfessor>);
    procedure PreencherAluno(pListaAluno: TList<TAluno>);
    procedure PreencherAdm(pListaAdm: TList<Tadm>);
    function ListarCursosProfessor(pProfessor: TProfessor): String;
    function ListarCursosAluno(pAluno: TAluno): String;
    function ListarSalasCurso(pCurso: TCurso): String;
    procedure CriaCB(Ds: TFDQuery; CB: TComboBox);
    procedure PesquisarProfessor;
    procedure PesquisarAdm;
    procedure PesquisarAluno;
    procedure PesquisarCurso;
    procedure ViewAluno;
    procedure ViewProfessor;
    procedure ViewCurso;
    Procedure ViewAdm;
  public
    procedure PreencherCurso(pListaCurso: TList<TCurso>);
  end;

var
  FrmListar: TFrmListar;
  Professor: TProfessor;
  ProfessorDAO: TProfessorDAO;
  Aluno: TAluno;
  AlunoDAO: TAlunoDAO;
  Curso: TCurso;
  CursoDAO: TCursoDAO;
  Adm: Tadm;
  AdmDAO: TAdmDAO;

implementation

{$R *.dfm}

procedure TFrmListar.BtnViewAlunoClick(Sender: TObject);
begin
  ViewAluno;
end;

procedure TFrmListar.BtnCadastroAdmClick(Sender: TObject);
begin
  hide;
  FrmCadAdm.ShowModal;
  Show;
  PesquisarAdm;
end;

procedure TFrmListar.BtnCadastroAlunoClick(Sender: TObject);
begin
  hide;
  FrmCadAlunos.ShowModal;
  PesquisarAluno;
  Show;
end;

procedure TFrmListar.BtnCadastroProfessorClick(Sender: TObject);
begin
  hide;
  FrmCadProfessor.ShowModal;
  PesquisarProfessor;
  Show;

end;

procedure TFrmListar.BtnNovoCursoClick(Sender: TObject);
begin
  hide;
  FrmNovoCurso.ShowModal;
  PesquisarCurso;
  Show;
end;

procedure TFrmListar.BtnPesquisaProfessorClick(Sender: TObject);
begin
  PesquisarProfessor;
end;

procedure TFrmListar.BtnSearchClick(Sender: TObject);
begin
  PesquisarAluno;
end;

procedure TFrmListar.BtnViewProfessorClick(Sender: TObject);
begin
  ViewProfessor;
end;

procedure TFrmListar.Button1Click(Sender: TObject);
begin
  hide;
  FrmCronograma.ShowModal;
  Show;
end;

procedure TFrmListar.BrnClearCursoClick(Sender: TObject);
begin
  EdtNomeCurso.Clear;
  CBSala.Clear;

  PesquisarCurso;
end;

procedure TFrmListar.BtnExcluirAdmClick(Sender: TObject);
begin
  try
    if MessageDlg('Deseja deletar ' + LVAdm.Selected.Caption + '?', mtWarning,
      [mbYes, mbNo], 1) = mrYes then
    begin
      if AdmDAO.DeleteAdm(LVAdm.ItemFocused.Data) = true then
      begin
        MessageDlg(LVAdm.Selected.Caption + ' Deletado com sucesso',
          mtConfirmation, [mbOK], 0);
        PesquisarAdm;
      end
      else
      begin
        MessageDlg('Erro ao deletar funcionário', mtWarning, [mbOK], 0);
      end;
    end;
  except
    MessageDlg('Selecione um curso para deletar', mtWarning, [mbOK], 0);
  end;
end;

procedure TFrmListar.BtnViewAdmClick(Sender: TObject);
begin
  ViewAdm;
end;

procedure TFrmListar.BtnViewCursoClick(Sender: TObject);
begin
  ViewCurso;
end;

procedure TFrmListar.BtnClearProfessorClick(Sender: TObject);
begin
  EdtNomeProfessor.Clear;
  EdtContatoProfessor.Clear;
  EdtCnpj.Clear;
  EdtCursoProfessor.ItemIndex := -1;

  PesquisarProfessor;
end;

procedure TFrmListar.BtnDeleteAlunoClick(Sender: TObject);
begin
  try
    if MessageDlg('Deseja deletar ' + LVAluno.Selected.Caption + '?', mtWarning,
      [mbYes, mbNo], 1) = mrYes then
    begin
      if AlunoDAO.DeleteAluno(LVAluno.ItemFocused.Data) = true then
      begin
        MessageDlg(LVAluno.Selected.Caption + ' Deletado com sucesso',
          mtConfirmation, [mbOK], 0);
        PesquisarAluno;
      end
      else
      begin
        MessageDlg('Erro ao deletar aluno', mtWarning, [mbOK], 0);
      end;
    end;
  except
    MessageDlg('Selecione um curso para deletar', mtWarning, [mbOK], 0);
  end;
end;

procedure TFrmListar.BtnDeleteProfessorClick(Sender: TObject);
begin
  try
    if MessageDlg('Deseja deletar ' + LVProfessor.Selected.Caption + '?',
      mtWarning, [mbYes, mbNo], 1) = mrYes then
    begin
      if ProfessorDAO.DeleteProfessor(LVProfessor.ItemFocused.Data) = true then
      begin
        MessageDlg(LVProfessor.Selected.Caption + ' Deletado com sucesso',
          mtConfirmation, [mbOK], 0);
        PesquisarProfessor;
      end
      else
      begin
        MessageDlg('Erro ao deletar professor', mtWarning, [mbYes, mbNo], 1);
        abort;
      end;
    end;
  except
    MessageDlg('Selecione um aluno para deletar', mtWarning, [mbOK], 0);
  end;
end;

procedure TFrmListar.BtnExcluirCursoClick(Sender: TObject);
begin
  try
    if MessageDlg('deletar curso de ' + LVCurso.Selected.Caption + '?',
      mtWarning, [mbYes, mbNo], 1) = mrYes then
    begin
      if CursoDAO.DeletarCurso(LVCurso.ItemFocused.Data) = true then
      begin
        MessageDlg(LVCurso.Selected.Caption + ' Deletado com sucesso',
          mtConfirmation, [mbOK], 0);
        PreencherCurso(CursoDAO.PesquisaCurso(Curso));
        PreencherProfessor(ProfessorDAO.PesquisaProfessor(Professor));
        PreencherAluno(AlunoDAO.PesquisarAluno(Aluno));
      end
      else
      begin
        ShowMessage('Erro ao deletar curso');
        abort;
      end;
    end;

  except
    MessageDlg('Selecione um curso para deletar', mtWarning, [mbOK], 0);
  end;
end;

procedure TFrmListar.BtnClearAdmClick(Sender: TObject);
begin
  EdtNomeAdm.Clear;
  EdtCpfAdm.Clear;
  EdtTelefoneAdm.Clear;
  EdtEmailAdm.Clear;

  PesquisarAdm;
end;

procedure TFrmListar.BtnClearAlunoClick(Sender: TObject);
begin
  EdtNomeAluno.Clear;
  EdtEmailAluno.Clear;
  EdtTelefoneAluno.Clear;
  EdtCPFAluno.Clear;
  EdtCursoAluno.ItemIndex := -1;

  PesquisarAluno;
end;

Procedure TFrmListar.CriaCB(Ds: TFDQuery; CB: TComboBox);
begin
  CB.Clear;
  while not(Ds.Eof) do
  begin
    CB.Items.Add(Ds.FieldByName('nome').AsString);

    Ds.Next;
  end;
end;

procedure TFrmListar.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 4 then
  begin
    hide;
    FrmCronograma.ShowModal;
    Show;
    PageControl1.ActivePageIndex := 0;
  end;

end;

procedure TFrmListar.PesquisaAdmClick(Sender: TObject);
begin
  PesquisarAdm;
end;

procedure TFrmListar.PesquisaCursoClick(Sender: TObject);
begin
  PesquisarCurso;
end;

procedure TFrmListar.PesquisarAdm;
begin
  Adm.Nome := EdtNomeAdm.Text;
  Adm.Email := EdtEmailAdm.Text;
  if EdtCpfAdm.Text <> '   .   .   -  ' then
  begin
    Adm.Cpf := EdtCpfAdm.Text;
  end
  else
    Adm.Cpf := '';
  Adm.Contato := EdtTelefoneAdm.Text;

  PreencherAdm(AdmDAO.PesquisaAdm(Adm));
end;

procedure TFrmListar.PesquisarAluno;
begin
  Aluno.Nome := EdtNomeAluno.Text;
  Aluno.Email := EdtEmailAluno.Text;
  Aluno.Curso := EdtCursoAluno.Text;
  if EdtCPFAluno.Text <> '   .   .   -  ' then
  begin
    Aluno.Cpf := EdtCPFAluno.Text;
  end
  else
    Aluno.Cpf := '';
  Aluno.Contato := EdtTelefoneAluno.Text;

  PreencherAluno(AlunoDAO.PesquisarAluno(Aluno));
end;

procedure TFrmListar.PesquisarCurso;
begin
  Curso.Nome := EdtNomeCurso.Text;
  Curso.salas[0] := CBSala.Items[CBSala.ItemIndex];
  PreencherCurso(CursoDAO.PesquisaCurso(Curso));
end;

procedure TFrmListar.PesquisarProfessor;
begin
  Professor.Nome := EdtNomeProfessor.Text;
  if EdtCnpj.Text <> '  .   .   /    -  ' then
  begin
    Professor.CNPJ := EdtCnpj.Text;
  end
  else
    Professor.CNPJ := '';
  Professor.Contato := EdtContatoProfessor.Text;
  Professor.Curso := EdtCursoProfessor.Text;

  PreencherProfessor(ProfessorDAO.PesquisaProfessor(Professor));
end;

procedure TFrmListar.PreencherAdm(pListaAdm: TList<Tadm>);
var
  I: integer;
  tempItem: TListItem;
begin
  try

    if Assigned(pListaAdm) then
    begin
      LVAdm.Clear;

      for I := 0 to pListaAdm.Count - 1 do
      begin
        tempItem := LVAdm.Items.Add;
        tempItem.Caption := Tadm(pListaAdm[I]).Nome;
        tempItem.SubItems.Add(Tadm(pListaAdm[I]).Cpf);
        tempItem.SubItems.Add(Tadm(pListaAdm[I]).Email);
        tempItem.SubItems.Add(Tadm(pListaAdm[I]).Contato);
        tempItem.Data := Tadm(pListaAdm[I]);
      end;
    end;

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmListar.PreencherAluno(pListaAluno: TList<TAluno>);
var
  I: integer;
  tempItem: TListItem;
begin
  try

    if Assigned(pListaAluno) then
    begin
      LVAluno.Clear;

      for I := 0 to pListaAluno.Count - 1 do
      begin
        tempItem := LVAluno.Items.Add;
        tempItem.Caption := TAluno(pListaAluno[I]).Nome;
        tempItem.SubItems.Add(TAluno(pListaAluno[I]).Cpf);
        tempItem.SubItems.Add(ListarCursosAluno(TAluno(pListaAluno[I])));
        tempItem.SubItems.Add(TAluno(pListaAluno[I]).Contato);
        tempItem.Data := TAluno(pListaAluno[I]);
      end;
    end;

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmListar.PreencherCurso(pListaCurso: TList<TCurso>);
var
  I: integer;
  tempItem: TListItem;
begin
  try

    if Assigned(pListaCurso) then
    begin
      LVCurso.Clear;

      for I := 0 to pListaCurso.Count - 1 do
      begin
        tempItem := LVCurso.Items.Add;
        tempItem.Caption := TCurso(pListaCurso[I]).Nome;
        tempItem.SubItems.Add(CurrToStr(TCurso(pListaCurso[I]).Preco));
        tempItem.SubItems.Add(ListarSalasCurso(TCurso(pListaCurso[I])));
        tempItem.Data := TCurso(pListaCurso[I]);
      end;
    end
    else
      ShowMessage('Nenhum curso encontrado');

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmListar.PreencherProfessor(pListaProfessor: TList<TProfessor>);
var
  I: integer;
  tempItem: TListItem;
begin
  try

    if Assigned(pListaProfessor) then
    begin
      LVProfessor.Clear;

      for I := 0 to pListaProfessor.Count - 1 do
      begin
        tempItem := LVProfessor.Items.Add;
        tempItem.Caption := TProfessor(pListaProfessor[I]).Nome;
        tempItem.SubItems.Add(TProfessor(pListaProfessor[I]).CNPJ);
        tempItem.SubItems.Add
          (ListarCursosProfessor(TProfessor(pListaProfessor[I])));
        tempItem.SubItems.Add(TProfessor(pListaProfessor[I]).Contato);
        tempItem.Data := TProfessor(pListaProfessor[I]);
      end;
    end
    else
      ShowMessage('Nenhum professor encontrado');

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;


procedure TFrmListar.ViewAdm;
begin
  try
    FrmEdtAdm.PreencherEdits(LVAdm.ItemFocused.Data);
    FrmEdtAdm.ShowModal;
    PesquisarAdm;
  except
    MessageDlg('Selecione um funcionário', mtWarning, [mbOK], 0);
  end;
end;

procedure TFrmListar.ViewAluno;
begin
  try
    hide;
    FrmEditAluno.PreencherTela(LVAluno.ItemFocused.Data);
    FrmEditAluno.ShowModal;
    Show;
    PesquisarAluno;
  except
    On e: exception do
    begin
      MessageDlg('Selecione um aluno', mtWarning, [mbOK], 0);
      Show;
    end;
  end;
end;

procedure TFrmListar.ViewCurso;
begin
  try
    FrmEditarCurso.PreencherEdits(LVCurso.ItemFocused.Data);
    FrmEditarCurso.ShowModal;
    PesquisarCurso;
  except
    MessageDlg('Selecione um curso', mtWarning, [mbOK], 0);
  end;
end;

procedure TFrmListar.ViewProfessor;
begin
  try
    hide;
    FrmEditProfessor.PreencherEditProfessor(LVProfessor.ItemFocused.Data);
    FrmEditProfessor.ShowModal;
    Show;
    PesquisarProfessor;
  except
    MessageDlg('Selecione um professor', mtWarning, [mbOK], 0);
    Show;
  end;
end;

procedure TFrmListar.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  PageControl1.TabIndex := 0;

  Professor := TProfessor.Create;
  ProfessorDAO := TProfessorDAO.Create;
  Aluno := TAluno.Create;
  AlunoDAO := TAlunoDAO.Create;
  Curso := TCurso.Create;
  CursoDAO := TCursoDAO.Create;
  Adm := Tadm.Create;
  AdmDAO := TAdmDAO.Create;

  PreencherProfessor(ProfessorDAO.PesquisaProfessor(Professor));
  PreencherAluno(AlunoDAO.PesquisarAluno(Aluno));
  PreencherCurso(CursoDAO.PesquisaCurso(Curso));
  PreencherAdm(AdmDAO.PesquisaAdm(Adm));

  CriaCB(CursoDAO.ListaCurso, EdtCursoProfessor);
  CriaCB(CursoDAO.ListaCurso, EdtCursoAluno);
end;

procedure TFrmListar.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(Professor) then
      FreeAndNil(Professor);

    if Assigned(ProfessorDAO) then
      FreeAndNil(ProfessorDAO);

    if Assigned(Aluno) then
      FreeAndNil(Aluno);

    if Assigned(AlunoDAO) then
      FreeAndNil(AlunoDAO);

    if Assigned(Curso) then
      FreeAndNil(Curso);

    if Assigned(CursoDAO) then
      FreeAndNil(CursoDAO);

    if Assigned(Adm) then
      FreeAndNil(Adm);

    if Assigned(AdmDAO) then
      FreeAndNil(AdmDAO);

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

function TFrmListar.ListarCursosAluno(pAluno: TAluno): String;
var
  C: string;
  I: integer;
begin
  if pAluno.Tamanho = 0 then
  begin
    Result := '';
    exit;
  end;

  for I := 0 to pAluno.Tamanho - 2 do
  begin
    C := C + pAluno.Cursos[I] + ', ';
  end;
  C := C + pAluno.Cursos[pAluno.Tamanho - 1];
  Result := C;

end;

function TFrmListar.ListarCursosProfessor(pProfessor: TProfessor): String;
var
  C: string;
  I: integer;
begin
  for I := 0 to pProfessor.Tamanho - 2 do
  begin
    C := C + pProfessor.Cursos[I] + ', ';
  end;
  C := C + pProfessor.Cursos[pProfessor.Tamanho - 1];
  Result := C;
end;

function TFrmListar.ListarSalasCurso(pCurso: TCurso): String;
var
  C: string;
  I: integer;
begin
  for I := 0 to 4 do
  begin
    C := C + pCurso.salas[I];
    if pCurso.salas[I + 1] <> '' then
      C := C + ', '
  end;
  Result := C;
end;

procedure TFrmListar.LVAdmDblClick(Sender: TObject);
begin
  ViewAdm;
end;

procedure TFrmListar.LVAlunoDblClick(Sender: TObject);
begin
  ViewAluno;
end;

procedure TFrmListar.LVCursoDblClick(Sender: TObject);
begin
  ViewCurso;
end;

procedure TFrmListar.LVProfessorDblClick(Sender: TObject);
begin
  ViewProfessor;
end;

end.
