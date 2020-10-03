;To build and run this use 'run.bat' in root folder. 
;You will need CSpect/sjasmplus/hdfmonkey/ZX roms and sdcard img
;See my videos if you wish to copy my exact setup
;or read the contents of run.bat/build.bat for the file locations that are used



    org 0x6000

    DEVICE ZXSPECTRUMNEXT

    CSPECTMAP "project.map"


main_start:
	call start
	jp main_loop



main_loop:
	ld bc,GAME_DELAY_TIME
	call wait

	call update
	call draw

	jp main_loop


wait:
	dec bc
	ld a,b
	cp 0
	jp nz, wait
	ret





GAME_DELAY_TIME equ 10000 
STACK_SIZE: equ 20    
stack_bottom:
    ds    STACK_SIZE, 0
stack_top:  db 0  ; WPMEM


	include 'game.asm'


    SAVENEX OPEN "main.nex", main_start, stack_top
    SAVENEX CORE 2, 0, 0        ; Next core 2.0.0 required as minimum
    SAVENEX CFG 7   ; Border color
    SAVENEX AUTO
    ; SAVENEX CLOSE