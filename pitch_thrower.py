import random
import subprocess

players = ["isaac", "vinney", "james"]
game_state = {
    "on_base": [],
    "outs": 0,
    "runs": 0
}

def build_logic_program(player, state) -> list[str]:
    pitch_count = 6
    pitch_records = []
    for i in range(pitch_count):
        height = random.randint(6, 50)
        distance = random.randint(10, 50)
        pitch_records.append(f"would_pitch({p}, {height}, {distance}, {i+1}).")
    for i in range(pitch_count):
        did_swing = random.randint(0, 1) == 1
        if did_swing:
            pitch_records.append(f"would_swing({p}, {i +1}).")
            did_hit = random.randint(0, 2) == 2
            if did_hit:
                strength = "weak"
                if random.randint(0, 2) == 2:
                    strength = "single"
                    if random.randint(0, 1) == 1:
                        strength = "double"
                pitch_records.append(f"would_hit({p}, {i +1}, {strength}).")
    for base_fact in state["on_base"]:
        pitch_records.append(base_fact)
    pitch_records.append(f"was_runs({state['runs']}).")
    return pitch_records

for p in players:
    at_bat_facts = build_logic_program(p, game_state)
    with open("random_pitches.lp", "w") as f:
        f.write("\n".join(at_bat_facts))
    p = subprocess.run(["clingo", "baseball.lp", "random_pitches.lp"], capture_output=True, text=True)
    output_lines = p.stdout.split("\n")
    lines_we_care_about = []
    for line in output_lines:
        if "would_pitch(" in line:
            lines_we_care_about.append(line)
    safe_facts = []
    for line in lines_we_care_about:
        facts = sorted(lines_we_care_about[0].split())
        for fc in facts:
            if "would_" not in fc and "was_" not in fc and "player(" not in fc and "thrown_pitch(" not in fc:
                print(fc)
            if "safe(" in fc and not "was_" in fc:
                safe_facts.append("was_" + fc + ".")
            if "run(" in fc:
                game_state["runs"] += 1
    game_state["on_base"] = safe_facts
    print("CURRENT GAME STATE: ", safe_facts, "RUNS: ", game_state["runs"])