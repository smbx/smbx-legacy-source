VERSION 5.00
Begin VB.Form frmLevelSettings 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Level Settings"
   ClientHeight    =   3585
   ClientLeft      =   1.00050e5
   ClientTop       =   330
   ClientWidth     =   12285
   Icon            =   "frmLevelSettings.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   3585
   ScaleWidth      =   12285
   Visible         =   0   'False
   Begin VB.CommandButton cmdAdvanced 
      Caption         =   "Advanced"
      Height          =   255
      Left            =   120
      TabIndex        =   183
      Top             =   3120
      Width           =   1455
   End
   Begin VB.Frame Frame 
      Caption         =   "Under Water"
      Height          =   615
      Index           =   16
      Left            =   3360
      TabIndex        =   170
      Top             =   2880
      Width           =   1455
      Begin VB.CommandButton cmdWater 
         Caption         =   "Off"
         Height          =   255
         Left            =   120
         TabIndex        =   171
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame Game 
      Caption         =   "Super Mario RPG"
      Height          =   2055
      Index           =   6
      Left            =   8760
      TabIndex        =   109
      Top             =   9360
      Visible         =   0   'False
      Width           =   3015
      Begin VB.Frame Frame 
         Caption         =   "Music"
         Height          =   1695
         Index           =   15
         Left            =   120
         TabIndex        =   110
         Top             =   240
         Width           =   2775
         Begin VB.OptionButton optMusic 
            Caption         =   "Rose Town"
            Height          =   255
            Index           =   34
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   117
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Nimbus Land"
            Height          =   255
            Index           =   33
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   116
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Tadpole Pond"
            Height          =   255
            Index           =   32
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   115
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Forest Maze"
            Height          =   255
            Index           =   16
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   114
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Bowser Battle"
            Height          =   255
            Index           =   21
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   113
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Mario's Pad"
            Height          =   255
            Index           =   30
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   112
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Seaside Town"
            Height          =   255
            Index           =   31
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   111
            Top             =   960
            Width           =   1215
         End
      End
   End
   Begin VB.Frame Game 
      Caption         =   "Super Mario 64"
      Height          =   2775
      Index           =   5
      Left            =   9120
      TabIndex        =   96
      Top             =   6960
      Visible         =   0   'False
      Width           =   3015
      Begin VB.Frame Frame 
         Caption         =   "Music"
         Height          =   2415
         Index           =   9
         Left            =   120
         TabIndex        =   97
         Top             =   240
         Width           =   2775
         Begin VB.OptionButton optMusic 
            Caption         =   "Star Reactor"
            Height          =   255
            Index           =   20
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   186
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Cave"
            Height          =   255
            Index           =   50
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   177
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Water"
            Height          =   255
            Index           =   49
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   175
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Boss"
            Height          =   255
            Index           =   36
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   142
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Snow"
            Height          =   255
            Index           =   35
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   141
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Main Theme"
            Height          =   255
            Index           =   27
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   100
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Castle"
            Height          =   255
            Index           =   26
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   99
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Desert"
            Height          =   255
            Index           =   14
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   98
            Top             =   960
            Width           =   1215
         End
      End
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   16320
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   0
      Top             =   600
      Width           =   375
   End
   Begin VB.Frame Frame 
      Caption         =   "No Turn Back"
      Height          =   615
      Index           =   6
      Left            =   3360
      TabIndex        =   84
      Top             =   2160
      Width           =   1455
      Begin VB.CommandButton cmdNoTurnBack 
         Caption         =   "Off"
         Height          =   255
         Left            =   120
         TabIndex        =   85
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Offscreen Exit"
      Height          =   615
      Index           =   5
      Left            =   3360
      TabIndex        =   65
      Top             =   1440
      Width           =   1455
      Begin VB.CommandButton cmdExit 
         Caption         =   "Off"
         Height          =   255
         Left            =   120
         TabIndex        =   66
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame Game 
      Caption         =   "Super Mario World"
      Height          =   2775
      Index           =   4
      Left            =   2520
      TabIndex        =   58
      Top             =   9960
      Visible         =   0   'False
      Width           =   7335
      Begin VB.Frame Frame 
         Caption         =   "Backgrounds"
         Height          =   2415
         Index           =   12
         Left            =   120
         TabIndex        =   61
         Top             =   240
         Width           =   4215
         Begin VB.OptionButton optBackground 
            Caption         =   "Desert Night"
            Height          =   255
            Index           =   58
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   185
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Underwater"
            Height          =   255
            Index           =   55
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   169
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Castle 2"
            Height          =   255
            Index           =   43
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   153
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Castle"
            Height          =   255
            Index           =   42
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   152
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Hills 3"
            Height          =   255
            Index           =   34
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   121
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Hills 4"
            Height          =   255
            Index           =   33
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   120
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Hills 2"
            Height          =   255
            Index           =   32
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   119
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Clouds"
            Height          =   255
            Index           =   31
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   118
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Cave"
            Height          =   255
            Index           =   30
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   107
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Night"
            Height          =   255
            Index           =   29
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   104
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Bonus"
            Height          =   255
            Index           =   28
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   103
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Forest"
            Height          =   255
            Index           =   19
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   77
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Ghost House"
            Height          =   255
            Index           =   18
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   76
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Trees"
            Height          =   255
            Index           =   12
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   63
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Hills"
            Height          =   255
            Index           =   11
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   62
            Top             =   240
            Width           =   1215
         End
      End
      Begin VB.Frame Frame 
         Caption         =   "Music"
         Height          =   2415
         Index           =   13
         Left            =   4440
         TabIndex        =   59
         Top             =   240
         Width           =   2775
         Begin VB.OptionButton optMusic 
            Caption         =   "Boss"
            Height          =   255
            Index           =   51
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   179
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Water"
            Height          =   255
            Index           =   48
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   176
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Castle"
            Height          =   255
            Index           =   41
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   151
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Cave"
            Height          =   255
            Index           =   29
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   106
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Sky"
            Height          =   255
            Index           =   28
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   105
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Ghost House"
            Height          =   255
            Index           =   17
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   94
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Overworld"
            Height          =   255
            Index           =   10
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   60
            Top             =   240
            Width           =   1215
         End
      End
   End
   Begin VB.Frame Game 
      Caption         =   "Misc."
      Height          =   2775
      Index           =   3
      Left            =   4920
      TabIndex        =   50
      Top             =   3600
      Visible         =   0   'False
      Width           =   7215
      Begin VB.Frame Frame 
         Caption         =   "Backgrounds"
         Height          =   2415
         Index           =   11
         Left            =   120
         TabIndex        =   72
         Top             =   240
         Width           =   1455
         Begin VB.OptionButton optBackground 
            Caption         =   "Mother Brain"
            Height          =   255
            Index           =   47
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   160
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Transport"
            Height          =   255
            Index           =   46
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   159
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Brinstar"
            Height          =   255
            Index           =   45
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   157
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Mystic Cave Z."
            Height          =   255
            Index           =   40
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   148
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "None"
            Height          =   255
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   138
            Top             =   240
            Value           =   -1  'True
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Crateria"
            Height          =   255
            Index           =   16
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   73
            Top             =   600
            Width           =   1215
         End
      End
      Begin VB.Frame Frame 
         Caption         =   "Music"
         Height          =   2415
         Index           =   10
         Left            =   1680
         TabIndex        =   51
         Top             =   240
         Width           =   5415
         Begin VB.OptionButton optMusic 
            Caption         =   "M. Gorge"
            Height          =   255
            Index           =   56
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   187
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Fleet Glide"
            Height          =   255
            Index           =   55
            Left            =   4080
            Style           =   1  'Graphical
            TabIndex        =   184
            Top             =   1800
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Waluigi"
            Height          =   255
            Index           =   53
            Left            =   4080
            Style           =   1  'Graphical
            TabIndex        =   181
            Top             =   1440
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Underground"
            Height          =   255
            Index           =   52
            Left            =   4080
            Style           =   1  'Graphical
            TabIndex        =   180
            Top             =   1080
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Mother Brain"
            Height          =   255
            Index           =   45
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   161
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Item Room"
            Height          =   255
            Index           =   44
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   158
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Meta Knight"
            Height          =   255
            Index           =   40
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   149
            Top             =   1440
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Hyrule Temple"
            Height          =   255
            Index           =   39
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   145
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Yoshi's Village"
            Height          =   255
            Index           =   38
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   144
            Top             =   720
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Shiver Mnt"
            Height          =   255
            Index           =   37
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   143
            Top             =   1080
            Width           =   1215
         End
         Begin VB.TextBox txtMusic 
            Height          =   375
            Left            =   2760
            TabIndex        =   91
            Top             =   240
            Width           =   2535
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Custom"
            Height          =   255
            Index           =   24
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   90
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "None"
            Height          =   255
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   89
            Top             =   240
            Value           =   -1  'True
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Lost Woods"
            Height          =   255
            Index           =   23
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   88
            Top             =   1800
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Metroid Charge"
            Height          =   255
            Index           =   22
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   87
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Airship Theme"
            Height          =   255
            Index           =   19
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   82
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Beach Bowl"
            Height          =   255
            Index           =   18
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   80
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "New SMB"
            Height          =   255
            Index           =   13
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   69
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Crateria"
            Height          =   255
            Index           =   12
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   68
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Brinstar"
            Height          =   255
            Index           =   11
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   67
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Corneria"
            Height          =   255
            Index           =   8
            Left            =   4080
            Style           =   1  'Graphical
            TabIndex        =   52
            Top             =   720
            Width           =   1215
         End
      End
   End
   Begin VB.Frame Game 
      Caption         =   "Super Mario Bros."
      Height          =   2775
      Index           =   2
      Left            =   120
      TabIndex        =   37
      Top             =   8640
      Visible         =   0   'False
      Width           =   4575
      Begin VB.Frame Frame12 
         Caption         =   "Music"
         Height          =   1695
         Left            =   3000
         TabIndex        =   39
         Top             =   240
         Width           =   1455
         Begin VB.OptionButton optMusic 
            Caption         =   "Water"
            Height          =   255
            Index           =   46
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   173
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Castle"
            Height          =   255
            Index           =   42
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   154
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Overworld"
            Height          =   255
            Index           =   9
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   55
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Underground"
            Height          =   255
            Index           =   7
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   41
            Top             =   600
            Width           =   1215
         End
      End
      Begin VB.Frame Frame11 
         Caption         =   "Backgrounds"
         Height          =   2415
         Left            =   120
         TabIndex        =   38
         Top             =   240
         Width           =   2775
         Begin VB.OptionButton optBackground 
            Caption         =   "Desert"
            Height          =   255
            Index           =   51
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   165
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Mushrooms"
            Height          =   255
            Index           =   50
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   164
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Castle"
            Height          =   255
            Index           =   41
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   150
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Overworld"
            Height          =   255
            Index           =   10
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   56
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Night 2"
            Height          =   255
            Index           =   9
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   54
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Night"
            Height          =   255
            Index           =   8
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   49
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Underground"
            Height          =   255
            Index           =   7
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   48
            Top             =   600
            Width           =   1215
         End
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Section"
      Height          =   2775
      Index           =   2
      Left            =   1680
      TabIndex        =   29
      Top             =   720
      Width           =   1575
      Begin VB.OptionButton optSection 
         Caption         =   "21"
         Height          =   255
         Index           =   20
         Left            =   1080
         Style           =   1  'Graphical
         TabIndex        =   136
         Top             =   2400
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "20"
         Height          =   255
         Index           =   19
         Left            =   1080
         Style           =   1  'Graphical
         TabIndex        =   135
         Top             =   2040
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "19"
         Height          =   255
         Index           =   18
         Left            =   1080
         Style           =   1  'Graphical
         TabIndex        =   134
         Top             =   1680
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "18"
         Height          =   255
         Index           =   17
         Left            =   1080
         Style           =   1  'Graphical
         TabIndex        =   133
         Top             =   1320
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "17"
         Height          =   255
         Index           =   16
         Left            =   1080
         Style           =   1  'Graphical
         TabIndex        =   132
         Top             =   960
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "16"
         Height          =   255
         Index           =   15
         Left            =   1080
         Style           =   1  'Graphical
         TabIndex        =   131
         Top             =   600
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "15"
         Height          =   255
         Index           =   14
         Left            =   1080
         Style           =   1  'Graphical
         TabIndex        =   130
         Top             =   240
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "14"
         Height          =   255
         Index           =   13
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   129
         Top             =   2400
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "13"
         Height          =   255
         Index           =   12
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   128
         Top             =   2040
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "12"
         Height          =   255
         Index           =   11
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   127
         Top             =   1680
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "11"
         Height          =   255
         Index           =   10
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   126
         Top             =   1320
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "10"
         Height          =   255
         Index           =   9
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   125
         Top             =   960
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "9"
         Height          =   255
         Index           =   8
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   124
         Top             =   600
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "8"
         Height          =   255
         Index           =   7
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   123
         Top             =   240
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "7"
         Height          =   255
         Index           =   6
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   122
         Top             =   2400
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "6"
         Height          =   255
         Index           =   5
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   35
         Top             =   2040
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "5"
         Height          =   255
         Index           =   4
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   34
         Top             =   1680
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "1"
         Height          =   255
         Index           =   0
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   33
         Top             =   240
         Value           =   -1  'True
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "2"
         Height          =   255
         Index           =   1
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   32
         Top             =   600
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "3"
         Height          =   255
         Index           =   2
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   31
         Top             =   960
         Width           =   375
      End
      Begin VB.OptionButton optSection 
         Caption         =   "4"
         Height          =   255
         Index           =   3
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   30
         Top             =   1320
         Width           =   375
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Level Wrap"
      Height          =   615
      Index           =   4
      Left            =   3360
      TabIndex        =   27
      Top             =   720
      Width           =   1455
      Begin VB.CommandButton cmdWrap 
         Caption         =   "Off"
         Height          =   255
         Left            =   120
         TabIndex        =   28
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame Game 
      Caption         =   "Super Mario Brothers 2"
      Height          =   2775
      Index           =   1
      Left            =   4560
      TabIndex        =   23
      Top             =   6960
      Visible         =   0   'False
      Width           =   4575
      Begin VB.Frame Frame 
         Caption         =   "Backgrounds"
         Height          =   2415
         Index           =   14
         Left            =   120
         TabIndex        =   26
         Top             =   240
         Width           =   2775
         Begin VB.OptionButton optBackground 
            Caption         =   "Dungeon"
            Height          =   255
            Index           =   57
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   178
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Warehouse"
            Height          =   255
            Index           =   54
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   168
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Cliff"
            Height          =   255
            Index           =   53
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   167
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Night - Desert"
            Height          =   255
            Index           =   52
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   166
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Night - Hills"
            Height          =   255
            Index           =   49
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   163
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Clouds"
            Height          =   255
            Index           =   48
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   162
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Castle"
            Height          =   255
            Index           =   44
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   155
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Underground"
            Height          =   255
            Index           =   25
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   93
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Trees"
            Height          =   255
            Index           =   5
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   47
            Top             =   240
            Width           =   1215
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Music"
         Height          =   1695
         Left            =   3000
         TabIndex        =   24
         Top             =   240
         Width           =   1455
         Begin VB.OptionButton optMusic 
            Caption         =   "Wart"
            Height          =   255
            Index           =   43
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   156
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Underground"
            Height          =   255
            Index           =   25
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   92
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Boss"
            Height          =   255
            Index           =   15
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   75
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Overworld"
            Height          =   255
            Index           =   5
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   25
            Top             =   240
            Width           =   1215
         End
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Game Selection"
      Height          =   615
      Index           =   3
      Left            =   120
      TabIndex        =   17
      Top             =   0
      Width           =   12015
      Begin VB.OptionButton optGame 
         Caption         =   "Super Mario RPG"
         Height          =   255
         Index           =   6
         Left            =   6840
         Style           =   1  'Graphical
         TabIndex        =   108
         Top             =   240
         Width           =   1575
      End
      Begin VB.OptionButton optGame 
         Caption         =   "Super Mario 64"
         Height          =   255
         Index           =   5
         Left            =   8520
         Style           =   1  'Graphical
         TabIndex        =   95
         Top             =   240
         Width           =   1575
      End
      Begin VB.OptionButton optGame 
         Caption         =   "Super Mario World"
         Height          =   255
         Index           =   4
         Left            =   5160
         Style           =   1  'Graphical
         TabIndex        =   57
         Top             =   240
         Width           =   1575
      End
      Begin VB.OptionButton optGame 
         Caption         =   "Misc."
         Height          =   255
         Index           =   3
         Left            =   10200
         Style           =   1  'Graphical
         TabIndex        =   53
         Top             =   240
         Width           =   1575
      End
      Begin VB.OptionButton optGame 
         Caption         =   "Super Mario Bros."
         Height          =   255
         Index           =   2
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   36
         Top             =   240
         Width           =   1575
      End
      Begin VB.OptionButton optGame 
         Caption         =   "Super Mario Bros. 2"
         Height          =   255
         Index           =   1
         Left            =   1800
         Style           =   1  'Graphical
         TabIndex        =   22
         Top             =   240
         Width           =   1575
      End
      Begin VB.OptionButton optGame 
         Caption         =   "Super Mario Bros. 3"
         Height          =   255
         Index           =   0
         Left            =   3480
         Style           =   1  'Graphical
         TabIndex        =   18
         Top             =   240
         Value           =   -1  'True
         Width           =   1575
      End
   End
   Begin VB.Frame Game 
      Caption         =   "Super Mario Brothers 3"
      Height          =   2775
      Index           =   0
      Left            =   4920
      TabIndex        =   1
      Top             =   720
      Width           =   7215
      Begin VB.Frame Frame 
         Caption         =   "Music"
         Height          =   2535
         Index           =   8
         Left            =   5640
         TabIndex        =   14
         Top             =   120
         Width           =   1455
         Begin VB.OptionButton optMusic 
            Caption         =   "Hammer Bros"
            Height          =   255
            Index           =   54
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   182
            Top             =   2160
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Water"
            Height          =   255
            Index           =   47
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   174
            Top             =   1860
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Battle"
            Height          =   255
            Index           =   6
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   40
            Top             =   1560
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Underground"
            Height          =   255
            Index           =   4
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   20
            Top             =   900
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Castle"
            Height          =   255
            Index           =   3
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   19
            Top             =   1220
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Sky"
            Height          =   255
            Index           =   2
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   16
            Top             =   570
            Width           =   1215
         End
         Begin VB.OptionButton optMusic 
            Caption         =   "Overworld"
            Height          =   255
            Index           =   1
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   15
            Top             =   240
            Width           =   1215
         End
      End
      Begin VB.Frame Frame 
         Caption         =   "Backgrounds"
         Height          =   2415
         Index           =   7
         Left            =   120
         TabIndex        =   13
         Top             =   240
         Width           =   5415
         Begin VB.OptionButton optBackground 
            Caption         =   "Underwater"
            Height          =   255
            Index           =   56
            Left            =   4080
            Style           =   1  'Graphical
            TabIndex        =   172
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Cave 2"
            Height          =   255
            Index           =   39
            Left            =   4080
            Style           =   1  'Graphical
            TabIndex        =   147
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Cave"
            Height          =   255
            Index           =   38
            Left            =   4080
            Style           =   1  'Graphical
            TabIndex        =   146
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Snow Hills"
            Height          =   255
            Index           =   37
            Left            =   4080
            Style           =   1  'Graphical
            TabIndex        =   140
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Clouds 2"
            Height          =   255
            Index           =   36
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   139
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Snow Trees"
            Height          =   255
            Index           =   35
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   137
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Castle"
            Height          =   255
            Index           =   27
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   102
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Toad's House"
            Height          =   255
            Index           =   26
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   101
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Bowser"
            Height          =   255
            Index           =   24
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   86
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Tanks"
            Height          =   255
            Index           =   23
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   83
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Waterfall"
            Height          =   255
            Index           =   22
            Left            =   2760
            Style           =   1  'Graphical
            TabIndex        =   81
            Top             =   240
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Battle"
            Height          =   255
            Index           =   21
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   79
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Forest"
            Height          =   255
            Index           =   20
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   78
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Ship"
            Height          =   255
            Index           =   17
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   74
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Dungeon 2"
            Height          =   255
            Index           =   15
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   71
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Desert"
            Height          =   255
            Index           =   14
            Left            =   1440
            Style           =   1  'Graphical
            TabIndex        =   70
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Clouds"
            Height          =   255
            Index           =   13
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   64
            Top             =   2040
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Bonus"
            Height          =   255
            Index           =   6
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   46
            Top             =   1680
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Pipes"
            Height          =   255
            Index           =   4
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   45
            Top             =   1320
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Dungeon"
            Height          =   255
            Index           =   3
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   44
            Top             =   960
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Hills"
            Height          =   255
            Index           =   2
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   43
            Top             =   600
            Width           =   1215
         End
         Begin VB.OptionButton optBackground 
            Caption         =   "Blocks"
            Height          =   255
            Index           =   1
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   42
            Top             =   240
            Width           =   1215
         End
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Level Boundry"
      Height          =   1335
      Index           =   0
      Left            =   120
      TabIndex        =   8
      Top             =   720
      Width           =   1455
      Begin VB.OptionButton optLevel 
         Caption         =   "Bottom"
         Height          =   255
         Index           =   3
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   12
         Top             =   960
         Width           =   1215
      End
      Begin VB.OptionButton optLevel 
         Caption         =   "Right"
         Height          =   255
         Index           =   2
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   11
         Top             =   720
         Width           =   1215
      End
      Begin VB.OptionButton optLevel 
         Caption         =   "Left"
         Height          =   255
         Index           =   1
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   480
         Width           =   1215
      End
      Begin VB.OptionButton optLevel 
         Caption         =   "Top"
         Height          =   255
         Index           =   0
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   9
         Top             =   240
         Value           =   -1  'True
         Width           =   1215
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Start Locations"
      Height          =   855
      Index           =   1
      Left            =   120
      TabIndex        =   5
      Top             =   2160
      Width           =   1455
      Begin VB.OptionButton optLevel 
         Caption         =   "Player 1"
         Height          =   255
         Index           =   4
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   240
         Width           =   1215
      End
      Begin VB.OptionButton optLevel 
         Caption         =   "Player 2"
         Height          =   255
         Index           =   5
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   480
         Width           =   1215
      End
   End
   Begin VB.Frame Frame8 
      Caption         =   "BG Color"
      Height          =   1815
      Left            =   13560
      TabIndex        =   2
      Top             =   10080
      Visible         =   0   'False
      Width           =   1455
      Begin VB.OptionButton optBackgroundColor 
         BackColor       =   &H00A08850&
         Height          =   375
         Index           =   3
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   21
         Top             =   1200
         Width           =   1215
      End
      Begin VB.OptionButton optBackgroundColor 
         BackColor       =   &H00F89868&
         Height          =   375
         Index           =   2
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   720
         Width           =   1215
      End
      Begin VB.OptionButton optBackgroundColor 
         BackColor       =   &H00000000&
         Height          =   375
         Index           =   1
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   240
         Value           =   -1  'True
         Width           =   1215
      End
   End
