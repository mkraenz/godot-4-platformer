# Godot Pixel Platformer

Following and extending the tutorial of HeartBeast from [youtube](https://www.youtube.com/playlist?list=PL9FzW-m48fn16W1Sz5bhTd1ArQQv4f-Cm).

Tileset Art from [kenney.nl](https://kenney.nl/assets/pixel-platformer).

Parallax sky background by [UnholyMoly from OpenGameArt](https://opengameart.org/content/platformer-colorful-adventure-16x16).

Original music created with BeepBox. [Source here (click edit at bottom right)](https://www.beepbox.co/player/#song=9n31s2k0l00e0bt2ma7g0fj07r1i0o432T1v1uaaf0q0x10kb1d35A2F0BcQ2d00Pc550E2bg7eT0v1u10f0qg01d04w2h0E0T1v1u92f30o21962pcq0x10w02d16A8F4B3Qd107P5a93E2b9639T4v1uf0f0q011z6666ji8k8k3jSBKSJJAArriiiiii07JCABrzrrrrrrr00YrkqHrsrrrrjr005zrAqzrjzrrqr1jRjrqGGrrzsrsA099ijrABJJJIAzrrtirqrqjqixzsrAjrqjiqaqqysttAJqjikikrizrHtBJJAzArzrIsRCITKSS099ijrAJS____Qg99habbCAYrDzh00E0b4h4z8M15000h4i8y4h40014h000000004h400000000p21pkQuizbwbqjbEe3R3bFGFe3JHbVvjhghSQ4tdh7qpsLGEE8WW3nEcImq_wcCLMYGYHaLabYyJ5axaYOYHcELOa0000)

## Thoughts on Persistence / Save Data / Saving / Loading

What should be persisted / loaded?

on load, player should:

- be in the most recently played level
- be at the most recently activated checkpoint or at level start if none have been activated yet
- all activated checkpoints and switches should still be active (or at least not in the active level)
- players health and keys are identical
- collected keys should _not_ show up again (or at least not in the active level)
- opened locks should still be open (or at least not in the active level)

Idea 1:

```ts
{
    player: {
        level: [levelId],
        position: MyGlobalPosition,
        health: PlayerStats.health,
        maxHealth: PlayerStats.max_health,
        keys: PlayerStats.max_keys,
    }
    levels: {
        [levelId]: {
            completed: false,
            checkpoints: {
                [id]: {
                    activated: true
                }
            },
            keys: {
                [id]: {
                    collected: true
                }
            },
            locks: {
                [id]: {
                    opened: true
                }
            },
            switches: {
                [id]: {
                    activated: true
                }
            },
        },
    }
}
```

Additionally, have an in-code map from levelids to level paths. This is done in-code so that we can change level names etc without breaking save games. Ids should always stay the same and be statically generated and manually added to the scene instances.

Example:

```gdscript
var LevelIdsToPaths = {
    [id]: "res://Levels/Level2/Level2.tscn"
}
```

Idea 2:

```ts
{
    player: {
        levelId: [id],
        position: MyGlobalPositionInTheCurrentLevel,
        health: PlayerStats.health,
        maxHealth: PlayerStats.max_health,
        keys: PlayerStats.keys,
    }
    [id]: {
        type: [name] // e.g. Level, Key, Switch
        // object specific data, e.g. level { completed: false }, checkpoint { activated: true }, locks { opened: true }, switch { activated: true }, key { collected: true }
    }
}
```

Additionally, have the level-Id-to-Path map from idea 1.

Advantage: objects can easily be looked up by ID. No object needs to know about the layout of the save file because its so simple.

~~Disadvantage: not clear what type of object it is~~

Idea 3:

following KIS:

```ts
{
    player:{
        levelId: [id],
        health: PlayerStats.health,
        maxHealth: PlayerStats.max_health,
        keys: PlayerStats.keys,
    }
}
```

Reload levels completely.
