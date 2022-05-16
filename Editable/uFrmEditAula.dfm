object FrmAula: TFrmAula
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Centro Musical Fascina'#231#227'o'
  ClientHeight = 273
  ClientWidth = 736
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
  object pAula: TPanel
    Left = 0
    Top = 0
    Width = 736
    Height = 283
    Align = alTop
    Caption = 'pAula'
    ShowCaption = False
    TabOrder = 0
    object BtnCadastrar: TSpeedButton
      Left = 29
      Top = 216
      Width = 98
      Height = 41
      Caption = 'Cadastrar'
      OnClick = BtnCadastrarClick
    end
    object BtnCancel: TSpeedButton
      Left = 602
      Top = 216
      Width = 98
      Height = 41
      Caption = 'Fechar'
      OnClick = BtnCancelClick
    end
    object Label27: TLabel
      Left = 29
      Top = 28
      Width = 39
      Height = 24
      Caption = 'Aula'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Panel1: TPanel
      Left = 29
      Top = 58
      Width = 204
      Height = 143
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      object Label5: TLabel
        Left = 17
        Top = 48
        Width = 28
        Height = 13
        Caption = 'Curso'
      end
      object CBCurso: TComboBox
        Left = 17
        Top = 67
        Width = 145
        Height = 21
        TabOrder = 0
        OnChange = CBCursoChange
      end
    end
    object Panel2: TPanel
      Left = 251
      Top = 55
      Width = 222
      Height = 146
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 1
      object Label24: TLabel
        Left = 41
        Top = 29
        Width = 15
        Height = 13
        Caption = 'Dia'
      end
      object Label26: TLabel
        Left = 41
        Top = 77
        Width = 23
        Height = 13
        Caption = 'Hora'
      end
      object CBDia: TComboBox
        Left = 41
        Top = 48
        Width = 145
        Height = 21
        TabOrder = 0
        Items.Strings = (
          'Segunda'
          'Ter'#231'a'
          'Quarta'
          'Quinta'
          'Sexta'
          'S'#225'bado')
      end
      object DThora: TDateTimePicker
        Left = 41
        Top = 96
        Width = 84
        Height = 21
        Date = 44161.000000000000000000
        Format = 'HH:mm'
        Time = 44161.000000000000000000
        Kind = dtkTime
        TabOrder = 1
      end
    end
    object Panel3: TPanel
      Left = 488
      Top = 56
      Width = 212
      Height = 145
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 2
      object Label25: TLabel
        Left = 33
        Top = 74
        Width = 20
        Height = 13
        Caption = 'Sala'
      end
      object Label11: TLabel
        Left = 35
        Top = 25
        Width = 46
        Height = 13
        Caption = 'Professor'
      end
      object CBSala: TComboBox
        Left = 32
        Top = 93
        Width = 153
        Height = 21
        TabOrder = 1
      end
      object CBProfessor: TComboBox
        Left = 32
        Top = 47
        Width = 153
        Height = 21
        TabOrder = 0
      end
    end
    object BtnSave: TButton
      Left = 29
      Top = 216
      Width = 98
      Height = 41
      Caption = 'Salvar'
      TabOrder = 4
      Visible = False
      OnClick = BtnSaveClick
    end
    object BtnEdit: TButton
      Left = 29
      Top = 216
      Width = 98
      Height = 41
      Caption = 'Editar'
      TabOrder = 3
      Visible = False
      OnClick = BtnEditClick
    end
  end
end
