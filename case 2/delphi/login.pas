unit login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, OMSCProcess;

type
  TfrmLogin = class(TForm)
    UserIDLbl: TLabel;
    PasswordLbl: TLabel;
    Shape1: TShape;
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation
uses OMSC;

{$R *.dfm}

procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
  Close;
  frmMain.Close;
end;

procedure TfrmLogin.btnOkClick(Sender: TObject);
begin
  username := edtUsername.text;
  frmMain.InitializeConnection(edtUsername.Text, edtPassword.Text);
end;

end.
