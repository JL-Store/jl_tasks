Config = {
    Framework = 'qb-core',  -- qb or esx
    Notify = 'okok',        -- okok, quasar, qb, esx
    Progressbar = 'progressbar', 
    InteractKey = 38,       -- "E" - https://docs.fivem.net/docs/game-references/controls/
    TextUI = 'okok',        -- okok, qb, esx
    Tasks = {
        lightbulb = {
            societys = {
                ['sonsofanarachy'] = {  -- Gang or Job
                    coordinates = {
                        { coord = vector3(1360.87, -704.23, 67.24), radius = 20 },
                        { coord = vector3(195.92, -1015.64, 30.09), radius = 20 }
                    },
                    texts = {
                        "Denna glödlampan behövs bytas ut, den verkar lite trasig", 
                        "Glödlampan ser helt slut ut, dags att byta?", 
                        "Lampan lyser inte ens, byt för fan."
                    },
                    -- Lämplig animation för att byta glödlampa
                    animations = { dict = "anim@mp_player_intcelebrationmale@wank", anim = "wank" }, -- "change lightbulb"-liknande animation
                    rewards = {
                        { item = 'metal', minamount = 2, maxamount = 3 },
                        { item = 'wood', minamount = 2, maxamount = 3 }
                    },
                    time = 15, -- in seconds (how long it takes to do the task)
                    timeout = 2 -- in hours
                },
                ['none'] = {  -- If it's for everyone, set this to none or unemployed
                    coordinates = {
                        { coord = vector3(100.0, -1050.0, 30.09), radius = 10 },
                        { coord = vector3(120.92, -1075.64, 30.09), radius = 20 }
                    },
                    texts = {
                        "Denna glödlampan behövs bytas ut, den verkar lite trasig", 
                        "Glödlampan ser helt slut ut, dags att byta?", 
                        "Lampan lyser inte ens, byt för fan."
                    },
                    animations = { dict = "anim@mp_player_intcelebrationmale@wank", anim = "wank" },
                    rewards = {
                        { item = 'metal', minamount = 2, maxamount = 3 },
                        { item = 'wood', minamount = 2, maxamount = 3 }
                    },
                    time = 15, -- in seconds (how long it takes to do the task)
                    timeout = 2 -- in hours
                }
            }
        },
        carpet = {
            societys = {
                ['sonsofanarchy'] = { 
                    texts = { "The carpet looks like shit, you better clean it", "The carpet looks like shit, you better clean it" },
                    coordinates = {
                        { coord = vector3(2439.71, 4970.36, 46.83), radius = 2 },
                    },
                    -- Lämplig animation för att rengöra en matta
                    animations = { dict = "amb@world_human_bum_wash@male@high@base", anim = "base" }, -- "Scrubbing the floor"
                    rewards = { { item = 'metal', minamount = 1, maxamount = 2 } },
                    timeout = 2, -- in hours
                    time = 15 -- in seconds (how long it takes to do the task)
                }
            }
        },
        mopfloor = {
            texts = { "Golvet ser smutsigt ut det skulle behöva rengöras." },
            societys = {
                ['sonsofanarchy'] = { 
                    coordinates = {
                        { coord = vector3(230.89, -1020.64, 30.09), radius = 10 },
                        { coord = vector3(250.92, -1045.64, 30.09), radius = 20 }
                    },
                    -- Lämplig animation för att moppa golvet
                    animations = { dict = "amb@world_human_janitor@male@base", anim = "base" }, 
                    rewards = {
                        { item = 'cleaning_supplies', minamount = 1, maxamount = 2 },
                        { item = 'water_bottle', minamount = 1, maxamount = 2 }
                    },
                    timeout = 2, -- in hours
                    time = 15 -- in seconds (how long it takes to do the task)
                },
                ['none'] = { 
                    coordinates = {
                        { coord = vector3(290.0, -1050.0, 30.09), radius = 10 },
                        { coord = vector3(310.92, -1075.64, 30.09), radius = 20 }
                    },
                    animations = { dict = "amb@world_human_janitor@male@base", anim = "base" },
                    rewards = {
                        { item = 'cleaning_supplies', minamount = 1, maxamount = 2 },
                        { item = 'water_bottle', minamount = 1, maxamount = 2 }
                    },
                    timeout = 2, -- in hours
                    time = 15 -- in seconds (how long it takes to do the task)
                },
            }
        }
    }
}
