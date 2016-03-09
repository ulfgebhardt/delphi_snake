unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls;

type
  TfMain = class(TForm)
    timer: TTimer;
    MainMenu: TMainMenu;
    mSnake: TMenuItem;
    Spielneustarten1: TMenuItem;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure StartGame;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure timerTimer(Sender: TObject);
    procedure Spielneustarten1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Points:Integer;
    Snake: array of TShape;
    Snakehor: Integer;
    Snakever: Integer;
    Dots: array of TShape;
    LastPosX:Integer;
    LastPosY:Integer;
  end;

var
  fMain: TfMain;

const
    SnakeHead = clBlue;

implementation

{$R *.dfm}

procedure TfMain.FormCreate(Sender: TObject);
begin

  Randomize;

  DoubleBuffered:=True;

  StartGame;

end;

procedure TfMain.StartGame;
var i:Integer;
begin

  Snakehor:= 1;
  Snakever:= 0;
  Points  := 0;
  for i:=0 to Length(Snake)-1 do Snake[i].Free;
  SetLength(Snake,0);
  for i:=0 to 2 do
    begin
    SetLength(Snake,Length(Snake)+1);
    Snake[Length(Snake)-1]:=TShape.create(fMain);
    Snake[Length(Snake)-1].Parent:=fMain;
    Snake[Length(Snake)-1].Shape:=stRoundRect;
    Snake[Length(Snake)-1].Width:=10;
    Snake[Length(Snake)-1].Height:=10;
    if i=0 then
       begin
       Snake[Length(Snake)-1].Top:=fMain.Height div 2;
       Snake[Length(Snake)-1].Left:=fMain.Width div 2;
       Snake[Length(Snake)-1].Brush.Color:=Snakehead;
       end else
         begin
         Snake[Length(Snake)-1].Top:=Snake[Length(Snake)-2].Top;
         Snake[Length(Snake)-1].Left:=Snake[Length(Snake)-2].Left-10;
         end;
    end;

  timer.Enabled:=True;  

end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = vk_up then
    begin
    Snakever:= -1;
    Snakehor:= 0;
    end;
  if Key = vk_down then
    begin
    Snakever:= 1;
    Snakehor:= 0;
    end;
  if Key = vk_left then
    begin
    Snakever:= 0;
    Snakehor:= -1;
    end;
  if Key = vk_right then
    begin
    Snakever:= 0;
    Snakehor:= 1;
    end;

end;

procedure TfMain.timerTimer(Sender: TObject);
var i,tempt,templ:Integer;
begin

  for i:=0 to length(Snake)-1 do
    begin
    if i=0 then
      begin
      LastPosY:=Snake[0].Top;
      LastPosX:=Snake[0].Left;
      Snake[0].Top:= Snake[0].Top + Snakever*Snake[0].Height;
      Snake[0].Left:= Snake[0].Left + Snakehor*Snake[0].Width;
      end else
        begin
        tempt:=Snake[i].Top;
        templ:=Snake[i].Left;
        Snake[i].Top:= LastPosY;
        Snake[i].Left:= LastPosX;
        LastPosY:=tempt;
        LastPosX:=templ;
        end;
    end;

  snake[0].BringToFront;  

  if Length(Dots)=0 then
    begin
    setlength(Dots,1);
    Dots[Length(Dots)-1]:=TShape.create(fMain);
    Dots[Length(Dots)-1].Parent:=fMain;
    Dots[Length(Dots)-1].Shape:=stCircle;
    Dots[Length(Dots)-1].Width:=7;
    Dots[Length(Dots)-1].Height:=7;
    Dots[Length(Dots)-1].Brush.Color:=clRed;
    Dots[Length(Dots)-1].Top:=40+Random(fMain.Height-180);
    Dots[Length(Dots)-1].Left:=40+Random(fMain.Width-80)
    end;

  //kollision

  //Wände
  if (Snake[0].left<0) then timer.Enabled:=False;
  if (Snake[0].Left+Snake[0].Width*2>fMain.Width) then timer.Enabled:=False;
  if (Snake[0].Top<10) then timer.Enabled:=False;
  if (Snake[0].Top+Snake[0].Height+60>fMain.Height) then timer.Enabled:=False;

  //Self
  for i:=1 to Length(Snake)-1 do
    if (Snake[0].Top=Snake[i].Top) and (Snake[0].Left=Snake[i].Left) then timer.Enabled:=False;

  //Dot
  if (Snake[0].Left+Snake[0].width>=Dots[0].Left) and (Snake[0].Left<=Dots[0].Left+Dots[0].Width) and (Snake[0].Top+Snake[0].Height>=Dots[0].Top) and (Snake[0].Top<=Dots[0].Top+Dots[0].Height) then
    begin
    Inc(Points,1000+random(1000));
    Dots[0].Free;
    SetLength(Dots,0);
    //Neues Schlangenglied
    SetLength(Snake,Length(Snake)+1);
    Snake[Length(Snake)-1]:=TShape.create(fMain);
    Snake[Length(Snake)-1].Parent:=fMain;
    Snake[Length(Snake)-1].Shape:=stRoundRect;
    Snake[Length(Snake)-1].Width:=10;
    Snake[Length(Snake)-1].Height:=10;
    Snake[Length(Snake)-1].Top:=LastPosY;
    Snake[Length(Snake)-1].Left:=LastPosX;
    end;


  Inc(Points,Random(2));

  label1.Caption:='Punkte: '+inttostr(Points);

end;

procedure TfMain.Spielneustarten1Click(Sender: TObject);
begin

  StartGame;

end;

end.
