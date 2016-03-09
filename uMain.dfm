object fMain: TfMain
  Left = 259
  Top = 212
  Width = 870
  Height = 640
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Snake'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 8
    Width = 37
    Height = 13
    Caption = 'Punkte:'
  end
  object timer: TTimer
    Interval = 100
    OnTimer = timerTimer
    Top = 48
  end
  object MainMenu: TMainMenu
    Left = 128
    Top = 112
    object mSnake: TMenuItem
      Caption = 'Snake'
      object Spielneustarten1: TMenuItem
        Caption = 'Spiel neu starten'
        OnClick = Spielneustarten1Click
      end
    end
  end
end
