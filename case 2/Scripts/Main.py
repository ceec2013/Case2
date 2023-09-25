from TradersClass import TradersClass
from TradersClass import Trader
from TradesClass import TradesClass
from TradesClass import TradesList
from TradersClass import TradersList
from Database import Database
from Processes import Process
import getpass
import socket
import psycopg2
import signal

# Define the host and port for your server
HOST = '127.0.0.1'  # Use '0.0.0.0' to listen on all available network interfaces
PORT = 9002


def decode_fix_message(client_socket, dbConnection, message):
    fields = message.split("\x01")
    decoded_message = {}

    for field in fields:
        tag, value = field.split('=')
        decoded_message[tag] = value
    Process.Parse_Message(client_socket, dbConnection, decoded_message)

def handle_client(client_socket, dbConnection):
    try:
        # Receive and process client messages here
        while True:            
            data = client_socket.recv(1024)  # Receive data from the client (adjust buffer size as needed)
            if not data:
                break  # No more data received, exit the loop

            # Process the received data (you can add your logic here)
            message = data.decode('utf-8')
            decode_fix_message(client_socket, dbConnection, message)
            
            # You can send a response back to the client if needed
            # response = "Response from server"
            # client_socket.send(response.encode('utf-8'))

    except Exception as e:
        print(f"Error handling client: {e}")
    finally:
        client_socket.close()

if __name__ == "__main__":

    # Get the username from the user
    username = input("Enter DB username: ")

    # Get the password from the user without displaying it
    password = getpass.getpass("Enter DB password: ")    
    
    db = Database(dbname='OMS',user=username, password=password)

    #initialize traders list and trades list
    TradersList.retrive_traders(db, TradersList)
    TradesList.retrive_trades(db, TradesList)
    
    # Create a socket server
    # Create a socket server
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
        server_socket.bind((HOST, PORT))
        server_socket.listen()

        print(f"Server is listening on {HOST}:{PORT}")
        
        try:
            while True:
                # Accept incoming connections
                client_socket, client_address = server_socket.accept()
                print(f"Accepted connection from {client_address}")
                handle_client(client_socket, db)

        except KeyboardInterrupt:
            print("Server is shutting down...")
            # Close the server socket when the application is closed
            server_socket.close()

    
    db.close()
