Attribute VB_Name = "modChangeRes"
Option Explicit
'Thanks to KPD-Team
'For the API and variables in this module
'Visit them at http://www.allapi.net/
'===========================================================
'I take no responsibilty if this code wrecks your computer.
'Use this code at your own risk!
'===========================================================
'Version 1.3
'By Brendon Pilt
'===========================================================
'Note:
'Form should be maximised so that it fills the whole screen
'when loaded
'===========================================================
'Note:
'Color quality and screen resolution can only be changed
'if it is supported by the Graphics Card\Operating System.
'===========================================================
Const ENUM_CURRENT_SETTINGS As Long = -1&    'Get current settings
Const DM_PELSWIDTH = &H80000        'Pixels in width
Const DM_PELSHEIGHT = &H100000      'Pixels in height
Const DM_BITSPERPEL = &H40000       'Color Depth
Const DM_DISPFREQ = &H400000        'Display Frequency
Const CDS_TEST = &H4
Private Type DEVMODE
    dmDeviceName As String * 32 'Name of graphics card?????
    dmSpecVersion As Integer
    dmDriverVersion As Integer 'graphics card driver version?????
    dmSize As Integer
    dmDriverExtra As Integer
    dmFields As Long
    dmOrientation As Integer
    dmPaperSize As Integer
    dmPaperLength As Integer
    dmPaperWidth As Integer
    dmScale As Integer
    dmCopies As Integer
    dmDefaultSource As Integer
    dmPrintQuality As Integer
    dmColor As Integer
    dmDuplex As Integer
    dmYResolution As Integer
    dmTTOption As Integer
    dmCollate As Integer
    dmFormName As String * 32 'Name of form?????
    dmUnusedPadding As Integer
    dmBitsPerPel As Integer 'Color Quality (can be 8, 16, 24, 32 or even 4)
    dmPelsWidth As Long 'Display Width in pixels
    dmPelsHeight As Long 'Display height in pixels
    dmDisplayFlags As Long
    dmDisplayFrequency As Long 'Display frequency
    dmICMMethod As Long 'NT 4.0
    dmICMIntent As Long 'NT 4.0
    dmMediaType As Long 'NT 4.0
    dmDitherType As Long 'NT 4.0
    dmReserved1 As Long 'NT 4.0
    dmReserved2 As Long 'NT 4.0
    dmPanningWidth As Long 'Win2000
    dmPanningHeight As Long 'Win2000
End Type

Private Declare Function ChangeDisplaySettingsEx Lib "user32" Alias "ChangeDisplaySettingsExA" (lpszDeviceName As Any, lpDevMode As Any, ByVal hWnd As Long, ByVal dwFlags As Long, lParam As Any) As Long
Private Declare Function EnumDisplaySettings Lib "user32" Alias "EnumDisplaySettingsA" (ByVal lpszDeviceName As Long, ByVal iModeNum As Long, lpDevMode As Any) As Boolean

Dim DevM As DEVMODE
Dim OldX As Integer, OldY As Integer, OldColor As Integer, OldFreq As Integer
Dim SetX As Integer, SetY As Integer, SetColor As Integer, SetFreq As Integer

Public Sub GetCurrentRes()
    '=======================================================
    'Call this sub in Form_Load
    '=======================================================
    
    'Save original (current) resolution
    EnumDisplaySettings 0&, ENUM_CURRENT_SETTINGS, DevM     'Get current setting
    OldX = DevM.dmPelsWidth     'or OldX = Screen.Width / Screen.TwipsPerPixelX
    OldY = DevM.dmPelsHeight    'or OldY = Screen.Height / Screen.TwipsPerPixelY
    OldColor = DevM.dmBitsPerPel
    OldFreq = DevM.dmDisplayFrequency
    'Apply new resolution
    ChangeRes 800, 600, 16, 60
End Sub

Public Sub SetOrigRes()
    '=======================================================
    'Call this sub in Form_Unload
    '=======================================================
    
    'Change the display settings back to the old settings
    ChangeRes OldX, OldY, OldColor, OldFreq
    Do
    Loop Until ShowCursor(1) >= 1
    resChanged = False
End Sub

