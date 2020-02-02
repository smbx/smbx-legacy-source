VERSION 5.00
Begin VB.Form frmLevelDebugger 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Debugger"
   ClientHeight    =   6255
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4830
   Icon            =   "frmLevelDebugger.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6255
   ScaleWidth      =   4830
   Begin VB.Frame Frame7 
      Caption         =   "Level Info"
      Height          =   3615
      Left            =   120
      TabIndex        =   27
      Top             =   2520
      Width           =   2175
      Begin VB.Label Label17 
         AutoSize        =   -1  'True
         Caption         =   "Dragon Coins"
         Height          =   195
         Left            =   240
         TabIndex        =   53
         Top             =   3240
         Width           =   960
      End
      Begin VB.Label lblDragonCoins 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   52
         Top             =   3240
         Width           =   90
      End
      Begin VB.Label lblIceFlowers 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   51
         Top             =   1560
         Width           =   90
      End
      Begin VB.Label Label11 
         AutoSize        =   -1  'True
         Caption         =   "Ice Flowers"
         Height          =   195
         Left            =   240
         TabIndex        =   50
         Top             =   1560
         Width           =   810
      End
      Begin VB.Label lbl1Ups 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   49
         Top             =   3000
         Width           =   90
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         Caption         =   "1-Ups"
         Height          =   195
         Left            =   240
         TabIndex        =   48
         Top             =   3000
         Width           =   420
      End
      Begin VB.Label lblCoins 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   47
         Top             =   360
         Width           =   90
      End
      Begin VB.Label lblStars 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   46
         Top             =   600
         Width           =   90
      End
      Begin VB.Label lblExits 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   45
         Top             =   840
         Width           =   90
      End
      Begin VB.Label lblMushrooms 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   44
         Top             =   1080
         Width           =   90
      End
      Begin VB.Label lblFireFlowers 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   43
         Top             =   1320
         Width           =   90
      End
      Begin VB.Label lblLeaves 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   42
         Top             =   1800
         Width           =   90
      End
      Begin VB.Label Label23 
         AutoSize        =   -1  'True
         Caption         =   "Kuribo's Shoes"
         Height          =   195
         Left            =   240
         TabIndex        =   41
         Top             =   2760
         Width           =   1050
      End
      Begin VB.Label Label22 
         AutoSize        =   -1  'True
         Caption         =   "Yoshis"
         Height          =   195
         Left            =   240
         TabIndex        =   40
         Top             =   2520
         Width           =   465
      End
      Begin VB.Label Label21 
         AutoSize        =   -1  'True
         Caption         =   "Tanooki Suits"
         Height          =   195
         Left            =   240
         TabIndex        =   39
         Top             =   2280
         Width           =   975
      End
      Begin VB.Label Label20 
         AutoSize        =   -1  'True
         Caption         =   "Hammer Suits"
         Height          =   195
         Left            =   240
         TabIndex        =   38
         Top             =   2040
         Width           =   975
      End
      Begin VB.Label Label19 
         AutoSize        =   -1  'True
         Caption         =   "Leaves"
         Height          =   195
         Left            =   240
         TabIndex        =   37
         Top             =   1800
         Width           =   525
      End
      Begin VB.Label Label18 
         AutoSize        =   -1  'True
         Caption         =   "Fire Flowers"
         Height          =   195
         Left            =   240
         TabIndex        =   36
         Top             =   1320
         Width           =   840
      End
      Begin VB.Label lblHammerSuits 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   35
         Top             =   2040
         Width           =   90
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Coins"
         Height          =   195
         Left            =   240
         TabIndex        =   34
         Top             =   360
         Width           =   390
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "Stars"
         Height          =   195
         Left            =   240
         TabIndex        =   33
         Top             =   600
         Width           =   360
      End
      Begin VB.Label Label14 
         AutoSize        =   -1  'True
         Caption         =   "Exits"
         Height          =   195
         Left            =   240
         TabIndex        =   32
         Top             =   840
         Width           =   330
      End
      Begin VB.Label Label13 
         AutoSize        =   -1  'True
         Caption         =   "Mushrooms"
         Height          =   195
         Left            =   240
         TabIndex        =   31
         Top             =   1080
         Width           =   810
      End
      Begin VB.Label lblTanookiSuits 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   30
         Top             =   2280
         Width           =   90
      End
      Begin VB.Label lblYoshis 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   29
         Top             =   2520
         Width           =   90
      End
      Begin VB.Label lblKuribosShoes 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   1560
         TabIndex        =   28
         Top             =   2760
         Width           =   90
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Player Sprites"
      Height          =   615
      Left            =   120
      TabIndex        =   25
      Top             =   7560
      Width           =   1455
      Begin VB.CommandButton plrSprites 
         Caption         =   "Show"
         Height          =   255
         Left            =   120
         TabIndex        =   26
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Block Swap"
      Height          =   1575
      Left            =   3240
      TabIndex        =   19
      Top             =   120
      Width           =   1455
      Begin VB.CommandButton cmdSwap 
         Caption         =   "Swap"
         Height          =   375
         Left            =   120
         TabIndex        =   24
         Top             =   1080
         Width           =   1215
      End
      Begin VB.TextBox txtIn 
         Height          =   300
         Left            =   480
         TabIndex        =   23
         Top             =   720
         Width           =   855
      End
      Begin VB.TextBox txtOut 
         Height          =   300
         Left            =   480
         TabIndex        =   22
         Top             =   360
         Width           =   855
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "In"
         Height          =   195
         Left            =   240
         TabIndex        =   21
         Top             =   720
         Width           =   135
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Out"
         Height          =   195
         Left            =   120
         TabIndex        =   20
         Top             =   360
         Width           =   255
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Misc"
      Height          =   735
      Left            =   1680
      TabIndex        =   16
      Top             =   1680
      Width           =   1455
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "FPS"
         Height          =   195
         Left            =   120
         TabIndex        =   18
         Top             =   240
         Width           =   300
      End
      Begin VB.Label lblFPS 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   480
         TabIndex        =   17
         Top             =   240
         Width           =   90
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Cursor"
      Height          =   735
      Left            =   120
      TabIndex        =   11
      Top             =   1680
      Width           =   1455
      Begin VB.Label lblCurY 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   360
         TabIndex        =   15
         Top             =   480
         Width           =   90
      End
      Begin VB.Label lblCurX 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   360
         TabIndex        =   14
         Top             =   240
         Width           =   90
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Y"
         Height          =   195
         Left            =   120
         TabIndex        =   13
         Top             =   480
         Width           =   105
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "X"
         Height          =   195
         Left            =   120
         TabIndex        =   12
         Top             =   240
         Width           =   105
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Blocks Sorted"
      Height          =   615
      Left            =   3240
      TabIndex        =   9
      Top             =   1800
      Width           =   1455
      Begin VB.CommandButton cmdSortBlocks 
         Caption         =   "No"
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Objects"
      Height          =   1455
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3015
      Begin VB.Label lblWarps 
         AutoSize        =   -1  'True
         Caption         =   "0 of 0"
         Height          =   195
         Left            =   1200
         TabIndex        =   8
         Top             =   1080
         Width           =   405
      End
      Begin VB.Label lblBackgrounds 
         AutoSize        =   -1  'True
         Caption         =   "0 of 0"
         Height          =   195
         Left            =   1200
         TabIndex        =   7
         Top             =   840
         Width           =   405
      End
      Begin VB.Label lblNPCs 
         AutoSize        =   -1  'True
         Caption         =   "0 of 0"
         Height          =   195
         Left            =   1200
         TabIndex        =   6
         Top             =   600
         Width           =   405
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Warps"
         Height          =   195
         Left            =   120
         TabIndex        =   5
         Top             =   1080
         Width           =   465
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Backgrounds"
         Height          =   195
         Left            =   120
         TabIndex        =   4
         Top             =   840
         Width           =   945
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "NPCs"
         Height          =   195
         Left            =   120
         TabIndex        =   3
         Top             =   600
         Width           =   405
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Blocks"
         Height          =   195
         Left            =   120
         TabIndex        =   2
         Top             =   360
         Width           =   480
      End
      Begin VB.Label lblBlocks 
         AutoSize        =   -1  'True
         Caption         =   "0 of 0"
         Height          =   195
         Left            =   1200
         TabIndex        =   1
         Top             =   360
         Width           =   405
      End
   End
