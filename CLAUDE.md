# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Prolog learning playground containing educational examples and exercises in logic programming, Answer Set Programming (ASP), and Datalog.

## Essential Commands

### Running Prolog Files (.pl)

```bash
# Using SWI-Prolog (primary interpreter)
swipl <filename>.pl

# Interactive query example
swipl basics/family.pl
?- father(abraham, isaac).
?- grandparent(X, debbie).

# One-shot query
swipl -g "likes(alice, X)" -t halt basics/example.pl
```

### Running ASP Files (.lp)

```bash
# Using Clingo for Answer Set Programming
clingo asp/n_queens.lp

# Multiple files
clingo datalog/baseball.lp datalog/random_pitches.lp

# All answer sets
clingo 0 asp/graph_colors.lp
```

### Python Integration

```bash
cd datalog
python pitch_thrower.py  # Runs baseball simulation with Clingo
```

## Project Structure

- **basics/** - Fundamental Prolog concepts (facts, rules, recursion, lists)
- **exercises/ch3/** - Chapter exercises including CNF conversion, sorting, data structures
- **asp/** - Answer Set Programming examples (N-Queens, graph coloring, games)
- **datalog/** - Datalog programs with Python integration
- **symbolic_manip/** - Symbolic computation (derivatives, SAT solving)
- **abstract_interpreter/** - Haskell implementation of logic interpreter
- **trees/** - Tree data structure implementations

## Development Notes

- No formal build system or test framework
- Files are standalone and run directly with interpreters
- Recent work focuses on exercises (see git log for progression)
- Two file types: `.pl` (Prolog) and `.lp` (ASP/Clingo)