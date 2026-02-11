import os
import mysql.connector
from dotenv import load_dotenv

load_dotenv()

def get_connection():
    try:
        connection = mysql.connector.connect(
            host=os.getenv("switchyard.proxy.rlwy.net"),
            port=int(os.getenv("51013")),
            user=os.getenv("root"),
            password=os.getenv("PSYCbLbIcbFldPKnlYOFJhJPoBTxJFPt"),
            database=os.getenv("ciphersphere")
        )
        print("Connected to Railway MySQL!")
        return connection

    except mysql.connector.Error as err:
        print("Database connection failed:", err)
        return None