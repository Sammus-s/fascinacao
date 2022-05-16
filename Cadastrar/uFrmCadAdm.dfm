object FrmCadAdm: TFrmCadAdm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Centro Musical Fascina'#231#227'o'
  ClientHeight = 481
  ClientWidth = 747
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
  object pEndereçoProfessor: TPanel
    Left = 0
    Top = 249
    Width = 747
    Height = 240
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 43
      Top = 26
      Width = 82
      Height = 24
      Caption = 'Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object rua: TLabel
      Left = 43
      Top = 65
      Width = 19
      Height = 13
      Caption = 'Rua'
    end
    object numero: TLabel
      Left = 607
      Top = 65
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object cidade: TLabel
      Left = 44
      Top = 122
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object bairro: TLabel
      Left = 324
      Top = 122
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object cep: TLabel
      Left = 607
      Top = 123
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object EdtRua: TEdit
      Left = 43
      Top = 87
      Width = 494
      Height = 21
      TabOrder = 0
    end
    object EdtNumero: TEdit
      Left = 607
      Top = 87
      Width = 73
      Height = 21
      NumbersOnly = True
      TabOrder = 1
    end
    object EdtBairro: TEdit
      Left = 324
      Top = 144
      Width = 213
      Height = 21
      TabOrder = 2
    end
    object MECep: TMaskEdit
      Left = 607
      Top = 142
      Width = 73
      Height = 21
      EditMask = '!99999-999;0;_'
      MaxLength = 9
      TabOrder = 3
      Text = ''
    end
    object BtnCadastrar: TButton
      Left = 44
      Top = 184
      Width = 91
      Height = 41
      Caption = 'Cadastrar'
      TabOrder = 4
      OnClick = BtnCadastrarClick
    end
    object BtnCancel: TButton
      Left = 591
      Top = 184
      Width = 91
      Height = 41
      Caption = 'Cancelar'
      TabOrder = 5
      OnClick = BtnCancelClick
    end
    object EdtCidade: TComboBox
      Left = 44
      Top = 142
      Width = 145
      Height = 21
      TabOrder = 6
    end
  end
  object pInfo: TPanel
    Left = 0
    Top = 0
    Width = 747
    Height = 249
    Align = alTop
    TabOrder = 1
    object Label2: TLabel
      Left = 38
      Top = 22
      Width = 102
      Height = 24
      Caption = 'Funcion'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 39
      Top = 168
      Width = 95
      Height = 13
      Caption = 'Data de nascimento'
    end
    object nome: TLabel
      Left = 39
      Top = 60
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label14: TLabel
      Left = 39
      Top = 116
      Width = 24
      Height = 13
      Caption = 'Email'
    end
    object Label15: TLabel
      Left = 527
      Top = 59
      Width = 39
      Height = 13
      Caption = 'Contato'
    end
    object user: TLabel
      Left = 527
      Top = 116
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
    end
    object cpf: TLabel
      Left = 190
      Top = 169
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object rg: TLabel
      Left = 341
      Top = 169
      Width = 14
      Height = 13
      Caption = 'RG'
    end
    object senha: TLabel
      Left = 527
      Top = 172
      Width = 30
      Height = 13
      Caption = 'Senha'
    end
    object EdtContato: TEdit
      Left = 527
      Top = 81
      Width = 155
      Height = 21
      TabOrder = 5
    end
    object EdtCpf: TMaskEdit
      Left = 190
      Top = 191
      Width = 107
      Height = 21
      EditMask = '!000.000.000-00;1;_'
      MaxLength = 14
      TabOrder = 4
      Text = '   .   .   -  '
    end
    object EdtRg: TMaskEdit
      Left = 341
      Top = 191
      Width = 111
      Height = 21
      TabOrder = 3
      Text = ''
      TextHint = '00.000.000-0'
    end
    object EdtNome: TEdit
      Left = 39
      Top = 81
      Width = 413
      Height = 21
      TabOrder = 0
    end
    object DTDataNasc: TDateTimePicker
      Left = 39
      Top = 191
      Width = 111
      Height = 24
      Date = 36526.000000000000000000
      Time = 0.613717129628639700
      TabOrder = 2
    end
    object EdtEmail: TEdit
      Left = 38
      Top = 138
      Width = 414
      Height = 21
      TabOrder = 1
    end
    object EdtUser: TEdit
      Left = 527
      Top = 138
      Width = 155
      Height = 21
      TabOrder = 6
      OnKeyPress = EdtUserKeyPress
    end
    object EdtPassw: TEdit
      Left = 527
      Top = 191
      Width = 155
      Height = 21
      TabOrder = 7
      OnKeyPress = EdtUserKeyPress
    end
  end
end
