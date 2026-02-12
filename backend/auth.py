import hashlib
from db import get_db
from crypto_utils import generate_salt, derive_key

def signup(email, login_password, master_password):
    db = get_db()
    cur = db.cursor()

    salt = generate_salt()
    master_key = derive_key(master_password, salt)
    login_hash = hashlib.sha256(login_password.encode()).digest()

    cur.execute(
        "INSERT INTO users (email, login_hash, salt) VALUES (%s,%s,%s)",
        (email, login_hash, salt)
    )

    db.commit()
    return True


def login(email, login_password):
    db = get_db()
    cur = db.cursor()

    cur.execute(
        "SELECT id, login_hash, salt FROM users WHERE email=%s",
        (email,)
    )
    row = cur.fetchone()

    if not row:
        return None

    user_id, stored_hash, salt = row
    if hashlib.sha256(login_password.encode()).digest() == stored_hash:
        return user_id, salt
    return None