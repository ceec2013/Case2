program OMSClient;

uses
  Vcl.Forms,
  OMSC in 'OMSC.pas' {frmMain},
  login in 'login.pas' {frmLogin},
  OMSCProcess in 'OMSCProcess.pas',
  AddTrade in 'AddTrade.pas' {frmAddTrade};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmAddTrade, frmAddTrade);
  if not Assigned(frmLogin) then
  begin
    frmLogin := TfrmLogin.Create(Application);
  end;
  frmLogin.Show;
  Application.Run;
end.
