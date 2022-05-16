unit uFrmCadCurso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, uCurso,
  Vcl.Mask, uSalaDAO, FireDac.Comp.client, ucursoDAO;

type
  TFrmNovoCurso = class(TForm)
    EdtNome: TEdit;
    CLSalas: TCheckListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BtnCadastroCurso: TButton;
    BtnCancelar: TButton;
    Label4: TLabel;
    EdtPreco: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure CriaCL(pQuery: TFDQuery);
    procedure BtnCadastroCursoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Procedure CreateCurso;
  public
    { Public declarations }
  end;

var
  FrmNovoCurso: TFrmNovoCurso;
  Curso: TCurso;
  SalaDAO: TSalaDAO;
  CursoDAO: TcursoDAO;

implementation

{$R *.dfm}
{ TForm2 }

procedure TFrmNovoCurso.BtnCadastroCursoClick(Sender: TObject);
var
  I: Integer;
begin

  CreateCurso;

  if CursoDAO.CadastraCurso(Curso) = true then
  begin

    if SalaDAO.CadastroCurso_sala(Curso) = false then
    begin
      showmessage('Erro ao cadastrar salas do curso');
      abort
    end;

    MessageDlg('Curso cadastrado com sucesso', mtConfirmation, [mbok], 0);

    EdtNome.Clear;
    EdtPreco.Clear;
    for I := 0 to CLSalas.Count-1 do
    if CLSalas.State[i] = cbChecked then
    CLSalas.State[i] := cbUnchecked;

    FrmNovoCurso.Close;

  end else
  begin
    MessageDlg('Erro ao Cadastrar curso', mtError, [mbok], 0);
    EdtNome.SetFocus;
    abort;
  end;

end;

procedure TFrmNovoCurso.BtnCancelarClick(Sender: TObject);
begin
  FrmNovoCurso.Close
end;

procedure TFrmNovoCurso.CreateCurso;
var
  I, count: Integer;

begin
  try
    if EdtNome.Text = '' then
    begin
      ShowMessage('Erro ao Cadastrar curso' + #13 + #13 +
      'Certifique-se de preencher todos os campos');
    abort
    end;


    count := 0;

    Curso := TCurso.Create;

    Curso.Nome := LowerCase(EdtNome.Text);
    Curso.Preco := StrToFloat(EdtPreco.Text);

    for I := 0 to CLSalas.Items.count - 1 do
    begin
      if CLSalas.State[I] = cbChecked then
      begin
        Curso.salas[count] := CLSalas.Items[I];
        count := count + 1
      end;
    end;

    if count = 0 then
    begin
      ShowMessage('Erro ao cadastrar curso' + #13 + #13 +
      'Certifique-se de preencher todos os campos');
    abort
    end;

  except

    ShowMessage('Erro ao Cadastrar curso' + #13 + #13 +
    'Certifique-se de preencher todos os campos');
    abort;
  end;

  Curso.Preco := StrToFloat(EdtPreco.Text);

end;

procedure TFrmNovoCurso.CriaCL(pQuery: TFDQuery);
begin
  CLSalas.Clear;
  while not pQuery.Eof do
  begin
    CLSalas.Items.Add(pQuery.FieldByName('nome').AsString);

    pQuery.Next;
  end;
end;

procedure TFrmNovoCurso.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  SalaDAO := TSalaDAO.Create;
  CriaCL(SalaDAO.ListaSala);

  CursoDAO := TcursoDAO.Create;

end;

procedure TFrmNovoCurso.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(SalaDAO) then
      FreeAndNil(SalaDAO);

    if Assigned(CursoDAO) then
      FreeAndNil(CursoDAO);

    if Assigned(Curso) then
      FreeAndNil(Curso);

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

end.
