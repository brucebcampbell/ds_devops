from rich.console import Console

console = Console()

test_data = [
    {
        "jsonrpc": "2.0",
        "method": "sum",
        "params": [None, 1, 2, 4, False, True],
        "id": "1",
    },
    {"jsonrpc": "2.0", "method": "notify_hello", "params": [7]},
    {"jsonrpc": "2.0", "method": "subtract", "params": [42, 23], "id": "2"},
]


def test_log():
    enabled = False
    context = {
        "foo": "bar",
    }
    movies = ["Deadpool", "Rise of the Skywalker"]
    console.log("Hello from", console, "!")
    console.log(test_data, log_locals=True)


test_log()


from rich.console import Console
from rich.markdown import Markdown

MARKDOWN = """
# This is an h1

Rich can do a pretty *decent* job of rendering markdown.

1. This is a list item
2. This is another list item
"""

console = Console()
md = Markdown(MARKDOWN)
console.print(md)


from rich.progress import track

import random
import time


def do_step(step):
    print(step)
    time.sleep(random.randint(0, 4))


for step in track(range(10)):
    do_step(step)


print("done")
