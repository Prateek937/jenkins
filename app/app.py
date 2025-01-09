from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def show_secret():
    try:
        with open("/tmp/TESTCRED", "r") as secret_file:
            secret = secret_file.read().strip()
    except FileNotFoundError:
        secret = "Secret file not found."
    return f"<h1>Secret: {secret}</h1>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
