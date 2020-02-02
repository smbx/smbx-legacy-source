VERSION 5.00
Begin VB.Form GFX 
   BackColor       =   &H8000000D&
   BorderStyle     =   0  'None
   Caption         =   "Graphics"
   ClientHeight    =   1395
   ClientLeft      =   0
   ClientTop       =   1770
   ClientWidth     =   1305
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1395
   ScaleWidth      =   1305
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   WindowState     =   1  'Minimized
   Begin VB.PictureBox ScreenShooter 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   1935
      Left            =   9360
      ScaleHeight     =   129
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   161
      TabIndex        =   133
      Top             =   600
      Width           =   2415
   End
   Begin VB.PictureBox BMVsMask 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   240
      Left            =   3480
      Picture         =   "GFX.frx":0000
      ScaleHeight     =   16
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   34
      TabIndex        =   130
      Top             =   4440
      Width           =   510
   End
   Begin VB.PictureBox BMVs 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   240
      Left            =   2160
      Picture         =   "GFX.frx":038E
      ScaleHeight     =   16
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   34
      TabIndex        =   129
      Top             =   4320
      Width           =   510
   End
   Begin VB.PictureBox BMWinMask 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Left            =   3480
      Picture         =   "GFX.frx":0746
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   70
      TabIndex        =   128
      Top             =   3840
      Width           =   1050
   End
   Begin VB.PictureBox BMWin 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Left            =   2160
      Picture         =   "GFX.frx":0B3B
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   70
      TabIndex        =   127
      Top             =   3840
      Width           =   1050
   End
   Begin VB.PictureBox CharacterNameMask 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   5
      Left            =   3480
      Picture         =   "GFX.frx":0FCB
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   60
      TabIndex        =   126
      Top             =   3360
      Width           =   900
   End
   Begin VB.PictureBox CharacterNameMask 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   4
      Left            =   3480
      Picture         =   "GFX.frx":13A7
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   64
      TabIndex        =   125
      Top             =   2880
      Width           =   960
   End
   Begin VB.PictureBox CharacterNameMask 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   3
      Left            =   3480
      Picture         =   "GFX.frx":178C
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   78
      TabIndex        =   124
      Top             =   2400
      Width           =   1170
   End
   Begin VB.PictureBox CharacterNameMask 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   2
      Left            =   3480
      Picture         =   "GFX.frx":1B84
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   74
      TabIndex        =   123
      Top             =   1920
      Width           =   1110
   End
   Begin VB.PictureBox CharacterNameMask 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   1
      Left            =   3480
      Picture         =   "GFX.frx":1F7D
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   78
      TabIndex        =   122
      Top             =   1440
      Width           =   1170
   End
   Begin VB.PictureBox CharacterName 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   5
      Left            =   2160
      Picture         =   "GFX.frx":2380
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   60
      TabIndex        =   121
      Top             =   3360
      Width           =   900
   End
   Begin VB.PictureBox CharacterName 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   4
      Left            =   2160
      Picture         =   "GFX.frx":27D3
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   64
      TabIndex        =   120
      Top             =   2880
      Width           =   960
   End
   Begin VB.PictureBox CharacterName 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   3
      Left            =   2160
      Picture         =   "GFX.frx":2C34
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   78
      TabIndex        =   119
      Top             =   2400
      Width           =   1170
   End
   Begin VB.PictureBox CharacterName 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   2
      Left            =   2160
      Picture         =   "GFX.frx":30CE
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   74
      TabIndex        =   118
      Top             =   1920
      Width           =   1110
   End
   Begin VB.PictureBox CharacterName 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   1
      Left            =   2160
      Picture         =   "GFX.frx":354A
      ScaleHeight     =   22
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   78
      TabIndex        =   117
      Top             =   1440
      Width           =   1170
   End
   Begin VB.PictureBox LoadCoinMask 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   1920
      Left            =   1560
      Picture         =   "GFX.frx":39EF
      ScaleHeight     =   128
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   28
      TabIndex        =   116
      Top             =   1440
      Width           =   420
   End
   Begin VB.PictureBox LoadCoin 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   1920
      Left            =   1080
      Picture         =   "GFX.frx":3E5A
      ScaleHeight     =   128
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   28
      TabIndex        =   115
      Top             =   1440
      Width           =   420
   End
   Begin VB.PictureBox BgHolder 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   855
      Left            =   120
      ScaleHeight     =   57
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   57
      TabIndex        =   114
      Top             =   1440
      Width           =   855
   End
   Begin VB.PictureBox BlitToMe 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   550
      Left            =   6120
      ScaleHeight     =   37
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   37
      TabIndex        =   113
      Top             =   120
      Width           =   550
   End
   Begin VB.Frame Frame24 
      Caption         =   "Misc."
      Height          =   1215
      Left            =   4920
      TabIndex        =   69
      Top             =   120
      Width           =   1095
      Begin VB.PictureBox Water 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BackColor       =   &H0000FF00&
         BorderStyle     =   0  'None
         Height          =   1080
         Left            =   1440
         ScaleHeight     =   72
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   80
         TabIndex        =   83
         Top             =   2760
         Visible         =   0   'False
         Width           =   1200
      End
      Begin VB.PictureBox BackgroundColor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BackColor       =   &H00000000&
         BorderStyle     =   0  'None
         Height          =   1080
         Index           =   2
         Left            =   120
         ScaleHeight     =   72
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   80
         TabIndex        =   75
         Top             =   3960
         Visible         =   0   'False
         Width           =   1200
      End
      Begin VB.PictureBox Split 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BackColor       =   &H00FF00FF&
         BorderStyle     =   0  'None
         Height          =   1080
         Index           =   1
         Left            =   120
         ScaleHeight     =   72
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   80
         TabIndex        =   74
         Top             =   2760
         Visible         =   0   'False
         Width           =   1200
      End
      Begin VB.PictureBox Split 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BackColor       =   &H00404040&
         BorderStyle     =   0  'None
         Height          =   1200
         Index           =   2
         Left            =   120
         ScaleHeight     =   80
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   88
         TabIndex        =   73
         Top             =   1440
         Visible         =   0   'False
         Width           =   1320
      End
      Begin VB.PictureBox WarpMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   1
         Left            =   1440
         Picture         =   "GFX.frx":43A0
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   72
         Top             =   240
         Visible         =   0   'False
         Width           =   480
      End
      Begin VB.PictureBox Warp 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   1
         Left            =   1440
         Picture         =   "GFX.frx":4FE2
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   71
         Top             =   840
         Visible         =   0   'False
         Width           =   480
      End
      Begin VB.PictureBox BackgroundColor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BackColor       =   &H00000000&
         BorderStyle     =   0  'None
         Height          =   1080
         Index           =   1
         Left            =   120
         ScaleHeight     =   72
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   80
         TabIndex        =   70
         Top             =   240
         Visible         =   0   'False
         Width           =   1200
      End
   End
   Begin VB.Frame Frame19 
      Caption         =   "Yoshi"
      Height          =   1215
      Left            =   2520
      TabIndex        =   55
      Top             =   120
      Visible         =   0   'False
      Width           =   1095
      Begin VB.PictureBox YoshiWings 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   1920
         Left            =   120
         Picture         =   "GFX.frx":5C24
         ScaleHeight     =   128
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   82
         Top             =   240
         Width           =   480
      End
      Begin VB.PictureBox YoshiWingsMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   1920
         Left            =   720
         Picture         =   "GFX.frx":614B
         ScaleHeight     =   128
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   81
         Top             =   240
         Width           =   480
      End
      Begin VB.PictureBox Tongue 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   1
         Left            =   1320
         Picture         =   "GFX.frx":65B3
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   59
         Top             =   1080
         Width           =   240
      End
      Begin VB.PictureBox TongueMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   1
         Left            =   1680
         Picture         =   "GFX.frx":6945
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   58
         Top             =   1080
         Width           =   240
      End
      Begin VB.PictureBox Tongue 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   2
         Left            =   1320
         Picture         =   "GFX.frx":6CC0
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   416
         TabIndex        =   57
         Top             =   360
         Width           =   6240
      End
      Begin VB.PictureBox TongueMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   2
         Left            =   1320
         Picture         =   "GFX.frx":70A5
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   416
         TabIndex        =   56
         Top             =   720
         Width           =   6240
      End
   End
   Begin VB.Frame Frame15 
      Caption         =   "Mounts"
      Height          =   1215
      Left            =   120
      TabIndex        =   46
      Top             =   120
      Visible         =   0   'False
      Width           =   1095
      Begin VB.PictureBox BootMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   1920
         Index           =   3
         Left            =   720
         Picture         =   "GFX.frx":748A
         ScaleHeight     =   128
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   79
         Top             =   4320
         Width           =   480
      End
      Begin VB.PictureBox Boot 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   1920
         Index           =   3
         Left            =   120
         Picture         =   "GFX.frx":7A25
         ScaleHeight     =   128
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   78
         Top             =   4320
         Width           =   480
      End
      Begin VB.PictureBox Boot 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   1920
         Index           =   2
         Left            =   120
         Picture         =   "GFX.frx":7FC0
         ScaleHeight     =   128
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   77
         Top             =   2280
         Width           =   480
      End
      Begin VB.PictureBox BootMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   1920
         Index           =   2
         Left            =   720
         Picture         =   "GFX.frx":85AB
         ScaleHeight     =   128
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   76
         Top             =   2280
         Width           =   480
      End
      Begin VB.PictureBox Mount 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   15360
         Index           =   2
         Left            =   1440
         Picture         =   "GFX.frx":89C8
         ScaleHeight     =   1024
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   128
         TabIndex        =   50
         Top             =   240
         Width           =   1920
      End
      Begin VB.PictureBox MountMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   15360
         Index           =   2
         Left            =   3480
         Picture         =   "GFX.frx":BF1C
         ScaleHeight     =   1024
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   128
         TabIndex        =   49
         Top             =   240
         Width           =   1920
      End
      Begin VB.PictureBox BootMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   1920
         Index           =   1
         Left            =   720
         Picture         =   "GFX.frx":CCD0
         ScaleHeight     =   128
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   48
         Top             =   240
         Width           =   480
      End
      Begin VB.PictureBox Boot 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   1920
         Index           =   1
         Left            =   120
         Picture         =   "GFX.frx":D0ED
         ScaleHeight     =   128
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   47
         Top             =   240
         Width           =   480
      End
   End
   Begin VB.Frame Frame14 
      Caption         =   "Menu"
      Height          =   6015
      Left            =   3720
      TabIndex        =   33
      Top             =   120
      Visible         =   0   'False
      Width           =   7215
      Begin VB.PictureBox MenuGFXMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   720
         Index           =   1
         Left            =   480
         Picture         =   "GFX.frx":D6D8
         ScaleHeight     =   48
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   800
         TabIndex        =   68
         Top             =   960
         Width           =   12000
      End
      Begin VB.PictureBox MenuGFX 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   9000
         Index           =   4
         Left            =   120
         Picture         =   "GFX.frx":DDBE
         ScaleHeight     =   600
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   800
         TabIndex        =   45
         Top             =   6240
         Width           =   12000
      End
      Begin VB.PictureBox MenuGFXMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   3
         Left            =   120
         Picture         =   "GFX.frx":167E9
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   468
         TabIndex        =   44
         Top             =   5880
         Width           =   7020
      End
      Begin VB.PictureBox MenuGFX 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   3
         Left            =   120
         Picture         =   "GFX.frx":16DCD
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   468
         TabIndex        =   43
         Top             =   5520
         Width           =   7020
      End
      Begin VB.PictureBox MenuGFXMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   3750
         Index           =   2
         Left            =   5760
         Picture         =   "GFX.frx":174BE
         ScaleHeight     =   250
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   374
         TabIndex        =   42
         Top             =   1560
         Width           =   5610
      End
      Begin VB.PictureBox MenuGFX 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   3750
         Index           =   2
         Left            =   120
         Picture         =   "GFX.frx":18010
         ScaleHeight     =   250
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   374
         TabIndex        =   41
         Top             =   1560
         Width           =   5610
      End
      Begin VB.PictureBox MenuGFX 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   900
         Index           =   1
         Left            =   120
         Picture         =   "GFX.frx":1A10A
         ScaleHeight     =   60
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   800
         TabIndex        =   34
         Top             =   240
         Width           =   12000
      End
   End
   Begin VB.Frame Frame8 
      Caption         =   "Interface"
      Height          =   1215
      Left            =   840
      TabIndex        =   0
      Top             =   5880
      Visible         =   0   'False
      Width           =   1095
      Begin VB.PictureBox InterfaceMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   8
         Left            =   3360
         Picture         =   "GFX.frx":1B309
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   135
         Top             =   1080
         Width           =   240
      End
      Begin VB.PictureBox Interface 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   8
         Left            =   3360
         Picture         =   "GFX.frx":1B694
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   134
         Top             =   720
         Width           =   240
      End
      Begin VB.PictureBox InterfaceMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   7
         Left            =   2760
         Picture         =   "GFX.frx":1BA1F
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   132
         Top             =   2520
         Width           =   480
      End
      Begin VB.PictureBox Interface 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   7
         Left            =   2760
         Picture         =   "GFX.frx":1BDD3
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   131
         Top             =   2160
         Width           =   480
      End
      Begin VB.PictureBox InterfaceMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   6
         Left            =   2400
         Picture         =   "GFX.frx":1C187
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   112
         Top             =   2520
         Width           =   240
      End
      Begin VB.PictureBox Interface 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   6
         Left            =   2400
         Picture         =   "GFX.frx":1C4E9
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   111
         Top             =   2160
         Width           =   240
      End
      Begin VB.PictureBox InterfaceMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   0
         Left            =   2040
         Picture         =   "GFX.frx":1C864
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   110
         Top             =   2520
         Width           =   240
      End
      Begin VB.PictureBox Interface 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   0
         Left            =   2040
         Picture         =   "GFX.frx":1CBCE
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   109
         Top             =   2160
         Width           =   240
      End
      Begin VB.PictureBox MCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   3
         Left            =   2040
         Picture         =   "GFX.frx":1CF37
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   108
         Top             =   1800
         Width           =   240
      End
      Begin VB.PictureBox HeartMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   450
         Index           =   2
         Left            =   2400
         Picture         =   "GFX.frx":1D29B
         ScaleHeight     =   30
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   22
         TabIndex        =   107
         Top             =   6720
         Width           =   330
      End
      Begin VB.PictureBox HeartMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   450
         Index           =   1
         Left            =   2040
         Picture         =   "GFX.frx":1D627
         ScaleHeight     =   30
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   22
         TabIndex        =   106
         Top             =   6720
         Width           =   330
      End
      Begin VB.PictureBox Heart 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   450
         Index           =   2
         Left            =   2400
         Picture         =   "GFX.frx":1D9B3
         ScaleHeight     =   30
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   22
         TabIndex        =   105
         Top             =   6240
         Width           =   330
      End
      Begin VB.PictureBox Heart 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   450
         Index           =   1
         Left            =   2040
         Picture         =   "GFX.frx":1DD9F
         ScaleHeight     =   30
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   22
         TabIndex        =   104
         Top             =   6240
         Width           =   330
      End
      Begin VB.PictureBox MCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   2
         Left            =   2520
         Picture         =   "GFX.frx":1E18B
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   103
         Top             =   5040
         Width           =   240
      End
      Begin VB.PictureBox MCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   2
         Left            =   2520
         Picture         =   "GFX.frx":1E501
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   102
         Top             =   5400
         Width           =   240
      End
      Begin VB.PictureBox MCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   1
         Left            =   2160
         Picture         =   "GFX.frx":1E877
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   101
         Top             =   5040
         Width           =   240
      End
      Begin VB.PictureBox MCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   1
         Left            =   2160
         Picture         =   "GFX.frx":1EBED
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   100
         Top             =   5400
         Width           =   240
      End
      Begin VB.PictureBox nCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   7
         Left            =   6360
         Picture         =   "GFX.frx":1EF63
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   99
         Top             =   5760
         Width           =   480
      End
      Begin VB.PictureBox nCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   7
         Left            =   5760
         Picture         =   "GFX.frx":1F312
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   98
         Top             =   5760
         Width           =   480
      End
      Begin VB.PictureBox nCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   6
         Left            =   5760
         Picture         =   "GFX.frx":1F700
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   97
         Top             =   5160
         Width           =   480
      End
      Begin VB.PictureBox nCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   6
         Left            =   6360
         Picture         =   "GFX.frx":1FAEE
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   96
         Top             =   5160
         Width           =   480
      End
      Begin VB.PictureBox nCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   5
         Left            =   5760
         Picture         =   "GFX.frx":1FE9D
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   95
         Top             =   4560
         Width           =   480
      End
      Begin VB.PictureBox nCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   5
         Left            =   6360
         Picture         =   "GFX.frx":2028B
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   94
         Top             =   4560
         Width           =   480
      End
      Begin VB.PictureBox nCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   3
         Left            =   4560
         Picture         =   "GFX.frx":2063A
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   93
         Top             =   6960
         Width           =   480
      End
      Begin VB.PictureBox nCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   3
         Left            =   5160
         Picture         =   "GFX.frx":20A28
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   92
         Top             =   6960
         Width           =   480
      End
      Begin VB.PictureBox nCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   2
         Left            =   4560
         Picture         =   "GFX.frx":20DD7
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   91
         Top             =   6360
         Width           =   480
      End
      Begin VB.PictureBox nCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   2
         Left            =   5160
         Picture         =   "GFX.frx":211C5
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   90
         Top             =   6360
         Width           =   480
      End
      Begin VB.PictureBox nCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   1
         Left            =   4560
         Picture         =   "GFX.frx":21574
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   89
         Top             =   5760
         Width           =   480
      End
      Begin VB.PictureBox nCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   1
         Left            =   5160
         Picture         =   "GFX.frx":21962
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   88
         Top             =   5760
         Width           =   480
      End
      Begin VB.PictureBox nCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   0
         Left            =   4560
         Picture         =   "GFX.frx":21D11
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   87
         Top             =   5160
         Width           =   480
      End
      Begin VB.PictureBox nCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   0
         Left            =   5160
         Picture         =   "GFX.frx":220FF
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   86
         Top             =   5160
         Width           =   480
      End
      Begin VB.PictureBox nCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   4
         Left            =   5160
         Picture         =   "GFX.frx":224AE
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   85
         Top             =   4560
         Width           =   480
      End
      Begin VB.PictureBox nCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   4
         Left            =   4560
         Picture         =   "GFX.frx":2285D
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   84
         Top             =   4560
         Width           =   480
      End
      Begin VB.PictureBox Font2S 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   1
         Left            =   120
         Picture         =   "GFX.frx":22C4B
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   496
         TabIndex        =   80
         Top             =   4200
         Width           =   7440
      End
      Begin VB.PictureBox ECursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   450
         Index           =   3
         Left            =   3720
         Picture         =   "GFX.frx":2325B
         ScaleHeight     =   30
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   22
         TabIndex        =   67
         Top             =   5640
         Width           =   330
      End
      Begin VB.PictureBox ECursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   450
         Index           =   3
         Left            =   3120
         Picture         =   "GFX.frx":235C9
         ScaleHeight     =   30
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   22
         TabIndex        =   66
         Top             =   5640
         Width           =   330
      End
      Begin VB.PictureBox ECursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   2
         Left            =   3120
         Picture         =   "GFX.frx":2397B
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   65
         Top             =   5040
         Width           =   480
      End
      Begin VB.PictureBox ECursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   2
         Left            =   3720
         Picture         =   "GFX.frx":23D5C
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   64
         Top             =   5040
         Width           =   480
      End
      Begin VB.PictureBox ECursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   1
         Left            =   3120
         Picture         =   "GFX.frx":2410B
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   63
         Top             =   4440
         Width           =   480
      End
      Begin VB.PictureBox ECursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   480
         Index           =   1
         Left            =   3720
         Picture         =   "GFX.frx":244F9
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   62
         Top             =   4440
         Width           =   480
      End
      Begin VB.PictureBox InterfaceMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   5
         Left            =   2760
         Picture         =   "GFX.frx":248A8
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   61
         Top             =   1080
         Width           =   240
      End
      Begin VB.PictureBox Interface 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   5
         Left            =   2400
         Picture         =   "GFX.frx":24C15
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   60
         Top             =   1080
         Width           =   240
      End
      Begin VB.PictureBox Chat 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   330
         Left            =   2760
         Picture         =   "GFX.frx":24F82
         ScaleHeight     =   22
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   12
         TabIndex        =   54
         Top             =   1680
         Width           =   180
      End
      Begin VB.PictureBox ChatMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   330
         Left            =   3000
         Picture         =   "GFX.frx":252EE
         ScaleHeight     =   22
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   12
         TabIndex        =   53
         Top             =   1680
         Width           =   180
      End
      Begin VB.PictureBox Font2 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   22605
         Index           =   3
         Left            =   1080
         Picture         =   "GFX.frx":2565A
         ScaleHeight     =   1507
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   17
         TabIndex        =   52
         Top             =   4200
         Width           =   255
      End
      Begin VB.PictureBox TextBox 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   3000
         Left            =   3720
         Picture         =   "GFX.frx":2609B
         ScaleHeight     =   200
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   500
         TabIndex        =   51
         Top             =   240
         Width           =   7500
      End
      Begin VB.PictureBox MCursorMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   0
         Left            =   2040
         Picture         =   "GFX.frx":26816
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   40
         Top             =   1440
         Width           =   240
      End
      Begin VB.PictureBox MCursor 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   0
         Left            =   2040
         Picture         =   "GFX.frx":26B58
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   39
         Top             =   1080
         Width           =   240
      End
      Begin VB.PictureBox Font2Mask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   29100
         Index           =   2
         Left            =   480
         Picture         =   "GFX.frx":26E9A
         ScaleHeight     =   1940
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   20
         TabIndex        =   38
         Top             =   4200
         Width           =   300
      End
      Begin VB.PictureBox Font2 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   29100
         Index           =   2
         Left            =   120
         Picture         =   "GFX.frx":4358C
         ScaleHeight     =   1940
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   20
         TabIndex        =   37
         Top             =   4200
         Width           =   300
      End
      Begin VB.PictureBox Font2 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   1
         Left            =   120
         Picture         =   "GFX.frx":5FC7E
         ScaleHeight     =   17
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   991
         TabIndex        =   36
         Top             =   3840
         Width           =   14865
      End
      Begin VB.PictureBox Interface 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   9000
         Index           =   4
         Left            =   7680
         Picture         =   "GFX.frx":6C260
         ScaleHeight     =   600
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   800
         TabIndex        =   35
         Top             =   240
         Width           =   12000
      End
      Begin VB.PictureBox Container 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   840
         Index           =   1
         Left            =   120
         Picture         =   "GFX.frx":1CBBA2
         ScaleHeight     =   56
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   56
         TabIndex        =   32
         Top             =   1200
         Width           =   840
      End
      Begin VB.PictureBox ContainerMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   840
         Index           =   1
         Left            =   1080
         Picture         =   "GFX.frx":1CE0A4
         ScaleHeight     =   56
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   56
         TabIndex        =   31
         Top             =   1200
         Width           =   840
      End
      Begin VB.PictureBox ContainerMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   840
         Index           =   2
         Left            =   1080
         Picture         =   "GFX.frx":1D05A6
         ScaleHeight     =   56
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   56
         TabIndex        =   30
         Top             =   2160
         Width           =   840
      End
      Begin VB.PictureBox Container 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   840
         Index           =   2
         Left            =   120
         Picture         =   "GFX.frx":1D2AA8
         ScaleHeight     =   56
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   56
         TabIndex        =   29
         Top             =   2160
         Width           =   840
      End
      Begin VB.PictureBox ContainerMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   840
         Index           =   0
         Left            =   1080
         Picture         =   "GFX.frx":1D4FAA
         ScaleHeight     =   56
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   56
         TabIndex        =   28
         Top             =   240
         Width           =   840
      End
      Begin VB.PictureBox Container 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   840
         Index           =   0
         Left            =   120
         Picture         =   "GFX.frx":1D74AC
         ScaleHeight     =   56
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   56
         TabIndex        =   27
         Top             =   240
         Width           =   840
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   0
         Left            =   120
         Picture         =   "GFX.frx":1D99AE
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   26
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   0
         Left            =   120
         Picture         =   "GFX.frx":1D9C90
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   25
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   1
         Left            =   480
         Picture         =   "GFX.frx":1D9F72
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   24
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   1
         Left            =   480
         Picture         =   "GFX.frx":1DA254
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   23
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   2
         Left            =   840
         Picture         =   "GFX.frx":1DA536
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   22
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   2
         Left            =   840
         Picture         =   "GFX.frx":1DA818
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   21
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   3
         Left            =   1200
         Picture         =   "GFX.frx":1DAAFA
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   20
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   3
         Left            =   1200
         Picture         =   "GFX.frx":1DADDC
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   19
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   4
         Left            =   1560
         Picture         =   "GFX.frx":1DB0BE
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   18
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   4
         Left            =   1560
         Picture         =   "GFX.frx":1DB3A0
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   17
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   5
         Left            =   1920
         Picture         =   "GFX.frx":1DB682
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   16
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   5
         Left            =   1920
         Picture         =   "GFX.frx":1DB964
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   15
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   6
         Left            =   2280
         Picture         =   "GFX.frx":1DBC46
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   14
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   6
         Left            =   2280
         Picture         =   "GFX.frx":1DBF28
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   13
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   7
         Left            =   2640
         Picture         =   "GFX.frx":1DC20A
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   12
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   7
         Left            =   2640
         Picture         =   "GFX.frx":1DC4EC
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   11
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   8
         Left            =   3000
         Picture         =   "GFX.frx":1DC7CE
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   10
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   8
         Left            =   3000
         Picture         =   "GFX.frx":1DCAB0
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   9
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Font1 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   9
         Left            =   3360
         Picture         =   "GFX.frx":1DCD92
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   8
         Top             =   3120
         Width           =   240
      End
      Begin VB.PictureBox Font1M 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   9
         Left            =   3360
         Picture         =   "GFX.frx":1DD074
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   7
         Top             =   3480
         Width           =   240
      End
      Begin VB.PictureBox Interface 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   1
         Left            =   2040
         Picture         =   "GFX.frx":1DD356
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   14
         TabIndex        =   6
         Top             =   240
         Width           =   210
      End
      Begin VB.PictureBox InterfaceMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   210
         Index           =   1
         Left            =   2040
         Picture         =   "GFX.frx":1DD600
         ScaleHeight     =   14
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   14
         TabIndex        =   5
         Top             =   600
         Width           =   210
      End
      Begin VB.PictureBox Interface 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   2
         Left            =   2400
         Picture         =   "GFX.frx":1DD8AA
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   4
         Top             =   240
         Width           =   240
      End
      Begin VB.PictureBox InterfaceMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   2
         Left            =   2400
         Picture         =   "GFX.frx":1DDBEC
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   16
         TabIndex        =   3
         Top             =   600
         Width           =   240
      End
      Begin VB.PictureBox Interface 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   3
         Left            =   2760
         Picture         =   "GFX.frx":1DDF2E
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   2
         Top             =   240
         Width           =   480
      End
      Begin VB.PictureBox InterfaceMask 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   240
         Index           =   3
         Left            =   2760
         Picture         =   "GFX.frx":1DE570
         ScaleHeight     =   16
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   1
         Top             =   600
         Width           =   480
      End
   End
End
Attribute VB_Name = "GFX"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
