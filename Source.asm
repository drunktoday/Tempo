includelib winmm.lib
INCLUDE Irvine32.inc
INCLUDE macros.inc
PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

main          EQU start@0

chosOne proto,pl: ptr BYTE,se: ptr BYTE
callmode proto,mo : ptr BYTE

.data

ground BYTE "--------------------------------------------------",0

clearScore byte "                                                                             ",0
strScore BYTE "score: ",0
score SDWORD 0
highScore sdword 0
historyScore byte "history: ",0
perfectCount byte 0

temp byte "  ",0

dis byte 15,15,15,15,13,13,13,13,13,13,12,13,13,13,12,13,13,13,14,13,13,25
	byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,25,13,13,13,60
	byte 15,20,15,25,12,12,12,15,15,15,25,15,15,15,12,13,15,15,14,15,15,60
	byte 20,20,25,25,13,13,13,15,15,15,12,15,15,15,12,13,15,15,14,15,15,60
	byte 20,20,25,25,12,13,15,15,15,15,12,15,15,15,12,13,15,15,14,15,15,60
	byte 15,20,15,25,17,12,12,15,15,15,25,15,15,15,12,13,15,15,14,15,15,60
	byte 15,20,15,25,12,12,13,15,15,15,25,15,15,15,12,13,15,15,12,14,14,60
index DWord 0
first dword 0
RB BYTE 119
LB BYTE 5
line byte 13
line2 byte 22
line3 byte 19
Current_xPos byte 0

speed1 dword 15
score_level dword 20

xPos BYTE 119
yPos BYTE 25

;xPos2 BYTE 5
;yPos2 BYTE 20

xCoinPos BYTE 13
yCoinPos BYTE 25

inputChar BYTE ?
rightbound BYTE 51

endCount BYTE 1		;結束遊戲計數器

HPcount BYTE 5		;生命值
HPstringHT BYTE  "**",0
HPstringHMPT byte "******",0
HPstringPL byte "*",0


HPdraw BYTE  "***",0
HPdraw1 Byte  "*******",0
HPdraw2 byte "*****",0
HPdraw3 byte "***",0

HPblank BYTE  "   ",0


choose1 DWORD 0
MODE bYTE 0
consoleHandle    DWORD ?
xyInit COORD <0,0>
xyGO COORD <2,2>
xyCH COORD <2,1>
xyopen COORD <0,0>
xyPos COORD <0,23> 
xyPlay COORD <0,15> 
xyShowScore COORD <50,10>
;;;;;;;;;;;;;;;;;;;;;;;;TIMING
timing_xPos byte 43
timing_yPos byte 15

timing_xPos1 byte 44
timing_yPos1 byte 15

timing_xPos2 byte 45
timing_yPos2 byte 15

timingFlag byte 0

timingDraw byte  "MISS    ",0
timingDraw1 byte "GOOD    ",0
timingDraw2 byte "PERFECT",0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

combo_xPos byte 13
combo_yPos byte 18

combo_xPos2 byte 14
combo_yPos2 byte 15
comboFlag byte 0

comboDraw byte "COMBO X ",0
clearcombo byte "                          ",0
clearPerfect byte "                                                                                          ",0

comboCount dword 0


goodString byte "GGGGGG OOOOOO OOOOOO DDDDD   ",0dh,0ah
		   byte "                                               G      O    O O    O D    D  ",0dh,0ah
		   byte "                                               G  GGG O    O O    O D     D ",0dh,0ah
		   byte "                                               G    G O    O O    O D    D  ",0dh,0ah
		   byte "                                               GGGGGG OOOOOO OOOOOO DDDDD   ",0

goodStringLight byte "||   GGGGGG OOOOOO OOOOOO DDDDD   ",0dh,0ah
		        byte "                                            ||   G      O    O O    O D    D   ||",0dh,0ah
		        byte "                                            ||   G  GGG O    O O    O D     D  ||",0dh,0ah
				byte "                                            ||   G    G O    O O    O D    D   ||",0dh,0ah
				byte "                                            ||   GGGGGG OOOOOO OOOOOO DDDDD    ||",0


missString byte "MMM MMM IIIIII SSSSS SSSSS ",0dh,0ah
		   byte "                                              M  M  M   II   S     S     ",0dh,0ah
		   byte "                                              M  M  M   II   SSSSS SSSSS ",0dh,0ah
		   byte "                                              M  M  M   II       S     S ",0dh,0ah
		   byte "                                              M     M IIIIII SSSSS SSSSS ",0

missStringLight byte "||   MMM MMM IIIIII SSSSS SSSSS  ||",0dh,0ah
		   byte "                                           ||   M  M  M   II   S     S      ||",0dh,0ah
		   byte "                                           ||   M  M  M   II   SSSSS SSSSS  ||",0dh,0ah
		   byte "                                           ||   M  M  M   II       S     S  ||",0dh,0ah
		   byte "                                           ||   M     M IIIIII SSSSS SSSSS  ||",0
