/*
* Test.cpp
*
* Created: 8/4/2016 11:52:51 PM
*  Author: ThaoNguyen
*/

#define F_CPU 8000000UL
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdlib.h>

#define sbi(port, bit) port |= (1 << bit)
#define cbi(port, bit) port &= (1 << bit)

typedef struct LED{
	uint8_t D0_7, D8_15, D16_23, D24_27;
} Led;

volatile Led heart;
volatile int8_t index = 0;

void off_all( void );
void on_all( void );
void on(uint8_t pos);
void display( void );
void effect1( void );
void effect2( void );
void effect3( void );
void effect4( void );
void effect5( void );
void effect6( void );
void effect7( void );
void effect8( void );

int main(void)
{
	srand(1);
	// Init IO
	DDRA = 0xff;
	PORTA = 0xff;
	
	DDRB = 0xBF;
	PORTB = 0xff;
	
	DDRC = 0xff;
	PORTC = 0xff;
	
	DDRD = 0xff;
	PORTD = 0xff;
	
	// Init Timer0
	TCCR0 |= (1 << CS01) | (1 << CS00);
	TIMSK |= (1 << TOIE0);
	TCNT0 = 130;
	sei();
	
	while(1)
	{
		//TODO:: Please write your application code
		switch (rand() % 8)
		{
			case 0:
			effect1();
			break;
			case 1:
			effect2();
			break;
			case 2:
			effect3();
			break;
			case 3:
			effect4();
			break;
			case 4:
			effect5();
			break;
			case 5:
			effect6();
			break;
			case 6:
			effect7();
			break;
			case 7:
			effect8();
			break;
			default:
			break;
		}
	}
}

void off_all( void )
{
	heart.D0_7 = heart.D8_15 = heart.D16_23 = heart.D24_27 = 0xff;
}

void on_all( void )
{
	heart.D0_7 = heart.D8_15 = heart.D16_23 = heart.D24_27 = 0;
}

void off(uint8_t pos)
{
	switch (pos)
	{
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		heart.D0_7 |= (1 << pos);
		break;
		
		case 8:
		case 9:
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		heart.D8_15 |= (1 << (pos - 8));
		break;
		
		case 16:
		case 17:
		case 18:
		case 19:
		case 20:
		case 21:
		case 22:
		case 23:
		heart.D16_23 |= (1 << (pos - 16));
		break;
		
		case 24:
		case 25:
		case 26:
		case 27:
		heart.D24_27 |= (1 << (pos - 24));
		break;
		
		default:
		break;
	}
}

void on(uint8_t pos)
{
	pos = pos % 28;
	switch (pos)
	{
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		heart.D0_7 &= ~(1 << pos);
		break;
		
		case 8:
		case 9:
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		heart.D8_15 &= ~(1 << (pos - 8));
		break;
		
		case 16:
		case 17:
		case 18:
		case 19:
		case 20:
		case 21:
		case 22:
		case 23:
		heart.D16_23 &= ~(1 << (pos - 16));
		break;
		
		case 24:
		case 25:
		case 26:
		case 27:
		heart.D24_27 &= ~(1 << (pos - 24));
		break;
		
		default:
		break;
	}
}

void display( void )
{
	PORTA = heart.D0_7;
	PORTC = heart.D8_15;
	PORTD = heart.D16_23;
	PORTB = heart.D24_27;
}

void effect1( void )
{
	off_all();
	for (index = 0; index < 3; index++)
	{
		off_all();
		_delay_ms(200);
		on_all();
		_delay_ms(200);
	}
}

void effect2( void )
{
	off_all();
	for (index = 0; index < 28; index++)
	{
		off_all();
		on(index);
		_delay_ms(50);
	}
}

void effect3( void )
{
	off_all();
	for (index = 0; index < 28; index++)
	{
		on(index);
		_delay_ms(75);
	}
	
	for (index = 27; index >= 0; index--)
	{
		off(index);
		_delay_ms(75);
	}
	
	on(0);
	_delay_ms(75);
	for (index = 27; index >= 1; index--)
	{
		on(index);
		_delay_ms(75);
	}
	
	for (index = 1; index < 28; index++)
	{
		off(index);
		_delay_ms(75);
	}
	off(0);
}

void effect4( void )
{
	off_all();
	for (index = 0; index < 28; index+=2)
	{
		on(index);
		on(27 - index);
		_delay_ms(100);
	}
	
	for (index = 27; index >= 0; index-=2)
	{
		off(index);
		off(27 - index);
		_delay_ms(100);
	}
}

void effect5( void )
{
	uint8_t max = 28, temp = 0;
	off_all();
	for (index = 0; index < 28; index++)
	{
		for (temp = 0; temp < max; temp++)
		{
			on(temp);
			_delay_ms(75);
		}
		max--;
		for (temp = 0; temp < max; temp++)
		{
			off(temp);
		}
	}
}

void effect6( void )
{
	uint8_t max = 0, temp = 0;
	off_all();
	on(0);
	on(14);
	
	for (index = 13; index > 0; index--)
	{
		for (temp = 13; temp > max; temp--)
		{
			on(temp);
			on(28 - temp);
			_delay_ms(50);
		}
		max++;
		for (temp = 13; temp > max; temp--)
		{
			off(temp);
			off(28 - temp);
		}
	}
}

void effect7( void )
{
	uint8_t temp = 0;
	off_all();
	for (index = 0; index < 7; index++)
	{
		for (temp = 0; temp < 4; temp++)
		{
			on(temp);
			on(temp + 4);
			on(temp + 8);
			on(temp + 12);
			on(temp + 16);
			on(temp + 20);
			on(temp + 24);
			_delay_ms(100);
			off_all();
		}
	}
}

void effect8( void )
{
	uint8_t temp = 0;
	for (index = 0; index < 4; index++)
	{
		for (temp = 0; temp < 11; temp++)
		{
			on(temp);
			on(temp + 1);
			on(temp + 2);
			on(temp + 3);
			
			on(temp + 8);
			on(temp + 9);
			on(temp + 10);
			on(temp + 11);
			
			on(temp + 16);
			on(temp + 17);
			on(temp + 18);
			on(temp + 19);
			
			on(temp + 25);
			on(temp + 26);
			on(temp + 27);
			on(temp + 28);
			
			_delay_ms(75);
			
			off_all();
		}
	}
}

ISR(TIMER0_OVF_vect)
{
	TCNT0 = 130;
	display();
}