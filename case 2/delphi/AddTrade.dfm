object frmAddTrade: TfrmAddTrade
  Left = 0
  Top = 0
  Caption = 'Add Trade'
  ClientHeight = 208
  ClientWidth = 202
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblSymbol: TLabel
    Left = 17
    Top = 47
    Width = 32
    Height = 13
    Caption = 'S&tock'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblQuantity: TLabel
    Left = 17
    Top = 77
    Width = 42
    Height = 13
    Caption = '&Volume'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPrice: TLabel
    Left = 17
    Top = 103
    Width = 28
    Height = 13
    Caption = '&Price'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DownLine: TShape
    Left = 9
    Top = 157
    Width = 181
    Height = 1
  end
  object lblSide: TLabel
    Left = 17
    Top = 20
    Width = 24
    Height = 13
    Caption = '&Side'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ValLabel: TLabel
    Left = 78
    Top = 131
    Width = 22
    Height = 13
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblValue: TLabel
    Left = 16
    Top = 131
    Width = 31
    Height = 13
    Caption = 'Value'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnClose: TButton
    Left = 17
    Top = 165
    Width = 80
    Height = 23
    BiDiMode = bdLeftToRight
    Cancel = True
    Caption = '&Close'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object btnSend: TButton
    Left = 104
    Top = 165
    Width = 80
    Height = 23
    Caption = 'Send'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnSendClick
  end
  object edtSymbol: TEdit
    Left = 78
    Top = 45
    Width = 106
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
  end
  object cmbSide: TComboBox
    Left = 78
    Top = 17
    Width = 106
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 3
    Text = 'BUY'
    TextHint = 'Side'
    Items.Strings = (
      'BUY'
      'SELL')
  end
  object edtQuantity: TEdit
    Left = 78
    Top = 74
    Width = 106
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
    OnChange = edtQuantityChange
    OnKeyPress = edtQuantityKeyPress
  end
  object edtPrice: TEdit
    Left = 78
    Top = 101
    Width = 106
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
    Text = '0.00'
    TextHint = '0.00'
    OnChange = edtPriceChange
    OnKeyPress = edtPriceKeyPress
  end
end