perfectString byte "PPPPP EEEEE RRRRR  FFFFF EEEEE CCCCC TTTTT ",0dh,0ah
			  byte "                                                P   P E	    R    R F     E     C       T   ",0dh,0ah
		      byte "                                                pppp  EEEEE RRRRR  FFFFF EEEEE C       T   ",0dh,0ah
		      byte "                                                p     E     R   R  F     E     C       T   ",0dh,0ah
		      byte "                                                p     EEEEE R    R F     EEEEE CCCCC   T   ",0
			   
perfectStringLight byte "||   PPPPP EEEEE RRRRR  FFFFF EEEEE CCCCC TTTTT  || ",0dh,0ah
				   byte "                                             ||   P   P E     R    R F     E     C       T    || ",0dh,0ah
		           byte "                                             ||   pppp  EEEEE RRRRR  FFFFF EEEEE C       T    || ",0dh,0ah
		           byte "                                             ||   p     E     R   R  F     E     C       T    || ",0dh,0ah
		           byte "                                             ||   p     EEEEE R    R F     EEEEE CCCCC   T    || ",0
			   

gamewin   BYTE 	 " ***********************************************************************************************************************", 0Dh,0Ah
		  BYTE	 " *   WW         WW          WW               IIIIIIIIIIIIIIIIIIIIIIIII               NNNN                    NN        *", 0Dh,0Ah
		  BYTE	 " *   WW        W  WW        WW                         IIIII                         NNN NN                  NN        *", 0Dh,0Ah
		  BYTE	 " *   WW       W    WW       WW                         IIIII                         NN    NN                NN        *", 0Dh,0Ah
		  BYTE	 " *   WW      W      WW      WW                         IIIII                         NN      NN              NN        *", 0Dh,0Ah
		  BYTE	 " *   WW     W        WW     WW                         IIIII                         NN        NN            NN        *", 0Dh,0Ah
		  BYTE	 " *   WW    W          WW    WW                         IIIII                         NN          NN          NN        *", 0Dh,0Ah
		  BYTE	 " *   WW   W            WW   WW                         IIIII                         NN            NN        NN        *", 0Dh,0Ah
		  BYTE	 " *   WW  W              WW  WW                         IIIII                         NN              NN      NN        *", 0Dh,0Ah
		  BYTE	 " *   WW W                WW WW                         IIIII                         NN                NN    NN        *", 0Dh,0Ah
		  BYTE	 " *   WWW                  WWWW                         IIIII                         NN                  NN NNN        *", 0Dh,0Ah
		  BYTE	 " *   WW                    WWW               IIIIIIIIIIIIIIIIIIIIIIIII               NN                    NNNN        *", 0Dh,0Ah
		  BYTE	 " ***********************************************************************************************************************",0

gameover  BYTE 	 " ***********************************************************************************************************************", 0Dh,0Ah
		  BYTE	 " *    MMMMMMMMMMMMMM                   EEEEEEEEEEEEEE                    A                      DDDDDDDDDDDDD           ", 0Dh,0Ah
		  BYTE	 " *    MM          MMM                 EE                               A  AA                   D          DDD           ", 0Dh,0Ah
		  BYTE	 " *    MM           MMMM              EE                              A    AA                 D           DDDD           ", 0Dh,0Ah
		  BYTE	 " *    MM            MMMM            EE                             A      AA                 D             DDDD         ", 0Dh,0Ah
		  BYTE	 " *    MM              MMMM         EE                            A        AA                D              DDDD         ", 0Dh,0Ah
		  BYTE	 " *    MM               MMMM       EEEEEEEEEEEEE                A          AA               D               DDDD         ", 0Dh,0Ah
		  BYTE	 " *    MM              MMMM       EE                          AAAAAAAAAAAAAAA              D              DDDD           ", 0Dh,0Ah
		  BYTE	 " *    MM           MMMM         EE                         A              AA             D             DDDD             ", 0Dh,0Ah
		  BYTE	 " *    MM        MMMMM          EE                        A                AA            D            DDDD               ", 0Dh,0Ah
		  BYTE	 " *    MM       MMMM           EE                       A                  AA           D           DDDD                 ", 0Dh,0Ah
		  BYTE	 " *    MMMMMMMMMMM            EEEEEEEEEEEEE           A                    AA          DDDDDDDDDDDDDD                    ", 0Dh,0Ah
		  BYTE	 " *                                                                                                                      ", 0Dh,0Ah
		  BYTE	 " ***********************************************************************************************************************",0


