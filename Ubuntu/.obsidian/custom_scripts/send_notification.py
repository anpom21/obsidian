#!/usr/bin/env python3
import argparse
import requests

ANDREAS_USER = "usozo22dr29waq7yx9f5u3ab74717x"
ANDREAS_TOKEN = "aqy5q6psoain23br3bci8dxeund4ne"

def send_notification(title: str, message: str, priority: int = 0):

    try:
        requests.post(
            "https://api.pushover.net/1/messages.json",
            data={
                "token": ANDREAS_TOKEN,
                "user": ANDREAS_USER,
                "title": title,
                "message": message,
                "priority": priority,
            },
            timeout=5,
        )
        print("Pushover notification sent successfully.")
    except Exception as e:
        print(f"Failed to send Pushover notification: {e}")
        

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--title", required=True)
    parser.add_argument("--message", required=True)
    args = parser.parse_args()

    send_notification(args.title, args.message)


if __name__ == "__main__":
    main()