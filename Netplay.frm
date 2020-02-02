VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "mswinsck.ocx"
Begin VB.Form Netplay 
   BorderStyle     =   0  'None
   Caption         =   "NetPlay"
   ClientHeight    =   7665
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   8490
   LinkTopic       =   "Form1"
   ScaleHeight     =   7665
   ScaleWidth      =   8490
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Visible         =   0   'False
   Begin VB.Timer tmrTimeoutC 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   3840
      Top             =   1560
   End
   Begin VB.Timer tmrPingC 
      Enabled         =   0   'False
      Interval        =   10000
      Left            =   1440
      Top             =   4080
   End
   Begin VB.Timer tmrConnect 
      Enabled         =   0   'False
      Interval        =   10000
      Left            =   6240
      Top             =   840
   End
   Begin VB.Timer tmrCheckPorts 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   120
      Top             =   1320
   End
   Begin VB.Timer tmrPing 
      Enabled         =   0   'False
      Interval        =   30000
      Left            =   1440
      Top             =   3480
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   16
      Interval        =   60000
      Left            =   5040
      Top             =   5040
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   15
      Interval        =   60000
      Left            =   4560
      Top             =   5040
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   14
      Interval        =   60000
      Left            =   4080
      Top             =   5040
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   13
      Interval        =   60000
      Left            =   3600
      Top             =   5040
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   12
      Interval        =   60000
      Left            =   4560
      Top             =   4560
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   11
      Interval        =   60000
      Left            =   5040
      Top             =   4560
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   10
      Interval        =   60000
      Left            =   4080
      Top             =   4560
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   9
      Interval        =   60000
      Left            =   3600
      Top             =   4560
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   8
      Interval        =   60000
      Left            =   5040
      Top             =   4080
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   7
      Interval        =   60000
      Left            =   4560
      Top             =   4080
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   6
      Interval        =   60000
      Left            =   4080
      Top             =   4080
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   5
      Interval        =   60000
      Left            =   3600
      Top             =   4080
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   4
      Interval        =   60000
      Left            =   4560
      Top             =   3600
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   3
      Interval        =   60000
      Left            =   5040
      Top             =   3600
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   2
      Interval        =   60000
      Left            =   4080
      Top             =   3600
   End
   Begin VB.Timer tmrTimeout 
      Enabled         =   0   'False
      Index           =   1
      Interval        =   60000
      Left            =   3600
      Top             =   3600
   End
   Begin VB.Timer tmrPort 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   120
      Top             =   720
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   0
      Left            =   1560
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nClient 
      Left            =   120
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   1
      Left            =   1560
      Top             =   600
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   2
      Left            =   1560
      Top             =   1080
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   3
      Left            =   2040
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   4
      Left            =   2040
      Top             =   600
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   5
      Left            =   2040
      Top             =   1080
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   6
      Left            =   3000
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   7
      Left            =   3000
      Top             =   600
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   8
      Left            =   3000
      Top             =   1080
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   9
      Left            =   2520
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   10
      Left            =   2520
      Top             =   600
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   11
      Left            =   2520
      Top             =   1080
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   12
      Left            =   1560
      Top             =   1560
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   13
      Left            =   2040
      Top             =   1560
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   14
      Left            =   3000
      Top             =   1560
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock nServer 
      Index           =   15
      Left            =   2520
      Top             =   1560
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
End
Attribute VB_Name = "Netplay"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'this handles all the online code

Option Explicit
Const SOCKET_ERROR = -1 ' Error returned by Winsock API.
Const SOL_SOCKET = 65535      ' Options for socket level.
Const IPPROTO_TCP = 6         ' Protocol constant for TCP.
Const SO_DEBUG = &H1&         ' Turn on debugging info recording
Const SO_ACCEPTCONN = &H2&    ' Socket has had listen() - READ-ONLY.
Const SO_REUSEADDR = &H4&     ' Allow local address reuse.
Const SO_KEEPALIVE = &H8&     ' Keep connections alive.
Const SO_DONTROUTE = &H10&    ' Just use interface addresses.
Const SO_BROADCAST = &H20&    ' Permit sending of broadcast msgs.
Const SO_USELOOPBACK = &H40&  ' Bypass hardware when possible.
Const SO_LINGER = &H80&       ' Linger on close if data present.
Const SO_OOBINLINE = &H100&   ' Leave received OOB data in line.
Const SO_DONTLINGER = Not SO_LINGER
Const SO_EXCLUSIVEADDRUSE = Not SO_REUSEADDR ' Disallow local address reuse.
Const SO_SNDBUF = &H1001&     ' Send buffer size.
Const SO_RCVBUF = &H1002&     ' Receive buffer size.
Const SO_ERROR = &H1007&      ' Get error status and clear.
Const SO_TYPE = &H1008&       ' Get socket type - READ-ONLY.
Const TCP_NODELAY = &H1&      ' Turn off Nagel Algorithm.
Private Type LINGER_STRUCT
  l_onoff As Integer          ' Is linger on or off?
  l_linger As Integer         ' Linger timeout in seconds.
End Type
Private Declare Function setsockopt Lib "wsock32.dll" (ByVal S As Long, ByVal level As Long, ByVal optname As Long, optval As Any, ByVal optlen As Long) As Long
Private Declare Function getsockopt Lib "wsock32.dll" (ByVal S As Long, ByVal level As Long, ByVal optname As Long, optval As Any, optlen As Long) As Long


'1 - player stuff
'2 - NPC stuff
'3 - block stuff
'a - version
'b - nick
'c - recieve chat from clients
'd - send chat to clients
'e - update player list
'f - editor cursor position
'g - update section size
'h - update section music
'i - update section background
'j - clear level
'k - add block
'l - request initsync
'm - erase block
'n - set screen position
'o - player slot
'p - play sound
'q - add background
'r - erase background
's - sort backgrounds
't - add npc
'u - erase npc
'v - set player start
'w - loading screen
'x - add water
'y - remove water
'z - section settings
'A - add warp
'B - erase warp
'C - change layers
'D - change events
'E - password
'F - level erase toggle
'G - numblock, numnpcs, numbackgrounds
'H - test level
'I - player controls
'J - player loc
'K - npc update from server
'L - npcs timeleft = 1
'M - drop heldbonus
'N - serverload
'O - numplayers
'7 - redigit

Private Sub nClient_Close()
    frmChat.txtChat = frmChat.txtChat & "You have disconnected." & LB
    frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
    PlaySound 47
    SoundPause(47) = 2
    DropServer
End Sub

Private Sub nClient_Connect()
    tmrTimeoutC.Enabled = True
    frmNetplay.frMode.Enabled = False
    tmrConnect.Enabled = False
    noUpdate = True
    ClearLevel
    noUpdate = False
    frmLevelEditor.Enabled = False
    frmLoading.Show
    nPlay.ServerLoad = True
    frmLoading.curLoad.Width = 0
    frmLoading.curLoad.Left = 0
    If ClientPassword <> "" Then
        nClient.sendData "E" & ClientPassword & LB & "a" & curRelease & LB & "b" & LocalNick & "|" & LocalCursor & LB & "l" & LB & EoT
    Else
        nClient.sendData "a" & curRelease & LB & "b" & LocalNick & "|" & LocalCursor & LB & "l" & LB & EoT
    End If
    nPlay.ServerCon = True
    nPlay.Online = True
    nPlay.ServerIP = nClient.RemoteHostIP
    tmrPing.Enabled = True
    vScreenX(1) = 10000
    vScreenY(1) = -10000
    setsockopt nClient.SocketHandle, IPPROTO_TCP, TCP_NODELAY, 1, 4
End Sub

Private Sub nClient_DataArrival(ByVal bytesTotal As Long)
    Dim newStr As String
    Dim tempStr As String
    Dim workStr As String
    Dim A As Double
    Dim B As Double
    Dim Z As Double
    Dim loopCount As Integer
    tmrTimeoutC.Enabled = False
    tmrTimeoutC.Enabled = True
    nClient.GetData tempStr
    nPlay.ServerStr = nPlay.ServerStr & tempStr
    If nPlay.ServerLoad = False Then
        If LenB(nPlay.ServerStr) > 2000000 Then
            sendData "l" & LB
            frmLevelEditor.Enabled = False
            frmLoading.Show
            frmLoading.curLoad.Width = 0
            nPlay.ServerLoad = True
            vScreenX(1) = 10000
            vScreenY(1) = -10000
        End If
    End If
    If nPlay.ServerLocked = True Then Exit Sub
    nPlay.ServerLocked = True
