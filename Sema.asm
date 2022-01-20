; SEMA.ASM
; BY CLODOALDO SOUZA
; 26/09/2009
;***********************************************************************************
#INCLUDE <P16F84A.INC>							;DEFINICAO DO PIC UTILIZADO
#DEFINE		BANK0	BCF		STATUS,RP0			; BANK0 PROGRAMAÇÃO NORMAL
#DEFINE		BANK1	BSF		STATUS,RP0			; BANK1 PROGRAMAÇÃO DE CONFIGURAÇÃO
#DEFINE		BOTAO1			PORTA,0
#DEFINE		BOTAO2			PORTA,1
#DEFINE		BOTAO3			PORTA,2
#DEFINE		BOTAO4			PORTA,3
#DEFINE		VERMELHO1		PORTB,0
#DEFINE		AMARELO1		PORTB,1
#DEFINE		VERDE1			PORTB,2
#DEFINE		VERMELHO2		PORTB,3
#DEFINE		AMARELO2		PORTB,4
#DEFINE		VERDE2			PORTB,5
#DEFINE		PISCA			PORTB,6
#DEFINE		BUZ1			PORTB,7
;***********************************************************************************
			ERRORLEVEL -302
;***********************************************************************************
			CBLOCK 0x0C
					CONTA
					WTEMP
					STATUS_TEMP
			ENDC
;***********************************************************************************
			ORG		0X00
			GOTO	INICIO
;***********************************************************************************
			ORG		0X04
;ROTINAS DE INTERRUPÇÃO
			RETFIE
;***********************************************************************************
INICIO
			BANK0
			CLRF	PORTA
			CLRF	PORTB
			BANK1
			;		  76543210
			MOVLW	B'11111111'
			MOVWF	TRISA
			;		  76543210
			MOVLW	B'00000000'
			MOVWF	TRISB
			;		  76543210
			MOVLW	B'10000000'
			MOVWF	OPTION_REG
			;		  76543210
			MOVLW	B'00000000'
			MOVWF	INTCON
			BANK0
			CLRF	PORTA
			CLRF	PORTB
;***********************************************************************************
MAIN			
			BSF		VERMELHO1					; ACENDE VERMELHO DO SEMAFORO 1
			BSF 	VERMELHO2					; ACENDE VERMELHO DO SEMAFORO 2
			BCF		VERDE1						; APAGA VERDE DO SEMAFORO 1
			BCF		VERDE2						; APAGA VERDE DO SEMAFORO 2
			BCF		AMARELO1					; APAGA AMARELO DO SEMAFORO 1
			BCF		AMARELO2					; APAGA AMARELO DO SEMAFORO 2
			MOVLW	.50							; W RECEBE 50 DECIMAL
			MOVWF	1F							; POSCAO DA MEMORIA 1F RECEBE W
			DECFSZ	1F							; DECREMENTA ENDERECO 1F = 0?
			GOTO	$-1							; NÃO VOLTA UMA LINHA
			BCF 	VERMELHO1					; APAGA VERMELHO DO SEMAFORO 1
			BSF		VERDE1						; ACENDE VERDE DO SEMAFORO 1
			MOVLW	.255						; W RECEBE 255 DECIMAL
			MOVWF	1F							; POSCAO DA MEMORIA 1F RECEBE W
			DECFSZ	1F							; DECREMENTA ENDERECO 1F = 0?
			GOTO	$-1							; NÃO VOLTA UMA LINHA
			BCF		VERDE1						; APAGA VERDE DO SEMAFORO 1
			BSF 	AMARELO1					; ACENDE AMARELO DO SEMAFORO 1
			MOVLW	.200						; W RECEBE 200 DECIMAL
			MOVWF	1F							; POSCAO DA MEMORIA 1F RECEBE W
			DECFSZ	1F							; DECREMENTA ENDERECO 1F = 0?
			GOTO	$-1							; NÃO VOLTA UMA LINHA
			BCF 	AMARELO1					; APAGA AMARELO DO SEMAFORO 1
			BSF		VERMELHO1					; ACENDE VERMELHO DO SEMAFORO 1
			MOVLW	.50							; W RECEBE 50 DECIMAL
			MOVWF	1F							; POSCAO DA MEMORIA 1F RECEBE W
			DECFSZ	1F							; DECREMENTA ENDERECO 1F = 0?
			GOTO	$-1							; NÃO VOLTA UMA LINHA
			BCF 	VERMELHO2					; APAGA VERMELHO DO SEMAFORO 2
			BSF		VERDE2						; ACENDE VERDE DO SEMAFORO 2
			MOVLW	.255						; W RECEBE 255 DECIMAL
			MOVWF	1F							; POSCAO DA MEMORIA 1F RECEBE W
			DECFSZ	1F							; DECREMENTA ENDERECO 1F = 0?
			GOTO	$-1							; NÃO VOLTA UMA LINHA
			BCF		VERDE2						; APAGA VERDE DO SEMAFORO 2
			BSF 	AMARELO2					; ACENDE AMARELO DO SEMAFORO 2
			MOVLW	.200						; W RECEBE 200 DECIMAL
			MOVWF	1F							; POSCAO DA MEMORIA 1F RECEBE W
			DECFSZ	1F							; DECREMENTA ENDERECO 1F = 0?
			GOTO	$-1							; NÃO VOLTA UMA LINHA
			BCF 	AMARELO2					; APAGA AMARELO DO SEMAFORO 2
			GOTO	MAIN						; SIM VOLTA PARA MAIN
;***********************************************************************************
			END
;***********************************************************************************