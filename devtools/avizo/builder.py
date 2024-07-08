#!/usr/bin/env python3
import argparse

from utils import Avizo


def create_parser():
    parser = argparse.ArgumentParser(
        description="Build tool for generate Avizo base16 icons"
    )
    parser.add_argument(
        "--color",
        type=str,
        choices=[
            "base00",
            "base01",
            "base02",
            "base03",
            "base04",
            "base05",
            "base06",
            "base07",
            "base08",
            "base09",
            "base0A",
            "base0B",
            "base0C",
            "base0D",
            "base0E",
            "base0F"
        ],
        default="base05",
        help="Color scheme code name in base16 format"
    )
    return parser


def main():
    parser = create_parser()
    args = parser.parse_args()

    avizo = Avizo()
    avizo.recolor(args.color)


if __name__ == "__main__":
    main()