End
Attribute VB_Name = "frmLevelDebugger"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdSortBlocks_Click()
    Dim A As Integer
    Dim B As Integer
    qSortBlocksX 1, numBlock
    B = 1
    For A = 2 To numBlock
        If Block(A).Location.X > Block(B).Location.X Then
            qSortBlocksY B, A - 1
            B = A
        End If
    Next A
    qSortBlocksY B, A - 1
    FindBlocks
    FindSBlocks
    BlocksSorted = True
End Sub

Private Sub cmdSwap_Click()
    Dim bIn As Integer
    Dim bOut As Integer
    Dim A As Integer
    If txtIn.Text = Val(txtIn.Text) And txtOut.Text = Val(txtOut.Text) Then
        If txtIn.Text <> "" And txtOut.Text <> "" Then
            bIn = Val(txtIn.Text)
            bOut = Val(txtOut.Text)
            For A = 1 To numBlock
                If Block(A).Type = bOut Then Block(A).Type = bIn
            Next A
        End If
    End If
End Sub

Private Sub Form_Load()
    Debugger = True
    Me.Top = 0
    Me.Left = frmLevelWindow.Width
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Debugger = False
End Sub

Public Sub UpdateDisplay()
    Dim iCoins As Integer
    Dim iStars As Integer
    Dim iExits As Integer
    Dim iMushrooms As Integer
    Dim iFireFlowers As Integer
    Dim iLeaves As Integer
    Dim iHammerSuits As Integer
    Dim iTanookiSuits As Integer
    Dim iYoshis As Integer
    Dim iKuribosShoes As Integer
    Dim i1Ups As Integer
    Dim iIceFlowers As Integer
    Dim iDragonCoins As Integer
    Dim realType As Integer

    lblBlocks.Caption = numBlock & " of " & maxBlocks
    lblNPCs.Caption = numNPCs & " of " & maxNPCs
    lblBackgrounds.Caption = numBackground & " of " & maxBackgrounds
    If numWarps > 0 Then
        If Warp(numWarps).PlacedEnt = True And Warp(numWarps).PlacedExit = True Then
            lblWarps.Caption = numWarps & " of " & maxWarps
        Else
            lblWarps.Caption = numWarps - 1 & " of " & maxWarps
        End If
    Else
        lblWarps.Caption = numWarps & " of " & maxWarps
    End If
    If BlocksSorted = True Then
        If Not cmdSortBlocks.Caption = "Yes" Then cmdSortBlocks.Caption = "Yes"
        If Not cmdSortBlocks.Enabled = False Then cmdSortBlocks.Enabled = False
    Else
        If Not cmdSortBlocks.Caption = "No" Then cmdSortBlocks.Caption = "No"
        If Not cmdSortBlocks.Enabled = True Then cmdSortBlocks.Enabled = True
    End If
    If HasCursor = True Then
        lblCurX = Int(EditorCursor.Location.X)
        lblCurY = Int(EditorCursor.Location.Y)
    Else
        lblCurX = "Offscreen"
        lblCurY = "Offscreen"
    End If
