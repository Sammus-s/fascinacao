object FrmCadProfessor: TFrmCadProfessor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Centro musical Fascinacao '
  ClientHeight = 458
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
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object pCadProfessor: TPanel
    Left = 0
    Top = 0
    Width = 744
    Height = 1018
    TabOrder = 0
    object pInfo: TPanel
      Left = 1
      Top = 1
      Width = 742
      Height = 257
      Align = alTop
      TabOrder = 0
      object Label2: TLabel
        Left = 38
        Top = 22
        Width = 82
        Height = 24
        Caption = 'Professor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object DataDeNascimento: TLabel
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
      object email: TLabel
        Left = 39
        Top = 116
        Width = 24
        Height = 13
        Caption = 'Email'
      end
      object contato: TLabel
        Left = 527
        Top = 59
        Width = 39
        Height = 13
        Caption = 'Contato'
      end
      object CNPJ: TLabel
        Left = 527
        Top = 111
        Width = 25
        Height = 13
        Caption = 'CNPJ'
      end
      object CPF: TLabel
        Left = 190
        Top = 169
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object RG: TLabel
        Left = 341
        Top = 169
        Width = 14
        Height = 13
        Caption = 'RG'
      end
      object EdtContato: TEdit
        Left = 527
        Top = 81
        Width = 155
        Height = 21
        TabOrder = 6
      end
      object EdtCpf: TMaskEdit
        Left = 190
        Top = 191
        Width = 109
        Height = 21
        EditMask = '!000.000.000-00;0;_'
        MaxLength = 14
        TabOrder = 4
        Text = ''
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
      object EdtCnpj: TMaskEdit
        Left = 526
        Top = 130
        Width = 109
        Height = 21
        EditMask = '!00.000.000/0000-00;1;_'
        MaxLength = 18
        TabOrder = 5
        Text = '  .   .   /    -  '
      end
    end
    object pEndereçoProfessor: TPanel
      Left = 1
      Top = 258
      Width = 742
      Height = 207
      Align = alTop
      TabOrder = 1
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
        Top = 145
        Width = 73
        Height = 21
        EditMask = '!99999-999;0;_'
        MaxLength = 9
        TabOrder = 3
        Text = ''
      end
      object EdtCidade: TComboBox
        Left = 43
        Top = 144
        Width = 145
        Height = 21
        TabOrder = 4
      end
    end
    object pCursos: TPanel
      Left = 1
      Top = 465
      Width = 742
      Height = 348
      Align = alTop
      Caption = 'pCursos'
      ShowCaption = False
      TabOrder = 2
      object Label1: TLabel
        Left = 39
        Top = 11
        Width = 59
        Height = 24
        Caption = 'Cursos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object BtnCadastrar: TSpeedButton
        Left = 39
        Top = 255
        Width = 98
        Height = 41
        Caption = 'Cadastrar'
        OnClick = BtnCadastrarClick
      end
      object BtnCancel: TSpeedButton
        Left = 190
        Top = 255
        Width = 98
        Height = 41
        Caption = 'Cancelar'
        OnClick = BtnCancelClick
      end
      object CLCursos: TCheckListBox
        Left = 39
        Top = 41
        Width = 643
        Height = 198
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 24
        ParentFont = False
        TabOrder = 0
      end
      object BtnNewCourse: TButton
        Left = 582
        Top = 255
        Width = 98
        Height = 41
        Caption = 'Novo Curso'
        TabOrder = 1
        OnClick = BtnNewCourseClick
      end
    end
  end
  object ScrollBar: TScrollBar
    Left = 728
    Top = 0
    Width = 19
    Height = 458
    Align = alRight
    Kind = sbVertical
    Max = 297
    PageSize = 0
    TabOrder = 1
    OnChange = ScrollBarChange
  end
end
