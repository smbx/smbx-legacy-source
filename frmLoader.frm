VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "ieframe.dll"
Begin VB.Form frmLoader 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Super Mario Bros. X - Version 1.3 - www.SuperMarioBrothers.org"
   ClientHeight    =   6855
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   9405
   Icon            =   "frmLoader.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6855
   ScaleWidth      =   9405
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkFrameskip 
      Caption         =   "Disable Frameskip"
      Height          =   255
      Left            =   4560
      TabIndex        =   5
      Top             =   6480
      Width           =   1695
   End
   Begin VB.CheckBox chkSound 
      Caption         =   "Disable Sound"
      Height          =   255
      Left            =   6360
      TabIndex        =   4
      Top             =   6480
      Width           =   1455
   End
   Begin SHDocVwCtl.WebBrowser Splash 
      Height          =   6135
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   9135
      ExtentX         =   16113
      ExtentY         =   10821
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   "http:///"
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   7920
      TabIndex        =   2
      Top             =   6360
      Width           =   1335
   End
   Begin VB.CommandButton cmdEditor 
      Caption         =   "Level Editor"
      Height          =   375
      Left            =   1560
      TabIndex        =   1
      Top             =   6360
      Width           =   1335
   End
   Begin VB.CommandButton cmdGame 
      Caption         =   "Start Game"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   6360
      Width           =   1335
   End
End
Attribute VB_Name = "frmLoader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdEditor_Click()
    LevelEditor = True
    StartMenu = True
End Sub

Private Sub cmdExit_Click()
    KillIt
End Sub

Private Sub cmdGame_Click()
    StartMenu = True
End Sub

Private Sub Form_Load()
    Splash.Navigate "http://www.supermariobrothers.org/splash/"
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If StartMenu = False Then KillIt
End Sub
