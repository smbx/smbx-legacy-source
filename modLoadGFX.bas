Attribute VB_Name = "modLoadGFX"
Option Explicit
'this module loads graphics into memory and is pretty much self explainatory

Public Sub LoadGFX()
    Dim A As Integer
    On Error Resume Next
    For A = 1 To 10
        If Dir(App.Path & "\graphics\mario\mario-" & A & ".gif") <> "" Then
            Set GFXMarioBMP(A) = LoadPicture(App.Path & "\graphics\mario\mario-" & A & ".gif")
            GFXMarioWidth(A) = frmMain.ScaleX(GFXMarioBMP(A).Width, vbHimetric, vbPixels)
            GFXMarioHeight(A) = frmMain.ScaleY(GFXMarioBMP(A).Height, vbHimetric, vbPixels)
            GFXMario(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXMario(A), GFXMarioBMP(A)
            If Dir(App.Path & "\graphics\mario\mario-" & A & "m.gif") <> "" Then
                Set GFXMarioMaskBMP(A) = LoadPicture(App.Path & "\graphics\mario\mario-" & A & "m.gif")
                GFXMarioMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXMarioMask(A), GFXMarioMaskBMP(A)
            End If
        End If
        If Dir(App.Path & "\graphics\luigi\luigi-" & A & ".gif") <> "" Then
            Set GFXLuigiBMP(A) = LoadPicture(App.Path & "\graphics\luigi\luigi-" & A & ".gif")
            GFXLuigiWidth(A) = frmMain.ScaleX(GFXLuigiBMP(A).Width, vbHimetric, vbPixels)
            GFXLuigiHeight(A) = frmMain.ScaleY(GFXLuigiBMP(A).Height, vbHimetric, vbPixels)
            GFXLuigi(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXLuigi(A), GFXLuigiBMP(A)
            If Dir(App.Path & "\graphics\luigi\luigi-" & A & "m.gif") <> "" Then
                Set GFXLuigiMaskBMP(A) = LoadPicture(App.Path & "\graphics\luigi\luigi-" & A & "m.gif")
                GFXLuigiMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXLuigiMask(A), GFXLuigiMaskBMP(A)
            End If
        End If
        If Dir(App.Path & "\graphics\peach\peach-" & A & ".gif") <> "" Then
            Set GFXPeachBMP(A) = LoadPicture(App.Path & "\graphics\peach\peach-" & A & ".gif")
            GFXPeachWidth(A) = frmMain.ScaleX(GFXPeachBMP(A).Width, vbHimetric, vbPixels)
            GFXPeachHeight(A) = frmMain.ScaleY(GFXPeachBMP(A).Height, vbHimetric, vbPixels)
            GFXPeach(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXPeach(A), GFXPeachBMP(A)
            If Dir(App.Path & "\graphics\peach\peach-" & A & "m.gif") <> "" Then
                Set GFXPeachMaskBMP(A) = LoadPicture(App.Path & "\graphics\peach\peach-" & A & "m.gif")
                GFXPeachMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXPeachMask(A), GFXPeachMaskBMP(A)
            End If
        End If
        If Dir(App.Path & "\graphics\toad\toad-" & A & ".gif") <> "" Then
            Set GFXToadBMP(A) = LoadPicture(App.Path & "\graphics\toad\toad-" & A & ".gif")
            GFXToadWidth(A) = frmMain.ScaleX(GFXToadBMP(A).Width, vbHimetric, vbPixels)
            GFXToadHeight(A) = frmMain.ScaleY(GFXToadBMP(A).Height, vbHimetric, vbPixels)
            GFXToad(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXToad(A), GFXToadBMP(A)
            If Dir(App.Path & "\graphics\toad\toad-" & A & "m.gif") <> "" Then
                Set GFXToadMaskBMP(A) = LoadPicture(App.Path & "\graphics\toad\toad-" & A & "m.gif")
                GFXToadMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXToadMask(A), GFXToadMaskBMP(A)
            End If
        End If
        If Dir(App.Path & "\graphics\link\link-" & A & ".gif") <> "" Then
            Set GFXLinkBMP(A) = LoadPicture(App.Path & "\graphics\link\link-" & A & ".gif")
            GFXLinkWidth(A) = frmMain.ScaleX(GFXLinkBMP(A).Width, vbHimetric, vbPixels)
            GFXLinkHeight(A) = frmMain.ScaleY(GFXLinkBMP(A).Height, vbHimetric, vbPixels)
            GFXLink(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXLink(A), GFXLinkBMP(A)
            If Dir(App.Path & "\graphics\link\link-" & A & "m.gif") <> "" Then
                Set GFXLinkMaskBMP(A) = LoadPicture(App.Path & "\graphics\link\link-" & A & "m.gif")
                GFXLinkMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXLinkMask(A), GFXLinkMaskBMP(A)
            End If
        End If
        UpdateLoad
    Next A
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\block\block-" & A & ".gif") <> "" Then
            Set GFXBlockBMP(A) = LoadPicture(App.Path & "\graphics\block\block-" & A & ".gif")
            GFXBlock(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXBlock(A), GFXBlockBMP(A)
            If Dir(App.Path & "\graphics\block\block-" & A & "m.gif") <> "" Then
                Set GFXBlockMaskBMP(A) = LoadPicture(App.Path & "\graphics\block\block-" & A & "m.gif")
                GFXBlockMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXBlockMask(A), GFXBlockMaskBMP(A)
            Else
                BlockHasNoMask(A) = True
            End If
        Else
            Exit Do
        End If
        If A Mod 20 = 0 Then UpdateLoad
    Loop
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\background2\background2-" & A & ".gif") <> "" Then
            Set GFXBackground2BMP(A) = LoadPicture(App.Path & "\graphics\background2\background2-" & A & ".gif")
            GFXBackground2Width(A) = frmMain.ScaleX(GFXBackground2BMP(A).Width, vbHimetric, vbPixels)
            GFXBackground2Height(A) = frmMain.ScaleY(GFXBackground2BMP(A).Height, vbHimetric, vbPixels)
            GFXBackground2(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXBackground2(A), GFXBackground2BMP(A)
            If A Mod 10 = 0 Then UpdateLoad
        Else
            Exit Do
        End If
    Loop
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\npc\npc-" & A & ".gif") <> "" Then
            Set GFXNPCBMP(A) = LoadPicture(App.Path & "\graphics\npc\npc-" & A & ".gif")
            GFXNPCWidth(A) = frmMain.ScaleX(GFXNPCBMP(A).Width, vbHimetric, vbPixels)
            GFXNPCHeight(A) = frmMain.ScaleY(GFXNPCBMP(A).Height, vbHimetric, vbPixels)
            GFXNPC(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXNPC(A), GFXNPCBMP(A)
            If Dir(App.Path & "\graphics\npc\npc-" & A & "m.gif") <> "" Then
                Set GFXNPCMaskBMP(A) = LoadPicture(App.Path & "\graphics\npc\npc-" & A & "m.gif")
                GFXNPCMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXNPCMask(A), GFXNPCMaskBMP(A)
            End If
        Else
            Exit Do
        End If
        If A Mod 20 = 0 Then UpdateLoad
    Loop
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\effect\effect-" & A & ".gif") <> "" Then
            Set GFXEffectBMP(A) = LoadPicture(App.Path & "\graphics\effect\effect-" & A & ".gif")
            GFXEffectWidth(A) = frmMain.ScaleX(GFXEffectBMP(A).Width, vbHimetric, vbPixels)
            GFXEffectHeight(A) = frmMain.ScaleY(GFXEffectBMP(A).Height, vbHimetric, vbPixels)
            GFXEffect(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXEffect(A), GFXEffectBMP(A)
            If Dir(App.Path & "\graphics\effect\effect-" & A & "m.gif") <> "" Then
                Set GFXEffectMaskBMP(A) = LoadPicture(App.Path & "\graphics\effect\effect-" & A & "m.gif")
                GFXEffectMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXEffectMask(A), GFXEffectMaskBMP(A)
            End If
        Else
            Exit Do
        End If
        If A Mod 20 = 0 Then UpdateLoad
    Loop
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\yoshi\yoshib-" & A & ".gif") <> "" Then
            Set GFXYoshiBBMP(A) = LoadPicture(App.Path & "\graphics\yoshi\yoshib-" & A & ".gif")
            GFXYoshiB(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXYoshiB(A), GFXYoshiBBMP(A)
            If Dir(App.Path & "\graphics\yoshi\yoshib-" & A & "m.gif") <> "" Then
                Set GFXYoshiBMaskBMP(A) = LoadPicture(App.Path & "\graphics\yoshi\yoshib-" & A & "m.gif")
                GFXYoshiBMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXYoshiBMask(A), GFXYoshiBMaskBMP(A)
            End If
        Else
            Exit Do
        End If
    Loop
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\yoshi\yoshit-" & A & ".gif") <> "" Then
            Set GFXYoshiTBMP(A) = LoadPicture(App.Path & "\graphics\yoshi\yoshit-" & A & ".gif")
            GFXYoshiT(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXYoshiT(A), GFXYoshiTBMP(A)
            If Dir(App.Path & "\graphics\yoshi\yoshit-" & A & "m.gif") <> "" Then
                Set GFXYoshiTMaskBMP(A) = LoadPicture(App.Path & "\graphics\yoshi\yoshit-" & A & "m.gif")
                GFXYoshiTMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXYoshiTMask(A), GFXYoshiTMaskBMP(A)
            End If
        Else
            Exit Do
        End If
    Loop
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\background\background-" & A & ".gif") <> "" Then
            Set GFXBackgroundBMP(A) = LoadPicture(App.Path & "\graphics\background\background-" & A & ".gif")
            GFXBackgroundWidth(A) = frmMain.ScaleX(GFXBackgroundBMP(A).Width, vbHimetric, vbPixels)
            GFXBackgroundHeight(A) = frmMain.ScaleY(GFXBackgroundBMP(A).Height, vbHimetric, vbPixels)
            BackgroundWidth(A) = GFXBackgroundWidth(A)
            BackgroundHeight(A) = GFXBackgroundHeight(A)
            GFXBackground(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXBackground(A), GFXBackgroundBMP(A)
            If Dir(App.Path & "\graphics\background\background-" & A & "m.gif") <> "" Then
                Set GFXBackgroundMaskBMP(A) = LoadPicture(App.Path & "\graphics\background\background-" & A & "m.gif")
                GFXBackgroundMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXBackgroundMask(A), GFXBackgroundMaskBMP(A)
            End If
        Else
            Exit Do
        End If
        If A Mod 20 = 0 Then UpdateLoad
    Loop
'world map
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\tile\tile-" & A & ".gif") <> "" Then
            Set GFXTileBMP(A) = LoadPicture(App.Path & "\graphics\tile\tile-" & A & ".gif")
            GFXTileWidth(A) = frmMain.ScaleX(GFXTileBMP(A).Width, vbHimetric, vbPixels)
            GFXTileHeight(A) = frmMain.ScaleY(GFXTileBMP(A).Height, vbHimetric, vbPixels)
            GFXTile(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXTile(A), GFXTileBMP(A)
        Else
            Exit Do
        End If
        If A Mod 20 = 0 Then UpdateLoad
    Loop
    UpdateLoad
    A = -1
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\level\level-" & A & ".gif") <> "" Then
            Set GFXLevelBMP(A) = LoadPicture(App.Path & "\graphics\level\level-" & A & ".gif")
            GFXLevelWidth(A) = frmMain.ScaleX(GFXLevelBMP(A).Width, vbHimetric, vbPixels)
            GFXLevelHeight(A) = frmMain.ScaleY(GFXLevelBMP(A).Height, vbHimetric, vbPixels)
            GFXLevel(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXLevel(A), GFXLevelBMP(A)
            If Dir(App.Path & "\graphics\level\level-" & A & "m.gif") <> "" Then
                Set GFXLevelMaskBMP(A) = LoadPicture(App.Path & "\graphics\level\level-" & A & "m.gif")
                GFXLevelMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXLevelMask(A), GFXLevelMaskBMP(A)
            End If
        Else
            Exit Do
        End If
    Loop
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\scene\scene-" & A & ".gif") <> "" Then
            Set GFXSceneBMP(A) = LoadPicture(App.Path & "\graphics\scene\scene-" & A & ".gif")
            GFXSceneWidth(A) = frmMain.ScaleX(GFXSceneBMP(A).Width, vbHimetric, vbPixels)
            GFXSceneHeight(A) = frmMain.ScaleY(GFXSceneBMP(A).Height, vbHimetric, vbPixels)
            GFXScene(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXScene(A), GFXSceneBMP(A)
            If Dir(App.Path & "\graphics\scene\scene-" & A & "m.gif") <> "" Then
                Set GFXSceneMaskBMP(A) = LoadPicture(App.Path & "\graphics\scene\scene-" & A & "m.gif")
                GFXSceneMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXSceneMask(A), GFXSceneMaskBMP(A)
            End If
        Else
            Exit Do
        End If
    Loop
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\player\player-" & A & ".gif") <> "" Then
            Set GFXPlayerBMP(A) = LoadPicture(App.Path & "\graphics\player\player-" & A & ".gif")
            GFXPlayerWidth(A) = frmMain.ScaleX(GFXPlayerBMP(A).Width, vbHimetric, vbPixels)
            GFXPlayerHeight(A) = frmMain.ScaleY(GFXPlayerBMP(A).Height, vbHimetric, vbPixels)
            GFXPlayer(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXPlayer(A), GFXPlayerBMP(A)
            If Dir(App.Path & "\graphics\player\player-" & A & "m.gif") <> "" Then
                Set GFXPlayerMaskBMP(A) = LoadPicture(App.Path & "\graphics\player\player-" & A & "m.gif")
                GFXPlayerMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXPlayerMask(A), GFXPlayerMaskBMP(A)
            End If
        Else
            Exit Do
        End If
    Loop
    UpdateLoad
    A = 0
    Do
        A = A + 1
        If Dir(App.Path & "\graphics\path\path-" & A & ".gif") <> "" Then
            Set GFXPathBMP(A) = LoadPicture(App.Path & "\graphics\path\path-" & A & ".gif")
            GFXPathWidth(A) = frmMain.ScaleX(GFXPathBMP(A).Width, vbHimetric, vbPixels)
            GFXPathHeight(A) = frmMain.ScaleY(GFXPathBMP(A).Height, vbHimetric, vbPixels)
            GFXPath(A) = CreateCompatibleDC(frmMain.hdc)
            SelectObject GFXPath(A), GFXPathBMP(A)
            If Dir(App.Path & "\graphics\path\path-" & A & "m.gif") <> "" Then
                Set GFXPathMaskBMP(A) = LoadPicture(App.Path & "\graphics\path\path-" & A & "m.gif")
                GFXPathMask(A) = CreateCompatibleDC(frmMain.hdc)
                SelectObject GFXPathMask(A), GFXPathMaskBMP(A)
            End If
        Else
            Exit Do
        End If
    Loop
    UpdateLoad
    Exit Sub
End Sub
    
Public Sub UnloadGFX()
    On Error Resume Next
    Dim A As Integer
    A = 0
    Do While A < maxBlockType
        A = A + 1
        If GFXBlock(A) <> 0 Then
            DeleteDC GFXBlock(A)
            DeleteObject GFXBlockBMP(A)
            If BlockHasNoMask(A) = False Then
                DeleteDC GFXBlockMask(A)
                DeleteObject GFXBlockMaskBMP(A)
            End If
        End If
    Loop
    A = 0
    Do While A < numBackground2
        A = A + 1
        If GFXBackground2(A) <> 0 Then
            DeleteDC GFXBackground2(A)
            DeleteObject GFXBackground2BMP(A)
        End If
    Loop
    A = 0
    Do While A < maxNPCType
        A = A + 1
        If GFXNPC(A) <> 0 Then
            DeleteDC GFXNPC(A)
            DeleteObject GFXNPCBMP(A)
            DeleteDC GFXNPCMask(A)
            DeleteObject GFXNPCMaskBMP(A)
        End If
    Loop
    A = 0
    Do While A < maxEffectType
        A = A + 1
        If GFXEffect(A) <> 0 Then
            DeleteDC GFXEffect(A)
            DeleteObject GFXEffectBMP(A)
            DeleteDC GFXEffectMask(A)
            DeleteObject GFXEffectMaskBMP(A)
        End If
    Loop
    A = 0
    Do While A < maxBackgroundType
        A = A + 1
        If GFXBackground(A) <> 0 Then
            DeleteDC GFXBackground(A)
            DeleteObject GFXBackgroundBMP(A)
            DeleteDC GFXBackgroundMask(A)
            DeleteObject GFXBackgroundMaskBMP(A)
        End If
    Loop
    A = 0
    Do While A < 10
        A = A + 1
        If GFXYoshiB(A) <> 0 Then
            DeleteDC GFXYoshiB(A)
            DeleteObject GFXYoshiBBMP(A)
            DeleteDC GFXYoshiBMask(A)
            DeleteObject GFXYoshiBMaskBMP(A)
        End If
        If GFXYoshiT(A) <> 0 Then
            DeleteDC GFXYoshiT(A)
            DeleteObject GFXYoshiTBMP(A)
            DeleteDC GFXYoshiTMask(A)
            DeleteObject GFXYoshiTMaskBMP(A)
        End If
    Loop
    A = 0
    Do While A < maxPlayerFrames
        A = A + 1
        If GFXMario(A) <> 0 Then
            DeleteDC GFXMario(A)
            DeleteObject GFXMarioBMP(A)
            DeleteDC GFXMarioMask(A)
            DeleteObject GFXMarioMaskBMP(A)
        End If
        If GFXLuigi(A) <> 0 Then
            DeleteDC GFXLuigi(A)
            DeleteObject GFXLuigiBMP(A)
            DeleteDC GFXLuigiMask(A)
            DeleteObject GFXLuigiMaskBMP(A)
        End If
        If GFXPeach(A) <> 0 Then
            DeleteDC GFXPeach(A)
            DeleteObject GFXPeachBMP(A)
            DeleteDC GFXPeachMask(A)
            DeleteObject GFXPeachMaskBMP(A)
        End If
        If GFXToad(A) <> 0 Then
            DeleteDC GFXToad(A)
            DeleteObject GFXToadBMP(A)
            DeleteDC GFXToadMask(A)
            DeleteObject GFXToadMaskBMP(A)
        End If
        If GFXLink(A) <> 0 Then
            DeleteDC GFXLink(A)
            DeleteObject GFXLinkBMP(A)
            DeleteDC GFXLinkMask(A)
            DeleteObject GFXLinkMaskBMP(A)
        End If
    Loop
    A = 0
    Do While A < maxTileType
        A = A + 1
        If GFXTile(A) <> 0 Then
            DeleteDC GFXTile(A)
            DeleteObject GFXTileBMP(A)
        End If
    Loop
    A = -1
    Do While A < maxLevelType
        A = A + 1
        If GFXLevel(A) <> 0 Then
            DeleteDC GFXLevel(A)
            DeleteObject GFXLevelBMP(A)
            DeleteDC GFXLevelMask(A)
            DeleteObject GFXLevelMaskBMP(A)
        End If
    Loop
    A = 0
    Do While A < maxSceneType
        A = A + 1
        If GFXScene(A) <> 0 Then
            DeleteDC GFXScene(A)
            DeleteObject GFXSceneBMP(A)
            DeleteDC GFXSceneMask(A)
            DeleteObject GFXSceneMaskBMP(A)
        End If
    Loop
    A = 0
    Do While A < numCharacters
        A = A + 1
        If GFXPlayer(A) <> 0 Then
            DeleteDC GFXPlayer(A)
            DeleteObject GFXPlayerBMP(A)
            DeleteDC GFXPlayerMask(A)
            DeleteObject GFXPlayerMaskBMP(A)
        End If
    Loop
    A = 0
    Do While A < maxPathType
        A = A + 1
        If GFXPath(A) <> 0 Then
            DeleteDC GFXPath(A)
            DeleteObject GFXPathBMP(A)
            DeleteDC GFXPathMask(A)
            DeleteObject GFXPathMaskBMP(A)
        End If
    Loop
End Sub

Public Sub LoadCustomGFX()
    Dim A As Integer
    Dim B As Integer
    If Dir(FileNamePath & "*.gif") <> "" Then
        If Dir(FileNamePath & "\block*.gif") <> "" Then
            For A = 1 To maxBlockType
                If Dir(FileNamePath & "\block-" & A & ".gif") <> "" Then
                    GFXBlockCustom(A) = True
                    Set GFXBlockBMP(A) = LoadPicture(FileNamePath & "\block-" & A & ".gif")
                    SelectObject GFXBlock(A), GFXBlockBMP(A)
                    cBlockGFX A
                    If Dir(FileNamePath & "\block-" & A & "m.gif") <> "" Then
                        Set GFXBlockMaskBMP(A) = LoadPicture(FileNamePath & "\block-" & A & "m.gif")
                        SelectObject GFXBlockMask(A), GFXBlockMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\background2*.gif") <> "" Then
            For A = 1 To numBackground2
                If Dir(FileNamePath & "\background2-" & A & ".gif") <> "" Then
                    GFXBackground2Custom(A) = True
                    Set GFXBackground2BMP(A) = LoadPicture(FileNamePath & "\background2-" & A & ".gif")
                    SelectObject GFXBackground2(A), GFXBackground2BMP(A)
                    GFXBackground2Width(A) = frmMain.ScaleX(GFXBackground2BMP(A).Width, vbHimetric, vbPixels)
                    GFXBackground2Height(A) = frmMain.ScaleY(GFXBackground2BMP(A).Height, vbHimetric, vbPixels)
                End If
            Next A
        End If
        If Dir(FileNamePath & "\npc*.gif") <> "" Then
            For A = 1 To maxNPCType
                If Dir(FileNamePath & "\npc-" & A & ".gif") <> "" Then
                    GFXNPCCustom(A) = True
                    Set GFXNPCBMP(A) = LoadPicture(FileNamePath & "\npc-" & A & ".gif")
                    SelectObject GFXNPC(A), GFXNPCBMP(A)
                    GFXNPCWidth(A) = frmMain.ScaleX(GFXNPCBMP(A).Width, vbHimetric, vbPixels)
                    GFXNPCHeight(A) = frmMain.ScaleY(GFXNPCBMP(A).Height, vbHimetric, vbPixels)
                    cNPCGFX A
                    If Dir(FileNamePath & "\npc-" & A & "m.gif") <> "" Then
                        Set GFXNPCMaskBMP(A) = LoadPicture(FileNamePath & "\npc-" & A & "m.gif")
                        SelectObject GFXNPCMask(A), GFXNPCMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\effect*.gif") <> "" Then
            For A = 1 To maxEffectType
                If Dir(FileNamePath & "\effect-" & A & ".gif") <> "" Then
                    GFXEffectCustom(A) = True
                    Set GFXEffectBMP(A) = LoadPicture(FileNamePath & "\effect-" & A & ".gif")
                    SelectObject GFXEffect(A), GFXEffectBMP(A)
                    GFXEffectWidth(A) = frmMain.ScaleX(GFXEffectBMP(A).Width, vbHimetric, vbPixels)
                    EffectHeight(A) = GFXEffectHeight(A)
                    GFXEffectHeight(A) = frmMain.ScaleY(GFXEffectBMP(A).Height, vbHimetric, vbPixels)
                    If Dir(FileNamePath & "\effect-" & A & "m.gif") <> "" Then
                        Set GFXEffectMaskBMP(A) = LoadPicture(FileNamePath & "\effect-" & A & "m.gif")
                        SelectObject GFXEffectMask(A), GFXEffectMaskBMP(A)
                    End If
                    EffectWidth(A) = GFXEffectWidth(A)
                    EffectHeight(A) = EffectDefaults.EffectHeight(A) / EffectHeight(A) * GFXEffectHeight(A)
                End If
            Next A
        End If
        If Dir(FileNamePath & "\background*.gif") <> "" Then
            For A = 1 To maxBackgroundType
                If Dir(FileNamePath & "\background-" & A & ".gif") <> "" Then
                    GFXBackgroundCustom(A) = True
                    Set GFXBackgroundBMP(A) = LoadPicture(FileNamePath & "\background-" & A & ".gif")
                    SelectObject GFXBackground(A), GFXBackgroundBMP(A)
                    GFXBackgroundWidth(A) = frmMain.ScaleX(GFXBackgroundBMP(A).Width, vbHimetric, vbPixels)
                    GFXBackgroundHeight(A) = frmMain.ScaleY(GFXBackgroundBMP(A).Height, vbHimetric, vbPixels)
                    GFXBackgroundWidth(A) = GFXBackgroundWidth(A)
                    GFXBackgroundHeight(A) = GFXBackgroundHeight(A)
                    cBackgroundGFX A
                    If Dir(FileNamePath & "\background-" & A & "m.gif") <> "" Then
                        Set GFXBackgroundMaskBMP(A) = LoadPicture(FileNamePath & "\background-" & A & "m.gif")
                        SelectObject GFXBackgroundMask(A), GFXBackgroundMaskBMP(A)
                    End If
                End If
            Next A
        End If
        
        If Dir(FileNamePath & "\yoshib*.gif") <> "" Then
            For A = 1 To 10
                If Dir(FileNamePath & "\yoshib-" & A & ".gif") <> "" Then
                    GFXYoshiBCustom(A) = True
                    Set GFXYoshiBBMP(A) = LoadPicture(FileNamePath & "\yoshib-" & A & ".gif")
                    SelectObject GFXYoshiB(A), GFXYoshiBBMP(A)
                    If Dir(FileNamePath & "\yoshib-" & A & "m.gif") <> "" Then
                        Set GFXYoshiBMaskBMP(A) = LoadPicture(FileNamePath & "\yoshib-" & A & "m.gif")
                        SelectObject GFXYoshiBMask(A), GFXYoshiBMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\yoshit*.gif") <> "" Then
            For A = 1 To 10
                If Dir(FileNamePath & "\yoshit-" & A & ".gif") <> "" Then
                    GFXYoshiTCustom(A) = True
                    Set GFXYoshiTBMP(A) = LoadPicture(FileNamePath & "\yoshit-" & A & ".gif")
                    SelectObject GFXYoshiT(A), GFXYoshiTBMP(A)
                    If Dir(FileNamePath & "\yoshit-" & A & "m.gif") <> "" Then
                        Set GFXYoshiTMaskBMP(A) = LoadPicture(FileNamePath & "\yoshit-" & A & "m.gif")
                        SelectObject GFXYoshiTMask(A), GFXYoshiTMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\mario*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(FileNamePath & "\mario-" & A & ".gif") <> "" Then
                    GFXMarioCustom(A) = True
                    Set GFXMarioBMP(A) = LoadPicture(FileNamePath & "\mario-" & A & ".gif")
                    SelectObject GFXMario(A), GFXMarioBMP(A)
                    GFXMarioWidth(A) = frmMain.ScaleX(GFXMarioBMP(A).Width, vbHimetric, vbPixels)
                    GFXMarioHeight(A) = frmMain.ScaleY(GFXMarioBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    MarioFrameX(A) = -(GFXMarioWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    MarioFrameY(A) = -(GFXMarioHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(FileNamePath & "\mario-" & A & "m.gif") <> "" Then
                        Set GFXMarioMaskBMP(A) = LoadPicture(FileNamePath & "\mario-" & A & "m.gif")
                        SelectObject GFXMarioMask(A), GFXMarioMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\luigi*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(FileNamePath & "\luigi-" & A & ".gif") <> "" Then
                    GFXLuigiCustom(A) = True
                    Set GFXLuigiBMP(A) = LoadPicture(FileNamePath & "\luigi-" & A & ".gif")
                    SelectObject GFXLuigi(A), GFXLuigiBMP(A)
                    GFXLuigiWidth(A) = frmMain.ScaleX(GFXLuigiBMP(A).Width, vbHimetric, vbPixels)
                    GFXLuigiHeight(A) = frmMain.ScaleY(GFXLuigiBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    LuigiFrameX(A) = -(GFXLuigiWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    LuigiFrameY(A) = -(GFXLuigiHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(FileNamePath & "\luigi-" & A & "m.gif") <> "" Then
                        Set GFXLuigiMaskBMP(A) = LoadPicture(FileNamePath & "\luigi-" & A & "m.gif")
                        SelectObject GFXLuigiMask(A), GFXLuigiMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\peach*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(FileNamePath & "\peach-" & A & ".gif") <> "" Then
                    GFXPeachCustom(A) = True
                    Set GFXPeachBMP(A) = LoadPicture(FileNamePath & "\peach-" & A & ".gif")
                    SelectObject GFXPeach(A), GFXPeachBMP(A)
                    GFXPeachWidth(A) = frmMain.ScaleX(GFXPeachBMP(A).Width, vbHimetric, vbPixels)
                    GFXPeachHeight(A) = frmMain.ScaleY(GFXPeachBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    PeachFrameX(A) = -(GFXPeachWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    PeachFrameY(A) = -(GFXPeachHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(FileNamePath & "\peach-" & A & "m.gif") <> "" Then
                        Set GFXPeachMaskBMP(A) = LoadPicture(FileNamePath & "\peach-" & A & "m.gif")
                        SelectObject GFXPeachMask(A), GFXPeachMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\toad*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(FileNamePath & "\toad-" & A & ".gif") <> "" Then
                    GFXToadCustom(A) = True
                    Set GFXToadBMP(A) = LoadPicture(FileNamePath & "\toad-" & A & ".gif")
                    SelectObject GFXToad(A), GFXToadBMP(A)
                    GFXToadWidth(A) = frmMain.ScaleX(GFXToadBMP(A).Width, vbHimetric, vbPixels)
                    GFXToadHeight(A) = frmMain.ScaleY(GFXToadBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    ToadFrameX(A) = -(GFXToadWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    ToadFrameY(A) = -(GFXToadHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(FileNamePath & "\toad-" & A & "m.gif") <> "" Then
                        Set GFXToadMaskBMP(A) = LoadPicture(FileNamePath & "\toad-" & A & "m.gif")
                        SelectObject GFXToadMask(A), GFXToadMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\link*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(FileNamePath & "\link-" & A & ".gif") <> "" Then
                    GFXLinkCustom(A) = True
                    Set GFXLinkBMP(A) = LoadPicture(FileNamePath & "\link-" & A & ".gif")
                    SelectObject GFXLink(A), GFXLinkBMP(A)
                    GFXLinkWidth(A) = frmMain.ScaleX(GFXLinkBMP(A).Width, vbHimetric, vbPixels)
                    GFXLinkHeight(A) = frmMain.ScaleY(GFXLinkBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    LinkFrameX(A) = -(GFXLinkWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    LinkFrameY(A) = -(GFXLinkHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(FileNamePath & "\link-" & A & "m.gif") <> "" Then
                        Set GFXLinkMaskBMP(A) = LoadPicture(FileNamePath & "\link-" & A & "m.gif")
                        SelectObject GFXLinkMask(A), GFXLinkMaskBMP(A)
                    End If
                End If
            Next A
        End If
    End If
End Sub

Public Sub UnloadCustomGFX()
    Dim A As Integer
    SetupPlayerFrames
    For A = 1 To maxBlockType
        If GFXBlockCustom(A) = True Then
            If Dir(App.Path & "\graphics\block\block-" & A & ".gif") <> "" Then
                GFXBlockCustom(A) = False
                Set GFXBlockBMP(A) = LoadPicture(App.Path & "\graphics\block\block-" & A & ".gif")
                SelectObject GFXBlock(A), GFXBlockBMP(A)
                cBlockGFX A
                If Dir(App.Path & "\graphics\block\block-" & A & "m.gif") <> "" Then
                    Set GFXBlockMaskBMP(A) = LoadPicture(App.Path & "\graphics\block\block-" & A & "m.gif")
                    SelectObject GFXBlockMask(A), GFXBlockMaskBMP(A)
                End If
            End If
        End If
    Next A
    For A = 1 To numBackground2
        If GFXBackground2Custom(A) = True Then
            If Dir(App.Path & "\graphics\background2\background2-" & A & ".gif") <> "" Then
                GFXBackground2Custom(A) = False
                Set GFXBackground2BMP(A) = LoadPicture(App.Path & "\graphics\background2\background2-" & A & ".gif")
                GFXBackground2Width(A) = frmMain.ScaleX(GFXBackground2BMP(A).Width, vbHimetric, vbPixels)
                GFXBackground2Height(A) = frmMain.ScaleY(GFXBackground2BMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXBackground2(A), GFXBackground2BMP(A)
            End If
        End If
    Next A
    For A = 1 To maxNPCType
        If GFXNPCCustom(A) = True Then
            If Dir(App.Path & "\graphics\npc\npc-" & A & ".gif") <> "" Then
                GFXNPCCustom(A) = False
                Set GFXNPCBMP(A) = LoadPicture(App.Path & "\graphics\npc\npc-" & A & ".gif")
                GFXNPCWidth(A) = frmMain.ScaleX(GFXNPCBMP(A).Width, vbHimetric, vbPixels)
                GFXNPCHeight(A) = frmMain.ScaleY(GFXNPCBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXNPC(A), GFXNPCBMP(A)
                cNPCGFX A
                If Dir(App.Path & "\graphics\npc\npc-" & A & "m.gif") <> "" Then
                    Set GFXNPCMaskBMP(A) = LoadPicture(App.Path & "\graphics\npc\npc-" & A & "m.gif")
                    SelectObject GFXNPCMask(A), GFXNPCMaskBMP(A)
                End If
            End If
        End If
    Next A
    For A = 1 To maxEffectType
        If GFXEffectCustom(A) = True Then
            If Dir(App.Path & "\graphics\effect\effect-" & A & ".gif") <> "" Then
                GFXEffectCustom(A) = False
                Set GFXEffectBMP(A) = LoadPicture(App.Path & "\graphics\effect\effect-" & A & ".gif")
                GFXEffectWidth(A) = frmMain.ScaleX(GFXEffectBMP(A).Width, vbHimetric, vbPixels)
                GFXEffectHeight(A) = frmMain.ScaleY(GFXEffectBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXEffect(A), GFXEffectBMP(A)
                If Dir(App.Path & "\graphics\effect\effect-" & A & "m.gif") <> "" Then
                    Set GFXEffectMaskBMP(A) = LoadPicture(App.Path & "\graphics\effect\effect-" & A & "m.gif")
                    SelectObject GFXEffectMask(A), GFXEffectMaskBMP(A)
                End If
                EffectWidth(A) = EffectDefaults.EffectWidth(A)
                EffectHeight(A) = EffectDefaults.EffectHeight(A)
            End If
        End If
    Next A
    For A = 1 To maxBackgroundType
        If GFXBackgroundCustom(A) = True Then
            If Dir(App.Path & "\graphics\background\background-" & A & ".gif") <> "" Then
                GFXBackgroundCustom(A) = False
                Set GFXBackgroundBMP(A) = LoadPicture(App.Path & "\graphics\background\background-" & A & ".gif")
                GFXBackgroundWidth(A) = frmMain.ScaleX(GFXBackgroundBMP(A).Width, vbHimetric, vbPixels)
                BackgroundWidth(A) = GFXBackgroundWidth(A)
                GFXBackgroundHeight(A) = frmMain.ScaleY(GFXBackgroundBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXBackground(A), GFXBackgroundBMP(A)
                cBackgroundGFX A
                If Dir(App.Path & "\graphics\background\background-" & A & "m.gif") <> "" Then
                    Set GFXBackgroundMaskBMP(A) = LoadPicture(App.Path & "\graphics\background\background-" & A & "m.gif")
                    SelectObject GFXBackgroundMask(A), GFXBackgroundMaskBMP(A)
                End If
            End If
        End If
    Next A
    For A = 1 To 10
        If GFXYoshiBCustom(A) = True Then
            If Dir(App.Path & "\graphics\yoshi\yoshib-" & A & ".gif") <> "" Then
                GFXYoshiBCustom(A) = False
                Set GFXYoshiBBMP(A) = LoadPicture(App.Path & "\graphics\yoshi\yoshib-" & A & ".gif")
                SelectObject GFXYoshiB(A), GFXYoshiBBMP(A)
                If Dir(App.Path & "\graphics\yoshib\yoshib-" & A & "m.gif") <> "" Then
                    Set GFXYoshiBMaskBMP(A) = LoadPicture(App.Path & "\graphics\yoshi\yoshib-" & A & "m.gif")
                    SelectObject GFXYoshiBMask(A), GFXYoshiBMaskBMP(A)
                End If
            End If
        End If
    Next A
    For A = 1 To 10
        If GFXYoshiTCustom(A) = True Then
            If Dir(App.Path & "\graphics\yoshi\yoshit-" & A & ".gif") <> "" Then
                GFXYoshiTCustom(A) = False
                Set GFXYoshiTBMP(A) = LoadPicture(App.Path & "\graphics\yoshi\yoshit-" & A & ".gif")
                SelectObject GFXYoshiT(A), GFXYoshiTBMP(A)
                If Dir(App.Path & "\graphics\yoshit\yoshit-" & A & "m.gif") <> "" Then
                    Set GFXYoshiTMaskBMP(A) = LoadPicture(App.Path & "\graphics\yoshi\yoshit-" & A & "m.gif")
                    SelectObject GFXYoshiTMask(A), GFXYoshiTMaskBMP(A)
                End If
            End If
        End If
    Next A
    For A = 1 To 10
        If GFXMarioCustom(A) = True Then
            If Dir(App.Path & "\graphics\mario\mario-" & A & ".gif") <> "" Then
                GFXMarioCustom(A) = False
                Set GFXMarioBMP(A) = LoadPicture(App.Path & "\graphics\mario\mario-" & A & ".gif")
                GFXMarioWidth(A) = frmMain.ScaleX(GFXMarioBMP(A).Width, vbHimetric, vbPixels)
                GFXMarioHeight(A) = frmMain.ScaleY(GFXMarioBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXMario(A), GFXMarioBMP(A)
                If Dir(App.Path & "\graphics\mario\mario-" & A & "m.gif") <> "" Then
                    Set GFXMarioMaskBMP(A) = LoadPicture(App.Path & "\graphics\mario\mario-" & A & "m.gif")
                    GFXMarioMask(A) = CreateCompatibleDC(frmMain.hdc)
                    SelectObject GFXMarioMask(A), GFXMarioMaskBMP(A)
                End If
            End If
        End If
        If GFXLuigiCustom(A) = True Then
            If Dir(App.Path & "\graphics\luigi\luigi-" & A & ".gif") <> "" Then
                GFXLuigiCustom(A) = False
                Set GFXLuigiBMP(A) = LoadPicture(App.Path & "\graphics\luigi\luigi-" & A & ".gif")
                GFXLuigiWidth(A) = frmMain.ScaleX(GFXLuigiBMP(A).Width, vbHimetric, vbPixels)
                GFXLuigiHeight(A) = frmMain.ScaleY(GFXLuigiBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXLuigi(A), GFXLuigiBMP(A)
                If Dir(App.Path & "\graphics\luigi\luigi-" & A & "m.gif") <> "" Then
                    Set GFXLuigiMaskBMP(A) = LoadPicture(App.Path & "\graphics\luigi\luigi-" & A & "m.gif")
                    GFXLuigiMask(A) = CreateCompatibleDC(frmMain.hdc)
                    SelectObject GFXLuigiMask(A), GFXLuigiMaskBMP(A)
                End If
            End If
        End If
        If GFXPeachCustom(A) = True Then
            If Dir(App.Path & "\graphics\peach\peach-" & A & ".gif") <> "" Then
                GFXPeachCustom(A) = False
                Set GFXPeachBMP(A) = LoadPicture(App.Path & "\graphics\peach\peach-" & A & ".gif")
                GFXPeachWidth(A) = frmMain.ScaleX(GFXPeachBMP(A).Width, vbHimetric, vbPixels)
                GFXPeachHeight(A) = frmMain.ScaleY(GFXPeachBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXPeach(A), GFXPeachBMP(A)
                If Dir(App.Path & "\graphics\peach\peach-" & A & "m.gif") <> "" Then
                    Set GFXPeachMaskBMP(A) = LoadPicture(App.Path & "\graphics\peach\peach-" & A & "m.gif")
                    GFXPeachMask(A) = CreateCompatibleDC(frmMain.hdc)
                    SelectObject GFXPeachMask(A), GFXPeachMaskBMP(A)
                End If
            End If
        End If
        If GFXToadCustom(A) = True Then
            If Dir(App.Path & "\graphics\toad\toad-" & A & ".gif") <> "" Then
                GFXToadCustom(A) = False
                Set GFXToadBMP(A) = LoadPicture(App.Path & "\graphics\toad\toad-" & A & ".gif")
                GFXToadWidth(A) = frmMain.ScaleX(GFXToadBMP(A).Width, vbHimetric, vbPixels)
                GFXToadHeight(A) = frmMain.ScaleY(GFXToadBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXToad(A), GFXToadBMP(A)
                If Dir(App.Path & "\graphics\toad\toad-" & A & "m.gif") <> "" Then
                    Set GFXToadMaskBMP(A) = LoadPicture(App.Path & "\graphics\toad\toad-" & A & "m.gif")
                    GFXToadMask(A) = CreateCompatibleDC(frmMain.hdc)
                    SelectObject GFXToadMask(A), GFXToadMaskBMP(A)
                End If
            End If
        End If
        If GFXLinkCustom(A) = True Then
            If Dir(App.Path & "\graphics\link\link-" & A & ".gif") <> "" Then
                GFXLinkCustom(A) = False
                Set GFXLinkBMP(A) = LoadPicture(App.Path & "\graphics\link\link-" & A & ".gif")
                GFXLinkWidth(A) = frmMain.ScaleX(GFXLinkBMP(A).Width, vbHimetric, vbPixels)
                GFXLinkHeight(A) = frmMain.ScaleY(GFXLinkBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXLink(A), GFXLinkBMP(A)
                If Dir(App.Path & "\graphics\link\link-" & A & "m.gif") <> "" Then
                    Set GFXLinkMaskBMP(A) = LoadPicture(App.Path & "\graphics\link\link-" & A & "m.gif")
                    GFXLinkMask(A) = CreateCompatibleDC(frmMain.hdc)
                    SelectObject GFXLinkMask(A), GFXLinkMaskBMP(A)
                End If
            End If
        End If
    Next A
End Sub


Public Sub LoadCustomGFX2(GFXFilePath As String)
    Dim A As Integer
    Dim B As Integer
    If Dir(GFXFilePath & "\*.gif") <> "" Then
        If Dir(GFXFilePath & "\block*.gif") <> "" Then
            For A = 1 To maxBlockType
                If Dir(GFXFilePath & "\block-" & A & ".gif") <> "" Then
                    GFXBlockCustom(A) = True
                    Set GFXBlockBMP(A) = LoadPicture(GFXFilePath & "\block-" & A & ".gif")
                    SelectObject GFXBlock(A), GFXBlockBMP(A)
                    cBlockGFX A
                    If Dir(GFXFilePath & "\block-" & A & "m.gif") <> "" Then
                        Set GFXBlockMaskBMP(A) = LoadPicture(GFXFilePath & "\block-" & A & "m.gif")
                        SelectObject GFXBlockMask(A), GFXBlockMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\background2*.gif") <> "" Then
            For A = 1 To numBackground2
                If Dir(GFXFilePath & "\background2-" & A & ".gif") <> "" Then
                    GFXBackground2Custom(A) = True
                    Set GFXBackground2BMP(A) = LoadPicture(GFXFilePath & "\background2-" & A & ".gif")
                    SelectObject GFXBackground2(A), GFXBackground2BMP(A)
                    GFXBackground2Width(A) = frmMain.ScaleX(GFXBackground2BMP(A).Width, vbHimetric, vbPixels)
                    GFXBackground2Height(A) = frmMain.ScaleY(GFXBackground2BMP(A).Height, vbHimetric, vbPixels)
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\npc*.gif") <> "" Then
            For A = 1 To maxNPCType
                If Dir(GFXFilePath & "\npc-" & A & ".gif") <> "" Then
                    GFXNPCCustom(A) = True
                    Set GFXNPCBMP(A) = LoadPicture(GFXFilePath & "\npc-" & A & ".gif")
                    SelectObject GFXNPC(A), GFXNPCBMP(A)
                    GFXNPCWidth(A) = frmMain.ScaleX(GFXNPCBMP(A).Width, vbHimetric, vbPixels)
                    GFXNPCHeight(A) = frmMain.ScaleY(GFXNPCBMP(A).Height, vbHimetric, vbPixels)
                    cNPCGFX A
                    If Dir(GFXFilePath & "\npc-" & A & "m.gif") <> "" Then
                        Set GFXNPCMaskBMP(A) = LoadPicture(GFXFilePath & "\npc-" & A & "m.gif")
                        SelectObject GFXNPCMask(A), GFXNPCMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\effect*.gif") <> "" Then
            For A = 1 To maxEffectType
                If Dir(GFXFilePath & "\effect-" & A & ".gif") <> "" Then
                    GFXEffectCustom(A) = True
                    Set GFXEffectBMP(A) = LoadPicture(GFXFilePath & "\effect-" & A & ".gif")
                    SelectObject GFXEffect(A), GFXEffectBMP(A)
                    GFXEffectWidth(A) = frmMain.ScaleX(GFXEffectBMP(A).Width, vbHimetric, vbPixels)
                    EffectHeight(A) = GFXEffectHeight(A)
                    GFXEffectHeight(A) = frmMain.ScaleY(GFXEffectBMP(A).Height, vbHimetric, vbPixels)
                    If Dir(GFXFilePath & "\effect-" & A & "m.gif") <> "" Then
                        Set GFXEffectMaskBMP(A) = LoadPicture(GFXFilePath & "\effect-" & A & "m.gif")
                        SelectObject GFXEffectMask(A), GFXEffectMaskBMP(A)
                    End If
                    EffectWidth(A) = GFXEffectWidth(A)
                    EffectHeight(A) = EffectDefaults.EffectHeight(A) / EffectHeight(A) * GFXEffectHeight(A)
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\background*.gif") <> "" Then
            For A = 1 To maxBackgroundType
                If Dir(GFXFilePath & "\background-" & A & ".gif") <> "" Then
                    GFXBackgroundCustom(A) = True
                    Set GFXBackgroundBMP(A) = LoadPicture(GFXFilePath & "\background-" & A & ".gif")
                    SelectObject GFXBackground(A), GFXBackgroundBMP(A)
                    GFXBackgroundWidth(A) = frmMain.ScaleX(GFXBackgroundBMP(A).Width, vbHimetric, vbPixels)
                    GFXBackgroundHeight(A) = frmMain.ScaleY(GFXBackgroundBMP(A).Height, vbHimetric, vbPixels)
                    GFXBackgroundWidth(A) = GFXBackgroundWidth(A)
                    GFXBackgroundHeight(A) = GFXBackgroundHeight(A)
                    cBackgroundGFX A
                    If Dir(GFXFilePath & "\background-" & A & "m.gif") <> "" Then
                        Set GFXBackgroundMaskBMP(A) = LoadPicture(GFXFilePath & "\background-" & A & "m.gif")
                        SelectObject GFXBackgroundMask(A), GFXBackgroundMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\yoshib*.gif") <> "" Then
            For A = 1 To 10
                If Dir(GFXFilePath & "\yoshib-" & A & ".gif") <> "" Then
                    GFXYoshiBCustom(A) = True
                    Set GFXYoshiBBMP(A) = LoadPicture(GFXFilePath & "\yoshib-" & A & ".gif")
                    SelectObject GFXYoshiB(A), GFXYoshiBBMP(A)
                    If Dir(GFXFilePath & "\yoshib-" & A & "m.gif") <> "" Then
                        Set GFXYoshiBMaskBMP(A) = LoadPicture(GFXFilePath & "\yoshib-" & A & "m.gif")
                        SelectObject GFXYoshiBMask(A), GFXYoshiBMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\yoshit*.gif") <> "" Then
            For A = 1 To 10
                If Dir(GFXFilePath & "\yoshit-" & A & ".gif") <> "" Then
                    GFXYoshiTCustom(A) = True
                    Set GFXYoshiTBMP(A) = LoadPicture(GFXFilePath & "\yoshit-" & A & ".gif")
                    SelectObject GFXYoshiT(A), GFXYoshiTBMP(A)
                    If Dir(GFXFilePath & "\yoshit-" & A & "m.gif") <> "" Then
                        Set GFXYoshiTMaskBMP(A) = LoadPicture(GFXFilePath & "\yoshit-" & A & "m.gif")
                        SelectObject GFXYoshiTMask(A), GFXYoshiTMaskBMP(A)
                    End If
                End If
            Next A
        End If
        
        If Dir(GFXFilePath & "\mario*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(GFXFilePath & "\mario-" & A & ".gif") <> "" Then
                    GFXMarioCustom(A) = True
                    Set GFXMarioBMP(A) = LoadPicture(GFXFilePath & "\mario-" & A & ".gif")
                    SelectObject GFXMario(A), GFXMarioBMP(A)
                    GFXMarioWidth(A) = frmMain.ScaleX(GFXMarioBMP(A).Width, vbHimetric, vbPixels)
                    GFXMarioHeight(A) = frmMain.ScaleY(GFXMarioBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    MarioFrameX(A) = -(GFXMarioWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    MarioFrameY(A) = -(GFXMarioHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(GFXFilePath & "\mario-" & A & "m.gif") <> "" Then
                        Set GFXMarioMaskBMP(A) = LoadPicture(GFXFilePath & "\mario-" & A & "m.gif")
                        SelectObject GFXMarioMask(A), GFXMarioMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\luigi*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(GFXFilePath & "\luigi-" & A & ".gif") <> "" Then
                    GFXLuigiCustom(A) = True
                    Set GFXLuigiBMP(A) = LoadPicture(GFXFilePath & "\luigi-" & A & ".gif")
                    SelectObject GFXLuigi(A), GFXLuigiBMP(A)
                    GFXLuigiWidth(A) = frmMain.ScaleX(GFXLuigiBMP(A).Width, vbHimetric, vbPixels)
                    GFXLuigiHeight(A) = frmMain.ScaleY(GFXLuigiBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    LuigiFrameX(A) = -(GFXLuigiWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    LuigiFrameY(A) = -(GFXLuigiHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(GFXFilePath & "\luigi-" & A & "m.gif") <> "" Then
                        Set GFXLuigiMaskBMP(A) = LoadPicture(GFXFilePath & "\luigi-" & A & "m.gif")
                        SelectObject GFXLuigiMask(A), GFXLuigiMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\peach*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(GFXFilePath & "\peach-" & A & ".gif") <> "" Then
                    GFXPeachCustom(A) = True
                    Set GFXPeachBMP(A) = LoadPicture(GFXFilePath & "\peach-" & A & ".gif")
                    SelectObject GFXPeach(A), GFXPeachBMP(A)
                    GFXPeachWidth(A) = frmMain.ScaleX(GFXPeachBMP(A).Width, vbHimetric, vbPixels)
                    GFXPeachHeight(A) = frmMain.ScaleY(GFXPeachBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    PeachFrameX(A) = -(GFXPeachWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    PeachFrameY(A) = -(GFXPeachHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(GFXFilePath & "\peach-" & A & "m.gif") <> "" Then
                        Set GFXPeachMaskBMP(A) = LoadPicture(GFXFilePath & "\peach-" & A & "m.gif")
                        SelectObject GFXPeachMask(A), GFXPeachMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\toad*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(GFXFilePath & "\toad-" & A & ".gif") <> "" Then
                    GFXToadCustom(A) = True
                    Set GFXToadBMP(A) = LoadPicture(GFXFilePath & "\toad-" & A & ".gif")
                    SelectObject GFXToad(A), GFXToadBMP(A)
                    GFXToadWidth(A) = frmMain.ScaleX(GFXToadBMP(A).Width, vbHimetric, vbPixels)
                    GFXToadHeight(A) = frmMain.ScaleY(GFXToadBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    ToadFrameX(A) = -(GFXToadWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    ToadFrameY(A) = -(GFXToadHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(GFXFilePath & "\toad-" & A & "m.gif") <> "" Then
                        Set GFXToadMaskBMP(A) = LoadPicture(GFXFilePath & "\toad-" & A & "m.gif")
                        SelectObject GFXToadMask(A), GFXToadMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(GFXFilePath & "\link*.gif") <> "" Then
            For A = 1 To maxPlayerFrames
                If Dir(GFXFilePath & "\link-" & A & ".gif") <> "" Then
                    GFXLinkCustom(A) = True
                    Set GFXLinkBMP(A) = LoadPicture(GFXFilePath & "\link-" & A & ".gif")
                    SelectObject GFXLink(A), GFXLinkBMP(A)
                    GFXLinkWidth(A) = frmMain.ScaleX(GFXLinkBMP(A).Width, vbHimetric, vbPixels)
                    GFXLinkHeight(A) = frmMain.ScaleY(GFXLinkBMP(A).Height, vbHimetric, vbPixels)
                    If A < 150 Then
                        B = 1
                    Else
                        B = 2
                    End If
                    LinkFrameX(A) = -(GFXLinkWidth(A) / 2 - Physics.PlayerWidth(1, B) / 2)
                    LinkFrameY(A) = -(GFXLinkHeight(A) - Physics.PlayerHeight(1, B) - 2)
                    If Dir(GFXFilePath & "\link-" & A & "m.gif") <> "" Then
                        Set GFXLinkMaskBMP(A) = LoadPicture(GFXFilePath & "\link-" & A & "m.gif")
                        SelectObject GFXLinkMask(A), GFXLinkMaskBMP(A)
                    End If
                End If
            Next A
        End If
    End If
End Sub

Public Sub LoadWorldCustomGFX()
    Dim A As Integer
    Dim B As Integer
    If Dir(FileNamePath & "*.gif") <> "" Then
        If Dir(FileNamePath & "\tile*.gif") <> "" Then
            For A = 1 To maxTileType
                If Dir(FileNamePath & "\tile-" & A & ".gif") <> "" Then
                    GFXTileCustom(A) = True
                    Set GFXTileBMP(A) = LoadPicture(FileNamePath & "\tile-" & A & ".gif")
                    SelectObject GFXTile(A), GFXTileBMP(A)
                    GFXTileWidth(A) = frmMain.ScaleX(GFXTileBMP(A).Width, vbHimetric, vbPixels)
                    GFXTileHeight(A) = frmMain.ScaleY(GFXTileBMP(A).Height, vbHimetric, vbPixels)
                    cTileGFX A
                End If
            Next A
        End If
        If Dir(FileNamePath & "\level*.gif") <> "" Then
            For A = 1 To maxLevelType
                If Dir(FileNamePath & "\level-" & A & ".gif") <> "" Then
                    GFXLevelCustom(A) = True
                    Set GFXLevelBMP(A) = LoadPicture(FileNamePath & "\level-" & A & ".gif")
                    SelectObject GFXLevel(A), GFXLevelBMP(A)
                    GFXLevelWidth(A) = frmMain.ScaleX(GFXLevelBMP(A).Width, vbHimetric, vbPixels)
                    GFXLevelHeight(A) = frmMain.ScaleY(GFXLevelBMP(A).Height, vbHimetric, vbPixels)
                    cLevelGFX A
                    If Dir(FileNamePath & "\level-" & A & "m.gif") <> "" Then
                        Set GFXLevelMaskBMP(A) = LoadPicture(FileNamePath & "\level-" & A & "m.gif")
                        SelectObject GFXLevelMask(A), GFXLevelMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\scene*.gif") <> "" Then
            For A = 1 To maxSceneType
                If Dir(FileNamePath & "\scene-" & A & ".gif") <> "" Then
                    GFXSceneCustom(A) = True
                    Set GFXSceneBMP(A) = LoadPicture(FileNamePath & "\scene-" & A & ".gif")
                    SelectObject GFXScene(A), GFXSceneBMP(A)
                    GFXSceneWidth(A) = frmMain.ScaleX(GFXSceneBMP(A).Width, vbHimetric, vbPixels)
                    GFXSceneHeight(A) = frmMain.ScaleY(GFXSceneBMP(A).Height, vbHimetric, vbPixels)
                    cSceneGFX A
                    If Dir(FileNamePath & "\scene-" & A & "m.gif") <> "" Then
                        Set GFXSceneMaskBMP(A) = LoadPicture(FileNamePath & "\scene-" & A & "m.gif")
                        SelectObject GFXSceneMask(A), GFXSceneMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\player*.gif") <> "" Then
            For A = 1 To numCharacters
                If Dir(FileNamePath & "\player-" & A & ".gif") <> "" Then
                    GFXPlayerCustom(A) = True
                    Set GFXPlayerBMP(A) = LoadPicture(FileNamePath & "\player-" & A & ".gif")
                    SelectObject GFXPlayer(A), GFXPlayerBMP(A)
                    GFXPlayerWidth(A) = frmMain.ScaleX(GFXPlayerBMP(A).Width, vbHimetric, vbPixels)
                    GFXPlayerHeight(A) = frmMain.ScaleY(GFXPlayerBMP(A).Height, vbHimetric, vbPixels)
                    If Dir(FileNamePath & "\player-" & A & "m.gif") <> "" Then
                        Set GFXPlayerMaskBMP(A) = LoadPicture(FileNamePath & "\player-" & A & "m.gif")
                        SelectObject GFXPlayerMask(A), GFXPlayerMaskBMP(A)
                    End If
                End If
            Next A
        End If
        If Dir(FileNamePath & "\path*.gif") <> "" Then
            For A = 1 To maxPathType
                If Dir(FileNamePath & "\path-" & A & ".gif") <> "" Then
                    GFXPathCustom(A) = True
                    Set GFXPathBMP(A) = LoadPicture(FileNamePath & "\path-" & A & ".gif")
                    SelectObject GFXPath(A), GFXPathBMP(A)
                    GFXPathWidth(A) = frmMain.ScaleX(GFXPathBMP(A).Width, vbHimetric, vbPixels)
                    GFXPathHeight(A) = frmMain.ScaleY(GFXPathBMP(A).Height, vbHimetric, vbPixels)
                    cPathGFX A
                    If Dir(FileNamePath & "\path-" & A & "m.gif") <> "" Then
                        Set GFXPathMaskBMP(A) = LoadPicture(FileNamePath & "\path-" & A & "m.gif")
                        SelectObject GFXPathMask(A), GFXPathMaskBMP(A)
                    End If
                End If
            Next A
        End If
    End If
End Sub

Public Sub UnloadWorldCustomGFX()
    Dim A As Integer
    For A = 1 To maxTileType
        If GFXTileCustom(A) = True Then
            If Dir(App.Path & "\graphics\tile\tile-" & A & ".gif") <> "" Then
                GFXTileCustom(A) = False
                Set GFXTileBMP(A) = LoadPicture(App.Path & "\graphics\tile\tile-" & A & ".gif")
                GFXTileWidth(A) = frmMain.ScaleX(GFXTileBMP(A).Width, vbHimetric, vbPixels)
                GFXTileHeight(A) = frmMain.ScaleY(GFXTileBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXTile(A), GFXTileBMP(A)
                cTileGFX A
            End If
        End If
    Next A
    For A = 1 To maxLevelType
        If GFXLevelCustom(A) = True Then
            If Dir(App.Path & "\graphics\level\level-" & A & ".gif") <> "" Then
                GFXLevelCustom(A) = False
                Set GFXLevelBMP(A) = LoadPicture(App.Path & "\graphics\level\level-" & A & ".gif")
                GFXLevelWidth(A) = frmMain.ScaleX(GFXLevelBMP(A).Width, vbHimetric, vbPixels)
                GFXLevelHeight(A) = frmMain.ScaleY(GFXLevelBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXLevel(A), GFXLevelBMP(A)
                cLevelGFX A
                If Dir(App.Path & "\graphics\level\level-" & A & "m.gif") <> "" Then
                    Set GFXLevelMaskBMP(A) = LoadPicture(App.Path & "\graphics\level\level-" & A & "m.gif")
                    SelectObject GFXLevelMask(A), GFXLevelMaskBMP(A)
                End If
            End If
        End If
    Next A
    For A = 1 To maxSceneType
        If GFXSceneCustom(A) = True Then
            If Dir(App.Path & "\graphics\scene\scene-" & A & ".gif") <> "" Then
                GFXSceneCustom(A) = False
                Set GFXSceneBMP(A) = LoadPicture(App.Path & "\graphics\scene\scene-" & A & ".gif")
                GFXSceneWidth(A) = frmMain.ScaleX(GFXSceneBMP(A).Width, vbHimetric, vbPixels)
                GFXSceneHeight(A) = frmMain.ScaleY(GFXSceneBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXScene(A), GFXSceneBMP(A)
                cLevelGFX A
                If Dir(App.Path & "\graphics\scene\scene-" & A & "m.gif") <> "" Then
                    Set GFXSceneMaskBMP(A) = LoadPicture(App.Path & "\graphics\scene\scene-" & A & "m.gif")
                    SelectObject GFXSceneMask(A), GFXSceneMaskBMP(A)
                End If
            End If
        End If
    Next A
    For A = 1 To numCharacters
        If GFXPlayerCustom(A) = True Then
            If Dir(App.Path & "\graphics\player\player-" & A & ".gif") <> "" Then
                GFXPlayerCustom(A) = False
                Set GFXPlayerBMP(A) = LoadPicture(App.Path & "\graphics\player\player-" & A & ".gif")
                GFXPlayerWidth(A) = frmMain.ScaleX(GFXPlayerBMP(A).Width, vbHimetric, vbPixels)
                GFXPlayerHeight(A) = frmMain.ScaleY(GFXPlayerBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXPlayer(A), GFXPlayerBMP(A)
                If Dir(App.Path & "\graphics\player\player-" & A & "m.gif") <> "" Then
                    Set GFXPlayerMaskBMP(A) = LoadPicture(App.Path & "\graphics\player\player-" & A & "m.gif")
                    SelectObject GFXPlayerMask(A), GFXPlayerMaskBMP(A)
                End If
            End If
        End If
    Next A
    For A = 1 To maxPathType
        If GFXPathCustom(A) = True Then
            If Dir(App.Path & "\graphics\path\path-" & A & ".gif") <> "" Then
                GFXPathCustom(A) = False
                Set GFXPathBMP(A) = LoadPicture(App.Path & "\graphics\path\path-" & A & ".gif")
                GFXPathWidth(A) = frmMain.ScaleX(GFXPathBMP(A).Width, vbHimetric, vbPixels)
                GFXPathHeight(A) = frmMain.ScaleY(GFXPathBMP(A).Height, vbHimetric, vbPixels)
                SelectObject GFXPath(A), GFXPathBMP(A)
                cPathGFX A
                If Dir(App.Path & "\graphics\path\path-" & A & "m.gif") <> "" Then
                    Set GFXPathMaskBMP(A) = LoadPicture(App.Path & "\graphics\path\path-" & A & "m.gif")
                    SelectObject GFXPathMask(A), GFXPathMaskBMP(A)
                End If
            End If
        End If
    Next A
End Sub


Private Sub cBlockGFX(A As Integer)
    Dim sWidth As Single
    Dim sHeight As Single
    If LevelEditor = True Or MagicHand = True Then
        sWidth = 32
        sHeight = 32
        If BlockWidth(A) > BlockHeight(A) Then
            sHeight = BlockHeight(A) * sWidth / BlockWidth(A)
        ElseIf BlockHeight(A) > BlockWidth(A) Then
            sWidth = BlockWidth(A) * sHeight / BlockHeight(A)
        End If
        BitBlt GFX.BlitToMe.hdc, 0, 0, 40, 40, 0, 0, 0, vbWhiteness
        StretchBlt GFX.BlitToMe.hdc, 2 + 16 - sWidth / 2, 2 + 16 - sHeight / 2, sWidth, sHeight, GFXBlock(A), 0, 0, BlockWidth(A), BlockHeight(A), vbSrcCopy
        GFX.BlitToMe.Picture = GFX.BlitToMe.Image
        frmBlocks.Block(A).Picture = GFX.BlitToMe.Picture
    End If
End Sub

Private Sub cNPCGFX(A As Integer)
    Dim sWidth As Single
    Dim sHeight As Single
    On Error Resume Next
    If LevelEditor = True Or MagicHand = True Then
        sWidth = 32
        sHeight = 32
        BitBlt GFX.BlitToMe.hdc, 0, 0, 40, 40, 0, 0, 0, vbWhiteness
        If NPCWidthGFX(A) = 0 Then
            If NPCWidth(A) > NPCHeight(A) Then
                sHeight = NPCHeight(A) * sWidth / NPCWidth(A)
            ElseIf NPCWidth(A) < NPCHeight(A) Then
                sWidth = NPCWidth(A) * sHeight / NPCHeight(A)
            End If
            StretchBlt GFX.BlitToMe.hdc, 2 + 16 - sWidth / 2, 2 + 16 - sHeight / 2, sWidth, sHeight, GFXNPC(A), 0, 0, NPCWidth(A), NPCHeight(A), vbSrcCopy
        Else
            If NPCWidthGFX(A) > NPCHeightGFX(A) Then
                sHeight = NPCHeightGFX(A) * sWidth / NPCWidthGFX(A)
            ElseIf NPCWidthGFX(A) < NPCHeightGFX(A) Then
                sWidth = NPCWidthGFX(A) * sHeight / NPCHeightGFX(A)
            End If
            StretchBlt GFX.BlitToMe.hdc, 2 + 16 - sWidth / 2, 2 + 16 - sHeight / 2, sWidth, sHeight, GFXNPC(A), 0, 0, NPCWidthGFX(A), NPCHeightGFX(A), vbSrcCopy
        End If
        GFX.BlitToMe.Picture = GFX.BlitToMe.Image
        frmNPCs.NPC(A).Picture = GFX.BlitToMe.Picture
    End If
End Sub

Private Sub cBackgroundGFX(A As Integer)
    Dim sWidth As Single
    Dim sHeight As Single
    If LevelEditor = True Or MagicHand = True Then
        sWidth = 32
        sHeight = 32
        If BackgroundWidth(A) > BackgroundHeight(A) Then
            sHeight = BackgroundHeight(A) * sWidth / BackgroundWidth(A)
        ElseIf BlockHeight(A) > BlockWidth(A) Then
            sWidth = BackgroundWidth(A) * sHeight / BackgroundHeight(A)
        End If
        BitBlt GFX.BlitToMe.hdc, 0, 0, 40, 40, 0, 0, 0, vbWhiteness
        StretchBlt GFX.BlitToMe.hdc, 2 + 16 - sWidth / 2, 2 + 16 - sHeight / 2, sWidth, sHeight, GFXBackground(A), 0, 0, BackgroundWidth(A), BackgroundHeight(A), vbSrcCopy
        GFX.BlitToMe.Picture = GFX.BlitToMe.Image
        frmBackgrounds.Background(A).Picture = GFX.BlitToMe.Picture
    End If
End Sub

Private Sub cTileGFX(A As Integer)
    Dim sWidth As Single
    Dim sHeight As Single
    If LevelEditor = True Or MagicHand = True Then
        sWidth = 32
        sHeight = 32
        If TileWidth(A) > TileHeight(A) Then
            sHeight = TileHeight(A) * sWidth / TileWidth(A)
        ElseIf BlockHeight(A) > BlockWidth(A) Then
            sWidth = TileWidth(A) * sHeight / TileHeight(A)
        End If
        BitBlt GFX.BlitToMe.hdc, 0, 0, 40, 40, 0, 0, 0, vbWhiteness
        StretchBlt GFX.BlitToMe.hdc, 2 + 16 - sWidth / 2, 2 + 16 - sHeight / 2, sWidth, sHeight, GFXTile(A), 0, 0, TileWidth(A), TileHeight(A), vbSrcCopy
        GFX.BlitToMe.Picture = GFX.BlitToMe.Image
        frmTiles.Tile(A).Picture = GFX.BlitToMe.Picture
    End If
End Sub

Private Sub cSceneGFX(A As Integer)
    Dim sWidth As Single
    Dim sHeight As Single
    If LevelEditor = True Or MagicHand = True Then
        sWidth = 32
        sHeight = 32
        If SceneWidth(A) > SceneHeight(A) Then
            sHeight = SceneHeight(A) * sWidth / SceneWidth(A)
        ElseIf BlockHeight(A) > BlockWidth(A) Then
            sWidth = SceneWidth(A) * sHeight / SceneHeight(A)
        End If
        BitBlt GFX.BlitToMe.hdc, 0, 0, 40, 40, 0, 0, 0, vbWhiteness
        StretchBlt GFX.BlitToMe.hdc, 2 + 16 - sWidth / 2, 2 + 16 - sHeight / 2, sWidth, sHeight, GFXScene(A), 0, 0, SceneWidth(A), SceneHeight(A), vbSrcCopy
        GFX.BlitToMe.Picture = GFX.BlitToMe.Image
        frmScene.Scene(A).Picture = GFX.BlitToMe.Picture
    End If
End Sub

Private Sub cLevelGFX(A As Integer)
    Dim sWidth As Single
    Dim sHeight As Single
    If LevelEditor = True Or MagicHand = True Then
        sWidth = 32
        sHeight = 32
        BitBlt GFX.BlitToMe.hdc, 0, 0, 40, 40, 0, 0, 0, vbWhiteness
        If GFXLevelBig(A) = True Then
            If GFXLevelWidth(A) > GFXLevelHeight(A) Then
                sHeight = GFXLevelHeight(A) * sWidth / GFXLevelWidth(A)
            ElseIf GFXLevelHeight(A) > GFXLevelWidth(A) Then
                sWidth = GFXLevelWidth(A) * sHeight / GFXLevelHeight(A)
            End If
            StretchBlt GFX.BlitToMe.hdc, 2 + 16 - sWidth / 2, 2 + 16 - sHeight / 2, sWidth, sHeight, GFXLevel(A), 0, 0, GFXLevelWidth(A), GFXLevelHeight(A), vbSrcCopy
        Else
            StretchBlt GFX.BlitToMe.hdc, 2 + 16 - sWidth / 2, 2 + 16 - sHeight / 2, sWidth, sHeight, GFXLevel(A), 0, 0, 32, 32, vbSrcCopy
        End If
        GFX.BlitToMe.Picture = GFX.BlitToMe.Image
        frmLevels.WorldLevel(A).Picture = GFX.BlitToMe.Picture
    End If
End Sub

Private Sub cPathGFX(A As Integer)
    Dim sWidth As Single
    Dim sHeight As Single
    If LevelEditor = True Or MagicHand = True Then
        sWidth = 32
        sHeight = 32
        BitBlt GFX.BlitToMe.hdc, 0, 0, 40, 40, 0, 0, 0, vbWhiteness
        StretchBlt GFX.BlitToMe.hdc, 2 + 16 - sWidth / 2, 2 + 16 - sHeight / 2, sWidth, sHeight, GFXPath(A), 0, 0, 32, 32, vbSrcCopy
        GFX.BlitToMe.Picture = GFX.BlitToMe.Image
        frmPaths.WorldPath(A).Picture = GFX.BlitToMe.Picture
    End If
End Sub

Public Sub UpdateLoad()
    Dim A As Integer
    If LoadCoinsT <= Timer Then
        LoadCoinsT = Timer + 0.1
        LoadCoins = LoadCoins + 1
        If LoadCoins > 3 Then LoadCoins = 0
        If LevelEditor = True Then
            BitBlt frmSplash.LoadCoin.hdc, 0, 0, frmSplash.LoadCoin.Width, frmSplash.LoadCoin.Height, GFX.BgHolder.hdc, 0, 0, vbSrcCopy
            BitBlt frmSplash.LoadCoin.hdc, 0, 0, GFX.LoadCoin.ScaleWidth, 32, GFX.LoadCoinMask.hdc, 0, 32 * LoadCoins, vbSrcAnd
            BitBlt frmSplash.LoadCoin.hdc, 0, 0, GFX.LoadCoin.ScaleWidth, 32, GFX.LoadCoin.hdc, 0, 32 * LoadCoins, vbSrcPaint
            frmSplash.LoadCoin.Refresh
        Else
            BitBlt frmMain.LoadCoin.hdc, 0, 0, frmMain.LoadCoin.Width, frmMain.LoadCoin.Height, GFX.BgHolder.hdc, 0, 0, vbSrcCopy
            BitBlt frmMain.LoadCoin.hdc, 0, 0, GFX.LoadCoin.ScaleWidth, 32, GFX.LoadCoinMask.hdc, 0, 32 * LoadCoins, vbSrcAnd
            BitBlt frmMain.LoadCoin.hdc, 0, 0, GFX.LoadCoin.ScaleWidth, 32, GFX.LoadCoin.hdc, 0, 32 * LoadCoins, vbSrcPaint
            frmMain.LoadCoin.Refresh
        End If
    End If
    DoEvents
End Sub

