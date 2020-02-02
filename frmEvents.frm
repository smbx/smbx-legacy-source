VERSION 5.00
Begin VB.Form frmEvents 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Events"
   ClientHeight    =   8280
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   9150
   Icon            =   "frmEvents.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8280
   ScaleWidth      =   9150
   Begin VB.Frame Frame19 
      Caption         =   "Saved Events"
      Height          =   1815
      Left            =   6840
      TabIndex        =   72
      Top             =   5520
      Width           =   2175
      Begin VB.Frame Frame21 
         Caption         =   "Remove"
         Height          =   735
         Left            =   120
         TabIndex        =   75
         Top             =   960
         Width           =   1935
         Begin VB.TextBox delSavedEvent 
            Height          =   375
            Left            =   120
            TabIndex        =   76
            Top             =   240
            Width           =   1695
         End
      End
      Begin VB.Frame Frame20 
         Caption         =   "Add"
         Height          =   735
         Left            =   120
         TabIndex        =   73
         Top             =   240
         Width           =   1935
         Begin VB.TextBox addSavedEvent 
            Height          =   375
            Left            =   120
            TabIndex        =   74
            Top             =   240
            Width           =   1695
         End
      End
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   13560
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   71
      Top             =   3720
      Width           =   375
   End
   Begin VB.Frame Frame17 
      Caption         =   "Autoscroll"
      Height          =   2895
      Left            =   6840
      TabIndex        =   63
      Top             =   2520
      Width           =   2175
      Begin VB.Frame Frame18 
         Caption         =   "Section"
         Height          =   855
         Left            =   120
         TabIndex        =   68
         Top             =   240
         Width           =   1935
         Begin VB.HScrollBar AutoSection 
            Height          =   255
            Left            =   120
            Max             =   20
            TabIndex        =   69
            Top             =   240
            Width           =   1695
         End
         Begin VB.Label lblAuto 
            AutoSize        =   -1  'True
            Caption         =   "Section: 1"
            Height          =   195
            Left            =   120
            TabIndex        =   70
            Top             =   600
            Width           =   720
         End
      End
      Begin VB.Frame Frame16 
         Caption         =   "Vertical Speed"
         Height          =   735
         Left            =   120
         TabIndex        =   66
         Top             =   2040
         Width           =   1935
         Begin VB.TextBox scrY 
            Height          =   375
            Left            =   120
            TabIndex        =   67
            Top             =   240
            Width           =   1695
         End
      End
      Begin VB.Frame Frame15 
         Caption         =   "Horizontal Speed"
         Height          =   735
         Left            =   120
         TabIndex        =   64
         Top             =   1200
         Width           =   1935
         Begin VB.TextBox scrX 
            Height          =   375
            Left            =   120
            TabIndex        =   65
            Top             =   240
            Width           =   1695
         End
      End
   End
   Begin VB.CheckBox chkStart 
      Caption         =   "Auto Start"
      Height          =   255
      Left            =   6840
      TabIndex        =   60
      Top             =   7440
      Width           =   1095
   End
   Begin VB.Frame Frame11 
      Caption         =   "Layer Movement"
      Height          =   2295
      Left            =   6840
      TabIndex        =   55
      Top             =   120
      Width           =   2175
      Begin VB.ComboBox cmbLayerMove 
         Height          =   315
         ItemData        =   "frmEvents.frx":628A
         Left            =   120
         List            =   "frmEvents.frx":6363
         TabIndex        =   61
         Top             =   240
         Width           =   1935
      End
      Begin VB.Frame Frame14 
         Caption         =   "Horizontal Speed"
         Height          =   735
         Left            =   120
         TabIndex        =   57
         Top             =   600
         Width           =   1935
         Begin VB.TextBox txtX 
            Height          =   375
            Left            =   120
            TabIndex        =   58
            Top             =   240
            Width           =   1695
         End
      End
      Begin VB.Frame Frame13 
         Caption         =   "Vertical Speed"
         Height          =   735
         Left            =   120
         TabIndex        =   56
         Top             =   1440
         Width           =   1935
         Begin VB.TextBox txtY 
            Height          =   375
            Left            =   120
            TabIndex        =   59
            Top             =   240
            Width           =   1695
         End
      End
   End
   Begin VB.Frame Frame12 
      Caption         =   "Player Controls"
      Height          =   855
      Left            =   120
      TabIndex        =   43
      Top             =   7320
      Width           =   4455
      Begin VB.CheckBox cDrop 
         Caption         =   "Drop"
         Height          =   255
         Left            =   3600
         TabIndex        =   54
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cStart 
         Caption         =   "Start"
         Height          =   255
         Left            =   3600
         TabIndex        =   53
         Top             =   480
         Width           =   735
      End
      Begin VB.CheckBox cAltJump 
         Caption         =   "Alt Jump"
         Height          =   255
         Left            =   2640
         TabIndex        =   51
         Top             =   480
         Width           =   975
      End
      Begin VB.CheckBox cAltRun 
         Caption         =   "Alt Run"
         Height          =   255
         Left            =   2640
         TabIndex        =   50
         Top             =   240
         Width           =   975
      End
      Begin VB.CheckBox cJump 
         Caption         =   "Jump"
         Height          =   255
         Left            =   1800
         TabIndex        =   49
         Top             =   480
         Width           =   855
      End
      Begin VB.CheckBox cRun 
         Caption         =   "Run"
         Height          =   255
         Left            =   1800
         TabIndex        =   48
         Top             =   240
         Width           =   975
      End
      Begin VB.CheckBox cRight 
         Caption         =   "Right"
         Height          =   255
         Left            =   960
         TabIndex        =   47
         Top             =   480
         Width           =   735
      End
      Begin VB.CheckBox cLeft 
         Caption         =   "Left"
         Height          =   255
         Left            =   960
         TabIndex        =   46
         Top             =   240
         Width           =   975
      End
      Begin VB.CheckBox cDown 
         Caption         =   "Down"
         Height          =   255
         Left            =   120
         TabIndex        =   45
         Top             =   480
         Width           =   975
      End
      Begin VB.CheckBox cUp 
         Caption         =   "Up"
         Height          =   255
         Left            =   120
         TabIndex        =   44
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame Frame9 
      Caption         =   "Trigger Event"
      Height          =   1695
      Left            =   4680
      TabIndex        =   38
      Top             =   6480
      Width           =   2055
      Begin VB.ComboBox TriggerEvent 
         Height          =   315
         ItemData        =   "frmEvents.frx":663C
         Left            =   120
         List            =   "frmEvents.frx":663E
         TabIndex        =   42
         Top             =   240
         Width           =   1815
      End
      Begin VB.Frame Frame10 
         Caption         =   "Delay"
         Height          =   975
         Left            =   120
         TabIndex        =   39
         Top             =   600
         Width           =   1815
         Begin VB.HScrollBar scrDelay 
            Height          =   255
            Left            =   120
            Max             =   6000
            TabIndex        =   40
            Top             =   240
            Width           =   1335
         End
         Begin VB.Label lblDelay 
            AutoSize        =   -1  'True
            Caption         =   "Instant"
            Height          =   195
            Left            =   120
            TabIndex        =   41
            Top             =   600
            Width           =   1560
         End
      End
   End
   Begin VB.Frame Frame8 
      Caption         =   "End Game"
      Height          =   735
      Left            =   4680
      TabIndex        =   36
      Top             =   5760
      Width           =   2055
      Begin VB.ComboBox cmbEndGame 
         Height          =   315
         ItemData        =   "frmEvents.frx":6640
         Left            =   120
         List            =   "frmEvents.frx":664A
         TabIndex        =   37
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame7 
      Caption         =   "Play Sound"
      Height          =   735
      Left            =   4680
      TabIndex        =   30
      Top             =   5040
      Width           =   2055
      Begin VB.ComboBox cmbSound 
         Height          =   315
         ItemData        =   "frmEvents.frx":6663
         Left            =   120
         List            =   "frmEvents.frx":6772
         TabIndex        =   31
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Section Settings"
      Height          =   2055
      Left            =   120
      TabIndex        =   17
      Top             =   5160
      Width           =   4455
      Begin VB.Frame Frame6 
         Caption         =   "Background"
         Height          =   1695
         Left            =   3000
         TabIndex        =   20
         Top             =   240
         Width           =   1335
         Begin VB.OptionButton cmdBackground 
            Caption         =   "Use Current"
            Height          =   375
            Index           =   2
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   29
            Top             =   1200
            Width           =   1095
         End
         Begin VB.OptionButton cmdBackground 
            Caption         =   "Default"
            Height          =   375
            Index           =   1
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   28
            Top             =   720
            Width           =   1095
         End
         Begin VB.OptionButton cmdBackground 
            Caption         =   "Don't Change"
            Height          =   375
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   27
            Top             =   240
            Width           =   1095
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "Music"
         Height          =   1695
         Left            =   1560
         TabIndex        =   19
         Top             =   240
         Width           =   1335
         Begin VB.OptionButton cmdMusic 
            Caption         =   "Use Current"
            Height          =   375
            Index           =   2
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   26
            Top             =   1200
            Width           =   1095
         End
         Begin VB.OptionButton cmdMusic 
            Caption         =   "Default"
            Height          =   375
            Index           =   1
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   25
            Top             =   720
            Width           =   1095
         End
         Begin VB.OptionButton cmdMusic 
            Caption         =   "Don't Change"
            Height          =   375
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   24
            Top             =   240
            Width           =   1095
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Position"
         Height          =   1695
         Left            =   120
         TabIndex        =   18
         Top             =   240
         Width           =   1335
         Begin VB.OptionButton cmdPosition 
            Caption         =   "Use Current"
            Height          =   375
            Index           =   2
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   23
            Top             =   1200
            Width           =   1095
         End
         Begin VB.OptionButton cmdPosition 
            Caption         =   "Default"
            Height          =   375
            Index           =   1
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   22
            Top             =   720
            Width           =   1095
         End
         Begin VB.OptionButton cmdPosition 
            Caption         =   "Don't Change"
            Height          =   375
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   21
            Top             =   240
            Width           =   1095
         End
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Message"
      Height          =   735
      Index           =   7
      Left            =   120
      TabIndex        =   15
      Top             =   4320
      Width           =   6615
      Begin VB.TextBox EventText 
         Height          =   375
         Left            =   120
         TabIndex        =   16
         Top             =   240
         Width           =   6375
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Events"
      Height          =   4095
      Left            =   120
      TabIndex        =   10
      Top             =   120
      Width           =   2295
      Begin VB.CommandButton cmdDupe 
         Caption         =   "Dupe"
         Height          =   375
         Left            =   840
         TabIndex        =   62
         Top             =   3600
         Width           =   615
      End
      Begin VB.CommandButton cmdDelete 
         Caption         =   "Delete"
         Height          =   375
         Left            =   1560
         TabIndex        =   14
         Top             =   3600
         Width           =   615
      End
      Begin VB.CommandButton cmdAdd 
         Caption         =   "Add"
         Height          =   375
         Left            =   120
         TabIndex        =   13
         Top             =   3600
         Width           =   615
      End
      Begin VB.ListBox lstEvent 
         Height          =   2790
         ItemData        =   "frmEvents.frx":6B18
         Left            =   120
         List            =   "frmEvents.frx":6B25
         TabIndex        =   12
         Top             =   720
         Width           =   2055
      End
      Begin VB.TextBox txtEvent 
         Enabled         =   0   'False
         Height          =   375
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   2055
      End
   End
   Begin VB.Frame LayerFrame 
      Caption         =   "Layers"
      Enabled         =   0   'False
      Height          =   4095
      Left            =   2520
      TabIndex        =   0
      Top             =   120
      Width           =   4215
      Begin VB.CheckBox chkSmoke 
         Caption         =   "No Smoke"
         Height          =   195
         Left            =   120
         TabIndex        =   52
         Top             =   240
         Width           =   1095
      End
      Begin VB.Frame Frame 
         Caption         =   "Toggle Layers"
         Height          =   1815
         Index           =   1
         Left            =   120
         TabIndex        =   32
         Top             =   2160
         Width           =   1935
         Begin VB.CommandButton cmdToggleAdd 
            Caption         =   "Add"
            Height          =   375
            Left            =   120
            TabIndex        =   35
            Top             =   1320
            Width           =   735
         End
         Begin VB.CommandButton cmdToggleRemove 
            Caption         =   "Remove"
            Height          =   375
            Left            =   960
            TabIndex        =   34
            Top             =   1320
            Width           =   855
         End
         Begin VB.ListBox lstToggleLayer 
            Height          =   1035
            ItemData        =   "frmEvents.frx":6B5A
            Left            =   120
            List            =   "frmEvents.frx":6B5C
            TabIndex        =   33
            Top             =   240
            Width           =   1695
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Show Layers"
         Height          =   1815
         Left            =   2160
         TabIndex        =   6
         Top             =   2160
         Width           =   1935
         Begin VB.ListBox lstShowLayer 
            Height          =   1035
            ItemData        =   "frmEvents.frx":6B5E
            Left            =   120
            List            =   "frmEvents.frx":6B60
            TabIndex        =   9
            Top             =   240
            Width           =   1695
         End
         Begin VB.CommandButton cmdShowRemove 
            Caption         =   "Remove"
            Height          =   375
            Left            =   960
            TabIndex        =   8
            Top             =   1320
            Width           =   855
         End
         Begin VB.CommandButton cmdShowAdd 
            Caption         =   "Add"
            Height          =   375
            Left            =   120
            TabIndex        =   7
            Top             =   1320
            Width           =   735
         End
      End
      Begin VB.Frame Frame 
         Caption         =   "Hide Layers"
         Height          =   1815
         Index           =   0
         Left            =   2160
         TabIndex        =   2
         Top             =   240
         Width           =   1935
         Begin VB.CommandButton cmdHideAdd 
            Caption         =   "Add"
            Height          =   375
            Left            =   120
            TabIndex        =   5
            Top             =   1320
            Width           =   735
         End
         Begin VB.CommandButton cmdHideRemove 
            Caption         =   "Remove"
            Height          =   375
            Left            =   960
            TabIndex        =   4
            Top             =   1320
            Width           =   855
         End
         Begin VB.ListBox lstHideLayer 
            Height          =   1035
            ItemData        =   "frmEvents.frx":6B62
            Left            =   120
            List            =   "frmEvents.frx":6B64
            TabIndex        =   3
            Top             =   240
            Width           =   1695
         End
      End
      Begin VB.ListBox lstLayers 
         Height          =   1620
         ItemData        =   "frmEvents.frx":6B66
         Left            =   120
         List            =   "frmEvents.frx":6B68
         TabIndex        =   1
         Top             =   480
         Width           =   1935
      End
   End
