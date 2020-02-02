VERSION 5.00
Begin VB.Form frmNPCAdvanced 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Advanced NPC Settings"
   ClientHeight    =   1950
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4305
   Icon            =   "frmNPCAdvanced.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1950
   ScaleWidth      =   4305
   Begin VB.Frame WarpFrame 
      Caption         =   "Warp to Section"
      Height          =   615
      Left            =   120
      TabIndex        =   10
      Top             =   1320
      Width           =   2535
      Begin VB.ComboBox WarpSection 
         Height          =   315
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   2175
      End
   End
   Begin VB.Frame FireFrame 
      Caption         =   "Firebar"
      Height          =   975
      Left            =   2760
      TabIndex        =   7
      Top             =   960
      Width           =   1455
      Begin VB.HScrollBar scrFire 
         Height          =   255
         Left            =   120
         Max             =   32
         TabIndex        =   8
         Top             =   480
         Value           =   1
         Width           =   1095
      End
      Begin VB.Label lbFire 
         Caption         =   "Position: 1"
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   240
         Width           =   1170
      End
   End
   Begin VB.Frame CheepFrame 
      Caption         =   "Cheep Cheep AI"
      Enabled         =   0   'False
      Height          =   615
      Left            =   120
      TabIndex        =   5
      Top             =   720
      Width           =   2535
      Begin VB.ComboBox cmbCheep 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "frmNPCAdvanced.frx":628A
         Left            =   120
         List            =   "frmNPCAdvanced.frx":629D
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   240
         Width           =   2175
      End
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   9000
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   4
      Top             =   3960
      Width           =   375
   End
   Begin VB.Frame LegacyFrame 
      Caption         =   "Legacy Boss"
      Enabled         =   0   'False
      Height          =   735
      Left            =   2760
      TabIndex        =   2
      Top             =   120
      Width           =   1455
      Begin VB.CommandButton Legacy 
         Caption         =   "No"
         Enabled         =   0   'False
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame ParaFrame 
      Caption         =   "Koopa Para-Troopa AI"
      Enabled         =   0   'False
      Height          =   615
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2535
      Begin VB.ComboBox cmbPara 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "frmNPCAdvanced.frx":62D8
         Left            =   120
         List            =   "frmNPCAdvanced.frx":62E8
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   240
         Width           =   2175
      End
   End
End
Attribute VB_Name = "frmNPCAdvanced"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()
    Dim A As Integer
    WarpSection.Clear
    For A = 1 To 21
        WarpSection.AddItem "Section " & A
    Next A
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
End Sub

Private Sub Legacy_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If Legacy.Caption = "No" Then
        Legacy.Caption = "Yes"
    Else
        Legacy.Caption = "No"
    End If
End Sub


Private Sub scrFire_Change()

    lbFire.Caption = "Position: " & scrFire.Value
End Sub
