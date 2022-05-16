program Fascinação;

uses
  Vcl.Forms,
  uFrmLogin in 'Display\uFrmLogin.pas' {FrmLogin},
  uDM in 'DataBase\uDM.pas' {DM: TDataModule},
  uDAO in 'DAO\uDAO.pas',
  uAdm in 'Model\uAdm.pas',
  uAdmDAO in 'DAO\uAdmDAO.pas',
  uAluno in 'Model\uAluno.pas',
  uResponsavel in 'Model\uResponsavel.pas',
  uAlunoDAO in 'DAO\uAlunoDAO.pas',
  uEndereco in 'Model\uEndereco.pas',
  uFrmListagem in 'Display\uFrmListagem.pas' {FrmListar},
  uProfessorDAO in 'DAO\uProfessorDAO.pas',
  uProfessor in 'Model\uProfessor.pas',
  uCurso in 'Model\uCurso.pas',
  uSala in 'Model\uSala.pas',
  uFrmCadCurso in 'Cadastrar\uFrmCadCurso.pas' {FrmNovoCurso},
  uSalaDAO in 'DAO\uSalaDAO.pas',
  uCursoDAO in 'DAO\uCursoDAO.pas',
  uEnderecoDAO in 'DAO\uEnderecoDAO.pas',
  uFrmEditProfessor in 'Editable\uFrmEditProfessor.pas' {FrmEditProfessor},
  uFrmEditCurso in 'Editable\uFrmEditCurso.pas' {FrmEditarCurso},
  uFrmEditAdm in 'Editable\uFrmEditAdm.pas' {FrmEdtAdm},
  uAula in 'Model\uAula.pas',
  uAulaDAO in 'DAO\uAulaDAO.pas',
  uFrmEditAluno in 'Editable\uFrmEditAluno.pas' {FrmEditAluno},
  uFrmEditAula in 'Editable\uFrmEditAula.pas' {FrmAula},
  uFrmCadAdm in 'Cadastrar\uFrmCadAdm.pas' {FrmCadAdm},
  uFrmCadAlunos in 'Cadastrar\uFrmCadAlunos.pas' {FrmCadAlunos},
  uFrmCadProfessor in 'Cadastrar\uFrmCadProfessor.pas' {FrmCadProfessor},
  uFrmCronograma in 'Display\uFrmCronograma.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmListar, FrmListar);
  Application.CreateForm(TFrmCadProfessor, FrmCadProfessor);
  Application.CreateForm(TFrmNovoCurso, FrmNovoCurso);
  Application.CreateForm(TFrmEditProfessor, FrmEditProfessor);
  Application.CreateForm(TFrmEditarCurso, FrmEditarCurso);
  Application.CreateForm(TFrmEdtAdm, FrmEdtAdm);
  Application.CreateForm(TFrmEditAluno, FrmEditAluno);
  Application.CreateForm(TFrmAula, FrmAula);
  Application.CreateForm(TFrmCadAdm, FrmCadAdm);
  Application.CreateForm(TFrmCadAlunos, FrmCadAlunos);
  Application.CreateForm(TFrmCadProfessor, FrmCadProfessor);
  Application.CreateForm(TFrmCronograma, FrmCronograma);
  Application.Run;
end.