topic BYTE 	 " ********************************************************************************************************************** ", 0Dh,0Ah
      BYTE	 " *   TTTTTTTTTTTTTTTTTTT     EEEEEEEEEEEEEE     M                   MM     PPPPPPPPPPP           OOOOOOOOOOOOO        * ", 0Dh,0Ah      
      BYTE	 " *   TTTTTTTTTTTTTTTTTTT     EE                 MM                 MMM     PP         PP       OO             OO      * ", 0Dh,0Ah
      BYTE	 " *           TTT             EE                 MMM               MMMM     PP          PP      OO             OO      * ", 0Dh,0Ah
      BYTE	 " *           TTT             EE                 MM M             MM MM     PP           PP     OO             OO      * ", 0Dh,0Ah
      BYTE	 " *           TTT             EE                 MM  M           MM  MM     PP          PP      OO             OO      * ", 0Dh,0Ah
      BYTE	 " *           TTT             EEEEEEEEEEEEEE     MM   M         MM   MM     PP        PP        OO             OO      * ", 0Dh,0Ah
      BYTE	 " *           TTT             EE                 MM    M       MM    MM     PPPPPPPPPP          OO             OO      * ", 0Dh,0Ah
      BYTE	 " *           TTT             EE                 MM     M     MM     MM     PP                  OO             OO      * ", 0Dh,0Ah
      BYTE	 " *           TTT             EE                 MM      M   MM      MM     PP                  OO             OO      * ", 0Dh,0Ah
      BYTE	 " *           TTT             EE                 MM       M MM       MM     PP                  OO             OO      * ", 0Dh,0Ah
      BYTE	 " *           TTT             EEEEEEEEEEEEEE     MM        MM        MM     PP                    OOOOOOOOOOOOO        * ", 0Dh,0Ah
      BYTE	 " *                                                                                                                    * ", 0Dh,0Ah
      BYTE	 " ********************************************************************************************************************** ", 0Dh,0Ah,0

playbu BYTE  "                                                                              ", 0Dh,0Ah
       BYTE	 "                                        PPPPPP  L           AA     Y       Y  ", 0Dh,0Ah
       BYTE	 "                                        P     P L          AA A     Y     Y   ", 0Dh,0Ah
       BYTE	 "                                        P     P L         AA   A      Y Y     ", 0Dh,0Ah
       BYTE	 "                                        PPPPPP  L        AAAAAAAA      Y      ", 0Dh,0Ah
       BYTE	 "                                        P       L        AA     A      Y      ", 0Dh,0Ah
       BYTE	 "                                        P       LLLLLLL AA       A     Y      ", 0Dh,0Ah
       BYTE	 "                                                                              ", 0Dh,0Ah,0
	   
playch BYTE  "                                     ┌───────────────────────────────────────┐                                     ", 0Dh,0Ah
       BYTE	 "                                     │  PPPPPP  L           AA     Y       Y │ ", 0Dh,0Ah                                                              
       BYTE	 "                                     │  P     P L          AA A     Y     Y  │ ", 0Dh,0Ah                                                                 
       BYTE	 "                                     │  P     P L         AA   A      Y Y    │ ", 0Dh,0Ah                                                              
       BYTE	 "                                     │  PPPPPP  L        AAAAAAAA      Y     │ ", 0Dh,0Ah                                                              
       BYTE	 "                                     │  P       L        AA     A      Y     │ ", 0Dh,0Ah                                                              
       BYTE	 "                                     │  P       LLLLLLL AA       A     Y     │ ", 0Dh,0Ah                                                              
       BYTE	 "                                     └───────────────────────────────────────┘                                     ", 0Dh,0Ah,0

setbu  BYTE  "                                                                                                                   ", 0Dh,0Ah
       BYTE	 "                                                SSSSSS  EEEEEE TTTTTTT                                             ", 0Dh,0Ah
       BYTE	 "                                                SSSS    E         TT                                               ", 0Dh,0Ah
       BYTE	 "                                                  SSSS  EEEEEE    TT                                               ", 0Dh,0Ah
       BYTE	 "                                                     S  E         TT                                               ", 0Dh,0Ah
       BYTE	 "                                                SSSSSS  EEEEEE    TT                                               ", 0Dh,0Ah
       BYTE	 "                                                                                                                   ", 0Dh,0Ah,0
	   
setch  BYTE  "                                         ┌─────────────────────────────────┐                                       ", 0Dh,0Ah
       BYTE	 "                                         │      SSSSSS  EEEEEE TTTTTTT     │                                       ", 0Dh,0Ah
       BYTE	 "                                         │      SSSS    E         TT       │                                       ", 0Dh,0Ah
       BYTE	 "                                         │        SSSS  EEEEEE    TT       │                                       ", 0Dh,0Ah
       BYTE	 "                                         │           S  E         TT       │                                       ", 0Dh,0Ah
       BYTE	 "                                         │      SSSSSS  EEEEEE    TT       │                                       ", 0Dh,0Ah
       BYTE	 "                                         └─────────────────────────────────┘                                       ", 0Dh,0Ah,0


