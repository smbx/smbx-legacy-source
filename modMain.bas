Attribute VB_Name = "modMain"
Option Explicit
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public Declare Function StretchBlt Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As Long) As Long
Public Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Public Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function GetDC Lib "user32" (ByVal hWnd As Long) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Public Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer
Public Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Integer, ByVal hwndCallback As Integer) As Integer
Public Declare Function SetCursorPos Lib "user32" (ByVal X As Long, ByVal Y As Long) As Long
Public Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Public Declare Function GetDesktopWindow Lib "user32.dll" () As Long
Public Declare Function GetWindowDC Lib "user32.dll" (ByVal hWnd As Long) As Long
Declare Function GetActiveWindow Lib "user32" () As Integer
Public Declare Function GetTickCount& Lib "kernel32" ()
Public OnlineDisc As Boolean


'Saved Events
Public Const MaxSavedEvents As Integer = 200
Public numSavedEvents As Integer
Public SavedEvents(1 To MaxSavedEvents) As String
Public BlockSwitch(1 To 4) As Boolean
'Public PowerUpUnlock(2 To 7) As Boolean


Public Const ScreenW As Integer = 800  'Game Screen Width
Public Const ScreenH As Integer = 600  'Game Screen Height
Public Const SWP_SHOWWINDOW = &H40
Public Const SWP_NOMOVE As Long = 2
Public Const SWP_NOSIZE As Long = 1
Public Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
Public Const HWND_TOPMOST As Long = -1
Public Const HWND_NOTOPMOST As Long = -2
Public myBackBuffer As Long 'Backbuffer
Public myBufferBMP As Long 'Backbuffer
Public AllCharBlock As Integer
Public Const KEY_TOGGLED As Integer = &H1   'For control information
Public Const KEY_PRESSED As Integer = &H1000    'For control information
Public LocalNick As String  'Online Nickname
Public LocalCursor As Integer  'Online Cursor color
Public ClientPassword As String  'Password client is connecting with
Public ServerPassword As String  'Password game server wants the client to use
Public ServerClear As Boolean
Public StartMenu As Boolean
Public BlockFlash As Integer
Public ScrollRelease As Boolean
Public TakeScreen As Boolean
Public LB As String  ' Line Break
Public EoT As String  ' End of Transmission for WINSOCK
Public Type Controls 'Controls for the player
    Up As Boolean
    Down As Boolean
    Left As Boolean
    Right As Boolean
    Jump As Boolean
    AltJump As Boolean
    Run As Boolean
    AltRun As Boolean
    Drop As Boolean
    Start As Boolean
End Type
Public Type nPlayer  'online player type
    Controls As Controls  'online players controls
    Cursor As Integer
    IsMe As Boolean  'True if this player is the local player
    Nick As String
    Active As Boolean  'True if a player is using this variable
    ECurserX As Double  'Cursor X position
    ECurserY As Double   'Cursor Y position
End Type
Public Type nPlay  'Netplay data type
    Allow As Boolean
    Mode As Integer  'Server or client
    ServerIP As String 'Server's IP
    ServerCon As Boolean 'Server is connected
    ServerStr As String
    ServerLocked As Boolean
    ServerLoad1 As Double
    ServerLoad As Boolean
    ClientLocked(0 To 15) As Boolean
    ClientIP(0 To 15) As String
    ClientCon(0 To 15) As Boolean
    ClientName(0 To 15) As String
    ClientStr(0 To 15) As String
    ClientRelease(0 To 15) As Integer
    ClientPassword(0 To 15) As Boolean
    ClientLoad1(0 To 15) As Double
    Online As Boolean 'online or local
    MySlot As Integer
    MyControls As Controls
    Player(0 To 15) As nPlayer
    PlayerWaitCount As Integer
    NPCWaitCount As Single
End Type
Public Type Location    'Holds location information for objects
    X As Double
    Y As Double
    Height As Double
    Width As Double
    SpeedX As Double
    SpeedY As Double
End Type
Public Type EditorControls      'Controls for the editor
    Up As Boolean
    Down As Boolean
    Left As Boolean
    Right As Boolean
    Mouse1 As Boolean
End Type
Public Type conKeyboard  'Input settings for the keyboard
    Up As Integer
    Down As Integer
    Left As Integer
    Right As Integer
    Jump As Integer
    Run As Integer
    Drop As Integer
    Start As Integer
    AltJump As Integer
    AltRun As Integer
End Type
Public Type conJoystick   'Input settings for the joystick
    Jump As Integer
    Run As Integer
    Drop As Integer
    Start As Integer
    AltJump As Integer
    AltRun As Integer
End Type
Public conKeyboard(1 To 2) As conKeyboard  'player 1 and 2's controls
Public conJoystick(1 To 2) As conJoystick
Public useJoystick(1 To 2) As Integer
Public Type NPC 'The NPC Type
    AttLayer As String
    Quicksand As Integer
    RespawnDelay As Integer
    Bouce As Boolean
    Pinched1 As Integer  'getting smashed by a block
    Pinched2 As Integer
    Pinched3 As Integer
    Pinched4 As Integer
    MovingPinched As Integer 'required to be smashed
    NetTimeout As Integer 'for online
    RealSpeedX As Single 'the real speed of the NPC
    Wet As Integer ' greater then 0 of the NPC is in water
    Settings As Integer
    NoLavaSplash As Boolean 'true for no lava splash
    Slope As Integer 'the block that the NPC is on a slope with
    Multiplier As Integer 'for upping the points the player recieves
    TailCD As Integer 'if greater then 0 the player can't hit with it's tail
    Shadow As Boolean 'if true turn the NPC black and allow it to pass through walls.  only used for a cheat code
    TriggerActivate As String 'for events - triggers when NPC gets activated
    TriggerDeath As String 'triggers when NPC dies
    TriggerTalk As String 'triggers when you talk to the NPC
    TriggerLast As String 'trigger when this is the last NPC in a layer to die
    Layer As String 'the layer name that the NPC is in
    Hidden As Boolean 'if the layer is hidden or not
    Legacy As Boolean 'Legacy Boss
    Chat As Boolean 'for talking to the NPC
    Inert As Boolean 'the friendly toggle. makes the NPC not do anything
    Stuck As Boolean 'the 'don't move' toggle. forces the NPC not to move
    DefaultStuck As Boolean
    Text As String 'the text that is displayed when you talk to the NPC
    oldAddBelt As Single
    PinchCount As Integer 'obsolete
    Pinched As Boolean 'obsolete
    PinchedDirection As Integer 'obsolete
    BeltSpeed As Single 'The speed of the object this NPC is standing on
    standingOnPlayer As Integer 'If this NPC is standing on a player in the clown car
    standingOnPlayerY As Integer
    Generator As Boolean 'for spawning new NPCs
    GeneratorTimeMax As Single
    GeneratorTime As Single
    GeneratorDirection As Integer
    GeneratorEffect As Integer
    GeneratorActive As Boolean
    playerTemp As Boolean
    Location As Location 'collsion detection information
'the default values are used when De-Activating an NPC when it goes on screen
    DefaultLocation As Location
    DefaultDirection As Single
    DefaultType As Integer
    DefaultSpecial As Integer
    DefaultSpecial2 As Integer
    Type As Integer 'Defines what NPC this is.  1 for goomba, 2 for red goomba, etc.
    Frame As Integer 'The graphic to be shown
    FrameCount As Single 'The counter for incrementing the frames
    Direction As Single 'The direction the NPC is walking
'Secial - misc variables used for NPC AI
    Special As Double
    Special2 As Double
    Special3 As Double
    Special4 As Double
    Special5 As Double
    Special6 As Double
    TurnAround As Boolean 'if the NPC needs to turn around
    Killed As Integer 'Flags the NPC to die a specific way.
    Active As Boolean 'If on screen
    Reset(1 To 2) As Boolean 'If it can display the NPC
    TimeLeft As Integer 'Time left before reset when not on screen
    HoldingPlayer As Integer 'Who is holding it
    CantHurt As Integer 'Won't hurt the player
    CantHurtPlayer As Integer
    BattleOwner As Integer 'Owner of the projectile
    WallDeath As Integer
    Projectile As Boolean 'If the NPC is a projectile
    Effect As Integer 'For starting / stopping effects
    Effect2 As Double
    Effect3 As Integer
    Section As Integer 'what section of the level the NPC is in
    Damage As Single
    JustActivated As Integer 'The player that activated the NPC
    Block As Integer 'Used when a P-Switch turns a block into a coint
    tempBlock As Integer
    onWall As Boolean
    TurnBackWipe As Boolean
    Immune As Integer 'time that the NPC is immune
End Type
Public Type Player              'The player data type.
    DoubleJump As Boolean
    FlySparks As Boolean
    Driving As Boolean
    Quicksand As Integer
    Bombs As Integer
    Slippy As Boolean
    Fairy As Boolean
    FairyCD As Integer
    FairyTime As Integer
    HasKey As Boolean
    SwordPoke As Integer
    Hearts As Integer
    CanFloat As Boolean
    FloatRelease As Boolean
    FloatTime As Integer
    FloatSpeed As Single
    FloatDir As Integer
    GrabTime As Integer 'how long the player has been trying to grab an npc from above
    GrabSpeed As Single
    VineNPC As Double 'the NPC that the player is climbing
    Wet As Integer 'weather or not the player is under water
    WetFrame As Boolean 'true if the play should be swimming
    SwimCount As Integer 'cool down between swim strokes
    NoGravity As Integer
    Slide As Boolean 'true if the player is sliding
    SlideKill As Boolean 'true if the player is sliding fast enough to kill an NPC
    Vine As Integer 'greater then 0 if the player is climbing
    NoShellKick As Integer 'dont kick a shell
    ShellSurf As Boolean 'true if surfing a shell
    StateNPC As Integer
    Slope As Integer 'the block that the player is standing on when on a slope
    Stoned As Boolean 'true of a statue form (tanooki suit)
    StonedCD As Integer 'delay before going back in to stone form
    StonedTime As Integer 'how long the player can remain as a statue
    SpinJump As Boolean 'true if spin jumping
    SpinFrame As Integer 'frame for spinning
    SpinFireDir As Integer 'for shooting fireballs while spin jumping
    Multiplier As Integer 'for score increase for multiple hops
    SlideCounter As Integer 'for creating the dust effect when sliding
    ShowWarp As Integer
    GroundPound As Boolean 'for purple yoshi pound
    GroundPound2 As Boolean 'for purple yoshi pound
    CanPound As Boolean 'for purple yoshi pound
    ForceHold As Integer  'force the player to hold an item for a specific amount of time
'yoshi powers
    YoshiYellow As Boolean
    YoshiBlue As Boolean
    YoshiRed As Boolean
    YoshiWingsFrame As Integer
    YoshiWingsFrameCount As Integer
'yoshi graphic display
    YoshiTX As Integer
    YoshiTY As Integer
    YoshiTFrame As Integer
    YoshiTFrameCount As Integer
    YoshiBX As Integer
    YoshiBY As Integer
    YoshiBFrame As Integer
    YoshiBFrameCount As Integer
    YoshiTongue As Location
    YoshiTongueX As Single
    YoshiTongueLength As Integer 'length of yoshi's tongue
    YoshiTonugeBool As Boolean
    YoshiNPC As Integer 'the NPC that is in yoshi's mouth
    YoshiPlayer As Integer 'the player that is in yoshi's mouth
    Dismount As Integer 'delay before you can remount
    NoPlayerCol As Integer
    Location As Location 'collision detection info
    Character As Integer 'luigi or mario
    Controls As Controls 'players controls
    Direction As Integer 'the way the player is facing
    Mount As Integer '1 for boot, 2 for clown car, 3 for yoshi
    MountType As Integer 'for different types of mounts. blue yoshi, red yoshi, etc
    MountSpecial As Integer
    MountOffsetY As Integer
    MountFrame As Integer 'GFX frame for the player's mount
    State As Integer '1 for small mario, 2 for super, 3 for fire, 4 for racoon, 5 for tanooki, 6 for hammer
    Frame As Integer
    FrameCount As Single
    Jump As Integer 'how long the player can jump for
    CanJump As Boolean 'true if the player can jump
    CanAltJump As Boolean 'true if the player can alt jump
    Effect As Integer 'for various effects like shrinking/growing/warping
    Effect2 As Double 'counter for the effects
    DuckRelease As Boolean
    Duck As Boolean 'true if ducking
    DropRelease As Boolean
    StandUp As Boolean 'aid with collision detection after ducking
    StandUp2 As Boolean
    Bumped As Boolean 'true if hit by another player
    Bumped2 As Single
    Dead As Boolean 'true if dead
    TimeToLive As Integer 'for returning to the other play after dying
    Immune As Integer 'greater then 0 if immune, this is a counter
    Immune2 As Boolean 'makes the player blink
    ForceHitSpot3 As Boolean 'force hitspot 3 for collision detection
'for getting smashed by a block
    Pinched1 As Integer
    Pinched2 As Integer
    Pinched3 As Integer
    Pinched4 As Integer
    NPCPinched As Integer 'must be > 0 for the player to get crushed
    m2Speed As Single
    HoldingNPC As Integer 'What NPC is being held
    CanGrabNPCs As Boolean 'If the player can grab NPCs
    HeldBonus As Integer 'the NPC that is in the player's container
    Section As Integer 'What section of the level the player is in
    WarpCD As Integer 'delay before allowing the player to warp again
    Warp As Integer 'the warp the player is using
    FireBallCD As Integer 'How long the player has to wait before he can shoot again
    FireBallCD2 As Integer 'How long the player has to wait before he can shoot again
    TailCount As Integer 'Used for the tail swipe
    RunCount As Single 'To find how long the player has ran for
    CanFly As Boolean 'If the player can fly
    CanFly2 As Boolean
    FlyCount As Integer 'length of time the player can fly
    RunRelease As Boolean 'The player let go of run and pressed again
    JumpRelease As Boolean 'The player let go of run and pressed again
    StandingOnNPC As Integer 'The NPC the player is standing on
    StandingOnTempNPC As Integer 'The NPC the player is standing on
    UnStart As Boolean 'Player let go of the start button
    mountBump As Single 'Player hit something while in a mount
    SpeedFixY As Single
End Type
Public Type Background  'Background objects
    Layer As String
    Hidden As Boolean
    Type As Integer
    Location As Location
End Type
Public Type Water
    Layer As String
    Hidden As Boolean
    Buoy As Single 'not used
    Quicksand As Boolean
    Location As Location
End Type
Public Type Block   'Blocks
    Slippy As Boolean
    RespawnDelay As Integer
    RapidHit As Integer
    DefaultType As Integer
    DefaultSpecial As Integer
'for event triggers
    TriggerHit As String
    TriggerDeath As String
    TriggerLast As String
    Layer As String
    Hidden As Boolean
    Type As Integer 'the block's type
    Location As Location
    Special As Integer 'what is in the block?
'for the shake effect after hitting ablock
    ShakeY As Integer
    ShakeY2 As Integer
    ShakeY3 As Integer
    Kill As Boolean 'if true the game will destroy the block
    Invis As Boolean 'for invisible blocks
    NPC As Integer 'when a coin is turned into a block after the p switch is hit
    IsPlayer As Integer 'for the clown car
    IsNPC As Integer 'the type of NPC the block is
    standingOnPlayerY As Integer 'when standing on a player in the clown car
    noProjClipping As Boolean
    IsReally As Integer 'the NPC that is this block
End Type
Public Type Effect  'Special effects
    Type As Integer
    Location As Location
    Frame As Integer
    FrameCount As Single
    Life As Integer 'timer before the effect disappears
    NewNpc As Integer 'when an effect should create and NPC, such as Yoshi
    Shadow As Boolean 'for a black effect set to true
End Type
Public Type vScreen 'Screen controls
    Left As Double
    Top As Double
    Width As Double
    Height As Double
    Visible As Boolean
    tempX As Double
    TempY As Double
    TempDelay As Integer
End Type
Public Type WorldLevel 'the type for levels on the world map
    Location As Location
    Type As Integer
    FileName As String 'level's file
    LevelExit(1 To 4) As Integer ' For the direction each type of exit opens the path
    Active As Boolean
    LevelName As String 'The name of the level
    StartWarp As Integer 'If the level should start with a player exiting a warp
    WarpX As Double 'for warping to another location on the world map
    WarpY As Double
    Path As Boolean 'for drawing a small path background
    Path2 As Boolean 'big path background
    Start As Boolean 'true if the game starts here
    Visible As Boolean 'true if it should be shown on the map
End Type
Public Type Warp 'warps such as pipes and doors
    Locked As Boolean 'requires a key NPC
    WarpNPC As Boolean 'allows NPC through the warp
    NoYoshi As Boolean 'don't allow yoshi
    Layer As String 'the name of the layer
    Hidden As Boolean 'if the layer is hidden
    PlacedEnt As Boolean 'for the editor, flags the entranced as placed
    PlacedExit As Boolean
    Stars As Integer 'number of stars required to enter
    Entrance As Location 'location of warp entrance
    Exit As Location 'location of warp exit
    Effect As Integer 'style of warp. door/
    level As String 'filename of the level it should warp to
    LevelWarp As Integer
    LevelEnt As Boolean 'this warp can't be used if set to true (this is for level entrances)
    Direction As Integer 'direction of the entrance for pipe style warps
    Direction2 As Integer 'direction of the exit
    MapWarp As Boolean
    MapX As Integer
    MapY As Integer
    curStars As Integer
    maxStars As Integer
End Type
Public Type Tile 'Tiles for the World
    Location As Location
    Type As Integer
End Type
Public Type Scene 'World Scenery
    Location As Location
    Type As Integer
    Active As Boolean 'if false this won't be shown. used for paths that become available on a scene
End Type
Public Type WorldPath 'World Paths
    Location As Location
    Active As Boolean
    Type As Integer
End Type
Public Type WorldMusic 'World Music
    Location As Location
    Type As Integer
End Type
Public Type EditorCursor 'The editor's cursor
    X As Single
    Y As Single
    SelectedMode As Integer 'cursor mode. eraser/npc/block/background
    Selected As Integer
    Location As Location
    Layer As String 'current layer
    Mode As Integer
    Block As Block
    Water As Water
    Background As Background
    NPC As NPC
    Warp As Warp
    Tile As Tile
    Scene As Scene
    WorldLevel As WorldLevel
    WorldPath As WorldPath
    WorldMusic As WorldMusic
End Type
Public Type WorldPlayer 'the players variables on the world map
    Location As Location
    Type As Integer
    Frame As Integer
    Frame2 As Integer
    Move As Integer
    Move2 As Integer
    Move3 As Boolean
    LevelName As String
End Type
Public Type Layer
    EffectStop As Boolean
    Name As String
    Hidden As Boolean
    SpeedX As Single
    SpeedY As Single
End Type
Public Type CreditLine
    Location As Location
    Text As String
End Type
Public ScreenShake As Integer
Public Checkpoint As String 'the filename of the level the player has a checkpoint in
Public MagicHand As Boolean 'true if playing a level in the editor while not in fullscreen mode
Public testPlayer(1 To 2) As Player 'test level player settings
Public ClearBuffer As Boolean 'true to black the backbuffer
Public numLocked As Integer
Public resChanged As Boolean 'true if in fullscreen mode
Public inputKey As Integer 'for setting the players controls
Public getNewKeyboard As Boolean 'true if setting keyboard controls
Public getNewJoystick As Boolean
Public lastJoyButton As Integer
Public GamePaused As Boolean 'true if the game is paused
Public MessageText As String 'when talking to an npc
Public NumSelectWorld As Integer
Public SelectWorld(1 To 100) As SelectWorld
Public ShowFPS As Boolean
Public PrintFPS As Double
Public vScreen(0 To 2) As vScreen 'Sets up the players screens
Public ScreenType As Integer 'The screen/view type
Public DScreenType As Integer 'The dynamic screen setup
Public LevelEditor As Boolean 'if true, load the editor
Public WorldEditor As Boolean
Public PlayerStart(1 To 2) As Location
Public Const vScreenYOffset As Integer = 0     'Players Y on the screen
Public Const maxBlocks As Integer = 20000  'Max # of blocks
Public Const maxPlayers As Integer = 200  'Holds the max number of players
Public Const maxEffects As Integer = 1000    'Max # of effects
Public Const maxNPCs As Integer = 5000    'Max # of NPCs
Public Const maxBackgrounds As Integer = 8000    'Max # of background objects
Public Const maxPlayerFrames As Integer = 750 'Maximum number of player frames
Public Const maxBlockType As Integer = 700 'Maximum number of block types
Public Const maxBackgroundType As Integer = 200 'Maximum number of background types
Public Const maxSceneType As Integer = 100 'Maximum number of scenetypes
Public Const maxNPCType As Integer = 300 'Maximum number of NPC types
Public Const maxEffectType As Integer = 200 'Maximum number of effect types
Public Const maxWarps As Integer = 200 'Maximum number of warps
Public Const numBackground2 As Integer = 100  'Total # of backgrounds
Public Const numCharacters As Integer = 5 'Maximum number of player characters
Public Const numStates As Integer = 7   'Maximum number of player states
Public Const maxWater As Integer = 1000
Public Const maxWorldLevels As Integer = 400   'Maximum number of levels
Public Const maxWorldPaths As Integer = 2000   'Maximum number of paths
Public Const maxWorldMusic As Integer = 1000   'Maximum number of musics
Public Const numSounds As Integer = 100
Public Const maxSections As Integer = 20
Public Const maxTileType As Integer = 400
Public Const maxLevelType As Integer = 100
Public Const maxPathType As Integer = 100
Public Const maxTiles As Integer = 20000
Public Const maxScenes As Integer = 5000
Public Const frameRate As Double = 15 'for controlling game speed
Public blockCharacter(0 To 20) As Boolean
Public Type SelectWorld
    WorldName As String
    WorldPath As String
    WorldFile As String
    blockChar(1 To numCharacters) As Boolean
End Type
Public OwedMount(0 To maxPlayers) As Integer 'when a yoshi/boot is taken from the player this returns after going back to the world map
Public OwedMountType(0 To maxPlayers) As Integer
Public AutoX(0 To maxSections) As Single 'for autoscroll
Public AutoY(0 To maxSections) As Single 'for autoscroll
Public numStars As Integer 'the number of stars the player has
Public Type Star 'keeps track of where there player got the stars from
    level As String
    Section As Integer
End Type
Public nPlay As nPlay ' for online stuff
Public Water(0 To maxWater) As Water
Public numWater As Integer 'number of water
Public Star(1 To 1000) As Star
Public GoToLevel As String
Public StartLevel As String 'start level for an episode
Public NoMap As Boolean 'episode has no world map
Public RestartLevel As Boolean 'restart the level on death
Public LevelChop(0 To maxSections) As Single 'for drawing backgrounds when the level has been shrunk
'collision detection optimization. creates a table of contents for blocks
Public Const FLBlocks As Long = 8000
Public FirstBlock(-FLBlocks To FLBlocks) As Integer
Public LastBlock(-FLBlocks To FLBlocks) As Integer
Public MidBackground As Integer 'for drawing backgrounds
Public LastBackground As Integer 'last backgrounds to be drawn
Public iBlocks As Integer 'blocks that are doing something. this keeps the number of interesting blocks
Public iBlock(0 To maxBlocks) As Integer 'references a block #
Public numTiles As Integer 'number of map tiles
Public numScenes As Integer 'number of scense
Public CustomMusic(0 To maxSections) As String 'section's custom music
Public level(0 To maxSections) As Location 'sections
Public LevelWrap(0 To maxSections) As Boolean 'Wrap around the level
Public OffScreenExit(0 To maxSections) As Boolean 'walk offscreen to end the level
Public bgMusic(0 To maxSections) As Integer 'music
Public bgMusicREAL(0 To maxSections) As Integer 'default music
Public Background2REAL(0 To maxSections) As Integer 'background
Public LevelREAL(0 To maxSections) As Location 'default background
Public curMusic As Integer 'current music playing
Public bgColor(0 To maxSections) As Long 'obsolete
Public Background2(0 To maxSections) As Integer 'level background
Public WorldPath(1 To maxWorldPaths) As WorldPath
Public numWorldPaths As Integer
Public numWarps As Integer 'number of warps in a level
Public Warp(1 To maxWarps) As Warp 'define the warps
Public Tile(1 To maxTiles) As Tile
Public Scene(1 To maxScenes) As Scene
Public Credit(1 To 200) As CreditLine 'for end game credits
Public numCredits As Integer 'number of credits
Public numBlock As Integer 'number of blocks
Public numBackground As Integer 'number of background objects
Public numNPCs As Integer
Public numEffects As Integer
Public numPlayers As Integer
Public numWorldLevels As Integer
Public WorldMusic(1 To maxWorldMusic) As WorldMusic
Public numWorldMusic As Integer
Public WorldLevel(1 To maxWorldLevels) As WorldLevel
Public Background(1 To maxBackgrounds) As Background
Public Effect(1 To maxEffects) As Effect
Public NPC(-128 To maxNPCs) As NPC
Public Block(0 To maxBlocks) As Block
Public Player(0 To maxPlayers) As Player
Public MarioFrameX(0 To maxPlayerFrames) As Integer 'Player frame offset X
Public MarioFrameY(0 To maxPlayerFrames) As Integer 'Player frame offset Y
Public LuigiFrameX(0 To maxPlayerFrames) As Integer 'Player frame offset X
Public LuigiFrameY(0 To maxPlayerFrames) As Integer 'Player frame offset Y
Public PeachFrameX(0 To maxPlayerFrames) As Integer 'Player frame offset X
Public PeachFrameY(0 To maxPlayerFrames) As Integer 'Player frame offset Y
Public ToadFrameX(0 To maxPlayerFrames) As Integer 'Player frame offset X
Public ToadFrameY(0 To maxPlayerFrames) As Integer 'Player frame offset Y
Public LinkFrameX(0 To maxPlayerFrames) As Integer 'Player frame offset X
Public LinkFrameY(0 To maxPlayerFrames) As Integer 'Player frame offset Y
Public BackgroundFence(0 To maxBackgroundType) As Boolean
Public NPCFrameOffsetX(0 To maxNPCType) As Integer 'NPC frame offset X
Public NPCFrameOffsetY(0 To maxNPCType) As Integer 'NPC frame offset Y
Public NPCWidth(0 To maxNPCType) As Integer 'NPC width
Public NPCHeight(0 To maxNPCType) As Integer 'NPC height
Public NPCWidthGFX(0 To maxNPCType) As Integer 'NPC gfx width
Public NPCHeightGFX(0 To maxNPCType) As Integer 'NPC gfx height
Public NPCSpeedvar(0 To maxNPCType) As Single 'NPC Speed Change
Public NPCIsAShell(0 To maxNPCType) As Boolean 'Flags the NPC type if it is a shell
Public NPCIsABlock(0 To maxNPCType) As Boolean 'Flag NPC as a block
Public NPCIsAHit1Block(0 To maxNPCType) As Boolean 'Flag NPC as a hit1 block
Public NPCIsABonus(0 To maxNPCType) As Boolean 'Flags the NPC type if it is a bonus
Public NPCIsACoin(0 To maxNPCType) As Boolean 'Flags the NPC type if it is a coin
Public NPCIsAVine(0 To maxNPCType) As Boolean 'Flags the NPC type if it is a vine
Public NPCIsAnExit(0 To maxNPCType) As Boolean 'Flags the NPC type if it is a level exit
Public NPCIsAParaTroopa(0 To maxNPCType) As Boolean 'Flags the NPC type as a para-troopa
Public NPCIsCheep(0 To maxNPCType) As Boolean 'Flags the NPC type as a cheep cheep
Public NPCJumpHurt(0 To maxNPCType) As Boolean 'Hurts the player even if it jumps on the NPC
Public NPCNoClipping(0 To maxNPCType) As Boolean 'NPC can go through blocks
Public NPCScore(0 To maxNPCType) As Integer 'NPC score value
Public NPCCanWalkOn(0 To maxNPCType) As Boolean  'NPC can be walked on
Public NPCGrabFromTop(0 To maxNPCType) As Boolean  'NPC can be grabbed from the top
Public NPCTurnsAtCliffs(0 To maxNPCType) As Boolean  'NPC turns around at cliffs
Public NPCWontHurt(0 To maxNPCType) As Boolean  'NPC wont hurt the player
Public NPCMovesPlayer(0 To maxNPCType) As Boolean 'Player can not walk through the NPC
Public NPCStandsOnPlayer(0 To maxNPCType) As Boolean 'for the clown car
Public NPCIsGrabbable(0 To maxNPCType) As Boolean 'Player can grab the NPC
Public NPCIsBoot(0 To maxNPCType) As Boolean 'npc is a kurbo's shoe
Public NPCIsYoshi(0 To maxNPCType) As Boolean 'npc is a yoshi
Public NPCIsToad(0 To maxNPCType) As Boolean 'npc is a toad
Public NPCNoYoshi(0 To maxNPCType) As Boolean 'Player can't eat the NPC
Public NPCForeground(0 To maxNPCType) As Boolean 'draw the npc in front
Public NPCIsABot(0 To maxNPCType) As Boolean 'Zelda 2 Bot monster
Public NPCDefaultMovement(0 To maxNPCType) As Boolean 'default NPC movement
Public NPCIsVeggie(0 To maxNPCType) As Boolean 'turnips
Public NPCNoFireBall(0 To maxNPCType) As Boolean 'not hurt by fireball
Public NPCNoIceBall(0 To maxNPCType) As Boolean 'not hurt by fireball
Public NPCNoGravity(0 To maxNPCType) As Boolean 'not affected by gravity

Public NPCFrame(0 To maxNPCType) As Integer
Public NPCFrameSpeed(0 To maxNPCType) As Integer
Public NPCFrameStyle(0 To maxNPCType) As Integer

Public Type NPCDefaults 'Default NPC Settings
    NPCFrameOffsetX(0 To maxNPCType) As Integer
    NPCFrameOffsetY(0 To maxNPCType) As Integer
    NPCWidth(0 To maxNPCType) As Integer
    NPCHeight(0 To maxNPCType) As Integer
    NPCWidthGFX(0 To maxNPCType) As Integer
    NPCHeightGFX(0 To maxNPCType) As Integer
    NPCIsAShell(0 To maxNPCType) As Boolean
    NPCIsABlock(0 To maxNPCType) As Boolean
    NPCIsAHit1Block(0 To maxNPCType) As Boolean
    NPCIsABonus(0 To maxNPCType) As Boolean
    NPCIsACoin(0 To maxNPCType) As Boolean
    NPCIsAVine(0 To maxNPCType) As Boolean
    NPCIsAnExit(0 To maxNPCType) As Boolean
    NPCIsAParaTroopa(0 To maxNPCType) As Boolean
    NPCIsCheep(0 To maxNPCType) As Boolean
    NPCJumpHurt(0 To maxNPCType) As Boolean
    NPCNoClipping(0 To maxNPCType) As Boolean
    NPCScore(0 To maxNPCType) As Integer
    NPCCanWalkOn(0 To maxNPCType) As Boolean
    NPCGrabFromTop(0 To maxNPCType) As Boolean
    NPCTurnsAtCliffs(0 To maxNPCType) As Boolean
    NPCWontHurt(0 To maxNPCType) As Boolean
    NPCMovesPlayer(0 To maxNPCType) As Boolean
    NPCStandsOnPlayer(0 To maxNPCType) As Boolean
    NPCIsGrabbable(0 To maxNPCType) As Boolean
    NPCIsBoot(0 To maxNPCType) As Boolean
    NPCIsYoshi(0 To maxNPCType) As Boolean
    NPCIsToad(0 To maxNPCType) As Boolean
    NPCNoYoshi(0 To maxNPCType) As Boolean
    NPCForeground(0 To maxNPCType) As Boolean
    NPCIsABot(0 To maxNPCType) As Boolean
    NPCDefaultMovement(0 To maxNPCType) As Boolean
    NPCIsVeggie(0 To maxNPCType) As Boolean
    NPCSpeedvar(0 To maxNPCType) As Single
    NPCNoFireBall(0 To maxNPCType) As Boolean
    NPCNoIceBall(0 To maxNPCType) As Boolean
    NPCNoGravity(0 To maxNPCType) As Boolean
End Type
Public NPCDefaults As NPCDefaults

Public BlockIsSizable(0 To maxBlockType) As Boolean 'Flags block if it is sizable
Public BlockSlope(0 To maxBlockType) As Integer 'block is sloped on top. -1 of block has an upward slope, 1 for downward
Public BlockSlope2(0 To maxBlockType) As Integer 'block is sloped on the bottom.
Public vScreenX(0 To maxPlayers) As Double  'vScreen offset
Public vScreenY(0 To maxPlayers) As Double 'vScreen offset

Public qScreenX(1 To maxPlayers) As Double  'vScreen offset adjust
Public qScreenY(1 To maxPlayers) As Double 'vScreen offset adjust
Public qScreen As Boolean 'Weather or not the screen needs adjusting

Public BlockWidth(0 To maxBlockType) As Integer 'Block type width
Public BlockHeight(0 To maxBlockType) As Integer 'Block type height
Public BonusWidth(1 To 100) As Integer 'Bonus type width
Public BonusHeight(1 To 100) As Integer 'Bonus type height
Public EffectWidth(1 To maxEffectType) As Integer 'Effect width
Public EffectHeight(1 To maxEffectType) As Integer 'Effect height
Public Type EffectDefaults
    EffectWidth(1 To maxEffectType) As Integer
    EffectHeight(1 To maxEffectType) As Integer
End Type
Public EffectDefaults As EffectDefaults
Public SceneWidth(1 To 100) As Integer 'Scene width
Public SceneHeight(1 To 100) As Integer 'Scene height
Public BackgroundHasNoMask(1 To maxBackgroundType) As Boolean
Public Foreground(0 To maxBackgroundType) As Boolean 'flags the background object to be drawn in front of everything else
Public BackgroundWidth(1 To maxBackgroundType) As Integer
Public BackgroundHeight(1 To maxBackgroundType) As Integer
Public BackgroundFrame(1 To maxBackgroundType) As Integer
Public BackgroundFrameCount(1 To maxBackgroundType) As Integer
Public BlockFrame(1 To maxBlockType) As Integer 'What frame the block is on
Public BlockFrame2(1 To maxBlockType) As Integer 'Counter to update the blocks frame
Public sBlockArray(1 To 1000) As Integer 'sizable block array
Public sBlockNum As Integer
Public SceneFrame(1 To maxSceneType) As Integer 'What frame the scene is on
Public SceneFrame2(1 To maxSceneType) As Integer 'Counter to update the scene frames
Public SpecialFrame(100) As Integer 'misc frames for things like coins and the kurbi shoe
Public SpecialFrameCount(100) As Single
Public TileWidth(1 To maxTileType) As Integer
Public TileHeight(1 To maxTileType) As Integer
Public TileFrame(1 To maxTileType) As Integer
Public TileFrame2(1 To maxTileType) As Integer
Public LevelFrame(1 To 100) As Integer 'What frame the scene is on
Public LevelFrame2(1 To 100) As Integer 'Counter to update the scene frames
Public BlockHasNoMask(1 To maxBlockType) As Boolean
Public LevelHasNoMask(1 To 100) As Boolean
Public BlockOnlyHitspot1(0 To maxBlockType) As Boolean
Public BlockKills(0 To maxBlockType) As Boolean 'block is lava
Public BlockKills2(0 To maxBlockType) As Boolean
Public BlockHurts(0 To maxBlockType) As Boolean 'block hurts the player
Public BlockPSwitch(0 To maxBlockType) As Boolean 'block is affected by the p switch
Public BlockNoClipping(0 To maxBlockType) As Boolean 'player/npcs can walk throught the block
Public CoinFrame(1 To 10) As Integer 'What frame the coin is on
Public CoinFrame2(1 To 10) As Integer 'Counter to update the coin frames
Public EditorCursor As EditorCursor
Public EditorControls As EditorControls
Public Sound(1 To numSounds) As Integer
Public SoundPause(1 To numSounds) As Integer
Public EndLevel As Boolean 'End the level and move to the next
Public LevelMacro As Integer 'Shows a level outro when beat
Public LevelMacroCounter As Integer
Public numJoysticks As Integer
Public FileName As String
Public Coins As Integer 'number of coins
Public Lives As Single 'number of lives
Public EndIntro As Boolean
Public ExitMenu As Boolean
Public LevelSelect As Boolean 'true if game should load the world map
Public WorldPlayer(1) As WorldPlayer
Public LevelBeatCode As Integer ' code for the way the plauer beat the level
Public curWorldLevel As Integer
Public curWorldMusic As Integer
Public NoTurnBack(0 To maxSections) As Boolean
Public UnderWater(0 To maxSections) As Boolean
Public TestLevel As Boolean
Public FullFileName As String
Public FileNamePath As String
Public GameMenu As Boolean
Public WorldName As String
Public selWorld As Integer
Public selSave As Integer
Public PSwitchTime As Integer
Public PSwitchStop As Integer
Public PSwitchPlayer As Integer
Public SaveSlot(1 To 3) As Integer
Public SaveStars(1 To 3) As Integer
Public BeltDirection As Integer 'direction of the converyer belt blocks
Public BeatTheGame As Boolean 'true if the game has been beaten
 'for frameskip
Public cycleCount As Integer
Public fpsTime As Double
Public fpsCount As Double
Public FrameSkip As Boolean
Public GoalTime As Double
Public overTime As Double
'------------------
Public worldCurs As Integer
Public minShow As Integer
Public maxShow As Integer
Public Type Physics
    PlayerJumpHeight As Integer
    PlayerBlockJumpHeight As Integer
    PlayerHeadJumpHeight As Integer
    PlayerNPCJumpHeight As Integer
    PlayerSpringJumpHeight As Integer
    PlayerJumpVelocity As Single
    PlayerRunSpeed As Single
    PlayerWalkSpeed As Single
    PlayerTerminalVelocity As Integer
    PlayerGravity As Single
    PlayerHeight(1 To numCharacters, 1 To numStates) As Integer
    PlayerDuckHeight(1 To numCharacters, 1 To numStates) As Integer
    PlayerWidth(1 To numCharacters, 1 To numStates) As Integer
    PlayerGrabSpotX(1 To numCharacters, 1 To numStates) As Integer
    PlayerGrabSpotY(1 To numCharacters, 1 To numStates) As Integer
    NPCTimeOffScreen As Integer
    NPCCanHurtWait As Integer
    NPCShellSpeed As Single
    NPCShellSpeedY As Single
    NPCWalkingSpeed As Single
    NPCWalkingOnSpeed As Single
    NPCMushroomSpeed As Single
    NPCGravity As Single
    NPCGravityReal As Single
    NPCPSwitch As Integer
End Type

Public Type Events
    addSavedEvent As String
    RemoveSavedEvent As String
    LayerSmoke As Boolean
    Sound As Integer
    Name As String
    Text As String
    HideLayer(0 To 20) As String
    ShowLayer(0 To 20) As String
    ToggleLayer(0 To 20) As String
    Music(0 To maxSections) As Integer
    Background(0 To maxSections) As Integer
    level(0 To maxSections) As Location
    EndGame As Integer
    TriggerEvent As String
    TriggerDelay As Double
    Controls As Controls
    MoveLayer As String
    SpeedX As Single
    SpeedY As Single
    AutoX As Single
    AutoY As Single
    AutoSection As Integer
    AutoStart As Boolean
End Type
Public Layer(0 To 100) As Layer
Public Events(0 To 100) As Events
Public ReturnWarp As Integer 'for when the player returns from a warp
Public StartWarp As Integer
Public Physics As Physics
Public MenuCursor As Integer
Public MenuMode As Integer
Public MenuCursorCanMove As Boolean
Public MenuCursorCanMove2 As Boolean 'Joystick
Public NextFrame As Boolean
Public StopHit As Integer
Public MouseRelease As Boolean
Public TestFullscreen As Boolean
Public keyDownAlt As Boolean 'for alt/enter fullscreen
Public keyDownEnter As Boolean
Public BlocksSorted As Boolean 'if using block optimization it requires the locks to be sorted
Public SingleCoop As Integer 'cheat code
Public CheatString As String 'logs keys for cheats
Public GameOutro As Boolean 'true if showing credits
Public CreditChop As Single
Public EndCredits As Integer
Public curStars As Integer 'number of stars
Public maxStars As Integer 'max number of stars in the game
'cheat codes --------------
Public ShadowMode As Boolean 'cheat code
Public MultiHop As Boolean
Public SuperSpeed As Boolean
Public WalkAnywhere As Boolean
Public FlyForever As Boolean
Public FreezeNPCs As Boolean
Public CaptainN As Boolean
Public FlameThrower As Boolean
Public CoinMode As Boolean 'cheat code
Public WorldUnlock As Boolean
Public MaxFPS As Boolean
Public GodMode As Boolean
Public GrabAll As Boolean
Public Cheater As Boolean 'if the player is a cheater
'--------------------------------
Public WorldCredits(1 To 5) As String
Public Score As Long 'player's score
Public Points(1 To 13) As Integer
Public oldJumpJoy As Integer
Public MaxWorldStars As Integer 'maximum number of world stars
Public Debugger As Boolean 'if the debugger window is open
Public SavedChar(0 To 10) As Player 'Saves the Player's Status

Public LoadCoins As Integer
Public LoadCoinsT As Single

'Game Graphics
Public GFXBlockCustom(1 To maxBlockType) As Boolean
Public GFXBlock(1 To maxBlockType) As Long
Public GFXBlockMask(1 To maxBlockType) As Long
Public GFXBlockBMP(1 To maxBlockType) As StdPicture
Public GFXBlockMaskBMP(1 To maxBlockType) As StdPicture
Public GFXBackground2Custom(1 To numBackground2) As Boolean
Public GFXBackground2(1 To numBackground2) As Long
Public GFXBackground2BMP(1 To numBackground2) As StdPicture
Public GFXBackground2Height(1 To numBackground2) As Integer
Public GFXBackground2Width(1 To numBackground2) As Integer
Public GFXNPCCustom(1 To maxNPCType) As Boolean
Public GFXNPC(1 To maxNPCType) As Long
Public GFXNPCMask(1 To maxNPCType) As Long
Public GFXNPCBMP(1 To maxNPCType) As StdPicture
Public GFXNPCMaskBMP(1 To maxNPCType) As StdPicture
Public GFXNPCHeight(1 To maxNPCType) As Integer
Public GFXNPCWidth(1 To maxNPCType) As Integer
Public GFXEffectCustom(1 To maxEffectType) As Boolean
Public GFXEffect(1 To maxEffectType) As Long
Public GFXEffectMask(1 To maxEffectType) As Long
Public GFXEffectBMP(1 To maxEffectType) As StdPicture
Public GFXEffectMaskBMP(1 To maxEffectType) As StdPicture
Public GFXEffectHeight(1 To maxEffectType) As Integer
Public GFXEffectWidth(1 To maxEffectType) As Integer
Public GFXBackgroundCustom(1 To maxBackgroundType) As Boolean
Public GFXBackground(1 To maxBackgroundType) As Long
Public GFXBackgroundMask(1 To maxBackgroundType) As Long
Public GFXBackgroundBMP(1 To maxBackgroundType) As StdPicture
Public GFXBackgroundMaskBMP(1 To maxBackgroundType) As StdPicture
Public GFXBackgroundHeight(1 To maxBackgroundType) As Integer
Public GFXBackgroundWidth(1 To maxBackgroundType) As Integer
Public GFXMarioCustom(1 To 10) As Boolean
Public GFXMario(1 To 10) As Long
Public GFXMarioMask(1 To 10) As Long
Public GFXMarioBMP(1 To 10) As StdPicture
Public GFXMarioMaskBMP(1 To 10) As StdPicture
Public GFXMarioHeight(1 To 10) As Integer
Public GFXMarioWidth(1 To 10) As Integer
Public GFXLuigiCustom(1 To 10) As Boolean
Public GFXLuigi(1 To 10) As Long
Public GFXLuigiMask(1 To 10) As Long
Public GFXLuigiBMP(1 To 10) As StdPicture
Public GFXLuigiMaskBMP(1 To 10) As StdPicture
Public GFXLuigiHeight(1 To 10) As Integer
Public GFXLuigiWidth(1 To 10) As Integer
Public GFXPeachCustom(1 To 10) As Boolean
Public GFXPeach(1 To 10) As Long
Public GFXPeachMask(1 To 10) As Long
Public GFXPeachBMP(1 To 10) As StdPicture
Public GFXPeachMaskBMP(1 To 10) As StdPicture
Public GFXPeachHeight(1 To 10) As Integer
Public GFXPeachWidth(1 To 10) As Integer
Public GFXToadCustom(1 To 10) As Boolean
Public GFXToad(1 To 10) As Long
Public GFXToadMask(1 To 10) As Long
Public GFXToadBMP(1 To 10) As StdPicture
Public GFXToadMaskBMP(1 To 10) As StdPicture
Public GFXToadHeight(1 To 10) As Integer
Public GFXToadWidth(1 To 10) As Integer

Public GFXLinkCustom(1 To 10) As Boolean
Public GFXLink(1 To 10) As Long
Public GFXLinkMask(1 To 10) As Long
Public GFXLinkBMP(1 To 10) As StdPicture
Public GFXLinkMaskBMP(1 To 10) As StdPicture
Public GFXLinkHeight(1 To 10) As Integer
Public GFXLinkWidth(1 To 10) As Integer

Public GFXYoshiBCustom(1 To 10) As Boolean
Public GFXYoshiB(1 To 10) As Long
Public GFXYoshiBMask(1 To 10) As Long
Public GFXYoshiBBMP(1 To 10) As StdPicture
Public GFXYoshiBMaskBMP(1 To 10) As StdPicture
Public GFXYoshiTCustom(1 To 10) As Boolean
Public GFXYoshiT(1 To 10) As Long
Public GFXYoshiTMask(1 To 10) As Long
Public GFXYoshiTBMP(1 To 10) As StdPicture
Public GFXYoshiTMaskBMP(1 To 10) As StdPicture
'World Map Graphics
Public GFXTileCustom(1 To maxTileType) As Long
Public GFXTile(1 To maxTileType) As Long
Public GFXTileBMP(1 To maxTileType) As StdPicture
Public GFXTileHeight(1 To maxTileType) As Integer
Public GFXTileWidth(1 To maxTileType) As Integer
Public GFXLevelCustom(0 To maxLevelType) As Long
Public GFXLevel(0 To maxLevelType) As Long
Public GFXLevelMask(0 To maxLevelType) As Long
Public GFXLevelBMP(0 To maxLevelType) As StdPicture
Public GFXLevelMaskBMP(0 To maxLevelType) As StdPicture
Public GFXLevelHeight(0 To maxLevelType) As Integer
Public GFXLevelWidth(0 To maxLevelType) As Integer
Public GFXLevelBig(0 To maxLevelType) As Boolean
Public GFXSceneCustom(1 To maxSceneType) As Long
Public GFXScene(1 To maxSceneType) As Long
Public GFXSceneMask(1 To maxSceneType) As Long
Public GFXSceneBMP(1 To maxSceneType) As StdPicture
Public GFXSceneMaskBMP(1 To maxSceneType) As StdPicture
Public GFXSceneHeight(1 To maxSceneType) As Integer
Public GFXSceneWidth(1 To maxSceneType) As Integer
Public GFXPathCustom(1 To maxPathType) As Long
Public GFXPath(1 To maxPathType) As Long
Public GFXPathMask(1 To maxPathType) As Long
Public GFXPathBMP(1 To maxPathType) As StdPicture
Public GFXPathMaskBMP(1 To maxPathType) As StdPicture
Public GFXPathHeight(1 To maxPathType) As Integer
Public GFXPathWidth(1 To maxPathType) As Integer

Public GFXPlayerCustom(1 To numCharacters) As Long
Public GFXPlayer(1 To numCharacters) As Long
Public GFXPlayerMask(1 To numCharacters) As Long
Public GFXPlayerBMP(1 To numCharacters) As StdPicture
Public GFXPlayerMaskBMP(1 To numCharacters) As StdPicture
Public GFXPlayerHeight(1 To numCharacters) As Integer
Public GFXPlayerWidth(1 To numCharacters) As Integer

Public PlayerCharacter As Integer
Public PlayerCharacter2 As Integer
Public MenuMouseX As Double
Public MenuMouseY As Double
Public MenuMouseDown As Boolean
Public MenuMouseBack As Boolean
Public MenuMouseRelease As Boolean
Public MenuMouseMove As Boolean
Public MenuMouseClick As Boolean

' event stuff
Public NewEvent(1 To 100) As String
Public newEventDelay(1 To 100) As Integer
Public newEventNum As Integer
Public ForcedControls As Boolean
Public ForcedControl As Controls
Public SyncCount As Integer
Public noUpdate As Boolean
Public gameTime As Double
Public noSound As Boolean
Public tempTime As Double
Dim ScrollDelay As Integer
'battlemode stuff
Public BattleMode As Boolean
Public BattleWinner As Integer
Public BattleLives(1 To maxPlayers) As Integer
Public BattleIntro As Integer
Public BattleOutro As Integer
Public LevelName As String
Public Const curRelease As Integer = 65


Public Sub SetupPhysics()
    With Physics
        .PlayerJumpVelocity = -5.7      'Jump velocity
        .PlayerJumpHeight = 20          'Jump height
        .PlayerBlockJumpHeight = 25     'Jump height off bouncy blocks
        .PlayerHeadJumpHeight = 22      'Jump height off another players head
        .PlayerNPCJumpHeight = 22       'Jump height off a NPC
        .PlayerSpringJumpHeight = 55    'Jump height off a Spring
        .PlayerRunSpeed = 6             'Max run speed
        .PlayerWalkSpeed = 3            'Max walk speed
        .PlayerGravity = 0.4            'Player's gravity
        .PlayerTerminalVelocity = 12    'Max falling speed
        .PlayerHeight(1, 1) = 30        'Little Mario
        .PlayerWidth(1, 1) = 24         '------------
        .PlayerGrabSpotX(1, 1) = 18     '---------
        .PlayerGrabSpotY(1, 1) = -2     '---------
        .PlayerHeight(1, 2) = 54        'Big Mario
        .PlayerWidth(1, 2) = 24         '---------
        .PlayerDuckHeight(1, 2) = 30    '---------
        .PlayerGrabSpotX(1, 2) = 18     '---------
        .PlayerGrabSpotY(1, 2) = 16     '---------
        .PlayerHeight(1, 3) = 54        'Fire Mario
        .PlayerWidth(1, 3) = 24         '---------
        .PlayerDuckHeight(1, 3) = 30    '---------
        .PlayerGrabSpotX(1, 3) = 18     '---------
        .PlayerGrabSpotY(1, 3) = 16     '---------
        .PlayerHeight(1, 7) = 54        'Ice Mario
        .PlayerWidth(1, 7) = 24         '---------
        .PlayerDuckHeight(1, 7) = 30    '---------
        .PlayerGrabSpotX(1, 7) = 18     '---------
        .PlayerGrabSpotY(1, 7) = 16     '---------
        .PlayerHeight(1, 4) = 54        'Racoon Mario
        .PlayerWidth(1, 4) = 24         '---------
        .PlayerDuckHeight(1, 4) = 30    '---------
        .PlayerGrabSpotX(1, 4) = 18     '---------
        .PlayerGrabSpotY(1, 4) = 16     '---------
        .PlayerHeight(1, 5) = 54        'Tanooki Mario
        .PlayerWidth(1, 5) = 24         '---------
        .PlayerDuckHeight(1, 5) = 30    '---------
        .PlayerGrabSpotX(1, 5) = 18     '---------
        .PlayerGrabSpotY(1, 5) = 16     '---------
        .PlayerHeight(1, 6) = 54        'Hammer Mario
        .PlayerWidth(1, 6) = 24         '---------
        .PlayerDuckHeight(1, 6) = 30    '---------
        .PlayerGrabSpotX(1, 6) = 18     '---------
        .PlayerGrabSpotY(1, 6) = 16     '---------
        
        .PlayerHeight(2, 1) = 30        'Little Luigi
        .PlayerWidth(2, 1) = 24         '------------
        .PlayerGrabSpotX(2, 1) = 16     '---------
        .PlayerGrabSpotY(2, 1) = -4     '---------
        .PlayerHeight(2, 2) = 60        'Big Luigi
        .PlayerWidth(2, 2) = 24         '---------
        .PlayerDuckHeight(2, 2) = 30    '---------
        .PlayerGrabSpotX(2, 2) = 18     '---------
        .PlayerGrabSpotY(2, 2) = 16     '---------
        .PlayerHeight(2, 3) = 60        'Fire Luigi
        .PlayerWidth(2, 3) = 24         '---------
        .PlayerDuckHeight(2, 3) = 30    '---------
        .PlayerGrabSpotX(2, 3) = 18     '---------
        .PlayerGrabSpotY(2, 3) = 16     '---------
        .PlayerHeight(2, 4) = 60        'Racoon Luigi
        .PlayerWidth(2, 4) = 24         '---------
        .PlayerDuckHeight(2, 4) = 30    '---------
        .PlayerGrabSpotX(2, 4) = 18     '---------
        .PlayerGrabSpotY(2, 4) = 16     '---------
        .PlayerHeight(2, 5) = 60        'Tanooki Luigi
        .PlayerWidth(2, 5) = 24         '---------
        .PlayerDuckHeight(2, 5) = 30    '---------
        .PlayerGrabSpotX(2, 5) = 18     '---------
        .PlayerGrabSpotY(2, 5) = 16     '---------
        .PlayerHeight(2, 6) = 60        'Tanooki Luigi
        .PlayerWidth(2, 6) = 24         '---------
        .PlayerDuckHeight(2, 6) = 30    '---------
        .PlayerGrabSpotX(2, 6) = 18     '---------
        .PlayerGrabSpotY(2, 6) = 16     '---------
        .PlayerHeight(2, 7) = 60        'Ice Luigi
        .PlayerWidth(2, 7) = 24         '---------
        .PlayerDuckHeight(2, 7) = 30    '---------
        .PlayerGrabSpotX(2, 7) = 18     '---------
        .PlayerGrabSpotY(2, 7) = 16     '---------
        
        .PlayerHeight(3, 1) = 38        'Little Peach
        .PlayerDuckHeight(3, 1) = 26    '---------
        .PlayerWidth(3, 1) = 24         '------------
        .PlayerGrabSpotX(3, 1) = 0      '---------
        .PlayerGrabSpotY(3, 1) = 0      '---------
        .PlayerHeight(3, 2) = 60        'Big Peach
        .PlayerWidth(3, 2) = 24         '---------
        .PlayerDuckHeight(3, 2) = 30    '---------
        .PlayerGrabSpotX(3, 2) = 0     '---------
        .PlayerGrabSpotY(3, 2) = 0     '---------
        .PlayerHeight(3, 3) = 60        'Fire Peach
        .PlayerWidth(3, 3) = 24         '---------
        .PlayerDuckHeight(3, 3) = 30    '---------
        .PlayerGrabSpotX(3, 3) = 18
        .PlayerGrabSpotY(3, 3) = 16
        
        .PlayerHeight(3, 4) = 60        'Racoon Peach
        .PlayerWidth(3, 4) = 24         '---------
        .PlayerDuckHeight(3, 4) = 30    '---------
        .PlayerGrabSpotX(3, 4) = 18
        .PlayerGrabSpotY(3, 4) = 16
        
        .PlayerHeight(3, 5) = 60        'Tanooki Peach
        .PlayerWidth(3, 5) = 24         '---------
        .PlayerDuckHeight(3, 5) = 30    '---------
        .PlayerGrabSpotX(3, 5) = 18
        .PlayerGrabSpotY(3, 5) = 16
        
        .PlayerHeight(3, 6) = 60        'Hammer Peach
        .PlayerWidth(3, 6) = 24         '---------
        .PlayerDuckHeight(3, 6) = 30    '---------
        .PlayerGrabSpotX(3, 6) = 18
        .PlayerGrabSpotY(3, 6) = 16
        
        
        .PlayerHeight(3, 7) = 60        'Ice Peach
        .PlayerWidth(3, 7) = 24         '---------
        .PlayerDuckHeight(3, 7) = 30    '---------
        .PlayerGrabSpotX(3, 7) = 18
        .PlayerGrabSpotY(3, 7) = 16

        .PlayerHeight(4, 1) = 30        'Little Toad
        .PlayerWidth(4, 1) = 24         '------------
        .PlayerDuckHeight(4, 1) = 26    '---------
        .PlayerGrabSpotX(4, 1) = 18     '---------
        .PlayerGrabSpotY(4, 1) = -2     '---------
        .PlayerHeight(4, 2) = 50        'Big Toad
        .PlayerWidth(4, 2) = 24         '---------
        .PlayerDuckHeight(4, 2) = 30    '---------
        .PlayerGrabSpotX(4, 2) = 18     '---------
        .PlayerGrabSpotY(4, 2) = 16     '---------
        .PlayerHeight(4, 3) = 50        'Fire Toad
        .PlayerWidth(4, 3) = 24         '---------
        .PlayerDuckHeight(4, 3) = 30    '---------
        .PlayerGrabSpotX(4, 3) = 18     '---------
        .PlayerGrabSpotY(4, 3) = 16     '---------
        
        .PlayerHeight(4, 4) = 50        'Racoon Toad
        .PlayerWidth(4, 4) = 24         '---------
        .PlayerDuckHeight(4, 4) = 30    '---------
        .PlayerGrabSpotX(4, 4) = 18     '---------
        .PlayerGrabSpotY(4, 4) = 16     '---------
        
        .PlayerHeight(4, 5) = 50        'Tanooki Toad
        .PlayerWidth(4, 5) = 24         '---------
        .PlayerDuckHeight(4, 5) = 30    '---------
        .PlayerGrabSpotX(4, 5) = 18     '---------
        .PlayerGrabSpotY(4, 5) = 16     '---------
        
        .PlayerHeight(4, 6) = 50        'Hammer Toad
        .PlayerWidth(4, 6) = 24         '---------
        .PlayerDuckHeight(4, 6) = 30    '---------
        .PlayerGrabSpotX(4, 6) = 18     '---------
        .PlayerGrabSpotY(4, 6) = 16     '---------
        
        .PlayerHeight(4, 7) = 50        'Ice Toad
        .PlayerWidth(4, 7) = 24         '---------
        .PlayerDuckHeight(4, 7) = 30    '---------
        .PlayerGrabSpotX(4, 7) = 18     '---------
        .PlayerGrabSpotY(4, 7) = 16     '---------

        .PlayerHeight(5, 1) = 54        'Green Link
        .PlayerWidth(5, 1) = 22         '---------
        .PlayerDuckHeight(5, 1) = 44    '---------
        .PlayerGrabSpotX(5, 1) = 18     '---------
        .PlayerGrabSpotY(5, 1) = 16     '---------
        
        .PlayerHeight(5, 2) = 54        'Green Link
        .PlayerWidth(5, 2) = 22         '---------
        .PlayerDuckHeight(5, 2) = 44    '---------
        .PlayerGrabSpotX(5, 2) = 18     '---------
        .PlayerGrabSpotY(5, 2) = 16     '---------
        
        .PlayerHeight(5, 3) = 54        'Fire Link
        .PlayerWidth(5, 3) = 22         '---------
        .PlayerDuckHeight(5, 3) = 44    '---------
        .PlayerGrabSpotX(5, 3) = 18     '---------
        .PlayerGrabSpotY(5, 3) = 16     '---------
        
        .PlayerHeight(5, 4) = 54        'Blue Link
        .PlayerWidth(5, 4) = 22         '---------
        .PlayerDuckHeight(5, 4) = 44    '---------
        .PlayerGrabSpotX(5, 4) = 18     '---------
        .PlayerGrabSpotY(5, 4) = 16     '---------
        
        .PlayerHeight(5, 5) = 54        'IronKnuckle Link
        .PlayerWidth(5, 5) = 22         '---------
        .PlayerDuckHeight(5, 5) = 44    '---------
        .PlayerGrabSpotX(5, 5) = 18     '---------
        .PlayerGrabSpotY(5, 5) = 16     '---------
        
        .PlayerHeight(5, 6) = 54        'Shadow Link
        .PlayerWidth(5, 6) = 22         '---------
        .PlayerDuckHeight(5, 6) = 44    '---------
        .PlayerGrabSpotX(5, 6) = 18     '---------
        .PlayerGrabSpotY(5, 6) = 16     '---------
        
        .PlayerHeight(5, 7) = 54        'Ice Link
        .PlayerWidth(5, 7) = 22         '---------
        .PlayerDuckHeight(5, 7) = 44    '---------
        .PlayerGrabSpotX(5, 7) = 18     '---------
        .PlayerGrabSpotY(5, 7) = 16     '---------
        
        .NPCTimeOffScreen = 180         'How long NPCs are active offscreen before being reset
        .NPCShellSpeed = 7.1            'Speed of kicked shells
        .NPCShellSpeedY = 11            'Vertical Speed of kicked shells
        .NPCCanHurtWait = 30            'How long to wait before NPCs can hurt players
        .NPCGravity = 0.26              'NPC Gravity
        .NPCGravityReal = 0.26              'NPC Gravity
        .NPCWalkingSpeed = 1.2          'NPC Walking Speed
        .NPCWalkingOnSpeed = 1          'NPC that can be walked on walking speed
        .NPCMushroomSpeed = 1.8         'Mushroom X Speed
        .NPCPSwitch = 777               'P Switch time
    End With
End Sub

Sub Main()
    Dim blankPlayer As Player
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim tempBool As Boolean
    Shell "regsvr32 /s" & Chr$(34) & App.Path & "\mswinsck.ocx" & Chr$(34) 'register mswinsck.ocx
    LB = Chr(13) & Chr(10) 'holds a variable for Line Break
    EoT = "" 'EoT is disabled
    Randomize Timer
    FrameSkip = True
    frmLoader.Show 'show the Splash screen
    Do
        DoEvents
    Loop While StartMenu = False 'wait until the player clicks a button
    
    If frmLoader.chkFrameskip.Value <> 0 Then FrameSkip = False
    If frmLoader.chkSound.Value <> 0 Then noSound = True
    
    Unload frmLoader
    
    
    
    If LevelEditor = False Then
        frmMain.Show
        GameMenu = True
    Else
        frmSplash.Show
        BlocksSorted = True
    End If
    InitControls 'init player's controls
    DoEvents
    If noSound = False Then
        mciSendString "open " & Chr(34) & App.Path & "\sound\do.mp3" & Chr(34) & " alias sound29", 0, 0, 0 'play the nintendo sound
        mciSendString "play sound29 from 10", 0, 0, 0
    End If
    InitSound 'Setup sound effects
    LevelSelect = True 'world map is to be shown
    DoEvents
    SetupPhysics 'Setup Physics
    SetupGraphics 'setup graphics
    Load GFX 'load the graphics form
    SizableBlocks
    LoadGFX 'load the graphics from file
    SetupVars 'Setup Variables
    frmMain.AutoRedraw = False
    frmMain.Picture = GFX.Picture
    frmMain.LoadCoin.Visible = False
    frmMain.Loader.Visible = False

    Do
    
        If GameMenu = True Then
            frmMain.MousePointer = 99
        ElseIf resChanged = False And TestLevel = False And LevelEditor = False Then
            frmMain.MousePointer = 0
        End If
    
        If LevelEditor = True Then 'Load the level editor
            If resChanged = True Then
                ChangeScreen
            End If
            BattleMode = False
            SingleCoop = 0
            numPlayers = 0
            frmMain.Hide
            frmLevelEditor.Show
            DoEvents
            SetupEditorGraphics 'Set up the editor graphics
            MagicHand = False
            frmLevelEditor.menuFile.Enabled = True
            frmLevelEditor.MenuTest.Enabled = True
            frmLevelEditor.mnuOnline.Enabled = True
            frmLevelEditor.mnuMode.Enabled = True
            frmLevelEditor.optCursor(5).Enabled = True
            frmLevelEditor.optCursor(15).Enabled = True
            frmLevelEditor.optCursor(2).Enabled = True
            If nPlay.Online = True Then
                If nPlay.Mode = 0 Then frmLevelEditor.MenuTest.Enabled = False
            End If
            For A = 0 To frmLevelSettings.optLevel.Count - 1
                frmLevelSettings.optLevel(A).Enabled = True
            Next A
            For A = 0 To frmLevelSettings.optSection.Count - 1
                frmLevelSettings.optSection(A).Enabled = True
            Next A
            With EditorCursor
                .Location.Height = 32
                .Location.Width = 32
            End With
            overTime = 0
            GoalTime = GetTickCount + 1000
            fpsCount = 0
            fpsTime = 0
            cycleCount = 0
            gameTime = 0
            Do 'LEVEL EDITOR LOOP
                tempTime = GetTickCount
                If tempTime >= gameTime + frameRate Or tempTime < gameTime Then
                    CheckActive
                    EditorLoop 'Do the editor loop
                    If fpsCount >= 32000 Then fpsCount = 0 'Fixes Overflow bug
                    If cycleCount >= 32000 Then cycleCount = 0 'Fixes Overflow bug
                    overTime = overTime + (tempTime - (gameTime + frameRate))
                    If gameTime = 0 Then overTime = 0
                    If overTime <= 1 Then
                        overTime = 0
                    ElseIf overTime > 1000 Then
                        overTime = 1000
                    End If
                    gameTime = tempTime - overTime
                    overTime = (overTime - (tempTime - gameTime))
                    DoEvents


                    If GetTickCount > fpsTime Then
                        If cycleCount >= 65 Then
                            overTime = 0
                            gameTime = tempTime
                        End If
                        cycleCount = 0
                        fpsTime = GetTickCount + 1000
                        GoalTime = fpsTime
                        If Debugger = True Then frmLevelDebugger.lblFPS = fpsCount
                        If ShowFPS = True Then
                            PrintFPS = fpsCount
                        End If
                        fpsCount = 0
                    End If
                End If
            Loop While LevelEditor = True
            
            
            
        ElseIf GameOutro = True Then 'SMBX Credits
            ShadowMode = False
            GodMode = False
            GrabAll = False
            CaptainN = False
            FlameThrower = False
            FreezeNPCs = False
            WalkAnywhere = False
            MultiHop = False
            SuperSpeed = False
            FlyForever = False
            For A = 1 To maxPlayers
                Player(A) = blankPlayer
            Next A
            numPlayers = 5
            GameMenu = False
            StopMusic
            OpenLevel App.Path & "\outro.lvl"
            ScreenType = 7
            SetupScreens
            ClearBuffer = True
            For A = 1 To numPlayers
                With Player(A)
                    If A = 1 Then
                        .State = 4
                    ElseIf A = 2 Then
                        .State = 7
                    ElseIf A = 3 Then
                        .State = 5
                    ElseIf A = 4 Then
                        .State = 3
                    Else
                        .State = 6
                    End If
                    If A = 4 Then
                        .Mount = 1
                        .MountType = Int(Rnd * 3) + 1
                    End If
                    .Character = A
                    If A = 2 Then
                        .Mount = 3
                        .MountType = Int(Rnd * 8) + 1
                    End If
                    .HeldBonus = 0
                    .Section = 0
                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                    .Location.Width = Physics.PlayerWidth(.Character, .State)
                End With
            Next A
            SetupPlayers
            CreditChop = 300 '100
            EndCredits = 0
            SetupCredits
            overTime = 0
            GoalTime = GetTickCount + 1000
            fpsCount = 0
            fpsTime = 0
            cycleCount = 0
            gameTime = 0
            Do
                DoEvents
                tempTime = GetTickCount
                ScreenType = 0
                SetupScreens
                If tempTime >= gameTime + frameRate Or tempTime < gameTime Then
                    CheckActive
                    OutroLoop
                    If fpsCount >= 32000 Then fpsCount = 0 'Fixes Overflow bug
                    If cycleCount >= 32000 Then cycleCount = 0 'Fixes Overflow bug
                    overTime = overTime + (tempTime - (gameTime + frameRate))
                    If gameTime = 0 Then overTime = 0
                    If overTime <= 1 Then
                        overTime = 0
                    ElseIf overTime > 1000 Then
                        overTime = 1000
                    End If
                    gameTime = tempTime - overTime
                    overTime = (overTime - (tempTime - gameTime))
                    DoEvents
                    If GetTickCount > fpsTime Then
                        If cycleCount >= 65 Then
                            overTime = 0
                            gameTime = tempTime
                        End If
                        cycleCount = 0
                        fpsTime = GetTickCount + 1000
                        GoalTime = fpsTime
                        If Debugger = True Then frmLevelDebugger.lblFPS = fpsCount
                        If ShowFPS = True Then
                            PrintFPS = fpsCount
                        End If
                        fpsCount = 0
                    End If
                End If
            Loop While GameOutro = True
        ElseIf GameMenu = True Then 'The Game Menu
            BattleIntro = 0
            BattleOutro = 0
            AllCharBlock = 0
            Cheater = False
            For A = 1 To maxPlayers
                OwedMount(A) = 0
                OwedMountType(A) = 0
            Next A
            MenuMouseMove = False
            MenuMouseRelease = False
            MenuMouseClick = False
            MenuMouseBack = False
            BattleMode = False
            If MenuMode <> 4 Then
                PlayerCharacter = 0
                PlayerCharacter2 = 0
            End If
            Checkpoint = ""
            WorldPlayer(1).Frame = 0
            CheatString = ""
            LevelBeatCode = 0
            curWorldLevel = 0
            ClearWorld
            ReturnWarp = 0
            ShadowMode = False
            GodMode = False
            GrabAll = False
            CaptainN = False
            FlameThrower = False
            FreezeNPCs = False
            WalkAnywhere = False
            MultiHop = False
            SuperSpeed = False
            FlyForever = False
            BeatTheGame = False
            ScreenType = 2
            SetupScreens
            BattleOutro = 0
            BattleIntro = 0
            For A = 1 To maxPlayers
                Player(A) = blankPlayer
            Next A
            numPlayers = 6
            OpenLevel App.Path & "\intro.lvl"
            vScreenX(1) = -level(0).X
            StartMusic 0
            SetupPlayers
            For A = 1 To numPlayers
                With Player(A)
                    .State = Int(Rnd * 6) + 2
                    .Character = Int(Rnd * 5) + 1
                    If A >= 1 And A <= 5 Then .Character = A
                    .HeldBonus = 0
                    .Section = 0
                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                    .Location.Width = Physics.PlayerWidth(.Character, .State)
                    .Location.X = level(.Section).X + ((128 + Rnd * 64) * A)
                    .Location.Y = level(.Section).Height - .Location.Height - 65
                    Do
                        tempBool = True
                        For B = 1 To numBlock
                            If CheckCollision(.Location, Block(B).Location) = True Then
                                .Location.Y = Block(B).Location.Y - .Location.Height - 0.1
                                tempBool = False
                            End If
                        Next B
                    Loop While tempBool = False
                    .Dead = True
                End With
            Next A
            ProcEvent "Level - Start", True
            For A = 2 To 100
                If Events(A).AutoStart = True Then ProcEvent Events(A).Name, True
            Next A
            overTime = 0
            GoalTime = GetTickCount + 1000
            fpsCount = 0
            fpsTime = 0
            cycleCount = 0
            gameTime = 0
            Do
                DoEvents
                tempTime = GetTickCount
                If tempTime >= gameTime + frameRate Or tempTime < gameTime Then
                    CheckActive
                    MenuLoop    'Run the menu loop
                    If fpsCount >= 32000 Then fpsCount = 0 'Fixes Overflow bug
                    If cycleCount >= 32000 Then cycleCount = 0 'Fixes Overflow bug
                    overTime = overTime + (tempTime - (gameTime + frameRate))
                    If gameTime = 0 Then overTime = 0
                    If overTime <= 1 Then
                        overTime = 0
                    ElseIf overTime > 1000 Then
                        overTime = 1000
                    End If
                    gameTime = tempTime - overTime
                    overTime = (overTime - (tempTime - gameTime))
                    DoEvents
                    If GetTickCount > fpsTime Then
                         If cycleCount >= 65 Then
                            overTime = 0
                            gameTime = tempTime
                        End If
                        cycleCount = 0
                        fpsTime = GetTickCount + 1000
                        GoalTime = fpsTime
                        If Debugger = True Then frmLevelDebugger.lblFPS = fpsCount
                        If ShowFPS = True Then
                            PrintFPS = fpsCount
                        End If
                        fpsCount = 0
                    End If
                End If
            Loop While GameMenu = True
        ElseIf LevelSelect = True Then 'World Map
            CheatString = ""
            For A = 1 To numPlayers
                If Player(A).Mount = 0 Or Player(A).Mount = 2 Then
                    If OwedMount(A) > 0 Then
                        Player(A).Mount = OwedMount(A)
                        If OwedMountType(A) > 0 Then
                            Player(A).MountType = OwedMountType(A)
                        Else
                            Player(A).MountType = 1
                        End If
                    End If
                End If
                OwedMount(A) = 0
                OwedMountType(A) = 0
            Next A
            LoadCustomGFX
            SetupPlayers
            If (StartLevel <> "" And NoMap = True) Or GoToLevel <> "" Then
                If NoMap = True Then SaveGame
                Player(1).Vine = 0
                Player(2).Vine = 0
                PlaySound 28
                SoundPause(26) = 200
                LevelSelect = False
                
                GameThing
                ClearLevel
                
                Sleep 1000
                If GoToLevel = "" Then
                    OpenLevel SelectWorld(selWorld).WorldPath & StartLevel
                Else
                    OpenLevel SelectWorld(selWorld).WorldPath & GoToLevel
                    GoToLevel = ""
                End If
            Else
                If curWorldMusic > 0 Then StartMusic curWorldMusic
                overTime = 0
                GoalTime = GetTickCount + 1000
                fpsCount = 0
                fpsTime = 0
                cycleCount = 0
                gameTime = 0
                Do 'level select loop
                    FreezeNPCs = False
                    DoEvents
                    tempTime = GetTickCount
                    If tempTime >= gameTime + frameRate Or tempTime < gameTime Or MaxFPS = True Then
                        
                        If fpsCount >= 32000 Then fpsCount = 0 'Fixes Overflow bug
                        If cycleCount >= 32000 Then cycleCount = 0 'Fixes Overflow bug
                        overTime = overTime + (tempTime - (gameTime + frameRate))
                        If gameTime = 0 Then overTime = 0
                        If overTime <= 1 Then
                            overTime = 0
                        ElseIf overTime > 1000 Then
                            overTime = 1000
                        End If
                        gameTime = tempTime - overTime
                        overTime = (overTime - (tempTime - gameTime))
                        
                        CheckActive
                        WorldLoop
                        DoEvents
                        If GetTickCount > fpsTime Then
                            If cycleCount >= 65 Then
                                overTime = 0
                                gameTime = tempTime
                            End If
                            cycleCount = 0
                            fpsTime = GetTickCount + 1000
                            GoalTime = fpsTime
                            If Debugger = True Then frmLevelDebugger.lblFPS = fpsCount
                            If ShowFPS = True Then
                                PrintFPS = fpsCount
                            End If
                            fpsCount = 0
                        End If
                    End If
                Loop While LevelSelect = True
            End If
        Else 'MAIN GAME
            CheatString = "" 'clear the cheat codes
            EndLevel = False
            If numPlayers = 1 Then
                ScreenType = 0 'Follow 1 player
            ElseIf numPlayers = 2 Then
                ScreenType = 5 'Dynamic screen
            Else
                'ScreenType = 3 'Average, no one leaves the screen
                ScreenType = 2 'Average
            End If
            If SingleCoop > 0 Then ScreenType = 6
            If nPlay.Online = True Then ScreenType = 8 'Online
            For A = 1 To numPlayers
                If Player(A).Mount = 2 Then Player(A).Mount = 0 'take players off the clown car
            Next A
            SetupPlayers 'Setup Players for the level
            qScreen = False
'for warp entrances
            If (ReturnWarp > 0 And FileName = StartLevel) Or StartWarp > 0 Then
                For A = 1 To numPlayers
                    With Player(A)
                        If StartWarp > 0 Then
                            .Warp = StartWarp
                        Else
                            .Warp = ReturnWarp
                        End If
                        If Warp(.Warp).Effect = 1 Then
                            If Warp(.Warp).Direction2 = 1 Then
                                .Location.X = Warp(.Warp).Exit.X + Warp(.Warp).Exit.Width / 2 - .Location.Width / 2
                                .Location.Y = Warp(.Warp).Exit.Y - .Location.Height - 8
                            ElseIf Warp(.Warp).Direction2 = 3 Then
                                .Location.X = Warp(.Warp).Exit.X + Warp(.Warp).Exit.Width / 2 - .Location.Width / 2
                                .Location.Y = Warp(.Warp).Exit.Y + Warp(.Warp).Exit.Height + 8
                            ElseIf Warp(.Warp).Direction2 = 2 Then
                                If .Mount = 3 Then .Duck = True
                                .Location.X = Warp(.Warp).Exit.X - .Location.Width - 8
                                .Location.Y = Warp(.Warp).Exit.Y + Warp(.Warp).Exit.Height - .Location.Height - 2
                            ElseIf Warp(.Warp).Direction2 = 4 Then
                                If .Mount = 3 Then .Duck = True
                                .Location.X = Warp(.Warp).Exit.X + Warp(.Warp).Exit.Width + 8
                                .Location.Y = Warp(.Warp).Exit.Y + Warp(.Warp).Exit.Height - .Location.Height - 2
                            End If
                            PlayerFrame A
                            CheckSection A
                            SoundPause(17) = 0
                            .Effect = 8
                            .Effect2 = 950
                        ElseIf Warp(.Warp).Effect = 2 Then
                            .Location.X = Warp(.Warp).Exit.X + Warp(.Warp).Exit.Width / 2 - .Location.Width / 2
                            .Location.Y = Warp(.Warp).Exit.Y + Warp(.Warp).Exit.Height - .Location.Height
                            CheckSection A
                            .Effect = 8
                            .Effect2 = 2000
                        End If
                    End With
                Next A
                If StartWarp > 0 Then
                    StartWarp = 0
                Else
                    ReturnWarp = 0
                End If
            End If
'--------------------------------------------
            ProcEvent "Level - Start", True
            For A = 2 To 100
                If Events(A).AutoStart = True Then ProcEvent Events(A).Name, True
            Next A
            overTime = 0
            GoalTime = GetTickCount + 1000
            fpsCount = 0
            fpsTime = 0
            cycleCount = 0
            gameTime = 0
            Do 'MAIN GAME LOOP
                DoEvents
                tempTime = GetTickCount
                If tempTime >= gameTime + frameRate Or tempTime < gameTime Or MaxFPS = True Then
                    CheckActive
                    If fpsCount >= 32000 Then fpsCount = 0 'Fixes Overflow bug
                    If cycleCount >= 32000 Then cycleCount = 0 'Fixes Overflow bug
                    overTime = overTime + (tempTime - (gameTime + frameRate))
                    If gameTime = 0 Then overTime = 0
                    If overTime <= 1 Then
                        overTime = 0
                    ElseIf overTime > 1000 Then
                        overTime = 1000
                    End If
                    gameTime = tempTime - overTime
                    overTime = (overTime - (tempTime - gameTime))
                    GameLoop    'Run the game loop
                    DoEvents
                    If GetTickCount > fpsTime Then
                        If cycleCount >= 65 Then
                            overTime = 0
                            gameTime = tempTime
                        End If
                        cycleCount = 0
                        fpsTime = GetTickCount + 1000
                        GoalTime = fpsTime
                        If Debugger = True Then frmLevelDebugger.lblFPS = fpsCount
                        If ShowFPS = True Then
                            PrintFPS = fpsCount
                        End If
                        fpsCount = 0
                    End If
                    If LivingPlayers = False Then
                        EveryonesDead
                    End If
                End If
            Loop While LevelSelect = False And GameMenu = False
            If TestLevel = True Then
                TestLevel = False
                LevelEditor = True
                If nPlay.Online = False Then
                    OpenLevel FullFileName
                Else
                    If nPlay.Mode = 1 Then
                        Netplay.sendData "H0" & LB
                        If Len(FullFileName) > 4 Then
                            If LCase(Right(FullFileName, 4)) = ".lvl" Then
                                OpenLevel FullFileName
                            Else
                                For A = 1 To 15
                                    If nPlay.ClientCon(A) = True Then Netplay.InitSync A
                                Next A
                            End If
                        Else
                            For A = 1 To 15
                                If nPlay.ClientCon(A) = True Then Netplay.InitSync A
                            Next A
                        End If
                    End If
                End If
                LevelSelect = False
            Else
                ClearLevel
            End If
        End If
    Loop
End Sub

Public Sub SetupVars() 'Set up object sizes and frame offsets for blocks/npcs/effects
    Dim A As Integer
    SetupPlayerFrames
    For A = 1 To maxEffectType
        EffectWidth(A) = 32
        EffectHeight(A) = 32
    Next A
    For A = 1 To maxNPCType
        NPCSpeedvar(A) = 1
    Next A
    For A = 174 To 186
        BackgroundFence(A) = True
    Next A
    GFXLevelBig(21) = True
    GFXLevelBig(22) = True
    GFXLevelBig(23) = True
    GFXLevelBig(24) = True
    GFXLevelBig(28) = True
    
    EffectWidth(145) = 32
    EffectHeight(145) = 60
    
    EffectWidth(71) = 16
    EffectHeight(71) = 16
    EffectWidth(148) = 16
    EffectHeight(148) = 16
    
    
    EffectWidth(111) = 16
    EffectHeight(111) = 16
    EffectHeight(121) = 48
    
    EffectWidth(144) = 54
    EffectHeight(144) = 42
    
    
    EffectWidth(143) = 64
    EffectHeight(143) = 64
    
    EffectWidth(120) = 48
    EffectHeight(121) = 48
    
    
    EffectWidth(138) = 48
    EffectHeight(138) = 64
    
    
    EffectWidth(125) = 80
    EffectHeight(125) = 34
    
    EffectWidth(134) = 32
    EffectHeight(134) = 58
    
    EffectWidth(130) = 30
    EffectHeight(130) = 34
    
    EffectWidth(132) = 32
    EffectHeight(132) = 32
    EffectWidth(133) = 10
    EffectHeight(133) = 8
    
   
    EffectWidth(1) = 16
    EffectHeight(1) = 16
    
    EffectWidth(135) = 16
    EffectHeight(135) = 16
    
    EffectWidth(104) = 32
    EffectHeight(104) = 32
    EffectWidth(105) = 64
    EffectHeight(105) = 72
    
    EffectWidth(129) = 30
    EffectHeight(129) = 42
    
    EffectWidth(106) = 80
    EffectHeight(106) = 94
    
    EffectWidth(108) = 64
    EffectHeight(108) = 64
    
    EffectWidth(112) = 96
    EffectHeight(112) = 106
    
    EffectWidth(4) = 32
    EffectHeight(4) = 32
    EffectWidth(8) = 32
    EffectHeight(8) = 32
    EffectWidth(9) = 32
    EffectHeight(9) = 32
    EffectWidth(10) = 32
    EffectHeight(10) = 32
    EffectWidth(11) = 32
    EffectHeight(11) = 32
    EffectWidth(12) = 8
    EffectHeight(12) = 8
    EffectWidth(13) = 84
    EffectHeight(13) = 26
    EffectWidth(14) = 62
    EffectHeight(14) = 32
    EffectWidth(15) = 32
    EffectHeight(15) = 28
    EffectWidth(16) = 128
    EffectHeight(16) = 128
    EffectWidth(17) = 32
    EffectHeight(17) = 32
    EffectWidth(18) = 32
    EffectHeight(18) = 32
    EffectWidth(19) = 32
    EffectHeight(19) = 32
    EffectWidth(20) = 32
    EffectHeight(20) = 32
    EffectWidth(21) = 16
    EffectHeight(21) = 16
    EffectWidth(22) = 32
    EffectHeight(22) = 32
    EffectWidth(23) = 32
    EffectHeight(23) = 32
    EffectWidth(24) = 32
    EffectHeight(24) = 32
    EffectWidth(25) = 32
    EffectHeight(25) = 48
    EffectWidth(26) = 32
    EffectHeight(26) = 32
    EffectWidth(29) = 40
    EffectHeight(29) = 64
    EffectWidth(30) = 16
    EffectHeight(30) = 16
    EffectWidth(31) = 32
    EffectHeight(31) = 32
    EffectWidth(32) = 32
    EffectHeight(32) = 62
    EffectWidth(33) = 32
    EffectHeight(33) = 32
    EffectWidth(34) = 32
    EffectHeight(34) = 32
    EffectWidth(35) = 32
    EffectHeight(35) = 32
    EffectWidth(36) = 32
    EffectHeight(36) = 32
    EffectWidth(37) = 32
    EffectHeight(37) = 32
    EffectWidth(38) = 32
    EffectHeight(38) = 32
    EffectWidth(45) = 48
    EffectHeight(45) = 46
    EffectWidth(46) = 48
    EffectHeight(46) = 46
    EffectWidth(47) = 44
    EffectHeight(47) = 44
    EffectWidth(48) = 32
    EffectHeight(48) = 32
    EffectWidth(50) = 64
    EffectHeight(50) = 80
    EffectWidth(51) = 16
    EffectHeight(51) = 16
    EffectWidth(54) = 32
    EffectHeight(54) = 64
    EffectWidth(55) = 32
    EffectHeight(55) = 64
    EffectWidth(56) = 32
    EffectHeight(56) = 32
    EffectWidth(57) = 16
    EffectHeight(57) = 16
    EffectWidth(58) = 32
    EffectHeight(58) = 32
    EffectWidth(59) = 32
    EffectHeight(59) = 64
    EffectWidth(60) = 32
    EffectHeight(60) = 32
    EffectWidth(61) = 32
    EffectHeight(61) = 32
    EffectWidth(62) = 32
    EffectHeight(62) = 32
    EffectWidth(63) = 48
    EffectHeight(63) = 48
    EffectWidth(64) = 32
    EffectHeight(64) = 32
    EffectWidth(65) = 32
    EffectHeight(65) = 32
    EffectWidth(66) = 32
    EffectHeight(66) = 32
    EffectWidth(67) = 32
    EffectHeight(67) = 32
    EffectWidth(68) = 16
    EffectHeight(68) = 16
    EffectWidth(69) = 64
    EffectHeight(69) = 64
    EffectWidth(70) = 16
    EffectHeight(70) = 16
    EffectWidth(71) = 16
    EffectHeight(71) = 16
    EffectWidth(72) = 32
    EffectHeight(72) = 28
    EffectWidth(73) = 32
    EffectHeight(73) = 32
    EffectWidth(74) = 8
    EffectHeight(74) = 10
    EffectWidth(75) = 32
    EffectHeight(75) = 32
    EffectWidth(76) = 14
    EffectHeight(76) = 14
    EffectWidth(77) = 8
    EffectHeight(77) = 8
    EffectWidth(139) = 8
    EffectHeight(139) = 8
    EffectWidth(78) = 10
    EffectHeight(78) = 10
    EffectWidth(79) = 50
    EffectHeight(79) = 24
    EffectWidth(80) = 16
    EffectHeight(80) = 16
    EffectWidth(81) = 32
    EffectHeight(81) = 32
    EffectWidth(82) = 32
    EffectHeight(82) = 32
    EffectWidth(83) = 32
    EffectHeight(83) = 42
    EffectWidth(84) = 32
    EffectHeight(84) = 32
    EffectWidth(85) = 32
    EffectHeight(85) = 32
    EffectWidth(86) = 40
    EffectHeight(86) = 64
    EffectWidth(87) = 64
    EffectHeight(87) = 64
    EffectWidth(88) = 32
    EffectHeight(88) = 32
    EffectWidth(89) = 26
    EffectHeight(89) = 46
    EffectWidth(90) = 48
    EffectHeight(90) = 96
    EffectWidth(91) = 140
    EffectHeight(91) = 128
    EffectWidth(92) = 32
    EffectHeight(92) = 32
    EffectWidth(93) = 32
    EffectHeight(93) = 32
    EffectWidth(94) = 32
    EffectHeight(94) = 32
    EffectWidth(97) = 48
    EffectHeight(97) = 64
    EffectWidth(98) = 64
    EffectHeight(98) = 64
    EffectWidth(99) = 48
    EffectHeight(99) = 64
    EffectWidth(100) = 16
    EffectHeight(100) = 16
    
    EffectWidth(113) = 8
    EffectHeight(113) = 8
    
    EffectWidth(140) = 32
    EffectHeight(140) = 40
    
    
    EffectWidth(114) = 32
    EffectHeight(114) = 32
    
    EffectWidth(103) = 120
    EffectHeight(103) = 96
    
    EffectWidth(123) = 32
    EffectHeight(123) = 32
    EffectWidth(124) = 32
    EffectHeight(124) = 32
    EffectHeight(95) = 28
    EffectHeight(96) = 28
    
    EffectHeight(46) = 46
    EffectWidth(46) = 48
    EffectHeight(47) = 44
    EffectWidth(47) = 44
            
    For A = 1 To maxNPCType
        NPCScore(A) = 2
        NPCWidth(A) = 32
        NPCHeight(A) = 32
    Next A
    
    NPCWidth(291) = 22
    NPCHeight(291) = 18
    NPCWidthGFX(291) = 42
    NPCHeightGFX(291) = 34
    NPCWontHurt(291) = True
    NPCJumpHurt(291) = True
    NPCNoYoshi(291) = True
    
    
    
    NPCNoYoshi(256) = True
    NPCNoYoshi(257) = True
    NPCNoYoshi(239) = True
    
    
    NPCScore(208) = 0
    NPCScore(15) = 7
    NPCScore(39) = 7
    NPCScore(86) = 9
    NPCScore(200) = 9
    NPCScore(201) = 9
    NPCScore(209) = 9
    NPCScore(29) = 5
    NPCScore(47) = 6
    NPCScore(284) = 6
    NPCScore(256) = 5
    NPCScore(257) = 5
    NPCScore(262) = 8
    NPCScore(267) = 8
    NPCScore(268) = 8
    NPCScore(280) = 8
    NPCScore(281) = 8
    NPCFrameOffsetY(251) = 2
    NPCFrameOffsetY(252) = 2
    NPCFrameOffsetY(253) = 2
    NPCFrameOffsetY(195) = 2
    NPCFrameOffsetY(77) = 2
    
    NPCWontHurt(288) = True
    NPCJumpHurt(288) = True
    
    NPCWontHurt(287) = True
    NPCWontHurt(195) = True
    NPCForeground(210) = True
    NPCForeground(230) = True
    
    NPCIsCheep(28) = True
    NPCIsCheep(229) = True
    NPCIsCheep(230) = True
    NPCIsCheep(232) = True
    NPCIsCheep(233) = True
    NPCIsCheep(234) = True
    NPCIsCheep(236) = True
    
    
    NPCNoClipping(289) = True
    NPCWontHurt(289) = True
    NPCJumpHurt(289) = True
    NPCWidth(289) = 32
    NPCHeight(289) = 32
    NPCWidthGFX(289) = 32
    NPCHeightGFX(289) = 64
    
    
    NPCWidth(283) = 48
    NPCHeight(283) = 48
    NPCWidthGFX(283) = 64
    NPCHeightGFX(283) = 64
    NPCFrameOffsetY(283) = 8
    NPCWontHurt(283) = True
    NPCJumpHurt(283) = True

    NPCWidthGFX(290) = 32
    NPCHeightGFX(290) = 64
    NPCForeground(290) = True
    NPCCanWalkOn(290) = True
    NPCIsABlock(290) = True
    NPCWontHurt(290) = True
    NPCNoClipping(290) = True

    
    NPCCanWalkOn(263) = True
    NPCWontHurt(263) = True
    NPCMovesPlayer(263) = True
    NPCIsGrabbable(263) = True
    NPCGrabFromTop(263) = True
    NPCIsABlock(263) = True
    
    NPCCanWalkOn(262) = True
    NPCWidth(262) = 40
    NPCHeight(262) = 56
    NPCWidthGFX(262) = 48
    NPCHeightGFX(262) = 64
    
    
    
    NPCIsABonus(254) = True
    NPCIsAShell(237) = True
    NPCWontHurt(237) = True
    NPCCanWalkOn(237) = True
    NPCJumpHurt(13) = True
    NPCJumpHurt(86) = True
    NPCJumpHurt(260) = True
    
    
    
    NPCNoYoshi(263) = True
    NPCNoYoshi(265) = True
    NPCNoYoshi(260) = True
    NPCNoYoshi(255) = True
    
    NPCNoClipping(270) = True
    
    NPCJumpHurt(246) = True
    NPCNoClipping(246) = True
    NPCNoYoshi(246) = True
    NPCWidth(246) = 16
    NPCHeight(246) = 16
    
    NPCWidth(251) = 18 'TLOZ Rupee
    NPCHeight(251) = 32
    NPCIsABonus(251) = True
    NPCIsACoin(251) = True
    
    NPCWidth(252) = 18 'TLOZ Rupee
    NPCHeight(252) = 32
    NPCIsABonus(252) = True
    NPCIsACoin(252) = True
    
    NPCWidth(253) = 18 'TLOZ Rupee
    NPCHeight(253) = 32
    NPCIsABonus(253) = True
    NPCIsACoin(253) = True
    
    NPCWidth(250) = 32 'TLOZ Heart
    NPCHeight(250) = 32
    NPCIsABonus(250) = True
    
    'vines
    For A = 213 To 224
        NPCIsAVine(A) = True
        NPCWontHurt(A) = True
        NPCNoClipping(A) = True
        NPCJumpHurt(A) = True
        NPCNoYoshi(A) = True
        NPCWidth(A) = 16
        NPCWidthGFX(A) = 32
        NPCHeightGFX(A) = 32
    Next A
    NPCHeight(223) = 24
    NPCHeightGFX(223) = 24
    NPCJumpHurt(231) = True
    NPCWontHurt(225) = True
    NPCJumpHurt(225) = True
    NPCNoYoshi(225) = True
    NPCWontHurt(226) = True
    NPCJumpHurt(226) = True
    NPCNoYoshi(226) = True
    NPCWontHurt(227) = True
    NPCJumpHurt(227) = True
    NPCNoYoshi(227) = True
    
    NPCNoYoshi(211) = True
    
    NPCIsGrabbable(195) = True
    NPCGrabFromTop(195) = True
    
    NPCWidth(240) = 32
    NPCHeight(240) = 32
    NPCIsABonus(240) = 32
    
    NPCWidth(248) = 32
    NPCHeight(248) = 32
    NPCIsABonus(248) = 32
    
    NPCWidth(200) = 64
    NPCHeight(200) = 72
    NPCFrameOffsetY(200) = 2
    NPCJumpHurt(200) = True
    NPCJumpHurt(210) = True
    NPCNoClipping(259) = True
    NPCNoYoshi(259) = True
    NPCJumpHurt(259) = True
    NPCWidth(260) = 16
    NPCHeight(260) = 16
    NPCNoClipping(260) = True
    
    NPCWidth(153) = 32 'Poison Mushroom
    NPCHeight(153) = 32
    NPCFrameOffsetY(153) = 2
    
    NPCWidth(242) = 32 'SML2 Goomba
    NPCHeight(242) = 32
    NPCFrameOffsetY(242) = 2
    NPCDefaultMovement(242) = True
    
    NPCWidth(243) = 32 'SML2 Flying Goomba
    NPCHeight(243) = 32
    NPCFrameOffsetY(243) = 2
    NPCWidthGFX(243) = 56
    NPCHeightGFX(243) = 36
    
    NPCWidth(244) = 32 'SMB3 Flying Goomba
    NPCHeight(244) = 32
    NPCFrameOffsetY(244) = 2
    NPCWidthGFX(244) = 40
    NPCHeightGFX(244) = 48
    
    NPCWidth(255) = 20
    NPCHeight(255) = 96
    NPCWontHurt(255) = True
    NPCIsABlock(255) = True
    NPCCanWalkOn(255) = True
    NPCMovesPlayer(255) = True
    
    NPCIsAParaTroopa(244) = True
    NPCIsAParaTroopa(243) = True
    
    NPCWidth(1) = 32 'Goomba
    NPCHeight(1) = 32
    NPCFrameOffsetY(1) = 2
    
    NPCWidth(1) = 32 'Goomba
    NPCHeight(1) = 32
    NPCFrameOffsetY(1) = 2
    NPCWidth(2) = 32 'Red goomba
    NPCHeight(2) = 32
    NPCFrameOffsetY(2) = 2
    NPCWidth(3) = 32 'Flying goomba
    NPCHeight(3) = 32
    NPCWidthGFX(3) = 40
    NPCHeightGFX(3) = 48
    NPCFrameOffsetY(3) = 2
    NPCWidth(4) = 32 'Green koopa
    NPCHeight(4) = 32
    NPCWidthGFX(4) = 32
    NPCHeightGFX(4) = 54
    NPCFrameOffsetY(4) = 2
    NPCWidth(5) = 32 'Green shell
    NPCHeight(5) = 32
    NPCFrameOffsetY(5) = 2
    NPCWidth(6) = 32 'Red koopa
    NPCHeight(6) = 32
    NPCWidthGFX(6) = 32
    NPCHeightGFX(6) = 54
    NPCFrameOffsetY(6) = 2
    NPCWidth(7) = 32 'Red shell
    NPCHeight(7) = 32
    NPCFrameOffsetY(7) = 2
    NPCWidth(8) = 32 'Plant
    NPCHeight(8) = 48
    NPCWidthGFX(8) = 32
    NPCHeightGFX(8) = 48
    NPCWidth(245) = 32 'SMB 3 Fire Plant
    NPCHeight(245) = 64
    NPCWidthGFX(245) = 32
    NPCHeightGFX(245) = 64
    NPCFrameOffsetY(8) = 1
    NPCWidth(9) = 32 'Mushroom
    NPCHeight(9) = 32
    NPCFrameOffsetY(9) = 2
    
    NPCWidth(273) = 32 '? Mushroom
    NPCHeight(273) = 32
    NPCFrameOffsetY(273) = 2
    
    NPCWidth(249) = 32 'SMB2 Mushroom
    NPCHeight(249) = 32
    NPCIsABonus(249) = True
    
    NPCWidth(274) = 32 'dragon coin
    NPCHeight(274) = 50
    NPCIsABonus(274) = True
    NPCIsACoin(274) = True
    NPCScore(274) = 6
    
    NPCWidth(10) = 28 'SMB3 Coin
    NPCHeight(10) = 32
    NPCWidth(11) = 32 'SMB3 Level exit
    NPCHeight(11) = 32
    NPCWidth(12) = 28 'Big Fireball
    NPCHeight(12) = 32
    NPCWidth(13) = 16 'Small Fireball
    NPCHeight(13) = 16
    NPCWidth(265) = 16 'Ice Bolt
    NPCHeight(265) = 16
    NPCNoIceBall(265) = True
    NPCNoYoshi(13) = True
    NPCWidth(14) = 32 'Fire Flower
    NPCHeight(14) = 32
    NPCFrameOffsetY(14) = 2
    NPCWidth(264) = 32 'Ice Flower
    NPCHeight(264) = 32
    NPCFrameOffsetY(264) = 2
    NPCWidth(277) = 32 'Ice Flower
    NPCHeight(277) = 32
    NPCFrameOffsetY(277) = 2
    NPCWidth(15) = 60 'Big Koopa
    NPCHeight(15) = 54
    NPCWidthGFX(15) = 68
    NPCHeightGFX(15) = 54
    NPCFrameOffsetY(15) = 2
    NPCNoYoshi(15) = True
    NPCWidth(16) = 32 'Boss Exit
    NPCHeight(16) = 32
    NPCWidth(17) = 32 'Bullet Bill
    NPCHeight(17) = 28
    NPCWidth(18) = 128 'Giant Bullet Bill
    NPCHeight(18) = 128
    NPCNoYoshi(18) = True
    NPCWidth(19) = 32 'Red Shy guy
    NPCHeight(19) = 32
    NPCWidth(20) = 32 'Blue Shy guy
    NPCHeight(20) = 32
    NPCWidth(247) = 32 'Cactus Thing
    NPCHeight(247) = 32
    NPCWidth(21) = 32 'Bullet Bill Shooter
    NPCHeight(21) = 32
    NPCNoYoshi(21) = True
    NPCWidth(22) = 32 'Bullet Bill Gun
    NPCHeight(22) = 32
    NPCFrameOffsetY(22) = 2
    NPCWidth(23) = 32 'Hard thing
    NPCHeight(23) = 32
    NPCFrameOffsetY(23) = 2
    NPCWidth(24) = 32 'Hard Thing shell
    NPCHeight(24) = 32
    NPCFrameOffsetY(24) = 2
    NPCWidth(25) = 32 'Bouncy Start Thing
    NPCHeight(25) = 32
    NPCWidth(26) = 32 'Spring
    NPCHeight(26) = 32
    NPCWidthGFX(26) = 32
    NPCHeightGFX(26) = 32
    NPCFrameOffsetY(26) = 2
    NPCWidth(27) = 32 'Grey goomba
    NPCHeight(27) = 32
    NPCWidth(28) = 32 'Red Jumping Fish
    NPCHeight(28) = 32
    NPCWidth(29) = 32 'Hammer Bro
    NPCHeight(29) = 48
    NPCFrameOffsetY(29) = 2
    NPCWidth(30) = 32 'Hammer
    NPCHeight(30) = 32
    NPCNoYoshi(30) = True
    NPCWidth(31) = 32 'Key
    NPCHeight(31) = 32
    NPCFrameOffsetY(31) = 1
    NPCWidth(32) = 32 'P Switch
    NPCHeight(32) = 32
    NPCFrameOffsetY(32) = 2
    NPCWidth(238) = 32 'P Switch Time
    NPCHeight(238) = 32
    NPCFrameOffsetY(238) = 2
    NPCWidth(239) = 32 'Push down thing
    NPCHeight(239) = 32
    NPCFrameOffsetY(239) = 2
    NPCWidth(33) = 24 'SMW Coin
    NPCHeight(33) = 32
    NPCWidth(258) = 24 'SMW Blue Coin
    NPCHeight(258) = 32
    NPCWidth(34) = 32 'Leaf
    NPCHeight(34) = 32
    NPCWidth(35) = 32 'Goombas Shoe
    NPCHeight(35) = 32
    NPCFrameOffsetY(35) = 2
    NPCFrameOffsetY(191) = 2
    NPCFrameOffsetY(193) = 2
    
    NPCWidth(285) = 32 'Spiney
    NPCHeight(285) = 32
    NPCFrameOffsetY(285) = 2
    NPCWidth(286) = 32 'Falling Spiney
    NPCHeight(286) = 32
    NPCFrameOffsetY(286) = 2
    
    NPCWidth(36) = 32 'Spiney
    NPCHeight(36) = 32
    NPCFrameOffsetY(36) = 2
    NPCWidth(37) = 48 'Thwomp
    NPCHeight(37) = 64
    NPCNoYoshi(37) = True
    NPCWidth(38) = 32 'Boo
    NPCHeight(38) = 32
    NPCNoYoshi(38) = True
    NPCWidth(39) = 32 'Birdo
    NPCHeight(39) = 60
    NPCWidthGFX(39) = 40
    NPCHeightGFX(39) = 72
    NPCFrameOffsetY(39) = 2
    NPCFrameOffsetX(39) = 3
    NPCNoYoshi(39) = True
    NPCWidth(40) = 32 'egg
    NPCHeight(40) = 24
    NPCWidth(41) = 32 'smb2 exit(birdo)
    NPCHeight(41) = 32
    NPCWidth(42) = 32 'ghost 1
    NPCHeight(42) = 32
    NPCNoYoshi(42) = True
    NPCWidth(43) = 32 'ghost 2
    NPCHeight(43) = 32
    NPCNoYoshi(43) = True
    NPCWidth(44) = 128 'big ghost
    NPCHeight(44) = 120
    NPCWidthGFX(44) = 140
    NPCHeightGFX(44) = 128
    NPCNoYoshi(44) = True
    NPCWidth(45) = 32 'ice block
    NPCHeight(45) = 32
    NPCWidth(46) = 32 'falling block
    NPCHeight(46) = 32
    NPCNoYoshi(46) = True
    NPCNoYoshi(212) = True
    NPCWidth(47) = 32 'lakitu
    NPCHeight(47) = 48
    NPCWidthGFX(47) = 32
    NPCHeightGFX(47) = 64
    NPCWidth(284) = 40 'smw lakitu
    NPCHeight(284) = 48
    NPCFrameOffsetY(284) = 6
    NPCWidthGFX(284) = 56
    NPCHeightGFX(284) = 72
    
    NPCWidth(48) = 32 'unripe spiney
    NPCHeight(48) = 32
    NPCWidth(49) = 32 'killer pipe
    NPCHeight(49) = 32
    NPCFrameOffsetY(49) = 2
    NPCWidth(50) = 48 'killer plant
    NPCHeight(50) = 32
    NPCFrameOffsetY(50) = 2
    NPCNoYoshi(50) = True
    NPCWidth(51) = 32 'down piranha plant
    NPCHeight(51) = 64
    NPCWidth(52) = 48 'left.right piranha plant
    NPCHeight(52) = 32
    NPCWidth(53) = 32 'mr crabs
    NPCHeight(53) = 32
    NPCFrameOffsetY(53) = 2
    NPCWidth(54) = 32 'bee thing
    NPCHeight(54) = 32
    NPCFrameOffsetY(54) = 2
    NPCWidth(55) = 32 'nekkid koopa
    NPCHeight(55) = 32
    NPCFrameOffsetY(55) = 2
    NPCWidth(56) = 128 'koopa clown car
    NPCHeight(56) = 128
    NPCNoYoshi(56) = True
    NPCWidth(57) = 32 'smb3 conveyer belt
    NPCHeight(57) = 32
    NPCNoYoshi(57) = True
    NPCWidth(58) = 32 'smb3 barrel
    NPCHeight(58) = 32
    NPCNoYoshi(58) = True
    NPCWidth(59) = 32 'purple goomba
    NPCHeight(59) = 32
    NPCFrameOffsetY(59) = 2
    NPCWidth(60) = 96 'purple platform
    NPCHeight(60) = 32
    NPCNoYoshi(60) = True
    NPCWidth(61) = 32 'blue goomba
    NPCHeight(61) = 32
    NPCFrameOffsetY(61) = 2
    NPCWidth(62) = 96 'blue platform
    NPCHeight(62) = 32
    NPCNoYoshi(62) = True
    NPCWidth(63) = 32 'green goomba
    NPCHeight(63) = 32
    NPCFrameOffsetY(63) = 2
    NPCWidth(64) = 96 'green platform
    NPCHeight(64) = 32
    NPCNoYoshi(64) = True
    NPCWidth(65) = 32 'red goomba
    NPCHeight(65) = 32
    NPCFrameOffsetY(65) = 2
    NPCWidth(66) = 96 'red platform
    NPCHeight(66) = 32
    NPCNoYoshi(66) = True
    NPCWidth(67) = 128 'grey pipe x
    NPCHeight(67) = 32
    NPCNoYoshi(67) = True
    NPCWidth(68) = 256 'big grey pipe x
    NPCHeight(68) = 32
    NPCNoYoshi(68) = True
    NPCWidth(69) = 32 'grey pipe y
    NPCHeight(69) = 127.9
    NPCNoYoshi(69) = True
    NPCWidth(70) = 32 'big grey pipe y
    NPCHeight(70) = 255.9
    NPCNoYoshi(70) = True
    NPCWidth(71) = 48 'giant goomba
    NPCHeight(71) = 46
    NPCFrameOffsetY(71) = 2
    NPCWidth(72) = 48 'giant green koopa
    NPCHeight(72) = 48
    NPCFrameOffsetY(72) = 2
    NPCWidthGFX(72) = 48
    NPCHeightGFX(72) = 62
    NPCWidth(73) = 44 'giant green shell
    NPCHeight(73) = 44
    NPCFrameOffsetY(73) = 2
    NPCWidth(74) = 48 'giant pirhana plant
    NPCHeight(74) = 64
    NPCFrameOffsetY(74) = 2
    
    NPCWidth(256) = 48 'gianter pirhana plant
    NPCHeight(256) = 128
    NPCFrameOffsetY(256) = 2
    
    NPCWidth(257) = 48 'gianter pirhana plant
    NPCHeight(257) = 128
    
    NPCWidth(75) = 38 'toad
    NPCHeight(75) = 54
    NPCFrameOffsetY(75) = 2
    NPCWidthGFX(75) = 38
    NPCHeightGFX(75) = 58
    NPCIsToad(75) = True
    NPCWidth(76) = 32 'flying green koopa
    NPCHeight(76) = 32
    NPCFrameOffsetY(76) = 2
    NPCWidthGFX(76) = 32
    NPCHeightGFX(76) = 56
    NPCIsAParaTroopa(76) = True
    NPCWidth(161) = 32 'flying red koopa
    NPCHeight(161) = 32
    NPCFrameOffsetY(161) = 2
    NPCWidthGFX(161) = 32
    NPCHeightGFX(161) = 56
    NPCIsAParaTroopa(161) = True
    NPCWidth(77) = 32 'black ninja
    NPCHeight(77) = 32
    NPCFrameOffsetY(73) = 2
    NPCWidth(78) = 128 'tank treads
    NPCHeight(78) = 32
    NPCNoYoshi(78) = True
    NPCWidth(79) = 64 'tank parts
    NPCHeight(79) = 32
    NPCNoYoshi(79) = True
    NPCWidth(80) = 128 'tank parts
    NPCHeight(80) = 32
    NPCNoYoshi(80) = True
    NPCWidth(81) = 128 'tank parts
    NPCHeight(81) = 32
    NPCNoYoshi(81) = True
    NPCWidth(82) = 128 'tank parts
    NPCHeight(82) = 32
    NPCNoYoshi(82) = True
    NPCWidth(83) = 256 'tank parts
    NPCHeight(83) = 32
    NPCNoYoshi(83) = True
    NPCWidth(84) = 32 'bowser statue
    NPCHeight(84) = 64
    NPCNoYoshi(84) = True
    NPCWidth(85) = 32 'statue fireball
    NPCHeight(85) = 16
    NPCNoYoshi(85) = True
    NPCWidth(86) = 62 'smb3 bowser
    NPCHeight(86) = 80
    NPCWidthGFX(86) = 64
    NPCHeightGFX(86) = 80
    NPCFrameOffsetY(86) = 2
    NPCNoYoshi(86) = True
    NPCWidth(87) = 48 'smb3 bowser fireball
    NPCHeight(87) = 32
    NPCNoYoshi(87) = True
    NPCWidth(88) = 20 'smb1 coin
    NPCHeight(88) = 32
    NPCWidth(89) = 32 'smb1 brown goomba
    NPCHeight(89) = 32
    NPCFrameOffsetY(89) = 2
    NPCWidth(90) = 32 '1 up
    NPCHeight(90) = 32
    NPCFrameOffsetY(90) = 2
    NPCIsAHit1Block(90) = True
    NPCWidth(91) = 32 'grab grass
    NPCHeight(91) = 16
    NPCFrameOffsetY(91) = -16
    NPCWidth(92) = 32 'turnip
    NPCHeight(92) = 32
    NPCIsVeggie(92) = True
    NPCWidth(93) = 32 'SMB1 Plant
    NPCHeight(93) = 48
    NPCWidth(94) = 32 'Inert Toad
    NPCHeight(94) = 54
    
    NPCWidth(198) = 32 'Peach
    NPCHeight(198) = 64
    NPCFrameOffsetY(198) = 2
    NPCFrameOffsetY(94) = 2
    NPCIsToad(94) = True
    NPCIsToad(198) = True
    NPCWidth(95) = 32 'Green Yoshi
    NPCHeight(95) = 32
    NPCWidthGFX(95) = 74
    NPCHeightGFX(95) = 56
    NPCFrameOffsetY(95) = 2
    NPCNoYoshi(95) = True
    NPCWidth(96) = 32 'Yoshi Egg
    NPCHeight(96) = 32
    NPCWidth(97) = 32 'SMB3 Star
    NPCHeight(97) = 32
    NPCWidth(98) = 32 'Blue Yoshi
    NPCHeight(98) = 32
    NPCWidthGFX(98) = 74
    NPCHeightGFX(98) = 56
    NPCFrameOffsetY(98) = 2
    NPCWidth(99) = 32 'Yellow Yoshi
    NPCHeight(99) = 32
    NPCWidthGFX(99) = 74
    NPCHeightGFX(99) = 56
    NPCFrameOffsetY(99) = 2
    NPCWidth(100) = 32 'Red Yoshi
    NPCHeight(100) = 32
    NPCWidthGFX(100) = 74
    NPCHeightGFX(100) = 56
    NPCFrameOffsetY(100) = 2
    NPCWidth(101) = 28 'Luigi
    NPCHeight(101) = 62
    NPCFrameOffsetY(101) = 2
    NPCIsToad(101) = True
    NPCWidth(102) = 32 'Link
    NPCHeight(102) = 64
    NPCFrameOffsetY(102) = 2
    NPCIsToad(102) = True
    NPCWidth(103) = 28 'SMB3 Red Coin
    NPCHeight(103) = 32
    NPCWidth(104) = 96 'SMB3 Platform
    NPCHeight(104) = 32
    NPCNoYoshi(104) = True
    NPCWidth(105) = 128 'SMW Falling Platform
    NPCHeight(105) = 22
    NPCNoYoshi(105) = True
    NPCWidth(106) = 128 'SMB Platform
    NPCHeight(106) = 16
    NPCNoYoshi(106) = True
    NPCWidth(107) = 24 'Bob-omb buddy
    NPCHeight(107) = 38
    NPCWidthGFX(107) = 48
    NPCHeightGFX(107) = 38
    NPCFrameOffsetY(107) = 2
    NPCIsToad(107) = True
    NPCWidth(108) = 32 'Yoshi Fireball
    NPCHeight(108) = 32
    NPCNoYoshi(108) = True
    NPCWidth(109) = 32 'SMW Green Koopa
    NPCHeight(109) = 32
    NPCWidthGFX(109) = 32
    NPCHeightGFX(109) = 54
    NPCFrameOffsetY(109) = 2
    NPCDefaultMovement(109) = True
    NPCWidth(110) = 32 'SMW Red Koopa
    NPCHeight(110) = 32
    NPCWidthGFX(110) = 32
    NPCHeightGFX(110) = 54
    NPCFrameOffsetY(110) = 2
    NPCTurnsAtCliffs(110) = True
    NPCDefaultMovement(110) = True
    NPCWidth(111) = 32 'SMW Blue Koopa
    NPCHeight(111) = 32
    NPCWidthGFX(111) = 32
    NPCHeightGFX(111) = 54
    NPCFrameOffsetY(111) = 2
    NPCTurnsAtCliffs(111) = True
    NPCDefaultMovement(111) = True
    NPCWidth(112) = 32 'SMW Yellow Koopa
    NPCHeight(112) = 32
    NPCWidthGFX(112) = 32
    NPCHeightGFX(112) = 54
    NPCFrameOffsetY(112) = 2
    NPCTurnsAtCliffs(112) = True
    NPCDefaultMovement(112) = True
    NPCWidth(113) = 32 'SMW Green Shell
    NPCHeight(113) = 32
    NPCFrameOffsetY(113) = 2
    NPCIsAShell(113) = True
    NPCWidth(114) = 32 'SMW Red Shell
    NPCHeight(114) = 32
    NPCFrameOffsetY(114) = 2
    NPCIsAShell(114) = True
    NPCWidth(115) = 32 'SMW Blue Shell
    NPCHeight(115) = 32
    NPCFrameOffsetY(115) = 2
    NPCIsAShell(115) = True
    NPCWidth(116) = 32 'SMW Yellow Shell
    NPCHeight(116) = 32
    NPCFrameOffsetY(116) = 2
    NPCIsAShell(116) = True
    NPCWidth(117) = 32 'SMW Green Beach Koopa
    NPCHeight(117) = 32
    NPCFrameOffsetY(117) = 2
    NPCDefaultMovement(117) = True
    NPCWidth(118) = 32 'SMW Red Beach Koopa
    NPCHeight(118) = 32
    NPCFrameOffsetY(118) = 2
    NPCTurnsAtCliffs(118) = True
    NPCDefaultMovement(118) = True
    NPCWidth(119) = 32 'SMW Blue Beach Koopa
    NPCHeight(119) = 32
    NPCFrameOffsetY(119) = 2
    NPCTurnsAtCliffs(119) = True
    NPCDefaultMovement(119) = True
    NPCWidth(120) = 32 'SMW Yellow Beach Koopa
    NPCHeight(120) = 32
    NPCFrameOffsetY(120) = 2
    NPCTurnsAtCliffs(120) = True
    NPCDefaultMovement(120) = True
    NPCWidth(121) = 32 'SMW Green Para-Koopa
    NPCHeight(121) = 32
    NPCWidthGFX(121) = 56
    NPCHeightGFX(121) = 56
    NPCFrameOffsetY(121) = 2
    NPCIsAParaTroopa(121) = True
    NPCWidth(122) = 32 'SMW Red Para-Koopa
    NPCHeight(122) = 32
    NPCWidthGFX(122) = 56
    NPCHeightGFX(122) = 56
    NPCFrameOffsetY(122) = 2
    NPCIsAParaTroopa(122) = True
    NPCWidth(123) = 32 'SMW Blue Para-Koopa
    NPCHeight(123) = 32
    NPCWidthGFX(123) = 56
    NPCHeightGFX(123) = 56
    NPCFrameOffsetY(123) = 2
    NPCIsAParaTroopa(123) = True
    NPCWidth(124) = 32 'SMW Yellow Para-Koopa
    NPCHeight(124) = 32
    NPCWidthGFX(124) = 56
    NPCHeightGFX(124) = 56
    NPCFrameOffsetY(124) = 2
    NPCIsAParaTroopa(124) = True
    NPCWidth(125) = 36 'Rat Head
    NPCHeight(125) = 56
    NPCWidthGFX(125) = 36
    NPCHeightGFX(125) = 66
    NPCFrameOffsetY(125) = 2
    NPCJumpHurt(261) = True
    NPCNoFireBall(261) = True
    NPCNoFireBall(17) = True
    NPCDefaultMovement(125) = True
    NPCNoYoshi(125) = True
    NPCWidth(126) = 32 'Blue Bot
    NPCHeight(126) = 34
    NPCWidthGFX(126) = 32
    NPCHeightGFX(126) = 26
    NPCIsABot(126) = True
    NPCWidth(127) = 32 'Cyan Bot
    NPCHeight(127) = 34
    NPCWidthGFX(127) = 32
    NPCHeightGFX(127) = 26
    NPCIsABot(127) = True
    NPCWidth(128) = 32 'Red Bot
    NPCHeight(128) = 34
    NPCWidthGFX(128) = 32
    NPCHeightGFX(128) = 26
    NPCWidth(129) = 32 'SMB2 Jumpy guy
    NPCHeight(129) = 32
    NPCCanWalkOn(129) = True
    NPCGrabFromTop(129) = True
    NPCDefaultMovement(129) = True
    NPCWidth(130) = 32 'Red Sniffit
    NPCHeight(130) = 32
    NPCCanWalkOn(130) = True
    NPCGrabFromTop(130) = True
    NPCDefaultMovement(130) = True
    NPCWidth(131) = 32 'Blue Sniffit
    NPCHeight(131) = 32
    NPCCanWalkOn(131) = True
    NPCGrabFromTop(131) = True
    NPCDefaultMovement(131) = True
    NPCTurnsAtCliffs(131) = True
    NPCWidth(132) = 32 'Grey Sniffit
    NPCHeight(132) = 32
    NPCCanWalkOn(132) = True
    NPCGrabFromTop(132) = True
    NPCDefaultMovement(132) = True
    NPCWidth(133) = 16 'Bullet
    NPCHeight(133) = 16
    NPCNoYoshi(133) = True
    NPCJumpHurt(133) = True
    NPCWidth(134) = 24 'SMB2 Bomb
    NPCHeight(134) = 24
    NPCWidthGFX(134) = 40
    NPCHeightGFX(134) = 40
    NPCWontHurt(134) = True
    NPCIsGrabbable(134) = True
    NPCGrabFromTop(134) = True
    NPCCanWalkOn(134) = True
    NPCWidth(135) = 32 'SMB2 Bob-om
    NPCHeight(135) = 32
    NPCGrabFromTop(135) = True
    NPCCanWalkOn(135) = True
    NPCDefaultMovement(135) = True
    NPCWidth(136) = 32 'SMB3 Bob-om
    NPCHeight(136) = 32
    NPCFrameOffsetY(136) = 2
    NPCDefaultMovement(136) = True
    NPCTurnsAtCliffs(136) = True
    NPCWidth(137) = 32 'SMB3 Bomb
    NPCHeight(137) = 28
    NPCFrameOffsetY(137) = 2
    NPCIsGrabbable(137) = True
    NPCWidth(138) = 28 'SMB 2 Coin
    NPCHeight(138) = 32
    NPCIsABonus(138) = True
    NPCIsACoin(138) = True
    NPCWidth(152) = 32 'Sonic Ring
    NPCHeight(152) = 32
    NPCIsABonus(152) = True
    NPCIsACoin(152) = True
    For A = 139 To 147 'Veggies
        NPCWidth(A) = GFXNPCWidth(A)
        NPCHeight(A) = GFXNPCHeight(A)
        NPCCanWalkOn(A) = True
        NPCGrabFromTop(A) = True
        NPCWontHurt(A) = True
        NPCIsGrabbable(A) = True
        NPCIsVeggie(A) = True
    Next A
    NPCWidth(148) = 32 'Black Yoshi
    NPCHeight(148) = 32
    NPCWidthGFX(148) = 74
    NPCHeightGFX(148) = 56
    NPCFrameOffsetY(148) = 2
    NPCNoYoshi(148) = True
    NPCWidth(149) = 32 'Purple Yoshi
    NPCHeight(149) = 32
    NPCWidthGFX(149) = 74
    NPCHeightGFX(149) = 56
    NPCFrameOffsetY(149) = 2
    NPCNoYoshi(149) = True
    NPCWidth(150) = 32 'Pink Yoshi
    NPCHeight(150) = 32
    NPCWidthGFX(150) = 74
    NPCHeightGFX(150) = 56
    NPCFrameOffsetY(150) = 2
    NPCWidth(228) = 32 'Ice Yoshi
    NPCHeight(228) = 32
    NPCWidthGFX(228) = 74
    NPCHeightGFX(228) = 56
    NPCFrameOffsetY(228) = 2
    NPCWidth(151) = 48 'SMW Sign
    NPCHeight(151) = 48
    NPCNoYoshi(151) = True
    NPCWontHurt(151) = True
    NPCNoClipping(151) = True
    NPCWidth(154) = 32 'SMB2 Mushroom Block
    NPCHeight(154) = 32
    NPCWidth(155) = 32 'SMB2 Mushroom Block
    NPCHeight(155) = 32
    NPCWidth(156) = 32 'SMB2 Mushroom Block
    NPCHeight(156) = 32
    NPCWidth(157) = 32 'SMB2 Mushroom Block
    NPCHeight(157) = 32
    NPCWidth(158) = 32 'Mr Saturn
    NPCHeight(158) = 42
    NPCFrameOffsetY(158) = 2
    NPCJumpHurt(158) = True
    NPCWidth(159) = 32 'Diggable Dirt
    NPCHeight(159) = 32
    NPCWidth(160) = 128 'Airship Rocket
    NPCHeight(160) = 32
    NPCWidthGFX(160) = 316
    NPCHeightGFX(160) = 32
    NPCNoYoshi(160) = True
    NPCWidth(154) = 32 'SMB2 Mushroom Block
    NPCHeight(154) = 32
    NPCWidth(162) = 32 'SMW Rex
    NPCHeight(162) = 60
    NPCWidthGFX(162) = 40
    NPCHeightGFX(162) = 64
    NPCFrameOffsetY(162) = 2
    NPCWidth(163) = 32 'SMW Rex Smashed
    NPCHeight(163) = 32
    NPCWidthGFX(163) = 32
    NPCHeightGFX(163) = 32
    NPCFrameOffsetY(163) = 2
    NPCWidth(164) = 58 'SMW Mega Mole
    NPCHeight(164) = 58
    NPCWidthGFX(164) = 64
    NPCHeightGFX(164) = 64
    NPCFrameOffsetY(164) = 2
    NPCWidth(165) = 32 'SMW Goomba
    NPCHeight(165) = 32
    NPCFrameOffsetY(165) = 2
    NPCWidth(166) = 32 'SMW Stomped Goomba Goomba
    NPCHeight(166) = 32
    NPCFrameOffsetY(166) = 2
    NPCWidth(167) = 32 'SMW Para-Goomba
    NPCHeight(167) = 32
    NPCWidthGFX(167) = 66
    NPCHeightGFX(167) = 50
    NPCFrameOffsetY(167) = 2
    NPCWidth(168) = 26 'Bully
    NPCHeight(168) = 30
    NPCWidthGFX(168) = 26
    NPCHeightGFX(168) = 46
    NPCFrameOffsetY(168) = 2
    NPCWidth(169) = 32 'Tanooki Suit
    NPCHeight(169) = 32
    NPCFrameOffsetY(169) = 2
    NPCIsABonus(169) = True
    NPCWidth(170) = 32 'Hammer Suit
    NPCHeight(170) = 32
    NPCFrameOffsetY(170) = 2
    NPCIsABonus(170) = True
    
    NPCWontHurt(292) = True 'Boomerang
    NPCJumpHurt(292) = True
    NPCNoClipping(292) = True
    NPCNoYoshi(292) = True
    NPCForeground(292) = True
    NPCNoIceBall(292) = True
    
    NPCNoIceBall(247) = True
    
    NPCWidth(171) = 16 'Hammer Suit Hammer
    NPCHeight(171) = 28
    NPCWontHurt(171) = True
    NPCNoClipping(171) = True
    NPCNoYoshi(171) = True
    
    NPCHeight(172) = 28 ' Green SMB1 Shell
    NPCIsAShell(172) = True
    NPCHeight(174) = 28 ' Red SMB1 Shell
    NPCIsAShell(174) = True
    NPCIsAShell(195) = True
    
    NPCJumpHurt(179) = True 'Razor Blade
    NPCWidthGFX(179) = 64
    NPCHeightGFX(179) = 64
    NPCWidth(179) = 48
    NPCHeight(179) = 48
    NPCFrameOffsetY(179) = 8
    NPCJumpHurt(180) = True 'SMW Thwomp
    NPCWidth(180) = 48
    NPCHeight(180) = 64
    NPCWidth(241) = 32 'POW
    NPCHeight(241) = 32 'POW
    NPCCanWalkOn(241) = True
    NPCMovesPlayer(241) = True
    NPCWontHurt(241) = True
    NPCIsABlock(241) = True
    NPCGrabFromTop(241) = True
    NPCIsGrabbable(241) = True
    
    NPCWontHurt(181) = True 'SMW Bowser Statue
    NPCIsABlock(181) = True
    NPCCanWalkOn(181) = True
    NPCMovesPlayer(181) = True
    NPCWidth(181) = 48
    NPCHeight(181) = 46
    NPCFrameOffsetY(181) = 2
    NPCWidth(197) = 48
    NPCHeight(197) = 16
    NPCIsABonus(197) = True
    NPCIsABonus(182) = True 'SMB1 Flower
    NPCIsABonus(183) = True 'SMW Flower
    NPCIsABonus(184) = True 'SMB1 Mushroom
    NPCIsABonus(185) = True 'SMW Mushroom
    NPCIsABonus(186) = True 'SMB1 1-up
    NPCIsABonus(187) = True 'SMW 1-up
    NPCIsABonus(188) = True 'SMW 3 up
    NPCWidth(188) = 30
    NPCWidth(189) = 32
    
    NPCNoYoshi(201) = True
    NPCNoYoshi(202) = True
    NPCJumpHurt(202) = True
    NPCWidth(201) = 80
    NPCHeight(201) = 94
    
    NPCWidth(199) = 56
    NPCHeight(199) = 60
    NPCWidthGFX(199) = 130
    NPCHeightGFX(199) = 64
    NPCJumpHurt(199) = True
    NPCNoClipping(199) = True
    NPCNoYoshi(203) = True
    NPCNoYoshi(204) = True
    NPCNoYoshi(205) = True
    NPCNoYoshi(206) = True
    
    NPCWidth(203) = 46
    NPCHeight(203) = 26
    NPCNoYoshi(203) = True
    NPCCanWalkOn(203) = True
    NPCNoYoshi(204) = True
    NPCCanWalkOn(204) = True
    NPCJumpHurt(201) = True
    
    NPCNoYoshi(208) = True
    NPCNoYoshi(209) = True
    NPCCanWalkOn(209) = True
    NPCMovesPlayer(209) = True
    NPCIsABlock(209) = True
    NPCNoClipping(209) = True
    NPCWidth(209) = 96
    NPCHeight(209) = 106
    
    NPCNoYoshi(202) = True
    NPCNoYoshi(201) = True
    NPCNoYoshi(200) = True
    
    NPCWidthGFX(189) = 48
    NPCHeightGFX(189) = 64
    NPCHeight(189) = 64
    NPCTurnsAtCliffs(189) = True
    NPCFrameOffsetY(189) = 2
    NPCDefaultMovement(189) = True
    NPCWidthGFX(175) = 32
    NPCWidthGFX(176) = 32
    NPCWidthGFX(177) = 32
    NPCWidthGFX(173) = 32
    NPCHeightGFX(175) = 48
    NPCHeightGFX(176) = 48
    NPCHeightGFX(177) = 48
    NPCHeightGFX(173) = 48
    
    NPCWidthGFX(190) = 32
    NPCHeightGFX(190) = 32
    
    NPCWidth(234) = 48
    
    NPCHeightGFX(235) = 48
    NPCWidthGFX(235) = 32
    NPCFrameOffsetY(235) = 16
    
    NPCJumpHurt(235) = True
    NPCJumpHurt(234) = True
    
    NPCHeight(190) = 20
    NPCFrameOffsetY(190) = 12
    NPCFrameOffsetY(194) = 2
    
    NPCMovesPlayer(190) = True
    
    NPCTurnsAtCliffs(175) = True
    
    NPCNoYoshi(178) = True
    NPCNoYoshi(179) = True
    NPCNoYoshi(180) = True
    NPCNoYoshi(181) = True
    NPCNoYoshi(189) = True
    
    NPCNoYoshi(190) = True
    NPCNoYoshi(192) = True
    NPCIsABonus(192) = True
    
    
    
    NPCIsAParaTroopa(176) = True
    NPCIsAParaTroopa(177) = True
    NPCIsABonus(178) = True
    NPCDefaultMovement(173) = True
    NPCDefaultMovement(175) = True
    NPCDefaultMovement(162) = True
    'NPCDefaultMovement(163) = True
    'NPCDefaultMovement(164) = True
    NPCDefaultMovement(165) = True
    NPCDefaultMovement(167) = True
    NPCCanWalkOn(164) = True
    NPCIsAHit1Block(164) = True
    NPCWontHurt(160) = True
    NPCWontHurt(166) = True
    NPCCanWalkOn(160) = True
    NPCMovesPlayer(160) = True
    NPCIsABlock(160) = True
    NPCDefaultMovement(160) = True
    NPCWontHurt(159) = True
    NPCCanWalkOn(159) = True
    NPCIsAHit1Block(159) = True
    NPCGrabFromTop(159) = True
    NPCWontHurt(154) = True
    NPCCanWalkOn(154) = True
    NPCIsABlock(154) = True
    NPCMovesPlayer(154) = True
    NPCWontHurt(155) = True
    NPCCanWalkOn(155) = True
    NPCIsABlock(155) = True
    NPCMovesPlayer(155) = True
    NPCWontHurt(156) = True
    NPCCanWalkOn(156) = True
    NPCIsABlock(156) = True
    NPCMovesPlayer(156) = True
    NPCWontHurt(157) = True
    NPCCanWalkOn(157) = True
    NPCIsABlock(157) = True
    NPCMovesPlayer(157) = True
    NPCNoYoshi(159) = True
    

    NPCWontHurt(197) = True
    NPCNoYoshi(197) = True
    
    
    NPCIsGrabbable(154) = True
    NPCIsGrabbable(166) = True
    NPCGrabFromTop(154) = True
    NPCIsGrabbable(155) = True
    NPCGrabFromTop(155) = True
    NPCIsGrabbable(156) = True
    NPCGrabFromTop(156) = True
    NPCIsGrabbable(157) = True
    NPCGrabFromTop(157) = True
    NPCIsABot(128) = True
    NPCIsYoshi(95) = True
    NPCIsYoshi(98) = True
    NPCIsYoshi(99) = True
    NPCIsYoshi(100) = True
    NPCIsYoshi(148) = True
    NPCIsYoshi(149) = True
    NPCIsYoshi(150) = True
    NPCIsYoshi(228) = True
    NPCIsBoot(35) = True
    NPCIsBoot(191) = True
    NPCIsBoot(193) = True
    NPCIsAShell(5) = True
    NPCIsAShell(7) = True
    NPCIsAShell(24) = True
    NPCIsAShell(73) = True
    NPCIsABonus(9) = True
    NPCIsABonus(273) = True
    NPCIsABonus(10) = True
    NPCIsABonus(11) = True
    NPCIsABonus(14) = True
    NPCIsABonus(264) = True
    NPCIsABonus(277) = True
    NPCIsABonus(16) = True
    NPCIsABonus(33) = True
    NPCIsABonus(258) = True
    NPCIsABonus(34) = True
    NPCIsABonus(41) = True
    NPCIsABonus(75) = True
    NPCIsABonus(88) = True
    NPCIsABonus(90) = True
    NPCIsABonus(94) = True
    NPCIsABonus(198) = True
    NPCIsABonus(97) = True
    NPCIsABonus(101) = True
    NPCIsABonus(102) = True
    NPCIsABonus(103) = True
    NPCIsABonus(107) = True
    NPCIsABonus(153) = True
    NPCIsABonus(196) = True
    NPCIsACoin(10) = True
    NPCIsACoin(33) = True
    NPCIsACoin(258) = True
    NPCIsACoin(88) = True
    NPCIsACoin(103) = True
    NPCIsAnExit(11) = True
    NPCIsAnExit(16) = True
    NPCIsAnExit(41) = True
    NPCIsAnExit(97) = True
    NPCIsAnExit(196) = True
    NPCJumpHurt(8) = True
    NPCJumpHurt(245) = True
    NPCJumpHurt(12) = True
    NPCJumpHurt(30) = True
    NPCJumpHurt(36) = True
    NPCJumpHurt(285) = True
    NPCJumpHurt(286) = True
    NPCJumpHurt(37) = True
    NPCJumpHurt(38) = True
    NPCJumpHurt(42) = True
    NPCJumpHurt(43) = True
    NPCJumpHurt(44) = True
    NPCJumpHurt(48) = True
    NPCJumpHurt(51) = True
    NPCJumpHurt(52) = True
    NPCJumpHurt(53) = True
    NPCJumpHurt(54) = True
    NPCJumpHurt(74) = True
    NPCJumpHurt(256) = True
    NPCJumpHurt(257) = True
    NPCJumpHurt(85) = True
    NPCJumpHurt(87) = True
    NPCJumpHurt(93) = True
    NPCCanWalkOn(19) = True
    NPCCanWalkOn(20) = True
    NPCCanWalkOn(247) = True
    NPCCanWalkOn(21) = True
    NPCCanWalkOn(25) = True
    'NPCCanWalkOn(28) = True
    NPCCanWalkOn(31) = True
    NPCCanWalkOn(39) = True
    NPCCanWalkOn(40) = True
    NPCCanWalkOn(45) = True
    NPCCanWalkOn(46) = True
    NPCCanWalkOn(212) = True
    NPCCanWalkOn(56) = True
    NPCCanWalkOn(57) = True
    NPCCanWalkOn(58) = True
    NPCCanWalkOn(60) = True
    NPCCanWalkOn(62) = True
    NPCCanWalkOn(64) = True
    NPCCanWalkOn(66) = True
    NPCCanWalkOn(67) = True
    NPCCanWalkOn(68) = True
    NPCCanWalkOn(69) = True
    NPCCanWalkOn(70) = True
    NPCCanWalkOn(78) = True
    NPCCanWalkOn(79) = True
    NPCCanWalkOn(80) = True
    NPCCanWalkOn(81) = True
    NPCCanWalkOn(82) = True
    NPCCanWalkOn(83) = True
    NPCCanWalkOn(84) = True
    NPCCanWalkOn(91) = True
    NPCCanWalkOn(92) = True
    NPCCanWalkOn(104) = True
    NPCCanWalkOn(105) = True
    NPCCanWalkOn(106) = True
    NPCGrabFromTop(19) = True
    NPCGrabFromTop(20) = True
    NPCGrabFromTop(247) = True
    NPCGrabFromTop(25) = True
    'NPCGrabFromTop(28) = True
    NPCGrabFromTop(31) = True
    NPCGrabFromTop(40) = True
    NPCGrabFromTop(45) = True
    NPCGrabFromTop(91) = True
    NPCGrabFromTop(92) = True
    NPCNoClipping(8) = True
    NPCNoClipping(245) = True
    'NPCNoClipping(10) = True
    NPCNoClipping(12) = True
    NPCNoClipping(17) = True
    NPCNoClipping(18) = True
    NPCNoClipping(30) = True
    NPCNoClipping(34) = True
    NPCNoClipping(38) = True
    NPCNoClipping(42) = True
    NPCNoClipping(43) = True
    NPCNoClipping(44) = True
    NPCNoClipping(46) = True
    NPCNoClipping(212) = True
    NPCNoClipping(47) = True
    NPCNoClipping(284) = True
    NPCNoClipping(50) = True
    NPCNoClipping(51) = True
    NPCNoClipping(52) = True
    'NPCNoClipping(56) = True
    NPCNoClipping(57) = True
    NPCNoClipping(60) = True
    NPCNoClipping(62) = True
    NPCNoClipping(64) = True
    NPCNoClipping(66) = True
    NPCNoClipping(74) = True
    NPCNoClipping(256) = True
    NPCNoClipping(257) = True
    NPCNoClipping(85) = True
    NPCNoClipping(87) = True
    NPCNoClipping(91) = True
    NPCNoClipping(93) = True
    NPCNoClipping(104) = True
    NPCNoClipping(105) = True
    NPCNoClipping(106) = True
    NPCNoClipping(108) = True
    NPCTurnsAtCliffs(6) = True
    NPCTurnsAtCliffs(20) = True
    NPCTurnsAtCliffs(247) = True
    NPCTurnsAtCliffs(55) = True
    NPCTurnsAtCliffs(59) = True
    NPCTurnsAtCliffs(61) = True
    NPCTurnsAtCliffs(63) = True
    NPCTurnsAtCliffs(65) = True
    NPCTurnsAtCliffs(107) = True
    NPCTurnsAtCliffs(158) = True
    NPCMovesPlayer(21) = True
    NPCMovesPlayer(31) = True
    NPCMovesPlayer(32) = True
    NPCMovesPlayer(238) = True
    NPCMovesPlayer(239) = True
    NPCMovesPlayer(45) = True
    NPCMovesPlayer(46) = True
    NPCMovesPlayer(212) = True
    NPCMovesPlayer(57) = True
    NPCMovesPlayer(58) = True
    NPCMovesPlayer(67) = True
    NPCMovesPlayer(68) = True
    NPCMovesPlayer(69) = True
    NPCMovesPlayer(70) = True
    NPCMovesPlayer(78) = True
    NPCMovesPlayer(79) = True
    NPCMovesPlayer(80) = True
    NPCMovesPlayer(81) = True
    NPCMovesPlayer(82) = True
    NPCMovesPlayer(83) = True
    NPCMovesPlayer(84) = True
    NPCWontHurt(21) = True
    NPCWontHurt(22) = True
    NPCWontHurt(26) = True
    NPCWontHurt(31) = True
    NPCWontHurt(32) = True
    NPCWontHurt(238) = True
    NPCWontHurt(239) = True
    NPCWontHurt(35) = True
    NPCWontHurt(191) = True
    NPCWontHurt(193) = True
    NPCWontHurt(45) = True
    NPCWontHurt(46) = True
    NPCWontHurt(212) = True
    NPCWontHurt(49) = True
    NPCWontHurt(50) = True
    NPCWontHurt(56) = True
    NPCWontHurt(57) = True
    NPCWontHurt(58) = True
    NPCWontHurt(60) = True
    NPCWontHurt(62) = True
    NPCWontHurt(64) = True
    NPCWontHurt(66) = True
    NPCWontHurt(67) = True
    NPCWontHurt(68) = True
    NPCWontHurt(69) = True
    NPCWontHurt(70) = True
    NPCWontHurt(78) = True
    NPCWontHurt(79) = True
    NPCWontHurt(80) = True
    NPCWontHurt(81) = True
    NPCWontHurt(82) = True
    NPCWontHurt(83) = True
    NPCWontHurt(84) = True
    NPCWontHurt(91) = True
    NPCWontHurt(92) = True
    NPCWontHurt(95) = True
    NPCWontHurt(96) = True
    NPCWontHurt(98) = True
    NPCWontHurt(99) = True
    NPCWontHurt(100) = True
    NPCWontHurt(104) = True
    NPCWontHurt(105) = True
    NPCWontHurt(106) = True
    NPCWontHurt(107) = True
    NPCWontHurt(108) = True
    NPCWontHurt(148) = True
    NPCWontHurt(149) = True
    NPCWontHurt(150) = True
    NPCWontHurt(228) = True
    NPCWontHurt(158) = True
    NPCIsGrabbable(22) = True
    NPCIsGrabbable(26) = True
    NPCIsGrabbable(31) = True
    NPCIsGrabbable(32) = True
    NPCIsGrabbable(238) = True
    NPCIsGrabbable(35) = True
    NPCIsGrabbable(191) = True
    NPCIsGrabbable(193) = True
    NPCIsGrabbable(45) = True
    NPCIsGrabbable(49) = True
    NPCIsGrabbable(92) = True
    NPCIsGrabbable(96) = True
    NPCIsGrabbable(158) = True
    NPCIsABlock(21) = True
    NPCIsABlock(31) = True
    NPCIsABlock(32) = True
    NPCIsABlock(238) = True
    NPCIsABlock(239) = True
    NPCIsABlock(45) = True
    NPCIsABlock(46) = True
    NPCIsABlock(212) = True
    NPCIsABlock(56) = True
    NPCIsABlock(57) = True
    NPCIsABlock(58) = True
    NPCIsABlock(67) = True
    NPCIsABlock(68) = True
    NPCIsABlock(69) = True
    NPCIsABlock(70) = True
    NPCIsABlock(78) = True
    NPCIsABlock(79) = True
    NPCIsABlock(80) = True
    NPCIsABlock(81) = True
    NPCIsABlock(82) = True
    NPCIsABlock(83) = True
    NPCIsABlock(84) = True
    NPCIsABlock(190) = True
    NPCIsAHit1Block(35) = True
    NPCIsAHit1Block(191) = True
    NPCIsAHit1Block(193) = True
    NPCIsAHit1Block(22) = True
    NPCIsAHit1Block(49) = True
    NPCIsAHit1Block(26) = True
    NPCIsAHit1Block(60) = True
    NPCIsAHit1Block(62) = True
    NPCIsAHit1Block(64) = True
    NPCIsAHit1Block(66) = True
    NPCIsAHit1Block(104) = True
    NPCIsAHit1Block(105) = True
    NPCIsAHit1Block(106) = True
    NPCWontHurt(190) = True
    NPCCanWalkOn(190) = True
    NPCStandsOnPlayer(22) = True
    NPCStandsOnPlayer(26) = True
    NPCStandsOnPlayer(31) = True
    NPCStandsOnPlayer(32) = True
    NPCStandsOnPlayer(238) = True
    NPCStandsOnPlayer(239) = True
    NPCStandsOnPlayer(35) = True
    NPCStandsOnPlayer(191) = True
    NPCStandsOnPlayer(193) = True
    NPCStandsOnPlayer(49) = True
    NPCStandsOnPlayer(95) = True
    NPCStandsOnPlayer(96) = True
    NPCStandsOnPlayer(98) = True
    NPCStandsOnPlayer(99) = True
    NPCStandsOnPlayer(100) = True
    NPCStandsOnPlayer(148) = True
    NPCStandsOnPlayer(149) = True
    NPCStandsOnPlayer(150) = True
    NPCStandsOnPlayer(228) = True
    
    
    NPCCanWalkOn(272) = True
    NPCGrabFromTop(272) = True
    NPCNoFireBall(272) = True
    NPCNoClipping(272) = True
    NPCWidth(272) = 32
    NPCHeight(272) = 32
    
    NPCCanWalkOn(208) = True
    NPCWontHurt(208) = True
    NPCMovesPlayer(208) = True
    NPCWidth(208) = 128
    NPCHeight(208) = 128
    NPCIsABlock(208) = True
    
    NPCForeground(208) = True
    NPCJumpHurt(207) = True
    NPCJumpHurt(206) = True
    NPCJumpHurt(205) = True
    
    NPCWidth(204) = 48
    NPCHeight(204) = 28
    NPCWidthGFX(204) = 112
    NPCHeightGFX(204) = 28
    
    NPCWidthGFX(205) = 44
    NPCHeightGFX(205) = 44
    NPCFrameOffsetY(205) = 6
    
    
    NPCWidth(270) = 32
    NPCHeight(270) = 42
    NPCJumpHurt(270) = True
    NPCNoClipping(270) = True
    
    NPCWidth(271) = 32
    NPCHeight(271) = 32
    NPCNoClipping(271) = True
    
    
    NPCWidth(210) = 28
    NPCNoClipping(210) = True
    NPCIsABlock(211) = True
    NPCNoClipping(211) = True
    NPCMovesPlayer(211) = True
    NPCCanWalkOn(211) = True
    NPCWontHurt(211) = True
    
    
    
    
    
    NPCForeground(12) = True
    NPCForeground(17) = True
    NPCForeground(18) = True
    NPCForeground(28) = True
    NPCForeground(30) = True
    NPCForeground(34) = True
    NPCForeground(38) = True
    NPCForeground(42) = True
    NPCForeground(43) = True
    NPCForeground(44) = True
    NPCForeground(47) = True
    NPCForeground(85) = True
    NPCForeground(86) = True
    NPCForeground(87) = True
    NPCForeground(108) = True
    NPCForeground(171) = True
    NPCDefaultMovement(1) = True
    NPCDefaultMovement(2) = True
    NPCDefaultMovement(3) = True
    NPCDefaultMovement(4) = True
    NPCDefaultMovement(6) = True
    NPCDefaultMovement(19) = True
    NPCDefaultMovement(20) = True
    NPCDefaultMovement(247) = True
    NPCDefaultMovement(23) = True
    NPCDefaultMovement(27) = True
    NPCDefaultMovement(36) = True
    NPCDefaultMovement(285) = True
    NPCDefaultMovement(50) = True
    NPCDefaultMovement(53) = True
    NPCDefaultMovement(55) = True
    NPCDefaultMovement(59) = True
    NPCDefaultMovement(61) = True
    NPCDefaultMovement(63) = True
    NPCDefaultMovement(65) = True
    NPCDefaultMovement(71) = True
    NPCDefaultMovement(72) = True
    NPCDefaultMovement(77) = True
    NPCDefaultMovement(78) = True
    NPCDefaultMovement(89) = True
    NPCDefaultMovement(91) = True
    NPCDefaultMovement(107) = True
    
    NPCNoFireBall(19) = True
    NPCNoFireBall(20) = True
    NPCNoFireBall(23) = True
    NPCNoFireBall(24) = True
    NPCNoFireBall(137) = True
    NPCNoFireBall(136) = True
    NPCNoFireBall(129) = True
    NPCNoFireBall(130) = True
    NPCNoFireBall(131) = True
    NPCNoFireBall(132) = True
    NPCNoFireBall(12) = True
    NPCNoFireBall(25) = True


    'link sword beam
    NPCWidth(266) = 16
    NPCHeight(266) = 8
    NPCWontHurt(266) = True
    NPCJumpHurt(266) = True
    NPCNoGravity(266) = True

    NPCNoYoshi(267) = True
    NPCNoYoshi(268) = True
    NPCNoYoshi(269) = True
    NPCNoYoshi(280) = True
    NPCNoYoshi(281) = True
    NPCNoYoshi(282) = True
    

    NPCNoClipping(276) = True
    NPCWidth(276) = 16
    NPCHeight(276) = 16
    NPCNoYoshi(276) = True
    NPCJumpHurt(276) = True
    
    NPCWidth(275) = 60
    NPCHeight(275) = 24
    NPCWidthGFX(275) = 64
    NPCHeightGFX(275) = 32
    NPCNoFireBall(275) = True
    NPCJumpHurt(275) = True
    
    NPCWidth(278) = 32
    NPCHeight(278) = 44
    NPCWontHurt(278) = True
    NPCJumpHurt(278) = True
    NPCIsGrabbable(278) = True
    
    NPCWidth(279) = 32
    NPCHeight(279) = 44
    NPCWidthGFX(279) = 96
    NPCHeightGFX(279) = 44
    NPCWontHurt(279) = True
    NPCJumpHurt(279) = True
    NPCIsGrabbable(279) = True
    

'set ice
    NPCNoIceBall(197) = True
    NPCNoIceBall(192) = True

    NPCNoIceBall(267) = True
    NPCNoIceBall(268) = True
    NPCNoIceBall(269) = True
    NPCNoIceBall(275) = True
    NPCNoIceBall(280) = True
    NPCNoIceBall(281) = True
    NPCNoIceBall(282) = True
    NPCNoIceBall(15) = True
    NPCNoIceBall(18) = True
    NPCNoIceBall(26) = True
    NPCNoIceBall(30) = True
    NPCNoIceBall(31) = True
    NPCNoIceBall(32) = True
    NPCNoIceBall(35) = True
    NPCNoIceBall(37) = True
    NPCNoIceBall(38) = True
    NPCNoIceBall(39) = True
    NPCNoIceBall(40) = True
    NPCNoIceBall(42) = True
    NPCNoIceBall(43) = True
    NPCNoIceBall(44) = True
    NPCNoIceBall(45) = True
    NPCNoIceBall(46) = True
    NPCNoIceBall(56) = True
    For A = 57 To 70
        NPCNoIceBall(A) = True
    Next A
    NPCNoIceBall(75) = True
    For A = 78 To 88
        NPCNoIceBall(A) = True
    Next A
    NPCNoIceBall(91) = True
    NPCNoIceBall(92) = True
    NPCNoIceBall(94) = True
    For A = 95 To 108
        NPCNoIceBall(A) = True
    Next A
    NPCNoIceBall(133) = True
    NPCNoIceBall(134) = True
    For A = 138 To 160
        NPCNoIceBall(A) = True
    Next A
    NPCNoIceBall(171) = True
    NPCNoIceBall(178) = True
    NPCNoIceBall(179) = True
    NPCNoIceBall(180) = True
    NPCNoIceBall(181) = True
    NPCNoIceBall(190) = True
    NPCNoIceBall(191) = True
    NPCNoIceBall(192) = True
    NPCNoIceBall(193) = True
    NPCNoIceBall(195) = True
    NPCNoIceBall(199) = True
    NPCNoIceBall(200) = True
    NPCNoIceBall(201) = True
    NPCNoIceBall(208) = True
    NPCNoIceBall(209) = True
    NPCNoIceBall(210) = True
    For A = 211 To 228
        NPCNoIceBall(A) = True
    Next A
    NPCNoIceBall(237) = True
    NPCNoIceBall(238) = True
    NPCNoIceBall(239) = True
    NPCNoIceBall(241) = True
    NPCNoIceBall(246) = True
    NPCNoIceBall(254) = True
    NPCNoIceBall(255) = True
    NPCNoIceBall(256) = True
    NPCNoIceBall(257) = True
    NPCNoIceBall(259) = True
    NPCNoIceBall(260) = True
    NPCNoIceBall(262) = True
    NPCNoIceBall(251) = True
    NPCNoIceBall(252) = True
    NPCNoIceBall(253) = True
    NPCNoIceBall(258) = True
    NPCNoIceBall(33) = True
    NPCNoIceBall(274) = True
    NPCNoIceBall(278) = True
    NPCNoIceBall(279) = True
    For A = 282 To 292
        If A <> 285 And A <> 286 Then NPCNoIceBall(A) = True
    Next A


    NPCHeight(247) = 30
    NPCHeightGFX(247) = 32
    NPCWidthGFX(247) = 32

    
    NPCDefaultMovement(158) = True
    
    
    NPCWidthGFX(267) = 84
    NPCHeightGFX(267) = 62
    NPCWidth(267) = 44
    NPCHeight(267) = 50
    
    NPCWidthGFX(268) = 44
    NPCHeightGFX(268) = 32
    NPCWidth(268) = 32
    NPCHeight(268) = 28
    
    NPCWidthGFX(269) = 16
    NPCHeightGFX(269) = 32
    NPCWidth(269) = 16
    NPCHeight(269) = 32
    NPCNoClipping(269) = True
    NPCJumpHurt(269) = True
    
    NPCWidthGFX(280) = 64
    NPCHeightGFX(280) = 64
    NPCWidth(280) = 48
    NPCHeight(280) = 48
    
    NPCWidthGFX(281) = 40
    NPCHeightGFX(281) = 36
    NPCWidth(281) = 36
    NPCHeight(281) = 32
    
    NPCWidthGFX(282) = 64
    NPCHeightGFX(282) = 32
    NPCWidth(282) = 64
    NPCHeight(282) = 26
    NPCFrameOffsetY(282) = 4
    NPCNoClipping(282) = True
    NPCJumpHurt(282) = True
    
    
    For A = 1 To maxBlockType
        BlockWidth(A) = 32
        BlockHeight(A) = 32
    Next A
    
    BlockWidth(571) = 64
    BlockWidth(572) = 64
    BlockWidth(615) = 64
    
    BlockWidth(634) = 64
    BlockHeight(634) = 64
    
    BlockHeight(595) = 64
    BlockHeight(596) = 64
    BlockHeight(597) = 64
    
    BlockHeight(569) = 64
    BlockHeight(570) = 64
    BlockHeight(571) = 64
    BlockHeight(572) = 64
    BlockHeight(575) = 64

    BlockOnlyHitspot1(572) = True
    BlockWidth(21) = 64
    BlockWidth(22) = 64
    BlockHeight(23) = 64
    BlockHeight(24) = 64
    BlockWidth(34) = 64
    BlockWidth(35) = 64
    BlockWidth(36) = 64
    BlockWidth(37) = 64
    BlockWidth(61) = 128
    BlockHeight(61) = 128
    BlockWidth(78) = 64
    BlockWidth(91) = 64
    BlockHeight(91) = 64
    BlockWidth(92) = 128
    BlockHeight(92) = 128
    BlockWidth(93) = 128
    BlockHeight(93) = 128
    BlockWidth(103) = 64
    BlockWidth(104) = 64
    BlockWidth(113) = 64
    BlockWidth(114) = 64
    BlockWidth(125) = 64
    BlockHeight(125) = 64
    BlockWidth(182) = 96
    BlockHeight(182) = 96
    BlockWidth(184) = 64
    BlockHeight(184) = 64
    BlockWidth(185) = 128
    BlockHeight(187) = 128
    BlockWidth(187) = 128
    BlockWidth(194) = 64
    BlockWidth(195) = 64
    BlockWidth(196) = 64
    BlockWidth(197) = 64
    BlockWidth(206) = 64
    BlockHeight(206) = 64
    BlockHeight(211) = 64
    BlockHeight(212) = 64
    BlockWidth(224) = 64
    BlockHeight(224) = 64
    BlockWidth(225) = 64
    BlockHeight(225) = 64
    BlockWidth(226) = 64
    BlockHeight(226) = 64
    BlockWidth(262) = 128
    BlockHeight(262) = 128
    
    BlockWidth(616) = 64
    BlockWidth(617) = 64
    BlockSlope(616) = -1
    BlockSlope(617) = 1
    
    BlockSlope(635) = -1
    BlockSlope(636) = -1
    BlockWidth(636) = 64
    BlockSlope(637) = 1
    BlockSlope(638) = 1
    BlockWidth(638) = 64
    
    
    For A = 137 To 146
        BlockWidth(A) = 64
    Next A
    For A = 147 To 158
        BlockHeight(A) = 64
    Next A
    BlockWidth(301) = 128
    BlockWidth(302) = 128
    BlockWidth(303) = 128
    BlockWidth(304) = 128
    BlockWidth(306) = 64
    BlockWidth(308) = 64
    BlockWidth(312) = 64
    BlockWidth(314) = 64
    BlockWidth(319) = 128
    BlockWidth(320) = 128
    BlockWidth(321) = 128
    BlockWidth(322) = 128
    BlockWidth(325) = 64
    BlockWidth(324) = 64
    BlockWidth(325) = 64
    BlockWidth(324) = 64
    BlockWidth(336) = 64
    BlockWidth(338) = 64
    BlockWidth(340) = 64
    BlockWidth(342) = 64
    BlockWidth(357) = 64
    BlockWidth(360) = 64
    BlockWidth(361) = 64
    BlockWidth(364) = 64
    BlockWidth(365) = 64
    BlockWidth(366) = 64
    BlockWidth(367) = 64
    BlockWidth(368) = 64
    BlockHeight(376) = 64
    BlockHeight(377) = 64
    BlockWidth(378) = 64
    BlockHeight(378) = 64
    BlockWidth(472) = 64
    BlockHeight(472) = 32
    BlockWidth(474) = 64
    BlockHeight(474) = 32
    BlockWidth(476) = 64
    BlockHeight(476) = 32
    BlockWidth(479) = 64
    BlockHeight(479) = 32
    BlockWidth(505) = 64
    BlockHeight(505) = 32
    BlockWidth(506) = 64
    BlockHeight(506) = 64
    
    BlockWidth(613) = 64
    
    BlockWidth(507) = 64
    BlockHeight(507) = 32
    
    BlockWidth(599) = 64
    BlockHeight(599) = 64
    
    
    BlockWidth(508) = 64
    BlockHeight(508) = 32
    
    BlockWidth(529) = 32
    BlockHeight(529) = 64
    
    BlockWidth(527) = 64
    BlockHeight(527) = 96
    
    
    
    
    BlockWidth(534) = 48
    BlockHeight(534) = 128
    BlockWidth(535) = 48
    BlockHeight(535) = 128
    BlockWidth(536) = 128
    BlockHeight(536) = 48
    BlockWidth(537) = 128
    BlockHeight(537) = 48
    BlockWidth(540) = 64
    
    
    
    
    BlockSlope(472) = -1
    BlockSlope(474) = 1
    BlockSlope2(476) = 1
    BlockSlope2(479) = -1
    
    
    BlockSlope2(77) = 1
    BlockSlope2(78) = 1
    BlockSlope2(613) = -1
    BlockSlope2(614) = -1
    
    
    BlockSlope(480) = -1
    BlockSlope(482) = 1
    BlockSlope2(486) = 1
    BlockSlope2(485) = -1
    
    
    BlockOnlyHitspot1(372) = True
    BlockOnlyHitspot1(373) = True
    BlockOnlyHitspot1(374) = True
    BlockOnlyHitspot1(375) = True
    BlockOnlyHitspot1(379) = True
    BlockOnlyHitspot1(380) = True
    BlockOnlyHitspot1(381) = True
    BlockOnlyHitspot1(382) = True
    BlockOnlyHitspot1(389) = True
    BlockOnlyHitspot1(391) = True
    BlockOnlyHitspot1(392) = True
    
    BlockOnlyHitspot1(506) = True
    BlockOnlyHitspot1(507) = True
    BlockOnlyHitspot1(508) = True
    
    BlockKills(371) = True
    BlockKills(404) = True
    BlockKills(406) = True
    BlockKills(405) = True
    BlockKills(420) = True
    BlockHasNoMask(336) = True
    BlockHasNoMask(337) = True
    BlockHasNoMask(338) = True
    BlockHasNoMask(339) = True
    BlockHasNoMask(303) = True
    BlockHasNoMask(304) = True
    BlockHasNoMask(348) = True
    BlockHasNoMask(353) = True
    BlockHasNoMask(354) = True
    BlockHasNoMask(355) = True
    BlockHasNoMask(356) = True
    BlockHasNoMask(3) = True
    BlockHasNoMask(4) = True
    BlockHasNoMask(13) = True
    BlockHasNoMask(15) = True
    BlockHasNoMask(16) = True
    BlockHasNoMask(17) = True
    BlockHasNoMask(19) = True
    BlockHasNoMask(21) = True
    BlockHasNoMask(34) = True
    BlockHasNoMask(36) = True
    BlockHasNoMask(23) = True
    BlockHasNoMask(29) = True
    BlockHasNoMask(40) = True
    BlockHasNoMask(43) = True
    BlockHasNoMask(46) = True
    BlockHasNoMask(47) = True
    BlockHasNoMask(48) = True
    BlockHasNoMask(49) = True
    BlockHasNoMask(50) = True
    BlockHasNoMask(51) = True
    BlockHasNoMask(52) = True
    BlockHasNoMask(53) = True
    BlockHasNoMask(54) = True
    BlockHasNoMask(59) = True
    BlockHasNoMask(60) = True
    BlockHasNoMask(61) = True
    BlockHasNoMask(63) = True
    BlockHasNoMask(65) = True
    BlockHasNoMask(67) = True
    BlockHasNoMask(70) = True
    BlockHasNoMask(71) = True
    BlockHasNoMask(72) = True
    BlockHasNoMask(73) = True
    BlockHasNoMask(74) = True
    BlockHasNoMask(75) = True
    BlockHasNoMask(76) = True
    BlockHasNoMask(81) = True
    BlockHasNoMask(83) = True
    BlockHasNoMask(84) = True
    BlockHasNoMask(85) = True
    BlockHasNoMask(86) = True
    BlockHasNoMask(87) = True
    BlockHasNoMask(91) = True
    BlockHasNoMask(93) = True
    BlockHasNoMask(94) = True
    BlockHasNoMask(95) = True
    BlockHasNoMask(96) = True
    BlockHasNoMask(97) = True
    BlockHasNoMask(98) = True
    BlockHasNoMask(99) = True
    BlockHasNoMask(100) = True
    BlockHasNoMask(101) = True
    BlockHasNoMask(102) = True
    BlockHasNoMask(103) = True
    BlockHasNoMask(111) = True
    BlockHasNoMask(118) = True
    BlockHasNoMask(119) = True
    BlockHasNoMask(120) = True
    BlockHasNoMask(121) = True
    BlockHasNoMask(122) = True
    BlockHasNoMask(123) = True
    BlockHasNoMask(124) = True
    BlockHasNoMask(125) = True
    BlockHasNoMask(126) = True
    BlockHasNoMask(127) = True
    BlockHasNoMask(131) = True
    BlockHasNoMask(134) = True
    BlockHasNoMask(136) = True
    BlockHasNoMask(159) = True
    BlockHasNoMask(160) = True
    BlockHasNoMask(166) = True
    BlockHasNoMask(183) = True
    BlockHasNoMask(184) = True
    BlockHasNoMask(186) = True
    BlockHasNoMask(187) = True
    BlockHasNoMask(188) = True
    BlockHasNoMask(190) = True
    BlockHasNoMask(198) = True
    BlockHasNoMask(199) = True
    BlockHasNoMask(200) = True
    BlockHasNoMask(201) = True
    BlockHasNoMask(202) = True
    BlockHasNoMask(203) = True
    BlockHasNoMask(204) = True
    BlockHasNoMask(205) = True
    BlockHasNoMask(206) = True
    BlockHasNoMask(216) = True
    BlockHasNoMask(217) = True
    BlockHasNoMask(218) = True
    BlockHasNoMask(223) = True
    BlockHasNoMask(226) = True
    BlockHasNoMask(227) = True
    BlockHasNoMask(228) = True
    BlockHasNoMask(229) = True
    BlockHasNoMask(230) = True
    BlockHasNoMask(231) = True
    BlockHasNoMask(232) = True
    BlockHasNoMask(233) = True
    BlockHasNoMask(234) = True
    BlockHasNoMask(235) = True
    BlockHasNoMask(236) = True
    BlockHasNoMask(237) = True
    BlockHasNoMask(238) = True
    BlockHasNoMask(239) = True
    BlockHasNoMask(250) = True
    BlockHasNoMask(251) = True
    BlockHasNoMask(252) = True
    BlockHasNoMask(253) = True
    BlockHasNoMask(254) = True
    BlockHasNoMask(255) = True
    BlockHasNoMask(256) = True
    BlockHasNoMask(257) = True
    BlockHasNoMask(258) = True
    BlockHasNoMask(261) = True
    BlockHasNoMask(262) = True
    BlockHasNoMask(264) = True
    BlockHasNoMask(263) = True
    BlockHasNoMask(273) = True
    BlockHasNoMask(272) = True
    BlockHasNoMask(276) = True
    BlockHasNoMask(281) = True
    BlockHasNoMask(282) = True
    BlockHasNoMask(283) = True
    BlockHasNoMask(291) = True
    BlockHasNoMask(292) = True
    BlockHasNoMask(320) = True
    BlockHasNoMask(322) = True
    BlockHasNoMask(323) = True
    BlockHasNoMask(330) = True
    BlockHasNoMask(331) = True
    BlockHasNoMask(369) = True
    BlockHasNoMask(370) = True
    BlockOnlyHitspot1(8) = True
    BlockOnlyHitspot1(121) = True
    BlockOnlyHitspot1(122) = True
    BlockOnlyHitspot1(123) = True
    BlockOnlyHitspot1(168) = True
    BlockOnlyHitspot1(289) = True
    BlockOnlyHitspot1(290) = True
    BlockOnlyHitspot1(370) = True

    BlockKills(30) = True
    BlockHurts(109) = True
    BlockHurts(598) = True
    BlockHurts(110) = True
    BlockHurts(267) = True
    BlockHurts(268) = True
    BlockHurts(269) = True
    BlockHurts(511) = True
    BlockPSwitch(4) = True
    BlockPSwitch(60) = True
    BlockPSwitch(89) = True
    BlockPSwitch(188) = True
    BlockPSwitch(280) = True
    BlockPSwitch(293) = True
    BlockNoClipping(172) = True
    BlockNoClipping(175) = True
    BlockNoClipping(178) = True
    BlockNoClipping(181) = True
    BlockSlope(299) = -1
    BlockSlope(300) = 1
    BlockSlope(301) = 1
    BlockSlope(302) = -1
    BlockSlope(305) = -1
    BlockSlope(306) = -1
    BlockSlope(307) = 1
    BlockSlope(308) = 1
    BlockSlope(324) = -1
    BlockSlope(325) = 1
    
    BlockSlope2(528) = 1
    BlockSlope2(523) = -1
    
    BlockSlope2(309) = 1
    BlockSlope2(310) = -1
    BlockSlope2(311) = 1
    BlockSlope2(312) = 1
    BlockSlope2(313) = -1
    BlockSlope2(314) = -1
    BlockSlope(315) = 1
    BlockSlope(316) = -1
    BlockSlope2(317) = 1
    BlockSlope2(318) = -1
    BlockSlope(319) = 1
    BlockSlope(321) = -1
    BlockSlope(326) = -1
    BlockSlope(327) = 1
    BlockSlope2(328) = -1
    BlockSlope2(329) = 1
    BlockSlope(332) = -1
    BlockSlope(333) = 1
    BlockSlope2(334) = -1
    BlockSlope2(335) = 1
    BlockSlope(340) = -1
    BlockSlope(341) = -1
    BlockSlope(342) = 1
    BlockSlope(343) = 1
    BlockSlope(357) = -1
    BlockSlope(358) = -1
    BlockSlope(359) = 1
    BlockSlope(360) = 1
    BlockSlope2(361) = 1
    BlockSlope2(362) = 1
    BlockSlope2(363) = -1
    BlockSlope2(364) = -1
    BlockSlope(365) = -1
    BlockSlope(366) = 1
    BlockSlope2(367) = -1
    BlockSlope2(368) = 1
    
    BlockKills(459) = True
    
    BlockKills(460) = True
    BlockKills(461) = True
    BlockKills(462) = True
    BlockKills(463) = True
    BlockKills(464) = True
    BlockKills(465) = True
    BlockKills(466) = True
    BlockKills(467) = True
    BlockKills(468) = True
    BlockKills(469) = True
    BlockKills(470) = True
    BlockKills(471) = True
    
    BlockKills2(460) = True
    BlockKills2(461) = True
    BlockKills2(462) = True
    BlockKills2(463) = True
    BlockKills2(464) = True
    BlockKills2(465) = True
    BlockKills2(466) = True
    BlockKills2(467) = True
    BlockKills(472) = True
    BlockKills(473) = True
    BlockKills(474) = True
    BlockKills(475) = True
    BlockKills(476) = True
    BlockKills(478) = True
    BlockKills(479) = True
    BlockKills2(472) = True
    BlockKills2(474) = True
    BlockKills2(476) = True
    BlockKills2(479) = True
    
    BlockKills(480) = True
    BlockKills(481) = True
    BlockKills(482) = True
    BlockKills(483) = True
    BlockKills(484) = True
    BlockKills(485) = True
    BlockKills(486) = True
    BlockKills(487) = True
    BlockKills2(480) = True
    BlockKills2(482) = True
    BlockKills2(485) = True
    BlockKills2(486) = True
    
    
    
    BlockHurts(407) = True
    BlockHurts(408) = True
    BlockHurts(428) = True
    BlockHurts(429) = True
    BlockHurts(430) = True
    BlockHurts(431) = True
    BlockHurts(511) = True
    BlockOnlyHitspot1(447) = True
    BlockOnlyHitspot1(446) = True
    BlockOnlyHitspot1(448) = True
    

    
    
    BlockWidth(604) = 64
    BlockWidth(605) = 64
    
    BlockSlope(600) = -1
    BlockSlope(604) = -1
    BlockSlope(601) = 1
    BlockSlope(605) = 1
    

    BlockSlope(451) = 1
    BlockSlope(452) = -1
    For A = 459 To 487
        BlockKills(A) = True
    Next A
    BackgroundHasNoMask(187) = True
    BackgroundHasNoMask(188) = True
    BackgroundHasNoMask(189) = True
    BackgroundHasNoMask(190) = True
    
    BackgroundHasNoMask(172) = True
    BackgroundHasNoMask(167) = True
    BackgroundHasNoMask(164) = True
    BackgroundHasNoMask(165) = True
    BackgroundHasNoMask(158) = True
    BackgroundHasNoMask(146) = True
    BackgroundHasNoMask(12) = True
    BackgroundHasNoMask(14) = True
    BackgroundHasNoMask(15) = True
    BackgroundHasNoMask(22) = True
    BackgroundHasNoMask(30) = True
    BackgroundHasNoMask(39) = True
    BackgroundHasNoMask(40) = True
    BackgroundHasNoMask(41) = True
    BackgroundHasNoMask(42) = True
    BackgroundHasNoMask(43) = True
    BackgroundHasNoMask(44) = True
    BackgroundHasNoMask(47) = True
    BackgroundHasNoMask(52) = True
    BackgroundHasNoMask(53) = True
    BackgroundHasNoMask(55) = True
    BackgroundHasNoMask(56) = True
    BackgroundHasNoMask(60) = True
    BackgroundHasNoMask(61) = True
    BackgroundHasNoMask(64) = True
    BackgroundHasNoMask(75) = True
    BackgroundHasNoMask(76) = True
    BackgroundHasNoMask(77) = True
    BackgroundHasNoMask(78) = True
    BackgroundHasNoMask(79) = True
    BackgroundHasNoMask(83) = True
    BackgroundHasNoMask(87) = True
    BackgroundHasNoMask(88) = True
    BackgroundHasNoMask(91) = True
    BackgroundHasNoMask(98) = True
    BackgroundHasNoMask(99) = True
    BackgroundHasNoMask(107) = True
    BackgroundHasNoMask(115) = True
    BackgroundHasNoMask(116) = True
    BackgroundHasNoMask(117) = True
    BackgroundHasNoMask(118) = True
    BackgroundHasNoMask(119) = True
    BackgroundHasNoMask(122) = True
    BackgroundHasNoMask(123) = True
    BackgroundHasNoMask(124) = True

    BackgroundHasNoMask(139) = True
    BackgroundHasNoMask(140) = True
    BackgroundHasNoMask(141) = True
    BackgroundHasNoMask(144) = True
    BackgroundHasNoMask(145) = True
    BlockOnlyHitspot1(69) = True
    
    
    Foreground(187) = True
    Foreground(188) = True
    Foreground(143) = True
    'Foreground(165) = True
    Foreground(145) = True
    Foreground(23) = True
    Foreground(24) = True
    Foreground(25) = True
    Foreground(45) = True
    Foreground(46) = True
    Foreground(49) = True
    Foreground(50) = True
    Foreground(51) = True
    'Foreground(65) = True
    Foreground(68) = True
    Foreground(69) = True
    Foreground(106) = True
    Foreground(137) = True
    Foreground(138) = True
    
    Foreground(154) = True
    Foreground(155) = True
    Foreground(156) = True
    Foreground(157) = True
    
    BackgroundHeight(158) = 32
    BackgroundHeight(159) = 32
    
    BackgroundHeight(187) = 32
    BackgroundHeight(188) = 32
    BackgroundHeight(189) = 32
    BackgroundHeight(190) = 32
    
    
    
    BackgroundHeight(170) = 32
    BackgroundHeight(171) = 32
    
    BackgroundHeight(26) = 64
    BackgroundHeight(18) = 32
    BackgroundHeight(19) = 32
    BackgroundHeight(20) = 32
    BackgroundHeight(36) = 96
    BackgroundHeight(65) = 96
    
    BackgroundHeight(66) = 32
    
    BackgroundHeight(68) = 64
    BackgroundHeight(70) = 32
    BackgroundHeight(172) = 32
    BackgroundHeight(82) = 32
    BackgroundHeight(100) = 32
    BackgroundHeight(125) = 64
    BackgroundHeight(134) = 32
    BackgroundHeight(135) = 32
    BackgroundHeight(136) = 32
    BackgroundHeight(137) = 32
    BackgroundHeight(138) = 32
    BackgroundWidth(163) = 64
    
    BackgroundWidth(173) = 112
    BackgroundHeight(173) = 120
    
    
    BackgroundWidth(160) = 24
    BackgroundHeight(160) = 24
    
    BackgroundWidth(161) = 64
    BackgroundHeight(161) = 48
    
    BackgroundHeight(168) = 32
    BackgroundWidth(168) = 64
    
    BackgroundHeight(169) = 64
    BackgroundWidth(169) = 64
    BackgroundHasNoMask(169) = True
    
    
    
    For A = 1 To maxSceneType
        SceneWidth(A) = 32
        SceneHeight(A) = 32
        If (A >= 15 And A <= 18) Or A = 21 Or A = 24 Or A = 58 Or A = 59 Or A = 63 Then
            SceneWidth(A) = 16
            SceneHeight(A) = 16
        End If
    Next A
    SceneWidth(20) = 64
    SceneHeight(20) = 64
    SceneWidth(27) = 48
    SceneHeight(27) = 16
    SceneWidth(28) = 48
    SceneHeight(28) = 16
    SceneWidth(29) = 64
    SceneHeight(29) = 16
    SceneWidth(30) = 64
    SceneHeight(30) = 16
    SceneWidth(33) = 14
    SceneHeight(33) = 14
    SceneWidth(34) = 14
    SceneHeight(34) = 14
    SceneWidth(44) = 64
    SceneHeight(50) = 48
    SceneWidth(50) = 64
    SceneWidth(54) = 30
    SceneHeight(54) = 24
    SceneWidth(55) = 30
    SceneHeight(55) = 24
    SceneWidth(57) = 64
    SceneHeight(57) = 64
    SceneWidth(60) = 48
    SceneHeight(60) = 48
    SceneWidth(61) = 64
    SceneHeight(61) = 76
    
    For A = 1 To maxTileType
        TileWidth(A) = 32
        TileHeight(A) = 32
    Next A
    TileWidth(8) = 64
    TileHeight(8) = 64
    TileWidth(9) = 96
    TileHeight(9) = 96
    TileWidth(12) = 64
    TileHeight(12) = 64
    TileWidth(13) = 96
    TileHeight(13) = 96
    TileWidth(27) = 128
    TileHeight(27) = 128
    TileWidth(325) = 64
    TileHeight(325) = 64
    Points(1) = 10
    Points(2) = 100
    Points(3) = 200
    Points(4) = 400
    Points(5) = 800
    Points(6) = 1000
    Points(7) = 2000
    Points(8) = 4000
    Points(9) = 8000
    Points(10) = 1
    Points(11) = 2
    Points(12) = 3
    Points(13) = 5
    For A = 1 To maxNPCType
        If NPCIsCheep(A) = True Then NPCForeground(A) = True
    Next A
    For A = 1 To maxEffectType
        EffectDefaults.EffectHeight(A) = EffectHeight(A)
        EffectDefaults.EffectWidth(A) = EffectWidth(A)
    Next A
    SaveNPCDefaults
End Sub

Public Sub GameLoop()   'The loop for the game
    Dim A As Integer
    Dim tempLocation As Location
    UpdateControls
    If LevelMacro > 0 Then UpdateMacro
    If BattleMode = True Then
        If BattleOutro > 0 Then
            BattleOutro = BattleOutro + 1
            If BattleOutro = 260 Then EndLevel = True
        End If
    End If
    
    
    If EndLevel = True Then
        If LevelBeatCode > 0 Then
            If Checkpoint = FullFileName Then
                Checkpoint = ""
            End If
        End If
        NextLevel
        UpdateControls
    ElseIf qScreen = True Then
        UpdateEffects
        UpdateGraphics
    ElseIf BattleIntro > 0 Then
        UpdateGraphics
        BlockFrames
        UpdateSound
        For A = 1 To numNPCs
            NPCFrames A
        Next A
        BattleIntro = BattleIntro - 1
        If BattleIntro = 1 Then PlaySound 58
    Else
        UpdateLayers 'layers before/after npcs
        UpdateNPCs
        If LevelMacro = 3 Then Exit Sub 'stop on key exit
        UpdateBlocks
        UpdateEffects
        UpdatePlayer
        If LivingPlayers = True Or BattleMode = True Then UpdateGraphics
        UpdateSound
        UpdateEvents
        If MagicHand = True Then UpdateEditor
        If Player(1).Controls.Start = True Or (GetKeyState(vbKeyEscape) And KEY_PRESSED) Then
            If LevelMacro = 0 And CheckLiving > 0 Then
                If Player(1).UnStart = True Then
                    If (CaptainN = True Or FreezeNPCs = True) And PSwitchStop = 0 Then
                        If (GetKeyState(vbKeyEscape) And KEY_PRESSED) Then
                            FreezeNPCs = False
                            PauseGame 1
                        Else
                            Player(1).UnStart = False
                            If FreezeNPCs = True Then
                                FreezeNPCs = False
                                If PSwitchTime > 0 Then
                                    If noSound = False Then mciSendString "resume smusic", 0, 0, 0
                                End If
                            Else
                                FreezeNPCs = True
                                If PSwitchTime > 0 Then
                                    If noSound = False Then mciSendString "pause smusic", 0, 0, 0
                                End If
                            End If
                            PlaySound 30
                        End If
                    Else
                        PauseGame 1
                    End If
                End If
            End If
        ElseIf numPlayers = 2 And Player(2).Controls.Start = True Then
            If LevelMacro = 0 And CheckLiving > 0 Then
                If Player(2).UnStart = True Then
                    If CaptainN = True Or FreezeNPCs = True Then
                        Player(2).UnStart = False
                        If FreezeNPCs = True Then
                            FreezeNPCs = False
                        Else
                            FreezeNPCs = True
                        End If
                        PlaySound 30
                    End If
                End If
            End If
        End If
    End If
End Sub

Public Sub MenuLoop()   'The loop for the menu
    On Error Resume Next
    Dim A As Integer
    Dim B As Integer
    Dim tempLocation As Location
    Dim newJoystick As Boolean
    Dim tempBool As Boolean
    Dim menuLen As Integer
    Dim blankPlayer As Player
    UpdateControls
    SingleCoop = 0

    With Player(1).Controls
    If frmMain.MousePointer <> 99 Then
        frmMain.MousePointer = 99
    End If
    If .Up = False And .Down = False And .Jump = False And .Run = False And .Start = False Then
        If (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Or (GetKeyState(vbKeyUp) And KEY_PRESSED) Or (GetKeyState(vbKeyDown) And KEY_PRESSED) Or (GetKeyState(vbKeyEscape) And KEY_PRESSED) Then
        Else
            MenuCursorCanMove = True
        End If
    End If
    'For the menu controls
        If getNewKeyboard = False And getNewJoystick = False Then
            If .Up = True Or (GetKeyState(vbKeyUp) And KEY_PRESSED) Then
                If MenuCursorCanMove = True Then
                    MenuCursor = MenuCursor - 1
                    If MenuMode >= 100 Then
                        Do While (MenuCursor = PlayerCharacter - 1 And (MenuMode = 300 Or MenuMode = 500)) Or blockCharacter(MenuCursor + 1) = True
                            MenuCursor = MenuCursor - 1
                            If MenuCursor < 0 Then MenuCursor = numCharacters - 1
                        Loop
                    End If
                    PlaySound 26
                End If
                MenuCursorCanMove = False
            ElseIf .Down = True Or (GetKeyState(vbKeyDown) And KEY_PRESSED) Then
                If MenuCursorCanMove = True Then
                    MenuCursor = MenuCursor + 1
                    If MenuMode >= 100 Then
                        Do While (MenuCursor = PlayerCharacter - 1 And (MenuMode = 300 Or MenuMode = 500)) Or blockCharacter(MenuCursor + 1) = True
                            MenuCursor = MenuCursor + 1
                            If MenuCursor >= numCharacters Then MenuCursor = 0
                        Loop
                    End If
                    PlaySound 26
                End If
                MenuCursorCanMove = False
            End If
        End If
        
        If MenuMode = 0 Then ' Main Menu
            If MenuMouseMove = True Then
                For A = 0 To 4
                    If MenuMouseY >= 350 + A * 30 And MenuMouseY <= 366 + A * 30 Then
                        If A = 0 Then
                            menuLen = 18 * Len("1 player game") - 2
                        ElseIf A = 1 Then
                            menuLen = 18 * Len("2 player game") - 2
                        ElseIf A = 2 Then
                            menuLen = 18 * Len("battle game")
                        ElseIf A = 3 Then
                            menuLen = 18 * Len("options")
                        Else
                            menuLen = 18 * Len("exit")
                        End If
                        If MenuMouseX >= 300 And MenuMouseX <= 300 + menuLen Then
                            If MenuMouseRelease = True And MenuMouseDown = True Then MenuMouseClick = True
                            If MenuCursor <> A Then
                                PlaySound 26
                                MenuCursor = A
                            End If
                        End If
                    End If
                Next A
            End If
            If (GetKeyState(vbKeyEscape) And KEY_PRESSED) And MenuCursorCanMove = True Then
                If MenuCursor <> 4 Then
                    MenuCursor = 4
                    PlaySound 26
                End If
            ElseIf ((.Jump = True Or .Start = True Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED)) And MenuCursorCanMove = True) Or MenuMouseClick = True Then
                MenuCursorCanMove = False
                PlayerCharacter = 0
                PlayerCharacter2 = 0
                If MenuCursor = 0 Then
                    PlaySound 29
                    MenuMode = 1
                    FindWorlds
                    MenuCursor = 0
                ElseIf MenuCursor = 1 Then
                    PlaySound 29
                    MenuMode = 2
                    FindWorlds
                    MenuCursor = 0
                ElseIf MenuCursor = 2 Then
                    PlaySound 29
                    MenuMode = 4
                    FindLevels
                    MenuCursor = 0
                ElseIf MenuCursor = 3 Then
                    PlaySound 29
                    MenuMode = 3
                    MenuCursor = 0
                ElseIf MenuCursor = 4 Then
                    PlaySound 29
                    BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
                    BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
                    StopMusic
                    DoEvents
                    Sleep 500
                    KillIt
                End If
            End If
            If MenuCursor > 4 Then MenuCursor = 0
            If MenuCursor < 0 Then MenuCursor = 4
        ElseIf MenuMode = 100 Or MenuMode = 200 Or MenuMode = 300 Or MenuMode = 400 Or MenuMode = 500 Then  'Character Select
            If MenuMouseMove = True Then
                B = 0
                For A = 0 To 4
                    If blockCharacter(A + 1) = True Then
                        B = B - 30
                    Else
                        If MenuMouseY >= 350 + A * 30 + B And MenuMouseY <= 366 + A * 30 + B Then
                            If A = 0 Then
                                menuLen = 18 * Len("mario game") + 2
                            ElseIf A = 3 Or A = 5 Then
                                menuLen = 18 * Len("toad game")
                            Else
                                menuLen = 18 * Len("luigi game")
                            End If
                            If MenuMouseX >= 300 And MenuMouseX <= 300 + menuLen Then
                                If MenuMouseRelease = True And MenuMouseDown = True Then MenuMouseClick = True
                                If MenuCursor <> A Then
                                    If ((MenuMode = 300 Or MenuMode = 500) And PlayerCharacter - 1 = A) Or (blockCharacter(A + 1) = True) And MenuMouseClick = True Then
                                        MenuMouseClick = False
                                    Else
                                        PlaySound 26
                                        MenuCursor = A
                                    End If
                                End If
                            End If
                        End If
                    End If
                Next A
            End If
            If MenuCursorCanMove = True Or MenuMouseClick = True Or MenuMouseBack = True Then
                If .Run = True Or (GetKeyState(vbKeyEscape) And KEY_PRESSED) Or MenuMouseBack = True Then
                    If MenuMode = 300 Then
                        MenuMode = 200
                        MenuCursor = PlayerCharacter - 1
                    ElseIf MenuMode = 500 Then
                        MenuMode = 400
                        MenuCursor = PlayerCharacter - 1
                    Else
                        MenuCursor = selWorld - 1
                        MenuMode = MenuMode / 100
                    End If
                    MenuCursorCanMove = False
                    PlaySound 26
                ElseIf .Jump = True Or .Start = True Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Or MenuMouseClick = True Then
                    PlaySound 29
                    If MenuMode = 100 Then
                        PlayerCharacter = MenuCursor + 1
                        MenuMode = 10
                        MenuCursor = 0
                    ElseIf MenuMode = 200 Then
                        PlayerCharacter = MenuCursor + 1
                        MenuMode = 300
                        MenuCursor = PlayerCharacter2
                    ElseIf MenuMode = 300 Then
                        PlayerCharacter2 = MenuCursor + 1
                        MenuMode = 20
                        MenuCursor = 0
                    ElseIf MenuMode = 400 Then
                        PlayerCharacter = MenuCursor + 1
                        MenuMode = 500
                        MenuCursor = PlayerCharacter2 - 1
                        If MenuCursor < 0 Then MenuCursor = 0
                    ElseIf MenuMode = 500 Then
                        PlayerCharacter2 = MenuCursor + 1
                        MenuCursor = 0
                        StartBattleMode
                        Exit Sub
                    End If
                    MenuCursorCanMove = False
                End If
            End If
            If MenuMode > 0 Then
                If MenuCursor > numCharacters - 1 Then
                    MenuCursor = 0
                    Do While (MenuCursor = PlayerCharacter - 1 And (MenuMode = 300 Or MenuMode = 500)) Or blockCharacter(MenuCursor + 1) = True
                        MenuCursor = MenuCursor + 1
                    Loop
                End If
                If MenuCursor < 0 Then
                    MenuCursor = numCharacters - 1
                    Do While (MenuCursor = PlayerCharacter - 1 And (MenuMode = 300 Or MenuMode = 500)) Or blockCharacter(MenuCursor + 1) = True
                        MenuCursor = MenuCursor - 1
                    Loop
                End If
            End If
            Do While ((MenuMode = 300 Or MenuMode = 500) And MenuCursor = PlayerCharacter - 1) Or blockCharacter(MenuCursor + 1) = True
                MenuCursor = MenuCursor + 1
            Loop
            If MenuMode >= 100 Then
                If MenuCursor >= numCharacters Then
                    MenuCursor = 0
                Else
                    For A = 1 To numPlayers
                        Player(A).Character = MenuCursor + 1
                        SizeCheck A
                    Next A
                    For A = 1 To numNPCs
                        If NPC(A).Type = 13 Then NPC(A).Special = MenuCursor + 1
                    Next A
                End If
            End If
        ElseIf MenuMode = 1 Or MenuMode = 2 Or MenuMode = 4 Then 'World Select
            If ScrollDelay > 0 Then
                MenuMouseMove = True
                ScrollDelay = ScrollDelay - 1
            End If
            If MenuMouseMove = True Then
                B = 0
                For A = minShow - 1 To maxShow - 1
                    If MenuMouseY >= 350 + B * 30 And MenuMouseY <= 366 + B * 30 Then
                        menuLen = 19 * Len(SelectWorld(A + 1).WorldName)
                        If MenuMouseX >= 300 And MenuMouseX <= 300 + menuLen Then
                            If MenuMouseRelease = True And MenuMouseDown = True Then MenuMouseClick = True
                            If MenuCursor <> A And ScrollDelay = 0 Then
                                ScrollDelay = 10
                                PlaySound 26
                                MenuCursor = A
                            End If
                        End If
                    End If
                    B = B + 1
                Next A
            End If
            If MenuCursorCanMove = True Or MenuMouseClick = True Or MenuMouseBack = True Then
                If .Run = True Or (GetKeyState(vbKeyEscape) And KEY_PRESSED) Or MenuMouseBack = True Then
                    MenuCursor = MenuMode - 1
                    If MenuMode = 4 Then MenuCursor = 2
                    MenuMode = 0
'world select back


                    PlaySound 26
                    MenuCursorCanMove = False
                ElseIf .Jump = True Or .Start = True Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Or MenuMouseClick = True Then
                    PlaySound 29
                    selWorld = MenuCursor + 1
                    FindSaves
                    For A = 1 To numCharacters
                        If MenuMode = 4 Then
                            blockCharacter(A) = False
                        Else
                            blockCharacter(A) = SelectWorld(selWorld).blockChar(A)
                        End If
                    Next A
                    MenuMode = MenuMode * 100
                    MenuCursor = 0
                    If MenuMode = 400 And PlayerCharacter <> 0 Then MenuCursor = PlayerCharacter - 1
                    MenuCursorCanMove = False
                End If
            End If
            If MenuMode < 100 Then
                If MenuCursor >= NumSelectWorld Then MenuCursor = 0
                If MenuCursor < 0 Then MenuCursor = NumSelectWorld - 1
            End If
        ElseIf MenuMode = 10 Or MenuMode = 20 Then 'Save Select
            If MenuMouseMove = True Then
                For A = 0 To 2
                    If MenuMouseY >= 350 + A * 30 And MenuMouseY <= 366 + A * 30 Then
                        menuLen = 18 * Len("slot 1 empty") - 2
                        If SaveSlot(A + 1) >= 0 Then menuLen = 18 * Len("slot ... 100") - 2
                        If SaveStars(A + 1) > 0 Then menuLen = 288 + Len(SaveStars(A + 1)) * 18
                        If MenuMouseX >= 300 And MenuMouseX <= 300 + menuLen Then
                            If MenuMouseRelease = True And MenuMouseDown = True Then MenuMouseClick = True
                            If MenuCursor <> A Then
                                PlaySound 26
                                MenuCursor = A
                            End If
                        End If
                    End If
                Next A
            End If
            If MenuCursorCanMove = True Or MenuMouseClick = True Or MenuMouseBack = True Then
                If .Run = True Or (GetKeyState(vbKeyEscape) And KEY_PRESSED) Or MenuMouseBack = True Then
'save select back
                    If AllCharBlock > 0 Then
                        MenuMode = MenuMode / 10
                        MenuCursor = selWorld - 1
                    Else
                        If MenuMode = 10 Then
                            MenuCursor = PlayerCharacter - 1
                            MenuMode = 100
                        Else
                            MenuMode = 300
                            MenuCursor = PlayerCharacter2 - 1
                        End If
                    End If
                    MenuCursorCanMove = False
                    PlaySound 29
                ElseIf .Jump = True Or .Start = True Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Or MenuMouseClick = True Then
                    PlaySound 29
                    numPlayers = MenuMode / 10
                    For A = 1 To numCharacters
                        SavedChar(A) = blankPlayer
                        SavedChar(A).Character = A
                        SavedChar(A).State = 1
                    Next A
                    Player(1).State = 1
                    Player(1).Mount = 0
                    Player(1).Character = 1
                    Player(1).HeldBonus = 0
                    Player(1).CanFly = False
                    Player(1).CanFly2 = False
                    Player(1).TailCount = 0
                    Player(1).YoshiBlue = False
                    Player(1).YoshiRed = False
                    Player(1).YoshiYellow = False
                    Player(1).Hearts = 0
                    Player(2).State = 1
                    Player(2).Mount = 0
                    Player(2).Character = 2
                    Player(2).HeldBonus = 0
                    Player(2).CanFly = False
                    Player(2).CanFly2 = False
                    Player(2).TailCount = 0
                    Player(2).YoshiBlue = False
                    Player(2).YoshiRed = False
                    Player(2).YoshiYellow = False
                    Player(2).Hearts = 0
                    If numPlayers <= 2 And PlayerCharacter > 0 Then
                        Player(1).Character = PlayerCharacter
                        PlayerCharacter = 0
                    End If
                    If numPlayers = 2 And PlayerCharacter2 > 0 Then
                        Player(2).Character = PlayerCharacter2
                        PlayerCharacter2 = 0
                    End If
                    selSave = MenuCursor + 1
                    numStars = 0
                    Coins = 0
                    Score = 0
                    Lives = 3
                    LevelSelect = True
                    GameMenu = False
                    BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
                    BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
                    StopMusic
                    DoEvents
                    Sleep 500
                    OpenWorld SelectWorld(selWorld).WorldPath & SelectWorld(selWorld).WorldFile
                    If SaveSlot(selSave) >= 0 Then
                        If NoMap = False Then StartLevel = ""
                        LoadGame
                    End If
                    If WorldUnlock = True Then
                        For A = 1 To numWorldPaths
                        tempLocation = WorldPath(A).Location
                        With tempLocation
                            .X = .X + 4
                            .Y = .Y + 4
                            .Width = .Width - 8
                            .Height = .Height - 8
                        End With
                            WorldPath(A).Active = True
                            For B = 1 To numScenes
                                If CheckCollision(tempLocation, Scene(B).Location) Then Scene(B).Active = False
                            Next B
                        Next A
                        For A = 1 To numWorldLevels
                            WorldLevel(A).Active = True
                        Next A
                    End If
                    SetupPlayers
                    If StartLevel <> "" Then
                        PlaySound 28
                        SoundPause(26) = 200
                        LevelSelect = False
                        
                        GameThing
                        ClearLevel
                        
                        Sleep 1000
                        OpenLevel SelectWorld(selWorld).WorldPath & StartLevel
                    End If
                    Exit Sub
                End If
            End If
            If MenuMode < 100 Then
                If MenuCursor > 2 Then MenuCursor = 0
                If MenuCursor < 0 Then MenuCursor = 2
            End If
        ElseIf MenuMode = 3 Then 'Options
            If MenuMouseMove = True Then
                For A = 0 To 3
                    If MenuMouseY >= 350 + A * 30 And MenuMouseY <= 366 + A * 30 Then
                        If A = 0 Then
                            menuLen = 18 * Len("player 1 controls") - 4
                        ElseIf A = 1 Then
                            menuLen = 18 * Len("player 2 controls") - 4
                        ElseIf A = 2 Then
                            If resChanged = True Then
                                menuLen = 18 * Len("windowed mode")
                            Else
                                menuLen = 18 * Len("fullscreen mode")
                            End If
                        Else
                            menuLen = 18 * Len("view credits") - 2
                        End If
                        If MenuMouseX >= 300 And MenuMouseX <= 300 + menuLen Then
                            If MenuMouseRelease = True And MenuMouseDown = True Then MenuMouseClick = True
                            If MenuCursor <> A Then
                                PlaySound 26
                                MenuCursor = A
                            End If
                        End If
                    End If
                Next A
            End If
            If MenuCursorCanMove = True Or MenuMouseClick = True Or MenuMouseBack = True Then
                If .Run = True Or (GetKeyState(vbKeyEscape) And KEY_PRESSED) Or MenuMouseBack = True Then
                    MenuMode = 0
                    MenuCursor = 3
                    MenuCursorCanMove = False
                    PlaySound 26
                ElseIf .Jump = True Or .Start = True Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Or MenuMouseClick = True Then
                    MenuCursorCanMove = False
                    If MenuCursor = 0 Then
                        MenuCursor = 0
                        MenuMode = 31
                        PlaySound 26
                    ElseIf MenuCursor = 1 Then
                        MenuCursor = 0
                        MenuMode = 32
                        PlaySound 26
                    ElseIf MenuCursor = 2 Then
                        PlaySound 29
                        ChangeScreen
                    ElseIf MenuCursor = 3 Then
                        PlaySound 29
                        GameMenu = False
                        GameOutro = True
                        CreditChop = 300
                        EndCredits = 0
                        SetupCredits
                    End If
                End If
            End If
            If MenuMode = 3 Then
                If MenuCursor > 3 Then MenuCursor = 0
                If MenuCursor < 0 Then MenuCursor = 3
            End If
        ElseIf MenuMode = 31 Or MenuMode = 32 Then 'Input Settings
            If MenuMouseMove = True And getNewJoystick = False And getNewKeyboard = False Then
                If useJoystick(MenuMode - 30) = 0 Then
                    For A = 0 To 10
                        If MenuMouseY >= 260 - 44 + A * 30 And MenuMouseY <= 276 - 44 + A * 30 Then
                            If A = 0 Then
                                menuLen = 18 * Len("INPUT......KEYBOARD")
                            ElseIf A = 1 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).Up)))
                            ElseIf A = 2 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).Down)))
                            ElseIf A = 3 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).Left)))
                            ElseIf A = 4 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).Right)))
                            ElseIf A = 5 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).Run)))
                            ElseIf A = 6 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).AltRun)))
                            ElseIf A = 7 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).Jump)))
                            ElseIf A = 8 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).AltJump)))
                            ElseIf A = 9 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).Drop)))
                            ElseIf A = 10 Then
                                menuLen = 18 * Len("UP........." & CheckKey(Chr(conKeyboard(MenuMode - 30).Start)))
                            End If
                            If MenuMouseX >= 300 And MenuMouseX <= 300 + menuLen Then
                                If MenuMouseRelease = True And MenuMouseDown = True Then MenuMouseClick = True
                                If MenuCursor <> A Then
                                    PlaySound 26
                                    MenuCursor = A
                                End If
                            End If
                        End If
                    Next A
                Else
                    For A = 0 To 6
                        If MenuMouseY >= 260 - 44 + A * 30 And MenuMouseY <= 276 + A * 30 - 44 Then
                            If A = 0 Then
                                menuLen = 18 * Len("INPUT......JOYSTICK 1") - 2
                            Else
                                menuLen = 18 * Len("RUN........_")
                            End If
                            If MenuMouseX >= 300 And MenuMouseX <= 300 + menuLen Then
                                If MenuMouseRelease = True And MenuMouseDown = True Then MenuMouseClick = True
                                If MenuCursor <> A Then
                                    PlaySound 26
                                    MenuCursor = A
                                End If
                            End If
                        End If
                    Next A
                End If
            End If
            If MenuCursorCanMove = True Or ((getNewKeyboard = False And getNewJoystick = False) And (MenuMouseClick = True Or MenuMouseBack = True)) Then
                If getNewKeyboard = True Then
                    If inputKey <> 0 Then
                        getNewKeyboard = False
                        MenuCursorCanMove = False
                        PlaySound 29
                        If MenuCursor = 1 Then
                            conKeyboard(MenuMode - 30).Up = inputKey
                        ElseIf MenuCursor = 2 Then conKeyboard(MenuMode - 30).Down = inputKey
                        ElseIf MenuCursor = 3 Then conKeyboard(MenuMode - 30).Left = inputKey
                        ElseIf MenuCursor = 4 Then conKeyboard(MenuMode - 30).Right = inputKey
                        ElseIf MenuCursor = 5 Then conKeyboard(MenuMode - 30).Run = inputKey
                        ElseIf MenuCursor = 6 Then conKeyboard(MenuMode - 30).AltRun = inputKey
                        ElseIf MenuCursor = 7 Then conKeyboard(MenuMode - 30).Jump = inputKey
                        ElseIf MenuCursor = 8 Then conKeyboard(MenuMode - 30).AltJump = inputKey
                        ElseIf MenuCursor = 9 Then conKeyboard(MenuMode - 30).Drop = inputKey
                        ElseIf MenuCursor = 10 Then conKeyboard(MenuMode - 30).Start = inputKey
                        End If
                    End If
                ElseIf getNewJoystick = True Then
                    JoyNum = useJoystick(MenuMode - 30) - 1
                    PollJoystick
                    If JoyButtons(oldJumpJoy) = True Then
                    Else
                        oldJumpJoy = -1
                        For A = 0 To 15
                            If JoyButtons(A) = True Then
                                PlaySound 29
                                If MenuCursor = 1 Then
                                    conJoystick(MenuMode - 30).Run = A
                                ElseIf MenuCursor = 2 Then conJoystick(MenuMode - 30).AltRun = A
                                ElseIf MenuCursor = 3 Then conJoystick(MenuMode - 30).Jump = A
                                ElseIf MenuCursor = 4 Then conJoystick(MenuMode - 30).AltJump = A
                                ElseIf MenuCursor = 5 Then conJoystick(MenuMode - 30).Drop = A
                                ElseIf MenuCursor = 6 Then conJoystick(MenuMode - 30).Start = A
                                End If
                                getNewJoystick = False
                                MenuCursorCanMove = False
                                Exit For
                            ElseIf (GetKeyState(vbKeyEscape) And KEY_PRESSED) Then
                                If MenuCursor = 1 Then
                                    conJoystick(MenuMode - 30).Run = lastJoyButton
                                ElseIf MenuCursor = 2 Then conJoystick(MenuMode - 30).AltRun = lastJoyButton
                                ElseIf MenuCursor = 3 Then conJoystick(MenuMode - 30).AltJump = lastJoyButton
                                ElseIf MenuCursor = 4 Then conJoystick(MenuMode - 30).Jump = lastJoyButton
                                ElseIf MenuCursor = 5 Then conJoystick(MenuMode - 30).Drop = lastJoyButton
                                ElseIf MenuCursor = 6 Then conJoystick(MenuMode - 30).Start = lastJoyButton
                                End If
                                getNewJoystick = False
                                MenuCursorCanMove = False
                            End If
                        Next A
                    End If
                Else
                    If .Run = True Or (GetKeyState(vbKeyEscape) And KEY_PRESSED) Or MenuMouseBack = True Then
                        SaveConfig
                        MenuCursor = MenuMode - 31
                        MenuMode = 3
                        MenuCursorCanMove = False
                        PlaySound 26
                    ElseIf .Jump = True Or .Start = True Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Or MenuMouseClick = True Then
                        If MenuCursor = 0 Then
                            PlaySound 29
                            useJoystick(MenuMode - 30) = useJoystick(MenuMode - 30) + 1
                            If useJoystick(MenuMode - 30) > numJoysticks Then useJoystick(MenuMode - 30) = 0
                        Else
                            If useJoystick(MenuMode - 30) = 0 Then
                                getNewKeyboard = True
                                inputKey = Asc("_")
                                If MenuCursor = 1 Then
                                    conKeyboard(MenuMode - 30).Up = inputKey
                                ElseIf MenuCursor = 2 Then conKeyboard(MenuMode - 30).Down = inputKey
                                ElseIf MenuCursor = 3 Then conKeyboard(MenuMode - 30).Left = inputKey
                                ElseIf MenuCursor = 4 Then conKeyboard(MenuMode - 30).Right = inputKey
                                ElseIf MenuCursor = 5 Then conKeyboard(MenuMode - 30).Run = inputKey
                                ElseIf MenuCursor = 6 Then conKeyboard(MenuMode - 30).AltRun = inputKey
                                ElseIf MenuCursor = 7 Then conKeyboard(MenuMode - 30).Jump = inputKey
                                ElseIf MenuCursor = 8 Then conKeyboard(MenuMode - 30).AltJump = inputKey
                                ElseIf MenuCursor = 9 Then conKeyboard(MenuMode - 30).Drop = inputKey
                                ElseIf MenuCursor = 10 Then conKeyboard(MenuMode - 30).Start = inputKey
                                End If
                                inputKey = 0
                            Else
                                If MenuCursor = 1 Then
                                    lastJoyButton = conJoystick(MenuMode - 30).Run
                                    conJoystick(MenuMode - 30).Run = -1
                                ElseIf MenuCursor = 2 Then
                                    lastJoyButton = conJoystick(MenuMode - 30).AltRun
                                    conJoystick(MenuMode - 30).AltRun = -1
                                ElseIf MenuCursor = 3 Then
                                    lastJoyButton = conJoystick(MenuMode - 30).Jump
                                    oldJumpJoy = conJoystick(MenuMode - 30).Jump
                                    conJoystick(MenuMode - 30).Jump = -1
                                ElseIf MenuCursor = 4 Then
                                    lastJoyButton = conJoystick(MenuMode - 30).AltJump
                                    conJoystick(MenuMode - 30).AltJump = -1
                                ElseIf MenuCursor = 5 Then
                                    lastJoyButton = conJoystick(MenuMode - 30).Drop
                                    conJoystick(MenuMode - 30).Drop = -1
                                ElseIf MenuCursor = 6 Then
                                    lastJoyButton = conJoystick(MenuMode - 30).Start
                                    conJoystick(MenuMode - 30).Start = -1
                                End If
                                getNewJoystick = True
                                MenuCursorCanMove = False
                            End If
                        End If
                        MenuCursorCanMove = False
                    End If
                End If
            End If
            If MenuMode <> 3 Then
                If useJoystick(MenuMode - 30) = 0 Then
                    If MenuCursor > 10 Then MenuCursor = 0
                    If MenuCursor < 0 Then MenuCursor = 10
                Else
                    If MenuCursor > 6 Then MenuCursor = 0
                    If MenuCursor < 0 Then MenuCursor = 6
                End If
            End If
        End If
    End With
    

'check for all characters blocked
        If MenuMode = 100 Or MenuMode = 200 Or MenuMode = 300 Then
            AllCharBlock = 0
            For A = 1 To numCharacters
                If blockCharacter(A) = False Then
                    If AllCharBlock = 0 Then
                        AllCharBlock = A
                    Else
                        AllCharBlock = 0
                        Exit For
                    End If
                End If
            Next A
            If AllCharBlock > 0 Then
                PlayerCharacter = AllCharBlock
                PlayerCharacter2 = AllCharBlock
                If MenuMode = 100 Then
                    MenuMode = 10
                    MenuCursor = 0
                ElseIf MenuMode = 200 Then
                    MenuMode = 300
                    MenuCursor = PlayerCharacter2
                Else
                    MenuMode = 20
                    MenuCursor = 0
                End If
            End If
        End If
    
    
    
    If CheckLiving = 0 Then
        ShowLayer "Destroyed Blocks"
        For A = 1 To numNPCs
            If NPC(A).DefaultType = 0 Then
                If NPC(A).TimeLeft > 10 Then NPC(A).TimeLeft = 10
            End If
        Next A
    End If
    For A = 1 To numPlayers
        With Player(A)
            If .TimeToLive > 0 Then
                .TimeToLive = 0
                .Dead = True
            End If
            .Controls.Down = False
            .Controls.Drop = False
            .Controls.Right = True
            .Controls.Left = False
            .Controls.Run = True
            .Controls.Up = False
            .Controls.AltRun = False
            .Controls.AltJump = False
            If .Jump = 0 Or .Location.Y < level(0).Y + 200 Then .Controls.Jump = False
            If .Location.SpeedX < 0.5 Then
                .Controls.Jump = True
                If .Slope > 0 Or .StandingOnNPC > 0 Or .Location.SpeedY = 0 Then .CanJump = True
            End If
            If .HoldingNPC = 0 Then
                If (.State = 3 Or .State = 6 Or .State = 7) And Rnd * 100 > 90 Then
                    If .FireBallCD = 0 And .RunRelease = False Then
                        .Controls.Run = False
                    End If
                End If
                If (.State = 4 Or .State = 5) And .TailCount = 0 And .RunRelease = False Then
                    tempLocation.Width = 24
                    tempLocation.Height = 20
                    tempLocation.Y = .Location.Y + .Location.Height - 22
                    tempLocation.X = .Location.X + .Location.Width
                    For B = 1 To numNPCs
                        If NPC(B).Active = True And Not NPCIsABonus(NPC(B).Type) And Not NPCWontHurt(NPC(B).Type) And NPC(B).HoldingPlayer = 0 Then
                            If CheckCollision(tempLocation, NPC(B).Location) Then
                                .Controls.Run = False
                            End If
                        End If
                    Next B
                End If
                If .StandingOnNPC > 0 Then
                    If NPCGrabFromTop(NPC(.StandingOnNPC).Type) = True Then
                        .Controls.Down = True
                        .Controls.Run = True
                        .RunRelease = True
                    End If
                End If
            End If
            If .Character = 5 Then
                If .FireBallCD = 0 And .RunRelease = False Then
                    tempLocation.Width = 38 + .Location.SpeedX * 0.5
                    tempLocation.Height = .Location.Height - 8
                    tempLocation.Y = .Location.Y + 4
                    tempLocation.X = .Location.X + .Location.Width
                    For B = 1 To numNPCs
                        If NPC(B).Active = True And Not NPCIsABonus(NPC(B).Type) And Not NPCWontHurt(NPC(B).Type) And NPC(B).HoldingPlayer = 0 Then
                            If CheckCollision(tempLocation, NPC(B).Location) Then
                                .RunRelease = True
                                If NPC(B).Location.Y > .Location.Y + .Location.Height / 2 Then .Controls.Down = True
                                Exit For
                            End If
                        End If
                    Next B
                End If
                If .Slope = 0 And .StandingOnNPC = 0 Then
                    If .Location.SpeedY < 0 Then
                        tempLocation.Width = 200
                        tempLocation.Height = .Location.Y - level(0).Y + .Location.Height
                        tempLocation.Y = level(0).Y
                        tempLocation.X = .Location.X
                        For B = 1 To numNPCs
                            If NPC(B).Active = True And Not NPCIsABonus(NPC(B).Type) And Not NPCWontHurt(NPC(B).Type) And NPC(B).HoldingPlayer = 0 Then
                                If CheckCollision(tempLocation, NPC(B).Location) Then
                                    .Controls.Up = True
                                    Exit For
                                End If
                            End If
                        Next B
                    ElseIf .Location.SpeedY > 0 Then
                        tempLocation.Width = 200
                        tempLocation.Height = level(0).Height - .Location.Y
                        tempLocation.Y = .Location.Y
                        tempLocation.X = .Location.X
                        For B = 1 To numNPCs
                            If NPC(B).Active = True And Not NPCIsABonus(NPC(B).Type) And Not NPCWontHurt(NPC(B).Type) And NPC(B).HoldingPlayer = 0 Then
                                If CheckCollision(tempLocation, NPC(B).Location) Then
                                    .Controls.Down = True
                                    Exit For
                                End If
                            End If
                        Next B
                    End If
                End If
            End If
                
            
            If .Location.X < -vScreenX(1) - .Location.Width And Not -vScreenX(1) <= level(0).X Then .Dead = True
            If .Location.X > -vScreenX(1) + 1000 Then .Dead = True
            If .Location.X > -vScreenX(1) + 600 And -vScreenX(1) + 850 < level(0).Width Then .Controls.Run = False
            If -vScreenX(1) <= level(0).X And (.Dead = True Or .TimeToLive > 0) Then
                .ForceHold = 65
                .State = Int(Rnd * 6) + 2
                .CanFly = False
                .CanFly2 = False
                .TailCount = 0
                .Dead = False
                .TimeToLive = 0
                .Character = Int(Rnd * 5) + 1
                If A >= 1 And A <= 5 Then .Character = A
                .HeldBonus = 0
                .Section = 0
                .Mount = 0
                .MountType = 0
                .YoshiBlue = False
                .YoshiRed = False
                .YoshiYellow = False
                .YoshiNPC = 0
                .Wet = 0
                .WetFrame = False
                .YoshiPlayer = 0
                .Bumped = False
                .Bumped2 = 0
                .Direction = 1
                .Dismount = 0
                .Effect = 0
                .Effect2 = 0
                .FireBallCD = 0
                .ForceHold = 0
                .Warp = 0
                .WarpCD = 0
                .GroundPound = False
                .Immune = 0
                .Frame = 0
                .Slope = 0
                .Slide = False
                .SpinJump = False
                .FrameCount = 0
                .TailCount = 0
                .Duck = False
                .GroundPound = False
                .Hearts = 3
                PlayerFrame A
                .Location.Height = Physics.PlayerHeight(.Character, .State)
                .Location.Width = Physics.PlayerWidth(.Character, .State)
                .Location.X = level(.Section).X - A * 48
                .Location.SpeedX = Physics.PlayerRunSpeed
                .Location.Y = level(.Section).Height - .Location.Height - 33
                Do
                    tempBool = True
                    For B = 1 To numBlock
                        If CheckCollision(.Location, Block(B).Location) = True Then
                            .Location.Y = Block(B).Location.Y - .Location.Height - 0.1
                            tempBool = False
                        End If
                    Next B
                Loop While tempBool = False
                If UnderWater(.Section) = False Then
                    If Int(Rnd * 25) + 1 = 25 Then
                        .Mount = 1
                        .MountType = Int(Rnd * 3) + 1
                        If .State = 1 Then
                            .Location.Height = Physics.PlayerHeight(1, 2)
                            .Location.Y = .Location.Y - Physics.PlayerHeight(1, 2) + Physics.PlayerHeight(.Character, 1)
                        End If
                    End If
                End If
                If .Mount = 0 And .Character <= 2 Then
                    If Int(Rnd * 15) + 1 = 15 Then
                        .Mount = 3
                        .MountType = Int(Rnd * 7) + 1
                        .Location.Y = .Location.Y + .Location.Height
                        .Location.Height = Physics.PlayerHeight(2, 2)
                        .Location.Y = .Location.Y - .Location.Height - 0.01
                    End If
                End If
                .CanFly = False
                .CanFly2 = False
                .RunCount = 0
                If .Mount = 0 And .Character <> 5 Then
                    numNPCs = numNPCs + 1
                    .HoldingNPC = numNPCs
                    .ForceHold = 120
                    With NPC(numNPCs)
                        Do
                            Do
                                .Type = Int(Rnd * 286) + 1
                            Loop While .Type = 11 Or .Type = 16 Or .Type = 18 Or .Type = 15 Or .Type = 21 Or .Type = 12 Or .Type = 13 Or .Type = 30 Or .Type = 17 Or .Type = 31 Or .Type = 32 Or (.Type >= 37 And .Type <= 44) Or .Type = 46 Or .Type = 47 Or .Type = 50 Or (.Type >= 56 And .Type <= 70) Or .Type = 8 Or .Type = 74 Or .Type = 51 Or .Type = 52 Or .Type = 75 Or .Type = 34 Or NPCIsToad(.Type) Or NPCIsAnExit(.Type) Or NPCIsYoshi(.Type) Or (.Type >= 78 And .Type <= 87) Or .Type = 91 Or .Type = 93 Or (.Type >= 104 And .Type <= 108) Or .Type = 125 Or .Type = 133 Or (.Type >= 148 And .Type <= 151) Or .Type = 159 Or .Type = 160 Or .Type = 164 Or .Type = 168 Or (.Type >= 154 And .Type <= 157) Or .Type = 159 Or .Type = 160 Or .Type = 164 Or .Type = 165 Or .Type = 171 Or .Type = 178 Or .Type = 197 Or .Type = 180 Or .Type = 181 Or .Type = 190 Or .Type = 192 Or .Type = 196 Or .Type = 197 Or (UnderWater(0) = True And NPCIsBoot(.Type) = True) Or (.Type >= 198 And .Type <= 228) Or .Type = 234
                        Loop While .Type = 235 Or .Type = 231 Or .Type = 179 Or .Type = 49 Or .Type = 237 Or .Type = 238 Or .Type = 239 Or .Type = 240 Or .Type = 245 Or .Type = 246 Or .Type = 248 Or .Type = 254 Or .Type = 255 Or .Type = 256 Or .Type = 257 Or .Type = 259 Or .Type = 260 Or .Type = 262 Or .Type = 263 Or .Type = 265 Or .Type = 266 Or (.Type >= 267 And .Type <= 272) Or .Type = 275 Or .Type = 276 Or (.Type >= 280 And .Type <= 284) Or .Type = 241
                        .Active = True
                        .HoldingPlayer = A
                        .Location.Height = NPCHeight(.Type)
                        .Location.Width = NPCWidth(.Type)
                        .Location.Y = Player(A).Location.Y  'level(.Section).Height + 1000
                        .Location.X = Player(A).Location.X 'level(.Section).X + 1000
                        .TimeLeft = 100
                        .Section = Player(A).Section
                    End With
                End If
            ElseIf .Location.X > level(.Section).Width + 64 Then
                .Dead = True
            End If
            If .WetFrame = True Then
                If .Location.SpeedY = 0 Or .Slope > 0 Then .CanJump = True
                If Rnd * 100 > 98 Or .Location.SpeedY = 0 Or .Slope > 0 Then .Controls.Jump = True
            End If
            If Rnd * 100 > 95 And .HoldingNPC = 0 And .Slide = False And .CanAltJump = True And .Mount = 0 Then .Controls.AltJump = True
            If Rnd * 1000 >= 999 And .CanFly2 = False Then .Controls.Run = False
            If .Mount = 3 And Rnd * 100 >= 98 And .RunRelease = False Then .Controls.Run = False
            If NPC(.HoldingNPC).Type = 22 Or NPC(.HoldingNPC).Type = 49 Then .Controls.Run = True
            If .Slide = True And .CanJump = True Then
                If .Location.SpeedX > -2 And .Location.SpeedX < 2 Then .Controls.Jump = True
            End If
            If .CanFly = False And .CanFly2 = False And (.State = 4 Or .State = 5) And .Slide = False Then
                .Controls.Jump = True
            End If
            If .Quicksand > 0 Then
                .CanJump = True
                .Controls.Jump = True
            End If
            If .FloatTime > 0 Or (.CanFloat = True And .FloatRelease = True And .Jump = 0 And .Location.SpeedY > 0 And Rnd * 100 > 95) Then
                .Controls.Jump = True
            End If
            If NPC(.HoldingNPC).Type = 13 And Rnd * 100 > 95 Then
                .Controls.Run = False
                If Rnd * 2 > 1 Then .Controls.Up = True
                If Rnd * 2 > 1 Then .Controls.Right = False
            End If
            
            If .Slide = False And (.Slope > 0 Or .StandingOnNPC > 0 Or .Location.SpeedY = 0) Then
                tempLocation = .Location
                tempLocation.Width = 95
                tempLocation.Height = tempLocation.Height - 1
                For B = 1 To numBlock
                    If BlockSlope(Block(B).Type) = 0 And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False And Block(B).Hidden = False Then
                        If CheckCollision(Block(B).Location, tempLocation) = True Then
                            .CanJump = True
                            .SpinJump = False
                            .Controls.Jump = True
                            Exit For
                        End If
                    End If
                Next B
            End If
            If .Slope = 0 And .Slide = False And .StandingOnNPC = 0 And (.Slope > 0 Or .Location.SpeedY = 0) Then
                tempBool = False
                tempLocation = .Location
                tempLocation.Width = 16
                tempLocation.Height = 16
                tempLocation.X = .Location.X + .Location.Width
                tempLocation.Y = .Location.Y + .Location.Height
                For B = 1 To numBlock
                    If (BlockIsSizable(Block(B).Type) = False Or Block(B).Location.Y > .Location.Y + .Location.Height - 1) And BlockOnlyHitspot1(Block(B).Type) = False And Block(B).Hidden = False Then
                        If CheckCollision(Block(B).Location, tempLocation) = True Then
                            tempBool = True
                            Exit For
                        End If
                    End If
                Next B
                If tempBool = False Then
                    .CanJump = True
                    .SpinJump = False
                    .Controls.Jump = True
                End If
            End If
            If .Character = 5 And .Controls.Jump = True Then
                .Controls.AltJump = True
                '.Controls.Jump = False
            End If
            
        End With
    Next A
    If LevelMacro > 0 Then UpdateMacro
    UpdateLayers
    UpdateNPCs
    UpdateBlocks
    UpdateEffects
    UpdatePlayer
    UpdateGraphics
    UpdateSound
    UpdateEvents
    
    
    If MenuMouseDown = True Then
        If Rnd * 100 > 40 Then
            NewEffect 80, newLoc(MenuMouseX - vScreenX(1), MenuMouseY - vScreenY(1))
            Effect(numEffects).Location.SpeedX = Rnd * 4 - 2
            Effect(numEffects).Location.SpeedY = Rnd * 4 - 2
        End If
        For A = 1 To numNPCs
            If NPC(A).Active = True Then
                If CheckCollision(newLoc(MenuMouseX - vScreenX(1), MenuMouseY - vScreenY(1)), NPC(A).Location) = True Then
                    If NPCIsACoin(NPC(A).Type) = False Then
                        NPC(0) = NPC(A)
                        NPC(0).Location.X = MenuMouseX - vScreenX(1)
                        NPC(0).Location.Y = MenuMouseY - vScreenY(1)
                        NPCHit A, 3, 0
                    Else
                        NewEffect 78, NPC(A).Location
                        NPC(A).Killed = 9
                    End If
                End If
            End If
        Next A
        For A = 1 To numBlock
            If Block(A).Hidden = False Then
                If CheckCollision(newLoc(MenuMouseX - vScreenX(1), MenuMouseY - vScreenY(1)), Block(A).Location) = True Then
                    BlockHit A
                    BlockHitHard A
                End If
            End If
        Next A
    End If
    
    MenuMouseMove = False
    MenuMouseClick = False
    If MenuMouseDown = True Then
        MenuMouseRelease = False
    Else
        MenuMouseRelease = True
    End If
    MenuMouseBack = False
End Sub

Public Sub EditorLoop() 'The loop for the level editor
    UpdateEditor
    UpdateBlocks
    UpdateEffects
    If WorldEditor = True Then
        UpdateGraphics2
    Else
        UpdateGraphics
    End If
    UpdateSound
End Sub

Public Sub KillIt() 'Cleans up the buffer before ending the program
    frmMain.Hide
    If resChanged = True Then SetOrigRes
    mciSendString "close all", 0, 0, 0
    DeleteDC myBackBuffer
    DeleteObject myBufferBMP
    UnloadGFX
    Do
    Loop Until ShowCursor(1) >= 1
    End
End Sub

Public Sub SaveLevel(FilePath As String)   'saves the level
    Dim A As Integer
    Dim B As Integer
    Dim tempNPC As NPC
    Dim C As Integer
    Dim starCount As Integer
    For A = 1 To numNPCs
        With NPC(A)
            If .Type = 60 Or .Type = 62 Or .Type = 64 Or .Type = 66 Or (.Type >= 78 And .Type <= 83) Then
                For B = 1 To A - 1
                    If Not (NPC(B).Type = 60 Or NPC(B).Type = 62 Or NPC(B).Type = 64 Or NPC(B).Type = 66 Or (NPC(B).Type >= 78 And NPC(B).Type <= 83)) Then
                        tempNPC = NPC(B)
                        NPC(B) = NPC(A)
                        NPC(A) = tempNPC
                        Exit For
                    End If
                Next B
            End If
        End With
        C = C + 1
    Next A
    qSortNPCsY 1, C
    qSortNPCsY C + 1, numNPCs
    qSortBlocksX 1, numBlock
    B = 1
    For A = 2 To numBlock
        If Block(A).Location.X > Block(B).Location.X Then
            qSortBlocksY B, A - 1
            B = A
        End If
    Next A
    qSortBlocksY B, A - 1
    qSortBackgrounds 1, numBackground
    FindSBlocks
    starCount = 0
    For A = 1 To numNPCs
        If NPC(A).Type = 97 Or NPC(A).Type = 196 Then
            starCount = starCount + 1
        End If
    Next A
    'NPCyFix
    For A = Len(FilePath) To 1 Step -1
        If Mid(FilePath, A, 1) = "/" Or Mid(FilePath, A, 1) = "\" Then Exit For
    Next A
    FileNamePath = Left(FilePath, (A))
    FileName = Right(FilePath, (Len(FilePath) - A))
    FullFileName = FilePath
    If Right(FileNamePath, 2) = "\\" Then
        FileNamePath = Left(FileNamePath, Len(FileNamePath) - 1)
    End If
    Open FilePath For Output As #1
        Write #1, curRelease
        Write #1, starCount
        Write #1, LevelName
        For B = 0 To maxSections
            With level(B)
                Write #1, .X
                Write #1, .Y
                Write #1, .Height
                Write #1, .Width
            End With
            Write #1, bgMusic(B)
            Write #1, bgColor(B)
            Write #1, LevelWrap(B)
            Write #1, OffScreenExit(B)
            Write #1, Background2(B)
            Write #1, NoTurnBack(B)
            Write #1, UnderWater(B)
            Write #1, CustomMusic(B)
        Next B
        For A = 1 To 2
            With PlayerStart(A)
                Write #1, .X
                Write #1, .Y
                Write #1, .Width
                Write #1, .Height
            End With
        Next A
        For A = 1 To numBlock
            With Block(A)
                Write #1, .Location.X
                Write #1, .Location.Y
                Write #1, .Location.Height
                Write #1, .Location.Width
                Write #1, .Type
                Write #1, .Special
                Write #1, .Invis
                Write #1, .Slippy
                If .Layer = "" Then .Layer = "Default"
                Write #1, .Layer
                Write #1, .TriggerDeath
                Write #1, .TriggerHit
                Write #1, .TriggerLast
            End With
        Next A
        Write #1, "next"
        For A = 1 To numBackground
            With Background(A)
                Write #1, .Location.X
                Write #1, .Location.Y
                Write #1, .Type
                If .Layer = "" Then .Layer = "Default"
                Write #1, .Layer
            End With
        Next A
        Write #1, "next"
        For A = 1 To numNPCs
            With NPC(A)
                Write #1, .Location.X
                Write #1, .Location.Y
                Write #1, .Direction
                Write #1, .Type
                If .Type = 91 Or .Type = 96 Or NPCIsAParaTroopa(.Type) = True Or .Type = 283 Or .Type = 284 Then Write #1, .Special
                If NPCIsCheep(.Type) = True Then Write #1, .Special
                If .Type = 260 Then Write #1, .Special
                If .Type = 288 Or .Type = 289 Or (.Type = 91 And .Special = 288) Then Write #1, .Special2 'potion
                Write #1, .Generator
                If .Generator = True Then
                    Write #1, .GeneratorDirection
                    Write #1, .GeneratorEffect
                    Write #1, .GeneratorTimeMax
                End If
                Write #1, .Text
                Write #1, .Inert
                Write #1, .Stuck
                Write #1, .Legacy
                If .Layer = "" Then .Layer = "Default"
                Write #1, .Layer
                Write #1, .TriggerActivate
                Write #1, .TriggerDeath
                Write #1, .TriggerTalk
                Write #1, .TriggerLast
                Write #1, .AttLayer
            End With
        Next A
        Write #1, "next"
        For A = 1 To numWarps + 1
            With Warp(A)
                If .PlacedEnt = True And .PlacedExit = True Then
                    Write #1, .Entrance.X
                    Write #1, .Entrance.Y
                    Write #1, .Exit.X
                    Write #1, .Exit.Y
                    Write #1, .Direction
                    Write #1, .Direction2
                    Write #1, .Effect
                    Write #1, .level
                    Write #1, .LevelWarp
                    Write #1, .LevelEnt
                    Write #1, .MapWarp
                    Write #1, .MapX
                    Write #1, .MapY
                    Write #1, .Stars
                    If .Layer = "" Then .Layer = "Default"
                    Write #1, .Layer
                    Write #1, .Hidden
                    Write #1, .NoYoshi
                    Write #1, .WarpNPC
                    Write #1, .Locked
                End If
            End With
        Next A
        Write #1, "next"
        For A = 1 To numWater
            With Water(A)
                Write #1, .Location.X
                Write #1, .Location.Y
                Write #1, .Location.Width
                Write #1, .Location.Height
                Write #1, .Buoy
                Write #1, .Quicksand
                Write #1, .Layer
            End With
        Next A
        Write #1, "next"
        For A = 0 To frmLayers.lstLayer.ListIndex
            Layer(A).Name = frmLayers.lstLayer.List(A)
            If frmLayers.lstLayer.Selected(A) = True Then
                Layer(A).Hidden = False
            Else
                Layer(A).Hidden = True
            End If
        Next A
        For A = 0 To 100
            If Layer(A).Name = "" Then Exit For
            Write #1, Layer(A).Name
            Write #1, Layer(A).Hidden
        Next A
        Write #1, "next"
        For A = 0 To 100
            If Events(A).Name = "" Then Exit For
            Write #1, Events(A).Name
            Write #1, Events(A).Text
            Write #1, Events(A).Sound
            Write #1, Events(A).EndGame
            For B = 0 To 20
                Write #1, Events(A).HideLayer(B)
                Write #1, Events(A).ShowLayer(B)
                Write #1, Events(A).ToggleLayer(B)
            Next B
            For B = 0 To maxSections
                Write #1, Events(A).Music(B)
                Write #1, Events(A).Background(B)
                Write #1, Events(A).level(B).X
                Write #1, Events(A).level(B).Y
                Write #1, Events(A).level(B).Height
                Write #1, Events(A).level(B).Width
            Next B
            Write #1, Events(A).TriggerEvent
            Write #1, Events(A).TriggerDelay
            Write #1, Events(A).LayerSmoke
            
            Write #1, Events(A).Controls.AltJump
            Write #1, Events(A).Controls.AltRun
            Write #1, Events(A).Controls.Down
            Write #1, Events(A).Controls.Drop
            Write #1, Events(A).Controls.Jump
            Write #1, Events(A).Controls.Left
            Write #1, Events(A).Controls.Right
            Write #1, Events(A).Controls.Run
            Write #1, Events(A).Controls.Start
            Write #1, Events(A).Controls.Up
            
            Write #1, Events(A).AutoStart
            Write #1, Events(A).MoveLayer
            Write #1, Events(A).SpeedX
            Write #1, Events(A).SpeedY
            Write #1, Events(A).AutoX
            Write #1, Events(A).AutoY
            Write #1, Events(A).AutoSection
            
        Next A
    Close #1
    LoadNPCDefaults
    If Dir(FileNamePath & Left(FileName, Len(FileName) - 4) & "\*.txt") <> "" Then
        FindCustomNPCs FileNamePath & Left(FileName, Len(FileName) - 4)
    Else
        FindCustomNPCs
    End If
    
    UnloadCustomGFX
    LoadCustomGFX
    
    LoadCustomGFX2 FileNamePath & Left(FileName, Len(FileName) - 4)
    
    PlaySound 12
    If nPlay.Online = True Then
        If nPlay.Mode = 1 Then
            Netplay.sendData "dServer requested resync." & LB & "j" & LB
            For A = 1 To 15
                If nPlay.ClientCon(A) = True Then Netplay.InitSync A
            Next A
        Else
            ClearLevel
            Netplay.sendData "l" & LB
        End If
    End If
End Sub

Public Sub OpenLevel(FilePath As String)   'loads the level
    Dim newInput As String
    Dim FileRelease As Integer
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim tempBool As Boolean
    Dim mSections As Integer
    Dim tempLocation As Location
    qScreen = False
    ClearLevel
    BlockSound
    FreezeNPCs = False
    CoinMode = False
    If LCase(Right(FilePath, 4)) <> ".lvl" And LCase(Right(FilePath, 4)) <> ".dat" Then FilePath = FilePath & ".lvl"
    For A = Len(FilePath) To 1 Step -1
        If Mid(FilePath, A, 1) = "/" Or Mid(FilePath, A, 1) = "\" Then Exit For
    Next A
    FileName = Right(FilePath, (Len(FilePath) - A))
    FileNamePath = Left(FilePath, (A))
    If Right(FileNamePath, 2) = "\\" Then
        FileNamePath = Left(FileNamePath, Len(FileNamePath) - 1)
    End If
    FullFileName = FilePath
    numBlock = 0
    numBackground = 0
    numNPCs = 0
    numWarps = 0
    
'Load Custom Stuff
    If Dir(FileNamePath & Left(FileName, Len(FileName) - 4) & "\*.txt") <> "" Then
        FindCustomNPCs FileNamePath & Left(FileName, Len(FileName) - 4)
    Else
        FindCustomNPCs
    End If
    LoadCustomGFX
    If Dir(FileNamePath & Left(FileName, Len(FileName) - 4) & "\*.gif") <> "" Then LoadCustomGFX2 FileNamePath & Left(FileName, Len(FileName) - 4)
'Blah
    
    
    If FilePath = ".lvl" Then Exit Sub
        Open FilePath For Input As #1
        Input #1, FileRelease
        If FileRelease > curRelease Then
            MsgBox "You are using an old version of SMBX that is incompatible with this file. Please visit www.SuperMarioBrothers.org to get the latest updates.", vbCritical, "Please click OK so the game can crash."
            KillIt
        End If
        If FileRelease >= 17 Then
            Input #1, maxStars
        End If
        If FileRelease >= 60 Then
            Input #1, LevelName
        End If
        If FileRelease <= 7 Then
            mSections = 5
        Else
            mSections = maxSections
        End If
        For B = 0 To mSections
            With level(B)
                Input #1, .X
                Input #1, .Y
                Input #1, .Height
                Input #1, .Width
            End With
            LevelREAL(B) = level(B)
            Input #1, bgMusic(B)
            bgMusicREAL(B) = bgMusic(B)
            Input #1, bgColor(B)
            Input #1, LevelWrap(B)
            Input #1, OffScreenExit(B)
            Input #1, Background2(B)
            Background2REAL(B) = Background2(B)
            If FileRelease >= 1 Then
                Input #1, NoTurnBack(B)
            End If
            If FileRelease >= 30 Then
                Input #1, UnderWater(B)
            End If
            If FileRelease >= 2 Then
                Input #1, CustomMusic(B)
            End If
        Next B
        For A = 1 To 2
            With PlayerStart(A)
                Input #1, .X
                Input #1, .Y
                Input #1, .Width
                Input #1, .Height
            End With
        Next A
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            numBlock = numBlock + 1
            With Block(numBlock)
                .Location.X = newInput
                Input #1, .Location.Y
                Input #1, .Location.Height
                Input #1, .Location.Width
                Input #1, .Type
                .DefaultType = .Type
                Input #1, .Special
                If .Special = 100 Then .Special = 1009
                If .Special = 102 Then .Special = 1014
                If .Special = 103 Then .Special = 1034
                If .Special = 105 Then .Special = 1095
                .DefaultSpecial = .Special
                Input #1, .Invis
                If FileRelease >= 61 Then Input #1, .Slippy
                If FileRelease >= 10 Then
                    Input #1, .Layer
                Else
                    .Layer = "Default"
                End If
                If FileRelease >= 14 Then
                    Input #1, .TriggerDeath
                    Input #1, .TriggerHit
                    Input #1, .TriggerLast
                End If
            End With
        Loop
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            numBackground = numBackground + 1
            With Background(numBackground)
                .Location.X = newInput
                Input #1, .Location.Y
                Input #1, .Type
                If FileRelease >= 10 Then
                    Input #1, .Layer
                Else
                    .Layer = "Default"
                End If
                .Location.Width = GFXBackgroundWidth(.Type)
                .Location.Height = BackgroundHeight(.Type)
            End With
        Loop
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            numNPCs = numNPCs + 1
            With NPC(numNPCs)
                .Location.X = newInput
                Input #1, .Location.Y
                If LevelEditor = False Then .Location.Y = .Location.Y - 0.01
                Input #1, .Direction
                Input #1, .Type
                If .Type = 91 Or .Type = 96 Or .Type = 283 Or .Type = 284 Then
                    Input #1, .Special
                    .DefaultSpecial = .Special
                End If
                If .Type = 288 Or .Type = 289 Or (.Type = 91 And .Special = 288) Then
                    Input #1, .Special2
                    .DefaultSpecial2 = .Special2
                End If
                If FileRelease >= 15 Then
                    If NPCIsAParaTroopa(.Type) = True Then
                        Input #1, .Special
                        .DefaultSpecial = .Special
                    End If
                End If
                If NPCIsCheep(.Type) = True Then
                    If FileRelease >= 31 Then
                        Input #1, .Special
                    Else
                        .Special = 2
                    End If
                    .DefaultSpecial = .Special
                End If
                If .Type = 260 Then
                    Input #1, .Special
                    .DefaultSpecial = .Special
                End If
                If FileRelease >= 3 Then
                    Input #1, .Generator
                    If .Generator = True Then
                        Input #1, .GeneratorDirection
                        Input #1, .GeneratorEffect
                        Input #1, .GeneratorTimeMax
                    End If
                End If
                If FileRelease >= 5 Then
                    Input #1, .Text
                End If
                If FileRelease >= 6 Then
                    Input #1, .Inert
                    If .Type = 151 Then .Inert = True
                    Input #1, .Stuck
                    .DefaultStuck = .Stuck
                End If
                If FileRelease >= 9 Then
                    Input #1, .Legacy
                Else
                    .Legacy = True
                End If
                If FileRelease >= 10 Then
                    Input #1, .Layer
                    Input #1, .TriggerActivate
                    Input #1, .TriggerDeath
                    Input #1, .TriggerTalk
                    If FileRelease >= 14 Then Input #1, .TriggerLast
                    If FileRelease >= 63 Then Input #1, .AttLayer
                Else
                    .Layer = "Default"
                End If
                .DefaultType = .Type
                .Location.Width = NPCWidth(.Type)
                .Location.Height = NPCHeight(.Type)
                .DefaultLocation = .Location
                .DefaultDirection = .Direction
                .TimeLeft = 1
                .Active = True
                .JustActivated = 1
                CheckSectionNPC numNPCs
                If .Type = 97 Or .Type = 196 Then
                    tempBool = False
                    For B = 1 To numStars
                        If Star(B).level = FileName And (Star(B).Section = .Section Or Star(B).Section = -1) Then tempBool = True
                    Next B
                    If tempBool = True Then
                        .Special = 1
                        .DefaultSpecial = 1
                        If .Type = 196 Then .Killed = 9
                    End If
                End If
                
            End With
        Loop
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            numWarps = numWarps + 1
            With Warp(numWarps)
                .PlacedEnt = True
                .PlacedExit = True
                .Entrance.X = newInput
                Input #1, .Entrance.Y
                Input #1, .Exit.X
                Input #1, .Exit.Y
                Input #1, .Direction
                Input #1, .Direction2
                Input #1, .Effect
                If FileRelease >= 3 Then
                    Input #1, .level
                    Input #1, .LevelWarp
                    Input #1, .LevelEnt
                End If
                If FileRelease >= 4 Then
                    Input #1, .MapWarp
                    Input #1, .MapX
                    Input #1, .MapY
                End If
                If FileRelease >= 7 Then
                    Input #1, .Stars
                End If
                If FileRelease >= 12 Then
                    Input #1, .Layer
                    Input #1, .Hidden
                End If
                If FileRelease >= 23 Then Input #1, .NoYoshi
                If FileRelease >= 25 Then Input #1, .WarpNPC
                If FileRelease >= 26 Then Input #1, .Locked
                .Entrance.Height = 32
                .Entrance.Width = 32
                .Exit.Height = 32
                .Exit.Width = 32
            End With
        Loop
        If FileRelease >= 29 Then
            A = 0
            Do Until EOF(1)
                Input #1, newInput
                If newInput = "next" Then Exit Do
                numWater = numWater + 1
                With Water(numWater)
                    .Location.X = newInput
                    Input #1, .Location.Y
                    Input #1, .Location.Width
                    Input #1, .Location.Height
                    Input #1, .Buoy
                    If FileRelease >= 62 Then Input #1, .Quicksand
                    Input #1, .Layer
                End With
            Loop
        End If
        A = 0
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            Layer(A).Name = newInput
            Input #1, Layer(A).Hidden
            If Layer(A).Hidden = True Then
                HideLayer Layer(A).Name, True
            End If
            If LevelEditor = True Or MagicHand = True Then
                If LCase(Layer(A).Name) <> "default" And LCase(Layer(A).Name) <> "destroyed blocks" And LCase(Layer(A).Name) <> "spawned npcs" And Layer(A).Name <> "" Then
                    frmLayers.lstLayer.AddItem Layer(A).Name
                    If Layer(A).Hidden = False Then
                        frmLayers.lstLayer.Selected(frmLayers.lstLayer.ListCount - 1) = True
                    End If
                End If
            End If
            A = A + 1
        Loop
        A = 0
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            Events(A).Name = newInput
            If FileRelease >= 11 Then Input #1, Events(A).Text
            If FileRelease >= 14 Then Input #1, Events(A).Sound
            If FileRelease >= 18 Then Input #1, Events(A).EndGame
            For B = 0 To 20
                Input #1, Events(A).HideLayer(B)
                Input #1, Events(A).ShowLayer(B)
                If FileRelease >= 14 Then Input #1, Events(A).ToggleLayer(B)
            Next B
            If FileRelease >= 13 Then
                For B = 0 To maxSections
                    Input #1, Events(A).Music(B)
                    Input #1, Events(A).Background(B)
                    Input #1, Events(A).level(B).X
                    Input #1, Events(A).level(B).Y
                    Input #1, Events(A).level(B).Height
                    Input #1, Events(A).level(B).Width
                Next B
            End If
            If FileRelease >= 26 Then
                Input #1, Events(A).TriggerEvent
                Input #1, Events(A).TriggerDelay
            End If
            If FileRelease >= 27 Then Input #1, Events(A).LayerSmoke
            If FileRelease >= 28 Then
                Input #1, Events(A).Controls.AltJump
                Input #1, Events(A).Controls.AltRun
                Input #1, Events(A).Controls.Down
                Input #1, Events(A).Controls.Drop
                Input #1, Events(A).Controls.Jump
                Input #1, Events(A).Controls.Left
                Input #1, Events(A).Controls.Right
                Input #1, Events(A).Controls.Run
                Input #1, Events(A).Controls.Start
                Input #1, Events(A).Controls.Up
            End If
            If FileRelease >= 32 Then
                Input #1, Events(A).AutoStart
                Input #1, Events(A).MoveLayer
                Input #1, Events(A).SpeedX
                Input #1, Events(A).SpeedY
            End If
            If FileRelease >= 33 Then
                Input #1, Events(A).AutoX
                Input #1, Events(A).AutoY
                Input #1, Events(A).AutoSection
            End If
            A = A + 1
        Loop
    Close #1
    FindBlocks
    UpdateBackgrounds
    FindSBlocks
    

    
    If LevelEditor = True Or MagicHand = True Then
        frmEvents.lstEvent.ListIndex = 0
        frmLayers.lstLayer.ListIndex = 0
        frmEvents.RefreshEvents
    End If
    If LevelEditor = True Then
        ResetNPC EditorCursor.NPC.Type
        curSection = 0
        vScreenY(1) = -(level(curSection).Height - 600)
        vScreenX(1) = -level(curSection).X
        numWarps = numWarps + 1
        For A = 0 To frmLevelSettings.optBackground.Count - 1
            If Background2(0) = A Then
                frmLevelSettings.optBackground(A).Value = True
            Else
                frmLevelSettings.optBackground(A).Value = False
            End If
        Next A
        For A = 1 To frmLevelSettings.optBackgroundColor.Count
            If bgColor(0) = frmLevelSettings.optBackgroundColor(A).BackColor Then
                frmLevelSettings.optBackgroundColor(A).Value = True
                Exit For
            End If
        Next A
        frmLevelSettings.optMusic(bgMusic(0)).Value = True
        If LevelWrap(0) = True Then
            frmLevelSettings.cmdWrap.Caption = "On"
        Else
            frmLevelSettings.cmdWrap.Caption = "Off"
        End If
        If UnderWater(0) = True Then
            frmLevelSettings.cmdWater.Caption = "On"
        Else
            frmLevelSettings.cmdWater.Caption = "Off"
        End If
        If OffScreenExit(0) = True Then
            frmLevelSettings.cmdExit.Caption = "On"
        Else
            frmLevelSettings.cmdExit.Caption = "Off"
        End If
        frmLevelSettings.txtMusic.Enabled = False
        frmLevelSettings.txtMusic.Text = CustomMusic(0)
        frmLevelSettings.txtMusic.Enabled = True
        If nPlay.Online = True And nPlay.Mode = 1 Then 'sync to server
            Netplay.sendData "j" & LB & "d" & LocalNick & " has loaded " & FileName & "." & LB & "w1" & LB & EoT
            frmChat.txtChat = frmChat.txtChat & LocalNick & " has loaded " & FileName & "." & LB
            frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
            PlaySound 47
            SoundPause(47) = 2
            For A = 1 To 15
                If nPlay.ClientCon(A) = True Then
                    Netplay.InitSync A
                End If
            Next A
        End If
    Else
        FindStars
        LevelMacro = 0
        For A = 1 To maxSections
            If level(A).Height - level(A).Y = 608 Then
                level(A).Y = level(A).Y + 8
            End If
        Next A
        B = numBackground
        For A = 1 To numWarps
            If Warp(A).Effect = 2 And Warp(A).Stars > numStars Then
                B = B + 1
                numLocked = numLocked + 1
                Background(B).Layer = Warp(A).Layer
                Background(B).Hidden = Warp(A).Hidden
                Background(B).Location.Width = 24
                Background(B).Location.Height = 24
                Background(B).Location.Y = Warp(A).Entrance.Y - Background(B).Location.Height
                Background(B).Location.X = Warp(A).Entrance.X + Warp(A).Entrance.Width / 2 - Background(B).Location.Width / 2
                Background(B).Type = 160
            ElseIf Warp(A).Effect = 2 And Warp(A).Locked = True Then  'For locks
                B = B + 1
                numLocked = numLocked + 1
                Background(B).Layer = Warp(A).Layer
                Background(B).Hidden = Warp(A).Hidden
                Background(B).Location = Warp(A).Entrance
                Background(B).Type = 98
                Background(B).Location.Width = 16
            End If
        Next A
    End If
    SoundPause(13) = 100
    overTime = 0
    GoalTime = GetTickCount + 1000
    fpsCount = 0
    fpsTime = 0
    cycleCount = 0
    gameTime = 0
 End Sub
 
 Public Sub ClearLevel() 'Reset everything to zero
    Dim A As Integer
    Dim B As Integer
    Dim blankNPC As NPC
    Dim blankwater As Water
    Dim blankWarp As Warp
    Dim blankBlock As Block
    Dim BlankBackground As Background
    Dim BlankLocation As Location
    Dim blankEvent As Events
    NPCScore(274) = 6
    LevelName = ""
    LoadNPCDefaults
    noUpdate = True
    BlocksSorted = True
    qScreen = False
    UnloadCustomGFX
    For A = 1 To newEventNum
        NewEvent(A) = ""
        newEventDelay(A) = 0
    Next A
    For A = 0 To maxSections
        AutoX(A) = 0
        AutoY(A) = 0
    Next A
    newEventNum = 0
    For A = 0 To 100
        Events(A) = blankEvent
        For B = 0 To maxSections
            Events(A).Background(B) = -1
            Events(A).Music(B) = -1
            Events(A).level(B).X = -1
        Next B
    Next A
    For A = 0 To maxWater
        Water(A) = blankwater
    Next A
    numWater = 0
    Events(0).Name = "Level - Start"
    Events(1).Name = "P Switch - Start"
    Events(2).Name = "P Switch - End"
    curMusic = 0
    curStars = 0
    maxStars = 0
    PSwitchTime = 0
    PSwitchStop = 0
    BeltDirection = 1
    StopMusic
    Layer(0).Name = "Default"
    Layer(0).Hidden = False
    Layer(1).Name = "Destroyed Blocks"
    Layer(1).Hidden = True
    Layer(2).Name = "Spawned NPCs"
    Layer(2).Hidden = False
    For A = 0 To 100
        If A > 2 Then
            Layer(A).Name = ""
            Layer(A).Hidden = False
        End If
        Layer(A).SpeedX = 0
        Layer(A).SpeedY = 0
    Next A
    If LevelEditor = True Or MagicHand = True Then
        MessageText = ""
        frmNPCs.chkMessage.Value = 0
        frmBlocks.chkFill.Value = 0
        frmEvents.txtEvent.Text = ""
        noUpdate = True
        frmEvents.RefreshEvents
        frmLayers.lstLayer.Clear
        frmLayers.lstLayer.AddItem "Default"
        frmLayers.lstLayer.AddItem "Destroyed Blocks"
        frmLayers.lstLayer.AddItem "Spawned NPCs"
        frmLayers.lstLayer.Selected(1) = False
        frmLayers.lstLayer.Selected(2) = True
        frmLayers.lstLayer.Selected(0) = True
        frmLayers.cmdDelete.Enabled = False
        frmLayers.txtLayer.Enabled = False
        frmLevelEditor.optCursor(13).Value = True
    End If
    For A = -128 To maxNPCs
        NPC(A) = blankNPC
    Next A
    numNPCs = 0
    For A = 1 To maxBlocks
        Block(A) = blankBlock
    Next A
    numBlock = 0
    For A = 1 To maxBackgrounds
        Background(A) = BlankBackground
    Next A
    For A = 0 To maxSections
        Background2(A) = 0
        bgColor(A) = &HF89868
        bgMusic(A) = 0
        level(A) = BlankLocation
        LevelWrap(A) = False
        LevelChop(A) = 0
        NoTurnBack(A) = False
        UnderWater(A) = False
        OffScreenExit(A) = False
        CustomMusic(A) = ""
    Next A
    For A = 1 To numWarps
        Warp(A) = blankWarp
    Next A
    numEffects = 0
    numBackground = 0
    PlayerStart(1) = BlankLocation
    PlayerStart(2) = BlankLocation
    If LevelEditor = True Then
        Unload frmLevelAdv
        noUpdate = True
        numPlayers = 0
        frmLevelSettings.txtMusic.Enabled = False
        frmLevelSettings.txtMusic.Text = ""
        frmLevelSettings.txtMusic.Enabled = True
        frmLevelSettings.optBackgroundColor(1).Value = 1
        frmLevelSettings.cmdWrap.Caption = "Off"
        frmLevelSettings.optMusic(bgMusic(0)).Value = True
        vScreenX(1) = 0
        vScreenY(1) = 0
        curSection = 0
        level(curSection).Height = 20000 * (curSection - maxSections / 2)
        level(curSection).Height = Int(level(curSection).Height / 32) * 32
        level(curSection).Y = level(curSection).Height - 600
        level(curSection).X = 20000 * (curSection - maxSections / 2)
        level(curSection).X = Int(level(curSection).X / 32) * 32
        level(curSection).Width = level(curSection).X + 800
        vScreenY(1) = -(level(curSection).Height - 600)
        vScreenX(1) = -level(curSection).X
        numWarps = 1
        frmLevelSettings.optSection(0).Value = True
        frmLevelSettings.optBackground(0).Value = True
        frmLevelSettings.optLevel(0).Value = True
        For A = 1 To frmLevelSettings.optBackground.Count - 1
            frmLevelSettings.optBackground(A).Value = False
        Next A
    End If
    noUpdate = False
End Sub
 
 Public Sub NextLevel()
    Dim A As Integer
    For A = 1 To numPlayers
        Player(A).HoldingNPC = 0
    Next A
    LevelMacro = 0
    LevelMacroCounter = 0
    StopMusic
    ClearLevel
    BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
    BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
    DoEvents
    If TestLevel = False And GoToLevel = "" And NoMap = False Then
        Sleep 500
    End If
    If BattleMode = True And LevelEditor = False Then
        EndLevel = False
        GameMenu = True
        MenuMode = 4
        MenuCursor = selWorld - 1
        PlayerCharacter = Player(1).Character
        PlayerCharacter2 = Player(2).Character
    Else
        LevelSelect = True
        EndLevel = False
    End If
 End Sub
 
 Public Sub UpdateMacro() 'macros mainly used for end of level stuffs. takes over the players controls
    Dim A As Integer
    Dim OnScreen As Boolean
    If LevelMacro = 1 Then 'SMB3 Exit
        For A = 1 To numPlayers
            With Player(A)
                If .Location.X < level(.Section).Width And .Dead = False Then
                    OnScreen = True
                    With .Controls
                        .Down = False
                        .Drop = False
                        .Jump = False
                        .Left = False
                        .Right = True
                        .Run = False
                        .Up = False
                        .Start = False
                        .AltJump = False
                        .AltRun = False
                    End With
                    If .Wet > 0 And .CanJump = True Then
                        If .Location.SpeedY > 1 Then .Controls.Jump = True
                    End If
                Else
                    .Location.SpeedY = -Physics.PlayerGravity
                    With .Controls
                        .Down = False
                        .Drop = False
                        .Jump = False
                        .Left = False
                        .Right = True
                        .Run = False
                        .Up = False
                        .Start = False
                        .AltJump = False
                        .AltRun = False
                    End With
                End If
            End With
        Next A
        If OnScreen = False Then
            LevelMacroCounter = LevelMacroCounter + 1
            If LevelMacroCounter >= 100 Then
                LevelBeatCode = 1
                LevelMacro = 0
                LevelMacroCounter = 0
                EndLevel = True
            End If
        End If
    ElseIf LevelMacro = 2 Then
        For A = 1 To numPlayers
            With Player(A).Controls
                .Down = False
                .Drop = False
                .Jump = False
                .Left = False
                .Right = False
                .Run = False
                .Up = False
                .Start = False
                .AltJump = False
                .AltRun = False
            End With
        Next A
        LevelMacroCounter = LevelMacroCounter + 1
        If LevelMacroCounter >= 460 Then
            LevelBeatCode = 2
            EndLevel = True
            LevelMacro = 0
            LevelMacroCounter = 0
            BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
            BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
        End If
    ElseIf LevelMacro = 3 Then
        Dim tempTime As Single
        Dim gameTime As Single
    Do
        tempTime = Timer - Int(Timer)
        If tempTime > gameTime + 0.01 Or tempTime < gameTime Then
            gameTime = tempTime
            DoEvents
            UpdateGraphics
            UpdateSound
            BlockFrames
            LevelMacroCounter = LevelMacroCounter + 1
            If LevelMacroCounter >= 300 Then Exit Do
        End If
    Loop
        LevelBeatCode = 4
        EndLevel = True
        LevelMacro = 0
        LevelMacroCounter = 0
        BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
        BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
    ElseIf LevelMacro = 4 Then
        For A = 1 To numPlayers
            With Player(A).Controls
                .Down = False
                .Drop = False
                .Jump = False
                .Left = False
                .Right = False
                .Run = False
                .Up = False
                .Start = False
                .AltJump = False
                .AltRun = False
            End With
        Next A
        LevelMacroCounter = LevelMacroCounter + 1
        If LevelMacroCounter >= 300 Then
            LevelBeatCode = 5
            EndLevel = True
            LevelMacro = 0
            LevelMacroCounter = 0
            BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
            BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
        End If
    ElseIf LevelMacro = 5 Then
        'numNPCs = 0
        For A = 1 To numPlayers
            With Player(A).Controls
                .Down = False
                .Drop = False
                .Jump = False
                .Left = False
                .Right = False
                .Run = False
                .Up = False
                .Start = False
                .AltJump = False
                .AltRun = False
            End With
        Next A
        LevelMacroCounter = LevelMacroCounter + 1
        If LevelMacroCounter = 250 Then
            PlaySound 45
        End If
        If LevelMacroCounter >= 800 Then
            EndLevel = True
            LevelMacro = 0
            LevelMacroCounter = 0
            If TestLevel = False Then
                GameOutro = True
                BeatTheGame = True
                SaveGame
                MenuMode = 0
                MenuCursor = 0
            End If
            BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
            BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
        End If
    ElseIf LevelMacro = 6 Then 'Star Exit
        For A = 1 To numPlayers
            With Player(A).Controls
                .Down = False
                .Drop = False
                .Jump = False
                .Left = False
                .Right = False
                .Run = False
                .Up = False
                .Start = False
                .AltJump = False
                .AltRun = False
            End With
        Next A
        LevelMacroCounter = LevelMacroCounter + 1
        If LevelMacroCounter >= 300 Then
            LevelBeatCode = 7
            LevelMacro = 0
            LevelMacroCounter = 0
            EndLevel = True
        End If
    ElseIf LevelMacro = 7 Then 'SMW Exit
        For A = 1 To numPlayers
            With Player(A)
                If .Location.X < level(.Section).Width And .Dead = False Then
                    With .Controls
                        .Down = False
                        .Drop = False
                        .Jump = False
                        .Left = False
                        .Right = True
                        .Run = False
                        .Up = False
                        .Start = False
                        .AltJump = False
                        .AltRun = False
                    End With
                Else
                    .Location.SpeedY = -Physics.PlayerGravity
                    With .Controls
                        .Down = False
                        .Drop = False
                        .Jump = False
                        .Left = False
                        .Right = True
                        .Run = False
                        .Up = False
                        .Start = False
                        .AltJump = False
                        .AltRun = False
                    End With
                End If
            End With
        Next A
        LevelMacroCounter = LevelMacroCounter + 1
        If LevelMacroCounter >= 630 Then
            LevelBeatCode = 8
            LevelMacro = 0
            LevelMacroCounter = 0
            EndLevel = True
        End If
    End If
 End Sub
 
 
Public Sub SaveWorld(FilePath As String)   'Saves the world!
    Dim A As Integer
    Dim B As Integer
    For A = Len(FilePath) To 1 Step -1
        If Mid(FilePath, A, 1) = "/" Or Mid(FilePath, A, 1) = "\" Then Exit For
    Next A
    FileName = Right(FilePath, (Len(FilePath) - A))
    FileNamePath = Left(FilePath, (A))
    WorldName = frmWorld.txtWorldName
    StartLevel = frmWorld.txtStartLevel
    NoMap = frmWorld.chkNoMap.Value
    RestartLevel = frmWorld.chkRestartLevel.Value
    UnloadWorldCustomGFX
    LoadWorldCustomGFX
    For A = 1 To 5
        WorldCredits(A) = frmWorld.txtCredits(A)
    Next A
    Open FilePath For Output As #1
        Write #1, curRelease
        Write #1, WorldName
        For A = 1 To 5
            Write #1, blockCharacter(A)
        Next A
        Write #1, StartLevel
        Write #1, NoMap
        Write #1, RestartLevel
        Write #1, MaxWorldStars
        For A = 1 To 5
            Write #1, WorldCredits(A)
        Next A
        For A = 1 To numTiles
            With Tile(A)
                Write #1, .Location.X
                Write #1, .Location.Y
                Write #1, .Type
            End With
        Next A
        Write #1, "next"
        For A = 1 To numScenes
            With Scene(A)
                Write #1, .Location.X
                Write #1, .Location.Y
                Write #1, .Type
            End With
        Next A
        Write #1, "next"
        For A = 1 To numWorldPaths
            With WorldPath(A)
                Write #1, .Location.X
                Write #1, .Location.Y
                Write #1, .Type
            End With
        Next A
        Write #1, "next"
        For A = 1 To numWorldLevels
            With WorldLevel(A)
                Write #1, .Location.X
                Write #1, .Location.Y
                Write #1, .Type
                Write #1, .FileName
                Write #1, .LevelName
                For B = 1 To 4
                    Write #1, .LevelExit(B)
                Next B
                Write #1, .StartWarp
                Write #1, .Visible
                Write #1, .Path
                Write #1, .Start
                Write #1, .WarpX
                Write #1, .WarpY
                Write #1, .Path2
            End With
        Next A
        Write #1, "next"
        For A = 1 To numWorldMusic
            With WorldMusic(A)
                Write #1, .Location.X
                Write #1, .Location.Y
                Write #1, .Type
            End With
        Next A
        Write #1, "next"
    Close #1
    UnloadCustomGFX
    LoadCustomGFX
    PlaySound 12
End Sub

Public Sub OpenWorld(FilePath As String)   'loads the world
    Dim newInput As String
    Dim FileRelease As Integer
    Dim A As Integer
    Dim B As Integer
    ClearWorld
    For A = Len(FilePath) To 1 Step -1
        If Mid(FilePath, A, 1) = "/" Or Mid(FilePath, A, 1) = "\" Then Exit For
    Next A
    FileName = Right(FilePath, (Len(FilePath) - A))
    FileNamePath = Left(FilePath, (A))
    LoadWorldCustomGFX
    numTiles = 0
    numScenes = 0
    numWorldLevels = 0
    numWorldPaths = 0
    numWorldMusic = 0
    Open FilePath For Input As #1
        Input #1, FileRelease
        If FileRelease > curRelease Then
            MsgBox "You are using an old version of SMBX that is incompatible with this file. Please visit www.SuperMarioBrothers.org to get the latest updates.", vbCritical, "Please click OK so the game can crash."
            KillIt
        End If
        Input #1, WorldName
        If FileRelease >= 55 Then
            Input #1, blockCharacter(1)
            Input #1, blockCharacter(2)
            Input #1, blockCharacter(3)
            Input #1, blockCharacter(4)
        End If
        If FileRelease >= 56 Then
            Input #1, blockCharacter(5)
        End If
        If FileRelease >= 3 Then
            Input #1, StartLevel
            Input #1, NoMap
            Input #1, RestartLevel
        End If
        If FileRelease >= 20 Then
            Input #1, MaxWorldStars
        End If
        If FileRelease >= 17 Then
            For A = 1 To 5
                Input #1, WorldCredits(A)
            Next A
        End If
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            numTiles = numTiles + 1
            With Tile(numTiles)
                .Location.X = newInput
                Input #1, .Location.Y
                Input #1, .Type
                .Location.Width = TileWidth(.Type)
                .Location.Height = TileHeight(.Type)
            End With
        Loop
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            numScenes = numScenes + 1
            With Scene(numScenes)
                .Location.X = newInput
                Input #1, .Location.Y
                Input #1, .Type
                .Location.Width = SceneWidth(.Type)
                .Location.Height = SceneHeight(.Type)
                .Active = True
            End With
        Loop
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            numWorldPaths = numWorldPaths + 1
            With WorldPath(numWorldPaths)
                .Location.X = newInput
                Input #1, .Location.Y
                Input #1, .Type
                .Location.Width = 32
                .Location.Height = 32
                If LevelEditor = True Then .Active = True
            End With
        Loop
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            numWorldLevels = numWorldLevels + 1
            With WorldLevel(numWorldLevels)
                .Location.X = newInput
                Input #1, .Location.Y
                Input #1, .Type
                Input #1, .FileName
                Input #1, .LevelName
                For B = 1 To 4
                    Input #1, .LevelExit(B)
                Next B
                If FileRelease >= 4 Then
                    Input #1, .StartWarp
                End If
                .Location.Width = 32
                .Location.Height = 32
                If FileRelease >= 21 Then
                    Input #1, .Visible
                    Input #1, .Path
                    Input #1, .Start
                    Input #1, .WarpX
                    Input #1, .WarpY
                Else
                    .Path = True
                    .WarpX = -1
                    .WarpY = -1
                End If
                If FileRelease >= 22 Then Input #1, .Path2
                If LevelEditor = True Or .Visible = True Then .Active = True
            End With
        Loop
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            numWorldMusic = numWorldMusic + 1
            With WorldMusic(numWorldMusic)
                .Location.X = newInput
                Input #1, .Location.Y
                Input #1, .Type
                If LevelEditor = True Then
                    .Location.Width = 32
                    .Location.Height = 32
                Else
                    .Location.Width = 30
                    .Location.Height = 30
                    .Location.Y = .Location.Y + 1
                    .Location.X = .Location.X + 1
                End If
            End With
        Loop
    Close #1
    LoadCustomGFX
    If LevelEditor = False Then
        For A = 1 To numWorldLevels
            If (FileRelease <= 20 And WorldLevel(A).Type = 1) Or (FileRelease > 20 And WorldLevel(A).Start = True) Then
                WorldPlayer(1).Type = 1
                WorldPlayer(1).Location = WorldLevel(A).Location
                Exit For
            End If
        Next A
        For A = 1 To numWorldLevels
            With WorldLevel(A)
                If (FileRelease <= 20 And WorldLevel(A).Type = 1) Or (FileRelease > 20 And WorldLevel(A).Start = True) Then
                    .Active = True
                    LevelPath A, 5, True
                End If
            End With
        Next A
    Else
        For A = 1 To numCharacters
            If blockCharacter(A) = True Then
                frmWorld.chkChar(A).Value = 1
            Else
                frmWorld.chkChar(A).Value = 0
            End If
        Next A
        frmWorld.txtWorldName = WorldName
        frmWorld.txtStartLevel = StartLevel
        If NoMap = True Then
            frmWorld.chkNoMap.Value = 1
        Else
            frmWorld.chkNoMap.Value = 0
        End If
        If RestartLevel = True Then
            frmWorld.chkRestartLevel.Value = 1
        Else
            frmWorld.chkRestartLevel.Value = 0
        End If
        For A = 1 To 5
            frmWorld.txtCredits(A).Text = WorldCredits(A)
        Next A
        frmWorld.txtStars = MaxWorldStars
    End If
    overTime = 0
    GoalTime = GetTickCount + 1000
    fpsCount = 0
    fpsTime = 0
    cycleCount = 0
    gameTime = 0
 End Sub
 
 Public Sub WorldLoop() 'Loop for world select
    Dim tempLocation As Location
    Dim A As Integer
    Dim B As Integer
    If SingleCoop > 0 Then SingleCoop = 1
    With WorldPlayer(1)
        vScreenX(1) = -(.Location.X + .Location.Width / 2) + vScreen(1).Width / 2
        vScreenY(1) = -(.Location.Y + .Location.Height / 2) + vScreen(1).Height / 2 + 32
    End With
    If numPlayers > 2 Then numPlayers = 1
    For B = 1 To numPlayers
        If Player(B).Mount = 2 Then Player(B).Mount = 0
    Next B
    UpdateGraphics2
    UpdateControls
    UpdateSound
    If curWorldLevel > 0 Then
        If LevelBeatCode > 0 Then
            For A = 1 To numWorldMusic
                If CheckCollision(WorldPlayer(1).Location, WorldMusic(A).Location) Then
                    If curWorldMusic <> WorldMusic(A).Type Then StartMusic WorldMusic(A).Type
                End If
            Next A
            With WorldLevel(curWorldLevel)
                For A = 1 To 4
                    If .LevelExit(A) = LevelBeatCode Or .LevelExit(A) = -1 Then
                        WorldPlayer(1).LevelName = .LevelName
                        LevelPath curWorldLevel, A
                    End If
                Next A
            End With
            SaveGame
            LevelBeatCode = 0
        ElseIf LevelBeatCode = -1 Then
            For A = 1 To numWorldMusic
                If CheckCollision(WorldPlayer(1).Location, WorldMusic(A).Location) Then
                    If curWorldMusic <> WorldMusic(A).Type Then StartMusic WorldMusic(A).Type
                End If
            Next A
            For A = 1 To numWorldLevels
                If CheckCollision(WorldPlayer(1).Location, WorldLevel(A).Location) Then
                    curWorldLevel = A
                    WorldPlayer(1).LevelName = WorldLevel(A).LevelName
                    Exit For
                End If
            Next A
            If curWorldLevel > 0 Then
                LevelPath curWorldLevel, 5
            End If
            SaveGame
            LevelBeatCode = 0
        End If
    Else
        LevelBeatCode = 0
    End If
    For A = 1 To numPlayers
        With Player(A)
            .Bumped = False
            .Bumped2 = 0
            .CanFly = False
            .CanFly2 = False
            .Effect = 0
            .Effect2 = 0
            .FlyCount = 0
            .TailCount = 0
            .Stoned = False
        End With
    Next A
    With WorldPlayer(1)
    
        If .Move > 0 Then
            .Frame2 = .Frame2 + 1
            If .Frame2 >= 8 Then
                .Frame2 = 0
                .Frame = .Frame + 1
            End If
            If .Move = 1 Then
                If .Frame < 6 Then .Frame = 7
                If .Frame > 7 Then .Frame = 6
            End If
            If .Move = 4 Then
                If .Frame < 2 Then .Frame = 3
                If .Frame > 3 Then .Frame = 2
            End If
            If .Move = 3 Then
                If .Frame < 0 Then .Frame = 1
                If .Frame > 1 Then .Frame = 0
            End If
            If .Move = 2 Then
                If .Frame < 4 Then .Frame = 5
                If .Frame > 5 Then .Frame = 4
            End If
        End If
    
    
        If .Move = 0 Then
            tempLocation = WorldPlayer(1).Location
            tempLocation.Width = tempLocation.Width - 8
            tempLocation.Height = tempLocation.Height - 8
            tempLocation.X = tempLocation.X + 4
            tempLocation.Y = tempLocation.Y + 4
            .LevelName = ""
            For A = 1 To numWorldLevels
                If CheckCollision(tempLocation, WorldLevel(A).Location) = True Then
                    .LevelName = WorldLevel(A).LevelName
                    Exit For
                End If
            Next A
            With Player(1).Controls
                If .Start = True Or (GetKeyState(vbKeyEscape) And KEY_PRESSED) Then
                    If Player(1).UnStart = True Then PauseGame 1
                End If
                If .Up = True Then
                    tempLocation.Y = tempLocation.Y - 32
                    For A = 1 To numWorldPaths
                        If CheckCollision(tempLocation, WorldPath(A).Location) = True And WorldPath(A).Active = True Then
                            WorldPlayer(1).Move = 1
                            Exit For
                        End If
                    Next A
                    For A = 1 To numWorldLevels
                        If WorldPlayer(1).Move = 0 Then
                            If CheckCollision(tempLocation, WorldLevel(A).Location) = True And WorldLevel(A).Active = True Then
                                WorldPlayer(1).Move = 1
                                Exit For
                            End If
                        End If
                    Next A
                    If WalkAnywhere = True Then WorldPlayer(1).Move = 1
                    If WorldPlayer(1).Move = 0 Then
                        WorldPlayer(1).Move3 = False
                        PlaySound 3
                        SoundPause(3) = 2
                    End If
                ElseIf .Left = True Then
                    tempLocation.X = tempLocation.X - 32
                    For A = 1 To numWorldPaths
                        If CheckCollision(tempLocation, WorldPath(A).Location) = True And WorldPath(A).Active = True Then
                            WorldPlayer(1).Move = 2
                            Exit For
                        End If
                    Next A
                    For A = 1 To numWorldLevels
                        If WorldPlayer(1).Move = 0 Then
                            If CheckCollision(tempLocation, WorldLevel(A).Location) = True And WorldLevel(A).Active = True Then
                                WorldPlayer(1).Move = 2
                                Exit For
                            End If
                        End If
                    Next A
                    If WalkAnywhere = True Then WorldPlayer(1).Move = 2
                    If WorldPlayer(1).Move = 0 Then
                        WorldPlayer(1).Move3 = False
                        PlaySound 3
                        SoundPause(3) = 2
                    End If
                ElseIf .Down = True Then
                    tempLocation.Y = tempLocation.Y + 32
                    For A = 1 To numWorldPaths
                        If CheckCollision(tempLocation, WorldPath(A).Location) = True And WorldPath(A).Active = True Then
                            WorldPlayer(1).Move = 3
                            Exit For
                        End If
                    Next A
                    For A = 1 To numWorldLevels
                        If WorldPlayer(1).Move = 0 Then
                            If CheckCollision(tempLocation, WorldLevel(A).Location) = True And WorldLevel(A).Active = True Then
                                WorldPlayer(1).Move = 3
                                Exit For
                            End If
                        End If
                    Next A
                    If WalkAnywhere = True Then WorldPlayer(1).Move = 3
                    If WorldPlayer(1).Move = 0 Then
                        WorldPlayer(1).Move3 = False
                        PlaySound 3
                        SoundPause(3) = 2
                    End If
                ElseIf .Right = True Then
                    tempLocation.X = tempLocation.X + 32
                    For A = 1 To numWorldPaths
                        If CheckCollision(tempLocation, WorldPath(A).Location) = True And WorldPath(A).Active = True Then
                            WorldPlayer(1).Move = 4
                            Exit For
                        End If
                    Next A
                    For A = 1 To numWorldLevels
                        If WorldPlayer(1).Move = 0 Then
                            If CheckCollision(tempLocation, WorldLevel(A).Location) = True And WorldLevel(A).Active = True Then
                                WorldPlayer(1).Move = 4
                                Exit For
                            End If
                        End If
                    Next A
                    If WalkAnywhere = True Then WorldPlayer(1).Move = 4
                    If WorldPlayer(1).Move = 0 Then
                        WorldPlayer(1).Move3 = False
                        PlaySound 3
                        SoundPause(3) = 2
                    End If
                ElseIf .Jump = True And Player(1).UnStart = True Then
                    For A = 1 To numWorldLevels
                        If CheckCollision(tempLocation, WorldLevel(A).Location) = True Then
                            If WorldLevel(A).WarpX <> -1 Then
                                WorldPlayer(1).Location.X = WorldLevel(A).WarpX
                            End If
                            If WorldLevel(A).WarpY <> -1 Then
                                WorldPlayer(1).Location.Y = WorldLevel(A).WarpY
                            End If
                            If WorldLevel(A).WarpY <> -1 Or WorldLevel(A).WarpX <> -1 Then
                                LevelBeatCode = 6
                                For B = 1 To numWorldLevels
                                    If CheckCollision(WorldPlayer(1).Location, WorldLevel(B).Location) = True Then
                                        WorldLevel(B).Active = True
                                        curWorldLevel = B
                                    End If
                                Next B
                            End If
                            If WorldLevel(A).FileName <> "" And WorldLevel(A).FileName <> ".lvl" Then
                                If Dir(SelectWorld(selWorld).WorldPath & WorldLevel(A).FileName) <> "" Then
                                    StartWarp = WorldLevel(A).StartWarp
                                    StopMusic
                                    PlaySound 28
                                    SoundPause(26) = 200
                                    curWorldLevel = A
                                    LevelSelect = False
                                    GameThing
                                    ClearLevel
                                    Sleep 1000
                                    OpenLevel SelectWorld(selWorld).WorldPath & WorldLevel(A).FileName
                                    Exit For
                                End If
                            ElseIf WorldLevel(A).WarpX <> -1 Or WorldLevel(A).WarpY <> -1 Then
                                StopMusic
                                PlaySound 28
                                BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
                                BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
                                DoEvents
                                Sleep 1000
                                
                                
                                
                                overTime = 0
                                GoalTime = GetTickCount + 1000
                                fpsCount = 0
                                fpsTime = 0
                                cycleCount = 0
                                gameTime = 0
                                
                            End If
                        End If
                    Next A
                Else
                    If WorldPlayer(1).Frame = 5 Then WorldPlayer(1).Frame = 4
                    If WorldPlayer(1).Frame = 3 Then WorldPlayer(1).Frame = 2
                End If
            End With
            If .Move3 = True And .Move = 0 Then
                .Move3 = False
                PlaySound 26
            End If
            For A = 1 To numWorldMusic
                If CheckCollision(.Location, WorldMusic(A).Location) Then
                    If curWorldMusic <> WorldMusic(A).Type Then StartMusic WorldMusic(A).Type
                End If
            Next A
        ElseIf .Move = 1 Then
            .Move2 = .Move2 + 2
            .Location.Y = .Location.Y - 2
            If WalkAnywhere = True Then
                .Move2 = .Move2 + 2
                .Location.Y = .Location.Y - 2
            End If
            If .Move2 >= 32 Then
                .Move2 = 0
                .Move = 0
                .Move3 = True
            End If
        ElseIf .Move = 2 Then
            .Move2 = .Move2 + 2
            .Location.X = .Location.X - 2
            If WalkAnywhere = True Then
                .Move2 = .Move2 + 2
                .Location.X = .Location.X - 2
            End If
            If .Move2 >= 32 Then
                .Move2 = 0
                .Move = 0
                .Move3 = True
            End If
        ElseIf .Move = 3 Then
            .Move2 = .Move2 + 2
            .Location.Y = .Location.Y + 2
            If WalkAnywhere = True Then
                .Move2 = .Move2 + 2
                .Location.Y = .Location.Y + 2
            End If
            If .Move2 >= 32 Then
                .Move2 = 0
                .Move = 0
                .Move3 = True
            End If
        ElseIf .Move = 4 Then
            .Move2 = .Move2 + 2
            .Location.X = .Location.X + 2
            If WalkAnywhere = True Then
                .Move2 = .Move2 + 2
                .Location.X = .Location.X + 2
            End If
            If .Move2 >= 32 Then
                .Move2 = 0
                .Move = 0
                .Move3 = True
            End If
        End If
    End With
End Sub

Public Sub LevelPath(Lvl As Integer, Direction As Integer, Optional Skp As Boolean = False)
    Dim tempLocation As Location
    Dim A As Integer
    With WorldLevel(Lvl)
        If Direction = 1 Or Direction = 5 Then
            tempLocation = .Location
            With tempLocation
                .X = .X + 4
                .Y = .Y + 4
                .Width = .Width - 8
                .Height = .Height - 8
                .Y = .Y - 32
                For A = 1 To numWorldPaths
                    If WorldPath(A).Active = False Then
                        If CheckCollision(tempLocation, WorldPath(A).Location) = True Then
                            PathPath A, Skp
                        End If
                    End If
                Next A
            End With
        End If
        If Direction = 2 Or Direction = 5 Then
            tempLocation = .Location
            With tempLocation
                .X = .X + 4
                .Y = .Y + 4
                .Width = .Width - 8
                .Height = .Height - 8
                .X = .X - 32
                For A = 1 To numWorldPaths
                    If WorldPath(A).Active = False Then
                        If CheckCollision(tempLocation, WorldPath(A).Location) = True Then
                            PathPath A, Skp
                        End If
                    End If
                Next A
            End With
        End If
        If Direction = 3 Or Direction = 5 Then
            tempLocation = .Location
            With tempLocation
                .X = .X + 4
                .Y = .Y + 4
                .Width = .Width - 8
                .Height = .Height - 8
                .Y = .Y + 32
                For A = 1 To numWorldPaths
                    If WorldPath(A).Active = False Then
                        If CheckCollision(tempLocation, WorldPath(A).Location) = True Then
                            PathPath A, Skp
                        End If
                    End If
                Next A
            End With
        End If
        If Direction = 4 Or Direction = 5 Then
            tempLocation = .Location
            With tempLocation
                .X = .X + 4
                .Y = .Y + 4
                .Width = .Width - 8
                .Height = .Height - 8
                .X = .X + 32
                For A = 1 To numWorldPaths
                    If WorldPath(A).Active = False Then
                        If CheckCollision(tempLocation, WorldPath(A).Location) = True Then
                            PathPath A, Skp
                        End If
                    End If
                Next A
            End With
        End If
    End With
End Sub

Public Sub PathPath(Pth As Integer, Optional Skp As Boolean = False)
    Dim A As Integer
    Dim B As Integer
    Dim tempLocation As Location
    tempLocation = WorldPath(Pth).Location
    With tempLocation
        .X = .X + 4
        .Y = .Y + 4
        .Width = .Width - 8
        .Height = .Height - 8
        For A = 1 To numScenes
            If Scene(A).Active = True Then
                If CheckCollision(tempLocation, Scene(A).Location) = True Then
                    Scene(A).Active = False
                End If
            End If
        Next A
        If WorldPath(Pth).Active = False And Skp = False Then
            WorldPath(Pth).Active = True
            vScreenX(1) = -(WorldPath(Pth).Location.X + WorldPath(Pth).Location.Width / 2) + vScreen(1).Width / 2
            vScreenY(1) = -(WorldPath(Pth).Location.Y + WorldPath(Pth).Location.Height / 2) + vScreen(1).Height / 2
            PlaySound 27
            PathWait
        End If
        WorldPath(Pth).Active = True
        For B = 1 To 4
            If B = 1 Then
                .Y = .Y - 32
            ElseIf B = 2 Then
                .Y = .Y + 32
                .X = .X - 32
            ElseIf B = 3 Then
                .X = .X + 32
                .Y = .Y + 32
            ElseIf B = 4 Then
                .Y = .Y - 32
                .X = .X + 32
            End If
            For A = 1 To numWorldPaths
                If WorldPath(A).Active = False Then
                    If CheckCollision(tempLocation, WorldPath(A).Location) = True Then
                        PathPath A, Skp
                    End If
                End If
            Next A
            For A = 1 To numWorldLevels
                If WorldLevel(A).Active = False Then
                    If CheckCollision(tempLocation, WorldLevel(A).Location) = True Then
                        WorldLevel(A).Active = True
                        If Skp = False Then
                            vScreenX(1) = -(WorldLevel(A).Location.X + WorldLevel(A).Location.Width / 2) + vScreen(1).Width / 2
                            vScreenY(1) = -(WorldLevel(A).Location.Y + WorldLevel(A).Location.Height / 2) + vScreen(1).Height / 2
                            PlaySound 27
                            PathWait
                        End If
                    End If
                End If
            Next A
        Next B
    End With
End Sub

Public Sub PathWait()
    Dim C As Integer
    overTime = 0
    GoalTime = GetTickCount + 1000
    fpsCount = 0
    cycleCount = 0
    gameTime = 0
    fpsTime = 0
    
    Do
        DoEvents
        tempTime = GetTickCount
        If tempTime >= gameTime + frameRate Or tempTime < gameTime Or MaxFPS = True Then
            UpdateGraphics2
            UpdateSound
            C = C + 1
            If fpsCount >= 32000 Then fpsCount = 0 'Fixes Overflow bug
            If cycleCount >= 32000 Then cycleCount = 0 'Fixes Overflow bug
            overTime = overTime + (tempTime - (gameTime + frameRate))
            If gameTime = 0 Then overTime = 0
            If overTime <= 1 Then
                overTime = 0
            ElseIf overTime > 1000 Then
                overTime = 1000
            End If
            gameTime = tempTime - overTime
            overTime = (overTime - (tempTime - gameTime))
            DoEvents
            If GetTickCount > fpsTime Then
                If cycleCount >= 65 Then
                    overTime = 0
                    gameTime = tempTime
                End If
                cycleCount = 0
                fpsTime = GetTickCount + 1000
                GoalTime = fpsTime
                If Debugger = True Then frmLevelDebugger.lblFPS = fpsCount
                If ShowFPS = True Then
                    PrintFPS = fpsCount
                End If
                fpsCount = 0
            End If
        End If
    Loop Until C >= 24
    overTime = 0
    GoalTime = GetTickCount + 1000
    fpsCount = 0
    cycleCount = 0
    gameTime = 0
    fpsTime = 0
End Sub

Public Sub ClearWorld()
    Dim blankTile As Tile
    Dim blankPath As WorldPath
    Dim blankScene As Scene
    Dim blankLevel As WorldLevel
    Dim blankMusic As WorldMusic
    Dim A As Integer
    For A = 1 To numCharacters
        blockCharacter(A) = False
        If LevelEditor = True Then frmWorld.chkChar(A).Value = 0
    Next A
    For A = 1 To numTiles
        Tile(A) = blankTile
    Next A
    For A = 1 To numWorldPaths
        WorldPath(A) = blankPath
    Next A
    For A = 1 To numScenes
        Scene(A) = blankScene
    Next A
    For A = 1 To numWorldLevels
        WorldLevel(A) = blankLevel
    Next A
    For A = 1 To numWorldMusic
        WorldMusic(A) = blankMusic
    Next A
    MaxWorldStars = 0
    numTiles = 0
    numWorldPaths = 0
    numScenes = 0
    numWorldLevels = 0
    numWorldPaths = 0
    numWorldMusic = 0
    RestartLevel = False
    NoMap = False
    StartLevel = ""
    BeatTheGame = False
    For A = 1 To 5
        WorldCredits(A) = ""
    Next A
    UnloadCustomGFX
    UnloadWorldCustomGFX
    If LevelEditor = True Then
        frmLevelEditor.optCursor(14).Value = True
        frmWorld.txtWorldName = ""
        frmWorld.txtStartLevel = ""
        frmWorld.chkNoMap.Value = False
        frmWorld.chkRestartLevel = False
        vScreenX(1) = 0
        vScreenY(1) = 0
        For A = 1 To 5
            frmWorld.txtCredits(A).Text = ""
        Next A
        frmWorld.txtStars = ""
        MaxWorldStars = 0
    End If
End Sub

Public Sub FindWorlds()
    Dim A As Integer
    Dim DirName(1 To 128) As String
    Dim FileName As String
    Dim numDirs As Integer
    Dim FileRelease As Integer
    NumSelectWorld = 0
    DirName(1) = Dir(App.Path & "\worlds\", vbDirectory)
    numDirs = numDirs + 1
    Do Until DirName(numDirs) = ""
        If Not (DirName(numDirs) = "." Or DirName(numDirs) = "..") Then
            If (GetAttr(App.Path & "\worlds\" & DirName(numDirs)) And vbDirectory) = vbDirectory Then
                numDirs = numDirs + 1
            End If
        End If
        DirName(numDirs) = Dir
    Loop
    numDirs = numDirs - 1
    For A = 1 To numDirs
        FileName = Dir(App.Path & "\worlds\" & DirName(A) & "\*.wld")
        Do Until FileName = ""
            If LCase(Right(FileName, 4)) = ".wld" Then
                NumSelectWorld = NumSelectWorld + 1
                With SelectWorld(NumSelectWorld)
                    .WorldFile = FileName
                    .WorldPath = App.Path & "\worlds\" & DirName(A) & "\"
                    Open .WorldPath & .WorldFile For Input As #1
                        Input #1, FileRelease
                        Input #1, .WorldName
                        If FileRelease >= 55 Then
                            Input #1, .blockChar(1)
                            Input #1, .blockChar(2)
                            Input #1, .blockChar(3)
                            Input #1, .blockChar(4)
                        End If
                        If FileRelease >= 56 Then Input #1, .blockChar(5)
                    Close #1
                End With
                Exit Do
            End If
            FileName = Dir
        Loop
    Next A
End Sub

Public Sub FindLevels()
    Dim A As Integer
    Dim B As Integer
    Dim DirName(1 To 128) As String
    Dim FileName As String
    Dim numDirs As Integer
    Dim FileRelease As Integer
    NumSelectWorld = 1
    SelectWorld(1).WorldName = "Random Level"
    DirName(1) = Dir(App.Path & "\battle\*.lvl")
    numDirs = 1
    Do Until DirName(numDirs) = ""
        If Not (DirName(numDirs) = "." Or DirName(numDirs) = "..") Then
            If LCase(Right(DirName(numDirs), 4)) = ".lvl" Then
                numDirs = numDirs + 1
            End If
        End If
        DirName(numDirs) = Dir
    Loop
    numDirs = numDirs - 1
    For A = 1 To numDirs
        FileName = App.Path & "\battle\" & DirName(A)
        Open FileName For Input As #1
            Input #1, FileRelease
            If FileRelease >= 60 Then
                Input #1, B
                NumSelectWorld = NumSelectWorld + 1
                With SelectWorld(NumSelectWorld)
                    .WorldFile = FileName
                    Input #1, .WorldName
                End With
            End If
        Close #1
    Next A
End Sub

Public Sub FindSaves()
    Dim A As Integer
    Dim B As Integer
    Dim FileRelease As Integer
    Dim curActive As Integer
    Dim maxActive As Integer
    Dim newInput As String
    For A = 1 To 3
        curActive = 0
        maxActive = 0
        If Dir(SelectWorld(selWorld).WorldPath & "save" & A & ".sav") <> "" Then
            Open SelectWorld(selWorld).WorldPath & "save" & A & ".sav" For Input As #1
                Input #1, FileRelease
                If FileRelease >= 56 Then 'Version 1.2.2 and newer
                    For B = 1 To 4 'Misc Skipping
                        Input #1, newInput
                    Next B
                    For B = 1 To 5 'Character Info Skipping
                        Input #1, newInput
                        Input #1, newInput
                        Input #1, newInput
                        Input #1, newInput
                        Input #1, newInput
                    Next B
                    Input #1, newInput 'World music skipping
                Else 'Version 1.2.1 and older
                    For B = 1 To 13
                        Input #1, newInput
                    Next B
                End If
                Do Until EOF(1)
                    Input #1, newInput
                    If newInput = "next" Then Exit Do
                    maxActive = maxActive + 1
                    If newInput = "#TRUE#" Then
                        curActive = curActive + 1
                    End If
                Loop
                Do Until EOF(1)
                    Input #1, newInput
                    If newInput = "next" Then Exit Do
                    maxActive = maxActive + 1
                    If newInput = "#TRUE#" Then
                        curActive = curActive + 1
                    End If
                Loop
                Do Until EOF(1)
                    Input #1, newInput
                    If newInput = "next" Then Exit Do
                Loop
                If FileRelease >= 7 Then
                    SaveStars(A) = 0
                    Do Until EOF(1)
                        Input #1, newInput
                        If newInput = "next" Then Exit Do
                        If FileRelease >= 16 Then Input #1, newInput
                        If newInput = "next" Then Exit Do
                        SaveStars(A) = SaveStars(A) + 1
                    Loop
                End If
                If FileRelease >= 20 Then
                    Input #1, newInput
                    maxActive = maxActive + (newInput * 4)
                    curActive = curActive + (SaveStars(A) * 4)
                End If
            Close #1
            If maxActive > 0 Then
                SaveSlot(A) = Int((curActive / maxActive) * 100)
            Else
                SaveSlot(A) = 100
            End If
        Else
            SaveSlot(A) = -1
        End If
    Next A
End Sub

Public Sub SaveGame()
    Dim A As Integer
    If Cheater = True Then Exit Sub
    For A = numPlayers To 1 Step -1
        SavedChar(Player(A).Character) = Player(A)
    Next A
    For A = numStars To 1 Step -1
        If Star(A).level = "" Then
            If numStars > A Then
                Star(A) = Star(numStars)
                Star(numStars).level = ""
                Star(numStars).Section = ""
            End If
            numStars = numStars - 1
        End If
    Next A
    Open SelectWorld(selWorld).WorldPath & "save" & selSave & ".sav" For Output As #1
        Write #1, curRelease
        Write #1, Lives
        Write #1, Coins
        Write #1, WorldPlayer(1).Location.X
        Write #1, WorldPlayer(1).Location.Y
        For A = 1 To 5
            Write #1, SavedChar(A).State
            Write #1, SavedChar(A).HeldBonus
            Write #1, SavedChar(A).Mount
            Write #1, SavedChar(A).MountType
            Write #1, SavedChar(A).Hearts
        Next A
        Write #1, curWorldMusic
        'ABOVE GETS SKIPPED BY FINDSAVES
        Write #1, BeatTheGame 'Can only get 99% until you finish the game
        For A = 1 To numWorldLevels
            Write #1, WorldLevel(A).Active
        Next A
        Write #1, "next"
        For A = 1 To numWorldPaths
            Write #1, WorldPath(A).Active
        Next A
        Write #1, "next"
        For A = 1 To numScenes
            Write #1, Scene(A).Active
        Next A
        Write #1, "next"
        For A = 1 To numStars
            Write #1, Star(A).level
            Write #1, Star(A).Section
        Next A
        Write #1, "next"
        Write #1, MaxWorldStars
    Close #1
End Sub

Public Sub LoadGame()
    Dim A As Integer
    Dim B As Integer
    Dim FileRelease As Integer
    Dim newInput As String
    Open SelectWorld(selWorld).WorldPath & "save" & selSave & ".sav" For Input As #1
        Input #1, FileRelease
        Input #1, Lives
        Input #1, Coins
        Input #1, WorldPlayer(1).Location.X
        Input #1, WorldPlayer(1).Location.Y
        If FileRelease >= 56 Then 'New player system
            For A = 1 To 5
                Input #1, SavedChar(A).State
                Input #1, SavedChar(A).HeldBonus
                Input #1, SavedChar(A).Mount
                Input #1, SavedChar(A).MountType
                Input #1, SavedChar(A).Hearts
                SavedChar(A).Character = A
            Next A
        Else
            Input #1, Player(1).State
            Input #1, Player(1).HeldBonus
            Input #1, Player(1).Mount
            If FileRelease >= 9 Then
                Input #1, Player(1).MountType
            Else
                If Player(1).Mount = 3 Then Player(1).MountType = 1
            End If
            If FileRelease >= 53 Then Input #1, Player(1).Hearts
            Input #1, Player(2).State
            Input #1, Player(2).HeldBonus
            Input #1, Player(2).Mount
            If FileRelease >= 9 Then
                Input #1, Player(2).MountType
            Else
                If Player(2).Mount = 3 Then Player(2).MountType = 1
            End If
            If FileRelease >= 53 Then Input #1, Player(2).Hearts
        End If
        Input #1, curWorldMusic
        If FileRelease >= 16 Then Input #1, BeatTheGame
        A = 0
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            A = A + 1
            WorldLevel(A).Active = newInput
        Loop
        A = 0
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            A = A + 1
            WorldPath(A).Active = newInput
        Loop
        A = 0
        Do Until EOF(1)
            Input #1, newInput
            If newInput = "next" Then Exit Do
            A = A + 1
            Scene(A).Active = newInput
        Loop
        A = 0
        If FileRelease >= 7 Then
            Do Until EOF(1)
                Input #1, newInput
                If newInput = "next" Then Exit Do
                A = A + 1
                Star(A).level = newInput
                If FileRelease >= 16 Then
                    Input #1, Star(A).Section
                Else
                    Star(A).Section = -1
                End If
            Loop
            numStars = A
        End If
        If FileRelease >= 20 Then
            Input #1, newInput
        End If
    Close #1
    For A = 1 To numPlayers
        Player(A) = SavedChar(Player(A).Character)
    Next A
End Sub

Public Sub PauseGame(plr As Integer)
    Dim stopPause As Boolean
    Dim A As Integer
    Dim B As Integer
    Dim noButtons
    Dim fpsTime As Double
    Dim fpsCount As Integer
    For A = numPlayers To 1 Step -1
        SavedChar(Player(A).Character) = Player(A)
    Next A
    If TestLevel = True And MessageText = "" Then Exit Sub
    If MessageText = "" Then
        PlaySound 30
    Else
        SoundPause(47) = 0
        PlaySound 47
    End If
    GamePaused = True
    MenuCursor = 0
    MenuCursorCanMove = False
    If PSwitchTime > 0 Then
        If noSound = False Then mciSendString "pause smusic", 0, 0, 0
    End If
    overTime = 0
    GoalTime = GetTickCount + 1000
    fpsCount = 0
    fpsTime = 0
    cycleCount = 0
    gameTime = 0
    Do
        tempTime = GetTickCount
        If tempTime >= gameTime + frameRate Or tempTime < gameTime Or MaxFPS = True Then
            If fpsCount >= 32000 Then fpsCount = 0 'Fixes Overflow bug
            If cycleCount >= 32000 Then cycleCount = 0 'Fixes Overflow bug
            overTime = overTime + (tempTime - (gameTime + frameRate))
            If gameTime = 0 Then overTime = 0
            If overTime <= 1 Then
                overTime = 0
            ElseIf overTime > 1000 Then
                overTime = 1000
            End If
            gameTime = tempTime - overTime
            overTime = (overTime - (tempTime - gameTime))
            If GetTickCount > fpsTime Then
                If cycleCount >= 65 Then
                    overTime = 0
                    gameTime = tempTime
                End If
                cycleCount = 0
                fpsTime = GetTickCount + 1000
                GoalTime = fpsTime
                If Debugger = True Then frmLevelDebugger.lblFPS = fpsCount
                If ShowFPS = True Then
                    PrintFPS = fpsCount
                End If
                fpsCount = 0
            End If
            
            
            DoEvents
            CheckActive
            
            If LevelSelect = True Then
                UpdateGraphics2
            Else
                UpdateGraphics
            End If
            UpdateControls
            UpdateSound
            BlockFrames
            UpdateEffects
            If SingleCoop > 0 Or numPlayers > 2 Then
                For A = 1 To numPlayers
                    Player(A).Controls = Player(1).Controls
                Next A
            End If
            With Player(plr).Controls
                If MessageText = "" Then
                    If noButtons = False Then
                        If .Down = False And .Up = False And .Run = False And .Jump = False And .Start = False Then
                            If (GetKeyState(vbKeyEscape) And KEY_PRESSED) Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Or (GetKeyState(vbKeyDown) And KEY_PRESSED) Or (GetKeyState(vbKeyUp) And KEY_PRESSED) Then
                            Else
                                noButtons = True
                            End If
                        End If
                    Else
                        If (GetKeyState(vbKeyEscape) And KEY_PRESSED) Then
                            If LevelSelect = True And Cheater = False Then
                                If MenuCursor <> 2 Then PlaySound 26
                                MenuCursor = 2
                            Else
                                If MenuCursor <> 1 Then PlaySound 26
                                MenuCursor = 1
                            End If
                            noButtons = False
                        ElseIf .Start = True Then
                            stopPause = True
                        End If
                        If .Up = True Or (GetKeyState(vbKeyUp) And KEY_PRESSED) Then
                            PlaySound 26
                            MenuCursor = MenuCursor - 1
                            noButtons = False
                        ElseIf .Down = True Or (GetKeyState(vbKeyDown) And KEY_PRESSED) Then
                            PlaySound 26
                            MenuCursor = MenuCursor + 1
                            noButtons = False
                        End If
                        
                        If LevelSelect = True Then
                            If Player(A).Character = 1 Or Player(A).Character = 2 Then Player(A).Hearts = 0
                            For A = 1 To numPlayers
                                If Player(A).RunRelease = False Then
                                    If Player(A).Controls.Left = False And Player(A).Controls.Right = False Then Player(A).RunRelease = True
                                
                                
                                ElseIf Player(A).Controls.Left = True Or Player(A).Controls.Right = True Then
                                
                                    AllCharBlock = 0
                                    For B = 1 To numCharacters
                                        If blockCharacter(B) = False Then
                                            If AllCharBlock = 0 Then
                                                AllCharBlock = B
                                            Else
                                                AllCharBlock = 0
                                                Exit For
                                            End If
                                        End If
                                    Next B
                                    If AllCharBlock = 0 Then
                                        PlaySound 26
                                        Player(A).RunRelease = False
                                        If A = 1 Then
                                            B = 2
                                        Else
                                            B = 1
                                        End If
                                        If numPlayers = 1 Then B = 0
                                        Player(0).Character = 0
                                        If Player(A).Controls.Left = True Then
                                            Do
                                                Player(A).Character = Player(A).Character - 1
                                                If Player(A).Character <= 0 Then Player(A).Character = 5
                                            Loop While Player(A).Character = Player(B).Character Or blockCharacter(Player(A).Character) = True
                                        Else
                                            Do
                                                Player(A).Character = Player(A).Character + 1
                                                If Player(A).Character >= 6 Then Player(A).Character = 1
                                            Loop While Player(A).Character = Player(B).Character Or blockCharacter(Player(A).Character) = True
                                        End If
                                        Player(A) = SavedChar(Player(A).Character)
                                        SetupPlayers
                                    End If
                                End If
                                
                                
                            Next A
                        End If
                        If .Jump = True Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Then
                            If MenuCursor = 0 Then
                                stopPause = True
                            ElseIf MenuCursor = 1 And (LevelSelect = True Or (StartLevel = FileName And NoMap = True)) And Cheater = False Then
                                SaveGame
                                stopPause = True
                            Else
                                If Cheater = False And (LevelSelect = True Or (StartLevel = FileName And NoMap = True)) Then SaveGame
                                stopPause = True
                                GameMenu = True
                                MenuMode = 0
                                MenuCursor = 0
                                If LevelSelect = False Then
                                    LevelSelect = True
                                    EndLevel = True
                                Else
                                    LevelSelect = False
                                End If
                                BitBlt myBackBuffer, 0, 0, 800, 600, 0, 0, 0, vbWhiteness
                                BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
                                StopMusic
                                DoEvents
                                Sleep 500
                            End If
                        End If
                        If Cheater = True Or Not (LevelSelect = True Or (StartLevel = FileName And NoMap = True)) Then
                            If MenuCursor > 1 Then MenuCursor = 0
                            If MenuCursor < 0 Then MenuCursor = 1
                        Else
                            If MenuCursor > 2 Then MenuCursor = 0
                            If MenuCursor < 0 Then MenuCursor = 2
                        End If
                    End If
                Else
                    If noButtons = False Then
                        If .Down = False And .Up = False And .Run = False And .Jump = False And .Start = False Then
                            If (GetKeyState(vbKeyEscape) And KEY_PRESSED) Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Or (GetKeyState(vbKeyDown) And KEY_PRESSED) Or (GetKeyState(vbKeyUp) And KEY_PRESSED) Then
                            Else
                                noButtons = True
                            End If
                        End If
                    Else
                        If (GetKeyState(vbKeyEscape) And KEY_PRESSED) Or .Jump = True Or .Run = True Or .Start = True Or (GetKeyState(vbKeySpace) And KEY_PRESSED) Or (GetKeyState(vbKeyReturn) And KEY_PRESSED) Then
                            stopPause = True
                        End If
                    End If
                End If
            End With
        End If
        If qScreen = True Then stopPause = False
    Loop Until stopPause = True
    GamePaused = False
    Player(plr).UnStart = False
    Player(plr).CanJump = False
    If MessageText = "" Then PlaySound 30
    If PSwitchTime > 0 Then
        If noSound = False Then mciSendString "resume smusic", 0, 0, 0
    End If
    MessageText = ""
    
    overTime = 0
    GoalTime = GetTickCount + 1000
    fpsCount = 0
    cycleCount = 0
    gameTime = 0
    fpsTime = 0
    
End Sub

Public Sub InitControls()
    Dim A As Integer
    Dim B As Integer
    Dim newJoystick As Boolean
    A = 0
    Do
        newJoystick = StartJoystick(A)
        If newJoystick = True Then
            A = A + 1
        Else
            Exit Do
        End If
    Loop
    numJoysticks = A
    If numJoysticks = 0 Then
        useJoystick(1) = 0
        useJoystick(2) = 0
    ElseIf numJoysticks = 1 Then
        useJoystick(1) = 1
        useJoystick(2) = 0
    Else
        useJoystick(1) = 1
        useJoystick(2) = 2
    End If
    '
    useJoystick(1) = 0
    useJoystick(2) = 0
    '
    For A = 1 To 2
        With conJoystick(A)
            .Run = 2
            .AltRun = 3
            .Jump = 0
            .AltJump = 1
            .Drop = 6
            .Start = 7
        End With
    Next A
    With conKeyboard(1)
        .Down = vbKeyDown
        .Left = vbKeyLeft
        .Up = vbKeyUp
        .Right = vbKeyRight
        .Jump = vbKeyZ
        .Run = vbKeyX
        .Drop = vbKeyShift
        .Start = vbKeyEscape
        .AltJump = vbKeyA
        .AltRun = vbKeyS
    End With
    With conKeyboard(2)
        .Down = vbKeyDown
        .Left = vbKeyLeft
        .Up = vbKeyUp
        .Right = vbKeyRight
        .Jump = vbKeyZ
        .Run = vbKeyX
        .Drop = vbKeyShift
        .Start = vbKeyEscape
        .AltJump = vbKeyA
        .AltRun = vbKeyS
    End With
    OpenConfig
    If useJoystick(1) > numJoysticks Then useJoystick(1) = 0
    If useJoystick(2) > numJoysticks Then useJoystick(2) = 0
End Sub

Public Sub OpenConfig()
    Dim A As Integer
    Dim FileRelease As Integer
    Dim resBool As Boolean
    If Dir(App.Path & "\config.dat") <> "" Then
        Open App.Path & "\config.dat" For Input As #1
            Input #1, FileRelease
            If FileRelease >= 16 Then
                Input #1, resBool
            End If
            For A = 1 To 2
                Input #1, useJoystick(A)
                With conKeyboard(A)
                    Input #1, .Up
                    Input #1, .Down
                    Input #1, .Left
                    Input #1, .Right
                    Input #1, .Run
                    Input #1, .Jump
                    Input #1, .Drop
                    Input #1, .Start
                    If FileRelease >= 19 Then
                        Input #1, .AltJump
                        Input #1, .AltRun
                    End If
                End With
                With conJoystick(A)
                    Input #1, .Run
                    Input #1, .Jump
                    Input #1, .Drop
                    Input #1, .Start
                    If FileRelease >= 19 Then
                        Input #1, .AltJump
                        Input #1, .AltRun
                    End If
                End With
            Next A
        Close #1
    Else
        'resBool = True
    End If
    If resBool = True And resChanged = False And LevelEditor = False Then ChangeScreen
End Sub

Public Sub SaveConfig()
    Dim A As Integer
    Open App.Path & "\config.dat" For Output As #1
        Write #1, curRelease
        Write #1, resChanged
        For A = 1 To 2
            Write #1, useJoystick(A)
            With conKeyboard(A)
                Write #1, .Up
                Write #1, .Down
                Write #1, .Left
                Write #1, .Right
                Write #1, .Run
                Write #1, .Jump
                Write #1, .Drop
                Write #1, .Start
                Write #1, .AltJump
                Write #1, .AltRun
            End With
            With conJoystick(A)
                Write #1, .Run
                Write #1, .Jump
                Write #1, .Drop
                Write #1, .Start
                Write #1, .AltJump
                Write #1, .AltRun
            End With
        Next A
    Close #1
End Sub

Public Sub NPCyFix()
    Dim A As Integer
    Dim XnH As Single
    Dim XnHfix As Single
    For A = 1 To numNPCs
        XnH = NPC(A).Location.Y + NPC(A).Location.Height
        If ((XnH * 100) Mod 800) / 100 <> 0 Then
            If ((XnH + Abs(((XnH * 100) Mod 800) / 100)) * 100) Mod 800 = 0 Then
                XnHfix = Abs(((XnH * 100) Mod 800) / 100)
            Else
                XnHfix = Abs(8 - (((XnH * 100) Mod 800) / 100))
            End If
            NPC(A).Location.Y = NPC(A).Location.Y + XnHfix
        End If
    Next A
End Sub

Private Sub CheckActive()
    Dim MusicPaused As Boolean
    If nPlay.Online = True Then Exit Sub
    'If LevelEditor = False And TestLevel = False Then Exit Sub
    'If LevelEditor = False Then Exit Sub
    Do While GetActiveWindow = 0
        DoEvents
        If LevelEditor = True Or MagicHand = True Then frmLevelWindow.vScreen(1).MousePointer = 0
        overTime = 0
        GoalTime = GetTickCount + 1000
        fpsCount = 0
        fpsTime = 0
        cycleCount = 0
        gameTime = 0
        tempTime = 0
        keyDownEnter = False
        keyDownAlt = False
        If musicPlaying = True Then
            MusicPaused = True
            If noSound = False Then mciSendString "pause all", 0, 0, 0
        End If
    Loop
    If noSound = False Then
        If MusicPaused = True Then
            If GameOutro = True Then
                mciSendString "resume tmusic", 0, 0, 0
            ElseIf LevelSelect = True And GameMenu = False And LevelEditor = False Then
                mciSendString "resume wmusic" & curWorldMusic, 0, 0, 0
            ElseIf curMusic > 0 Then
                mciSendString "resume music" & curMusic, 0, 0, 0
            ElseIf curMusic < 0 Then
                If PSwitchStop > 0 Then
                    mciSendString "resume stmusic", 0, 0, 0
                Else
                    mciSendString "resume smusic", 0, 0, 0
                End If
            End If
        End If
    End If
    If LevelEditor = True Or MagicHand = True Then frmLevelWindow.vScreen(1).MousePointer = 99
End Sub

Public Sub CheatCode(NewKey As String)
    Dim newCheat As String
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim tempLocation As Location
    Dim oldString As String
    If LevelEditor = True Or GameMenu = True Or nPlay.Online = True Or BattleMode = True Then
        CheatString = ""
        Exit Sub
    End If
    CheatString = CheatString & LCase(NewKey)
    If Len(CheatString) > 23 Then
        For A = 2 To Len(CheatString)
            newCheat = newCheat & Mid(CheatString, A, 1)
        Next A
        CheatString = newCheat
    End If
    oldString = CheatString
    For A = 1 To Len(CheatString)
        If Mid(CheatString, A, 13) = Chr$(114) & Chr$(101) & Chr$(100) & Chr$(105) & Chr$(103) & Chr$(105) & Chr$(116) & Chr$(105) & Chr$(115) & Chr$(99) & Chr$(111) & Chr$(111) & Chr$(108) Then             'redigitiscool
            PlaySound 69
            Cheater = False
            CheatString = ""
            Exit Sub
        End If
        If LevelSelect = True Then
            If Mid(CheatString, A, Len("imtiredofallthiswalking")) = "imtiredofallthiswalking" Then
                For B = 1 To numWorldPaths
                    tempLocation = WorldPath(B).Location
                    With tempLocation
                        .X = .X + 4
                        .Y = .Y + 4
                        .Width = .Width - 8
                        .Height = .Height - 8
                    End With
                    WorldPath(B).Active = True
                    For C = 1 To numScenes
                        If CheckCollision(tempLocation, Scene(C).Location) Then Scene(C).Active = False
                    Next C
                Next B
                For B = 1 To numWorldLevels
                    WorldLevel(B).Active = True
                Next B
                PlaySound 27
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("illparkwhereiwant")) = "illparkwhereiwant" Then
                If WalkAnywhere = True Then
                    WalkAnywhere = False
                    PlaySound 5
                Else
                    WalkAnywhere = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit For
            End If
        Else
            If Mid(CheatString, A, Len("needashell")) = "needashell" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 113
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("fairymagic")) = "fairymagic" Then
                If Player(1).Fairy = True Then
                    For B = 1 To numPlayers
                        With Player(B)
                            PlaySound 87
                            .Immune = 10
                            .Effect = 8
                            .Effect2 = 4
                            .Fairy = False
                            .FairyTime = 0
                            SizeCheck B
                            NewEffect 63, .Location
                        End With
                    Next B
                Else
                    For B = 1 To numPlayers
                        With Player(B)
                            PlaySound 87
                            .Immune = 10
                            .Effect = 8
                            .Effect2 = 4
                            .Fairy = True
                            .FairyTime = -1
                            SizeCheck B
                            NewEffect 63, .Location
                        End With
                    Next B
                End If
                CheatString = ""
                Exit For
                
                
            ElseIf Mid(CheatString, A, Len("iceage")) = "iceage" Then
                For C = 1 To numNPCs
                    If NPC(C).Active = True Then
                        If NPCNoIceBall(NPC(C).Type) = False And NPC(C).Type <> 263 And NPCIsABonus(NPC(C).Type) = False Then
                            NPC(0).Type = 265
                            NPCHit C, 3, 0
                        End If
                    End If
                Next C
                PlaySound 34
                CheatString = ""
                Exit For
                
                
            ElseIf Mid(CheatString, A, Len("istillplaywithlegos")) = "istillplaywithlegos" Then
                ShowLayer "Destroyed Blocks"
                PlaySound 34
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("itsrainingmen")) = "itsrainingmen" Then
                For C = 1 To numPlayers
                    For B = -100 To 900 Step 34
                        numNPCs = numNPCs + 1
                        With NPC(numNPCs)
                            .Type = 90
                            .Location.Y = Player(C).Location.Y - 600
                            .Location.X = Player(C).Location.X - 400 + B
                            .Location.Height = 32
                            .Location.Width = 32
                            .Stuck = True
                            .Active = True
                            .TimeLeft = 200
                            .Section = Player(C).Section
                        End With
                    Next B
                Next C
                PlaySound 34
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("donttypethis")) = "donttypethis" Then
                For C = 1 To numPlayers
                    For B = -100 To 900 Step 34
                        numNPCs = numNPCs + 1
                        With NPC(numNPCs)
                            .Type = 134
                            .Location.Y = Player(C).Location.Y - 600
                            .Location.X = Player(C).Location.X - 400 + B
                            .Location.Height = 32
                            .Location.Width = 32
                            .Stuck = True
                            .Active = True
                            .TimeLeft = 200
                            .Section = Player(C).Section
                        End With
                    Next B
                Next C
                PlaySound 34
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("wetwater")) = "wetwater" Then
                For B = 1 To numEffects
                    If Effect(B).Type = 113 Then Effect(B).Life = 0
                Next B
                For B = 0 To maxSections
                    If UnderWater(B) = True Then
                        UnderWater(B) = False
                        If Background2REAL(B) = 55 Then
                            Background2(B) = 30
                        ElseIf Background2REAL(B) = 56 Then
                            Background2(B) = 39
                        Else
                            Background2(B) = Background2REAL(B)
                        End If
                        If bgMusicREAL(B) = 46 Then
                            Background2(B) = 8
                            bgMusic(B) = 7
                        ElseIf bgMusicREAL(B) = 47 Then
                            Background2(B) = 39
                            bgMusic(B) = 4
                        ElseIf bgMusicREAL(B) = 48 Then
                            Background2(B) = 30
                            bgMusic(B) = 29
                        ElseIf bgMusicREAL(B) = 49 Then
                            Background2(B) = 30
                            bgMusic(B) = 50
                        Else
                            bgMusic(B) = bgMusicREAL(B)
                        End If
                    Else
                        UnderWater(B) = True
                        If Background2REAL(B) <> 55 And Background2REAL(B) <> 56 Then
                            If Background2REAL(B) = 12 Or Background2REAL(B) = 13 Or Background2REAL(B) = 19 Or Background2REAL(B) = 29 Or Background2REAL(B) = 30 Or Background2REAL(B) = 31 Or Background2REAL(B) = 32 Or Background2REAL(B) = 33 Or Background2REAL(B) = 34 Or Background2REAL(B) = 42 Or Background2REAL(B) = 43 Then
                                Background2(B) = 55
                            Else
                                Background2(B) = 56
                            End If
                        Else
                            Background2(B) = Background2REAL(B)
                        End If
                        If bgMusicREAL(B) < 46 Or bgMusicREAL(B) > 49 Then
                            If bgMusic(B) = 7 Or bgMusic(B) = 9 Or bgMusic(B) = 42 Then
                                bgMusic(B) = 46
                            ElseIf bgMusic(B) = 1 Or bgMusic(B) = 2 Or bgMusic(B) = 3 Or bgMusic(B) = 4 Or bgMusic(B) = 6 Or bgMusic(B) = 54 Then
                                bgMusic(B) = 47
                            ElseIf bgMusic(B) = 10 Or bgMusic(B) = 17 Or bgMusic(B) = 28 Or bgMusic(B) = 29 Or bgMusic(B) = 41 Or bgMusic(B) = 51 Then
                                bgMusic(B) = 48
                            ElseIf bgMusic(B) = 14 Or bgMusic(B) = 26 Or bgMusic(B) = 27 Or bgMusic(B) = 35 Or bgMusic(B) = 36 Or bgMusic(B) = 50 Then
                                bgMusic(B) = 49
                            Else
                                bgMusic(B) = 18
                            End If
                        Else
                            bgMusic(B) = bgMusicREAL(B)
                        End If
                    End If
                Next B
                PlaySound 34
                For B = 1 To numPlayers
                    If Player(B).Dead = False And Player(B).TimeToLive = 0 Then
                        StopMusic
                        StartMusic Player(B).Section
                        Exit For
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needaredshell")) = "needaredshell" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 114
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needablueshell")) = "needablueshell" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 115
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needayellowshell")) = "needayellowshell" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 116
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needaveggie")) = "needaturnip" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 92
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needa1up")) = "needa1up" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 90
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needatanookisuit")) = "needatanookisuit" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 169
                    If Player(B).Character >= 3 And Player(B).State <> 5 Then
                        PlaySound 34
                        Player(B).Immune = 30
                        Player(B).Effect = 8
                        Player(B).Effect2 = 4
                        Player(B).State = 5
                        SizeCheck B
                        NewEffect 10, newLoc(Player(B).Location.X + Player(B).Location.Width / 2 - EffectWidth(10) / 2, Player(B).Location.Y + Player(B).Location.Height / 2 - EffectHeight(10) / 2)
                    End If
                    If Player(B).Character >= 3 And Player(B).Hearts < 3 Then Player(B).Hearts = Player(B).Hearts + 1
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needahammersuit")) = "needahammersuit" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 170
                    If Player(B).Character >= 3 And Player(B).State <> 6 Then
                        PlaySound 34
                        Player(B).Immune = 30
                        Player(B).Effect = 8
                        Player(B).Effect2 = 4
                        Player(B).State = 6
                        SizeCheck B
                        NewEffect 10, newLoc(Player(B).Location.X + Player(B).Location.Width / 2 - EffectWidth(10) / 2, Player(B).Location.Y + Player(B).Location.Height / 2 - EffectHeight(10) / 2)
                    End If
                    If Player(B).Character >= 3 And Player(B).Hearts < 3 Then Player(B).Hearts = Player(B).Hearts + 1
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needamushroom")) = "needamushroom" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 9
                    If Player(B).Character >= 3 And Player(B).State = 1 Then
                        PlaySound 34
                        Player(B).Immune = 30
                        Player(B).Effect = 8
                        Player(B).Effect2 = 4
                        Player(B).State = 2
                        SizeCheck B
                        NewEffect 10, newLoc(Player(B).Location.X + Player(B).Location.Width / 2 - EffectWidth(10) / 2, Player(B).Location.Y + Player(B).Location.Height / 2 - EffectHeight(10) / 2)
                    End If
                    If Player(B).Character >= 3 And Player(B).Hearts < 3 Then Player(B).Hearts = Player(B).Hearts + 1
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needaflower")) = "needaflower" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 14
                    If Player(B).Character >= 3 And Player(B).State <> 3 Then
                        PlaySound 34
                        Player(B).Immune = 30
                        Player(B).Effect = 8
                        Player(B).Effect2 = 4
                        Player(B).State = 3
                        SizeCheck B
                        NewEffect 10, newLoc(Player(B).Location.X + Player(B).Location.Width / 2 - EffectWidth(10) / 2, Player(B).Location.Y + Player(B).Location.Height / 2 - EffectHeight(10) / 2)
                    End If
                    If Player(B).Character >= 3 And Player(B).Hearts < 3 Then Player(B).Hearts = Player(B).Hearts + 1
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needaniceflower")) = "needaniceflower" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 264
                    If Player(B).Character >= 3 And Player(B).State <> 7 Then
                        PlaySound 34
                        Player(B).Immune = 30
                        Player(B).Effect = 8
                        Player(B).Effect2 = 4
                        Player(B).State = 7
                        SizeCheck B
                        NewEffect 10, newLoc(Player(B).Location.X + Player(B).Location.Width / 2 - EffectWidth(10) / 2, Player(B).Location.Y + Player(B).Location.Height / 2 - EffectHeight(10) / 2)
                    End If
                    If Player(B).Character >= 3 And Player(B).Hearts < 3 Then Player(B).Hearts = Player(B).Hearts + 1
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needaleaf")) = "needaleaf" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 34
                    If Player(B).Character >= 3 And Player(B).State <> 4 Then
                        PlaySound 34
                        Player(B).Immune = 30
                        Player(B).Effect = 8
                        Player(B).Effect2 = 4
                        Player(B).State = 4
                        SizeCheck B
                        NewEffect 10, newLoc(Player(B).Location.X + Player(B).Location.Width / 2 - EffectWidth(10) / 2, Player(B).Location.Y + Player(B).Location.Height / 2 - EffectHeight(10) / 2)
                    End If
                    If Player(B).Character >= 3 And Player(B).Hearts < 3 Then Player(B).Hearts = Player(B).Hearts + 1
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needanegg")) = "needanegg" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 96
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needaplant")) = "needaplant" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 49
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needagun")) = "needagun" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 22
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needaswitch")) = "needaswitch" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 32
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needaclock")) = "needaclock" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 248
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needabomb")) = "needabomb" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 135
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needashoe")) = "needashoe" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 35
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needaredshoe")) = "needaredshoe" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 191
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("needablueshoe")) = "needablueshoe" Then
                PlaySound 12
                For B = 1 To numPlayers
                    Player(B).HeldBonus = 193
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("shadowstar")) = "shadowstar" Then
                PlaySound 34
                For B = 1 To numPlayers
                    Player(B).Immune = 50
                    tempLocation = Player(B).Location
                    tempLocation.Y = Player(B).Location.Y + Player(B).Location.Height / 2 - 16
                    tempLocation.X = Player(B).Location.X + Player(B).Location.Width / 2 - 16
                    NewEffect 10, tempLocation
                Next B
                If ShadowMode = True Then
                    ShadowMode = False
                Else
                    ShadowMode = True
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("ibakedacakeforyou")) = "ibakedacakeforyou" Then
                PlaySound 34
                For B = 1 To numPlayers
                    Player(B).Character = 3
                    Player(B).Immune = 50
                    If Player(B).Mount <= 1 Then
                        Player(B).Location.Y = Player(B).Location.Y + Player(B).Location.Height
                        Player(B).Location.Height = Physics.PlayerHeight(Player(B).Character, Player(B).State)
                        If Player(B).Mount = 1 And Player(B).State = 1 Then Player(B).Location.Height = Physics.PlayerHeight(1, 2)
                        Player(B).Location.Y = Player(B).Location.Y - Player(B).Location.Height
                        Player(B).StandUp = True
                    End If
                    tempLocation = Player(B).Location
                    tempLocation.Y = Player(B).Location.Y + Player(B).Location.Height / 2 - 16
                    tempLocation.X = Player(B).Location.X + Player(B).Location.Width / 2 - 16
                    NewEffect 10, tempLocation
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("anothercastle")) = "anothercastle" Then
                PlaySound 34
                For B = 1 To numPlayers
                    Player(B).Character = 4
                    Player(B).Immune = 50
                    If Player(B).Mount <= 1 Then
                        Player(B).Location.Y = Player(B).Location.Y + Player(B).Location.Height
                        Player(B).Location.Height = Physics.PlayerHeight(Player(B).Character, Player(B).State)
                        If Player(B).Mount = 1 And Player(B).State = 1 Then Player(B).Location.Height = Physics.PlayerHeight(1, 2)
                        Player(B).Location.Y = Player(B).Location.Y - Player(B).Location.Height
                        Player(B).StandUp = True
                    End If
                    tempLocation = Player(B).Location
                    tempLocation.Y = Player(B).Location.Y + Player(B).Location.Height / 2 - 16
                    tempLocation.X = Player(B).Location.X + Player(B).Location.Width / 2 - 16
                    NewEffect 10, tempLocation
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("iamerror")) = "iamerror" Then
                PlaySound 34
                For B = 1 To numPlayers
                    Player(B).Character = 5
                    Player(B).Immune = 50
                    If Player(B).Mount <= 1 Then
                        Player(B).Location.Y = Player(B).Location.Y + Player(B).Location.Height
                        Player(B).Location.Height = Physics.PlayerHeight(Player(B).Character, Player(B).State)
                        If Player(B).Mount = 1 And Player(B).State = 1 Then Player(B).Location.Height = Physics.PlayerHeight(1, 2)
                        Player(B).Location.Y = Player(B).Location.Y - Player(B).Location.Height
                        Player(B).StandUp = True
                    End If
                    tempLocation = Player(B).Location
                    tempLocation.Y = Player(B).Location.Y + Player(B).Location.Height / 2 - 16
                    tempLocation.X = Player(B).Location.X + Player(B).Location.Width / 2 - 16
                    NewEffect 10, tempLocation
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("itsamemario")) = "itsamemario" Then
                PlaySound 34
                For B = 1 To numPlayers
                    Player(B).Character = 1
                    Player(B).Immune = 50
                    If Player(B).Mount <= 1 Then
                        Player(B).Location.Y = Player(B).Location.Y + Player(B).Location.Height
                        Player(B).Location.Height = Physics.PlayerHeight(Player(B).Character, Player(B).State)
                        If Player(B).Mount = 1 And Player(B).State = 1 Then Player(B).Location.Height = Physics.PlayerHeight(1, 2)
                        Player(B).Location.Y = Player(B).Location.Y - Player(B).Location.Height
                        Player(B).StandUp = True
                    End If
                    tempLocation = Player(B).Location
                    tempLocation.Y = Player(B).Location.Y + Player(B).Location.Height / 2 - 16
                    tempLocation.X = Player(B).Location.X + Player(B).Location.Width / 2 - 16
                    NewEffect 10, tempLocation
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("itsameluigi")) = "itsameluigi" Then
                PlaySound 34
                For B = 1 To numPlayers
                    Player(B).Character = 2
                    Player(B).Immune = 50
                    If Player(B).Mount <= 1 Then
                        Player(B).Location.Y = Player(B).Location.Y + Player(B).Location.Height
                        Player(B).Location.Height = Physics.PlayerHeight(Player(B).Character, Player(B).State)
                        If Player(B).Mount = 1 And Player(B).State = 1 Then Player(B).Location.Height = Physics.PlayerHeight(1, 2)
                        Player(B).Location.Y = Player(B).Location.Y - Player(B).Location.Height
                        Player(B).StandUp = True
                    End If
                    tempLocation = Player(B).Location
                    tempLocation.Y = Player(B).Location.Y + Player(B).Location.Height / 2 - 16
                    tempLocation.X = Player(B).Location.X + Player(B).Location.Width / 2 - 16
                    NewEffect 10, tempLocation
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("supermario128")) = "supermario128" Then
                B = CheckLiving
                If B > 0 Then
                    numPlayers = 128
                    ScreenType = 2
                    SetupScreens
                    If Player(B).Effect = 9 Then Player(B).Effect = 0
                    Player(B).Immune = 1
                    For C = 1 To numPlayers
                        If C <> B Then
                            Player(C) = Player(B)
                            Player(C).Location.SpeedY = Rnd * 24 - 12
                        End If
                    Next C
                    Bomb Player(B).Location, Int(Rnd * 2) + 2
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("supermario64")) = "supermario64" Then
                B = CheckLiving
                If B > 0 Then
                    numPlayers = 64
                    ScreenType = 2
                    SetupScreens
                    If Player(B).Effect = 9 Then Player(B).Effect = 0
                    Player(B).Immune = 1
                    For C = 1 To numPlayers
                        If C <> B Then
                            Player(C) = Player(B)
                            Player(C).Location.SpeedY = Rnd * 24 - 12
                        End If
                    Next C
                    Bomb Player(B).Location, Int(Rnd * 2) + 2
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("supermario32")) = "supermario32" Then
                B = CheckLiving
                If B > 0 Then
                    numPlayers = 32
                    ScreenType = 2
                    SetupScreens
                    If Player(B).Effect = 9 Then Player(B).Effect = 0
                    Player(B).Immune = 1
                    For C = 1 To numPlayers
                        If C <> B Then
                            Player(C) = Player(B)
                            Player(C).Location.SpeedY = Rnd * 24 - 12
                        End If
                    Next C
                    Bomb Player(B).Location, Int(Rnd * 2) + 2
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("supermario16")) = "supermario16" Then
                B = CheckLiving
                If B > 0 Then
                    numPlayers = 16
                    ScreenType = 2
                    SetupScreens
                    If Player(B).Effect = 9 Then Player(B).Effect = 0
                    Player(B).Immune = 1
                    For C = 1 To numPlayers
                        If C <> B Then
                            Player(C) = Player(B)
                            Player(C).Location.SpeedY = Rnd * 24 - 12
                        End If
                    Next C
                    Bomb Player(B).Location, Int(Rnd * 2) + 2
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("supermario8")) = "supermario8" Then
                B = CheckLiving
                If B > 0 Then
                    numPlayers = 8
                    ScreenType = 2
                    SetupScreens
                    If Player(B).Effect = 9 Then Player(B).Effect = 0
                    Player(B).Immune = 1
                    For C = 1 To numPlayers
                        If C <> B Then
                            Player(C) = Player(B)
                            Player(C).Location.SpeedY = Rnd * 24 - 12
                        End If
                    Next C
                    Bomb Player(B).Location, Int(Rnd * 2) + 2
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("supermario4")) = "supermario4" Then
                B = CheckLiving
                If B > 0 Then
                    numPlayers = 4
                    ScreenType = 2
                    SetupScreens
                    If Player(B).Effect = 9 Then Player(B).Effect = 0
                    Player(B).Immune = 1
                    For C = 1 To numPlayers
                        If C <> B Then
                            Player(C) = Player(B)
                            Player(C).Location.SpeedY = Rnd * 24 - 12
                        End If
                    Next C
                    Bomb Player(B).Location, Int(Rnd * 2) + 2
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("supermario2")) = "supermario2" Then
                B = CheckLiving
                If B > 0 Then
                    numPlayers = 2
                    ScreenType = 6
                    SingleCoop = 1
                    SetupScreens
                    If Player(B).Effect = 9 Then Player(B).Effect = 0
                    Player(B).Immune = 1
                    For C = 1 To numPlayers
                        If C <> B Then
                            Player(C) = Player(B)
                            Player(C).Location.SpeedY = Rnd * 24 - 12
                        End If
                        If C = 1 Then
                            Player(C).Character = 1
                            If Player(C).Mount <= 1 Then
                                Player(C).Location.Y = Player(C).Location.Y + Player(C).Location.Height
                                Player(C).Location.Height = Physics.PlayerHeight(Player(C).Character, Player(C).State)
                                If Player(C).Mount = 1 And Player(C).State = 1 Then Player(C).Location.Height = Physics.PlayerHeight(1, 2)
                                Player(C).Location.Y = Player(C).Location.Y - Player(C).Location.Height
                                Player(C).StandUp = True
                            End If
                        Else
                            Player(C).Character = 2
                            If Player(C).Mount <= 1 Then
                                Player(C).Location.Y = Player(C).Location.Y + Player(C).Location.Height
                                Player(C).Location.Height = Physics.PlayerHeight(Player(C).Character, Player(C).State)
                                If Player(C).Mount = 1 And Player(C).State = 1 Then Player(C).Location.Height = Physics.PlayerHeight(1, 2)
                                Player(C).Location.Y = Player(C).Location.Y - Player(C).Location.Height
                                Player(C).StandUp = True
                            End If
                        End If
                    Next C
                    Bomb Player(B).Location, Int(Rnd * 2) + 2
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("1player")) = "1player" Then
                B = CheckLiving
                If B > 0 Then
                    For C = 1 To numPlayers
                        Player(C).Immune = 1
                    Next C
                    For C = 1 To numPlayers
                        If C <> B Then
                            Bomb Player(C).Location, Int(Rnd * 2) + 2
                        End If
                    Next C
                    numPlayers = 1
                    ScreenType = 0
                    SingleCoop = 1
                    SetupScreens
                    If Player(B).Effect = 9 Then Player(B).Effect = 0
                    C = 1
                    Player(C) = Player(B)
                    Player(C).Character = 1
                    If Player(C).Mount <= 1 Then
                        Player(C).Location.Y = Player(C).Location.Y + Player(C).Location.Height
                        Player(C).Location.Height = Physics.PlayerHeight(Player(C).Character, Player(C).State)
                        If Player(C).Mount = 1 And Player(C).State = 1 Then Player(C).Location.Height = Physics.PlayerHeight(1, 2)
                        Player(C).Location.Y = Player(C).Location.Y - Player(C).Location.Height
                        Player(C).StandUp = True
                    End If
                    Player(C).Immune = 1
                    Player(C).Immune2 = True
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("2player")) = "2player" Then
                B = CheckLiving
                If B > 0 Then
                    numPlayers = 2
                    ScreenType = 5
                    SingleCoop = 0
                    SetupScreens
                    If Player(B).Effect = 9 Then Player(B).Effect = 0
                    Player(B).Immune = 1
                    For C = 1 To numPlayers
                        If C <> B Then
                            Player(C) = Player(B)
                            Player(C).Location.SpeedY = Rnd * -12
                        End If
                        If C = 1 Then
                            Player(C).Character = 1
                            If Player(C).Mount <= 1 Then
                                Player(C).Location.Y = Player(C).Location.Y + Player(C).Location.Height
                                Player(C).Location.Height = Physics.PlayerHeight(Player(C).Character, Player(C).State)
                                If Player(C).Mount = 1 And Player(C).State = 1 Then Player(C).Location.Height = Physics.PlayerHeight(1, 2)
                                Player(C).Location.Y = Player(C).Location.Y - Player(C).Location.Height
                                Player(C).StandUp = True
                            End If
                        Else
                            Player(C).Character = 2
                            If Player(C).Mount <= 1 Then
                                Player(C).Location.Y = Player(C).Location.Y + Player(C).Location.Height
                                Player(C).Location.Height = Physics.PlayerHeight(Player(C).Character, Player(C).State)
                                If Player(C).Mount = 1 And Player(C).State = 1 Then Player(C).Location.Height = Physics.PlayerHeight(1, 2)
                                Player(C).Location.Y = Player(C).Location.Y - Player(C).Location.Height
                                Player(C).StandUp = True
                            End If
                        End If
                    Next C
                    Bomb Player(B).Location, Int(Rnd * 2) + 2
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("wariotime")) = "wariotime" Then
                For B = 1 To numNPCs
                    If NPC(B).Active = True Then
                        If NPCWontHurt(NPC(B).Type) = False And NPCIsABlock(NPC(B).Type) = False And NPCIsABonus(NPC(B).Type) = False And NPCIsACoin(NPC(B).Type) = False And NPCIsAnExit(NPC(B).Type) = False And NPC(B).Type <> 91 And NPC(B).Generator = False And NPC(B).Inert = False Then
                            PlaySound 34
                            NPC(B).Location.Y = NPC(B).Location.Y + NPC(B).Location.Height / 2
                            NPC(B).Location.X = NPC(B).Location.X + NPC(B).Location.Width / 2
                            tempLocation = NPC(B).Location
                            tempLocation.Y = tempLocation.Y - 16
                            tempLocation.X = tempLocation.X - 16
                            NewEffect 10, tempLocation
                            NPC(B).Type = 10
                            NPC(B).Location.Width = NPCWidth(NPC(B).Type)
                            NPC(B).Location.Height = NPCHeight(NPC(B).Type)
                            NPC(B).Location.Y = NPC(B).Location.Y - NPC(B).Location.Height / 2
                            NPC(B).Location.X = NPC(B).Location.X - NPC(B).Location.Width / 2
                            NPC(B).Location.SpeedX = 0
                            NPC(B).Location.SpeedY = 0
                        End If
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("wherearemycarkeys")) = "wherearemycarkeys" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 31
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        CheckSectionNPC numNPCs
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("boingyboing")) = "boingyboing" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 26
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        CheckSectionNPC numNPCs
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("bombsaway")) = "bombsaway" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 134
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.X = Player(B).Location.X
                        NPC(numNPCs).Location.Y = Player(B).Location.Y
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        CheckSectionNPC numNPCs
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("firemissiles")) = "firemissiles" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 17
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        CheckSectionNPC numNPCs
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("burnthehousedown")) = "burnthehousedown" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 279
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        NPC(numNPCs).Location.X = Player(B).Location.X
                        NPC(numNPCs).Location.Y = Player(B).Location.Y
                        NPC(numNPCs).Section = Player(B).Section
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("upandout")) = "upandout" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 278
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        NPC(numNPCs).Location.X = Player(B).Location.X
                        NPC(numNPCs).Location.Y = Player(B).Location.Y
                        NPC(numNPCs).Section = Player(B).Section
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
                
            ElseIf Mid(CheatString, A, Len("powhammer")) = "powhammer" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 241
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        NPC(numNPCs).Location.X = Player(B).Location.X
                        NPC(numNPCs).Location.Y = Player(B).Location.Y
                        NPC(numNPCs).Section = Player(B).Section
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("hammerinmypants")) = "hammerinmypants" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 29
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        NPC(numNPCs).Location.X = Player(B).Location.X
                        NPC(numNPCs).Location.Y = Player(B).Location.Y
                        NPC(numNPCs).Section = Player(B).Section
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("rainbowrider")) = "rainbowrider" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 195
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Effect = 2
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("greenegg")) = "greenegg" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 96
                        NPC(numNPCs).Special = 95
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Effect = 2
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("blueegg")) = "blueegg" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 96
                        NPC(numNPCs).Frame = 1
                        NPC(numNPCs).Special = 98
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Effect = 2
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("yellowegg")) = "yellowegg" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 96
                        NPC(numNPCs).Special = 99
                        NPC(numNPCs).Frame = 2
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Effect = 2
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("redegg")) = "redegg" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 96
                        NPC(numNPCs).Special = 100
                        NPC(numNPCs).Frame = 3
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Effect = 2
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("blackegg")) = "blackegg" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 96
                        NPC(numNPCs).Special = 148
                        NPC(numNPCs).Frame = 4
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Effect = 2
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("purpleegg")) = "purpleegg" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 96
                        NPC(numNPCs).Special = 149
                        NPC(numNPCs).Frame = 5
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Effect = 2
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("pinkegg")) = "pinkegg" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 96
                        NPC(numNPCs).Special = 150
                        NPC(numNPCs).Frame = 6
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Effect = 2
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("pinkegg")) = "coldegg" Then
                For B = 1 To numPlayers
                    If Player(B).Mount = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 Then
                        numNPCs = numNPCs + 1
                        NPC(numNPCs).Type = 96
                        NPC(numNPCs).Special = 228
                        NPC(numNPCs).Frame = 6
                        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                        NPC(numNPCs).Location.SpeedX = 0
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Effect = 2
                        NPC(numNPCs).Active = True
                        NPC(numNPCs).TimeLeft = 200
                        NPC(numNPCs).HoldingPlayer = B
                        Player(B).HoldingNPC = numNPCs
                        Player(B).ForceHold = 60
                        PlaySound 23
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("stophittingme")) = "stophittingme" Then
                Dim tempBool As Boolean
                tempBool = GodMode
                GodMode = False
                For B = 1 To numPlayers
                    PlayerHurt B
                Next B
                GodMode = tempBool
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("stickyfingers")) = "stickyfingers" Then
                If GrabAll = True Then
                    If TestLevel = True Then frmTestSettings.chkGrabAll.Value = 0
                    GrabAll = False
                    PlaySound 5
                Else
                    If TestLevel = True Then frmTestSettings.chkGrabAll.Value = 1
                    GrabAll = True
                    PlaySound 6
                End If
                For B = 1 To 128
                    If GrabAll = True Then
                        Player(B).CanGrabNPCs = True
                    Else
                        Player(B).CanGrabNPCs = False
                    End If
                Next B
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("captainn")) = "captainn" Then
                If CaptainN = True Then
                    CaptainN = False
                    PlaySound 5
                Else
                    CaptainN = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("flamethrower")) = "flamethrower" Then
                If FlameThrower = True Then
                    FlameThrower = False
                    PlaySound 5
                Else
                    FlameThrower = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("moneytree")) = "moneytree" Then
                If CoinMode = True Then
                    CoinMode = False
                    PlaySound 5
                Else
                    CoinMode = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("donthurtme")) = "donthurtme" Then
                If GodMode = True Then
                    If TestLevel = True Then frmTestSettings.chkGodMode.Value = 0
                    GodMode = False
                    PlaySound 5
                Else
                    If TestLevel = True Then frmTestSettings.chkGodMode.Value = 1
                    GodMode = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("wingman")) = "wingman" Then
                If FlyForever = True Then
                    FlyForever = False
                    PlaySound 5
                Else
                    FlyForever = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("sonicstooslow")) = "sonicstooslow" Then
                If SuperSpeed = True Then
                    SuperSpeed = False
                    PlaySound 5
                Else
                    SuperSpeed = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("ahippinandahoppin")) = "ahippinandahoppin" Then
                If MultiHop = True Then
                    MultiHop = False
                    PlaySound 5
                Else
                    MultiHop = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit For
            ElseIf Mid(CheatString, A, Len("framerate")) = "framerate" Then
                If ShowFPS = True Then
                    If TestLevel = True Then frmTestSettings.chkShowFPS.Value = 0
                    ShowFPS = False
                    PlaySound 5
                    PrintFPS = 0
                Else
                    If TestLevel = True Then frmTestSettings.chkShowFPS.Value = 1
                    ShowFPS = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit Sub
            ElseIf Mid(CheatString, A, Len("speeddemon")) = "speeddemon" Then
                If MaxFPS = True Then
                    MaxFPS = False
                    If TestLevel = True Then frmTestSettings.chkMaxFPS.Value = 0
                    PlaySound 5
                Else
                    If TestLevel = True Then frmTestSettings.chkMaxFPS.Value = 1
                    MaxFPS = True
                    PlaySound 6
                End If
                CheatString = ""
                Exit For
            End If
        End If
    Next A
    If oldString <> CheatString Then Cheater = True
End Sub

Public Sub OutroLoop() 'credit loop
    Dim blankControls As Controls
    Dim A As Integer
    Dim B As Integer
    Dim tempLocation As Location
    Dim jumpBool As Boolean
    Dim fBlock As Long
    Dim lBlock As Long
    UpdateControls
    For A = 1 To numPlayers
        With Player(A)
            .Controls = blankControls
            .Controls.Left = True
            jumpBool = True
            tempLocation = .Location
            tempLocation = .Location
            tempLocation.SpeedX = 0
            tempLocation.SpeedY = 0
            tempLocation.Y = .Location.Y + .Location.Height - 8
            tempLocation.Height = 16
            tempLocation.Width = 16
            If .Location.SpeedX > 0 Then
                tempLocation.X = .Location.X + .Location.Width + 20
            Else
                tempLocation.X = .Location.X - tempLocation.Width - 20
            End If
            fBlock = FirstBlock((tempLocation.X / 32) - 1)
            lBlock = LastBlock(((tempLocation.X + tempLocation.Width) / 32) + 1)
            For B = fBlock To lBlock
                If tempLocation.X + tempLocation.Width >= Block(B).Location.X Then
                    If tempLocation.X <= Block(B).Location.X + Block(B).Location.Width Then
                        If tempLocation.Y + tempLocation.Height >= Block(B).Location.Y Then
                            If tempLocation.Y <= Block(B).Location.Y + Block(B).Location.Height Then
                                If BlockNoClipping(Block(B).Type) = False And Block(B).Invis = False And Block(B).Hidden = False And Not (BlockIsSizable(Block(B).Type) And Block(B).Location.Y < .Location.Y + .Location.Height - 3) Then
                                    jumpBool = False
                                End If
                            End If
                        End If
                    End If
                Else
                    If BlocksSorted = True Then Exit For
                End If
            Next B
            If jumpBool = True Or .Jump > 0 Then .Controls.Jump = True
        End With
    Next A
    UpdateNPCs
    UpdateBlocks
    UpdateEffects
    UpdatePlayer
    UpdateGraphics
    UpdateSound
End Sub

Public Sub SetupCredits()
    Dim A As Integer
    numCredits = 0
    AddCredit "Super Mario Bros. X"
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit "Created By:"
    AddCredit ""
    AddCredit "Andrew Spinks"
    AddCredit "'Redigit'"
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    If WorldCredits(1) <> "" Then
        AddCredit "Level Design:"
        AddCredit ""
        For A = 1 To 5
            If WorldCredits(A) = "" Then Exit For
            AddCredit WorldCredits(A)
        Next A
        AddCredit ""
        AddCredit ""
        AddCredit ""
    End If
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit "Custom Sprites:"
    AddCredit ""
    AddCredit "Blue"
    AddCredit "Iceman404"
    AddCredit "LuigiFan"
    AddCredit "NameUser"
    AddCredit "Redigit"
    AddCredit "Valtteri"
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit "Special Thanks:"
    AddCredit ""
    AddCredit "4matsy"
    AddCredit "AndyDark"
    AddCredit "Bikcmp"
    AddCredit "Blue"
    AddCredit "Captain Obvious"
    AddCredit "CaptainTrek"
    AddCredit "Chase"
    AddCredit "Coldwin"
    AddCredit "CrystalMike"
    AddCredit "DarkMatt"
    AddCredit "FallingSnow"
    AddCredit "Garro"
    AddCredit "Knuckles96"
    AddCredit "Kuribo"
    AddCredit "Kyasarin"
    AddCredit "Luminous"
    AddCredit "m4sterbr0s"
    AddCredit "NameUser"
    AddCredit "Namyrr"
    AddCredit "Qig"
    AddCredit "Quill"
    AddCredit "Red_Yoshi"
    AddCredit "Spitfire"
    AddCredit "Valtteri"
    AddCredit "Vandarx"
    AddCredit "Zephyr"
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit "'He has delivered us from the power"
    AddCredit "of darkness and conveyed us into"
    AddCredit "the kingdom of the Son of His love.'"
    AddCredit ""
    AddCredit "Colossians 1:13"
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit ""
    AddCredit "www.SuperMarioBrothers.org"


    For A = 1 To numCredits
        With Credit(A)
            .Location.Width = Len(.Text) * 18
            .Location.Height = 16
            .Location.X = 400 - .Location.Width / 2
            .Location.Y = 640 + 32 * A
        End With
    Next A
End Sub

Public Sub FindStars() 'checks for stars in warps the lead to another level
    Dim A As Integer
    Dim B As Integer
    Dim FileRelease As Integer
    Dim newInput As String
    For A = 1 To numWarps
        With Warp(A)
            If .level <> "" Then
                If Dir(FileNamePath & .level) <> "" Then
                    Open FileNamePath & .level For Input As #1
                        Input #1, FileRelease
                        If FileRelease >= 17 Then
                            Input #1, .maxStars
                        End If
                    Close #1
                    .curStars = 0
                    For B = 1 To numStars
                        If LCase(Star(B).level) = LCase(.level) Then
                            .curStars = .curStars + 1
                        End If
                    Next B
                End If
            End If
        End With
    Next A
End Sub

Public Sub AddCredit(newCredit As String) 'for settings up the game's credits
    numCredits = numCredits + 1
    Credit(numCredits).Text = newCredit
End Sub

Public Function newLoc(X As Double, Y As Double, Optional Width As Double = 0, Optional Height As Double = 0) As Location 'creates a temp Location
    newLoc.X = X
    newLoc.Y = Y
    newLoc.Width = Width
    newLoc.Height = Height
End Function

Public Sub MoreScore(addScore As Integer, Loc As Location, Optional Multiplier As Integer = 0) 'calcualtes scores based on the multiplyer and how much the NPC is worth
    Dim oldM As Integer
    Dim A As Integer
    If GameMenu = True Or GameOutro = True Or BattleMode = True Then Exit Sub
    A = addScore + Multiplier
    If A = 0 Then Exit Sub
    Multiplier = Multiplier + 1
    If A > 13 Then A = 13
    If A < addScore Then A = addScore
    If Multiplier > 9 Then Multiplier = 8
    If A > 13 Then A = 13
    If Points(A) <= 5 Then
        Lives = Lives + Points(A)
        PlaySound 15
    Else
        Score = Score + Points(A)
    End If
    NewEffect 79, Loc
    Effect(numEffects).Frame = A - 1
End Sub

Public Sub SetupPlayerFrames() 'sets up player frame offsets so they are displayed correctly on the screen
    Dim A As Integer
    For A = 1 To maxPlayerFrames
        MarioFrameX(A) = 0
        MarioFrameY(A) = 0
        LuigiFrameX(A) = 0
        LuigiFrameY(A) = 0
        PeachFrameX(A) = 0
        PeachFrameY(A) = 0
        ToadFrameX(A) = 0
        ToadFrameY(A) = 0
    Next A
    
    LinkFrameY(101) = -8
    LinkFrameY(102) = -8
    LinkFrameY(103) = -8
    LinkFrameY(104) = -6
    LinkFrameY(105) = -8
    LinkFrameY(106) = -8
    LinkFrameY(107) = -4
    LinkFrameY(108) = -6
    LinkFrameY(109) = -4
    LinkFrameY(110) = -16
    LinkFrameY(111) = -2
    LinkFrameY(99) = -8
    LinkFrameY(98) = -8
    LinkFrameY(97) = -8
    LinkFrameY(96) = -6
    LinkFrameY(95) = -8
    LinkFrameY(94) = -8
    LinkFrameY(93) = -4
    LinkFrameY(92) = -6
    LinkFrameY(91) = -4
    LinkFrameY(90) = -16
    LinkFrameY(89) = -2
    For A = 51 To 149
        LinkFrameX(A) = -4
    Next A
    LinkFrameX(106) = -18
    LinkFrameX(93) = -36
    LinkFrameX(92) = -36
    
    For A = 51 To 649
        LinkFrameX(A + 100) = LinkFrameX(A)
        LinkFrameY(A + 100) = LinkFrameY(A)
    Next A

        LinkFrameX(512) = -4
        LinkFrameY(512) = -8
        LinkFrameX(488) = -4
        LinkFrameY(488) = -8

For A = 51 To 149
    ToadFrameY(A) = -6
    ToadFrameX(A) = -2
Next A
    ToadFrameY(107) = -2
    ToadFrameY(127) = -2
    
    ToadFrameX(127) = -4
    ToadFrameX(73) = -4
    
    ToadFrameX(115) = -4
    ToadFrameX(85) = -4
    ToadFrameY(93) = -2
    ToadFrameY(73) = -2
    ToadFrameY(122) = -20
    ToadFrameY(123) = -12
    
    ToadFrameY(78) = -20
    ToadFrameY(77) = -12
    
    For A = 151 To 349
        ToadFrameY(A) = 2
        ToadFrameX(A) = -4
    Next A
    
    For A = 151 To 349
        ToadFrameY(A) = ToadFrameY(A) - 4
    Next A
    
    ToadFrameY(227) = 0
    ToadFrameY(207) = 0
    ToadFrameY(173) = 0
    ToadFrameY(193) = 0
    ToadFrameY(327) = 0
    ToadFrameY(307) = 0
    ToadFrameY(273) = 0
    ToadFrameY(293) = 0
    ToadFrameY(322) = -22
    ToadFrameY(278) = -22
    ToadFrameY(222) = -22
    ToadFrameY(178) = -22
    ToadFrameY(323) = -16
    ToadFrameY(277) = -16
    ToadFrameY(223) = -16
    ToadFrameY(177) = -16
    
    ToadFrameX(294) = -4
    ToadFrameX(194) = -4
    ToadFrameX(306) = -6
    ToadFrameX(206) = -6
    ToadFrameX(106) = -4
    
    PeachFrameY(101) = -4
    PeachFrameY(102) = -4
    PeachFrameY(103) = -4
    PeachFrameY(104) = -4
    PeachFrameY(108) = -4
    PeachFrameY(109) = -4
    PeachFrameY(110) = -4
    PeachFrameY(127) = -2
    PeachFrameY(122) = -16
    PeachFrameY(78) = -16
    PeachFrameY(99) = -4
    PeachFrameY(98) = -4
    PeachFrameY(97) = -4
    PeachFrameY(96) = -4
    PeachFrameY(92) = -4
    PeachFrameY(91) = -4
    PeachFrameY(90) = -4
    PeachFrameY(73) = -2
    PeachFrameX(101) = -2
    PeachFrameX(102) = -2
    PeachFrameX(103) = -2
    PeachFrameX(104) = -2
    PeachFrameX(108) = -2
    PeachFrameX(109) = -2
    PeachFrameX(110) = -2
    PeachFrameX(107) = -2
    PeachFrameX(93) = -2
    PeachFrameX(127) = -4
    PeachFrameX(99) = 0
    PeachFrameX(98) = 0
    PeachFrameX(97) = 0
    PeachFrameX(96) = 0
    PeachFrameX(92) = 0
    PeachFrameX(91) = 0
    PeachFrameX(90) = 0
    PeachFrameX(73) = -4
    
    PeachFrameY(201) = -2
    PeachFrameY(202) = -2
    PeachFrameY(203) = -2
    PeachFrameY(204) = -2
    PeachFrameY(208) = -2
    PeachFrameY(209) = -2
    PeachFrameY(210) = -2
    PeachFrameY(215) = -2
    PeachFrameY(185) = -2
    PeachFrameY(222) = -30
    PeachFrameY(178) = -30
    PeachFrameY(199) = -2
    PeachFrameY(198) = -2
    PeachFrameY(197) = -2
    PeachFrameY(196) = -2
    PeachFrameY(192) = -2
    PeachFrameY(191) = -2
    PeachFrameY(190) = -2
    PeachFrameX(201) = -4
    PeachFrameX(202) = -4
    PeachFrameX(203) = -4
    PeachFrameX(204) = -4
    PeachFrameX(207) = -4
    PeachFrameX(208) = -4
    PeachFrameX(209) = -4
    PeachFrameX(210) = -4
    PeachFrameX(215) = -4
    PeachFrameX(185) = -4
    PeachFrameX(227) = -4
    PeachFrameX(199) = -4
    PeachFrameX(198) = -4
    PeachFrameX(197) = -4
    PeachFrameX(196) = -4
    PeachFrameX(193) = -4
    PeachFrameX(192) = -4
    PeachFrameX(191) = -4
    PeachFrameX(190) = -4
    PeachFrameX(173) = -4
    PeachFrameY(223) = -30
    PeachFrameY(177) = -30
    PeachFrameY(206) = -2
    PeachFrameY(194) = -2
    PeachFrameX(195) = PeachFrameX(196)
    PeachFrameY(195) = PeachFrameY(196)
    PeachFrameX(205) = PeachFrameX(204)
    PeachFrameY(205) = PeachFrameY(204)
    PeachFrameX(206) = -8
    PeachFrameX(194) = 0
    PeachFrameX(213) = -4
    PeachFrameX(187) = -4
    PeachFrameY(213) = -2
    PeachFrameY(187) = -2
    PeachFrameY(123) = -16
    PeachFrameY(77) = -16
    PeachFrameY(122) = -2
    PeachFrameY(78) = -22
    PeachFrameY(106) = -4
    PeachFrameY(94) = -4
    PeachFrameX(95) = PeachFrameX(96)
    PeachFrameY(95) = PeachFrameY(96)
    PeachFrameX(105) = PeachFrameX(104)
    PeachFrameY(105) = PeachFrameY(104)
    PeachFrameX(106) = -4
    PeachFrameX(94) = 0
    PeachFrameX(113) = -2
    PeachFrameX(115) = -2
    PeachFrameX(85) = -2
    PeachFrameY(115) = -4
    PeachFrameY(85) = -4
    PeachFrameX(87) = -2
    PeachFrameY(113) = -4
    PeachFrameY(87) = -4
    PeachFrameY(75) = -2
    PeachFrameY(74) = -2
    PeachFrameY(125) = -2
    PeachFrameY(126) = -2
    PeachFrameY(123) = -16
    PeachFrameY(122) = -22
    For A = 151 To 249
        PeachFrameX(A + 100) = PeachFrameX(A)
        PeachFrameY(A + 100) = PeachFrameY(A)
    Next A
    PeachFrameX(312) = PeachFrameX(310)
    PeachFrameX(311) = PeachFrameX(310)
    PeachFrameX(288) = PeachFrameX(290)
    PeachFrameX(289) = PeachFrameX(290)
    PeachFrameY(312) = PeachFrameY(310)
    PeachFrameY(311) = PeachFrameY(310)
    PeachFrameY(288) = PeachFrameY(290)
    PeachFrameY(289) = PeachFrameY(290)

    
    
    
    MarioFrameY(96) = 0
    MarioFrameX(97) = -4
    MarioFrameX(98) = -2
    MarioFrameY(98) = 0
    MarioFrameY(99) = 2
    MarioFrameY(101) = 2
    MarioFrameX(102) = -4
    MarioFrameY(102) = 0
    MarioFrameX(103) = -4
    MarioFrameY(104) = 0
    MarioFrameX(105) = -2
    MarioFrameX(106) = -4
    MarioFrameY(190) = 2
    MarioFrameY(191) = 2
    MarioFrameY(192) = 2
    MarioFrameY(193) = -4
    MarioFrameX(194) = -2
    MarioFrameY(194) = 0
    MarioFrameX(195) = -2
    MarioFrameX(196) = -2
    MarioFrameX(197) = -2
    MarioFrameY(197) = 2
    MarioFrameX(198) = -2
    MarioFrameY(198) = 2
    MarioFrameY(199) = 2
    MarioFrameY(201) = 2
    MarioFrameY(202) = 2
    MarioFrameX(202) = -2
    MarioFrameY(203) = 2
    MarioFrameX(203) = -2
    MarioFrameX(204) = -2
    MarioFrameX(205) = -2
    MarioFrameX(206) = -2
    MarioFrameY(206) = 0
    MarioFrameY(207) = -4
    MarioFrameY(208) = 2
    MarioFrameY(209) = 2
    MarioFrameY(210) = 2
    MarioFrameX(209) = -2
    MarioFrameX(210) = -4
    MarioFrameY(288) = 2
    MarioFrameY(289) = 2
    MarioFrameY(290) = 2
    MarioFrameY(291) = 2
    MarioFrameY(292) = 2
    MarioFrameY(293) = -4
    MarioFrameX(294) = -2
    MarioFrameY(294) = 0
    MarioFrameX(295) = -2
    MarioFrameX(296) = -2
    MarioFrameX(297) = -2
    MarioFrameY(297) = 2
    MarioFrameX(298) = -2
    MarioFrameY(298) = 2
    MarioFrameY(299) = 2
    MarioFrameY(301) = 2
    MarioFrameY(302) = 2
    MarioFrameX(302) = -2
    MarioFrameY(303) = 2
    MarioFrameX(303) = -2
    MarioFrameX(304) = -2
    MarioFrameX(305) = -2
    MarioFrameX(306) = -2
    MarioFrameY(306) = 0
    MarioFrameY(307) = -4
    MarioFrameY(308) = 2
    MarioFrameY(309) = 2
    MarioFrameY(310) = 2
    MarioFrameX(309) = -2
    MarioFrameX(310) = -4
    MarioFrameY(311) = 2
    MarioFrameY(312) = 2
    MarioFrameX(382) = -4
    MarioFrameX(383) = -4
    MarioFrameX(384) = -4
    MarioFrameY(385) = -2
    MarioFrameX(386) = -14
    MarioFrameX(389) = -2
    MarioFrameY(393) = -4
    MarioFrameX(394) = -2
    MarioFrameY(394) = -4
    MarioFrameX(395) = -2
    MarioFrameX(396) = -2
    MarioFrameX(397) = -2
    MarioFrameX(398) = -2
    MarioFrameX(401) = -14
    MarioFrameX(402) = -14
    MarioFrameX(403) = -16
    MarioFrameX(404) = -16
    MarioFrameX(405) = -16
    MarioFrameY(406) = -4
    MarioFrameX(407) = -14
    MarioFrameY(407) = -4
    MarioFrameX(408) = -14
    MarioFrameX(409) = -16
    MarioFrameX(410) = -18
    MarioFrameX(411) = -14
    MarioFrameX(412) = -18
    MarioFrameX(413) = -4
    MarioFrameX(414) = -4
    MarioFrameX(415) = -4
    MarioFrameY(415) = -2
    MarioFrameX(416) = -16
    MarioFrameX(417) = -16
    MarioFrameX(418) = -16
    MarioFrameX(419) = -16
    MarioFrameX(420) = -16
    MarioFrameX(421) = -16
    LuigiFrameY(96) = 0
    LuigiFrameX(97) = -4
    LuigiFrameX(98) = -2
    LuigiFrameY(98) = 0
    LuigiFrameY(99) = 2
    LuigiFrameY(101) = 2
    LuigiFrameX(102) = -4
    LuigiFrameY(102) = 0
    LuigiFrameX(103) = -4
    LuigiFrameY(104) = 0
    LuigiFrameX(105) = -2
    LuigiFrameX(106) = -4
    LuigiFrameY(190) = 2
    LuigiFrameY(191) = 2
    LuigiFrameY(192) = 2
    LuigiFrameY(193) = -6
    LuigiFrameX(194) = -2
    LuigiFrameY(194) = 0
    LuigiFrameX(195) = -2
    LuigiFrameX(196) = -2
    LuigiFrameX(197) = -2
    LuigiFrameY(197) = 2
    LuigiFrameX(198) = -2
    LuigiFrameY(198) = 2
    LuigiFrameY(199) = 2
    LuigiFrameY(201) = 2
    LuigiFrameY(202) = 2
    LuigiFrameX(202) = -2
    LuigiFrameY(203) = 2
    LuigiFrameX(203) = -2
    LuigiFrameX(204) = -2
    LuigiFrameX(205) = -2
    LuigiFrameX(206) = -2
    LuigiFrameY(206) = 0
    LuigiFrameY(207) = -6
    LuigiFrameY(208) = 2
    LuigiFrameY(209) = 2
    LuigiFrameY(210) = 2
    LuigiFrameX(209) = -2
    LuigiFrameX(210) = -4
    LuigiFrameY(288) = 2
    LuigiFrameY(289) = 2
    LuigiFrameY(290) = 2
    LuigiFrameY(291) = 2
    LuigiFrameY(292) = 2
    LuigiFrameY(293) = -6
    LuigiFrameX(294) = -2
    LuigiFrameY(294) = 0
    LuigiFrameX(295) = -2
    LuigiFrameX(296) = -2
    LuigiFrameX(297) = -2
    LuigiFrameY(297) = 2
    LuigiFrameX(298) = -2
    LuigiFrameY(298) = 2
    LuigiFrameY(299) = 2
    LuigiFrameY(301) = 2
    LuigiFrameY(302) = 2
    LuigiFrameX(302) = -2
    LuigiFrameY(303) = 2
    LuigiFrameX(303) = -2
    LuigiFrameX(304) = -2
    LuigiFrameX(305) = -2
    LuigiFrameX(306) = -2
    LuigiFrameY(306) = 0
    LuigiFrameY(307) = -6
    LuigiFrameY(308) = 2
    LuigiFrameY(309) = 2
    LuigiFrameY(310) = 2
    LuigiFrameX(309) = -2
    LuigiFrameX(310) = -4
    LuigiFrameY(311) = 2
    LuigiFrameY(312) = 2
    LuigiFrameX(382) = -4
    LuigiFrameX(383) = -4
    LuigiFrameX(384) = -2
    LuigiFrameX(386) = -14
    LuigiFrameX(389) = -2
    LuigiFrameY(393) = -4
    LuigiFrameX(394) = -2
    LuigiFrameY(394) = 0
    LuigiFrameX(395) = -2
    LuigiFrameX(396) = -2
    LuigiFrameX(397) = -2
    LuigiFrameX(398) = -2
    LuigiFrameX(401) = -14
    LuigiFrameX(402) = -14
    LuigiFrameX(403) = -16
    LuigiFrameX(404) = -16
    LuigiFrameX(405) = -16
    LuigiFrameY(406) = 0
    LuigiFrameX(407) = -14
    LuigiFrameY(407) = -4
    LuigiFrameX(408) = -14
    LuigiFrameX(409) = -16
    LuigiFrameX(410) = -18
    LuigiFrameX(411) = -14
    LuigiFrameX(412) = -18
    LuigiFrameX(413) = -4
    LuigiFrameX(414) = -4
    LuigiFrameX(415) = -4
    LuigiFrameX(416) = -16
    LuigiFrameX(417) = -16
    LuigiFrameX(418) = -16
    LuigiFrameX(419) = -16
    LuigiFrameX(420) = -18
    LuigiFrameX(421) = -16
    For A = 150 To maxPlayerFrames 'Adjust the players frames to their new sizes
        MarioFrameX(A) = MarioFrameX(A) - 2
        LuigiFrameX(A) = LuigiFrameX(A) - 2
        LuigiFrameY(A) = LuigiFrameY(A) - 2
    Next A
    LuigiFrameY(101) = LuigiFrameY(101) - 2
    LuigiFrameY(102) = LuigiFrameY(102) - 2
    LuigiFrameY(105) = LuigiFrameY(105) - 2
    LuigiFrameY(106) = LuigiFrameY(106) - 2
    LuigiFrameY(99) = LuigiFrameY(99) - 2
    LuigiFrameY(98) = LuigiFrameY(98) - 2
    LuigiFrameY(95) = LuigiFrameY(95) - 2
    LuigiFrameY(94) = LuigiFrameY(94) - 2
'Yoshi Frames
    MarioFrameX(130) = -2 - 4
    MarioFrameX(70) = 6 - 4
    MarioFrameY(130) = 18
    MarioFrameY(70) = 18
    MarioFrameX(230) = -4 - 4
    MarioFrameX(170) = 4 - 4
    MarioFrameX(330) = -4 - 4
    MarioFrameX(270) = 4 - 4
    MarioFrameX(430) = -20 - 4
    MarioFrameX(370) = 4 - 4
    MarioFrameY(430) = -2
    MarioFrameY(370) = -2
    LuigiFrameX(130) = -2 - 4
    LuigiFrameX(70) = 6 - 4
    LuigiFrameY(130) = 16
    LuigiFrameY(70) = 16
    LuigiFrameY(230) = -4
    LuigiFrameY(170) = -4
    LuigiFrameY(330) = -4
    LuigiFrameY(270) = -4
    LuigiFrameY(430) = -6
    LuigiFrameY(370) = -6
    LuigiFrameX(230) = -6 - 4
    LuigiFrameX(170) = 4 - 4
    LuigiFrameX(330) = -6 - 4
    LuigiFrameX(270) = 4 - 4
    LuigiFrameX(430) = -20 - 4
    LuigiFrameX(370) = 4 - 4
    MarioFrameX(131) = -2 - 2
    MarioFrameX(69) = 6 - 4
    MarioFrameY(131) = 22
    MarioFrameY(69) = 22
    MarioFrameX(231) = -4 - 3
    MarioFrameX(169) = 4 - 6
    MarioFrameY(231) = 8
    MarioFrameY(169) = 8
    MarioFrameX(331) = -4 - 2
    MarioFrameX(269) = 4 - 6
    MarioFrameY(331) = 8
    MarioFrameY(269) = 8
    MarioFrameX(431) = -20
    MarioFrameX(369) = 4 - 6
    MarioFrameY(431) = 6
    MarioFrameY(369) = 6
    LuigiFrameX(131) = -2 - 2
    LuigiFrameX(69) = 6 - 4
    LuigiFrameY(131) = 22
    LuigiFrameY(69) = 22
    LuigiFrameX(231) = -6
    LuigiFrameX(169) = 4 - 6
    LuigiFrameY(231) = 4
    LuigiFrameY(169) = 4
    LuigiFrameX(331) = -6
    LuigiFrameX(269) = 4 - 6
    LuigiFrameY(331) = 4
    LuigiFrameY(269) = 4
    LuigiFrameX(431) = -20
    LuigiFrameX(369) = 4 - 6
    LuigiFrameY(431) = 2
    LuigiFrameY(369) = 2
'Facing Frames
    MarioFrameX(113) = -2
    MarioFrameY(113) = 2
    MarioFrameX(115) = -2
    MarioFrameY(115) = 2
    MarioFrameX(87) = MarioFrameX(113)
    MarioFrameY(87) = MarioFrameY(113)
    MarioFrameX(85) = MarioFrameX(115)
    MarioFrameY(85) = MarioFrameY(115)
    MarioFrameX(213) = -4
    MarioFrameY(213) = 2
    MarioFrameX(215) = -4
    MarioFrameY(215) = 2
    MarioFrameX(187) = MarioFrameX(213)
    MarioFrameY(187) = MarioFrameY(213)
    MarioFrameX(185) = MarioFrameX(215)
    MarioFrameY(185) = MarioFrameY(215)
    MarioFrameX(313) = -4
    MarioFrameY(313) = 2
    MarioFrameX(315) = -4
    MarioFrameY(315) = 2
    MarioFrameX(287) = MarioFrameX(313)
    MarioFrameY(287) = MarioFrameY(313)
    MarioFrameX(285) = MarioFrameX(315)
    MarioFrameY(285) = MarioFrameY(315)
    MarioFrameX(413) = -4
    MarioFrameY(413) = 0
    MarioFrameX(415) = -4
    MarioFrameY(415) = -2
    MarioFrameX(387) = MarioFrameX(413)
    MarioFrameY(387) = MarioFrameY(413)
    MarioFrameX(385) = MarioFrameX(415)
    MarioFrameY(385) = MarioFrameY(415)
    LuigiFrameX(113) = -2
    LuigiFrameY(113) = 2
    LuigiFrameX(115) = -2
    LuigiFrameY(115) = 2
    LuigiFrameX(87) = LuigiFrameX(113)
    LuigiFrameY(87) = LuigiFrameY(113)
    LuigiFrameX(85) = LuigiFrameX(115)
    LuigiFrameY(85) = LuigiFrameY(115)
    LuigiFrameX(213) = -4
    LuigiFrameY(213) = 2
    LuigiFrameX(215) = -4
    LuigiFrameY(215) = 2
    LuigiFrameX(187) = LuigiFrameX(213)
    LuigiFrameY(187) = LuigiFrameY(213)
    LuigiFrameX(185) = LuigiFrameX(215)
    LuigiFrameY(185) = LuigiFrameY(215)
    LuigiFrameX(313) = -4
    LuigiFrameY(313) = 2
    LuigiFrameX(315) = -4
    LuigiFrameY(315) = 2
    LuigiFrameX(287) = LuigiFrameX(313)
    LuigiFrameY(287) = LuigiFrameY(313)
    LuigiFrameX(285) = LuigiFrameX(315)
    LuigiFrameY(285) = LuigiFrameY(315)
    LuigiFrameX(413) = -4
    LuigiFrameY(413) = 0
    LuigiFrameX(415) = -4
    LuigiFrameY(415) = -2
    LuigiFrameX(387) = LuigiFrameX(413)
    LuigiFrameY(387) = LuigiFrameY(413)
    LuigiFrameX(385) = LuigiFrameX(415)
    LuigiFrameY(385) = LuigiFrameY(415)
    LuigiFrameX(113) = 0 '-2
    LuigiFrameY(113) = 0
    LuigiFrameX(115) = 0 '-2
    LuigiFrameY(115) = 0
    LuigiFrameX(87) = LuigiFrameX(113)
    LuigiFrameY(87) = LuigiFrameY(113)
    LuigiFrameX(85) = LuigiFrameX(115)
    LuigiFrameY(85) = LuigiFrameY(115)
    LuigiFrameX(213) = -4
    LuigiFrameY(213) = 0
    LuigiFrameX(215) = -4
    LuigiFrameY(215) = 0
    LuigiFrameX(187) = LuigiFrameX(213)
    LuigiFrameY(187) = LuigiFrameY(213)
    LuigiFrameX(185) = LuigiFrameX(215)
    LuigiFrameY(185) = LuigiFrameY(215)
    LuigiFrameX(313) = -4
    LuigiFrameY(313) = 0
    LuigiFrameX(315) = -4
    LuigiFrameY(315) = 0
    LuigiFrameX(287) = LuigiFrameX(313)
    LuigiFrameY(287) = LuigiFrameY(313)
    LuigiFrameX(285) = LuigiFrameX(315)
    LuigiFrameY(285) = LuigiFrameY(315)
    LuigiFrameX(413) = -4
    LuigiFrameY(413) = -2
    LuigiFrameX(415) = -4
    LuigiFrameY(415) = -2
    LuigiFrameX(387) = LuigiFrameX(413)
    LuigiFrameY(387) = LuigiFrameY(413)
    LuigiFrameX(385) = LuigiFrameX(415)
    LuigiFrameY(385) = LuigiFrameY(415)
    For A = 450 To 550
        MarioFrameX(A) = MarioFrameX(A - 100)
        MarioFrameY(A) = MarioFrameY(A - 100)
        LuigiFrameX(A) = LuigiFrameX(A - 100)
        LuigiFrameY(A) = LuigiFrameY(A - 100)
        MarioFrameX(A + 100) = MarioFrameX(A - 200)
        MarioFrameY(A + 100) = MarioFrameY(A - 200)
        LuigiFrameX(A + 100) = LuigiFrameX(A - 200)
        LuigiFrameY(A + 100) = LuigiFrameY(A - 200)
    Next A
    MarioFrameY(508) = MarioFrameY(508) - 2
    MarioFrameY(509) = MarioFrameY(509) - 2
    MarioFrameY(510) = MarioFrameY(510) - 2
    MarioFrameY(492) = MarioFrameY(492) - 2
    MarioFrameY(491) = MarioFrameY(491) - 2
    MarioFrameY(490) = MarioFrameY(490) - 2
    MarioFrameY(501) = -2
    MarioFrameY(499) = -2
    MarioFrameY(502) = -2
    MarioFrameY(498) = -2
    MarioFrameY(503) = 0
    MarioFrameY(497) = 0
    MarioFrameY(512) = -2
    MarioFrameY(513) = -2
    MarioFrameY(514) = -2
    MarioFrameY(515) = 0
    MarioFrameY(488) = -2
    MarioFrameY(487) = -2
    MarioFrameY(486) = -2
    MarioFrameY(485) = 0
    MarioFrameX(513) = -6
    MarioFrameX(514) = -6
    MarioFrameX(515) = -6
    MarioFrameX(485) = -2
    MarioFrameX(487) = -2
    MarioFrameX(518) = -16
    MarioFrameX(517) = -16
    MarioFrameX(516) = -16
    MarioFrameY(530) = MarioFrameY(530) - 2
    MarioFrameY(531) = MarioFrameY(531) - 2
    MarioFrameY(470) = MarioFrameY(470) - 2
    MarioFrameY(569) = MarioFrameY(469) - 2
    MarioFrameY(500) = -2
    MarioFrameX(500) = -4
    LuigiFrameY(500) = 4
    LuigiFrameX(500) = -4
    MarioFrameX(513) = -4
    MarioFrameX(487) = -4
    MarioFrameX(601) = -6
    MarioFrameY(601) = 0
    MarioFrameY(599) = 0
    MarioFrameY(602) = 0
    MarioFrameY(603) = 0
    MarioFrameY(598) = 0
    MarioFrameY(597) = 0
    MarioFrameY(604) = -2
    MarioFrameY(605) = -2
    MarioFrameY(596) = -2
    MarioFrameY(595) = -2
    MarioFrameY(613) = -2
    MarioFrameY(587) = -2
    MarioFrameY(615) = 0
    MarioFrameY(585) = 0
    MarioFrameX(608) = -6
    MarioFrameY(608) = 0
    MarioFrameY(592) = 0
    MarioFrameX(609) = -6
    MarioFrameY(609) = 0
    MarioFrameY(591) = 0
    MarioFrameY(610) = 0
    MarioFrameY(590) = 0
    MarioFrameY(611) = 0
    MarioFrameX(611) = -6
    MarioFrameY(589) = 0
    MarioFrameY(612) = 0
    MarioFrameX(612) = -6
    MarioFrameY(588) = 0
    MarioFrameY(613) = 0
    MarioFrameY(587) = 0
    MarioFrameY(630) = -2
    MarioFrameY(570) = -2
    MarioFrameY(631) = 6
    MarioFrameY(569) = 6
    MarioFrameY(469) = 4
    MarioFrameY(607) = 0
    MarioFrameY(593) = 0
    MarioFrameX(593) = -6
    LuigiFrameX(601) = -6
    LuigiFrameX(608) = -6
    LuigiFrameX(609) = -6
    LuigiFrameX(611) = -6
    LuigiFrameX(612) = -6
    LuigiFrameX(630) = -12
    LuigiFrameY(607) = 0
    LuigiFrameY(593) = 0
        MarioFrameX(225) = -4
        MarioFrameX(226) = -4
        MarioFrameX(175) = -4
        MarioFrameX(174) = -4
        MarioFrameX(325) = -4
        MarioFrameX(326) = -4
        MarioFrameX(275) = -4
        MarioFrameX(274) = -4
        MarioFrameX(425) = -4
        MarioFrameX(426) = -4
        MarioFrameX(375) = -4
        MarioFrameX(374) = -4
        MarioFrameX(525) = -4
        MarioFrameX(526) = -4
        MarioFrameX(475) = -4
        MarioFrameX(474) = -4
        MarioFrameX(625) = -4
        MarioFrameX(626) = -4
        MarioFrameX(575) = -4
        MarioFrameX(574) = -4
        MarioFrameX(125) = -2
        MarioFrameX(126) = -2
        MarioFrameX(75) = -2
        MarioFrameX(74) = -2
        LuigiFrameX(225) = -4
        LuigiFrameX(226) = -4
        LuigiFrameX(175) = -4
        LuigiFrameX(174) = -4
        LuigiFrameX(325) = -4
        LuigiFrameX(326) = -4
        LuigiFrameX(275) = -4
        LuigiFrameX(274) = -4
        LuigiFrameX(425) = -4
        LuigiFrameX(426) = -4
        LuigiFrameX(375) = -4
        LuigiFrameX(374) = -4
        LuigiFrameX(525) = -4
        LuigiFrameX(526) = -4
        LuigiFrameX(475) = -4
        LuigiFrameX(474) = -4
        LuigiFrameX(625) = -4
        LuigiFrameX(626) = -4
        LuigiFrameX(575) = -4
        LuigiFrameX(574) = -4
    LuigiFrameX(124) = -4
    LuigiFrameX(76) = -4
    LuigiFrameX(224) = -4
    LuigiFrameX(176) = -4
    LuigiFrameX(324) = -4
    LuigiFrameX(276) = -4
    LuigiFrameX(424) = -4
    LuigiFrameX(376) = -4
    LuigiFrameX(524) = -4
    LuigiFrameX(476) = -4
    LuigiFrameX(624) = -4
    LuigiFrameX(576) = -4
    
    LuigiFrameY(224) = 2
    LuigiFrameY(176) = 2
    LuigiFrameY(324) = 2
    LuigiFrameY(276) = 2
    LuigiFrameY(424) = 0
    LuigiFrameY(376) = 0
    LuigiFrameY(524) = 0
    LuigiFrameY(476) = 0
    LuigiFrameY(624) = 2
    LuigiFrameY(576) = 2
    
    
    MarioFrameX(124) = -4
    MarioFrameX(76) = -2
    MarioFrameX(224) = -4
    MarioFrameX(176) = -4
    MarioFrameX(324) = -4
    MarioFrameX(276) = -4
    MarioFrameX(424) = -4
    MarioFrameX(376) = -4
    MarioFrameX(524) = -4
    MarioFrameX(476) = -4
    MarioFrameX(624) = -4
    MarioFrameX(576) = -4
    MarioFrameY(224) = 4
    MarioFrameY(176) = 4
    MarioFrameY(324) = 4
    MarioFrameY(276) = 4
    MarioFrameY(424) = 2
    MarioFrameY(376) = 2
    MarioFrameY(524) = 2
    MarioFrameY(476) = 2
    MarioFrameY(624) = 2
    MarioFrameY(576) = 2
    
    
    
    MarioFrameX(140) = -4
    MarioFrameY(140) = 2
    MarioFrameX(141) = -4
    MarioFrameY(141) = 2
    MarioFrameX(142) = -4
    MarioFrameY(142) = 2
    MarioFrameX(143) = -4
    MarioFrameY(143) = 2
    MarioFrameX(60) = -4
    MarioFrameY(60) = 2
    MarioFrameX(59) = -4
    MarioFrameY(59) = 2
    MarioFrameX(58) = 0
    MarioFrameY(58) = 2
    MarioFrameX(57) = 0
    MarioFrameY(57) = 2
    MarioFrameX(240) = -8
    MarioFrameY(240) = 2
    MarioFrameX(241) = -8
    MarioFrameY(241) = 2
    MarioFrameX(242) = -8
    MarioFrameY(242) = 2
    MarioFrameX(243) = -8
    MarioFrameY(243) = 2
    MarioFrameX(244) = -8
    MarioFrameY(244) = 2
    MarioFrameX(160) = -6
    MarioFrameY(160) = 2
    MarioFrameX(159) = -6
    MarioFrameY(159) = 2
    MarioFrameX(158) = -6
    MarioFrameY(158) = 2
    MarioFrameX(157) = -4
    MarioFrameY(157) = 2
    MarioFrameX(156) = -6
    MarioFrameY(156) = 2
    MarioFrameX(340) = -8
    MarioFrameY(340) = 2
    MarioFrameX(341) = -8
    MarioFrameY(341) = 2
    MarioFrameX(342) = -8
    MarioFrameY(342) = 2
    MarioFrameX(343) = -8
    MarioFrameY(343) = 2
    MarioFrameX(344) = -8
    MarioFrameY(344) = 2
    MarioFrameX(260) = -6
    MarioFrameY(260) = 2
    MarioFrameX(259) = -6
    MarioFrameY(259) = 2
    MarioFrameX(258) = -6
    MarioFrameY(258) = 2
    MarioFrameX(257) = -4
    MarioFrameY(257) = 2
    MarioFrameX(256) = -6
    MarioFrameY(256) = 2
    MarioFrameX(540) = -18
    MarioFrameY(540) = 0
    MarioFrameX(541) = -18
    MarioFrameY(541) = 0
    MarioFrameX(542) = -18
    MarioFrameY(542) = 0
    MarioFrameX(543) = -18
    MarioFrameY(543) = 0
    MarioFrameX(544) = -18
    MarioFrameY(544) = 0
    MarioFrameX(460) = -6
    MarioFrameY(460) = 0
    MarioFrameX(459) = -6
    MarioFrameY(459) = 0
    MarioFrameX(458) = -6
    MarioFrameY(458) = 0
    MarioFrameX(457) = -4
    MarioFrameY(457) = 0
    MarioFrameX(456) = -6
    MarioFrameY(456) = 0
    MarioFrameX(440) = -18
    MarioFrameY(440) = 0
    MarioFrameX(441) = -18
    MarioFrameY(441) = 0
    MarioFrameX(442) = -18
    MarioFrameY(442) = 0
    MarioFrameX(443) = -18
    MarioFrameY(443) = 0
    MarioFrameX(444) = -18
    MarioFrameY(444) = 0
    MarioFrameX(360) = -6
    MarioFrameY(360) = 0
    MarioFrameX(359) = -6
    MarioFrameY(359) = 0
    MarioFrameX(358) = -6
    MarioFrameY(358) = 0
    MarioFrameX(357) = -4
    MarioFrameY(357) = 0
    MarioFrameX(356) = -6
    MarioFrameY(356) = 0
    MarioFrameX(640) = -8
    MarioFrameY(640) = 0
    MarioFrameX(641) = -8
    MarioFrameY(641) = 0
    MarioFrameX(642) = -8
    MarioFrameY(642) = 0
    MarioFrameX(643) = -8
    MarioFrameY(643) = 0
    MarioFrameX(644) = -8
    MarioFrameY(644) = 0
    MarioFrameX(560) = -6
    MarioFrameY(560) = 0
    MarioFrameX(559) = -6
    MarioFrameY(559) = 0
    MarioFrameX(558) = -6
    MarioFrameY(558) = 0
    MarioFrameX(557) = -4
    MarioFrameY(557) = 0
    MarioFrameX(556) = -6
    MarioFrameY(556) = 0

 
 
            MarioFrameX(515) = -4
        MarioFrameX(485) = -4
   
    
    
    
    
    
    LuigiFrameX(640) = -10
    LuigiFrameY(640) = 0
    LuigiFrameX(641) = -10
    LuigiFrameY(641) = 0
    LuigiFrameX(642) = -10
    LuigiFrameY(642) = 0
    LuigiFrameX(643) = -10
    LuigiFrameY(643) = 0
    LuigiFrameX(644) = -10
    LuigiFrameY(644) = 0
    
    LuigiFrameX(560) = -4
    LuigiFrameY(560) = 0
    LuigiFrameX(559) = -4
    LuigiFrameY(559) = 0
    LuigiFrameX(558) = -4
    LuigiFrameY(558) = 0
    LuigiFrameX(557) = -2
    LuigiFrameY(557) = 0
    LuigiFrameX(556) = -2
    LuigiFrameY(556) = 0
 
 
    LuigiFrameX(540) = -20
    LuigiFrameY(540) = -2
    LuigiFrameX(541) = -20
    LuigiFrameY(541) = -2
    LuigiFrameX(542) = -20
    LuigiFrameY(542) = -2
    LuigiFrameX(543) = -20
    LuigiFrameY(543) = -2
    LuigiFrameX(544) = -20
    LuigiFrameY(544) = -2
    LuigiFrameX(460) = -4
    LuigiFrameY(460) = -2
    LuigiFrameX(459) = -4
    LuigiFrameY(459) = -2
    LuigiFrameX(458) = -4
    LuigiFrameY(458) = -2
    LuigiFrameX(457) = -2
    LuigiFrameY(457) = -2
    LuigiFrameX(456) = -2
    LuigiFrameY(456) = -2
 
 
 
    LuigiFrameX(140) = -4
    LuigiFrameY(140) = 0
    LuigiFrameX(141) = -4
    LuigiFrameY(141) = 0
    LuigiFrameX(142) = -4
    LuigiFrameY(142) = 0
    LuigiFrameX(143) = -4
    LuigiFrameY(143) = 0
    LuigiFrameX(60) = -6
    LuigiFrameY(60) = 0
    LuigiFrameX(59) = -6
    LuigiFrameY(59) = 0
    LuigiFrameX(58) = 0
    LuigiFrameY(58) = 0
    LuigiFrameX(57) = 0
    LuigiFrameY(57) = 0
    
    LuigiFrameX(240) = -10
    LuigiFrameY(240) = 0
    LuigiFrameX(241) = -10
    LuigiFrameY(241) = 0
    LuigiFrameX(242) = -10
    LuigiFrameY(242) = 0
    LuigiFrameX(243) = -10
    LuigiFrameY(243) = 0
    LuigiFrameX(244) = -10
    LuigiFrameY(244) = 0
    LuigiFrameX(160) = -4
    LuigiFrameY(160) = 0
    LuigiFrameX(159) = -4
    LuigiFrameY(159) = 0
    LuigiFrameX(158) = -4
    LuigiFrameY(158) = 0
    LuigiFrameX(157) = -2
    LuigiFrameY(157) = 0
    LuigiFrameX(156) = -2
    LuigiFrameY(156) = 0
    
    LuigiFrameX(340) = -10
    LuigiFrameY(340) = 0
    LuigiFrameX(341) = -10
    LuigiFrameY(341) = 0
    LuigiFrameX(342) = -10
    LuigiFrameY(342) = 0
    LuigiFrameX(343) = -10
    LuigiFrameY(343) = 0
    LuigiFrameX(344) = -10
    LuigiFrameY(344) = 0
    LuigiFrameX(260) = -4
    LuigiFrameY(260) = 0
    LuigiFrameX(259) = -4
    LuigiFrameY(259) = 0
    LuigiFrameX(258) = -4
    LuigiFrameY(258) = 0
    LuigiFrameX(257) = -2
    LuigiFrameY(257) = 0
    LuigiFrameX(256) = -2
    LuigiFrameY(256) = 0
 
 
    LuigiFrameX(440) = -20
    LuigiFrameY(440) = -2
    LuigiFrameX(441) = -20
    LuigiFrameY(441) = -2
    LuigiFrameX(442) = -20
    LuigiFrameY(442) = -2
    LuigiFrameX(443) = -20
    LuigiFrameY(443) = -2
    LuigiFrameX(444) = -20
    LuigiFrameY(444) = -2
    LuigiFrameX(360) = -4
    LuigiFrameY(360) = -2
    LuigiFrameX(359) = -4
    LuigiFrameY(359) = -2
    LuigiFrameX(358) = -4
    LuigiFrameY(358) = -2
    LuigiFrameX(357) = -2
    LuigiFrameY(357) = -2
    LuigiFrameX(356) = -2
    LuigiFrameY(356) = -2
    
        MarioFrameY(122) = -8
        MarioFrameY(123) = -6
        MarioFrameY(78) = -8
        MarioFrameX(78) = -4
        MarioFrameY(77) = -6
        
        MarioFrameY(222) = -24
        MarioFrameX(222) = -4
        MarioFrameY(223) = -6 - 24
        MarioFrameX(223) = -4
        MarioFrameY(178) = -24
        MarioFrameX(178) = -4
        MarioFrameY(177) = -6 - 24
        MarioFrameX(177) = -4
        MarioFrameY(322) = -24
        MarioFrameX(322) = -4
        MarioFrameY(323) = -6 - 24
        MarioFrameX(323) = -4
        MarioFrameY(278) = -24
        MarioFrameX(278) = -4
        MarioFrameY(277) = -6 - 24
        MarioFrameX(277) = -4
        MarioFrameY(422) = -24 - 2
        MarioFrameX(422) = -4
        MarioFrameY(423) = -6 - 24
        MarioFrameX(423) = -4
        MarioFrameY(378) = -24 - 2
        MarioFrameX(378) = -4
        MarioFrameY(377) = -6 - 24
        MarioFrameX(377) = -4
        
        MarioFrameY(522) = -24 - 2
        MarioFrameX(522) = -4
        MarioFrameY(523) = -6 - 24
        MarioFrameX(523) = -4
        MarioFrameY(478) = -24 - 2
        MarioFrameX(478) = -4
        MarioFrameY(477) = -6 - 24
        MarioFrameX(477) = -4
        
        MarioFrameY(622) = -24 - 2
        MarioFrameX(622) = -4
        MarioFrameY(623) = -6 - 24
        MarioFrameX(623) = -4
        MarioFrameY(578) = -24 - 2
        MarioFrameX(578) = -4
        MarioFrameY(577) = -6 - 24
        MarioFrameX(577) = -4
        LuigiFrameY(122) = -8
        LuigiFrameY(123) = -6
        LuigiFrameX(123) = -2
        LuigiFrameY(78) = -8
        LuigiFrameX(78) = -4
        LuigiFrameY(77) = -6
        LuigiFrameY(222) = -24 - 4
        LuigiFrameX(222) = -4
        LuigiFrameY(223) = -8 - 24
        LuigiFrameX(223) = -4
        LuigiFrameY(178) = -24 - 4
        LuigiFrameX(178) = -4
        LuigiFrameY(177) = -8 - 24
        LuigiFrameX(177) = -4
        
        LuigiFrameY(322) = -24 - 4
        LuigiFrameX(322) = -4
        LuigiFrameY(323) = -8 - 24
        LuigiFrameX(323) = -4
        LuigiFrameY(278) = -24 - 4
        LuigiFrameX(278) = -4
        LuigiFrameY(277) = -8 - 24
        LuigiFrameX(277) = -4
        
        LuigiFrameY(422) = -24 - 4
        LuigiFrameX(422) = -4
        LuigiFrameY(423) = -8 - 24
        LuigiFrameX(423) = -4
        LuigiFrameY(378) = -24 - 4
        LuigiFrameX(378) = -4
        LuigiFrameY(377) = -8 - 24
        LuigiFrameX(377) = -4
        
        LuigiFrameY(522) = -24 - 4
        LuigiFrameX(522) = -4
        LuigiFrameY(523) = -8 - 24
        LuigiFrameX(523) = -4
        LuigiFrameY(478) = -24 - 4
        LuigiFrameX(478) = -4
        LuigiFrameY(477) = -8 - 24
        LuigiFrameX(477) = -4
        
        LuigiFrameY(622) = -24 - 4
        LuigiFrameX(622) = -4
        LuigiFrameY(623) = -8 - 24
        LuigiFrameX(623) = -4
        LuigiFrameY(578) = -24 - 4
        LuigiFrameX(578) = -4
        LuigiFrameY(577) = -8 - 24
        LuigiFrameX(577) = -4
    LuigiFrameY(207) = -6
    LuigiFrameY(193) = -6
    LuigiFrameY(307) = -6
    LuigiFrameY(293) = -6
    
    For A = 650 To 750
        MarioFrameX(A) = MarioFrameX(A - 400)
        MarioFrameY(A) = MarioFrameY(A - 400)
        LuigiFrameX(A) = LuigiFrameX(A - 400)
        LuigiFrameY(A) = LuigiFrameY(A - 400)
        PeachFrameX(A) = PeachFrameX(A - 400)
        PeachFrameY(A) = PeachFrameY(A - 400)
        ToadFrameX(A) = ToadFrameX(A - 400)
        ToadFrameY(A) = ToadFrameY(A - 400)
        LinkFrameX(A) = LinkFrameX(A - 400)
        LinkFrameY(A) = LinkFrameY(A - 400)
    Next A
    
    PeachFrameX(401) = -16
    PeachFrameY(401) = -2
    PeachFrameX(399) = -4
    PeachFrameY(399) = -2
    PeachFrameX(402) = -16
    PeachFrameY(402) = -2
    PeachFrameX(398) = -4
    PeachFrameY(398) = -2
    PeachFrameX(403) = -16
    PeachFrameY(403) = -2
    PeachFrameX(397) = -4
    PeachFrameY(397) = -2
    PeachFrameX(404) = -14
    PeachFrameY(404) = -2
    PeachFrameX(396) = -4
    PeachFrameY(396) = -2
    PeachFrameX(405) = -14
    PeachFrameY(405) = -2
    PeachFrameX(395) = -4
    PeachFrameY(395) = -2
    PeachFrameX(406) = -8
    PeachFrameY(406) = -2
    PeachFrameX(394) = -14
    PeachFrameY(394) = -2
    PeachFrameX(407) = -4
    PeachFrameY(407) = -2
    PeachFrameX(393) = -4
    PeachFrameY(393) = -2
    PeachFrameX(408) = -14
    PeachFrameY(408) = -2
    PeachFrameX(392) = -4
    PeachFrameY(392) = -2
    PeachFrameX(409) = -14
    PeachFrameY(409) = -2
    PeachFrameX(391) = -4
    PeachFrameY(391) = -2
    PeachFrameX(410) = -16
    PeachFrameY(410) = -2
    PeachFrameX(390) = -4
    PeachFrameY(390) = -2
    PeachFrameX(412) = -16
    PeachFrameY(412) = -2
    PeachFrameX(388) = -4
    PeachFrameY(388) = -2
    PeachFrameX(413) = -4
    PeachFrameY(413) = -4
    PeachFrameX(387) = -4
    PeachFrameY(387) = -4
    PeachFrameX(414) = -4
    PeachFrameY(414) = -2
    PeachFrameX(386) = -16
    PeachFrameY(386) = -2
    PeachFrameX(415) = -4
    PeachFrameY(415) = -4
    PeachFrameX(385) = -4
    PeachFrameY(385) = -4
    PeachFrameX(419) = -13
    PeachFrameY(419) = 0
    PeachFrameX(381) = -11
    PeachFrameY(381) = 0
    PeachFrameX(420) = -13
    PeachFrameY(420) = 0
    PeachFrameX(380) = -11
    PeachFrameY(380) = 0
    PeachFrameX(421) = -13
    PeachFrameY(421) = 0
    PeachFrameX(379) = -11
    PeachFrameY(379) = 0
    PeachFrameX(422) = 0
    PeachFrameY(422) = -30
    PeachFrameX(378) = 0
    PeachFrameY(378) = -30
    PeachFrameX(423) = 0
    PeachFrameY(423) = -30
    PeachFrameX(377) = 0
    PeachFrameY(377) = -30
    PeachFrameX(425) = 0
    PeachFrameY(425) = -2
    PeachFrameX(375) = 0
    PeachFrameY(375) = -2
    PeachFrameX(426) = 0
    PeachFrameY(426) = -2
    PeachFrameX(374) = 0
    PeachFrameY(374) = -2
    PeachFrameX(427) = -4
    PeachFrameY(427) = -2
    PeachFrameX(373) = -4
    PeachFrameY(373) = -2
    PeachFrameX(501) = -16
    PeachFrameY(501) = -6
    PeachFrameX(499) = -4
    PeachFrameY(499) = -6
    PeachFrameX(502) = -18
    PeachFrameY(502) = -6
    PeachFrameX(498) = -4
    PeachFrameY(498) = -6
    PeachFrameX(503) = -16
    PeachFrameY(503) = -6
    PeachFrameX(497) = -4
    PeachFrameY(497) = -6
    PeachFrameX(504) = -14
    PeachFrameY(504) = -6
    PeachFrameX(496) = -4
    PeachFrameY(496) = -6
    PeachFrameX(505) = -14
    PeachFrameY(505) = -6
    PeachFrameX(495) = -4
    PeachFrameY(495) = -6
    PeachFrameX(506) = -8
    PeachFrameY(506) = -6
    PeachFrameX(494) = -12
    PeachFrameY(494) = -6
    PeachFrameX(507) = -4
    PeachFrameY(507) = -6
    PeachFrameX(493) = -4
    PeachFrameY(493) = -6
    PeachFrameX(508) = -16
    PeachFrameY(508) = -6
    PeachFrameX(492) = -4
    PeachFrameY(492) = -6
    PeachFrameX(509) = -18
    PeachFrameY(509) = -6
    PeachFrameX(491) = -4
    PeachFrameY(491) = -6
    PeachFrameX(510) = -18
    PeachFrameY(510) = -6
    PeachFrameX(490) = -4
    PeachFrameY(490) = -6
    PeachFrameX(512) = -16
    PeachFrameY(512) = -6
    PeachFrameX(488) = -4
    PeachFrameY(488) = -6
    PeachFrameX(513) = -4
    PeachFrameY(513) = -2
    PeachFrameX(487) = -4
    PeachFrameY(487) = -2
    PeachFrameX(514) = -4
    PeachFrameY(514) = -6
    PeachFrameX(486) = -16
    PeachFrameY(486) = -6
    PeachFrameX(515) = -4
    PeachFrameY(515) = -6
    PeachFrameX(485) = -4
    PeachFrameY(485) = -6
    PeachFrameX(519) = -13
    PeachFrameY(519) = -4
    PeachFrameX(481) = -9
    PeachFrameY(481) = -4
    PeachFrameX(520) = -13
    PeachFrameY(520) = -4
    PeachFrameX(480) = -9
    PeachFrameY(480) = -4
    PeachFrameX(521) = -13
    PeachFrameY(521) = -4
    PeachFrameX(479) = -9
    PeachFrameY(479) = -4
    PeachFrameX(522) = 0
    PeachFrameY(522) = -34
    PeachFrameX(478) = 0
    PeachFrameY(478) = -34
    PeachFrameX(523) = 0
    PeachFrameY(523) = -34
    PeachFrameX(477) = 0
    PeachFrameY(477) = -34
    PeachFrameX(525) = 0
    PeachFrameY(525) = 0
    PeachFrameX(475) = 0
    PeachFrameY(475) = 0
    PeachFrameX(526) = 0
    PeachFrameY(526) = 0
    PeachFrameX(474) = 0
    PeachFrameY(474) = 0
    PeachFrameX(527) = -6
    PeachFrameY(527) = -6
    PeachFrameX(473) = -6
    PeachFrameY(473) = -6
    PeachFrameX(500) = -5
    PeachFrameY(500) = -6
    
    PeachFrameX(601) = -10
    PeachFrameY(601) = -2
    PeachFrameX(599) = -4
    PeachFrameY(599) = -2
    PeachFrameX(602) = -10
    PeachFrameY(602) = -2
    PeachFrameX(598) = -4
    PeachFrameY(598) = -2
    PeachFrameX(603) = -8
    PeachFrameY(603) = -2
    PeachFrameX(597) = -4
    PeachFrameY(597) = -2
    PeachFrameX(604) = -8
    PeachFrameY(604) = -2
    PeachFrameX(596) = -4
    PeachFrameY(596) = -2
    PeachFrameX(605) = -8
    PeachFrameY(605) = -2
    PeachFrameX(595) = -4
    PeachFrameY(595) = -2
    PeachFrameX(606) = -6
    PeachFrameY(606) = -2
    PeachFrameX(594) = -6
    PeachFrameY(594) = -2
    PeachFrameX(607) = -4
    PeachFrameY(607) = -4
    PeachFrameX(593) = -4
    PeachFrameY(593) = -4
    PeachFrameX(608) = -6
    PeachFrameY(608) = -2
    PeachFrameX(592) = -4
    PeachFrameY(592) = -2
    PeachFrameX(609) = -6
    PeachFrameY(609) = -2
    PeachFrameX(591) = -4
    PeachFrameY(591) = -2
    PeachFrameX(610) = -8
    PeachFrameY(610) = -2
    PeachFrameX(590) = -4
    PeachFrameY(590) = -2
    PeachFrameX(611) = -6
    PeachFrameY(611) = -2
    PeachFrameX(589) = -4
    PeachFrameY(589) = -2
    PeachFrameX(612) = -6
    PeachFrameY(612) = -2
    PeachFrameX(588) = -4
    PeachFrameY(588) = -2
    PeachFrameX(613) = -4
    PeachFrameY(613) = 2
    PeachFrameX(587) = -4
    PeachFrameY(587) = 2
    PeachFrameX(615) = -4
    PeachFrameY(615) = -4
    PeachFrameX(585) = -4
    PeachFrameY(585) = -4
    PeachFrameX(622) = 0
    PeachFrameY(622) = -34
    PeachFrameX(578) = 0
    PeachFrameY(578) = -34
    PeachFrameX(623) = 0
    PeachFrameY(623) = -32
    PeachFrameX(577) = 0
    PeachFrameY(577) = -32
    PeachFrameX(625) = 0
    PeachFrameY(625) = 2
    PeachFrameX(575) = 0
    PeachFrameY(575) = 2
    PeachFrameX(626) = 0
    PeachFrameY(626) = 2
    PeachFrameX(574) = 0
    PeachFrameY(574) = 2
    PeachFrameX(627) = -4
    PeachFrameY(627) = -4
    PeachFrameX(573) = -4
    PeachFrameY(573) = -4
    
    ToadFrameX(401) = -14
    ToadFrameY(401) = -2
    ToadFrameX(399) = -4
    ToadFrameY(399) = -2
    ToadFrameX(402) = -12
    ToadFrameY(402) = -2
    ToadFrameX(398) = -4
    ToadFrameY(398) = -2
    ToadFrameX(403) = -18
    ToadFrameY(403) = -2
    ToadFrameX(397) = -4
    ToadFrameY(397) = -2
    ToadFrameX(404) = -18
    ToadFrameY(404) = -2
    ToadFrameX(396) = -4
    ToadFrameY(396) = -2
    ToadFrameX(405) = -18
    ToadFrameY(405) = -2
    ToadFrameX(395) = -4
    ToadFrameY(395) = -2
    ToadFrameX(406) = -6
    ToadFrameY(406) = -2
    ToadFrameX(394) = -4
    ToadFrameY(394) = -2
    ToadFrameX(407) = -4
    ToadFrameY(407) = 0
    ToadFrameX(393) = -4
    ToadFrameY(393) = 0
    ToadFrameX(408) = -16
    ToadFrameY(408) = -2
    ToadFrameX(392) = -4
    ToadFrameY(392) = -2
    ToadFrameX(409) = -14
    ToadFrameY(409) = -2
    ToadFrameX(391) = -4
    ToadFrameY(391) = -2
    ToadFrameX(410) = -18
    ToadFrameY(410) = -2
    ToadFrameX(390) = -4
    ToadFrameY(390) = -2
    ToadFrameX(411) = -14
    ToadFrameY(411) = -2
    ToadFrameX(389) = -4
    ToadFrameY(389) = -2
    ToadFrameX(412) = -16
    ToadFrameY(412) = -2
    ToadFrameX(388) = -4
    ToadFrameY(388) = -2
    ToadFrameX(413) = -4
    ToadFrameY(413) = -4
    ToadFrameX(387) = -4
    ToadFrameY(387) = -4
    ToadFrameX(414) = -4
    ToadFrameY(414) = -2
    ToadFrameX(386) = -14
    ToadFrameY(386) = -2
    ToadFrameX(415) = -4
    ToadFrameY(415) = -2
    ToadFrameX(385) = -4
    ToadFrameY(385) = -2
    ToadFrameX(416) = -18
    ToadFrameY(416) = -2
    ToadFrameX(384) = -8
    ToadFrameY(384) = -2
    ToadFrameX(417) = -18
    ToadFrameY(417) = -2
    ToadFrameX(383) = -8
    ToadFrameY(383) = -2
    ToadFrameX(418) = -18
    ToadFrameY(418) = -2
    ToadFrameX(382) = -8
    ToadFrameY(382) = -2
    ToadFrameX(419) = -12
    ToadFrameY(419) = -2
    ToadFrameX(381) = -8
    ToadFrameY(381) = -2
    ToadFrameX(420) = -18
    ToadFrameY(420) = -2
    ToadFrameX(380) = -8
    ToadFrameY(380) = -2
    ToadFrameX(421) = -14
    ToadFrameY(421) = -2
    ToadFrameX(379) = -8
    ToadFrameY(379) = -2
    ToadFrameX(422) = -4
    ToadFrameY(422) = -22
    ToadFrameX(378) = -4
    ToadFrameY(378) = -22
    ToadFrameX(423) = -4
    ToadFrameY(423) = -16
    ToadFrameX(377) = -4
    ToadFrameY(377) = -16
    ToadFrameX(424) = -8
    ToadFrameY(424) = 6
    ToadFrameX(376) = -4
    ToadFrameY(376) = 6
    ToadFrameX(425) = -4
    ToadFrameY(425) = -4
    ToadFrameX(375) = -4
    ToadFrameY(375) = -4
    ToadFrameX(426) = -4
    ToadFrameY(426) = -4
    ToadFrameX(374) = -4
    ToadFrameY(374) = -4
    ToadFrameX(427) = -4
    ToadFrameY(427) = 0
    ToadFrameX(373) = -4
    ToadFrameY(373) = 0
    
    
    
    
    ToadFrameX(501) = -12
    ToadFrameY(501) = -2
    ToadFrameX(499) = -4
    ToadFrameY(499) = -2
    ToadFrameX(502) = -12
    ToadFrameY(502) = -2
    ToadFrameX(498) = -4
    ToadFrameY(498) = -2
    ToadFrameX(503) = -18
    ToadFrameY(503) = -2
    ToadFrameX(497) = -4
    ToadFrameY(497) = -2
    ToadFrameX(504) = -18
    ToadFrameY(504) = -2
    ToadFrameX(496) = -4
    ToadFrameY(496) = -2
    ToadFrameX(505) = -18
    ToadFrameY(505) = -2
    ToadFrameX(495) = -4
    ToadFrameY(495) = -2
    ToadFrameX(506) = -6
    ToadFrameY(506) = -2
    ToadFrameX(494) = -4
    ToadFrameY(494) = -2
    ToadFrameX(507) = -4
    ToadFrameY(507) = 0
    ToadFrameX(493) = -4
    ToadFrameY(493) = 0
    ToadFrameX(508) = -12
    ToadFrameY(508) = -2
    ToadFrameX(492) = -4
    ToadFrameY(492) = -2
    ToadFrameX(509) = -12
    ToadFrameY(509) = -2
    ToadFrameX(491) = -4
    ToadFrameY(491) = -2
    ToadFrameX(510) = -18
    ToadFrameY(510) = -2
    ToadFrameX(490) = -4
    ToadFrameY(490) = -2
    ToadFrameX(511) = -14
    ToadFrameY(511) = -2
    ToadFrameX(489) = -4
    ToadFrameY(489) = -2
    ToadFrameX(512) = -14
    ToadFrameY(512) = -2
    ToadFrameX(488) = -4
    ToadFrameY(488) = -2
    ToadFrameX(513) = -4
    ToadFrameY(513) = -4
    ToadFrameX(487) = -4
    ToadFrameY(487) = -4
    ToadFrameX(514) = -4
    ToadFrameY(514) = -2
    ToadFrameX(486) = -12
    ToadFrameY(486) = -2
    ToadFrameX(515) = -4
    ToadFrameY(515) = -2
    ToadFrameX(485) = -4
    ToadFrameY(485) = -2
    ToadFrameX(516) = -12
    ToadFrameY(516) = -2
    ToadFrameX(484) = -8
    ToadFrameY(484) = -2
    ToadFrameX(517) = -12
    ToadFrameY(517) = -2
    ToadFrameX(483) = -8
    ToadFrameY(483) = -2
    ToadFrameX(518) = -18
    ToadFrameY(518) = -2
    ToadFrameX(482) = -8
    ToadFrameY(482) = -2
    ToadFrameX(519) = -12
    ToadFrameY(519) = -2
    ToadFrameX(481) = -8
    ToadFrameY(481) = -2
    ToadFrameX(520) = -12
    ToadFrameY(520) = -2
    ToadFrameX(480) = -8
    ToadFrameY(480) = -2
    ToadFrameX(521) = -14
    ToadFrameY(521) = -2
    ToadFrameX(479) = -8
    ToadFrameY(479) = -2
    ToadFrameX(522) = -4
    ToadFrameY(522) = -22
    ToadFrameX(478) = -4
    ToadFrameY(478) = -22
    ToadFrameX(523) = -4
    ToadFrameY(523) = -16
    ToadFrameX(477) = -4
    ToadFrameY(477) = -16
    ToadFrameX(524) = -12
    ToadFrameY(524) = 6
    ToadFrameX(476) = -4
    ToadFrameY(476) = 6
    ToadFrameX(525) = -4
    ToadFrameY(525) = -4
    ToadFrameX(475) = -4
    ToadFrameY(475) = -4
    ToadFrameX(526) = -4
    ToadFrameY(526) = -4
    ToadFrameX(474) = -4
    ToadFrameY(474) = -4
    ToadFrameX(527) = -4
    ToadFrameY(527) = -2
    ToadFrameX(473) = -4
    ToadFrameY(473) = -2
    
    
    ToadFrameX(601) = -6
    ToadFrameY(601) = -2
    ToadFrameX(599) = -4
    ToadFrameY(599) = -2
    
    ToadFrameX(602) = -6
    ToadFrameY(602) = -2
    ToadFrameX(598) = -4
    ToadFrameY(598) = -2
    
    ToadFrameX(603) = -6
    ToadFrameY(603) = -2
    ToadFrameX(597) = -4
    ToadFrameY(597) = -2
    
    ToadFrameX(604) = -6
    ToadFrameY(604) = -2
    ToadFrameX(596) = -4
    ToadFrameY(596) = -2
    
    ToadFrameX(605) = -6
    ToadFrameY(605) = -2
    ToadFrameX(595) = -4
    ToadFrameY(595) = -2
    
    ToadFrameX(606) = -6
    ToadFrameY(606) = -2
    ToadFrameX(594) = -4
    ToadFrameY(594) = -2
    
    ToadFrameX(607) = -6
    ToadFrameY(607) = 0
    ToadFrameX(593) = -6
    ToadFrameY(593) = 0
    
    ToadFrameX(608) = -6
    ToadFrameY(608) = -2
    ToadFrameX(592) = -4
    ToadFrameY(592) = -2
    
    ToadFrameX(609) = -6
    ToadFrameY(609) = -2
    ToadFrameX(591) = -4
    ToadFrameY(591) = -2
    
    ToadFrameX(610) = -6
    ToadFrameY(610) = -2
    ToadFrameX(590) = -4
    ToadFrameY(590) = -2
    
    ToadFrameX(611) = -6
    ToadFrameY(611) = -2
    ToadFrameX(589) = -4
    ToadFrameY(589) = -2
    
    ToadFrameX(612) = -6
    ToadFrameY(612) = -2
    ToadFrameX(588) = -4
    ToadFrameY(588) = -2
    
    ToadFrameX(613) = -4
    ToadFrameY(613) = -2
    ToadFrameX(587) = -4
    ToadFrameY(587) = -2
    
    ToadFrameX(615) = -6
    ToadFrameY(615) = -2
    ToadFrameX(585) = -6
    ToadFrameY(585) = -2
    
    ToadFrameX(622) = -4
    ToadFrameY(622) = -22
    ToadFrameX(578) = -4
    ToadFrameY(578) = -22
    
    ToadFrameX(623) = -4
    ToadFrameY(623) = -16
    ToadFrameX(577) = -4
    ToadFrameY(577) = -16
    
    ToadFrameX(625) = -4
    ToadFrameY(625) = -2
    ToadFrameX(575) = -4
    ToadFrameY(575) = -2
    
    ToadFrameX(626) = -4
    ToadFrameY(626) = -2
    ToadFrameX(574) = -4
    ToadFrameY(574) = -2
    
    ToadFrameX(627) = -4
    ToadFrameY(627) = 0
    ToadFrameX(573) = -4
    ToadFrameY(573) = 0
    
    
    ToadFrameX(500) = -6
    ToadFrameY(500) = -6
    
    
End Sub


Private Sub SizableBlocks() 'set up sizable blocks
    BlockIsSizable(568) = True
    BlockIsSizable(579) = True
    BlockIsSizable(575) = True
    BlockIsSizable(25) = True
    BlockIsSizable(26) = True
    BlockIsSizable(27) = True
    BlockIsSizable(28) = True
    BlockIsSizable(38) = True
    BlockIsSizable(79) = True
    BlockIsSizable(108) = True
    BlockIsSizable(130) = True
    BlockIsSizable(161) = True
    BlockIsSizable(240) = True
    BlockIsSizable(241) = True
    BlockIsSizable(242) = True
    BlockIsSizable(243) = True
    BlockIsSizable(244) = True
    BlockIsSizable(245) = True
    BlockIsSizable(259) = True
    BlockIsSizable(260) = True
    BlockIsSizable(261) = True
    BlockIsSizable(287) = True
    BlockIsSizable(288) = True
    BlockIsSizable(437) = True
    BlockIsSizable(441) = True
    BlockIsSizable(442) = True
    BlockIsSizable(443) = True
    BlockIsSizable(444) = True
    BlockIsSizable(438) = True
    BlockIsSizable(439) = True
    BlockIsSizable(440) = True
    BlockIsSizable(445) = True
End Sub

Public Sub StartBattleMode()
    Dim A As Integer
    Dim blankPlayer As Player
    numPlayers = 2
    For A = 1 To numCharacters
        SavedChar(A) = blankPlayer
        SavedChar(A).Character = A
        SavedChar(A).State = 1
    Next A
    Player(1).State = 2
    Player(1).Mount = 0
    Player(1).Character = 1
    Player(1).HeldBonus = 0
    Player(1).CanFly = False
    Player(1).CanFly2 = False
    Player(1).TailCount = 0
    Player(1).YoshiBlue = False
    Player(1).YoshiRed = False
    Player(1).YoshiYellow = False
    Player(1).Hearts = 2
    Player(2).State = 2
    Player(2).Mount = 0
    Player(2).Character = 2
    Player(2).HeldBonus = 0
    Player(2).CanFly = False
    Player(2).CanFly2 = False
    Player(2).TailCount = 0
    Player(2).YoshiBlue = False
    Player(2).YoshiRed = False
    Player(2).YoshiYellow = False
    Player(2).Hearts = 2
    Player(1).Character = PlayerCharacter
    Player(2).Character = PlayerCharacter2
    numStars = 0
    Coins = 0
    Score = 0
    Lives = 99
    BattleLives(1) = 3
    BattleLives(2) = 3
    LevelSelect = False
    GameMenu = False
    BattleMode = True
    BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
    BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
    StopMusic
    DoEvents
    Sleep 500
    ClearLevel
    If selWorld = 1 Then
        selWorld = Int(Rnd * (NumSelectWorld - 1)) + 2
    End If
    
    OpenLevel SelectWorld(selWorld).WorldFile
    SetupPlayers
    BattleIntro = 150
    BattleWinner = 0
    BattleOutro = 0
End Sub

Public Function FixComma(newStr As String) As String
    Dim A As Integer
    Dim tempStr As String
    For A = 1 To Len(newStr)
        If Mid(newStr, A, 1) = "," Then
            tempStr = tempStr & "."
        Else
            tempStr = tempStr & Mid(newStr, A, 1)
        End If
    Next A
    FixComma = tempStr
End Function






