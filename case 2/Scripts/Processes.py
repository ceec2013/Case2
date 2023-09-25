from TradesClass import TradesList
from TradersClass import TradersList
from TradesClass import Trades
from Database import Database
import datetime

class Process :  
    @staticmethod
    def Process_Login(client_socket, username, password) :
        UTrader = TradersList.search_trader(username)
        if UTrader is not None :
            if UTrader.user_id == username and UTrader.user_pass == password :
                response = "\x0135=LR\x0158=OK\x019001="+str(UTrader.trader_type)+'\x01'
                client_socket.send(response.encode('utf-8'))
                print(response)
            elif UTrader.user_id == username and UTrader.user_pass != password :
                response = "\x0135=LR\x0158=Wrong Password\x01"
                client_socket.send(response.encode('utf-8'))
                print(response)
        else :
            response = "\x0135=LR\x0158=User does not exists\x01"
            client_socket.send(response.encode('utf-8'))
            print(response)
            
    @staticmethod
    def Process_NewTrade(client_socket, dbConnection, DecodedMessage) :
        totVal = int(DecodedMessage['32']) * float(DecodedMessage['31'])
        trade = Trades(DecodedMessage['11'], datetime.datetime.now(), DecodedMessage['55'], DecodedMessage['32'], DecodedMessage['54'], DecodedMessage['9003'], DecodedMessage['31'], totVal)
        TradesList.add_trade(trade);
        TradesList.saveNewTrade(dbConnection,trade)
        
    @staticmethod
    def Process_EditTrade(client_socket, dbConnection, DecodedMessage) :
        totVal = int(DecodedMessage['32']) * float(DecodedMessage['31'])
        trade = Trades(DecodedMessage['11'], datetime.datetime.now(), DecodedMessage['55'], DecodedMessage['32'], DecodedMessage['54'], DecodedMessage['9003'], DecodedMessage['31'], totVal)
        TradesList.edit_trade(trade);
        TradesList.saveEditTrade(dbConnection,DecodedMessage['32'],DecodedMessage['31'])
        
    @staticmethod
    def Process_AddTrader(client_socket, dbConnection, DecodedMessage) :
                        #UserID                 UserPass                First Name              Last Name               Age                     Trader Type
        trader = Trader(DecodedMessage['9003'], DecodedMessage['9004'], DecodedMessage['9005'], DecodedMessage['9006'], DecodedMessage['9007'], DecodedMessage['9008'])
        TraderList.add_trader(trader);
        TraderList.saveAddTrader(dbConnection,trader)
     
    @staticmethod
    def Parse_Message(client_socket, dbConnection, DecodedMessage) :
        try:
            if DecodedMessage['35'] == "A" : #login               
                username = DecodedMessage['553']
                password = DecodedMessage['554']
                Process.Process_Login(client_socket, username, password)
            elif DecodedMessage['35'] == '8' : #new trade
                Process.Process_NewTrade(client_socket, dbConnection, DecodedMessage)
            elif DecodedMessage['35'] == '85' : #edit trade 
                Process.Process_EditTrade(client_socket, dbConnection, DecodedMessage)
            elif DecodedMessage['35'] == 'AT' : #Add Trader 
                Process.Process_AddTrader(client_socket, dbConnection, DecodedMessage)
            
        finally:
            pass