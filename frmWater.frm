VERSION 5.00
Begin VB.Form frmWater 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Water"
   ClientHeight    =   2055
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   1350
   Icon            =   "frmWater.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2055
   ScaleWidth      =   1350
   Begin VB.Frame Frame2 
      Caption         =   "Quicksand"
      Height          =   615
      Left            =   120
      TabIndex        =   8
      Top             =   1320
      Width           =   1095
      Begin VB.CommandButton Quicksand 
         Caption         =   "No"
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   240
         Width           =   855
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Buoyancy"
      Height          =   855
      Left            =   5520
      TabIndex        =   4
      Top             =   120
      Width           =   1215
      Begin VB.HScrollBar scrBuoy 
         Height          =   255
         Left            =   120
         Max             =   200
         Min             =   1
         TabIndex        =   6
         Top             =   480
         Value           =   100
         Width           =   975
      End
      Begin VB.Label lblBuoy 
         Caption         =   "100%"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   930
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Water Size"
      Height          =   1095
      Index           =   33
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   1095
      Begin VB.CommandButton WaterR 
         Height          =   255
         Left            =   360
         TabIndex        =   5
         Top             =   480
         Width           =   255
      End
      Begin VB.VScrollBar WaterH 
         Height          =   735
         Left            =   360
         Max             =   99
         Min             =   1
         TabIndex        =   3
         Top             =   240
         Value           =   1
         Width           =   255
      End
      Begin VB.HScrollBar WaterW 
         Height          =   255
         Left            =   120
         Max             =   99
         Min             =   1
         TabIndex        =   2
         Top             =   480
         Value           =   1
         Width           =   735
      End
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   3480
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   0
      Top             =   1440
      Width           =   375
   End
End
Attribute VB_Name = "frmWater"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Quicksand_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If QuickSand.Caption = "No" Then
        QuickSand.Caption = "Yes"
    Else
        QuickSand.Caption = "No"
    End If
End Sub

Private Sub WaterH_Change()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub WaterR_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    WaterH.Value = 2
    WaterW.Value = 2
End Sub

Private Sub WaterW_Change()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub
