---
linkTitle: hsm
title: hsm [Writeup]
type: docs
math: True
weight: 3
---
## Challenge Description

> We have build a secure HSM!

## Challenge Files
```py {filename=main.py, linenos=table}
import os
import signal
import base64
import ed25519

from Crypto.Cipher import AES

KEY = os.urandom(32)
PHRASE = b'I want flag'

def print_menu():
    print('''
[1] create key
[2] sign message
[3] verify signature
    '''.strip())

    return input('> ')

def decrypt_key(key):
    """
    Decrypt the secret part of the key and reconstruct key object
    """
    key = base64.b64decode(key)

    nonce, sk, tag, vk = key[:12], key[12:44], key[44:60], key[60:]

    aes = AES.new(KEY, nonce=nonce, mode=AES.MODE_GCM)

    sk = aes.decrypt_and_verify(sk, tag)

    key = ed25519.SigningKey(sk_s=sk + vk)

    return key

def encrypt_key(key):
    """
    Encrypt the secret part of the key
    """

    key = key.sk_s

    sk, vk = key[:32], key[32:]

    nonce = os.urandom(12)

    aes = AES.new(KEY, nonce=nonce, mode=AES.MODE_GCM)

    sk, tag = aes.encrypt_and_digest(sk)

    return base64.b64encode(nonce + sk + tag + vk).decode()

def generate_key():
    sk, _ = ed25519.create_keypair()
    out = encrypt_key(sk)

    print(f'Your key is: {out}')


def sign_message():
    key = input('Hand me your  key: ').strip()
    key = decrypt_key(key)

    msg = input('Which message to sign?: ').strip().encode()

    if msg == PHRASE:
        print("I'm sorry Dave, I'm afraid I can't do that")
        return

    sig = key.sign(msg)
    sig = base64.b64encode(sig).decode()

    print(f'Signature: {sig}')


def verify_signature():
    key = input('Hand me your key: ').strip()
    key = decrypt_key(key)

    msg = input('Which message to verify?: ').strip().encode()

    sig = input('What is the signature?: ').strip().encode()
    sig = base64.b64decode(sig)

    pk = key.get_verifying_key()

    try:
        pk.verify(sig, msg)
        print("The signature is valid")

        if msg == PHRASE:
            print(os.environ["FLAG"])
    except ed25519.BadSignatureError:
        print("The signature is invalid")


def main():
    signal.alarm(300)

    while True:
        option = print_menu()

        match option:
            case '1':
                generate_key()
            case '2':
                sign_message()
            case '3':
                verify_signature()
            case _:
                print('Invalid option')

if __name__ == '__main__':
    main()
```

## Solution 
We are provided with a Public Key Cryptosystem that signs messages that we request for using their private key and verifies if the provided signature is valid for the corresponding provided message. The goal of this challenge is to pass the verification of a signature of a certain message. The difficulty lies in that the server denies signing that certain message. It also seems impossible to gain the private key used by the server to sign the messages.

### Verifying Key Vulnerability
Let's take a look at the encryption and decryption of our key

```py {filename=main.py linenos=table, linenostart=20}
def decrypt_key(key):
    """
    Decrypt the secret part of the key and reconstruct key object
    """
    key = base64.b64decode(key)

    nonce, sk, tag, vk = key[:12], key[12:44], key[44:60], key[60:]

    aes = AES.new(KEY, nonce=nonce, mode=AES.MODE_GCM)

    sk = aes.decrypt_and_verify(sk, tag)

    key = ed25519.SigningKey(sk_s=sk + vk)

    return key

def encrypt_key(key):
    """
    Encrypt the secret part of the key
    """

    key = key.sk_s

    sk, vk = key[:32], key[32:]

    nonce = os.urandom(12)

    aes = AES.new(KEY, nonce=nonce, mode=AES.MODE_GCM)

    sk, tag = aes.encrypt_and_digest(sk)

    return base64.b64encode(nonce + sk + tag + vk).decode()
```
If we take a closer look at the decryption algorithm, we notice that the server nowhere checks whether the verifying key belongs to the provided signing key. Hence, we could generate a signature and verifying key pair on the client side and use that signing key to sign a message. We could then ask the server to generate a key for us and replace their verifying key with our verifying key. 

