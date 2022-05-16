object FrmEditProfessor: TFrmEditProfessor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Centro musical fascina'#231#227'o'
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
      object Nome: TLabel
        Left = 39
        Top = 60
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Email: TLabel
        Left = 39
        Top = 116
        Width = 24
        Height = 13
        Caption = 'Email'
      end
      object Contato: TLabel
        Left = 527
        Top = 59
        Width = 39
        Height = 13
        Caption = 'Contato'
      end
      object cnpj: TLabel
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
      object Rg: TLabel
        Left = 341
        Top = 172
        Width = 14
        Height = 13
        Caption = 'RG'
      end
      object EdtContato: TEdit
        Left = 527
        Top = 81
        Width = 155
        Height = 21
        TabOrder = 0
      end
      object EdtCpf: TMaskEdit
        Left = 190
        Top = 191
        Width = 109
        Height = 21
        EditMask = '!000.000.000-00;0;_'
        MaxLength = 14
        TabOrder = 1
        Text = ''
      end
      object EdtRg: TMaskEdit
        Left = 341
        Top = 191
        Width = 111
        Height = 21
        TabOrder = 2
        Text = ''
        TextHint = '00.000.000-0'
      end
      object EdtNome: TEdit
        Left = 39
        Top = 81
        Width = 413
        Height = 21
        TabOrder = 3
      end
      object DTDataNasc: TDateTimePicker
        Left = 39
        Top = 191
        Width = 111
        Height = 24
        Date = 36526.000000000000000000
        Time = 0.613717129628639700
        TabOrder = 4
      end
      object EdtEmail: TEdit
        Left = 38
        Top = 138
        Width = 414
        Height = 21
        TabOrder = 5
      end
      object EdtCnpj: TMaskEdit
        Left = 526
        Top = 130
        Width = 109
        Height = 21
        EditMask = '!00.000.000/0000-00;1;_'
        MaxLength = 18
        TabOrder = 6
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
        Left = 44
        Top = 145
        Width = 145
        Height = 21
        TabOrder = 4
      end
    end
    object pCursos: TPanel
      Left = 1
      Top = 722
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
      object BtnEditar: TSpeedButton
        Left = 39
        Top = 255
        Width = 98
        Height = 41
        Caption = 'Editar'
        OnClick = BtnEditarClick
      end
      object BtnClose: TSpeedButton
        Left = 584
        Top = 256
        Width = 98
        Height = 41
        Caption = 'Fechar'
        OnClick = BtnCloseClick
      end
      object BtnSave: TSpeedButton
        Left = 39
        Top = 256
        Width = 98
        Height = 40
        Caption = 'Salvar'
        Visible = False
        OnClick = BtnSaveClick
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
    end
    object pHorario: TPanel
      Left = 1
      Top = 465
      Width = 742
      Height = 257
      Align = alTop
      Caption = '465'
      ShowCaption = False
      TabOrder = 3
      object Label4: TLabel
        Left = 50
        Top = 53
        Width = 219
        Height = 16
        Caption = 'O professor n'#227'o estar'#225' disponivel em:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 409
        Top = 72
        Width = 18
        Height = 16
        Caption = 'Dia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 409
        Top = 134
        Width = 30
        Height = 16
        Caption = 'In'#237'cio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 409
        Top = 191
        Width = 21
        Height = 16
        Caption = 'Fim'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 18
        Top = 16
        Width = 180
        Height = 23
        Caption = 'Hor'#225'rios indispon'#237'veis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object EdtDiaHorario: TComboBox
        Left = 409
        Top = 91
        Width = 129
        Height = 21
        TabOrder = 0
        Text = 'Segunda'
        Items.Strings = (
          'Segunda'
          'Ter'#231'a'
          'Quarta'
          'Quinta'
          'Sexta'
          'S'#225'bado')
      end
      object LVHorario: TListView
        Left = 50
        Top = 73
        Width = 250
        Height = 166
        Columns = <
          item
            AutoSize = True
            Caption = 'Dia'
          end
          item
            AutoSize = True
            Caption = 'In'#237'cio'
          end
          item
            AutoSize = True
            Caption = 'Fim'
          end>
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
      object BtnCadHorario: TButton
        Left = 600
        Top = 196
        Width = 105
        Height = 43
        Caption = 'Cadastrar Horario'
        TabOrder = 2
        OnClick = BtnCadHorarioClick
      end
      object EdtHoraInicio: TDateTimePicker
        Left = 409
        Top = 156
        Width = 129
        Height = 21
        Date = 44154.000000000000000000
        Format = 'HH:mm'
        Time = 44154.000000000000000000
        Kind = dtkTime
        TabOrder = 3
      end
      object EdtHoraFim: TDateTimePicker
        Left = 408
        Top = 213
        Width = 130
        Height = 21
        Date = 44154.000000000000000000
        Format = 'HH:mm'
        Time = 44154.000000000000000000
        Kind = dtkTime
        TabOrder = 4
      end
      object BtnDeleteHora: TButton
        Left = 600
        Top = 69
        Width = 105
        Height = 43
        Caption = 'Deletar Horario'
        TabOrder = 5
        OnClick = BtnDeleteHoraClick
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
