Attribute VB_Name = "modSound"
Public musicPlaying As Boolean
Public musicLoop As Integer
Public musicName As String

Public Sub StartMusic(A As Integer) 'play music
    If noSound = True Then Exit Sub
    If (LevelSelect = True Or WorldEditor = True) And LevelEditor = False And GameMenu = False Then 'music on the world map
        StopMusic
        mciSendString "play wmusic" & A & " from 10", 0, 0, 0
        musicName = "wmusic" & A
        curWorldMusic = A
    ElseIf A = -1 Then 'P switch music
        StopMusic
        If FreezeNPCs = True Then
            mciSendString "play stmusic from 10", 0, 0, 0
        Else
            mciSendString "play smusic from 10", 0, 0, 0
        End If
        musicName = "smusic"
        curMusic = -1
    ElseIf PSwitchTime = 0 And PSwitchStop = 0 Then ' level music
        StopMusic
        curMusic = bgMusic(A)
        If bgMusic(A) = 24 Then
            mciSendString "close music24", 0, 0, 0
            mciSendString "open " & Chr(34) & FileNamePath & "\" & CustomMusic(A) & Chr(34) & " alias music24", 0, 0, 0
            mciSendString "setaudio music24 volume to 400", 0, 0, 0
        End If
        mciSendString "play music" & bgMusic(A) & " from 70", 0, 0, 0
        musicName = "music" & bgMusic(A)
    End If
    musicPlaying = True
End Sub

Public Sub StopMusic() 'stop playing music
    If musicPlaying = False Then Exit Sub
    If noSound = True Then Exit Sub
    For A = 1 To 56
        If A <= 16 Then mciSendString "stop wmusic" & A, 0, 0, 0
        mciSendString "stop music" & A, 0, 0, 0
    Next A
    mciSendString "stop smusic", 0, 0, 0
    mciSendString "stop stmusic", 0, 0, 0
    mciSendString "stop tmusic", 0, 0, 0
    musicPlaying = False
End Sub

Public Sub InitSound() 'readys sound and music to be played
    Dim A As Integer
    If noSound = True Then Exit Sub