modeEA BYTE  "                                                                                                                  ", 0Dh,0Ah
       BYTE	 "                                              M   M   OOO   DDD   EEEE            M      M U   U SSSSS IIIII  CCCC  ", 0Dh,0Ah
       BYTE	 "                                              MM MM  OO OO  D  D  E       O       MM    MM U   U SSS     I   C     ", 0Dh,0Ah
       BYTE	 "                                              M M M  O   O  D  D  EEE          <- M M  M M U   U  SSSS   I   C     ->  ", 0Dh,0Ah
       BYTE	 "                                              M M M  OO OO  D  D  E       O       M  MM  M U   U     S   I   C    ", 0Dh,0Ah
       BYTE	 "                                              M M M   OOO   DDD   EEEE            M  MM  M  UUU  SSSSS IIIII  CCCC   ", 0Dh,0Ah
       BYTE	 "                                                                                 ───────────────────────────────── ", 0Dh,0Ah,0

modeHA BYTE  "                                                                                                                   ", 0Dh,0Ah
       BYTE	 "                                              M   M   OOO   DDD   EEEE            SSSSS H   H  OOOO  U    U TTTTT  ", 0Dh,0Ah
       BYTE	 "                                              MM MM  OO OO  D  D  E       O       SSS   H   H O    O U    U   T    ", 0Dh,0Ah
       BYTE	 "                                              M M M  O   O  D  D  EEE          <-  SSSS HHHHH O    O U    U   T    -> ", 0Dh,0Ah
       BYTE	 "                                              M M M  OO OO  D  D  E       O           S H   H O    O U    U   T    ", 0Dh,0Ah
       BYTE	 "                                              M M M   OOO   DDD   EEEE            SSSSS H   H  OOOO   UUUU    T    ", 0Dh,0Ah
       BYTE	 "                                                                                 ─────────────────────────────────  ", 0Dh,0Ah,0


stickman_stand BYTE "●_____● ",0dh,0ah
			   BYTE " |     |  ",0dh,0ah
			   BYTE " |● ●|  ",0dh,0ah
			   BYTE " |_____|  ",0dh,0ah
			   BYTE "   /|\  ",0dh,0ah
			   BYTE "  / | \   ",0dh,0ah
			   BYTE "   / \   ",0dh,0ah
			   BYTE "  /   \  ",0
			 
stickman_hit   BYTE "●_____● ",0dh,0ah
			   BYTE " |     |  ",0dh,0ah
			   BYTE " |● ●|  ",0dh,0ah
			   BYTE " |_____|  ",0dh,0ah
			   BYTE "   /|\_/  ",0dh,0ah
			   BYTE "  / | __/ ",0dh,0ah
			   BYTE "   _|/    ",0dh,0ah
			   BYTE "  /       ",0 

stickman_miss  BYTE "  ●_____●",0dh,0ah
			   BYTE "   |     | ",0dh,0ah
			   BYTE "   |● ●| ",0dh,0ah
			   BYTE "   |_____| ",0dh,0ah
			   BYTE " /|\    ",0dh,0ah
			   BYTE "/ | \   ",0dh,0ah
			   BYTE " / \    ",0dh,0ah
			   BYTE "/   \   ",0


stickman_blank BYTE "           ",0dh,0ah
			   BYTE "          ",0dh,0ah
			   BYTE "          ",0dh,0ah
			   BYTE "          ",0dh,0ah
			   BYTE "          ",0dh,0ah
			   BYTE "          ",0dh,0ah
			   BYTE "          ",0dh,0ah
			   BYTE "          ",0

move_count BYTE 2
;deviceConnect BYTE "DeviceConnect",0
SND_ALIAS    DWORD 00010000h
SND_RESOURCE DWORD 00040005h
SND_FILENAME DWORD 00020000h
RE dword ?
SND_ASYNC dword 1h
file BYTE "aa.wav",0
file2 BYTE "aaa.wav",0
file3 BYTE "high.wav",0
file4 BYTE "play_choose.wav",0
file5 BYTE "menu_music.wav",0
file6 BYTE "set_easy.wav",0
file7 BYTE "set_difficult.wav",0
file8 BYTE "without_you.wav",0
file9 BYTE "cow.wav",0

upflag BYTE 0
upCount BYTE 0
movementflag BYTE 0
movementCount BYTE 0
.code
main PROC,argc : byte ,argv : ptr byte
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MENU
MENU_START:
INVOKE  GetStdHandle, STD_OUTPUT_HANDLE
mov consoleHandle,eax
mov score,0
mov index,0
mov first,0
mov xPos,119
mov score_level,20
mov upflag,0
mov upCount,0
mov speed1, 15
mov perfectCount,0
mov timingflag,0
mov movementflag,0
mov movementCount,0

