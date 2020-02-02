VERSION 5.00
Begin VB.Form frmLoading2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Loading"
   ClientHeight    =   5775
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4470
   Icon            =   "frmLoading2.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5775
   ScaleWidth      =   4470
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   15
      Left            =   3480
      TabIndex        =   44
      Top             =   5400
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   15
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   42
      Top             =   5400
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   15
         Left            =   960
         TabIndex        =   43
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   15
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   14
      Left            =   3480
      TabIndex        =   41
      Top             =   5040
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   14
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   39
      Top             =   5040
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   14
         Left            =   960
         TabIndex        =   40
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   14
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   13
      Left            =   3480
      TabIndex        =   38
      Top             =   4680
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   13
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   36
      Top             =   4680
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   13
         Left            =   960
         TabIndex        =   37
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   13
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   12
      Left            =   3480
      TabIndex        =   35
      Top             =   4320
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   12
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   33
      Top             =   4320
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   12
         Left            =   960
         TabIndex        =   34
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   12
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   11
      Left            =   3480
      TabIndex        =   32
      Top             =   3960
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   11
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   30
      Top             =   3960
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   11
         Left            =   960
         TabIndex        =   31
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   11
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   10
      Left            =   3480
      TabIndex        =   29
      Top             =   3600
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   10
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   27
      Top             =   3600
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   10
         Left            =   960
         TabIndex        =   28
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   10
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   9
      Left            =   3480
      TabIndex        =   26
      Top             =   3240
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   9
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   24
      Top             =   3240
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   9
         Left            =   960
         TabIndex        =   25
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   9
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   8
      Left            =   3480
      TabIndex        =   23
      Top             =   2880
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   8
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   21
      Top             =   2880
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   8
         Left            =   960
         TabIndex        =   22
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   8
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   7
      Left            =   3480
      TabIndex        =   20
      Top             =   2520
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   7
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   18
      Top             =   2520
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   7
         Left            =   960
         TabIndex        =   19
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   7
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   6
      Left            =   3480
      TabIndex        =   17
      Top             =   2160
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   6
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   15
      Top             =   2160
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   6
         Left            =   960
         TabIndex        =   16
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   6
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   5
      Left            =   3480
      TabIndex        =   14
      Top             =   1800
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   5
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   12
      Top             =   1800
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   5
         Left            =   960
         TabIndex        =   13
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   5
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   4
      Left            =   3480
      TabIndex        =   11
      Top             =   1440
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   4
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   9
      Top             =   1440
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   4
         Left            =   960
         TabIndex        =   10
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   4
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   3
      Left            =   3480
      TabIndex        =   8
      Top             =   1080
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   3
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   6
      Top             =   1080
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   3
         Left            =   960
         TabIndex        =   7
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   3
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   2
      Left            =   3480
      TabIndex        =   5
      Top             =   720
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   2
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   3
      Top             =   720
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   2
         Left            =   960
         TabIndex        =   4
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   2
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "Kick"
      Height          =   255
      Index           =   1
      Left            =   3480
      TabIndex        =   2
      Top             =   360
      Width           =   855
   End
   Begin VB.PictureBox maxLoad 
      Height          =   255
      Index           =   1
      Left            =   120
      ScaleHeight     =   195
      ScaleWidth      =   3195
      TabIndex        =   1
      Top             =   360
      Width           =   3255
      Begin VB.Label lblClient 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Anonymous"
         Height          =   195
         Index           =   1
         Left            =   960
         TabIndex        =   45
         Top             =   0
         Width           =   825
      End
      Begin VB.Shape curLoad 
         BorderColor     =   &H00FF8080&
         FillColor       =   &H00FF8080&
         FillStyle       =   0  'Solid
         Height          =   615
         Index           =   1
         Left            =   0
         Top             =   0
         Width           =   1335
      End
   End
   Begin VB.Timer tmrLoad 
      Interval        =   1000
      Left            =   120
      Top             =   6000
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Syncing data with clients, please wait..."
      Height          =   195
      Left            =   840
      TabIndex        =   0
      Top             =   120
      Width           =   2775
   End
End
Attribute VB_Name = "frmLoading2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    For A = 1 To 15
        curLoad(A).Top = 0
        curLoad(A).Left = 0
        curLoad(A).Width = 0
        lblClient(A).Caption = ""
        cmdBoot(A).Enabled = False
    Next A
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
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

