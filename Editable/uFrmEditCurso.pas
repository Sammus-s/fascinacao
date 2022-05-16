unit uFrmEditCurso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, uCurso,
  uCursoDAO, usalaDAO, FireDac.Comp.Client;

type
  TFrmEditarCurso = class(TForm)
    BtnSave: TButton;
    BtnCancelar: TButton;
    CLSalas: TCheckListBox;
    EdtNome: TEdit;
    EdtPreco: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BtnEdit: TButton;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CriaCL(pQuery: TFDQuery);
  private
    procedure onlyRead;
    procedure editable;
    procedure Createcurso;

  public
    procedure PreencherEdits(pCurso: TCurso);
  end;

var
  FrmEditarCurso: TFrmEditarCurso;
  Curso: TCurso;
  CursoDAO: TCursoDAO;
  SalaDAO: TSalaDao;

implementation

{$R *.dfm}
{ TForm2 }

procedure TFrmEditarCurso.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmEditarCurso.BtnEditClick(Sender: TObject);
begin
  editable;
  BtnEdit.hide;
  BtnSave.Show;
end;

procedure TFrmEditarCurso.BtnSaveClick(Sender: TObject);
begin
  Createcurso;

  cursoDAO.UpdateCurso(curso);
  SalaDAO.UpdateSala_curso(curso);

  onlyRead;
  BtnSave.hide;
  BtnEdit.Show;
end;

procedure TFrmEditarCurso.Createcurso;
var
  I, count: Integer;

begin
  try
    if EdtNome.Text = '' then
    begin
      ShowMessage('Erro ao Editar curso' + #13 + #13 +
        'Certifique-se de preencher todos os campos');
      abort
    end;

    count := 0;

    curso.Nome := LowerCase(EdtNome.Text);
    curso.Preco := StrToFloat(EdtPreco.Text);

    for I := 0 to CLSalas.Items.count - 1 do
    begin
      if CLSalas.State[I] = cbChecked then
      begin
        curso.salas[count] := CLSalas.Items[I];
        count := count + 1
      end;
    end;

    if count = 0 then
    begin
      ShowMessage('Erro ao Editar curso' + #13 + #13 +
        'Certifique-se de preencher todos os campos');
      abort
    end;

  except

    ShowMessage('Erro ao Editar curso' + #13 + #13 +
      'Certifique-se de preencher todos os campos');
    abort
  end;
end;

procedure TFrmEditarCurso.CriaCL(pQuery: TFDQuery);
begin
  CLSalas.Clear;
  while not pQuery.Eof do
  begin
    CLSalas.Items.Add(pQuery.FieldByName('nome').AsString);

    pQuery.Next;
  end;
end;

procedure TFrmEditarCurso.editable;
begin
  EdtNome.ReadOnly := False;
  EdtPreco.ReadOnly := False;
  CLSalas.Enabled := True;
end;

procedure TFrmEditarCurso.FormCreate(Sender: TObject);
begin
  curso := TCurso.Create;
  cursoDAO := TCursoDAO.Create;
  SalaDAO := TSalaDao.Create;
end;

procedure TFrmEditarCurso.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(curso) then
      FreeAndNil(curso);

    if Assigned(cursoDAO) then
      FreeAndNil(cursoDAO);

    if Assigned(SalaDAO) then
      FreeAndNil(SalaDAO);

  except
    on e:exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TFrmEditarCurso.onlyRead;
begin
  EdtNome.ReadOnly := True;
  EdtPreco.ReadOnly := True;
  CLSalas.Enabled := False;
end;

procedure TFrmEditarCurso.PreencherEdits(pCurso: TCurso);
var
  I, count: Integer;
begin
  onlyRead;
  CriaCL(SalaDAO.ListaSAla);
  curso := pCurso;
  EdtNome.Text := pCurso.Nome;
  EdtPreco.Text := CurrToStr(pCurso.Preco);

  for I := 0 to CLSalas.Items.Count - 1 do
  begin
    for Count := 0 to 4 do
    begin
      if pCurso.salas[Count] = CLSalas.Items[I] then
        CLSalas.State[I] := cbChecked;
    end;
  end;
end;

end.
