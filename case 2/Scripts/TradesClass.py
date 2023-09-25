from Database import Database
import psycopg2

class Trades:
    def __init__(self, trade_ord_id, transact_date, symbol, volume, side, trader_id, price, tot_val):
        self.trade_ord_id = trade_ord_id
        self.transact_date = transact_date
        self.symbol = symbol
        self.volume = volume
        self.side = side
        self.trader_id = trader_id
        self.price = price
        self.tot_val = tot_val

    def __str__(self):
        return f"TradeOrdID: {self.trade_ord_id}, Symbol: {self.symbol}, Volume: {self.volume}, Side: {self.side}, TraderID: {self.trader_id}, Price: {self.price}, Total Value: {self.tot_val}"

		
class TradesClass:
    def __init__(self):
        self.trades = []

    def add_trade(self, trade):
        self.trades.append(trade)

    def delete_trade(self, TradeOrdID):
        for trade in self.trades:
            if trade.TradeOrdID == TradeOrdID:
                self.trades.remove(trade)
                return True
        return False

    def edit_trade(self, TradeOrdID, new_TransactDate=None, new_Symbol=None, new_Volume=None, new_Side=None, new_traderID=None, new_price=None, new_TotVal=None):
        for trade in self.trades:
            if trade.TradeOrdID == TradeOrdID:
                if new_TransactDate is not None:
                    trade.TransactDate = new_TransactDate
                if new_Symbol is not None:
                    trade.Symbol = new_Symbol
                if new_Volume is not None:
                    trade.Volume = new_Volume
                if new_Side is not None:
                    trade.Side = new_Side
                if new_traderID is not None:
                    trade.traderID = new_traderID
                if new_price is not None:
                    trade.price = new_price
                if new_TotVal is not None:
                    trade.TotVal = new_TotVal
                return True
        return False
        
    def search_trades(self, TradeOrdID):
        for trade in self.trades:
            if trade.TradeOrdID == TradeOrdID:
                return True
        return False
        
    def retrive_trades(self, dbConnection, TradesList):
        cursor = None
        try:

            # Retrieve All Trades
            cursor = dbConnection.execute_query("SELECT * FROM trades;")
        
            # Fetch and print the results
            rows = cursor.fetchall()
            for row in rows:
                trade = Trades(row[1], row[2], row[3], row[4], row[5], row[6], row[7],row[4]*row[6])
                TradesList.add_trade(trade)
            
        except (Exception, psycopg2.Error) as error:
            print("Error querying the database:", error)
            
    def saveNewTrade(self, dbConnection, Ntrade):
        cursor = None
        try:
            print(str(Ntrade.volume))
            print(str(Ntrade.price))
            # Insert New Trade
            storedProc = "call public.insertnewtrade('" + Ntrade.trade_ord_id + "'::character varying, " + "'" + str(Ntrade.transact_date) + "'::date, " + "'" + Ntrade.symbol + "'::character varying, " + "'" + str(Ntrade.volume) + "'::integer, " + "'" + (Ntrade.trader_id) + "'::character varying, " + "'" + str(Ntrade.price) + "'::decimal, " + "'" + str(Ntrade.side) + "'::integer " + ")"
            print(storedProc)
            cursor = dbConnection.execute_proc(storedProc)         
            
        except (Exception, psycopg2.Error) as error:
            print("Error querying the database:", error)
            
    def saveEditTrade(self, dbConnection,trade_ord_id, volume, price):
        cursor = None
        try:
            # Insert New Trade
            storedProc = "call public.updatetrade('" + trade_ord_id + "'::character varying, " + "'" + str(volume) + "'::integer, " + "'" + str(price) + "'::decimal" + ")"
            print(storedProc)
            cursor = dbConnection.execute_proc(storedProc)         
            
        except (Exception, psycopg2.Error) as error:
            print("Error querying the database:", error)
            
TradesList = TradesClass()