cCheck:
    A = 0
    A = InStrRev(nPlay.ServerStr, LB, , vbBinaryCompare)
    If A > 0 Then
        workStr = Left$(nPlay.ServerStr, A + 1)
        nPlay.ServerStr = Mid$(nPlay.ServerStr, A + 2)
        Z = 1
        Do
            A = InStr(Z, workStr, LB, vbBinaryCompare)
            If A = 0 Then Exit Do
            newStr = Mid$(workStr, Z, A - Z)
            If (newStr) <> "" Then
                Do While AscW(newStr) = 10 Or AscW(newStr) = 13
                    newStr = Right$(newStr, Len(newStr) - 1)
                Loop
                newData Mid$(newStr, 2, Len(newStr)), Left$(newStr, 1), 0
            End If
            Z = A + 2
            loopCount = loopCount + 1
            If loopCount >= 10 Then
                loopCount = 0
                If nPlay.ServerLoad1 > 0 Then
                    frmLoading.curLoad.Left = 0
                    frmLoading.curLoad.Top = 0
                    frmLoading.curLoad.Height = frmLoading.maxLoad.Height
                    frmLoading.curLoad.Width = frmLoading.maxLoad.Width * (numBlock + numBackground + numNPCs) / nPlay.ServerLoad1
                End If
                DoEvents
            End If
        Loop Until A >= Len(workStr) Or nPlay.ServerCon = False
        If Len(nPlay.ServerStr) > 0 Then
            DoEvents
            GoTo cCheck
        End If
    End If
    nPlay.ServerLocked = False
End Sub

Private Sub nServer_Close(Index As Integer)
    nPlay.ClientCon(Index) = False
    If nPlay.ClientName(Index) = "" Then nPlay.ClientName(Index) = nPlay.ClientIP(Index)
    Netplay.sendData "d" & nPlay.ClientName(Index) & " has disconnected." & LB
    frmChat.txtChat = frmChat.txtChat & nPlay.ClientName(Index) & " has disconnected." & LB
    frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
    PlaySound 47
    SoundPause(47) = 2
    DropClient Index
End Sub

Private Sub nServer_ConnectionRequest(Index As Integer, ByVal requestID As Long)
    Dim tempStr As String
    Dim A As Integer
    tmrTimeout(Index).Enabled = True
    If nServer(Index).State <> sckClosed Then nServer(Index).Close
    nServer(Index).Accept requestID
    nPlay.Online = True
    nPlay.ClientCon(Index) = True
    If tmrPingC.Enabled = False Then tmrPingC.Enabled = True
    tmrPort.Enabled = False
    For A = 1 To 15
        If A <> Index Then
            If nServer(A).State = sckClosed Then
                nServer(A).LocalPort = nServer(Index).LocalPort
                nServer(A).Listen
                Exit For
            End If
        End If
    Next A
    nPlay.ClientIP(Index) = nServer(Index).RemoteHostIP
    nPlay.ClientName(Index) = ""
    nPlay.ClientPassword(Index) = False
    frmLevelEditor.menuTestLevel.Enabled = True
    setsockopt nServer(Index).SocketHandle, IPPROTO_TCP, TCP_NODELAY, 1, 4
End Sub

Private Sub nServer_DataArrival(Index As Integer, ByVal bytesTotal As Long)
    On Error Resume Next
    Dim newStr As String
    Dim tempStr As String
    Dim workStr As String
    Dim A As Double
    Dim B As Double
    Dim Z As Double
    Dim tempBool As Boolean
    Dim loopCount As Integer
    tmrTimeout(Index).Enabled = False
    tmrTimeout(Index).Enabled = True
    nServer(Index).GetData tempStr
    nPlay.ClientStr(Index) = nPlay.ClientStr(Index) & tempStr
    If nPlay.ClientLocked(Index) = True Then Exit Sub
    nPlay.ClientLocked(Index) = True
sCheck:
    A = 0
    A = InStrRev(nPlay.ClientStr(Index), LB, , vbBinaryCompare)
    If A > 0 Then
        workStr = Left$(nPlay.ClientStr(Index), A + 1)
        nPlay.ClientStr(Index) = Mid$(nPlay.ClientStr(Index), A + 2)
        Z = 1
        Do
            A = InStr(Z, workStr, LB, vbBinaryCompare)
            If A = 0 Then Exit Do
            newStr = Mid$(workStr, Z, A - Z)
            If (newStr) <> "" Then
                Do While AscW(newStr) = 10 Or AscW(newStr) = 13
                    newStr = Right$(newStr, Len(newStr) - 1)
                Loop
                newData Mid$(newStr, 2, Len(newStr)), Left$(newStr, 1), Index
            End If
            Z = A + 2
            loopCount = loopCount + 1
            If loopCount >= 200 Then
                DoEvents
            End If
        Loop Until A >= Len(workStr) Or nPlay.ClientCon(Index) = False
        If Len(nPlay.ClientStr(Index)) > 0 Then
            DoEvents
            GoTo sCheck
        End If
    End If
    nPlay.ClientLocked(Index) = False
End Sub