End
Attribute VB_Name = "frmEvents"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SelEvent As Integer
Dim DontRefresh As Boolean

Private Sub addSavedEvent_Change()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).addSavedEvent = addSavedEvent.Text
        End If
    Next A
End Sub

Private Sub AutoSection_Change()
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).AutoSection = AutoSection.Value
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
    lblAuto.Caption = "Section: " & AutoSection.Value + 1
End Sub

Private Sub cAltJump_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cAltJump.Value = 1 Then
                Events(A).Controls.AltJump = True
            Else
                Events(A).Controls.AltJump = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cAltRun_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cAltRun.Value = 1 Then
                Events(A).Controls.AltRun = True
            Else
                Events(A).Controls.AltRun = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cDown_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cDown.Value = 1 Then
                Events(A).Controls.Down = True
            Else
                Events(A).Controls.Down = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cDrop_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cDrop.Value = 1 Then
                Events(A).Controls.Drop = True
            Else
                Events(A).Controls.Drop = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub chkSmoke_Click()
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If chkSmoke.Value = 0 Then
                Events(A).LayerSmoke = False
            Else
                Events(A).LayerSmoke = True
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub chkStart_Click()
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If chkStart.Value = 0 Then
                Events(A).AutoStart = False
            Else
                Events(A).AutoStart = True
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cJump_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cJump.Value = 1 Then
                Events(A).Controls.Jump = True
            Else
                Events(A).Controls.Jump = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cLeft_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cLeft.Value = 1 Then
                Events(A).Controls.Left = True
            Else
                Events(A).Controls.Left = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cmbEndGame_Click()
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).EndGame = cmbEndGame.ListIndex
        End If
    Next A
    RefreshEvents