'Level Info
    For A = 1 To numNPCs
        With NPC(A)
            If .Inert = False Then
                If .Type = 91 Or .Type = 96 Or .Type = 283 Then
                    realType = .Special
                Else
                    realType = .Type
                End If
                If NPCIsACoin(realType) Then
                    If realType = 252 Or realType = 258 Then
                        iCoins = iCoins + 5
                    ElseIf realType = 253 Then
                        iCoins = iCoins + 20
                    Else
                        iCoins = iCoins + 1
                    End If
                ElseIf realType = 97 Or realType = 196 Then 'Stars
                    iStars = iStars + 1
                ElseIf NPCIsAnExit(realType) Then
                    iExits = iExits + 1
                ElseIf realType = 9 Or realType = 184 Or realType = 185 Or realType = 249 Or realType = 250 Then 'mushrooms
                    iMushrooms = iMushrooms + 1
                ElseIf realType = 14 Or realType = 182 Or realType = 183 Then 'Fire flowers
                    iFireFlowers = iFireFlowers + 1
                ElseIf realType = 34 Then 'leaves
                    iLeaves = iLeaves + 1
                ElseIf realType = 169 Then ' Tanooki suit
                    iTanookiSuits = iTanookiSuits + 1
                ElseIf realType = 170 Then 'Hammer suit
                    iHammerSuits = iHammerSuits + 1
                ElseIf NPCIsYoshi(realType) Then
                    iYoshis = iYoshis + 1
                ElseIf NPCIsBoot(realType) Then
                    iKuribosShoes = iKuribosShoes + 1
                ElseIf realType = 90 Or realType = 186 Or realType = 187 Then
                    i1Ups = i1Ups + 1
                ElseIf realType = 188 Then
                    i1Ups = i1Ups + 3
                ElseIf realType = 264 Or realType = 277 Then
                    iIceFlowers = iIceFlowers + 1
                End If
                If realType = 274 Then
                    iDragonCoins = iDragonCoins + 1
                End If
            End If
        End With
    Next A
    For A = 1 To numBlock
        With Block(A)
            If .Special > 1000 Then
                realType = .Special - 1000
            ElseIf .Special > 0 And .Special < 100 Then
                iCoins = iCoins + .Special
                realType = -1
            Else
                realType = -1
            End If
            If realType > 0 Then
                If NPCIsACoin(realType) Then
                    iCoins = iCoins + 1
                ElseIf realType = 97 Or realType = 196 Then 'Stars
                    iStars = iStars + 1
                ElseIf NPCIsAnExit(realType) Then
                    iExits = iExits + 1
                ElseIf realType = 9 Or realType = 184 Or realType = 185 Or realType = 249 Or realType = 250 Then 'mushrooms
                    iMushrooms = iMushrooms + 1
                ElseIf realType = 14 Or realType = 182 Or realType = 183 Then 'Fire flowers
                    iFireFlowers = iFireFlowers + 1
                ElseIf realType = 34 Then 'leaves
                    iLeaves = iLeaves + 1
                ElseIf realType = 169 Then ' Tanooki suit
                    iTanookiSuits = iTanookiSuits + 1
                ElseIf realType = 170 Then 'Hammer suit
                    iHammerSuits = iHammerSuits + 1
                ElseIf NPCIsYoshi(realType) Then
                    iYoshis = iYoshis + 1
                ElseIf NPCIsBoot(realType) Then
                    iKuribosShoes = iKuribosShoes + 1
                ElseIf realType = 90 Or realType = 186 Or realType = 187 Then
                    i1Ups = i1Ups + 1
                ElseIf realType = 188 Then
                    i1Ups = i1Ups + 3
                ElseIf realType = 264 Or realType = 277 Then
                    iIceFlowers = iIceFlowers + 1
                End If
            End If
        End With
    Next A
    lblCoins.Caption = iCoins
    lblStars.Caption = iStars
    lblExits.Caption = iExits
    lblMushrooms.Caption = iMushrooms
    lblFireFlowers.Caption = iFireFlowers
    lblLeaves.Caption = iLeaves
    lblTanookiSuits.Caption = iTanookiSuits
    lblHammerSuits.Caption = iHammerSuits
    lblYoshis.Caption = iYoshis
    lblKuribosShoes.Caption = iKuribosShoes
    lbl1Ups.Caption = i1Ups
    lblIceFlowers.Caption = iIceFlowers
    lblDragonCoins.Caption = iDragonCoins
End Sub

Private Sub plrSprites_Click()
    On Error Resume Next
    Dim Y As Integer
    Dim A As Integer
    Dim X As Integer
    frmSprites.Show
    frmSprites.pic.Cls
    For X = 0 To 9
        For Y = 0 To 9
            A = Y + (X * 10) + 51
            A = A + 500
            BitBlt frmSprites.pic.hdc, X * 100, Y * 100, 100, 100, GFXLuigi(A), 0, 0, vbSrcCopy
        Next Y
    Next X
End Sub