End
Attribute VB_Name = "frmLevelSettings"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAdvanced_Click()
    On Error Resume Next
    frmLevelAdv.Top = frmLevelSettings.Top
    frmLevelAdv.Left = frmLevelSettings.Left
    frmLevelAdv.Show
    frmLevelAdv.RefreshFields
    frmLevelAdv.SetFocus
End Sub

Private Sub cmdExit_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If OffScreenExit(curSection) = True Then
        OffScreenExit(curSection) = False
        cmdExit.Caption = "Off"
    Else
        OffScreenExit(curSection) = True
        cmdExit.Caption = "On"
    End If
    If nPlay.Online = True Then Netplay.sendData Netplay.ModSection(curSection)
End Sub

Private Sub cmdNoTurnBack_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If NoTurnBack(curSection) = True Then
        NoTurnBack(curSection) = False
        cmdNoTurnBack.Caption = "Off"
    Else
        NoTurnBack(curSection) = True
        cmdNoTurnBack.Caption = "On"
    End If
    If nPlay.Online = True Then Netplay.sendData Netplay.ModSection(curSection)
End Sub

Private Sub cmdWater_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If UnderWater(curSection) = True Then
        UnderWater(curSection) = False
        cmdWater.Caption = "Off"
    Else
        UnderWater(curSection) = True
        cmdWater.Caption = "On"
    End If
    If nPlay.Online = True Then Netplay.sendData Netplay.ModSection(curSection)