'SOUNDS
    mciSendString "open " & Chr(34) & App.Path & "\sound\player-jump.mp3" & Chr(34) & " alias sound1", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\stomped.mp3" & Chr(34) & " alias sound2", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\block-hit.mp3" & Chr(34) & " alias sound3", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\block-smash.mp3" & Chr(34) & " alias sound4", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\player-shrink.mp3" & Chr(34) & " alias sound5", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\player-grow.mp3" & Chr(34) & " alias sound6", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\mushroom.mp3" & Chr(34) & " alias sound7", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\player-died.mp3" & Chr(34) & " alias sound8", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\shell-hit.mp3" & Chr(34) & " alias sound9", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\player-slide.mp3" & Chr(34) & " alias sound10", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\item-dropped.mp3" & Chr(34) & " alias sound11", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\has-item.mp3" & Chr(34) & " alias sound12", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\camera-change.mp3" & Chr(34) & " alias sound13", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\coin.mp3" & Chr(34) & " alias sound14", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\1up.mp3" & Chr(34) & " alias sound15", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\lava.mp3" & Chr(34) & " alias sound16", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\warp.mp3" & Chr(34) & " alias sound17", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\fireball.mp3" & Chr(34) & " alias sound18", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\level-win.mp3" & Chr(34) & " alias sound19", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\boss-beat.mp3" & Chr(34) & " alias sound20", 0, 0, 0
    modLoadGFX.UpdateLoad
    mciSendString "open " & Chr(34) & App.Path & "\sound\dungeon-win.mp3" & Chr(34) & " alias sound21", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\bullet-bill.mp3" & Chr(34) & " alias sound22", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\grab.mp3" & Chr(34) & " alias sound23", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\spring.mp3" & Chr(34) & " alias sound24", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\hammer.mp3" & Chr(34) & " alias sound25", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\slide.mp3" & Chr(34) & " alias sound26", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\newpath.mp3" & Chr(34) & " alias sound27", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\level-select.mp3" & Chr(34) & " alias sound28", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\do.mp3" & Chr(34) & " alias sound29", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\pause.mp3" & Chr(34) & " alias sound30", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\key.mp3" & Chr(34) & " alias sound31", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\pswitch.mp3" & Chr(34) & " alias sound32", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\tail.mp3" & Chr(34) & " alias sound33", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\racoon.mp3" & Chr(34) & " alias sound34", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\boot.mp3" & Chr(34) & " alias sound35", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\smash.mp3" & Chr(34) & " alias sound36", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\thwomp.mp3" & Chr(34) & " alias sound37", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\birdo-spit.mp3" & Chr(34) & " alias sound38", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\birdo-hit.mp3" & Chr(34) & " alias sound39", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\smb2-exit.mp3" & Chr(34) & " alias sound40", 0, 0, 0
    modLoadGFX.UpdateLoad
    mciSendString "open " & Chr(34) & App.Path & "\sound\birdo-beat.mp3" & Chr(34) & " alias sound41", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\npc-fireball.mp3" & Chr(34) & " alias sound42", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\fireworks.mp3" & Chr(34) & " alias sound43", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\bowser-killed.mp3" & Chr(34) & " alias sound44", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\game-beat.mp3" & Chr(34) & " alias sound45", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\door.mp3" & Chr(34) & " alias sound46", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\message.mp3" & Chr(34) & " alias sound47", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\yoshi.mp3" & Chr(34) & " alias sound48", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\yoshi-hurt.mp3" & Chr(34) & " alias sound49", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\yoshi-tongue.mp3" & Chr(34) & " alias sound50", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\yoshi-egg.mp3" & Chr(34) & " alias sound51", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\got-star.mp3" & Chr(34) & " alias sound52", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-kill.mp3" & Chr(34) & " alias sound53", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\player-died2.mp3" & Chr(34) & " alias sound54", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\yoshi-swallow.mp3" & Chr(34) & " alias sound55", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\ring.mp3" & Chr(34) & " alias sound56", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\dry-bones.mp3" & Chr(34) & " alias sound57", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\smw-checkpoint.mp3" & Chr(34) & " alias sound58", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\dragon-coin.mp3" & Chr(34) & " alias sound59", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\smw-exit.mp3" & Chr(34) & " alias sound60", 0, 0, 0
    modLoadGFX.UpdateLoad
    mciSendString "open " & Chr(34) & App.Path & "\sound\smw-blaarg.mp3" & Chr(34) & " alias sound61", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\wart-bubble.mp3" & Chr(34) & " alias sound62", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\wart-die.mp3" & Chr(34) & " alias sound63", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\sm-block-hit.mp3" & Chr(34) & " alias sound64", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\sm-killed.mp3" & Chr(34) & " alias sound65", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\sm-hurt.mp3" & Chr(34) & " alias sound66", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\sm-glass.mp3" & Chr(34) & " alias sound67", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\sm-boss-hit.mp3" & Chr(34) & " alias sound68", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\sm-cry.mp3" & Chr(34) & " alias sound69", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\sm-explosion.mp3" & Chr(34) & " alias sound70", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\climbing.mp3" & Chr(34) & " alias sound71", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\swim.mp3" & Chr(34) & " alias sound72", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\grab2.mp3" & Chr(34) & " alias sound73", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\smw-saw.mp3" & Chr(34) & " alias sound74", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\smb2-throw.mp3" & Chr(34) & " alias sound75", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\smb2-hit.mp3" & Chr(34) & " alias sound76", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-stab.mp3" & Chr(34) & " alias sound77", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-hurt.mp3" & Chr(34) & " alias sound78", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-heart.mp3" & Chr(34) & " alias sound79", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-died.mp3" & Chr(34) & " alias sound80", 0, 0, 0
    modLoadGFX.UpdateLoad
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-rupee.mp3" & Chr(34) & " alias sound81", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-fire.mp3" & Chr(34) & " alias sound82", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-item.mp3" & Chr(34) & " alias sound83", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-key.mp3" & Chr(34) & " alias sound84", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-shield.mp3" & Chr(34) & " alias sound85", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-dash.mp3" & Chr(34) & " alias sound86", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-fairy.mp3" & Chr(34) & " alias sound87", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-grass.mp3" & Chr(34) & " alias sound88", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-hit.mp3" & Chr(34) & " alias sound89", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\zelda-sword-beam.mp3" & Chr(34) & " alias sound90", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\sound\bubble.mp3" & Chr(34) & " alias sound91", 0, 0, 0
    modLoadGFX.UpdateLoad