Public Sub ChangeRes(ScreenX As Integer, ScreenY As Integer, ScreenColor As Integer, ScreenFreq As Integer)
    '=======================================================
    'ChangeRes sub format (can be set at runtime):
    'Insert a zero if you don't want to change an aspect
    'eg:
    'ChangeRes 800, 600, 16, 60     '800x600 pixels, 16 bit Color, 60Hz
    'ChangeRes 800, 600, 16, 0      '800x600 pixels, 16 bit Color
    'ChangeRes 800, 600, 0, 60      '800x600 pixels, 60Hz
    'ChangeRes 0, 0, 16, 60         '16 bit Color, 60Hz
    'ChangeRes 0, 0, 16, 0          '16 bit Color
    'ChangeRes 800, 600, 0, 0       '800x600 pixels
    'ChangeRes 0, 0, 0, 60          '60Hz
    '=======================================================
    
    '=======================================================
    'The "EndIf" statement is used because if a "0" is used
    'in the API call, the API considers it as an aspect that
    'does not need to be changed, but is the current system
    'setting.
    'eg:
    'ChangeRes 0, 0, 0, 0   =   The current system setting
    'ChangeRes 0, 0, 16, 0  =   The current resolution and display frequency setting, with new color quality
    '=======================================================
    
    'Get selected resolution
    If ScreenX <> 0 And ScreenY <> 0 And ScreenColor = 0 And ScreenFreq = 0 Then
        DevM.dmPelsWidth = ScreenX          'Screen width
        DevM.dmPelsHeight = ScreenY         'Screen height
        DevM.dmBitsPerPel = SetColor        'Screen color quality
        DevM.dmDisplayFrequency = SetFreq   'Screen display frequency
        'SetX = ScreenX
        'SetY = ScreenY
        SaveIt ScreenX, ScreenY, ScreenColor, ScreenFreq, "ChangeResol"
        'DevM.dmFields = DM_PELSWIDTH Or DM_PELSHEIGHT
    ElseIf ScreenX = 0 And ScreenY = 0 And ScreenColor <> 0 And ScreenFreq = 0 Then
        DevM.dmPelsWidth = SetX             'Screen width
        DevM.dmPelsHeight = SetY            'Screen height
        DevM.dmBitsPerPel = ScreenColor     'Screen color quality
        DevM.dmDisplayFrequency = SetFreq   'Screen display frequency
        'SetColor = ScreenColor
        SaveIt ScreenX, ScreenY, ScreenColor, ScreenFreq, "ChangeColor"
        'DevM.dmFields = DM_BITSPERPEL
    ElseIf ScreenX = 0 And ScreenY = 0 And ScreenColor = 0 And ScreenFreq <> 0 Then
        DevM.dmPelsWidth = SetX                 'Screen width
        DevM.dmPelsHeight = SetY                'Screen height
        DevM.dmBitsPerPel = SetColor            'Screen color quality
        DevM.dmDisplayFrequency = ScreenFreq    'Screen display frequency
        'SetFreq = ScreenFreq
        SaveIt ScreenX, ScreenY, ScreenColor, ScreenFreq, "ChangeFreq"
        'DevM.dmFields = DM_DISPFREQ
    ElseIf ScreenX <> 0 And ScreenY <> 0 And ScreenColor <> 0 And ScreenFreq <> 0 Then
        DevM.dmPelsWidth = ScreenX             'Screen width
        DevM.dmPelsHeight = ScreenY            'Screen height
        DevM.dmBitsPerPel = ScreenColor        'Screen color quality
        DevM.dmDisplayFrequency = ScreenFreq   'Screen display frequency
        SaveIt ScreenX, ScreenY, ScreenColor, ScreenFreq, "ChangeAll"
        'DevM.dmFields = DM_PELSWIDTH Or DM_PELSHEIGHT Or DM_BITSPERPEL Or DM_DISPFREQ
    ElseIf ScreenX = 0 And ScreenY = 0 And ScreenColor = 0 And ScreenFreq = 0 Then
        Exit Sub
    End If
    'we want to change the horizontal and the vertical
    'resolution, the color quality, and the display
    'frequency (screen refresh rate)
    DevM.dmFields = DM_PELSWIDTH Or DM_PELSHEIGHT Or DM_BITSPERPEL Or DM_DISPFREQ
    'change the display settings
    Call ChangeDisplaySettingsEx(ByVal 0&, DevM, ByVal 0&, CDS_TEST, ByVal 0&)
End Sub

Private Sub SaveIt(ScX As Integer, ScY As Integer, ScC As Integer, ScF As Integer, ScreenChanged As String)
    Select Case ScreenChanged
        Case "ChangeResol"
            SetX = ScX      'Screen width
            SetY = ScY      'Screen height
        Case "ChangeColor"
            SetColor = ScC  'Screen color quality
        Case "ChangeFreq"
            SetFreq = ScF   'Screen display frequency
        Case "ChangeAll"
            SetX = ScX      'Screen width
            SetY = ScY      'Screen height
            SetColor = ScC  'Screen color quality
            SetFreq = ScF   'Screen display frequency
    End Select
End Sub

'===========================================================
'Example of code for form:
'Private Sub cmdChange_Click(Index As Integer)
'    Select Case Index
'        Case 0
'            '1024x768x16x60
'            ChangeRes 1024, 768, 0, 0
'        Case 1
'            '800x600x32x85
'            ChangeRes 800, 600, 32, 85
'        Case 2
'            '800x600x16x85
'            ChangeRes 0, 0, 16, 0
'        Case 3
'            '800x600x16x60
'            ChangeRes 0, 0, 0, 60
'    End Select
'End Sub
'
'Private Sub Form_Load()
'    GetCurrentRes
'End Sub
'
'Private Sub Form_Unload(Cancel As Integer)
'    SetOrigRes
'End Sub
'===========================================================


'Common Screen Resoulutions:
'==============='
'Width   Height '
'==============='
'640     480    '
'800     600    '
'1024    768    '
'1280    1024   '
'1600    1200   '
'==============='
'
'Common Color Qualities:
'==============================================================='
'Bits   # colors        Common Name
'==============================================================='
'4      16              16 Colors                               '
'8      256             256 Colors                              '
'16     65,536          High Color (16-Bit)                     '
'24     16,777,216      True Color (24-bit)                     '
'32     4,294,967,296   True Color (32-Bit/24bit + 8bit Alpha)  '
'==============================================================='
