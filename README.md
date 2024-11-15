# Advent of Code 2024 - Elixir Edition

This project is for my attempt at AOC'24. Following tradition I'm picking a language I've never used before, and this year is Elixir. Why? I'll explain in order of what led me to it
* According the [SO 2024 Dev Survey](https://survey.stackoverflow.co/2024/technology#2-programming-scripting-and-markup-languages) it's the second most Admired language
  * Beat by Rust which I used for AOC'23
* According the [SO 2024 Dev Survey](https://survey.stackoverflow.co/2024/technology#4-top-paying-technologies) it's the second highest paying language
  * Beat by it's "predecessor" and compilation target Erlang
* The [BEAM (Erlang VM) architecture and design is freaking cool](https://www.youtube.com/watch?v=JvBT4XBdoUE)!
* There is an embedded framework built in Elixir called [Nerves](https://nerves-project.org/) which could be relevant for some side projects

I had some trouble figuring out how to correctly setup a new project and directory structure, so I copied a format from [ktunprasert's AOC project](https://github.com/ktunprasert/aoc-elixir)

## Setup

This is intended to be run as a standalone project, so you'll need to clone the repo and install the dependencies.

```bash
git clone https://github.com/myfoostrong/aoc24
cd aoc24
mix deps.get
# Run Day 1
mix run -e "Aoc.Runner 2024,$DAY"
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/aoc24>.