mov eax,8
or eax,SND_ASYNC
mov RE, eax
FACE1:
	INVOKE PlaySound, OFFSET file5, null, RE
	mov eax, yellow(black*16)
	call SetTextColor	 
	mov edx , OFFSET topic
	call WriteString
	call Crlf
	mov eax, white(black*16)
	call SetTextColor
	mov edx , OFFSET playch
	call WriteString
	mov edx , OFFSET setbu
	call WriteString


  START:
    invoke SetConsoleCursorPosition ,consoleHandle,xyInit   
    call ReadChar 

	
	.IF ax == 4800h && choose1 <= 1;UP
		mov choose1,0
		invoke chosOne,addr playch,addr setbu
		jmp START

	.ELSEIF ax == 5000h && choose1 <=1 ;DOWN
		mov choose1,1
		invoke chosOne,addr playbu,addr setch
		jmp START
		
	.ELSEIF ax == 3920h && choose1 == 0 ;play
		INVOKE PlaySound, OFFSET file4, NULL, SND_ASYNC
		call clrscr
		INVOKE PlaySound,NULL, NULL, 0
		jmp StartGame

	.ELSEIF ax == 4B00h && choose1 > 1  ;Easy mode choose, Left shift
		INVOKE PlaySound, OFFSET file7, NULL, SND_ASYNC
		mov choose1,2
		invoke callmode ,addr modeEA
		jmp START

	.ELSEIF ax == 4D00h && choose1 > 1  ;Hard mode choose, Right shift
		INVOKE PlaySound, OFFSET file6, NULL, SND_ASYNC
		mov choose1,3
		invoke callmode ,addr modeHA
		jmp START

	.ELSEIF ax == 3920h && choose1 == 1 ;Set print difficulty
		INVOKE PlaySound, OFFSET file7, NULL, SND_ASYNC
		mov choose1,2
		.IF MODE==0
			invoke callmode ,addr modeEA
		.ELSE
			invoke callmode ,addr modeHA
		.ENDIF
			jmp START

	.ELSEIF ax == 3920h && choose1 == 2;space  ;esay
		INVOKE PlaySound, OFFSET file5, NULL, SND_ASYNC
		mov MODE,0
		mov choose1,1
		invoke chosOne,addr playbu,addr setch
		jmp START

	.ELSEIF ax == 3920h && choose1 == 3;space ;difficult
		INVOKE PlaySound, OFFSET file5, NULL, SND_ASYNC
		mov MODE,1
		mov choose1,1
		invoke chosOne,addr playbu,addr setch
		jmp START
	
	.ELSE
		jmp START
.ENDIF



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START GAME

StartGame:
	mov dl,0
	mov dh,21
	call Gotoxy
	mov eax,238
	call SetTextColor

	;畫底下的背景
	mov ecx,10
drawBackgroundY:
	push ecx
	mov ecx,119