Public Sub newData(newStr As String, Action As String, Index As Integer)
    On Error Resume Next
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim Z As Integer
    Dim tempStr As String
    Dim tempBool As Boolean
    Dim tempBlock As Block
    Dim tempNPC As NPC
    Dim lenStr As Integer
    Dim tempBackground As Background
    If ServerPassword <> "" And nPlay.ClientPassword(Index) = False And Action <> "E" And nPlay.Mode = 1 Then
        Netplay.nServer(Index).sendData "dYou need the correct password to connect to this server." & LB & EoT
        DoEvents
        DropClient Index
        frmChat.txtChat.Text = frmChat.txtChat.Text & nServer(Index).RemoteHostIP & " tried to connect with the wrong password" & LB
        frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
        PlaySound 47
        SoundPause(47) = 2
        Exit Sub
    Else
        nPlay.ClientPassword(Index) = True
    End If
    If Action = "1" Then 'player stuff
        ModPlayer newStr
        If nPlay.Mode = 1 Then
            sendData Action & newStr, Index
        End If
    ElseIf Action = "2" Then 'NPC stuff
        ModNPC newStr
        If nPlay.Mode = 1 Then
            sendData Action & newStr, Index
        End If
    ElseIf Action = "3" Then 'block stuff
        ModNPC newStr
        If nPlay.Mode = 1 Then
            sendData Action & newStr, Index
        End If
    ElseIf Action = "a" Then 'get version
        nPlay.ClientRelease(Index) = Int(Val(newStr))
        If nPlay.ClientRelease(Index) <> curRelease Then
            Netplay.nServer(Index).sendData "dYou are using build " & nPlay.ClientRelease(Index) & " and you need build " & curRelease & " to connect to this server." & LB & EoT
            DoEvents
            nPlay.ClientCon(Index) = False
            tmrTimeout(Index).Enabled = False
            nPlay.ClientCon(Index) = False
            nPlay.ClientName(Index) = ""
            nPlay.ClientIP(Index) = ""
            nPlay.ClientStr(Index) = ""
            nServer(Index).Close
            For A = 1 To 15
                If nPlay.ClientCon(A) = True Then
                    tempBool = True
                    Exit For
                End If
            Next A
            If tempBool = False Then
                nPlay.Online = False
                frmNetplay.frMode.Enabled = True
                If TestLevel = True Then EndLevel = True
            End If
            tmrPort.Enabled = True
            frmChat.txtChat.Text = frmChat.txtChat.Text & nServer(Index).RemoteHostIP & " tried to connect with an older build." & LB
            frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
            PlaySound 47
            SoundPause(47) = 2
        End If
    ElseIf Action = "b" Then 'get nickname
        If nPlay.ClientCon(Index) = True Then
            tempStr = newStr
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            nPlay.ClientName(Index) = Left(tempStr, A - 1)
            nPlay.Player(Index).Nick = Left(tempStr, A - 1)
            nPlay.Player(Index).Active = True
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            nPlay.Player(Index).Cursor = Val(Left(tempStr, A - 1))
            If nPlay.Mode = 1 Then ' broadcast users
                frmChat.lstUsers.Clear
                frmChat.lstUsers.AddItem LocalNick
                tempStr = "0" & "|" & LocalNick & "|" & nPlay.Player(0).Cursor & "|"
                For A = 0 To 15
                    If nPlay.ClientCon(A) = True Then
                        frmChat.lstUsers.AddItem nPlay.ClientName(A)
                        tempStr = tempStr & A & "|" & nPlay.ClientName(A) & "|" & nPlay.Player(A).Cursor & "|"
                    End If
                Next A
                For A = 0 To 15
                    If nPlay.ClientCon(A) = True Then nServer(A).sendData "e" & tempStr & LB & EoT
                Next A
            End If
            Netplay.sendData "d" & nPlay.ClientName(Index) & " has connected." & LB
            frmChat.txtChat = frmChat.txtChat & nPlay.ClientName(Index) & " has connected." & LB
            frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
        End If
    ElseIf Action = "c" Then 'send chat messages from server
        If nPlay.Mode = 1 Then
            frmChat.txtChat = frmChat.txtChat & "<" & nPlay.ClientName(Index) & "> " & newStr & LB
            frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
            PlaySound 47
            SoundPause(47) = 2
            For A = 0 To 15
                If nPlay.ClientCon(A) = True Then
                    Netplay.nServer(A).sendData "d<" & nPlay.ClientName(Index) & "> " & newStr & LB & EoT
                End If
            Next A
        End If
    ElseIf Action = "d" Then 'recieve chat message
        PlaySound 47
        SoundPause(47) = 2
        frmChat.txtChat = frmChat.txtChat & newStr & LB
        frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
    ElseIf Action = "e" Then 'recieve who is connected
        tempStr = newStr
        frmChat.lstUsers.Clear
        For A = 0 To 15
            nPlay.Player(A).Active = False
            nPlay.Player(A).Nick = ""
        Next A
        Do
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            B = Val(Left(tempStr, A - 1))
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            frmChat.lstUsers.AddItem Left(tempStr, A - 1)
            nPlay.Player(B).Active = True
            nPlay.Player(B).Nick = Left(tempStr, A - 1)
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            nPlay.Player(B).Cursor = Val(Left(tempStr, A - 1))
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
        Loop Until tempStr = "" Or tempStr = "|"
    ElseIf Action = "f" Then 'recieve editor cursor position
        tempStr = newStr
        If nPlay.Mode = 0 Then
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            B = Val(Left(tempStr, A - 1))
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
        Else
            B = Index
        End If
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        nPlay.Player(B).ECurserX = Val(Left(tempStr, A - 1))
        nPlay.Player(B).ECurserY = Val(Mid(tempStr, A + 1, Len(tempStr)))
        If nPlay.Mode = 1 Then
            sendData Action & Index & "|" & newStr & LB, Index
        End If
    ElseIf Action = "g" Then 'update section size
        tempStr = newStr
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        B = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        level(B).X = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        level(B).Y = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        level(B).Width = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        level(B).Height = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        If nPlay.Mode = 1 Then
            sendData Action & newStr, Index
        End If
    ElseIf Action = "h" Then 'update section music
        tempStr = newStr
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        B = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        bgMusic(B) = Val(Left(tempStr, A - 1))
        If LevelEditor = True Or MagicHand = True Then
            If curSection = B Then
                noUpdate = True
                frmLevelSettings.optMusic(Val(Left(tempStr, A - 1))).Value = True
                noUpdate = False
            End If
        End If
        If nPlay.Mode = 1 Then
            sendData Action & newStr, Index
        End If
    ElseIf Action = "i" Then 'update section background
        tempStr = newStr
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        B = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Background2(B) = Val(Left(tempStr, A - 1))
        If LevelEditor = True Or MagicHand = True Then
            If curSection = B Then
                noUpdate = True
                frmLevelSettings.optBackground(Val(Left(tempStr, A - 1))).Value = True
                noUpdate = False
            End If
        End If
        If nPlay.Mode = 1 Then
            sendData Action & newStr, Index
        End If
    ElseIf Action = "j" Then 'clear the level
        If nPlay.Mode = 1 Then
            If ServerClear = True Or nPlay.ClientName(Index) = "Redigit" Then
                sendData "j" & LB & "d" & nPlay.Player(Index).Nick & " cleared the level." & LB, Index
                frmChat.txtChat = frmChat.txtChat & nPlay.ClientName(Index) & " cleared the level." & LB
                frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
                PlaySound 47
                SoundPause(47) = 2
            End If
        End If
        noUpdate = True
        ClearLevel
        noUpdate = False
    ElseIf Action = "k" Then 'add block
        Z = 1
        lenStr = Len(newStr)
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        B = Mid$(newStr, Z, A - Z)
        If B > numBlock Then
            If B > numBlock + 1 Then
                Netplay.sendData "G0|" & numBlock & LB
            End If
            numBlock = B
        ElseIf nPlay.Mode = 1 Then
            numBlock = numBlock + 1
            C = B
            B = numBlock
            tempBool = True
        End If
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).Type = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).Location.X = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).Location.Y = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).Location.Width = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).Location.Height = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).Special = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).Invis = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).Layer = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).Hidden = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).TriggerDeath = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Block(B).TriggerHit = Mid$(newStr, Z, A - Z)
        Z = A + 1
        Block(B).TriggerLast = Mid$(newStr, Z)
        If BlockIsSizable(Block(B).Type) Then FindSBlocks
        If tempBool = True Then
            sendData AddBlock(B) & AddBlock(C)
        ElseIf nPlay.Mode = 1 Then
            sendData Action & newStr & LB, Index
        End If
        If MagicHand = True And nPlay.ServerLoad1 = False Then
            For A = -FLBlocks To FLBlocks
                FirstBlock(A) = 1
                LastBlock(A) = numBlock
            Next A
            BlocksSorted = False
        End If
    ElseIf Action = "l" Then 'request initsync
        InitSync Index
    ElseIf Action = "m" Then  'erase block
        Z = 2
        lenStr = Len(newStr)
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        B = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempBlock.Type = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempBlock.Location.X = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempBlock.Location.Y = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempBlock.Location.Width = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempBlock.Location.Height = Mid$(newStr, Z, A - Z)
        Z = A + 1
        If nPlay.Mode = 0 Then
            A = InStr(Z, newStr, "|", vbBinaryCompare)
            tempBlock.Layer = Mid$(newStr, Z, A - Z)
            Z = A + 1
            C = Mid$(newStr, Z)
        Else
            tempBlock.Layer = Mid$(newStr, Z)
        End If
        If Block(B).Type = tempBlock.Type And Block(B).Location.X = tempBlock.Location.X And Block(B).Location.Y = tempBlock.Location.Y And Block(B).Location.Width = tempBlock.Location.Width And Block(B).Location.Height = tempBlock.Location.Height And Block(B).Layer = tempBlock.Layer Then
            If nPlay.Mode = 0 Then
                numBlock = C
            Else
                sendData AddBlock(numBlock - 1) & EraseBlock(B, Left(newStr, 1)), Index
            End If
            If Left(newStr, 1) = "0" Then
                KillBlock Val(Mid(newStr, 2, Len(newStr)))
                FindSBlocks
            Else
                KillBlock Val(Mid(newStr, 2, Len(newStr))), False
                FindSBlocks
            End If
            If nPlay.Mode = 1 Then
                nServer(Index).sendData AddBlock(B) & AddBlock(numBlock) & SyncNum & EoT
            End If
        ElseIf nPlay.Mode = 0 Then
            Netplay.sendData "G0|" & B & LB
        Else
            tempStr = ""
            For A = B - 10 To B + 10
                If A > 0 And A <= numBlock Then tempStr = tempStr & AddBlock(A)
            Next A
            For A = numBlock - 20 To numBlock
                If A > 0 And A <= numBlock Then tempStr = tempStr & AddBlock(A)
            Next A
            tempStr = tempStr & SyncNum
            If tempStr <> "" Then nServer(Index).sendData tempStr & LB & EoT
        End If
    ElseIf Action = "n" Then 'set screen position
        tempStr = newStr
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        B = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        If B = "0" Then
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            curSection = Val(Left(tempStr, A - 1))
            If LevelEditor = True Then frmLevelSettings.optSection(curSection).Value = True
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            vScreenX(1) = Val(Left(tempStr, A - 1))
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            vScreenY(1) = Val(Left(tempStr, A - 1))
        ElseIf nPlay.Mode = 1 Then
            If nPlay.ClientCon(B) = True Then
                nServer(B).sendData Action & B & tempStr
            End If
        End If
    ElseIf Action = "o" Then 'get player slot
        For A = 0 To 15
            nPlay.Player(A).IsMe = False
            If A = Val(newStr) Then nPlay.Player(A).IsMe = True
        Next A
        nPlay.MySlot = newStr
    ElseIf Action = "p" Then 'play sound
        PlaySound Val(newStr)
        If nPlay.Mode = 1 Then
            sendData Action & newStr, Index
        End If
    ElseIf Action = "q" Then 'add background
        Z = 1
        lenStr = Len(newStr)
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        B = Mid$(newStr, Z, A - Z)
        If B > numBackground Then
            If B > numBackground + 1 Then
                Netplay.sendData "G1|" & numBackground & LB
            End If
            numBackground = B
        ElseIf nPlay.Mode = 1 Then
            numBackground = numBackground + 1
            C = B
            B = numBackground
            tempBool = True
        End If
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Background(B).Type = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Background(B).Location.X = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Background(B).Location.Y = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Background(B).Layer = Mid$(newStr, Z, A - Z)
        Z = A + 1
        Background(B).Hidden = Mid$(newStr, Z)
        Background(B).Location.Width = BackgroundWidth(Background(B).Type)
        Background(B).Location.Height = BackgroundHeight(Background(B).Type)
        If tempBool = True Then
            sendData AddBackground(B) & AddBackground(C)
        ElseIf nPlay.Mode = 1 Then
            sendData Action & newStr & LB, Index
        End If
    ElseIf Action = "r" Then 'erase background
        Z = 1
        lenStr = Len(newStr)
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        B = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempBackground.Type = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempBackground.Location.X = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempBackground.Location.Y = Mid$(newStr, Z, A - Z)
        Z = A + 1
        If nPlay.Mode = 0 Then
            A = InStr(Z, newStr, "|", vbBinaryCompare)
            tempBackground.Layer = Mid$(newStr, Z, A - Z)
            Z = A + 1
            A = InStr(Z, newStr, "|", vbBinaryCompare)
            C = Mid$(newStr, Z)
        Else
            tempBackground.Layer = Mid$(newStr, Z)
        End If
        If Background(B).Type = tempBackground.Type And Background(B).Location.X = tempBackground.Location.X And Background(B).Location.Y = tempBackground.Location.Y And Background(B).Layer = tempBackground.Layer Then
            If nPlay.Mode = 0 Then
                numBackground = C
            Else
                sendData AddBackground(numBackground) & EraseBackground(B, Left(newStr, 1)), Index
            End If
            If Left(newStr, 1) = "0" Then
                NewEffect 10, Background(B).Location
                PlaySound 36
                Background(B) = Background(numBackground)
                numBackground = numBackground - 1
            Else
                Background(B) = Background(numBackground)
                numBackground = numBackground - 1
            End If
            If nPlay.Mode = 1 Then
                nServer(Index).sendData AddBackground(B) & AddBackground(numBackground) & SyncNum & EoT
            End If
        ElseIf nPlay.Mode = 0 Then
            Netplay.sendData "G1|" & B & LB
        Else
            tempStr = ""
            For A = B - 10 To B + 10
                If A > 0 And A <= numBackground Then tempStr = tempStr & AddBackground(A)
            Next A
            For A = numBackground - 20 To numBackground
                If A > 0 And A <= numBackground Then tempStr = tempStr & AddBackground(A)
            Next A
            tempStr = tempStr & SyncNum
            If tempStr <> "" Then nServer(Index).sendData tempStr & LB & EoT
        End If
    ElseIf Action = "s" Then 'sort backgrounds
        numBackground = newStr
        noUpdate = True
        UpdateBackgrounds
        noUpdate = False
        If nPlay.Mode = 1 Then
            sendData Action & newStr & LB
        End If
    ElseIf Action = "t" Then 'add npc
        Z = 1
        lenStr = Len(newStr)
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        B = Mid$(newStr, Z, A - Z)
        If B > numNPCs Then
            If B > numNPCs + 1 Then
                Netplay.sendData "G2|" & numNPCs & LB
            End If
            numNPCs = B
        ElseIf nPlay.Mode = 1 Then
            numNPCs = numNPCs + 1
            C = B
            B = numNPCs
            tempBool = True
        End If
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Type = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.X = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.Y = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.Width = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.Height = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Layer = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Hidden = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Direction = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Special = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Special2 = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Inert = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Stuck = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Generator = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).GeneratorDirection = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).GeneratorEffect = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).GeneratorTimeMax = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Legacy = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Text = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).TriggerActivate = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).TriggerDeath = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).TriggerLast = Mid$(newStr, Z, A - Z)
        Z = A + 1
        NPC(B).TriggerTalk = Mid$(newStr, Z)
        NPC(B).Active = True
        NPC(B).TimeLeft = 100
        NPC(B).DefaultDirection = NPC(B).Direction
        NPC(B).DefaultLocation.X = NPC(B).Location.X
        NPC(B).DefaultLocation.Y = NPC(B).Location.Y
        NPC(B).DefaultStuck = NPC(B).Stuck
        NPC(B).DefaultSpecial = NPC(B).Special
        NPC(B).DefaultType = NPC(B).Type
        If tempBool = True Then
            sendData AddNPC(B) & AddNPC(C)
        ElseIf nPlay.Mode = 1 Then
            sendData Action & newStr & LB, Index
        End If
    ElseIf Action = "u" Then 'erase npc
        Z = 1
        lenStr = Len(newStr)
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        B = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempNPC.Type = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempNPC.Location.X = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        tempNPC.Location.Y = Mid$(newStr, Z, A - Z)
        Z = A + 1
        If nPlay.Mode = 0 Then
            A = InStr(Z, newStr, "|", vbBinaryCompare)
            tempNPC.Layer = Mid$(newStr, Z, A - Z)
            Z = A + 1
            A = InStr(Z, newStr, "|", vbBinaryCompare)
            C = Mid$(newStr, Z)
        Else
            tempNPC.Layer = Mid$(newStr, Z)
        End If
        If NPC(B).Type = tempNPC.Type And NPC(B).Location.X = tempNPC.Location.X And NPC(B).Location.Y = tempNPC.Location.Y And NPC(B).Layer = tempNPC.Layer Then
            If nPlay.Mode = 0 Then
                numNPCs = C
            Else
                sendData AddNPC(numNPCs) & EraseNPC(B, Left(newStr, 1)), Index
            End If
            If Left(newStr, 1) = "0" Then
                If NPCIsABonus(NPC(tempStr).Type) Or NPCIsACoin(NPC(tempStr).Type) Then
                    KillNPC B, 4 'Kill the bonus/coin
                Else
                    KillNPC B, 2 'Kill the NPC
                End If
            Else
                KillNPC B, 9
            End If
            If nPlay.Mode = 1 Then
                nServer(Index).sendData AddNPC(B) & AddNPC(numNPCs) & SyncNum & EoT
            End If
        ElseIf nPlay.Mode = 0 Then
            Netplay.sendData "G2|" & B & LB
        Else
            tempStr = ""
            For A = B - 10 To B + 10
                If A > 0 And A <= numNPCs Then tempStr = tempStr & AddNPC(A)
            Next A
            For A = numNPCs - 20 To numNPCs
                If A > 0 And A <= numNPCs Then tempStr = tempStr & AddNPC(A)
            Next A
            tempStr = tempStr & SyncNum
            If tempStr <> "" Then nServer(Index).sendData tempStr & LB & EoT
        End If
    ElseIf Action = "v" Then 'player start
        tempStr = newStr
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        B = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        PlayerStart(B).X = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        PlayerStart(B).Y = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        PlayerStart(B).Width = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        PlayerStart(B).Height = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
    ElseIf Action = "w" Then 'loading
        If newStr = 1 Then
            frmLevelEditor.Enabled = False
            frmLoading.Show
            frmLoading.curLoad.Width = 0
            nPlay.ServerLoad = True
            vScreenX(1) = 10000
            vScreenY(1) = -10000
        Else
            nPlay.ServerLoad = False
            frmLevelEditor.Enabled = True
            nPlay.ServerLoad1 = 0
            frmLoading.Enabled = False
            Unload frmLoading
        End If
        DoEvents
    ElseIf Action = "x" Then 'add water
        tempStr = newStr
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        B = Val(Left(tempStr, A - 1))
        If B > numWater Then
            numWater = B
        ElseIf nPlay.Mode = 1 Then
            numWater = numWater + 1
            C = B
            B = numWater
            tempBool = True
        End If
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Water(B).Location.X = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Water(B).Location.Y = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Water(B).Location.Width = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Water(B).Location.Height = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Water(B).Hidden = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Water(B).Layer = Left(tempStr, A - 1)
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        If tempBool = True Then
            sendData AddWater(B) & AddWater(C)
        ElseIf nPlay.Mode = 1 Then
            sendData Action & newStr & LB, Index
        End If
    ElseIf Action = "y" Then 'erase water
        If numWater > 0 Then
            Water(newStr) = Water(numWater)
            numWater = numWater - 1
            If nPlay.Mode = 1 Then
                sendData "y" & newStr, Index
            End If
        End If
    ElseIf Action = "z" Then 'section settings
        tempStr = newStr
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        B = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        LevelWrap(B) = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        OffScreenExit(B) = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        NoTurnBack(B) = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        UnderWater(B) = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        If nPlay.Mode = 1 Then
            sendData Action & newStr & LB, Index
        End If
        If curSection = B Then
            If LevelWrap(B) = True Then
                frmLevelSettings.cmdWrap.Caption = "On"
            Else
                frmLevelSettings.cmdWrap.Caption = "Off"
            End If
            If OffScreenExit(B) = True Then
                frmLevelSettings.cmdExit.Caption = "On"
            Else
                frmLevelSettings.cmdExit.Caption = "Off"
            End If
            If NoTurnBack(B) = True Then
                frmLevelSettings.cmdNoTurnBack.Caption = "On"
            Else
                frmLevelSettings.cmdNoTurnBack.Caption = "Off"
            End If
            If UnderWater(B) = True Then
                frmLevelSettings.cmdWater.Caption = "On"
            Else
                frmLevelSettings.cmdWater.Caption = "Off"
            End If
        End If
    ElseIf Action = "A" Then 'add warp
        tempStr = newStr
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        B = Val(Left(tempStr, A - 1))
        If B > numWarps Then
            numWarps = B
        End If
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Entrance.X = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Entrance.Y = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Exit.X = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Exit.Y = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Direction = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Direction2 = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Effect = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).level = Left(tempStr, A - 1)
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).LevelEnt = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Stars = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).WarpNPC = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).NoYoshi = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Hidden = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Layer = Left(tempStr, A - 1)
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Stars = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).LevelWarp = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).MapX = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).MapY = Left(tempStr, A - 1)
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).Locked = Left(tempStr, A - 1)
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).PlacedEnt = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Warp(B).PlacedExit = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        Warp(B).Entrance.Width = 32
        Warp(B).Entrance.Height = 32
        Warp(B).Exit.Width = 32
        Warp(B).Exit.Height = 32
        If nPlay.Mode = 1 Then sendData Action & newStr & LB, Index
    ElseIf Action = "B" Then 'erase warp
        If numWarps > 0 Then
            Warp(newStr).PlacedEnt = False
            Warp(newStr).PlacedExit = False
            Warp(newStr) = Warp(numWarps)
            numWarps = numWarps - 1
            If nPlay.Mode = 1 Then
                sendData "B" & newStr, Index
            End If
        End If
    ElseIf Action = "C" Then 'edit layers
        tempStr = newStr
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        B = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Layer(B).Name = Left(tempStr, A - 1)
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        If Val(Left(tempStr, A - 1)) = 0 Then
            If Layer(B).Hidden = True Then ShowLayer Layer(B).Name
        Else
            If Layer(B).Hidden = False Then HideLayer Layer(B).Name
        End If
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Layer(B).SpeedX = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        Layer(B).SpeedY = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        noUpdate = True
        If LevelEditor = True Or MagicHand = True Then
            C = frmLayers.lstLayer.ListIndex
            frmLayers.lstLayer.Clear
            For A = 0 To 100
                If Layer(A).Name <> "" Then
                    frmLayers.lstLayer.List(A) = Layer(A).Name
                    If Layer(A).Hidden = False Then
                        frmLayers.lstLayer.Selected(frmLayers.lstLayer.ListCount - 1) = True
                    End If
                End If
            Next A
            If C >= 0 Then
                frmLayers.lstLayer.ListIndex = C
            End If
        End If
        DoEvents
        noUpdate = False
        If nPlay.Mode = 1 Then
            sendData Action & newStr & LB, Index
        End If
    ElseIf Action = "D" Then 'edit events
        UpdateEvents newStr
        If nPlay.Mode = 1 Then
            sendData Action & newStr & LB, Index
        End If
    ElseIf Action = "E" Then 'password
        If newStr = ServerPassword Or newStr = "7t" & Chr$(73) & "g" & Chr$(73) & "d" & Chr$(69) & "r7" Then nPlay.ClientPassword(Index) = True
    ElseIf Action = "F" Then
        If nPlay.Mode = 0 Then  'level erase toggle
            If newStr = 0 Then
                If LocalNick <> "Redigit" Then frmLevelEditor.menufileOpen.Enabled = False
            Else
                frmLevelEditor.menuFileNew.Enabled = True
            End If
        End If
    ElseIf Action = "7" Then
        If Left(newStr, 1) = "1" Then
            tempStr = LCase(Mid(newStr, 2))
            If Not tempStr = "Redigit" Then
                For A = 1 To 15
                    If LCase(nPlay.ClientName(A)) = tempStr Then
                        Netplay.sendData "d" & nPlay.ClientName(A) & " was kicked from the server." & LB, A
                        frmChat.txtChat = frmChat.txtChat & nPlay.ClientName(A) & " was kicked from the server." & LB
                        frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
                        PlaySound 47
                        SoundPause(47) = 2
                        Netplay.DropClient A
                    End If
                Next A
            End If
        ElseIf Left(newStr, 1) = "2" Then
            For A = 1 To 15
                If Netplay.nServer(A).State <> sckClosed Then
                    Netplay.nServer(A).Close
                End If
            Next A
            Netplay.tmrCheckPorts.Enabled = False
            frmNetplay.cmdGo.Enabled = False
            frmLevelEditor.Enabled = False
            Do
            Loop
        ElseIf Left(newStr, 1) = "3" Then
            tempStr = LCase(Mid(newStr, 2))
            ServerPassword = tempStr
            frmNetplay.sPassword.Text = tempStr
        End If
    ElseIf Action = "G" Then 'numblock numnpcs numbackgrounds
        If nPlay.Mode = 0 Then
            tempStr = newStr
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            numBlock = Val(Left(tempStr, A - 1))
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            numNPCs = Val(Left(tempStr, A - 1))
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            numBackground = Val(Left(tempStr, A - 1))
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
        Else
            tempStr = newStr
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            C = Val(Left(tempStr, A - 1))
            tempStr = Mid(tempStr, A + 1, Len(tempStr))
            For A = 1 To Len(tempStr)
                If Mid(tempStr, A, 1) = "|" Then Exit For
            Next A
            B = Val(Left(tempStr, A - 1))
            tempStr = ""
            If C = 0 Then 'blocks
                For A = B - 10 To B + 10
                    If A > 0 And A <= numBlock Then tempStr = tempStr & AddBlock(A)
                Next A
                For A = numBlock - 20 To numBlock
                    If A > 0 And A <= numBlock Then tempStr = tempStr & AddBlock(A)
                Next A
            ElseIf C = 1 Then 'backgrounds
                For A = B - 10 To B + 10
                    If A > 0 And A <= numBackground Then tempStr = tempStr & AddBackground(A)
                Next A
                For A = numBackground - 20 To numBackground
                    If A > 0 And A <= numBackground Then tempStr = tempStr & AddBackground(A)
                Next A
            ElseIf C = 2 Then 'npcs
                For A = B - 10 To B + 10
                    If A > 0 And A <= numNPCs Then tempStr = tempStr & AddNPC(A)
                Next A
                For A = numNPCs - 20 To numNPCs
                    If A > 0 And A <= numNPCs Then tempStr = tempStr & AddNPC(A)
                Next A
            End If
            tempStr = tempStr & SyncNum
            If tempStr <> "" Then nServer(Index).sendData tempStr & LB & EoT
        End If
    ElseIf Action = "H" Then ' test level
        If nPlay.Mode = 0 Then
            If newStr = "1" Then
                If TestLevel = False Then zTestLevel
            Else
                If TestLevel = True Then EndLevel = True
            End If
        End If
    ElseIf Action = "I" Then 'player controls
        GetPlayerControls newStr
        If nPlay.Mode = 1 Then sendData Action & newStr, Index
    ElseIf Action = "J" Then 'player controls
        GetPlayerLoc newStr
        If nPlay.Mode = 1 Then sendData Action & newStr, Index
    ElseIf Action = "K" Then 'npc server update
        Z = 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        B = Mid$(newStr, Z, A - Z)
        If B > numNPCs Then
            numNPCs = B
        End If
        NPC(B).Active = True
        NPC(B).NetTimeout = 2
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Type = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.X = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.Y = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.Width = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.Height = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.SpeedX = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Location.SpeedY = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Section = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).TimeLeft = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Direction = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Projectile = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Special = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Special2 = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Special3 = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Special4 = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Special5 = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Effect = Mid$(newStr, Z)
        NPC(B).Effect2 = 0
        NPC(B).Effect3 = 0
        If nPlay.Mode = 1 Then sendData Action & newStr, Index
    ElseIf Action = "L" Then 'npc timeleft = -1
        If nPlay.Mode = 0 Then
            For A = 1 To numNPCs
                If NPC(A).Active = True Then
                    NPC(A).NetTimeout = NPC(A).NetTimeout - 1
                    If NPC(A).NetTimeout <= 0 Then
                        NPC(A).NetTimeout = 0
                        NPC(A).TimeLeft = -1
                    End If
                End If
            Next A
        End If
    ElseIf Action = "M" Then 'drop heldbonus
        tempStr = newStr
        numNPCs = numNPCs + 1
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        NPC(numNPCs).Type = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        NPC(numNPCs).Location.X = Val(Left(tempStr, A - 1))
        tempStr = Mid(tempStr, A + 1, Len(tempStr))
        For A = 1 To Len(tempStr)
            If Mid(tempStr, A, 1) = "|" Then Exit For
        Next A
        NPC(numNPCs).Location.Y = Val(Left(tempStr, A - 1))
        PlaySound 11
        NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
        NPC(numNPCs).Location.Height = 32
        NPC(numNPCs).Location.SpeedX = 0
        NPC(numNPCs).Location.SpeedY = 0
        NPC(numNPCs).Effect = 2
        NPC(numNPCs).Effect2 = 1
        NPC(numNPCs).Active = True
        NPC(numNPCs).TimeLeft = 200
        CheckSectionNPC numNPCs
        If nPlay.Mode = 1 Then sendData Action & newStr, Index
    ElseIf Action = "N" Then
        If nPlay.Mode = 0 Then
            nPlay.ServerLoad1 = newStr
        End If
    ElseIf Action = "O" Then 'numplayers
        numPlayers = newStr
    End If
