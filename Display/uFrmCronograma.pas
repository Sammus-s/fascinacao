unit uFrmCronograma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, uAulaDAO, uFrmEditAula, uAula;

type
  TFrmCronograma = class(TForm)
    PageControl: TPageControl;
    Segunda: TTabSheet;
    Terca: TTabSheet;
    Quarta: TTabSheet;
    Quinta: TTabSheet;
    Sexta: TTabSheet;
    Sabado: TTabSheet;
    PHorario_seg: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    pSalas_seg: TPanel;
    pHorario_sab: TPanel;
    pSala_sab: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    PHorario_qui: TPanel;
    PSalas_qui: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    PHorario_qua: TPanel;
    PSalas_qua: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    pHorario_sex: TPanel;
    PSalas_sex: TPanel;
    Panel29: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    Panel33: TPanel;
    PHorario_ter: TPanel;
    PSalas_ter: TPanel;
    Panel36: TPanel;
    Panel37: TPanel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel40: TPanel;
    Beatles_sab: TPanel;
    Elvis_sab: TPanel;
    Oasis_sab: TPanel;
    Mundo_sab: TPanel;
    Estudio_sab: TPanel;
    Beatles_qui: TPanel;
    Elvis_qui: TPanel;
    Oasis_qui: TPanel;
    Mundo_qui: TPanel;
    Estudio_qui: TPanel;
    Beatles_ter: TPanel;
    Elvis_ter: TPanel;
    Oasis_ter: TPanel;
    Mundo_ter: TPanel;
    Estudio_ter: TPanel;
    Beatles_seg: TPanel;
    Elvis_seg: TPanel;
    Oasis_seg: TPanel;
    Mundo_seg: TPanel;
    Estudio_seg: TPanel;
    Beatles_qua: TPanel;
    Elvis_qua: TPanel;
    Oasis_qua: TPanel;
    Mundo_qua: TPanel;
    Estudio_qua: TPanel;
    Beatles_sex: TPanel;
    Elvis_sex: TPanel;
    Oasis_sex: TPanel;
    Mundo_sex: TPanel;
    Estudio_sex: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AulaClick(Sender: TObject);
  private
    procedure Display_horario(pPanel: TPanel);

    procedure UpdateCronograma;
  public
    { Public declarations }
  end;

var
  FrmCronograma: TFrmCronograma;
  AulaDAO: TAulaDAO;

implementation

{$R *.dfm}

procedure TFrmCronograma.AulaClick(Sender: TObject);
var Aula : TAula;
begin
  Aula := TAula.Create;
  Aula.id := StrToInt(TPanel(Sender).Caption);
  Aula := AulaDAO.RetornaAula(Aula);

  FrmAula.EditAula(Aula);
  FrmAula.ShowModal;
  UpdateCronograma;
end;

procedure TFrmCronograma.Display_horario(pPanel: TPanel);
var
  L: Tlabel;
  I, Top: integer;
  text: string;
begin
  text := '09:00';
  Top := 15;
  for I := 0 to 9 do
  begin
    L := Tlabel.Create(pPanel);
    L.Parent := pPanel;
    L.Top := Top;
    L.Left := 22;
    L.Caption := text;
    Top := Round(Top + pPanel.Height / 10);
    text := FormatDateTime('HH:mm', StrToTime(text) + StrToTime('01:00'));
  end;

end;

procedure TFrmCronograma.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  AulaDAO := TAulaDAO.Create;

  if dayofweek(now) < 2 then
  PageControl.TabIndex := 2
  else
  PageControl.TabIndex := dayofweek(now) - 2;
  Display_horario(PHorario_seg);
  Display_horario(PHorario_ter);
  Display_horario(PHorario_qua);
  Display_horario(PHorario_qui);
  Display_horario(pHorario_sex);
  Display_horario(pHorario_sab);

  UpdateCronograma;
end;

procedure TFrmCronograma.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(AulaDAO) then
      FreeAndNil(AulaDAO);
  except
    on E: exception do
      raise exception.Create(E.Message);
  end;
end;

procedure TFrmCronograma.FormShow(Sender: TObject);
var
  I: integer;
begin
  UpdateCronograma;
end;

procedure TFrmCronograma.UpdateCronograma;
begin
  AulaDAO.CriaAula(Beatles_seg, 'Segunda', 'beatles');
  AulaDAO.CriaAula(Elvis_seg, 'Segunda', 'elvis');
  AulaDAO.CriaAula(Oasis_seg, 'Segunda', 'oasis');
  AulaDAO.CriaAula(Mundo_seg, 'Segunda', 'mundo bita');
  AulaDAO.CriaAula(Estudio_seg, 'Segunda', 'estúdio');

  AulaDAO.CriaAula(Beatles_ter, 'Terça', 'beatles');
  AulaDAO.CriaAula(Elvis_ter, 'Terça', 'elvis');
  AulaDAO.CriaAula(Oasis_ter, 'Terça', 'oasis');
  AulaDAO.CriaAula(Mundo_ter, 'Terça', 'mundo bita');
  AulaDAO.CriaAula(Estudio_ter, 'Terça', 'estúdio');

  AulaDAO.CriaAula(Beatles_qua, 'Quarta', 'beatles');
  AulaDAO.CriaAula(Elvis_qua, 'Quarta', 'elvis');
  AulaDAO.CriaAula(Oasis_qua, 'Quarta', 'oasis');
  AulaDAO.CriaAula(Mundo_qua, 'Quarta', 'mundo bita');
  AulaDAO.CriaAula(Estudio_qua, 'Quarta', 'estúdio');

  AulaDAO.CriaAula(Beatles_qui, 'Quinta', 'beatles');
  AulaDAO.CriaAula(Elvis_qui, 'Quinta', 'elvis');
  AulaDAO.CriaAula(Oasis_qui, 'Quinta', 'oasis');
  AulaDAO.CriaAula(Mundo_qui, 'Quinta', 'mundo bita');
  AulaDAO.CriaAula(Estudio_qui, 'Quinta', 'estúdio');

  AulaDAO.CriaAula(Beatles_sex, 'Sexta', 'beatles');
  AulaDAO.CriaAula(Elvis_sex, 'Sexta', 'elvis');
  AulaDAO.CriaAula(Oasis_sex, 'Sexta', 'oasis');
  AulaDAO.CriaAula(Mundo_sex, 'Sexta', 'mundo bita');
  AulaDAO.CriaAula(Estudio_sex, 'Sexta', 'estúdio');

  AulaDAO.CriaAula(Beatles_sab, 'Sábado', 'beatles');
  AulaDAO.CriaAula(Elvis_sab, 'Sábado', 'elvis');
  AulaDAO.CriaAula(Oasis_sab, 'Sábado', 'oasis');
  AulaDAO.CriaAula(Mundo_sab, 'Sábado', 'mundo bita');
  AulaDAO.CriaAula(Estudio_sab, 'Sábado', 'estúdio');
end;

end.
