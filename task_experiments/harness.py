#!/usr/bin/env python3
import json
import sys
import subprocess
import tempfile
import os
import glob

# Color mapping for terminal output
COLOR_MAP = {
    0: 'black',
    1: 'blue', 
    2: 'red',
    3: 'green',
    4: 'yellow',
    5: 'grey',
    6: 'pink',
    7: 'orange',
    8: 'cyan',
    9: 'maroon'
}

# Terminal color codes
TERM_COLORS = {
    'black': '\033[40m  \033[0m',
    'blue': '\033[44m  \033[0m',
    'red': '\033[41m  \033[0m',
    'green': '\033[42m  \033[0m',
    'yellow': '\033[43m  \033[0m',
    'grey': '\033[100m  \033[0m',
    'pink': '\033[105m  \033[0m',
    'orange': '\033[48;5;208m  \033[0m',
    'cyan': '\033[46m  \033[0m',
    'maroon': '\033[48;5;52m  \033[0m'
}

def grid_to_prolog_facts(grid):
    """Convert a grid to Prolog input_cell facts."""
    facts = []
    for row_idx, row in enumerate(grid):
        for col_idx, value in enumerate(row):
            color = COLOR_MAP[value]
            facts.append(f"input_cell({col_idx}, {row_idx}, {color}).")
    return '\n'.join(facts)

def parse_output_cells(prolog_output):
    """Parse output_cell facts from Prolog output."""
    cells = {}
    lines = prolog_output.strip().split('\n')
    
    for line in lines:
        line = line.strip()
        if line.startswith('output_cell(') and line.endswith(').'):
            # Extract X, Y, Color from output_cell(X, Y, Color).
            content = line[12:-2]  # Remove 'output_cell(' and ').'
            parts = content.split(', ')
            if len(parts) == 3:
                x = int(parts[0])
                y = int(parts[1])
                color = parts[2]
                cells[(x, y)] = color
    
    return cells

def render_grid(cells):
    """Render the grid with terminal colors."""
    if not cells:
        print("No output cells found")
        return
    
    # Find grid dimensions
    max_x = max(x for x, y in cells.keys())
    max_y = max(y for x, y in cells.keys())
    
    # Print the grid
    for y in range(max_y + 1):
        row = []
        for x in range(max_x + 1):
            color = cells.get((x, y), 'black')
            row.append(TERM_COLORS[color])
        print(''.join(row))

def main():
    if len(sys.argv) != 4:
        print("Usage: python harness.py <directory> <train|test> <index>")
        sys.exit(1)
    
    task_dir = sys.argv[1]
    dataset_type = sys.argv[2]
    index = int(sys.argv[3])
    
    # Check if directory exists
    if not os.path.isdir(task_dir):
        print(f"Error: Directory '{task_dir}' does not exist")
        sys.exit(1)
    
    # Find the JSON file in the directory
    json_files = glob.glob(os.path.join(task_dir, '*.json'))
    
    if len(json_files) == 0:
        print(f"Error: No JSON file found in directory '{task_dir}'")
        sys.exit(1)
    elif len(json_files) > 1:
        print(f"Error: Multiple JSON files found in directory '{task_dir}': {json_files}")
        sys.exit(1)
    
    json_file = json_files[0]
    
    # Load JSON data
    with open(json_file, 'r') as f:
        data = json.load(f)
    
    # Get the appropriate dataset
    if dataset_type not in ['train', 'test']:
        print("First argument must be 'train' or 'test'")
        sys.exit(1)
    
    dataset = data[dataset_type]
    
    # Check index bounds
    if index < 0 or index >= len(dataset):
        print(f"Index {index} out of bounds for {dataset_type} dataset (0-{len(dataset)-1})")
        sys.exit(1)
    
    # Get the input grid
    input_grid = dataset[index]['input']
    
    # Display input grid
    print(f"\nInput grid for {dataset_type}[{index}]:")
    input_cells = {}
    for row_idx, row in enumerate(input_grid):
        for col_idx, value in enumerate(row):
            color = COLOR_MAP[value]
            input_cells[(col_idx, row_idx)] = color
    render_grid(input_cells)
    
    # Convert to Prolog facts
    prolog_facts = grid_to_prolog_facts(input_grid)
    #print("IN FACTS: ")
    #print(prolog_facts)
    
    # Create temporary file with facts and include task.pl
    with tempfile.NamedTemporaryFile(mode='w', suffix='.pl', delete=False) as f:
        f.write(prolog_facts)
        f.write('\n\n')
        # Include the task.pl file from the specified directory
        task_pl_path = os.path.join(task_dir, 'task.pl')
        if not os.path.exists(task_pl_path):
            print(f"Error: task.pl not found in directory '{task_dir}'")
            sys.exit(1)
        f.write(f':- include(\'{task_pl_path}\').\n')
        temp_file = f.name
    
    try:
        # Run Prolog query
        cmd = [
            'swipl',
            '-g', 'forall(output_cell(X, Y, Color), format("output_cell(~w, ~w, ~w).~n", [X, Y, Color]))',
            '-t', 'halt',
            temp_file
        ]
        
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        if result.returncode != 0:
            print(f"Error running Prolog: {result.stderr}")
            sys.exit(1)
        
        # Parse output cells
        output_cells = parse_output_cells(result.stdout)
        
        # Render the grid
        print(f"\nOutput grid for {dataset_type}[{index}]:")
        render_grid(output_cells)
        
    finally:
        # Clean up temp file
        os.unlink(temp_file)

if __name__ == '__main__':
    main()