End Sub

Private Sub cmdWrap_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If LevelWrap(curSection) = True Then
        LevelWrap(curSection) = False
        cmdWrap.Caption = "Off"
    Else
        LevelWrap(curSection) = True
        cmdWrap.Caption = "On"
    End If
    If nPlay.Online = True Then Netplay.sendData Netplay.ModSection(curSection)
End Sub

Private Sub Form_Load()
    Dim A As Integer
    For A = 0 To Game.Count - 1
        Game(A).Top = Game(0).Top
        Game(A).Left = Game(0).Left
    Next A
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    frmLevelEditor.optCursor(13).Value = True
End Sub

Private Sub optBackground_Click(Index As Integer)
    Dim A As Integer
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    For A = 0 To optBackground.Count - 1
        If A <> Index Then optBackground(A).Value = False
    Next A
    Background2(curSection) = Index
    If noUpdate = False Then Netplay.sendData "i" & curSection & "|" & Index
End Sub

Private Sub optBackgroundColor_Click(Index As Integer)
    bgColor(curSection) = optBackgroundColor(Index).BackColor
    GFX.BackgroundColor(1).BackColor = bgColor(curSection)
End Sub

Private Sub optGame_Click(Index As Integer)
    Dim A As Integer
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    For A = 0 To Game.Count - 1
        If A = Index Then
            Game(A).Visible = True
        Else
            Game(A).Visible = False
        End If
    Next A