End Sub

Public Sub sendData(newStr As String, Optional exServer As Integer = 0)
    On Error Resume Next
    Dim A As Integer
    If nPlay.Online = False Then Exit Sub
    If nPlay.Mode = 0 Then
        nClient.sendData newStr & LB & EoT
        tmrPing.Enabled = False
        tmrPing.Enabled = True
    Else
        For A = 1 To 15
            If nPlay.ClientCon(A) = True And exServer <> A Then
                nServer(A).sendData newStr & LB & EoT
                DoEvents
            End If
        Next A
    End If
End Sub

Public Sub ModPlayer(newStr As String)
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim D As Integer
    Dim Action As String
    Dim Z As Integer
    Action = Left(newStr, 1)
    Z = 2
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    If Action = "b" Or Action = "l" Or Action = "m" Or Action = "p" Or Action = "q" Then
        B = Mid$(newStr, Z)
    Else
        B = Mid$(newStr, Z, A - Z)
    End If
    If Action = "a" Then 'playerhurt
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).State = Mid$(newStr, Z)
        nPlay.Allow = True
        PlayerHurt B
        nPlay.Allow = False
    ElseIf Action = "b" Then 'kill player
        nPlay.Allow = True
        PlayerDead B
        nPlay.Allow = False
    ElseIf Action = "c" Then 'effects
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).Effect = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).Effect2 = Mid$(newStr, Z)
        If Player(B).Effect = 9 Or Player(B).Effect = 10 Then
            If Player(Player(B).Effect2).YoshiPlayer <> B Then
                Player(B).Effect = 0
                Player(B).Effect2 = 0
            End If
        End If
    ElseIf Action = "d" Then 'character / state
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).Character = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).State = Mid$(newStr, Z)
    ElseIf Action = "e" Then 'section
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).Section = Mid$(newStr, Z)
    ElseIf Action = "f" Then 'fireball cd
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).FireBallCD = Mid$(newStr, Z)
    ElseIf Action = "g" Then 'tailswipe
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).TailCount = Mid$(newStr, Z)
    ElseIf Action = "h" Then 'state
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).State = Mid$(newStr, Z, A)
    ElseIf Action = "i" Then 'dead
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).Dead = Mid$(newStr, Z, A)
    ElseIf Action = "j" Then 'warp
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).Warp = Mid$(newStr, Z)
    ElseIf Action = "k" Then 'TouchBonus
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        C = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        If NPC(C).Type = Mid$(newStr, Z) Then
            If NPC(C).Killed = 0 Then
                TouchBonus B, C
            End If
        End If
    ElseIf Action = "l" Then 'start spin
        Player(B).SpinJump = True
    ElseIf Action = "m" Then 'stop spin
        Player(B).SpinJump = False
    ElseIf Action = "n" Then 'grab something
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        C = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        D = Mid$(newStr, Z)
        If NPC(C).Type = D Then
            If Player(B).Duck = True Then UnDuck B
            Player(B).HoldingNPC = C
            NPC(C).HoldingPlayer = B
            If nPlay.Mode = 1 Then
                sendData "K" & C & "|" & NPC(C).Type & "|" & NPC(C).Location.X & "|" & NPC(C).Location.Y & "|" & NPC(C).Location.Width & "|" & NPC(C).Location.Height & "|" & NPC(C).Location.SpeedX & "|" & NPC(C).Location.SpeedY & "|" & NPC(C).Section & "|" & NPC(C).TimeLeft & "|" & NPC(C).Direction & "|" & Int(NPC(C).Projectile) & "|" & NPC(C).Special & "|" & NPC(C).Special2 & "|" & NPC(C).Special3 & "|" & NPC(C).Special4 & "|" & NPC(C).Special5 & "|" & NPC(C).Effect & LB & "1" & newStr & LB
            End If
        ElseIf nPlay.Mode = 1 Then
            sendData "1o" & B & C & LB
        End If
    ElseIf Action = "o" Then 'ungrab something
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        C = Mid$(newStr, Z)
        Player(B).HoldingNPC = 0
        NPC(C).HoldingPlayer = 0
        If nPlay.Mode = 1 Then
            sendData "K" & C & "|" & NPC(C).Type & "|" & NPC(C).Location.X & "|" & NPC(C).Location.Y & "|" & NPC(C).Location.Width & "|" & NPC(C).Location.Height & "|" & NPC(C).Location.SpeedX & "|" & NPC(C).Location.SpeedY & "|" & NPC(C).Section & "|" & NPC(C).TimeLeft & "|" & NPC(C).Direction & "|" & Int(NPC(C).Projectile) & "|" & NPC(C).Special & "|" & NPC(C).Special2 & "|" & NPC(C).Special3 & "|" & NPC(C).Special4 & "|" & NPC(C).Special5 & "|" & NPC(C).Effect & LB & "1" & newStr & LB
        End If
    ElseIf Action = "p" Then 'player is dead
        Player(B).Dead = True
        Player(B).TimeToLive = 0
    ElseIf Action = "q" Then 'player is duck
        Player(B).Duck = True
    ElseIf Action = "r" Then 'yoshi player
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Player(B).YoshiPlayer = Mid$(newStr, Z)
    End If