End Sub

Private Sub cmbLayerMove_Click()
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).MoveLayer = cmbLayerMove.Text
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cmbSound_Click()
    If DontRefresh = True Then Exit Sub
    If cmbSound.ListIndex > 0 Then
        SoundPause(cmbSound.ListIndex) = 0
        PlaySound cmbSound.ListIndex
    End If
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).Sound = cmbSound.ListIndex
        End If
    Next A
    RefreshEvents
End Sub

Private Sub cmdAdd_Click()
    On Error Resume Next
    Dim A As Integer
    Dim B As Integer
    Dim tempBool As Boolean
    Dim NewEvent As String
    NewEvent = "New Event"
    B = 1
    Do
        tempBool = False
        For A = 0 To lstEvent.ListCount - 1
            If LCase(NewEvent) = LCase(lstEvent.List(A)) Then
                tempBool = True
                Exit For
            End If
        Next A
        If tempBool = True Then
            B = B + 1
            NewEvent = "New Event " & B
        End If
    Loop While tempBool = True
    lstEvent.AddItem NewEvent
    For A = 0 To 100
        If Events(A).Name = "" Then
            Events(A).Name = NewEvent
            Exit For
        End If
    Next A
    lstEvent.ListIndex = lstEvent.ListCount - 1
    txtEvent.SelStart = 0
    txtEvent.SelLength = Len(txtEvent.Text)
    txtEvent.SetFocus
    RefreshEvents
    EventText.Text = ""
