object FrmNovoCurso: TFrmNovoCurso
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Centro Musical Fascina'#231#227'o'
  ClientHeight = 393
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 24
    Width = 106
    Height = 25
    Caption = 'Novo Curso'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 72
    Top = 82
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 72
    Top = 174
    Width = 33
    Height = 13
    Caption = 'Sala(s)'
  end
  object Label4: TLabel
    Left = 72
    Top = 128
    Width = 27
    Height = 13
    Caption = 'Pre'#231'o'
  end
  object EdtNome: TEdit
    Left = 72
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object CLSalas: TCheckListBox
    Left = 72
    Top = 193
    Width = 121
    Height = 97
    ItemHeight = 13
    TabOrder = 2
  end
  object BtnCadastroCurso: TButton
    Left = 32
    Top = 320
    Width = 81
    Height = 42
    Caption = 'Cadastrar'
    TabOrder = 3
    OnClick = BtnCadastroCursoClick
  end
  object BtnCancelar: TButton
    Left = 160
    Top = 320
    Width = 81
    Height = 42
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = BtnCancelarClick
  end
  object EdtPreco: TEdit
    Left = 72
    Top = 147
    Width = 121
    Height = 21
    TabOrder = 1
  end
end
