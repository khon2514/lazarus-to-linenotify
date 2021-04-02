{
    Send msg to line
        พัตณาโดย  ภก.สุรศักดิ์  คณานันท์
   update ล่าสุด  2/4/2564
**********************************
                                    เงื่อนไข
****************************
 1.Linenotify เป็น Open source
 2. สามารถนำไปใช้กับการพัฒนาได้เลย
 3. ห้ามขาย
4. ห้ามลบ Credit  Comment ของผู้พัฒนา
5. ผู้พัฒนาจะไม่รับผิดชอบกรณีเกิดการเสียหายกับโปรแกรมของท่านไม่ว่ากรณีใดๆ
  ****************************
}


unit LineNotify;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
   IdHTTP,LCLIntf,
  idMultipartFormData, IdURI, LConvEncoding, LazUTF8, IdSSLOpenSSL, IdFTP,
  jsonConf;

type

  { TLineNotify }

  TLineNotify = class(TComponent)
  private
   FURLNotify  : string;
   FURLAuthentication : string;
   FURLtoken : string;
   FURLstatus :string;
   FURLrevoke :string;
   FURLServer : string;
   Fclient_id :string;
   Fclient_secret : string;
   Fredirect_uri : string;
   FURLaccessToken : string;
   FURLaccessService: string;

  protected

  public
    constructor Create (AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure notification(acomponent : tcomponent;operation:toperation);override;
    procedure Send(Authorization,message:string;imageFile:string='';
       stickerPackageId:integer=0;stickerId:integer=0);
    procedure Revoke(Authorization:string);
    procedure accToken;
    procedure accService;

  published
   property  URLNotify  : string read FURLNotify  write FURLNotify;
   property  URLAuthentication  : string read FURLAuthentication write FURLAuthentication;
   property  URLtoken  : string read FURLtoken write FURLtoken;
   property  URLstatus  : string read FURLstatus write FURLstatus;
   property  URLrevoke  : string read FURLrevoke write FURLrevoke;
   property  URLaccessToken  : string read FURLaccessToken write FURLaccessToken;
   property  URLaccessService  : string read FURLaccessService write FURLaccessService;

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I linenotify_icon.lrs}
  RegisterComponents('Kananant',[TLineNotify]);
end;

{ TLineNotify }

constructor TLineNotify.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FURLNotify:='https://notify-api.line.me/api/notify';
  FURLAuthentication :='https: //notify-bot.line.me/oauth/authorize';
  FURLtoken :='https://notify-bot.line.me/oauth/token';
  FURLstatus :='https://notify-api.line.me/api/status';
  FURLrevoke :='https://notify-api.line.me/api/revoke';
  FURLaccessToken :='https://notify-bot.line.me/my/';
  FURLaccessService :='https://notify-bot.line.me/my/services/';
end;

destructor TLineNotify.Destroy;
begin
  inherited Destroy;
end;

procedure TLineNotify.notification(acomponent: tcomponent; operation: toperation
  );
begin
  inherited notification(acomponent, operation);
end;

procedure TLineNotify.Send(Authorization, message: string; imageFile: string;
  stickerPackageId: integer; stickerId: integer);
var
   lParam : TIdMultipartFormDataStream;
   IdHTTP : TIdHTTP;
begin
  if Authorization ='' then exit;
  if FURLNotify ='' then exit;
  if message ='' then message :='...';

 lParam := TIdMultipartFormDataStream.Create;
 try

   if imageFile <> '' then
    lParam.AddFile('imageFile',imageFile);
    lParam.AddFormField('message', UTF8Encode(message), 'utf-8').ContentTransfer := '8bit';
    if (stickerPackageId > 0) and (stickerId > 0)  then
     begin
      lParam.AddFormField('stickerPackageId', inttostr(stickerPackageId));
      lParam.AddFormField('stickerId', inttostr(stickerId));
     end;
    IdHTTP := TIdHTTP.Create(nil);
    try
     IdHTTP.Request.ContentType:='application/x-www-form-urlencoded';
     IdHTTP.Request.CharSet:='utf-8';
     IdHTTP.Request.CustomHeaders.Values['Authorization']:='Bearer '+Authorization;
    // try
     IdHTTP.Post(FURLNotify,lParam)  ;

    // except
    // end;

    finally
      IdHTTP.Free;
    end;
 finally
   lParam.Free;
 end;

end;

procedure TLineNotify.Revoke(Authorization: string);
var
   lParam : TIdMultipartFormDataStream;
   IdHTTP : TIdHTTP;
begin
    if Authorization ='' then exit;
    lParam := TIdMultipartFormDataStream.Create;
    try
    IdHTTP := TIdHTTP.Create(nil);
    try
     IdHTTP.Request.ContentType:='application/x-www-form-urlencoded';
     IdHTTP.Request.CharSet:='utf-8';
     IdHTTP.Request.CustomHeaders.Values['Authorization']:='Bearer '+Authorization;
     try
      IdHTTP.Post('https://notify-api.line.me/api/revoke',lParam)  ;

     except
     end;

    finally
      IdHTTP.Free;
    end;

    finally
      lParam.Free;
    end;

end;

procedure TLineNotify.accToken;
begin
 if FURLaccessToken <> '' then
  OpenDocument(FURLaccessToken);
end;

procedure TLineNotify.accService;
begin

   if FURLaccessService <> '' then
  OpenDocument(FURLaccessService);
end;

end.