End Sub

Private Sub cmdBackground_Click(Index As Integer)
    On Error Resume Next
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If Index = 0 Then
                Events(A).Background(curSection) = -1
            ElseIf Index = 1 Then
                Events(A).Background(curSection) = -2
            Else
                Events(A).Background(curSection) = Background2(curSection)
            End If
        End If
    Next A
    RefreshEvents
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub cmdDelete_Click()
    Dim blankEvent As Events
    Dim EventName As String
    If MsgBox("Are you sure you want to delete this event?", vbYesNo, "Delete Event") = 6 Then
        EventName = lstEvent.List(lstEvent.ListIndex)
        For A = lstEvent.ListIndex To 99
            Events(A) = Events(A + 1)
        Next A
        Events(100) = blankEvent
        EventName = LCase(EventName)
        For A = 1 To numNPCs
            With NPC(A)
                If LCase(.TriggerActivate) = EventName Then .TriggerActivate = ""
                If LCase(.TriggerDeath) = EventName Then .TriggerDeath = ""
                If LCase(.TriggerLast) = EventName Then .TriggerLast = ""
                If LCase(.TriggerTalk) = EventName Then .TriggerTalk = ""
            End With
        Next A
        For A = 1 To numBlock
            With Block(A)
                If LCase(.TriggerDeath) = EventName Then .TriggerDeath = ""
                If LCase(.TriggerHit) = EventName Then .TriggerHit = ""
                If LCase(.TriggerLast) = EventName Then .TriggerLast = ""
            End With
        Next A
        If LCase(frmAdvanced.TriggerActivate.Text) = EventName Then frmAdvanced.TriggerActivate.Text = ""
        If LCase(frmAdvanced.TriggerTalk.Text) = EventName Then frmAdvanced.TriggerTalk.Text = ""
        If LCase(frmAdvanced.TriggerDeath.Text) = EventName Then frmAdvanced.TriggerDeath.Text = ""
        If LCase(frmAdvanced.TriggerLast.Text) = EventName Then frmAdvanced.TriggerLast.Text = ""
        If LCase(frmAdvancedBlock.TriggerHit.Text) = EventName Then frmAdvancedBlock.TriggerHit.Text = ""
        If LCase(frmAdvancedBlock.TriggerDeath.Text) = EventName Then frmAdvancedBlock.TriggerDeath.Text = ""
        If LCase(frmAdvancedBlock.TriggerLast.Text) = EventName Then frmAdvancedBlock.TriggerLast.Text = ""
        RefreshEvents
        lstEvent.ListIndex = lstEvent.ListCount - 1
        txtEvent.Text = lstEvent.List(lstEvent.ListCount - 1)
    End If
End Sub

