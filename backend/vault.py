from db import get_db
from crypto_utils import encrypt_password, decrypt_password

def add_entry(user_id, platform, username, password, key):
    enc_pwd, iv = encrypt_password(password, key)

    db = get_db()
    cur = db.cursor()
    cur.execute(
        """INSERT INTO vault (user_id, platform, username, encrypted_password, iv)
           VALUES (%s,%s,%s,%s,%s)""",
        (user_id, platform, username, enc_pwd, iv)
    )
    db.commit()


def fetch_entries(user_id, key):
    db = get_db()
    cur = db.cursor(dictionary=True)
    cur.execute(
        "SELECT id, platform, username, encrypted_password, iv FROM vault WHERE user_id=%s",
        (user_id,)
    )

    results = []
    for row in cur.fetchall():
        pwd = decrypt_password(row["encrypted_password"], key, row["iv"])
        results.append({
            "site": row["platform"],
            "user": row["username"],
            "pass": pwd
        })

    return results