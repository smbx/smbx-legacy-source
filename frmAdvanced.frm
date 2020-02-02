VERSION 5.00
Begin VB.Form frmAdvanced 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "NPC Event Triggers"
   ClientHeight    =   3930
   ClientLeft      =   -15
   ClientTop       =   375
   ClientWidth     =   4350
   Icon            =   "frmAdvanced.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3930
   ScaleWidth      =   4350
   Begin VB.Frame Frame4 
      Caption         =   "Attach to Layer"
      Height          =   735
      Left            =   120
      TabIndex        =   10
      Top             =   3120
      Width           =   4095
      Begin VB.ComboBox AttLayer 
         Height          =   315
         Left            =   240
         TabIndex        =   11
         Top             =   240
         Width           =   3615
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Event Triggers"
      Height          =   3135
      Left            =   120
      TabIndex        =   1
      Top             =   0
      Width           =   4095
      Begin VB.Frame Frame3 
         Caption         =   "No More Objects in Layer"
         Height          =   660
         Index           =   2
         Left            =   120
         TabIndex        =   8
         Top             =   2400
         Width           =   3855
         Begin VB.ComboBox TriggerLast 
            Height          =   315
            Left            =   120
            TabIndex        =   9
            Text            =   "TriggerLast"
            Top             =   240
            Width           =   3615
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Activate"
         Height          =   660
         Index           =   1
         Left            =   120
         TabIndex        =   6
         Top             =   1680
         Width           =   3855
         Begin VB.ComboBox TriggerActivate 
            Height          =   315
            Left            =   120
            TabIndex        =   7
            Text            =   "TriggerActivate"
            Top             =   240
            Width           =   3615
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Talk"
         Height          =   660
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Top             =   960
         Width           =   3855
         Begin VB.ComboBox TriggerTalk 
            Height          =   315
            Left            =   120
            TabIndex        =   5
            Text            =   "TriggerTalk"
            Top             =   240
            Width           =   3615
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Death"
         Height          =   660
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   3855
         Begin VB.ComboBox TriggerDeath 
            Height          =   315
            Left            =   120
            TabIndex        =   4
            Text            =   "TriggerDeath"
            Top             =   240
            Width           =   3615
         End
      End
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   8640
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   0
      Top             =   7560
      Width           =   375
   End
End
Attribute VB_Name = "frmAdvanced"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmbPara_Click()
    If cmbPara.ListIndex = 3 Then
        frmNPCs.frmDirection.Caption = "Direction"
        frmNPCs.optNPCDirection(0).Caption = "Up"
        frmNPCs.optNPCDirection(2).Caption = "Down"
    Else
        frmNPCs.frmDirection.Caption = "Direction"
        frmNPCs.optNPCDirection(0).Caption = "Left"
        frmNPCs.optNPCDirection(2).Caption = "Right"
    End If
End Sub

Private Sub Form_Load()
    frmNPCAdvanced.cmbPara.ListIndex = 1
    frmNPCAdvanced.cmbCheep.ListIndex = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
End Sub