Private Sub cmdDupe_Click()
    On Error Resume Next
    Dim A As Integer
    Dim B As Integer
    Dim dupeEvent As Integer
    Dim tempBool As Boolean
    Dim NewEvent As String
    Dim prevEvent As Integer
    NewEvent = Events(SelEvent).Name
    dupeEvent = SelEvent
    prevEvent = lstEvent.ListIndex
    B = 1
    
    Do
        tempBool = False
        For A = 0 To lstEvent.ListCount - 1
            If LCase(NewEvent) = LCase(lstEvent.List(A)) Then
                tempBool = True
                Exit For
            End If
        Next A
        If tempBool = True Then
            B = B + 1
            NewEvent = Events(dupeEvent).Name & " " & B
        End If
    Loop While tempBool = True
    
    lstEvent.AddItem NewEvent
    For A = 0 To 100
        If Events(A).Name = "" Then
            Events(A) = Events(dupeEvent)
            Events(A).Name = NewEvent
            EventText.Text = Events(A).Text
            Exit For
        End If
    Next A
    lstEvent.ListIndex = prevEvent
    txtEvent.SelStart = 0
    txtEvent.SelLength = Len(txtEvent.Text)
    txtEvent.SetFocus
    RefreshEvents
End Sub

Private Sub cmdHideAdd_Click()
    Dim A As Integer
    Dim B As Integer
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            For B = 0 To 20
                If Events(A).HideLayer(B) = "" Then
                    Events(A).HideLayer(B) = lstLayers.List(lstLayers.ListIndex)
                    Exit For
                ElseIf LCase(Events(A).HideLayer(B)) = LCase(lstLayers.List(lstLayers.ListIndex)) Then
                    Exit For
                End If
            Next B
            Exit For
        End If
    Next A
    RefreshEvents
End Sub

Private Sub cmdHideRemove_Click()
    Dim A As Integer
    Dim B As Integer
    If lstHideLayer.ListCount = 0 Then Exit Sub
    If lstHideLayer.ListIndex = -1 Then lstHideLayer.ListIndex = lstHideLayer.ListCount - 1
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            For B = lstHideLayer.ListIndex To 19
                Events(A).HideLayer(B) = Events(A).HideLayer(B + 1)
            Next B
            Exit For
        End If
    Next A
    RefreshEvents
End Sub

Private Sub cmdMusic_Click(Index As Integer)
    On Error Resume Next
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If Index = 0 Then
                Events(A).Music(curSection) = -1
            ElseIf Index = 1 Then
                Events(A).Music(curSection) = -2
            Else
                Events(A).Music(curSection) = bgMusic(curSection)
            End If
        End If
    Next A
    If Me.Visible = True Then FocusNinja.SetFocus
    RefreshEvents
End Sub

Private Sub cmdPosition_Click(Index As Integer)
    On Error Resume Next
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If Index = 0 Then
                Events(A).level(curSection).X = -1
            ElseIf Index = 1 Then
                Events(A).level(curSection).X = -2
            Else
                Events(A).level(curSection).X = level(curSection).X
                Events(A).level(curSection).Width = level(curSection).Width
                Events(A).level(curSection).Y = level(curSection).Y
                Events(A).level(curSection).Height = level(curSection).Height
            End If
        End If
    Next A
    If Me.Visible = True Then FocusNinja.SetFocus
    RefreshEvents
End Sub

Private Sub cmdShowAdd_Click()
    Dim A As Integer
    Dim B As Integer
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            For B = 0 To 20
                If Events(A).ShowLayer(B) = "" Then
                    Events(A).ShowLayer(B) = lstLayers.List(lstLayers.ListIndex)
                    Exit For
                ElseIf LCase(Events(A).ShowLayer(B)) = LCase(lstLayers.List(lstLayers.ListIndex)) Then
                    Exit For
                End If
            Next B
            Exit For
        End If
    Next A
    RefreshEvents
End Sub

Private Sub cmdShowRemove_Click()
    Dim A As Integer
    Dim B As Integer
    If lstShowLayer.ListCount = 0 Then Exit Sub
    If lstShowLayer.ListIndex = -1 Then lstShowLayer.ListIndex = lstShowLayer.ListCount - 1
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            For B = lstShowLayer.ListIndex To 19
                Events(A).ShowLayer(B) = Events(A).ShowLayer(B + 1)
            Next B
            Exit For
        End If
    Next A
    RefreshEvents
End Sub

Private Sub cmdToggleAdd_Click()
    Dim A As Integer
    Dim B As Integer
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            For B = 0 To 20
                If Events(A).ToggleLayer(B) = "" Then
                    Events(A).ToggleLayer(B) = lstLayers.List(lstLayers.ListIndex)
                    Exit For
                ElseIf LCase(Events(A).ToggleLayer(B)) = LCase(lstLayers.List(lstLayers.ListIndex)) Then
                    Exit For
                End If
            Next B
            Exit For
        End If
    Next A
    RefreshEvents
End Sub

Private Sub cmdToggleRemove_Click()
    Dim A As Integer
    Dim B As Integer
    If lstToggleLayer.ListCount = 0 Then Exit Sub
    If lstToggleLayer.ListIndex = -1 Then lstToggleLayer.ListIndex = lstToggleLayer.ListCount - 1
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            For B = lstToggleLayer.ListIndex To 19
                Events(A).ToggleLayer(B) = Events(A).ToggleLayer(B + 1)
            Next B
            Exit For
        End If
    Next A
    RefreshEvents
End Sub