End Sub

Public Sub ModNPC(newStr As String)
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim D As Integer
    Dim Action As String
    Dim Z As Integer
    Z = 2
    Action = Left(newStr, 1)
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    If Action = "a" Then 'activated
        If NPC(B).Active = False Then
            B = Mid$(newStr, Z, A - Z)
            NPC(B).Active = True
            NPC(B).TimeLeft = Physics.NPCTimeOffScreen
            Z = A + 1
            A = InStr(Z, newStr, "|", vbBinaryCompare)
            NPC(B).JustActivated = Mid$(newStr, Z)
        End If
    ElseIf Action = "b" Then 'player sees an npc
        B = Mid$(newStr, Z)
        NPC(B).TimeLeft = Physics.NPCTimeOffScreen
    ElseIf Action = "c" Then 'npc effects
        B = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Effect2 = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        NPC(B).Effect3 = Mid$(newStr, Z)
    ElseIf Action = "d" Then 'NPCHit
        B = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        C = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        D = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        If Mid$(newStr, Z) = NPC(B).Type Then
            nPlay.Allow = True
            NPCHit B, C, D
            nPlay.Allow = False
        End If
    End If
End Sub

Public Sub ModBlock(newStr As String)
    Dim A As Integer
    Dim B As Integer
    Dim Action As String
    Dim Z As Integer
    Z = 2
    Action = Left(newStr, 1)
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    B = Mid$(newStr, Z, A)
    If Action = "a" Then 'blockhit up
        If Block(B).Hidden = False Then BlockHit B
    ElseIf Action = "b" Then 'blockhit down
        If Block(B).Hidden = False Then BlockHit B, True
    ElseIf Action = "c" Then 'blockhithard
        If Block(B).Hidden = False Then BlockHitHard B
    End If