The above claim could be verified from the source code of `Class SigningKey` from `ed25519.keys.py`
```py {filename=ed25519.keys.py, linenos=table, linenostart=74}
class SigningKey(object):
    # this can only be used to reconstruct a key created by create_keypair().
    def __init__(self, sk_s, prefix="", encoding=None):
        assert isinstance(sk_s, bytes)
        if not isinstance(prefix, bytes):
            prefix = prefix.encode('ascii')
        sk_s = remove_prefix(sk_s, prefix)
        if encoding is not None:
            sk_s = from_ascii(sk_s, encoding=encoding)
        if len(sk_s) == 32:
            # create from seed
            vk_s, sk_s = _ed25519.publickey(sk_s)
        else:
            if len(sk_s) != 32+32:
                raise ValueError("SigningKey takes 32-byte seed or 64-byte string")
        self.sk_s = sk_s # seed+pubkey
        self.vk_s = sk_s[32:] # just pubkey
```

The verification protocol at the server generates the verifying key solely on the basis of the parameter `vk_s` 

```py {filename=ed25519.keys.py, linenos=table, linenostart=113}
    def get_verifying_key(self):
        return VerifyingKey(self.vk_s)
```
which was tampered with our malicious key
```py {filename=main.py, linenos=table, linenostart=76}
def verify_signature():
    key = input('Hand me your key: ').strip()
    key = decrypt_key(key)

    msg = input('Which message to verify?: ').strip().encode()

    sig = input('What is the signature?: ').strip().encode()
    sig = base64.b64decode(sig)

    pk = key.get_verifying_key()

    try:
        pk.verify(sig, msg)
        print("The signature is valid")

        if msg == PHRASE:
            print(os.environ["FLAG"])
    except ed25519.BadSignatureError:
        print("The signature is invalid")
```

and hence we could proceed with the previously devised attack.

### Solve Script
```py {filename=solve.py, linenos=table}
from Crypto.Util.number import *
from Crypto.Cipher import AES
import ed25519 
import base64
import os

KEY = os.urandom(32)
PHRASE = b'I want flag'

sk, vk = ed25519.create_keypair()

assert sk.vk_s == vk.vk_s

def encrypt_key(key):
    key = key.sk_s
    sk, vk = key[:32], key[32:]

    nonce = os.urandom(12)
    aes = AES.new(KEY, nonce=nonce, mode=AES.MODE_GCM)

    sk, tag = aes.encrypt_and_digest(sk)
    return base64.b64encode(nonce + sk + tag + vk).decode()

def decrypt_key(key):
    key = base64.b64decode(key)

    nonce, sk, tag, vk = key[:12], key[12:44], key[44:60], key[60:]
    aes = AES.new(KEY, nonce=nonce, mode=AES.MODE_GCM)

    sk = aes.decrypt_and_verify(sk, tag)
    key = ed25519.SigningKey(sk_s=sk + vk)

    return key

enc_key = encrypt_key(sk)

vk_tampered = base64.b64decode(enc_key)[60:]

sig = sk.sign(PHRASE)
sig = base64.b64encode(sig)

print(f'Signature: {sig}')
print(f'vk_s: {vk_tampered}')

pk = sk.get_verifying_key()
pk.verify(base64.b64decode(sig), PHRASE)
vk.verify(base64.b64decode(sig), PHRASE)

from pwn import *

r = remote('hsm.rumble.host', 3229, level='DEBUG')

r.recvuntil(b'> ')
r.sendline(b'1')

r.recvuntil(b'Your key is: ')
key = base64.b64decode(r.recvline().strip())

key_tampered = key[:60] + vk_tampered
r.recvuntil(b'> ')
r.sendline(b'3')

r.recvuntil(b'Hand me your key: ')
r.sendline(base64.b64encode(key_tampered))

r.recvuntil(b'Which message to verify?: ')
r.sendline(PHRASE)

r.recvuntil(b'What is the signature?: ')
r.sendline(sig)

r.interactive()

## CSR{did_I_already_said_nonce?}
```
## Flag
```
CSR{did_I_already_said_nonce?}
```