Private Sub cRight_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cRight.Value = 1 Then
                Events(A).Controls.Right = True
            Else
                Events(A).Controls.Right = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cRun_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cRun.Value = 1 Then
                Events(A).Controls.Run = True
            Else
                Events(A).Controls.Run = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cStart_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cStart.Value = 1 Then
                Events(A).Controls.Start = True
            Else
                Events(A).Controls.Start = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub cUp_Click()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            If cUp.Value = 1 Then
                Events(A).Controls.Up = True
            Else
                Events(A).Controls.Up = False
            End If
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
        End If
    Next A
End Sub

Private Sub delSavedEvent_Change()
    Dim A As Integer
    If DontRefresh = True Then Exit Sub
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).delSavedEvent = delSavedEvent.Text
        End If
    Next A
End Sub

Private Sub EventText_Change()
    Dim A As Integer
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).Text = ""
            For B = 1 To Len(EventText.Text)
                If Mid(EventText.Text, B, 1) = Chr(34) Then
                    Events(A).Text = Events(A).Text & "'"
                Else
                    Events(A).Text = Events(A).Text & Mid(EventText.Text, B, 1)
                End If
            Next B
            If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
            Exit For
        End If
    Next A
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
End Sub

Private Sub lstEvent_Click()
    On Error Resume Next
    If DontRefresh = True Then Exit Sub
    SelEvent = lstEvent.ListIndex
    txtEvent.Text = lstEvent.List(lstEvent.ListIndex)
    RefreshEvents
    txtEvent.SetFocus
End Sub

Private Sub lstLayers_Click()
    cmdHideAdd.Enabled = True
    cmdShowAdd.Enabled = True
    cmdToggleAdd.Enabled = True
End Sub

Private Sub scrDelay_Change()
    Dim A As Integer
    If scrDelay.Value = 0 Then
        lblDelay.Caption = "Instant"
    ElseIf scrDelay.Value = 10 Then
        lblDelay.Caption = scrDelay.Value / 10 & " Second"
    Else
        lblDelay.Caption = scrDelay.Value / 10 & " Seconds"
    End If
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).TriggerDelay = scrDelay.Value
        End If
    Next A
    If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
End Sub

Private Sub scrX_Change()
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).AutoX = Val(scrX.Text)
        End If
    Next A
    If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
End Sub

Private Sub scrY_Change()
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).AutoY = Val(scrY.Text)
        End If
    Next A
    If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
End Sub

Private Sub TriggerEvent_Click()
    Dim A As Integer
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).TriggerEvent = TriggerEvent.Text
        End If
    Next A
    If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
End Sub

Private Sub txtEvent_KeyPress(KeyAscii As Integer)
    Dim A As Integer
    Dim oldName As String
    Dim newName As String
    If DontRefresh = True Then Exit Sub
    oldName = LCase(lstEvent.List(lstEvent.ListIndex))
    If KeyAscii = vbKeyReturn Then
        Do While Right(txtEvent.Text, 1) = " "
            txtEvent.Text = Left(txtEvent.Text, Len(txtEvent.Text) - 1)
        Loop
        If txtEvent.Text = "" Then
            txtEvent.Text = lstEvent.List(lstEvent.ListIndex)
            Exit Sub
        End If
        For A = 0 To lstEvent.ListCount - 1
            If LCase(txtEvent.Text) = LCase(lstEvent.List(A)) Then
                txtEvent.Text = lstEvent.List(lstEvent.ListIndex)
                Exit For
            End If
        Next A
        For A = 0 To 100
            If Events(A).Name = lstEvent.List(lstEvent.ListIndex) Then
                Events(A).Name = txtEvent.Text
                newName = Events(A).Name
                For B = 1 To numNPCs
                    With NPC(B)
                        If LCase(.TriggerActivate) = oldName Then .TriggerActivate = newName
                        If LCase(.TriggerDeath) = oldName Then .TriggerDeath = newName
                        If LCase(.TriggerLast) = oldName Then .TriggerLast = newName
                        If LCase(.TriggerTalk) = oldName Then .TriggerTalk = newName
                    End With
                Next B
                For B = 1 To numBlock
                    With Block(B)
                        If LCase(.TriggerDeath) = oldName Then .TriggerDeath = newName
                        If LCase(.TriggerHit) = oldName Then .TriggerHit = newName
                        If LCase(.TriggerLast) = oldName Then .TriggerLast = newName
                    End With
                Next B
                If LCase(frmAdvanced.TriggerActivate.Text) = oldName Then frmAdvanced.TriggerActivate.Text = newName
                If LCase(frmAdvanced.TriggerTalk.Text) = oldName Then frmAdvanced.TriggerTalk.Text = newName
                If LCase(frmAdvanced.TriggerDeath.Text) = oldName Then frmAdvanced.TriggerDeath.Text = newName
                If LCase(frmAdvanced.TriggerLast.Text) = oldName Then frmAdvanced.TriggerLast.Text = newName
                If LCase(frmAdvancedBlock.TriggerHit.Text) = oldName Then frmAdvancedBlock.TriggerHit.Text = newName
                If LCase(frmAdvancedBlock.TriggerDeath.Text) = oldName Then frmAdvancedBlock.TriggerDeath.Text = newName
                If LCase(frmAdvancedBlock.TriggerLast.Text) = oldName Then frmAdvancedBlock.TriggerLast.Text = newName
                Exit For
            End If
        Next A
        RefreshEvents
    End If
