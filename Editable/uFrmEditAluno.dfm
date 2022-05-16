object FrmEditAluno: TFrmEditAluno
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Centro Musical Fascina'#231#227'o'
  ClientHeight = 507
  ClientWidth = 759
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
  object pCadastroAluno: TPanel
    Left = 0
    Top = 0
    Width = 759
    Height = 985
    TabOrder = 0
    object pNovoAluno: TPanel
      Left = 1
      Top = 1
      Width = 757
      Height = 257
      Align = alTop
      TabOrder = 0
      object Label2: TLabel
        Left = 38
        Top = 22
        Width = 50
        Height = 24
        Caption = 'Aluno'
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
        Width = 33
        Height = 16
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
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
      object Label16: TLabel
        Left = 527
        Top = 111
        Width = 88
        Height = 13
        Caption = 'Contato Comercial'
      end
      object cpf: TLabel
        Left = 190
        Top = 169
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object Label18: TLabel
        Left = 341
        Top = 169
        Width = 14
        Height = 13
        Caption = 'RG'
      end
      object EdtContatoAluno: TEdit
        Left = 527
        Top = 81
        Width = 155
        Height = 21
        MaxLength = 25
        TabOrder = 5
      end
      object EdtCpfAluno: TMaskEdit
        Left = 190
        Top = 191
        Width = 109
        Height = 21
        EditMask = '!999.999.999-99;1;_'
        MaxLength = 14
        TabOrder = 3
        Text = '   .   .   -  '
      end
      object EdtNomeAluno: TEdit
        Left = 39
        Top = 81
        Width = 413
        Height = 21
        TabOrder = 0
      end
      object EdtContatoComAluno: TEdit
        Left = 527
        Top = 133
        Width = 155
        Height = 21
        MaxLength = 25
        TabOrder = 6
      end
      object DTDataNascAluno: TDateTimePicker
        Left = 39
        Top = 191
        Width = 111
        Height = 24
        Date = 36526.000000000000000000
        Time = 0.613717129628639700
        TabOrder = 2
      end
      object EdtEmailAluno: TEdit
        Left = 38
        Top = 138
        Width = 414
        Height = 21
        TabOrder = 1
      end
      object CBTemResponsavel: TCheckBox
        Left = 527
        Top = 193
        Width = 138
        Height = 17
        Caption = 'Tem respons'#225'vel'
        TabOrder = 7
        OnClick = CBTemResponsavelExit
        OnExit = CBTemResponsavelExit
      end
      object EdtRgAluno: TEdit
        Left = 341
        Top = 191
        Width = 111
        Height = 21
        TabOrder = 4
        TextHint = '00.000.000-0'
      end
    end
    object pResponsavelCad: TPanel
      Left = 1
      Top = 473
      Width = 757
      Height = 235
      Align = alTop
      TabOrder = 2
      Visible = False
      object Label1: TLabel
        Left = 42
        Top = 24
        Width = 111
        Height = 24
        Caption = 'Respons'#225'vel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object NomeResponsavel: TLabel
        Left = 42
        Top = 64
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object ContatoResponsavel: TLabel
        Left = 527
        Top = 64
        Width = 39
        Height = 13
        Caption = 'Contato'
      end
      object Label7: TLabel
        Left = 527
        Top = 137
        Width = 88
        Height = 13
        Caption = 'Contato Comercial'
      end
      object CPFResponsavel: TLabel
        Left = 190
        Top = 137
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object Label9: TLabel
        Left = 341
        Top = 137
        Width = 14
        Height = 13
        Caption = 'RG'
      end
      object Label10: TLabel
        Left = 42
        Top = 137
        Width = 95
        Height = 13
        Caption = 'Data de nascimento'
      end
      object EdtNomeResponsável: TEdit
        Left = 42
        Top = 86
        Width = 410
        Height = 21
        MaxLength = 100
        TabOrder = 0
      end
      object EdtContatoResponsavel: TEdit
        Left = 527
        Top = 86
        Width = 155
        Height = 21
        TabOrder = 4
      end
      object EdtContatoComResponsavel: TEdit
        Left = 527
        Top = 159
        Width = 155
        Height = 21
        TabOrder = 5
      end
      object EdtCpfResponsavel: TMaskEdit
        Left = 190
        Top = 159
        Width = 111
        Height = 21
        EditMask = '!999.999.999-99;1;_'
        MaxLength = 14
        TabOrder = 2
        Text = '   .   .   -  '
      end
      object EdtRgResponsavel: TMaskEdit
        Left = 341
        Top = 159
        Width = 111
        Height = 21
        MaxLength = 15
        TabOrder = 3
        Text = ''
        TextHint = '00.000.000-0'
      end
      object DTDataNascResponsavel: TDateTimePicker
        Left = 42
        Top = 159
        Width = 113
        Height = 24
        Date = 36526.000000000000000000
        Time = 0.722771087959699800
        TabOrder = 1
      end
    end
    object pEndereçoAluno: TPanel
      Left = 1
      Top = 258
      Width = 757
      Height = 215
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
        Top = 68
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
        MaxLength = 100
        TabOrder = 0
      end
      object EdtNumero: TEdit
        Left = 607
        Top = 87
        Width = 73
        Height = 21
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 2
      end
      object EdtBairro: TEdit
        Left = 324
        Top = 144
        Width = 213
        Height = 21
        MaxLength = 50
        TabOrder = 1
      end
      object MECep: TMaskEdit
        Left = 607
        Top = 145
        Width = 71
        Height = 21
        EditMask = '!99999-999;1;_'
        MaxLength = 9
        TabOrder = 3
        Text = '     -   '
      end
      object EdtCidade: TComboBox
        Left = 43
        Top = 144
        Width = 145
        Height = 21
        TabOrder = 4
      end
    end
    object pAula: TPanel
      Left = 1
      Top = 708
      Width = 757
      Height = 283
      Align = alTop
      Caption = 'pAula'
      ShowCaption = False
      TabOrder = 3
      object BtnSave: TSpeedButton
        Left = 45
        Top = 214
        Width = 98
        Height = 41
        Caption = 'Salvar '
        Visible = False
        OnClick = BtnSaveClick
      end
      object BtnCancel: TSpeedButton
        Left = 618
        Top = 214
        Width = 98
        Height = 41
        BiDiMode = bdLeftToRight
        Caption = 'Fechar'
        ParentBiDiMode = False
        OnClick = BtnCancelClick
      end
      object Label27: TLabel
        Left = 45
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
      object LVAulas: TListView
        Left = 45
        Top = 58
        Width = 529
        Height = 135
        Columns = <
          item
            Caption = 'Curso'
            Width = 130
          end
          item
            Caption = 'Professor'
            Width = 100
          end
          item
            Caption = 'Dia'
            Width = 80
          end
          item
            Caption = 'Hora'
            Width = 130
          end
          item
            Caption = 'Sala'
            Width = 80
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
      end
      object BtnCadAula: TButton
        Left = 618
        Top = 58
        Width = 98
        Height = 41
        Caption = 'Nova aula'
        TabOrder = 1
        OnClick = BtnCadAulaClick
      end
      object BtnDeleteAula: TButton
        Left = 618
        Top = 105
        Width = 98
        Height = 41
        Caption = 'Excluir aula'
        TabOrder = 2
        OnClick = BtnDeleteAulaClick
      end
      object BtnUpdateAula: TButton
        Left = 618
        Top = 152
        Width = 98
        Height = 41
        Caption = 'Editar Aula'
        TabOrder = 3
        OnClick = BtnUpdateAulaClick
      end
      object BtnEditar: TButton
        Left = 45
        Top = 214
        Width = 98
        Height = 41
        Caption = 'Editar'
        TabOrder = 4
        OnClick = BtnEditarClick
      end
    end
  end
  object ScrollBar: TScrollBar
    Left = 736
    Top = 0
    Width = 23
    Height = 507
    Align = alRight
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    OnChange = ScrollBarChange
  end
end
