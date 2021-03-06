; #########################################################################
;
;   render.asm - Assembly file for EECS205 Assignment 4/5
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

    include stars.inc		
    include blit.inc
    include trig.inc
    include rotate.inc	
    include game.inc


.DATA
overString BYTE "Game Over. You Lost",0
	
.CODE

;; Define the function GameRender

GameRender PROC 
	
	INVOKE BeginDraw

	INVOKE DrawAllStars

	cmp over, 1
	jne a1
	INVOKE DrawString, 250, 200, offset overString
	jmp done

a1:	
	cmp asteroid1.y, 0
	jl a2
	cmp asteroid1.visible, 0
	je a2
	INVOKE RotateBlit, asteroid1.bmpPtr, asteroid1.x, asteroid1.y, asteroid1.a
a2:	
	cmp asteroid2.y, 0
	jl a3
	cmp asteroid2.visible, 0
	je a3
	INVOKE RotateBlit, asteroid2.bmpPtr, asteroid2.x, asteroid2.y, asteroid2.a
a3:
	cmp asteroid3.y, 0
	jl c1
	cmp asteroid3.visible, 0
	je c1
	INVOKE RotateBlit, asteroid3.bmpPtr, asteroid3.x, asteroid3.y, asteroid3.a
c1:
	cmp cage1.y, 0
	jl c2
	cmp cage1.visible, 0
	je c2
	INVOKE RotateBlit, cage1.bmpPtr, cage1.x, cage1.y, cage1.a
c2:
	cmp cage2.y, 0
	jl drawShip
	cmp cage2.visible, 0
	je drawShip
	INVOKE RotateBlit, cage2.bmpPtr, cage2.x, cage2.y, cage2.a
drawShip:	
	INVOKE RotateBlit, ship.bmpPtr, ship.x, ship.y, ship.a
	cmp shot, 0
	je done
drawProjectile:	
	INVOKE RotateBlit, projectile.bmpPtr, projectile.x, projectile.y, projectile.a
	
done:	
	INVOKE EndDraw

ret
GameRender ENDP


END
