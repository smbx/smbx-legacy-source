VERSION 5.00
Begin VB.Form frmLoading 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Loading"
   ClientHeight    =   1350
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   3165
   Icon            =   "frmLoading.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1350
   ScaleWidth      =   3165
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdGo 
      Caption         =   "Disconnect"
      Height          =   375
      Left            =   840
      TabIndex        =   3
      Top             =   840
      Width           =   1455
   End
   Begin VB.PictureBox maxLoad 
      Height          =   375
      Left            =   120
      ScaleHeight     =   315
      ScaleWidth      =   2835
      TabIndex        =   1
      Top             =   360
      Width           =   2895
      Begin VB.PictureBox curLoad 
         BackColor       =   &H00FF8080&
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   0
         ScaleHeight     =   375
         ScaleWidth      =   2895
         TabIndex        =   2
         Top             =   0
         Width           =   2895
      End
   End
   Begin VB.Timer tmrLoad 
      Interval        =   1000
      Left            =   120
      Top             =   4440
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Loading data from server, please wait..."
      Height          =   195
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2775
   End
End
Attribute VB_Name = "frmLoading"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdGo_Click()
    frmChat.txtChat = frmChat.txtChat & "You have disconnected." & LB
    frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
    PlaySound 47
    SoundPause(47) = 2
    Netplay.DropServer
    Me.Enabled = False
    Unload Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If Me.Enabled = True Then
        frmChat.txtChat = frmChat.txtChat & "You have disconnected." & LB
        frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
        PlaySound 47
        SoundPause(47) = 2
        Netplay.DropServer
    End If
End Sub

Private Sub tmrLoad_Timer()
    If Me.Caption = "Loading" Then
        Me.Caption = "Loading."
    ElseIf Me.Caption = "Loading." Then
        Me.Caption = "Loading.."
    ElseIf Me.Caption = "Loading.." Then
        Me.Caption = "Loading..."
    ElseIf Me.Caption = "Loading..." Then
        Me.Caption = "Loading...."
    Else
        Me.Caption = "Loading"
    End If
End Sub
