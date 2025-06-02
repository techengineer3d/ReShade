# ReShade

Presets and shaders for the reshade program at https://reshade.me/ .

## Intro

I am a long time game industry veteran game developer with a background in shading, graphics and tools programming.

After discovering reshade, the "shade anywhere" program, I tried using the existing reshade shaders to improve the overall video quality and cinematic viewing experience of my movie collection.

I had a great time making different shading presets, and could not believe the vast improvements that could be achieved with reshade post-fx.

It was like watching a completely new film in some cases.

I found that it looks best when viewing 4K or 8K remasters or ultra-high definition (UHD) content.

I would like to share my reshade presets and setup this repository.

## Folders

"reshade-presets": reshade shader presets are located in this folder.

"reshade-shaders": reshade shader resources are located in this folder.

"readme": contains assets and images used in this repository's readme.md file.

## Presets

### Game Presets

I have created reshade post effect shader presets for a few games.

- Final Fantasy Ever Crisis
- Final Fantasy XIV
- Tiny Tina's Wonderland
- Wuthering Waves

The preset files are located in the following folder:

reshade-presets\TechEngineer3D

There are 3 presets for each game.
1. Base Shading : standard shading, no high dynamic range stuff.
2. HDR Natural: high dynamic range shading, uses Uncharted 2 FILMIC tonemapping.
3. HDR Vibrant: high dynamic range shading, uses Baking Labs ACES tonemapping.

The preset files follow the following naming conventions:
1. Base Shading: TechEngineer3D-GameFX-<game_title>-.ini
2. HDR Natural:  TechEngineer3D-GameFX-<game_title>-HDR-Natural-.ini
3. HDR Vibrant:  TechEngineer3D-GameFX-<game_title>-HDR-Vibrant-.ini

I have included some screenshots below.
Will update with more later.

### Movie Presets

#### TechEngineer3D-PostFX-Color-Contrast-Sharp-Bloom

This post-fx shader is for enhancing image color richness, fidelity, details, sharpness, contrast, lighting and specular highlights.

This is the result of my first post-fx shader for reshade.

After a month of experimenting and tuning parameters, I came up with the overall quality and look I was aiming for.

I have tested it with various movie scenes and am pleased with the results.

I have not tried testing this with any realtime 3D games, but since it is just post effects, it could technically work on games too.

It could probably use a little more tweaking to deal with specific scenes that have strong brightness or dark areas.

But overall, I think the results are good.

I was rather amazed at a lot of the fine details that were brought out when compared to the original movie images.

In the preset folder, there is an updated version of this preset called TechEngineer3D-PostFX-Color-Contrast-Sharp-Bloom-v2.



I have posted some screenshots below, showing the original image and reshaded image.

The small image preview on GitHub makes it hard to see many of the enhanced details.

I recommend to preview the images at full size, next to each other.

Better yet, just download the preset and shaders, and try viewing it in your movie player of choice.

### Screenshots

#### UI
Reshade UI  
![Alt text](/readme/images/Reshade-Preset-TE3D-PostFX-Color-Contrast-Sharp-Bloom.png?raw=true "Reshade UI")

#### Games

##### Final Fantasy Ever Crisis

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-BlazingOnslaught-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-BlazingOnslaught-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-BlazingOnslaught-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-CeruleanRaven-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-CeruleanRaven-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-CeruleanRaven-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-GiganticShield-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-GiganticShield-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-GiganticShield-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-GrenadeBomb-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-GrenadeBomb-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-GrenadeBomb-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-HealingWind-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-HealingWind-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-HealingWind-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-LunaticHigh-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-LunaticHigh-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-LunaticHigh-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-MindBlow-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-MindBlow-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-MindBlow-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-QueensShot-EffectsOFF.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-QueensShot-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-QueensShot-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-SealEvil-EffectsOFF.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-SealEvil-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-SealEvil-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-SealEvil01-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-SealEvil01-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-SealEvil01-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-SledFang-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-SledFang-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-SledFang-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-Somersault-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-Somersault-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-Somersault-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-StageOfDefeat-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-StageOfDefeat-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-StageOfDefeat-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-ValiantAttempt-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-ValiantAttempt-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-ValiantAttempt-HDR-Vibrant.png?raw=true>)  

Reshade OFF 
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-WaterKick-EffectsOFF-.png?raw=true>)  
HDR Natural (Uncharted 2 FILMIC)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-WaterKick-HDR-Natural.png?raw=true>)  
HDR Vibrant (Baking Lab ACES)
![alt text](</readme/images/games/ffevercrisis/GameFX-FFEC-LimitBreak-WaterKick-HDR-Vibrant.png?raw=true>)  

##### Rise Of The Tomb Raider

Reshade OFF  
![alt text](</readme/images/Game - Rise Of The Tomb Raider - Prophet's Tomb 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Game - Rise Of The Tomb Raider - Prophet's Tomb 01 - Reshade ON.png?raw=true> "Reshade ON")

![alt text](</readme/images/Game - Rise Of The Tomb Raider - Prophet's Tomb 02 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Game - Rise Of The Tomb Raider - Prophet's Tomb 02 - Reshade ON.png?raw=true> "Reshade ON")

##### Films

Avengers Infinity War  
Reshade OFF  
![Alt text](</readme/images/Film - Avengers - Infinity War - Group Pose 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![Alt text](</readme/images/Film - Avengers - Infinity War - Group Pose 01 - Reshade ON.png?raw=true> "Reshade ON")

Avengers Endgame  
Reshade OFF  
![Alt text](</readme/images/Film - Avengers - Endgame - Thanos 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![Alt text](</readme/images/Film - Avengers - Endgame - Thanos 01 - Reshade ON.png?raw=true> "Reshade ON")

Reshade OFF  
![Alt text](</readme/images/Film - Avengers - Endgame - Iron Man 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![Alt text](</readme/images/Film - Avengers - Endgame - Iron Man 01 - Reshade ON.png?raw=true> "Reshade ON")

The Hobbit  
Reshade OFF  
![alt text](</readme/images/Film - Hobbit - Desolation of Smaug - Bilbo & Smaug 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Hobbit - Desolation of Smaug - Bilbo & Smaug 01 - Reshade ON.png?raw=true> "Reshade ON")

Jurassic Park  
Reshade OFF  
![alt text](</readme/images/Film - Jurassic Park - TRex Paddock 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Jurassic Park - TRex Paddock 01 - Reshade ON.png?raw=true> "Reshade ON")

Star Trek III - The Search For Spock  
Reshade OFF  
![alt text](</readme/images/Film - Star Trek 3 - Excelsior's Pursuit 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON
![alt text](</readme/images/Film - Star Trek 3 - Excelsior's Pursuit 01 - Reshade ON.png?raw=true> "Reshade ON")

Star Trek VI - The Undiscovered Country  
Reshade OFF  
![alt text](</readme/images/Film - Star Trek 6 - Excelsior 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON
![alt text](</readme/images/Film - Star Trek 6 - Excelsior 01 - Reshade ON.png?raw=true> "Reshade ON")

Star Wars V - The Empire Strikes Back 
Reshade OFF  
![alt text](</readme/images/Film - Star Wars 5 - Star Destroyers 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Star Wars 5 - Star Destroyers 01 - Reshade ON.png?raw=true> "Reshade ON")

![alt text](</readme/images/Film - Star Wars 5 - Vader Chamber 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Star Wars 5 - Vader Chamber 01 - Reshade ON.png?raw=true> "Reshade ON")

Reshade OFF  
![alt text](</readme/images/Film - Star Wars 5 - Hoth - Imperial Walkers 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Star Wars 5 - Hoth - Imperial Walkers 01 - Reshade ON.png?raw=true> "Reshade ON")

Reshade OFF  
![alt text](</readme/images/Film - Star Wars 5 - Hoth - Imperial Walkers 02 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Star Wars 5 - Hoth - Imperial Walkers 02 - Reshade ON.png?raw=true> "Reshade ON")

Reshade OFF  
![alt text](</readme/images/Film - Star Wars 5 - Hoth - Imperial Walker Commander 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Star Wars 5 - Hoth - Imperial Walker Commander 01 - Reshade ON.png?raw=true> "Reshade ON")

Reshade OFF  
![alt text](</readme/images/Film - Star Wars 5 - Hoth - Luke Snow Speeder 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Star Wars 5 - Hoth - Luke Snow Speeder 01 - Reshade ON.png?raw=true> "Reshade ON")

Star Wars - Return of The Jedi  
Reshade OFF  
![alt text](</readme/images/Film - Star Wars 6 - Jabba's Sail Barge 01 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Star Wars 6 - Jabba's Sail Barge 01 - Reshade ON.png?raw=true> "Reshade ON")

Reshade OFF  
![alt text](</readme/images/Film - Star Wars 6 - Jabba's Sail Barge 02 - Reshade OFF.png?raw=true> "Reshade OFF")
Reshade ON  
![alt text](</readme/images/Film - Star Wars 6 - Jabba's Sail Barge 02 - Reshade ON.png?raw=true> "Reshade ON")


