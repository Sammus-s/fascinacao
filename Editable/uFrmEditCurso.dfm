object FrmEditarCurso: TFrmEditarCurso
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Centro Musical Fascina'#231#227'o'
  ClientHeight = 383
  ClientWidth = 261
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
    Width = 53
    Height = 25
    Caption = 'Curso'
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
  object BtnSave: TButton
    Left = 32
    Top = 320
    Width = 81
    Height = 42
    Caption = 'Salvar'
    TabOrder = 0
    Visible = False
    OnClick = BtnSaveClick
  end
  object BtnCancelar: TButton
    Left = 160
    Top = 320
    Width = 81
    Height = 42
    Caption = 'Fechar'
    TabOrder = 1
    OnClick = BtnCancelarClick
  end
  object CLSalas: TCheckListBox
    Left = 72
    Top = 193
    Width = 121
    Height = 97
    ItemHeight = 13
    TabOrder = 2
  end
  object EdtNome: TEdit
    Left = 72
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object EdtPreco: TEdit
    Left = 72
    Top = 147
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object BtnEdit: TButton
    Left = 32
    Top = 320
    Width = 81
    Height = 42
    Caption = 'Editar'
    TabOrder = 5
    OnClick = BtnEditClick
  end
end
