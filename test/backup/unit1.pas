unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtDlgs,
  LineNotify;

type

  { TfrmSendLine }

  TfrmSendLine = class(TForm)
    btnSend: TButton;
    txtMsg: TEdit;
    txtToken: TEdit;
    LineNotify1: TLineNotify;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure btnSendClick(Sender: TObject);
  private

  public

  end;

var
  frmSendLine: TfrmSendLine;

implementation

{$R *.lfm}

{ TfrmSendLine }

procedure TfrmSendLine.btnSendClick(Sender: TObject);
begin

  LineNotify1.Send(txtToken.Text,'test',OpenPictureDialog1.FileName,1,1);
end;

end.