drawBackgroundX:
	mov al," "
	call WriteChar
	loop drawBackgroundX
	pop ecx
	loop drawBackgroundY

	;選擇難易度
	cmp MODE, 0	 ;難易度: easy, 生命值會有5, hard只會有3
	je easyHP

	difficultHP: 
		mov HPcount, 5
		mov movementflag,0
		call draw_movement
		jmp gameLoop
	
	easyHP:  
		mov HPcount, 8
		INVOKE PlaySound, OFFSET file7, NULL, SND_ASYNC
		mov movementflag,0
		call draw_movement
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GAMELOOP

	
	gameLoop:		
		call DrawCoin
		mov eax,white (black * 16)
		call SetTextColor

		mov dl,0
		mov dh,0
		call Gotoxy
		mov edx,offset clearScore
		call WriteString

		mov dl,0
		mov dh,0
		call Gotoxy
		mov edx,OFFSET strScore
		call WriteString
		
		mov eax,score
		call WriteInt

		;印生命值
		drawHP:

			mov eax,white (black *16)
			call SetTextColor

			mov dl,0
			mov dh,4
			call Gotoxy
			mov ecx,4
			push edx
			CC:
				mov edx,offset clearScore
				call WriteString
				pop edx
				add dh,1
				push edx
				call Gotoxy
				loop CC

			pop edx

			mov al, 1
			mov dl,-6
			mov dh,4
			call Gotoxy
			push edx
			HPstar:						;印生命值星星
				inc al
				pop edx
				push eax
			
				mov eax,red (red * 16)
				call SetTextColor
				
				add dl,6
				mov dh,4
				call Gotoxy
				push edx
				mov edx, OFFSET HPdraw
				call WriteString
				mov eax,black (black * 16)
				call SetTextColor
				mov edx, OFFSET HPstringPL
				call WriteString

				mov eax,red (red * 16)
				call SetTextColor
				mov edx, OFFSET HPdraw
				call WriteString

				pop edx

				
				add dh,1
				push edx
				call Gotoxy
				

				mov edx, OFFSET HPdraw1
				call WriteString

				pop edx
				
				add dl,1
				add dh,1
				push edx
				call Gotoxy
				mov edx, OFFSET HPdraw2
				call WriteString

				pop edx
				pop eax
				add dl,1
				add dh,1
				push edx
				call Gotoxy
				mov edx,offset HPdraw3
				call WriteString
				

				cmp HPcount, 0			;生命值歸零
				je lose

				cmp al, HPcount
				jbe HPstar

				mov eax,white (black * 16)
				call setTextColor
				mov edx, OFFSET HPblank
				call WriteString	
		
		
		
		
		onGround:
				
			moveRight:
				inc upCount
				inc movementCount
				.IF perfectCount != 0
					inc perfectCount
				.ENDIF

				.IF perfectCount == 3
					call drawtiming
					mov perfectCount,0
				.ENDIF

				.IF upCount==1
					.IF upflag==1
						.IF combo_yPos!=15
							call updatecombo
							dec combo_yPos
							.IF comboCount>0
								call Drawcombo
								call DrawcomboNum
							.ENDIF
						.ELSEIF combo_yPos==15
							mov upflag,0
							call updatecombo
							mov combo_yPos,20
						.ENDIF
					
					.ELSEIF upflag==0
						call updatecombo
						mov combo_yPos,20
					.ENDIF
					mov upCount,0
					
				.ENDIF

				;;;;;;;;;;;;;;;;;;;;人物圖片更換

				.IF movementCount==5
					.IF upflag==1
						call draw_movement
						mov movementflag,0 
						call draw_movement
					.ENDIF
					mov movementCount,0

				.ELSE
					call draw_movement
				.ENDIF

				
				
				call UpdatePlayer
				call DrawCoin
				mov eax,blue (blue * 16)
				call SetTextColor
				dec xPos
				mov al,xPos
				push eax
				call DrawPlayer
				
				
				mov eax,speed1
				call delay

				next:
					mov eax,index
					cmp eax,153
					ja move
					mov esi,index
					mov al,xPos
					add al,dis[esi]
					cmp al,RB
					jb clear 
					jae move 

				clear:
					mov xPos,al
					inc xPos
					call UpdatePlayer
					dec xPos
					call DrawPlayer
					add index,1 
					jmp next
				move:
					pop eax
					mov xPos,al
					mov eax,first
					mov index,eax
					
					;加難度(看分數超過XXX)
					mov eax,score_level
					cmp score,eax
					jl here

					;判斷速度是否已經不能再快了(delay < 1)
					mov eax, speed1
					cmp eax,1
					je here

					;加速
					dec speed1
					add score_level,35

					here:
						mov al,line
						cmp xPos,al
						je check_key
						jb del

						mov al,line2
						cmp xPos,al
						jb check_key2
						jmp gameLoop

				check_key:
					;;;;;call FlushConsoleInputBuffer
					.IF comboCount<=0
						call updatecombo
					.ENDIF
 					call ReadKey
					cmp al, 1
					je die
					cmp ax,3920h
					je space
					cmp al,20
					je space
					

				check_key2:
					.IF comboCount<=0
						call updatecombo
					.ENDIF
					mov al,line3
					cmp xPos,al
					jbe gameLoop


					call ReadKey
					cmp ax,3920h
					je die2
					cmp al,20
					je die2
					jmp gameLoop

				die:
					mov eax, black(black*16)
					call SetTextColor
					call updatetiming
					mov comboCount,0
					call updatecombo
    				dec score
					dec HPcount	

					;;;;;;;;MISS
					call updatetiming
					mov timingFlag, 0
					call Drawtiming

					;;;;;;;;change movement to dodge
					mov movementflag,2
					jmp gameLoop

					

				die2:			
					;;;;;;;;GOOD
					mov eax, black(black*16)
					call SetTextColor

					call updatetiming

					mov timingFlag, 1
					call Drawtiming

					;;;;;;;;;;;COMBO
					mov comboCount,0
					call updatecombo
					dec score
					call UpdatePlayer
					mov esi,first
					inc first

					;結束遊戲
					mov eax,first
					mov endCount,al
					cmp endCount,155	
					je exitGame

					mov al,xPos
					add al,dis[esi]
					cmp al,RB
					mov xPos,al
					inc index
					mov movementflag,0
				
				del:
 					mov al,LB
					cmp xPos,al
					ja moveRight
					call UpdatePlayer
					
					mov esi,first
					inc first

					;可以活多久
  					mov eax,first
					mov endCount,al
					cmp endCount,155	
					je exitGame

					mov al,xPos
					add al,dis[esi]
					mov xPos,al
					inc index
					jmp gameLoop

			space:
				mov upflag,1
				mov al,Mode
				cmp al,0
				je Perfect
				
				.IF combocount<=15
					INVOKE PlaySound, OFFSET file, NULL, SND_ASYNC
				.ELSEIF combocount>15&&comboCount<=30
					INVOKE PlaySound, OFFSET file2, NULL, SND_ASYNC
				.ELSE
					INVOKE PlaySound, OFFSET file3, NULL, SND_ASYNC
				.ENDIF


				;;;;;;;;PERFECT

				Perfect:
					.IF combocount<=15
						inc score
					.ELSEIF combocount>15&&comboCount<=30
						add score,3
					.ELSE
						add score,5
					.ENDIF

					
					mov eax, black(black*16)
					call SetTextColor
					call updatetiming
					mov timingflag,2
					call Drawtiming


				;;;;;;;;;clear previous movement
					mov dl, 0
					mov dh, 22
					call Gotoxy
					mov edx, OFFSET stickman_blank
					mov eax,yellow (yellow * 16)
					call SetTextColor
					call WriteString
				;;;;;;;;;;change next movement
					mov dl, 0
					mov dh, 22
					call Gotoxy
					mov edx, OFFSET stickman_hit
					mov eax,red (yellow * 16)
					call SetTextColor
					call WriteString
				mov movementflag,1
				inc first
				call drawPlayer_match
				call UpdatePlayer
				call DrawCoin

				;結束遊戲
				mov eax,first
				mov endCount,al
				cmp endCount,155	
				je exitGame

				mov esi,index
				mov al,xPos
				add al,dis[esi]
				cmp al,RB
				mov xPos,al
				inc index

				inc score
				inc comboCount
				.IF comboCount>0
					call drawCombo
					call DrawcomboNum
				.ENDIF
				;死亡計數器加一
				inc endCount
				jmp gameLoop


	exitGame:
		mov eax,score
		cmp eax,highScore
		jng Dothis
		mov highScore,eax 

		Dothis:
		mov eax,white (black * 16)
		call SetTextColor
		call clrscr
		mov eax,white (green * 16)
		call SetTextColor
		mov dl,0
		mov dh,5
		call Gotoxy
		mov edx,OFFSET gamewin
		call WriteString
		mov eax,black (black * 16)
		call SetTextColor
		call waitMsg
		mov eax,white (black * 16)
		call SetTextColor
		call Clrscr
		mov dl,52
		mov dh,15
		call Gotoxy
		mov edx, offset strScore
		call WriteString
		mov eax,score
		call WriteInt
		mov dl,52
		mov dh,17
		call Gotoxy
		mov edx,offset historyScore
		call WriteString
		mov eax,highScore
		call WriteInt
		mov eax,black (black * 16)
		call SetTextColor
		call waitMsg
		call Clrscr
		jmp MENU_START

	lose:
		INVOKE PlaySound, NULL,NULL, 0
		INVOKE PlaySound, OFFSET file9, NULL, SND_ASYNC
		mov eax,white (black * 16)
		call SetTextColor
		call clrscr
		mov eax,yellow (red * 16)
		call SetTextColor
		mov dl,0
		mov dh,5
		call Gotoxy
		mov edx,OFFSET gameover
		call WriteString
		mov eax,black (black * 16)
		call SetTextColor
		call waitMsg
		call Clrscr
		jmp MENU_START


	end_G:
	
