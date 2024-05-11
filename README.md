# USB 2.0 Chipyard Generator

This branch is the combination of the dedicated USB2.0 submodule branches as of May 10, midnight.
Note that that considering the teams' various implemetations, the fool-proof way of merging into main without polluting invididual branches is:

- Checkout the branch in question (```checkout slowy-rx```) 
- Make a clone of the branch in question (```checkout -b slowy-rx-clone```) 
- Pull from main and follow the command git recommends using for upstream (```git pull origin main```)
- There will be conflicts, many - due to main's directory structure - fix them 
- Push changes to branch (```git add / commit / push```)
- Create a PR request to main, approve it (obama awarding obama meme .jpg)
- Delete the clone branch

Bonus: got a whole bunch of deleted files, like build files popping up, that aren't getting staged? Try:

```git status | grep 'deleted:' | cut -d':' -f2  | xargs -t   -I {}  git add  -u "{}"```

This segment will be updated with a proper overview once full-USB PAR is made possible.

**COMING SOON**