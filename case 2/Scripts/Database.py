import psycopg2

class Database:
    def __init__(self, dbname, user, password, host='localhost', port=5432):
        self.conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
        self.cursor = self.conn.cursor()

    def execute_query(self, query, params=None):
        self.cursor.execute(query, params)
        return self.cursor
        
    def execute_proc(self, proc, params=None):
        self.cursor.execute(proc,params)
        self.conn.commit()
        return self.cursor

    def commit(self):
        self.conn.commit()

    def close(self):
        self.cursor.close()
        self.conn.close()