End Sub

Private Sub optLevel_Click(Index As Integer)
    Dim A As Integer
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    For A = 0 To optLevel.Count - 1
        If A <> Index Then optLevel(A).Value = False
    Next A
End Sub

Private Sub optMusic_Click(Index As Integer)
    Dim A As Integer
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    For A = 0 To optMusic.Count - 1
        If A <> Index Then optMusic(A).Value = False
    Next A
    If curMusic <> -1 Then
        StopMusic
        bgMusic(curSection) = Index
        StartMusic curSection
    End If
    If noUpdate = False Then Netplay.sendData "h" & curSection & "|" & Index
End Sub

Private Sub optSection_Click(Index As Integer)
    Dim A As Integer
    txtMusic.Enabled = False
    txtMusic.Text = CustomMusic(Index)
    txtMusic.Enabled = True
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If bgMusic(curSection) <> bgMusic(Index) Then
        StopMusic
        StartMusic Index
    ElseIf bgMusic(curSection) = 24 Then
        If CustomMusic(curSection) <> CustomMusic(Index) Then
            StopMusic
            StartMusic Index
        End If
    End If
    If bgColor(curSection) <> bgColor(Index) Then
        GFX.BackgroundColor(1).BackColor = bgColor(Index)
    End If
    curSection = Index
    optMusic(bgMusic(Index)).Value = True
    For A = 1 To optBackgroundColor.Count
        If optBackgroundColor(A).BackColor = bgColor(curSection) Then
            optBackgroundColor(A).Value = True
            Exit For
        End If
    Next A
    For A = 0 To frmLevelSettings.optBackground.Count - 1
        If Background2(curSection) = A Then
            frmLevelSettings.optBackground(A).Value = True
        Else
            frmLevelSettings.optBackground(A).Value = False
        End If
    Next A
    If LevelWrap(curSection) = True Then
        cmdWrap.Caption = "On"
    Else
        cmdWrap.Caption = "Off"
    End If
    If NoTurnBack(curSection) = True Then
        cmdNoTurnBack.Caption = "On"
    Else
        cmdNoTurnBack.Caption = "Off"
    End If
    If UnderWater(curSection) = True Then
        cmdWater.Caption = "On"
    Else
        cmdWater.Caption = "Off"
    End If
    
    If OffScreenExit(curSection) = True Then
        cmdExit.Caption = "On"
    Else
        cmdExit.Caption = "Off"
    End If
    If level(curSection).Y <> level(curSection).Height Then
        vScreenX(1) = -level(curSection).X
        vScreenY(1) = -(level(curSection).Height - 600)
    Else
        level(curSection).Height = 20000 * (curSection - maxSections / 2)
        level(curSection).Height = Int(level(curSection).Height / 32) * 32
        level(curSection).Y = level(curSection).Height - 600
        level(curSection).X = 20000 * (curSection - maxSections / 2)
        level(curSection).X = Int(level(curSection).X / 32) * 32
        level(curSection).Width = level(curSection).X + 800
        vScreenY(1) = -(level(curSection).Height - 600)
        vScreenX(1) = -level(curSection).X
    End If
End Sub

Private Sub txtMusic_Change()
    If txtMusic.Enabled = True Then
        optMusic(0).Value = True
        DoEvents
        txtMusic.SetFocus
        CustomMusic(curSection) = txtMusic.Text
    End If
End Sub
