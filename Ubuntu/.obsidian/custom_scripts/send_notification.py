#!/usr/bin/env python3
import argparse


def send_notification(title: str, message: str) -> None:
    # Replace this with your real notification logic.
    print(f"{title}: {message}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--title", required=True)
    parser.add_argument("--message", required=True)
    args = parser.parse_args()

    send_notification(args.title, args.message)


if __name__ == "__main__":
    main()