VERSION 5.00
Begin VB.Form frmEventTrigger 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Event Triggers"
   ClientHeight    =   1830
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   3870
   Icon            =   "frmEventTriger.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1830
   ScaleWidth      =   3870
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   8040
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   5
      Top             =   3000
      Width           =   375
   End
   Begin VB.Frame Frame 
      Caption         =   "Event Size"
      Height          =   1095
      Index           =   33
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   1095
      Begin VB.CommandButton EventR 
         Height          =   255
         Left            =   360
         TabIndex        =   4
         Top             =   480
         Width           =   255
      End
      Begin VB.HScrollBar EventW 
         Height          =   255
         Left            =   120
         Max             =   99
         Min             =   2
         TabIndex        =   3
         Top             =   480
         Value           =   2
         Width           =   735
      End
      Begin VB.VScrollBar EventH 
         Height          =   735
         Left            =   360
         Max             =   99
         Min             =   2
         TabIndex        =   2
         Top             =   240
         Value           =   2
         Width           =   255
      End
   End
   Begin VB.ComboBox TriggerEvent 
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Text            =   "TriggerEvent"
      Top             =   120
      Width           =   3615
   End
End
Attribute VB_Name = "frmEventTrigger"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub eventH_Change()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub eventR_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    EventH.Value = 2
    EventW.Value = 2
End Sub

Private Sub eventW_Change()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