End Sub

Public Sub RefreshEvents()
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    If DontRefresh = True Then Exit Sub
    lstLayers.Clear
    cmbLayerMove.Clear
    lstHideLayer.Clear
    lstShowLayer.Clear
    lstToggleLayer.Clear
    lstEvent.Clear
    For A = 0 To 100
        If Events(A).Name <> "" Then
            lstEvent.List(A) = Events(A).Name
        Else
            Exit For
        End If
    Next A
    DontRefresh = True
    If SelEvent >= lstEvent.ListCount Then
        SelEvent = lstEvent.ListCount - 1
    End If
    lstEvent.ListIndex = SelEvent
    For A = 0 To frmLayers.lstLayer.ListCount - 1
        lstLayers.List(A) = frmLayers.lstLayer.List(A)
        cmbLayerMove.List(A) = frmLayers.lstLayer.List(A)
    Next A
    For A = 0 To 100
        If Events(A).Name = lstEvent.List(lstEvent.ListIndex) Then
            With Events(A)
                EventText.Text = .Text
                cmbSound.Text = cmbSound.List(.Sound)
                cmbSound.ListIndex = .Sound
                cmbEndGame.ListIndex = .EndGame
                cmbLayerMove.Text = .MoveLayer
                txtX.Text = .SpeedX
                txtY.Text = .SpeedY
                scrX.Text = .AutoX
                scrY.Text = .AutoY
                addSavedEvent.Text = .addSavedEvent
                delSavedEvent.Text = .delSavedEvent
                AutoSection.Value = .AutoSection
                lblAuto.Caption = "Section: " & AutoSection.Value + 1
                For B = 1 To Len(txtX.Text)
                    If Mid(txtX.Text, B, 1) = "," Then txtX.Text = Left(txtX.Text, B - 1) & "." & Right(txtX.Text, Len(txtX.Text) - B)
                Next B
                For B = 1 To Len(txtY.Text)
                    If Mid(txtY.Text, B, 1) = "," Then txtY.Text = Left(txtY.Text, B - 1) & "." & Right(txtY.Text, Len(txtY.Text) - B)
                Next B
                For B = 1 To Len(scrX.Text)
                    If Mid(scrX.Text, B, 1) = "," Then scrX.Text = Left(scrX.Text, B - 1) & "." & Right(scrX.Text, Len(scrX.Text) - B)
                Next B
                For B = 1 To Len(scrY.Text)
                    If Mid(scrY.Text, B, 1) = "," Then scrY.Text = Left(scrY.Text, B - 1) & "." & Right(scrY.Text, Len(scrY.Text) - B)
                Next B
                If .AutoStart = True Then
                    chkStart.Value = 1
                Else
                    chkStart.Value = 0
                End If
                For B = 0 To 20
                    If .HideLayer(B) <> "" Then
                        lstHideLayer.List(B) = .HideLayer(B)
                        For C = 0 To lstLayers.ListCount - 1
                            If LCase(.HideLayer(B)) = LCase(lstLayers.List(C)) Then lstLayers.RemoveItem C
                        Next C
                    End If
                    If .ShowLayer(B) <> "" Then
                        lstShowLayer.List(B) = .ShowLayer(B)
                        For C = 0 To lstLayers.ListCount - 1
                            If LCase(.ShowLayer(B)) = LCase(lstLayers.List(C)) Then lstLayers.RemoveItem C
                        Next C
                    End If
                    If .ToggleLayer(B) <> "" Then
                        lstToggleLayer.List(B) = .ToggleLayer(B)
                        For C = 0 To lstLayers.ListCount - 1
                            If LCase(.ToggleLayer(B)) = LCase(lstLayers.List(C)) Then lstLayers.RemoveItem C
                        Next C
                    End If
                Next B
                If .Music(curSection) >= 0 Then
                    cmdMusic(2).Value = True
                    cmdMusic(2).Caption = frmLevelSettings.optMusic(Events(A).Music(curSection)).Caption
                Else
                    cmdMusic(2).Caption = "Use Current"
                    If .Music(curSection) = -1 Then
                        cmdMusic(0).Value = True
                    Else
                        cmdMusic(1).Value = True
                    End If
                End If
                If .Background(curSection) >= 0 Then
                    cmdBackground(2).Value = True
                    cmdBackground(2).Caption = frmLevelSettings.optBackground(Events(A).Background(curSection)).Caption
                Else
                    cmdBackground(2).Caption = "Use Current"
                    If .Background(curSection) = -1 Then
                        cmdBackground(0).Value = True
                    Else
                        cmdBackground(1).Value = True
                    End If
                End If
                If .level(curSection).X <> -1 And .level(curSection).X <> -2 Then
                    cmdPosition(2).Value = True
                    cmdPosition(2).Caption = "Set"
                Else
                    cmdPosition(2).Caption = "Use Current"
                    If .level(curSection).X = -1 Then
                        cmdPosition(0).Value = True
                    Else
                        cmdPosition(1).Value = True
                    End If
                End If
            End With
            Exit For
        End If
    Next A
    A = A - 1
    If lstEvent.ListCount > 0 Then
        LayerFrame.Enabled = True
        txtEvent.Enabled = True
        If Not (txtEvent.Text = "P Switch - Start" Or txtEvent.Text = "P Switch - End" Or txtEvent.Text = "Level - Start") Then
            If lstEvent.ListIndex >= 0 Then cmdDelete.Enabled = True
        Else
            cmdDelete.Enabled = False
            txtEvent.Enabled = False
        End If
    Else
        LayerFrame.Enabled = False
        txtEvent.Enabled = False
        cmdDelete.Enabled = False
    End If
    If lstHideLayer.ListCount = 0 Then
        cmdHideRemove.Enabled = False
    Else
        cmdHideRemove.Enabled = True
    End If
    If lstShowLayer.ListCount = 0 Then
        cmdShowRemove.Enabled = False
    Else
        cmdShowRemove.Enabled = True
    End If
    If lstToggleLayer.ListCount = 0 Then
        cmdToggleRemove.Enabled = False
    Else
        cmdToggleRemove.Enabled = True
    End If
    If lstLayers.ListCount = 0 Then
        cmdHideAdd.Enabled = False
        cmdShowAdd.Enabled = False
        cmdToggleAdd.Enabled = False
    Else
        cmdHideAdd.Enabled = True
        cmdShowAdd.Enabled = True
        cmdToggleAdd.Enabled = True
    End If
    If SelEvent > lstEvent.ListCount - 1 Then
        SelEvent = lstEvent.ListCount - 1
    End If
    cmdHideAdd.Enabled = False
    cmdShowAdd.Enabled = False
    cmdToggleAdd.Enabled = False
    frmAdvanced.TriggerDeath.Clear
    frmAdvanced.TriggerTalk.Clear
    frmAdvanced.TriggerActivate.Clear
    frmAdvanced.TriggerLast.Clear
    frmAdvancedBlock.TriggerDeath.Clear
    frmAdvancedBlock.TriggerHit.Clear
    frmAdvancedBlock.TriggerLast.Clear
    TriggerEvent.Clear
    oldtimer = Timer
    TriggerEvent.List(0) = ""
    For A = 0 To lstEvent.ListCount - 1
        frmAdvanced.TriggerActivate.List(A) = Events(A).Name
        frmAdvanced.TriggerTalk.List(A) = Events(A).Name
        frmAdvanced.TriggerDeath.List(A) = Events(A).Name
        frmAdvanced.TriggerLast.List(A) = Events(A).Name
        frmAdvancedBlock.TriggerDeath.List(A) = Events(A).Name
        frmAdvancedBlock.TriggerHit.List(A) = Events(A).Name
        frmAdvancedBlock.TriggerLast.List(A) = Events(A).Name
        TriggerEvent.List(A + 1) = Events(A).Name
    Next A
    If SelEvent >= 0 Then
        TriggerEvent.Text = Events(SelEvent).TriggerEvent
        scrDelay.Value = Events(SelEvent).TriggerDelay
        If Events(SelEvent).LayerSmoke = True Then
            chkSmoke.Value = 1
        Else
            chkSmoke.Value = 0
        End If
        If Events(SelEvent).Controls.Up = True Then
            cUp.Value = 1
        Else
            cUp.Value = 0
        End If
        If Events(SelEvent).Controls.Down = True Then
            cDown.Value = 1
        Else
            cDown.Value = 0
        End If
        If Events(SelEvent).Controls.Left = True Then
            cLeft.Value = 1
        Else
            cLeft.Value = 0
        End If
        
        If Events(SelEvent).Controls.Right = True Then
            cRight.Value = 1
        Else
            cRight.Value = 0
        End If
        If Events(SelEvent).Controls.Run = True Then
            cRun.Value = 1
        Else
            cRun.Value = 0
        End If
        If Events(SelEvent).Controls.AltRun = True Then
            cAltRun.Value = 1
        Else
            cAltRun.Value = 0
        End If
        If Events(SelEvent).Controls.Jump = True Then
            cJump.Value = 1
        Else
            cJump.Value = 0
        End If
        If Events(SelEvent).Controls.AltJump = True Then
            cAltJump.Value = 1
        Else
            cAltJump.Value = 0
        End If
        If Events(SelEvent).Controls.Drop = True Then
            cDrop.Value = 1
        Else
            cDrop.Value = 0
        End If
        If Events(SelEvent).Controls.Start = True Then
            cStart.Value = 1
        Else
            cStart.Value = 0
        End If
    End If
    txtEvent.Text = lstEvent.List(SelEvent)
    If txtEvent.Text = "P Switch - Start" Or txtEvent.Text = "P Switch - End" Or txtEvent.Text = "Level - Start" Then
        cmdDelete.Enabled = False
        txtEvent.Enabled = False
    Else
        cmdDelete.Enabled = True
        txtEvent.Enabled = True
    End If
    If lstEvent.ListIndex = -1 Then
        cmdDelete.Enabled = False
    End If
    If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
    DontRefresh = False
End Sub

Private Sub txtX_Change()
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).SpeedX = Val(txtX.Text)
        End If
    Next A
    If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
End Sub

Private Sub txtY_Change()
    For A = 0 To 100
        If LCase(Events(A).Name) = LCase(lstEvent.List(lstEvent.ListIndex)) Then
            Events(A).SpeedY = Val(txtY.Text)
        End If
    Next A
    If noUpdate = False And nPlay.Online = True Then Netplay.sendData Netplay.ModEvent(SelEvent)
End Sub
