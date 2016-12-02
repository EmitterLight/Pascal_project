unit u_reminder;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, uplaysound, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    playsound: Tplaysound;
    SetBtn: TButton;
    ClrBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    procedure ClrBtnClick(Sender: TObject);
    procedure SetBtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  t, t1, hs, ms, sumT, resT, h1, h2: TTime;
  h, m, s: integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Label2.Caption:='Текущее время:    ' + timetostr(time);
  Label1.Caption:='Текущая дата:        ' + datetostr(date);
end;

procedure TForm1.SetBtnClick(Sender: TObject);
begin
  t:=time;
  h:=strtoint(edit1.Text);  //устанавливаем кол-во часов
  m:=strtoint(edit2.Text); //устанавливаем кол-во минут
  s:=strtoint(edit3.Text); //устанавливаем кол-во секунд
  hs:=h * 3600; //получаем кол-во секунд в установленных часах
  ms:=m * 60; // получаем кол-во секунд в установленных минутах
  sumT:=hs + ms + s;   //сумарное кол-во секунд
  resT:=t + (sumT/86400);  // (час равен 3600 секунд (24*3600 в сутках или 86400))
  Label6.Caption:='Таймер сработает в: ' + FormatDateTime('hh:mm:ss',(resT)); //показываем установленное время
  t1:=strtotime(FormatDateTime('hh:mm:ss',(resT)));
  Label7.Caption:='Осталось: ' + timetostr(t1-t); //показываем сколько осталось
  ClrBtn.Enabled:=true;  //делаем кнопку "Сброс" активной
  Timer2.Enabled:=true;  //включчаем наш второй таймер
  //Очищаем поля эдитов
  Edit1.Text:='0';
  Edit2.Text:='0';
  Edit3.Text:='0';
end;

procedure TForm1.ClrBtnClick(Sender: TObject);
begin
  Timer2.Enabled:=false;
  Label6.Caption:='Таймер сработает в: ';
  Label7.Caption:='Осталось: ';
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  h1:=time;
  h2:=resT-h1;
  Label7.Caption:='Осталось: ' + timetostr(h2);
  if h2<0 then
   begin
     Timer2.Enabled:=False;
     Label6.Caption:='Таймер сработал в: ' + FormatDateTime('hh:mm:ss',(resT));
     playsound.execute;
     ShowMessage('Пора выпить воды!');
   end;
end;

end.

