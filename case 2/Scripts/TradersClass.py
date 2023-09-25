from Database import Database

class Trader:
    def __init__(self, user_id, user_pass, first_name, last_name, age, trader_type):
        self.user_id = user_id
        self.user_pass = user_pass
        self.first_name = first_name
        self.last_name = last_name
        self.age = age
        self.trader_type = trader_type #0 = Admin; 1 = user

    def __str__(self):
        return f"UserID: {self.user_id}, Name: {self.first_name} {self.last_name}, Age: {self.age}, Type: {self.trader_type}"
		
class TradersClass:
    def __init__(self):
        self.traders = []
		
    def add_trader(self, trader):
        self.traders.append(trader)

    def delete_trader(self, trader_id):
        self.traders = [trader for trader in self.traders if trader.user_id != trader_id]

    def edit_trader(cls, traders_list, user_id, new_user_pass=None, new_first_name=None, new_last_name=None, new_age=None, new_trader_type=None):
        for trader in self.traders:
            if trader.UserID == user_id:
                if new_user_pass is not None:
                    trader.UserPass = new_user_pass
                if new_first_name is not None:
                    trader.FirstName = new_first_name
                if new_last_name is not None:
                    trader.LastName = new_last_name
                if new_age is not None:
                    trader.Age = new_age
                if new_trader_type is not None:
                    trader.tradertype = new_trader_type
                return True
        return False
        
    def search_trader(self, user_id):
        for trader in self.traders:
            if trader.user_id == user_id:
                return trader
        return none
        
    def retrive_traders(self, dbConnection, TradersList):
        traderCursor = None
        try:
            # Retrieve All Traders
            traderCursor = dbConnection.execute_query("SELECT * FROM traders;")
        
            # Fetch and print the results
            rows = traderCursor.fetchall()
            for row in rows:
                trader = Trader(row[1], row[2], row[3], row[4], row[5], row[6])
                TradersList.add_trader(trader)
            
        except (Exception, psycopg2.Error) as error:
            print("Error querying the database:", error)
            
    def saveAddTrader(self, dbConnection, Ntrader):
        cursor = None
        try:
            # Insert New Trade
            storedProc = "call public.addnewtrader('" + Ntrader.user_id + "'::character varying, " + "'" + Ntrader.user_pass + "'::character varying, " + "'" + Ntrader.first_name + "'::character varying, " + "'" + Ntrader.last_name + "'::character varying, " + "'" + str(Ntrader.age) + "'::integer, " + "'" + str(Ntrader.trader_type) + "'::integer" + ")"
            print(storedProc)
            cursor = dbConnection.execute_proc(storedProc)         
            
        except (Exception, psycopg2.Error) as error:
            print("Error querying the database:", error)
            
TradersList = TradersClass()