invoke exitProcess,0
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
drawPlayer_match PROC
	mov eax,red (red*16)
	call SetTextColor
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov edx,offset temp
	call WriteString
	mov dl,xPos
	mov dh,yPos
	inc dh
	call Gotoxy
	mov edx,offset temp
	call WriteString
	mov eax,5
	call delay
	ret
drawPlayer_match ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawPlayer PROC
	; draw player at (xPos,yPos):
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov edx,offset temp
	call WriteString
	mov dl,xPos
	mov dh,yPos
	inc dh
	call Gotoxy
	mov edx,offset temp
	call WriteString
	ret
DrawPlayer ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdatePlayer PROC
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov eax,238
	call SetTextColor

	mov edx,offset temp
	call WriteString
	mov dl,xPos
	mov dh,yPos
	inc dh
	call Gotoxy
	mov edx,offset temp
	call WriteString

	mov eax,blue (blue * 16)
	call SetTextColor
	ret
UpdatePlayer ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawCoin PROC
	mov eax,black (black * 16)
	call SetTextColor
	mov dl,xCoinPos
	mov dh,yCoinPos
	call Gotoxy
	mov edx,offset temp
	call WriteString
	mov dl,xCoinPos
	mov dh,yCoinPos
	inc dh
	call Gotoxy
	mov edx,offset temp
	call WriteString
	mov eax,blue (blue * 16)
	call SetTextColor
	ret
DrawCoin ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

chosOne PROC,pl: ptr BYTE,se: ptr BYTE
	invoke SetConsoleCursorPosition ,consoleHandle,xyPlay

	mov edx , pl
	call WriteString
	mov edx , se
	call WriteString
	invoke SetConsoleCursorPosition ,consoleHandle,xyInit   
ret
chosOne ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

callmode PROC,mo: ptr BYTE
	invoke SetConsoleCursorPosition ,consoleHandle,xyPos
	mov edx , mo
	call WriteString
	invoke SetConsoleCursorPosition ,consoleHandle,xyInit   
ret
callmode ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Drawcombo PROC
	call updatecombo
    mov eax,11 (black*16)
	call SetTextColor
	.IF comboFlag==0
		mov dl,combo_xPos
		mov dh,combo_yPos
	.ELSE
		mov dl,combo_xPos2
		mov dh,combo_yPos2
	.ENDIF
	call Gotoxy
	mov edx,offset comboDraw 
	call WriteString

	
	mov eax,blue (blue * 16)
	call SetTextColor
	ret