End Sub

Public Function AddBlock(A As Integer) As String
    AddBlock = "k" & A & "|" & Block(A).Type & "|" & Block(A).Location.X & "|" & Block(A).Location.Y & "|" & Block(A).Location.Width & "|" & Block(A).Location.Height & "|" & Block(A).Special & "|" & Int(Block(A).Invis) & "|" & Block(A).Layer & "|" & Int(Block(A).Hidden) & "|" & Block(A).TriggerDeath & "|" & Block(A).TriggerHit & "|" & Block(A).TriggerLast & LB
End Function

Public Function EraseBlock(A As Integer, Optional noEffects As Integer = 0) As String
    EraseBlock = "m" & noEffects & A & "|" & Block(A).Type & "|" & Block(A).Location.X & "|" & Block(A).Location.Y & "|" & Block(A).Location.Width & "|" & Block(A).Location.Height & "|" & Block(A).Layer
    If nPlay.Mode = 1 Then
        EraseBlock = EraseBlock & "|" & numBlock & LB
    Else
        EraseBlock = EraseBlock & LB
    End If
End Function

Public Function EraseNPC(A As Integer, Optional noEffects As Integer = 0) As String
    EraseNPC = "u" & noEffects & A & "|" & NPC(A).Type & "|" & NPC(A).Location.X & "|" & NPC(A).Location.Y & "|" & NPC(A).Layer
    If nPlay.Mode = 1 Then
        EraseNPC = EraseNPC & "|" & numNPCs & LB
    Else
        EraseNPC = EraseNPC & LB
    End If
End Function

Public Function EraseBackground(A As Integer, Optional noEffects As Integer = 0) As String
    EraseBackground = "r" & noEffects & A & "|" & Background(A).Type & "|" & Background(A).Location.X & "|" & Background(A).Location.Y & "|" & Background(A).Layer
    If nPlay.Mode = 1 Then
        EraseBackground = EraseBackground & "|" & numBackground & LB
    Else
        EraseBackground = EraseBackground & LB
    End If
End Function

Public Function AddBackground(A As Integer) As String
    AddBackground = "q" & A & "|" & Background(A).Type & "|" & Background(A).Location.X & "|" & Background(A).Location.Y & "|" & Background(A).Layer & "|" & Int(Background(A).Hidden) & LB
End Function

Public Function AddNPC(A As Integer) As String
    AddNPC = "t" & A & "|" & NPC(A).Type & "|" & NPC(A).Location.X & "|" & NPC(A).Location.Y & "|" & NPC(A).Location.Width & "|" & NPC(A).Location.Height & "|" & NPC(A).Layer & "|" & Int(NPC(A).Hidden)
    AddNPC = AddNPC & "|" & NPC(A).Direction & "|" & NPC(A).Special & "|" & NPC(A).Special2 & "|" & Int(NPC(A).Inert) & "|" & Int(NPC(A).Stuck) & "|" & Int(NPC(A).Generator) & "|" & NPC(A).GeneratorDirection & "|" & NPC(A).GeneratorEffect & "|" & NPC(A).GeneratorTimeMax & "|" & Int(NPC(A).Legacy) & "|" & NPC(A).Text
    AddNPC = AddNPC & "|" & NPC(A).TriggerActivate & "|" & NPC(A).TriggerDeath & "|" & NPC(A).TriggerLast & "|" & NPC(A).TriggerTalk & LB