'WORLD / MISC MUSIC
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-world1.mp3" & Chr(34) & " alias wmusic1", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-world4.mp3" & Chr(34) & " alias wmusic2", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-world7.mp3" & Chr(34) & " alias wmusic3", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-worldmap.mp3" & Chr(34) & " alias wmusic4", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\nsmb-world.mp3" & Chr(34) & " alias wmusic5", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-world2.mp3" & Chr(34) & " alias wmusic6", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-forestofillusion.mp3" & Chr(34) & " alias wmusic7", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-world3.mp3" & Chr(34) & " alias wmusic8", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-world8.mp3" & Chr(34) & " alias wmusic9", 0, 0, 0
    modLoadGFX.UpdateLoad
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-world6.mp3" & Chr(34) & " alias wmusic10", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-world5.mp3" & Chr(34) & " alias wmusic11", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-special.mp3" & Chr(34) & " alias wmusic12", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-bowserscastle.mp3" & Chr(34) & " alias wmusic13", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-starroad.mp3" & Chr(34) & " alias wmusic14", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-yoshisisland.mp3" & Chr(34) & " alias wmusic15", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-vanilladome.mp3" & Chr(34) & " alias wmusic16", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-switch.mp3" & Chr(34) & " alias smusic", 0, 0, 0 'p switch music
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-switch.mp3" & Chr(34) & " alias stmusic", 0, 0, 0 'p switch music
    mciSendString "open " & Chr(34) & App.Path & "\music\smg-title.mp3" & Chr(34) & " alias tmusic", 0, 0, 0 'credit music
    
'LEVEL MUSIC
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-overworld.mp3" & Chr(34) & " alias music1", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-sky.mp3" & Chr(34) & " alias music2", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-castle.mp3" & Chr(34) & " alias music3", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-underground.mp3" & Chr(34) & " alias music4", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb2-overworld.mp3" & Chr(34) & " alias music5", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-boss.mp3" & Chr(34) & " alias music6", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb-underground.mp3" & Chr(34) & " alias music7", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\sf-corneria.mp3" & Chr(34) & " alias music8", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb-overworld.mp3" & Chr(34) & " alias music9", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-overworld.mp3" & Chr(34) & " alias music10", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\sm-brinstar.mp3" & Chr(34) & " alias music11", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\sm-crateria.mp3" & Chr(34) & " alias music12", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\nsmb-overworld.mp3" & Chr(34) & " alias music13", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\sm64-desert.mp3" & Chr(34) & " alias music14", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb2-boss.mp3" & Chr(34) & " alias music15", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mariorpg-forestmaze.mp3" & Chr(34) & " alias music16", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-ghosthouse.mp3" & Chr(34) & " alias music17", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smg-beach-bowl-galaxy.mp3" & Chr(34) & " alias music18", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\ssbb-airship.mp3" & Chr(34) & " alias music19", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smg-star-reactor.mp3" & Chr(34) & " alias music20", 0, 0, 0
    modLoadGFX.UpdateLoad
    mciSendString "open " & Chr(34) & App.Path & "\music\mariorpg-bowser.mp3" & Chr(34) & " alias music21", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\tds-metroid-charge.mp3" & Chr(34) & " alias music22", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\z3-lost-woods.mp3" & Chr(34) & " alias music23", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb2-underground.mp3" & Chr(34) & " alias music25", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mario64-castle.mp3" & Chr(34) & " alias music26", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mario64-maintheme.mp3" & Chr(34) & " alias music27", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-sky.mp3" & Chr(34) & " alias music28", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-cave.mp3" & Chr(34) & " alias music29", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mariorpg-mariospad.mp3" & Chr(34) & " alias music30", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mariorpg-seasidetown.mp3" & Chr(34) & " alias music31", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mariorpg-tadpolepond.mp3" & Chr(34) & " alias music32", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mariorpg-nimbusland.mp3" & Chr(34) & " alias music33", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mariorpg-rosetown.mp3" & Chr(34) & " alias music34", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mario64-snowmountain.mp3" & Chr(34) & " alias music35", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mario64-boss.mp3" & Chr(34) & " alias music36", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\pm-shiver-mountain.mp3" & Chr(34) & " alias music37", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\pm-yoshis-village.mp3" & Chr(34) & " alias music38", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\ssbb-zelda2.mp3" & Chr(34) & " alias music39", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\ssbb-meta.mp3" & Chr(34) & " alias music40", 0, 0, 0
    modLoadGFX.UpdateLoad
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-castle.mp3" & Chr(34) & " alias music41", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb-castle.mp3" & Chr(34) & " alias music42", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb2-wart.mp3" & Chr(34) & " alias music43", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\sm-itemroom.mp3" & Chr(34) & " alias music44", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\sm-brain.mp3" & Chr(34) & " alias music45", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb-water.mp3" & Chr(34) & " alias music46", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-water.mp3" & Chr(34) & " alias music47", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-water.mp3" & Chr(34) & " alias music48", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mario64-water.mp3" & Chr(34) & " alias music49", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mario64-cave.mp3" & Chr(34) & " alias music50", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smw-boss.mp3" & Chr(34) & " alias music51", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\ssbb-underground.mp3" & Chr(34) & " alias music52", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\ssbb-waluigi.mp3" & Chr(34) & " alias music53", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smb3-hammer.mp3" & Chr(34) & " alias music54", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\smg2-fg.mp3" & Chr(34) & " alias music55", 0, 0, 0
    mciSendString "open " & Chr(34) & App.Path & "\music\mkwii-mushroom-gorge.mp3" & Chr(34) & " alias music56", 0, 0, 0
    modLoadGFX.UpdateLoad
    For A = 1 To 56 'set volume
        If A <= 16 Then mciSendString "setaudio wmusic" & A & " volume to 500", 0, 0, 0 'world map music is a little louder
        mciSendString "setaudio music" & A & " volume to 400", 0, 0, 0
    Next A
    mciSendString "setaudio smusic volume to 500", 0, 0, 0
    mciSendString "setaudio stmusic volume to 500", 0, 0, 0
    mciSendString "setaudio tmusic volume to 500", 0, 0, 0
