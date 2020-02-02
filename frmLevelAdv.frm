VERSION 5.00
Begin VB.Form frmLevelAdv 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Advanced Level Settings"
   ClientHeight    =   2070
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4485
   Icon            =   "frmLevelAdv.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2070
   ScaleWidth      =   4485
   Begin VB.Frame Frame2 
      Caption         =   "Clone Section"
      Height          =   1095
      Left            =   120
      TabIndex        =   2
      Top             =   840
      Width           =   4215
      Begin VB.CommandButton cmdClone 
         Caption         =   "Clone"
         Height          =   375
         Left            =   2640
         TabIndex        =   7
         Top             =   240
         Width           =   735
      End
      Begin VB.ComboBox CloneT 
         Height          =   315
         ItemData        =   "frmLevelAdv.frx":628A
         Left            =   840
         List            =   "frmLevelAdv.frx":628C
         TabIndex        =   4
         Top             =   600
         Width           =   1695
      End
      Begin VB.ComboBox CloneS 
         Height          =   315
         Left            =   840
         TabIndex        =   3
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Target:"
         Height          =   195
         Left            =   240
         TabIndex        =   6
         Top             =   600
         Width           =   510
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Source:"
         Height          =   195
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   555
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Level Name"
      Height          =   615
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4215
      Begin VB.TextBox txtLevelName 
         Height          =   285
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   3975
      End
   End
End
Attribute VB_Name = "frmLevelAdv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Sub RefreshFields()
    txtLevelName.Text = LevelName
End Sub

Private Sub cmdClone_Click()
    CloneSection CloneS.ListIndex, CloneT.ListIndex
End Sub

Private Sub Form_Load()
    Dim A As Integer
    CloneS.Clear
    CloneT.Clear
    For A = 1 To 21
        CloneS.AddItem "Section " & A
        CloneT.AddItem "Section " & A
    Next A
End Sub

Private Sub txtLevelName_Change()
    LevelName = txtLevelName.Text
End Sub

Public Sub CloneSection(SectionS As Integer, SectionT As Integer)
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    frmLevelSettings.optSection(SectionT).Value = True
    frmLevelSettings.optBackground(Background2(SectionS)).Value = True
    frmLevelSettings.optMusic(bgMusic(SectionS)).Value = True
    If UnderWater(SectionS) = True Then
        frmLevelSettings.cmdWater.Caption = "On"
    Else
        frmLevelSettings.cmdWater.Caption = "Off"
    End If
    If OffScreenExit(SectionS) = True Then
        frmLevelSettings.cmdExit.Caption = "On"
    Else
        frmLevelSettings.cmdExit.Caption = "Off"
    End If
    If LevelWrap(SectionS) = True Then
        frmLevelSettings.cmdWrap.Caption = "On"
    Else
        frmLevelSettings.cmdWrap.Caption = "Off"
    End If
    If NoTurnBack(SectionS) = True Then
        frmLevelSettings.cmdNoTurnBack.Caption = "On"
    Else
        frmLevelSettings.cmdNoTurnBack.Caption = "Off"
    End If
    UnderWater(SectionT) = UnderWater(SectionS)
    NoTurnBack(SectionT) = NoTurnBack(SectionS)
    LevelWrap(SectionT) = LevelWrap(SectionS)
    OffScreenExit(SectionT) = OffScreenExit(SectionS)
    level(SectionT).Width = level(SectionS).Width - level(SectionS).X + level(SectionT).X
    level(SectionT).Height = level(SectionS).Height - level(SectionS).Y + level(SectionT).Y
    For A = 1 To numBlock
        If CloneLoc(Block(A).Location, level(SectionS)) = True Then
            numBlock = numBlock + 1
            Block(numBlock) = Block(A)
            Block(numBlock).Location.X = Block(A).Location.X - level(SectionS).X + level(SectionT).X
            Block(numBlock).Location.Y = Block(A).Location.Y - level(SectionS).Y + level(SectionT).Y
        End If
    Next A
    For A = 1 To numNPCs
        If CloneLoc(NPC(A).Location, level(SectionS)) = True Then
            numNPCs = numNPCs + 1
            NPC(numNPCs) = NPC(A)
            NPC(numNPCs).Location.X = NPC(A).Location.X - level(SectionS).X + level(SectionT).X
            NPC(numNPCs).Location.Y = NPC(A).Location.Y - level(SectionS).Y + level(SectionT).Y
            NPC(numNPCs).DefaultLocation = NPC(A).Location
        End If
    Next A
    For A = 1 To numBackground
        If CloneLoc(Background(A).Location, level(SectionS)) = True Then
            numBackground = numBackground + 1
            Background(numBackground) = Background(A)
            Background(numBackground).Location.X = Background(A).Location.X - level(SectionS).X + level(SectionT).X
            Background(numBackground).Location.Y = Background(A).Location.Y - level(SectionS).Y + level(SectionT).Y
        End If
    Next A
    For A = 1 To numWater
        If CloneLoc(Water(A).Location, level(SectionS)) = True Then
            numWater = numWater + 1
            Water(numWater) = Water(A)
            Water(numWater).Location.X = Water(A).Location.X - level(SectionS).X + level(SectionT).X
            Water(numWater).Location.Y = Water(A).Location.Y - level(SectionS).Y + level(SectionT).Y
        End If
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
End Sub

Private Function CloneLoc(Loc1 As Location, Loc2 As Location) As Boolean
    Dim Dist As Integer
    Dist = 128
    If Loc1.X + Loc1.Width + Dist >= Loc2.X Then
        If Loc1.X <= Loc2.Width + Dist Then
            If Loc1.Y + Loc1.Height + Dist >= Loc2.Y Then
                If Loc1.Y <= Loc2.Height + Dist Then
                    CloneLoc = True
                End If
            End If
        End If
    End If
End Function