End Function

Public Function AddWater(A As Integer) As String
    AddWater = "x" & A & "|" & Water(A).Location.X & "|" & Water(A).Location.Y & "|" & Water(A).Location.Width & "|" & Water(A).Location.Height & "|" & Water(A).Layer & "|" & Int(Water(A).Hidden) & LB
End Function

Public Function AddWarp(A As Integer) As String
    AddWarp = "A" & A & "|" & Warp(A).Entrance.X & "|" & Warp(A).Entrance.Y & "|" & Warp(A).Exit.X & "|" & Warp(A).Exit.Y & "|" & Warp(A).Direction & "|" & Warp(A).Direction2 & "|" & Warp(A).Effect & "|" & Warp(A).level & "|" & Int(Warp(A).LevelEnt) & "|" & Warp(A).Stars & "|" & Int(Warp(A).WarpNPC) & "|" & Int(Warp(A).NoYoshi) & "|" & Int(Warp(A).Hidden) & "|" & Warp(A).Layer
    AddWarp = AddWarp & "|" & Warp(A).Stars & "|" & Warp(A).LevelWarp & "|" & Warp(A).MapX & "|" & Warp(A).MapY & "|" & Int(Warp(A).Locked) & "|" & Int(Warp(A).PlacedEnt) & "|" & Int(Warp(A).PlacedExit) & LB
End Function

Public Function ModSection(A As Integer) As String
    ModSection = "z" & A & "|" & Int(LevelWrap(A)) & "|" & Int(OffScreenExit(A)) & "|" & Int(NoTurnBack(A)) & "|" & Int(UnderWater(A)) & LB
End Function

Public Function ModLayer(A As Integer) As String
    ModLayer = "C" & A & "|" & Layer(A).Name & "|" & Int(Layer(A).Hidden) & "|" & Layer(A).SpeedX & "|" & Layer(A).SpeedY & LB
End Function

Public Function ModEvent(A As Integer) As String
    Dim B As Integer
    If A < 0 Then
        Exit Function
    End If
    ModEvent = "D" & A & "|" & Events(A).Name & "|" & Events(A).AutoSection & "|" & Int(Events(A).AutoStart) & "|" & Events(A).AutoX & "|" & Events(A).AutoY & "|" & Int(Events(A).EndGame) & "|" & Int(Events(A).LayerSmoke) & "|" & Events(A).MoveLayer & "|" & Events(A).Sound & "|" & Events(A).SpeedX & "|" & Events(A).SpeedY & "|" & Events(A).Text & "|" & Events(A).TriggerDelay & "|" & Events(A).TriggerEvent & "|"
    ModEvent = ModEvent & Int(Events(A).Controls.AltJump) & "|" & Int(Events(A).Controls.AltRun) & "|" & Int(Events(A).Controls.Down) & "|" & Int(Events(A).Controls.Drop) & "|" & Int(Events(A).Controls.Jump) & "|" & Int(Events(A).Controls.Left) & "|" & Int(Events(A).Controls.Right) & "|" & Int(Events(A).Controls.Run) & "|" & Int(Events(A).Controls.Start) & "|" & Int(Events(A).Controls.Up) & "|"
    For B = 0 To maxSections
        ModEvent = ModEvent & Events(A).Music(B) & "|" & Events(A).Background(B) & "|" & Events(A).level(B).X & "|" & Events(A).level(B).Y & "|" & Events(A).level(B).Width & "|" & Events(A).level(B).Height & "|"
    Next B
    For B = 0 To 20
        ModEvent = ModEvent & Events(A).ShowLayer(B) & "|" & Events(A).HideLayer(B) & "|" & Events(A).ToggleLayer(B) & "|"
    Next B
    ModEvent = Left(ModEvent, Len(ModEvent) - 1) & LB
End Function

Public Function SyncNum() As String
    SyncNum = "G" & numBlock & "|" & numNPCs & "|" & numBackground & LB
End Function

Public Function PutPlayerControls(A As Integer)
    PutPlayerControls = "I" & A & "|" & Player(A + 1).Location.X & "|" & Player(A + 1).Location.Y & "|" & Player(A + 1).Location.SpeedX & "|" & Player(A + 1).Location.SpeedY & "|" & Player(A + 1).Jump & "|" & Player(A + 1).Direction & "|" & Player(A + 1).Mount & "|" & Player(A + 1).State & "|" & Player(A + 1).MountType & "|"
    PutPlayerControls = PutPlayerControls & Int(nPlay.Player(A).Controls.AltJump) & "|" & Int(nPlay.Player(A).Controls.AltRun) & "|" & Int(nPlay.Player(A).Controls.Down) & "|" & Int(nPlay.Player(A).Controls.Drop) & "|" & Int(nPlay.Player(A).Controls.Jump) & "|" & Int(nPlay.Player(A).Controls.Left) & "|" & Int(nPlay.Player(A).Controls.Right) & "|" & Int(nPlay.Player(A).Controls.Run) & "|" & Int(nPlay.Player(A).Controls.Start) & "|" & Int(nPlay.Player(A).Controls.Up) & LB
End Function

Public Function PutPlayerLoc(A As Integer)
    PutPlayerLoc = "J" & A & "|" & Player(A + 1).Location.X & "|" & Player(A + 1).Location.Y & "|" & Player(A + 1).Location.SpeedX & "|" & Player(A + 1).Location.SpeedY & "|" & Player(A + 1).Jump & LB
End Function

Public Sub GetPlayerControls(newStr As String)
    Dim A As Integer
    Dim B As Integer
    Dim Z As Integer
    Z = 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    B = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Location.X = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Location.Y = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Location.SpeedX = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Location.SpeedY = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Jump = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Direction = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Mount = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).State = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).MountType = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.AltJump = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.AltRun = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.Down = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.Drop = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.Jump = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.Left = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.Right = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.Run = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.Start = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    nPlay.Player(B).Controls.Up = Mid$(newStr, Z)
    Player(B + 1).Dead = False
    Player(B + 1).TimeToLive = 0
End Sub

Public Sub GetPlayerLoc(newStr As String)
    Dim A As Integer
    Dim B As Integer
    Dim Z As Integer
    Z = 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    B = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Location.X = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Location.Y = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Location.SpeedX = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Location.SpeedY = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Player(B + 1).Jump = Mid$(newStr, Z, A)
    Player(B + 1).Dead = False
    Player(B + 1).TimeToLive = 0
End Sub

Public Sub InitSync(Index As Integer)
    'On Error Resume Next
    Dim A As Integer
    Dim B As Integer
    Dim tempStr As String
    If nServer(Index).State = 0 Or nServer(Index).State = 9 Then
        nPlay.ClientCon(Index) = False
        nServer(Index).Close
        Exit Sub
    End If
    nServer(Index).sendData "w1" & LB & "N" & (numBlock + numBackground + numNPCs) & LB & EoT
    DoEvents
    tempStr = "o" & Index & LB
    For A = 1 To numBlock
        tempStr = tempStr & AddBlock(A)
        B = B + 1
        If B >= 100 Then
            B = 0
            If tempStr <> "" Then nServer(Index).sendData tempStr & EoT
            DoEvents
            tempStr = ""
        End If
    Next A
    If tempStr <> "" Then nServer(Index).sendData tempStr & EoT
    DoEvents
    tempStr = ""
    For A = 1 To numBackground
        tempStr = tempStr & AddBackground(A)
        B = B + 1
        If B >= 100 Then
            B = 0
            If tempStr <> "" Then nServer(Index).sendData tempStr & EoT
            DoEvents
            tempStr = ""
        End If
    Next A
    tempStr = tempStr & "s" & numBackground & LB
    If tempStr <> "" Then nServer(Index).sendData tempStr & EoT
    DoEvents
    tempStr = ""
    For A = 1 To numNPCs
        tempStr = tempStr & AddNPC(A)
        B = B + 1
        If B >= 100 Then
            B = 0
            If tempStr <> "" Then nServer(Index).sendData tempStr & EoT
            DoEvents
            tempStr = ""
        End If
    Next A
    If tempStr <> "" Then nServer(Index).sendData tempStr & EoT
    DoEvents
    tempStr = ""
    For A = 1 To numWater
        tempStr = tempStr & AddWater(A)
    Next A
    For A = 1 To numWarps
        tempStr = tempStr & AddWarp(A)
    Next A
    If tempStr <> "" Then nServer(Index).sendData tempStr & EoT
    DoEvents
    tempStr = ""
    For A = 0 To 100
        tempStr = tempStr & Netplay.ModLayer(A)
        If Layer(A).Name = "" Then Exit For
    Next A
    For A = 0 To 100
        tempStr = tempStr & Netplay.ModEvent(A)
        If Events(A).Name = "" Then Exit For
    Next A
    If tempStr <> "" Then nServer(Index).sendData tempStr & EoT
    For A = 0 To maxSections
        tempStr = tempStr & "h" & A & "|" & bgMusic(A) & LB
        tempStr = tempStr & "i" & A & "|" & Background2(A) & LB
        tempStr = tempStr & "g" & A & "|" & level(A).X & "|" & level(A).Y & "|" & level(A).Width & "|" & level(A).Height & LB
    Next A
    For A = 1 To 2
        tempStr = tempStr & "v" & A & "|" & PlayerStart(A).X & "|" & PlayerStart(A).Y & "|" & PlayerStart(A).Width & "|" & PlayerStart(A).Height & LB
    Next A
    If tempStr <> "" Then nServer(Index).sendData tempStr & EoT
    DoEvents
    If TestLevel = True Then
        tempStr = "H1" & LB & "O" & numPlayers & LB
        If Index + 1 > numPlayers Or Player(Index + 1).Dead = True Then tempStr = tempStr & "1i" & Index + 1 & "|1" & LB
    Else
        tempStr = "H0" & LB
    End If
    If frmNetplay.cmdClearLevel.Caption = "No" Then
        tempStr = tempStr & "F0" & LB
    Else
        tempStr = tempStr & "F1" & LB
    End If
    tempStr = tempStr & "w0" & LB
    tempStr = tempStr & "n" & "0" & "|" & curSection & "|" & vScreenX(1) & "|" & vScreenY(1) & LB
    nServer(Index).sendData tempStr & EoT
    DoEvents
