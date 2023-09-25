unit OMSC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Vcl.StdCtrls, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, ipwcore, ipwipport;

type
  TfrmMain = class(TForm)
    TradesGrid: TAdvStringGrid;
    btnViewTrader: TButton;
    btnAddTrade: TButton;
    btnEditTrade: TButton;
    ClientPort: TipwIPPort;
    procedure ClientPortDataIn(Sender: TObject; Text: string; EOL: Boolean);
    procedure btnAddTradeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitializeConnection(Username : String; Password : String);
    procedure ProcessData(Text : string);
  end;

var
  frmMain: TfrmMain;

implementation

uses OMSCProcess, AddTrade;

{$R *.dfm}

procedure TfrmMain.btnAddTradeClick(Sender: TObject);
begin
  if not Assigned(frmAddTrade) then
  begin
    frmAddTrade := TfrmAddTrade.Create(Application);
  end;
  frmAddTrade.Show;
end;

procedure TfrmMain.ClientPortDataIn(Sender: TObject; Text: string;
  EOL: Boolean);
begin
  ProcessData(Text);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  TradesGrid.ColCount := 9;

  TradesGrid.ColWidths[ColTradesDummy] := 0;
  TradesGrid.ColWidths[ColTradesClOrdID] := 86;
  TradesGrid.ColWidths[ColTradesDate] := 86;
  TradesGrid.ColWidths[ColTradesSide] := 86;
  TradesGrid.ColWidths[ColTradesSymbol] := 86;
  TradesGrid.ColWidths[ColTradesVolume] := 86;
  TradesGrid.ColWidths[ColTradesPrice] := 86;
  TradesGrid.ColWidths[ColTradesTotVal] := 86;
  TradesGrid.ColWidths[ColTradesTrader] := 86;


  TradesGrid.Cells[ColTradesDummy,0] := '';
  TradesGrid.Cells[ColTradesClOrdID,0] := 'TRADE ID';
  TradesGrid.Cells[ColTradesDate,0] := 'DATE';
  TradesGrid.Cells[ColTradesSide,0] := 'SIDE';
  TradesGrid.Cells[ColTradesSymbol,0] := 'SYMBOL';
  TradesGrid.Cells[ColTradesVolume,0] := 'VOLUME';
  TradesGrid.Cells[ColTradesPrice,0] := 'PRICE';
  TradesGrid.Cells[ColTradesTotVal,0] := 'VALUE';
  TradesGrid.Cells[ColTradesTrader,0] := 'TRADER';

end;

procedure TfrmMain.InitializeConnection(Username : String; Password : String);
begin
  ClientPort.Connected := true;
  ClientPort.Send('35=A' + #1 + '553='+ Username + #1 + '554=' + Password);
end;

procedure TfrmMain.ProcessData(Text : string);
var
  strMsgType : string;
begin
  strMsgType := GetFIXTagValue(FIX_MsgType, Text);
  if strMsgType <> '' then
    FIXParseMsg(strMsgType, Text);
end;


end.