End Sub

Public Sub PlaySound(A As Integer) 'play a sound
    Dim soundString As String
    If noSound = True Then Exit Sub
    If (GameMenu = False Or A = 26 Or A = 29) And GameOutro = False Then
        If numPlayers > 2 And nPlay.Online = False Then SoundPause(10) = 1
        If SoundPause(A) = 0 Then 'if the sound wasn't just played
            soundString = "stop sound" & A
            mciSendString soundString, 0, 0, 0
            soundString = "play sound" & A & " from 10"
            mciSendString soundString, 0, 0, 0

'set the delay before a sound can be played again
            If A = 2 Then
                SoundPause(A) = 12
            ElseIf A = 3 Then SoundPause(A) = 12
            ElseIf A = 4 Then SoundPause(A) = 12
            ElseIf A = 5 Then SoundPause(A) = 30
            ElseIf A = 8 Then SoundPause(A) = 10
            ElseIf A = 9 Then SoundPause(A) = 4
            ElseIf A = 10 Then SoundPause(A) = 8
            ElseIf A = 12 Then SoundPause(A) = 10
            ElseIf A = 17 Then SoundPause(A) = 10
            ElseIf A = 26 Then SoundPause(A) = 8
            ElseIf A = 31 Then SoundPause(A) = 20
            ElseIf A = 37 Then SoundPause(A) = 10
            ElseIf A = 42 Then SoundPause(A) = 16
            ElseIf A = 50 Then SoundPause(A) = 8
            ElseIf A = 54 Then SoundPause(A) = 8
            ElseIf A = 71 Then SoundPause(A) = 9
            ElseIf A = 74 Then SoundPause(A) = 8
            ElseIf A = 81 Then SoundPause(A) = 5
            ElseIf A = 86 Then SoundPause(A) = 8
            Else
                SoundPause(A) = 4
            End If
        End If
    End If
End Sub

Public Sub BlockSound() 'stops all sound from being played for 10 cycles
    Dim A As Integer
    For A = 1 To numSounds
        SoundPause(A) = 10
    Next A
End Sub

Public Sub UpdateSound() 'checks to loop music and update the soundpause variable
    Dim A As Integer
    Dim sPosition As String * 255
    Dim sLength As String * 255
    Dim Position As Single
    Dim Length As Single
    If noSound = True Then Exit Sub
    If musicPlaying = True Then
        musicLoop = musicLoop + 1
        If musicName = "music0" Then musicLoop = 0
        If musicLoop >= 1 And musicName <> "music0" Then
            musicLoop = 0
            mciSendString "Status " & musicName & " Position", sPosition, 255, 0
            mciSendString "Status " & musicName & " Length", sLength, 255, 0
            nLength = InStr(sLength, Chr$(0))
            Length = Val(Left$(sLength, nLength - 1))
            nLength = InStr(sPosition, Chr$(0))
            Position = Val(Left$(sPosition, nLength - 1))
            If Position >= Length - 70 Then
                If PSwitchTime = 0 And PSwitchStop = 0 Then
                    'mciSendString "stop " & musicName, vbNullString, 0, 0
                    If GameOutro = False Then mciSendString "play " & musicName & " from 70", vbNullString, 0, 0
                End If
            End If
        End If
    End If
    For A = 1 To numSounds
        If SoundPause(A) > 0 Then SoundPause(A) = SoundPause(A) - 1
    Next A
End Sub


