# Data Collection Protocol — READ BEFORE RECORDING

A trained policy can only be as good as the demos. Sloppy data = wasted GPU hours
and a robot that flails. Follow this every session, no exceptions.

## Task definition (pilot)

**One episode = pick up ONE screw from the spread-out layer and drop it into the
screw sorter ramp, then return to the home position.**

- Episode length target: 10–15 seconds. Max 20s (set in `configs/setup.env`).
- Smooth, deliberate motions. Not slow-motion, but no jerky corrections.
- Same drop point over the sorter every time.

## Scene rules (the big one)

- [ ] Arm clamped to the table in its marked position
- [ ] Cameras rigidly mounted; positions taped/marked. **NEVER moved mid-dataset.**
- [ ] Sorter ramp in its marked position
- [ ] Same lighting every session (same lamp, same brightness; avoid windows/daylight shifts)
- [ ] Screw pickup zone marked with tape

If ANYTHING in the scene must move, that's a NEW dataset. Don't mix.

## Episode procedure

1. Scatter 5–10 screws in the pickup zone (random positions/orientations each episode — this variety is what teaches the policy to generalize)
2. Start episode
3. Pick one screw, drop in sorter, return to home pose
4. End episode
5. During reset time: re-scatter as needed

## During recording

- **Watch the camera feed, not the follower arm.** The policy only sees the cameras —
  if you demo using info the cameras can't see, the policy can't reproduce it.
- Botched a demo (dropped screw, missed grasp, knocked the pile)? **Re-record the episode**
  (recording UI supports redoing the current episode). Don't keep garbage episodes.
- Take a break every ~20 episodes. Tired teleop = sloppy data.

## Quality bar

- First real dataset: **50 clean episodes**, then we train and see.
- Failed-then-recovered grasps are actually GOOD data if the recovery is clean —
  a few of these teach the policy to retry. Keep ~5-10% of episodes like this.

## Logging (mandatory)

After every session, add a row to `docs/lab_notebook.md`:
date, who, dataset name, # episodes, scene changes, anything weird.

## Naming convention

Datasets: `<task>_<version>` → `screws_pilot_v1`, `screws_pilot_v2`...
New version whenever the scene, camera, or task changes.