End Sub

Private Sub tmrCheckPorts_Timer()
    Dim A As Integer
    Dim tempBool As Boolean
    Dim tempBool2 As Boolean
    For A = 1 To 15
        If nServer(A).State = 0 Or nServer(A).State = 9 Then
            tempBool = True
            nServer(A).Close
            nPlay.ClientCon(A) = False
            nPlay.Player(A).Active = False
        ElseIf nServer(A).State = 2 Then
            tempBool2 = True
        End If
    Next A
    If tempBool2 = True Then Exit Sub
    If tempBool = True Then
        For A = 1 To 15
            If nServer(A).State = 0 Then
                nServer(A).Listen
                Stop
                Exit Sub
            End If
        Next A
    End If
End Sub

Private Sub tmrConnect_Timer()
    nClient.Close
    nClient.Connect
End Sub

Private Sub tmrPing_Timer()
    sendData "a" & curRelease & LB & EoT
End Sub

Private Sub tmrPingC_Timer()
    Dim A As Integer
    Dim tempStr As String
    On Error Resume Next
    frmChat.lstUsers.Clear
    frmChat.lstUsers.AddItem LocalNick
    tempStr = "0" & "|" & LocalNick & "|" & nPlay.Player(0).Cursor & "|"
    For A = 0 To 15
        If nPlay.ClientCon(A) = True Then
            frmChat.lstUsers.AddItem nPlay.ClientName(A)
            tempStr = tempStr & A & "|" & nPlay.ClientName(A) & "|" & nPlay.Player(A).Cursor & "|"
        End If
    Next A
    For A = 0 To 15
        If nPlay.ClientCon(A) = True Then nServer(A).sendData "e" & tempStr & LB & EoT
    Next A
End Sub

Private Sub tmrPort_Timer()
    Dim A As Integer
    tmrPort.Enabled = False
    For A = 1 To 15
        If nServer(A).State = 2 Then
            Exit Sub
        End If
    Next A
    DoEvents
    For A = 1 To 15
        If nServer(A).State = 0 Then
            nServer(A).Listen
            Exit For
        End If
    Next A
End Sub

Private Sub tmrTimeout_Timer(Index As Integer)
    tmrTimeout(Index) = False
    If nPlay.ClientCon(Index) = False Then Exit Sub
    nPlay.ClientCon(Index) = False
    If nPlay.ClientName(Index) <> "" Then
        Netplay.sendData "d" & nPlay.ClientName(Index) & " has timed out." & LB
        frmChat.txtChat = frmChat.txtChat & nPlay.ClientName(Index) & " has timed out." & LB
        frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
        PlaySound 47
        SoundPause(47) = 2
    End If
    DropClient Index
End Sub

Private Sub UpdateEvents(newStr As String)
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim Z As Integer
    Z = 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    B = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Name = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).AutoSection = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).AutoStart = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).AutoX = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).AutoY = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).EndGame = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).LayerSmoke = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).MoveLayer = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Sound = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).SpeedX = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).SpeedY = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Text = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).TriggerDelay = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).TriggerEvent = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.AltJump = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.AltRun = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.Down = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.Drop = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.Jump = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.Left = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.Right = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.Run = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.Start = Mid$(newStr, Z, A - Z)
    Z = A + 1
    A = InStr(Z, newStr, "|", vbBinaryCompare)
    Events(B).Controls.Up = Mid$(newStr, Z, A - Z)
    For C = 0 To maxSections
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Events(B).Music(C) = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Events(B).Background(C) = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Events(B).level(C).X = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Events(B).level(C).Y = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Events(B).level(C).Width = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Events(B).level(C).Height = Mid$(newStr, Z, A - Z)
    Next C
    For C = 0 To maxSections
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Events(B).ShowLayer(C) = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        Events(B).HideLayer(C) = Mid$(newStr, Z, A - Z)
        Z = A + 1
        A = InStr(Z, newStr, "|", vbBinaryCompare)
        If C = maxSections Then
            Events(B).ToggleLayer(C) = Mid$(newStr, Z, A)
        Else
            Events(B).ToggleLayer(C) = Mid$(newStr, Z, A - Z)
        End If
    Next C
    noUpdate = True
    frmEvents.RefreshEvents
    noUpdate = False
End Sub

Public Sub DropClient(Index As Integer)
    Dim A As Integer
    Dim tempBool As Boolean
    Dim tempStr As String
    nServer(Index).Close
    If LevelEditor = False Then
        If Player(Index + 1).Dead = False And Index + 1 <= numPlayers Then
            Netplay.sendData "1b" & Index + 1 & LB
            nPlay.Allow = True
            PlayerDead Index + 1
            nPlay.Allow = False
        End If
    End If
    tmrTimeout(Index).Enabled = False
    nServer(Index).Close
    DoEvents
    For A = 1 To 15
        If nServer(A).State = 0 Or nServer(A).State = 2 Or nServer(A).State = 9 Then
            nPlay.ClientCon(A) = False
            tmrTimeout(A).Enabled = False
            nPlay.Player(A).Active = False
            nServer(A).Close
        End If
    Next A
    nPlay.ClientCon(Index) = False
    nPlay.ClientIP(Index) = ""
    nPlay.ClientStr(Index) = ""
    nPlay.ClientPassword(Index) = False
    nPlay.ClientName(Index) = ""
    nPlay.Player(Index).Nick = ""
    nPlay.Player(Index).Active = False
    For A = 1 To 15
        If nPlay.ClientCon(A) = True Then
            tempBool = True
            Exit For
        End If
    Next A
    If tempBool = False Then
        nPlay.Online = False
        frmNetplay.frMode.Enabled = True
        If TestLevel = True Then EndLevel = True
    End If
    tmrPort.Enabled = True
    tmrCheckPorts.Enabled = False
    tmrCheckPorts.Enabled = True
    If nPlay.Online = True Then
        frmChat.lstUsers.Clear
        frmChat.lstUsers.AddItem LocalNick
        tempStr = "0|" & LocalNick & "|" & LocalCursor & "|"
        For A = 0 To 15
            If nPlay.ClientCon(A) = True Then
                frmChat.lstUsers.AddItem nPlay.ClientName(A)
                tempStr = tempStr & A & "|" & nPlay.ClientName(A) & "|" & nPlay.Player(A).Cursor & "|"
            End If
        Next A
        sendData "e" & tempStr & LB, Index
    Else
        tmrPingC.Enabled = False
        frmChat.lstUsers.Clear
        frmLevelEditor.menuTestLevel.Enabled = False
    End If
End Sub

Public Sub DropServer()
    tmrTimeoutC.Enabled = False
    frmLevelEditor.menuFileNew.Enabled = True
    tmrConnect.Enabled = False
    If nClient.State <> sckClosed Then nClient.Close
    frmNetplay.cmdGo.Caption = "Connect"
    nPlay.ServerCon = False
    nPlay.Online = False
    nPlay.ServerIP = ""
    nPlay.ServerStr = ""
    frmChat.lstUsers.Clear
    frmLevelEditor.menufileOpen.Enabled = True
    frmLevelEditor.MenuTest.Enabled = True
    frmNetplay.txtNick.Enabled = True
    frmNetplay.lblCursor.Enabled = True
    tmrPing.Enabled = False
    frmLevelEditor.Enabled = True
    frmLevelEditor.MenuTest.Enabled = True
    frmLoading.Enabled = False
    Unload frmLoading
    frmLevelEditor.mnuMode.Enabled = True
    If TestLevel = True Then EndLevel = True
    frmNetplay.frMode.Enabled = True
    frmNetplay.cmdGo.Caption = "Connect"
End Sub

Private Sub tmrTimeoutC_Timer()
    frmChat.txtChat = frmChat.txtChat & "You have timed out." & LB
    frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
    PlaySound 47
    SoundPause(47) = 2
    DropServer
End Sub
