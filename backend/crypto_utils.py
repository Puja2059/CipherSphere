import hashlib
import os
from Crypto.Cipher import AES
import base64

def generate_salt():
    return os.urandom(32)

def derive_key(master_password, salt):
    return hashlib.pbkdf2_hmac(
        'sha256',
        master_password.encode(),
        salt,
        100000,
        32
    )

def encrypt_password(password, key):
    iv = os.urandom(16)
    cipher = AES.new(key, AES.MODE_CFB, iv=iv)
    encrypted = cipher.encrypt(password.encode())
    return base64.b64encode(encrypted), iv

def decrypt_password(enc_password, key, iv):
    cipher = AES.new(key, AES.MODE_CFB, iv=iv)
    return cipher.decrypt(base64.b64decode(enc_password)).decode()