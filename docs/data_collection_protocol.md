# Data Collection Protocol — READ BEFORE RECORDING

A trained policy can only be as good as the demos. Sloppy data = wasted GPU hours
and a robot that flails. Follow this every session, no exceptions.

## Task definition (pilot)

**One episode = pick up ONE VEX piece (gear) from the pickup zone and place it in
the container, then return to the home position.**

- Episode length target: 10–15 seconds. Max 15s (set in `configs/setup.env`).
- Smooth, deliberate motions. Not slow-motion, but no jerky corrections.
- Same drop point over the container every time.

## Scene rules (the big one)

- [ ] Arm clamped to the table in its marked position
- [ ] Camera rigidly mounted; position taped/marked. **NEVER moved mid-dataset.**
- [ ] Container in its marked position
- [ ] Same lighting every session (same lamp, same brightness; avoid windows/daylight shifts)
- [ ] Pickup zone marked with tape

If ANYTHING in the scene must move, that's a NEW dataset. Don't mix.

## Episode procedure

1. Scatter 5–10 pieces in the pickup zone (random positions/orientations each episode — this variety is what teaches the policy to generalize)
2. Start episode
3. Pick one piece, place in container, return to home pose
4. End episode
5. During reset time: re-scatter as needed

## During recording

- **Watch the camera feed, not the follower arm.** The policy only sees the cameras —
  if you demo using info the cameras can't see, the policy can't reproduce it.
- Botched a demo (dropped the piece, missed grasp, knocked the pile)? **Re-record the episode**
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

Datasets: `<task>_<version>` → `gear_v1`, `gear_v2`...
New version whenever the scene, camera, or task changes. Batches recorded
separately can be merged later with `scripts/merge_datasets.sh`.