Drawcombo ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DrawcomboNum PROC
   
	.IF comboFlag==0
		mov dl,21
		mov dh,combo_yPos
		
		;mov comboFlag,1
	.ELSE
		mov dl,22
		mov dh,combo_yPos2
		
		;mov comboFlag,0
	.ENDIF
	call Gotoxy
	

	.IF comboCount>5&&comboCount<11
		mov eax,14 (black*16)
		call SetTextColor
	.ELSEIF comboCount>10&&comboCount<16
		mov eax,6 (black * 16)
		call SetTextColor
	.ELSEIF comboCount<=5
		mov eax,white (black * 16)
		call SetTextColor
	.ELSEIF comboCount>15&&comboCount<21
		mov eax,9 (black * 16)
		call SetTextColor
	.ELSEIF comboCount>20&&comboCount<26
		mov eax,12 (black * 16)
		call SetTextColor
	.ELSE
		mov eax,red (black * 16)
	    call SetTextColor
	.ENDIF 
	mov eax,0
	mov eax,comboCount
	call Writedec
	
	mov eax,blue (blue * 16)
	call SetTextColor
	ret
DrawcomboNum ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

updatecombo PROC

	mov eax,white (black * 16)
	call SetTextColor
	.IF comboFlag==1
		mov dl,combo_xPos
		mov dh,combo_yPos
	.ELSE
		mov dl,combo_xPos
		mov dh,combo_yPos
	.ENDIF
	call Gotoxy
	mov  edx,offset clearcombo
	call WriteString
	mov eax,blue (blue * 16)
	call SetTextColor
	ret
updatecombo ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Drawtiming PROC
	call updatetiming
    mov eax,11 (black*16)
	call SetTextColor
	.IF timingFlag == 0		;miss
		.IF perfectCount == 0
			mov dl,timing_xPos
			mov dh,timing_yPos
			call Gotoxy
			mov edx,offset missStringLight 
			mov eax, white(black*16)
			inc perfectCount
		.ELSE
			mov dl,timing_xPos
			add dl,3
			mov dh,timing_yPos
			call Gotoxy
			mov edx,offset missString
			mov eax, red(black*16)
		.ENDIF
	.ELSEIF timingFlag == 1 ;good
		.IF perfectCount ==0
			mov dl,timing_xPos1
			mov dh,timing_yPos1
			call Gotoxy
			mov edx,offset goodStringLight 
			mov eax, white(black*16)
			inc perfectCount
		.ELSE
			mov dl,timing_xPos1
			add dl,3
			mov dh,timing_yPos1
			call Gotoxy
			mov edx,offset goodString 
			mov eax, blue(black*16)
		.ENDIF
	.ELSE					;perfect
		.IF perfectCount == 0
			mov dl,timing_xPos2
			mov dh,timing_yPos2
			call Gotoxy
			mov edx,offset perfectStringLight
			mov eax, white(black*16)
			inc perfectCount

		.ELSE
			mov dl,timing_xPos2
			add dl,3
			mov dh,timing_yPos2
			call Gotoxy
			mov edx,offset perfectString
			mov eax, green(black*16)
		.ENDIF
	.ENDIF

	call SetTextColor
	call WriteString

	ret
Drawtiming ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
updatetiming PROC

	mov eax,white (black * 16)
	call SetTextColor
	.IF timingFlag == 0		;miss
		mov dl,timing_xPos
		mov dh,timing_yPos
	.ELSEIF timingFlag == 1		;good
		mov dl,timing_xPos1
		mov dh,timing_yPos1
	.ELSE					;perfect
		mov dl,timing_xPos2
		mov dh,timing_yPos2 
	.ENDIF
	call Gotoxy
	push edx
	mov edx,offset clearPerfect
	call WriteString
	mov ecx,4
	ClearP:
		pop edx
		inc dh
		call Gotoxy
		push edx
		mov edx,offset clearPerfect
		call WriteString
	loop ClearP
	pop edx


	ret
updatetiming ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
draw_movement PROC
		;add move_count, 2
		mov dl, 0
		mov dh, 22
		call Gotoxy
		mov edx, OFFSET stickman_blank
		mov eax,yellow (yellow * 16)
		call SetTextColor
		call WriteString

		mov dl,0
		mov dh,22
		call Gotoxy
		.IF movementflag==0
			mov edx, OFFSET stickman_stand
			mov eax,black (yellow * 16)

		.ELSEIF movementflag==1
			mov edx, OFFSET stickman_hit
			mov eax,black (yellow * 16)
		.ELSE
			mov edx, OFFSET stickman_miss
			mov eax,red (yellow * 16)
		.ENDIF
		
		call SetTextColor
		call WriteString
	ret
draw_movement ENDP


END main