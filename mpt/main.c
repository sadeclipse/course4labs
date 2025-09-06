#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

#define EMPTY 10
#define MINUS 11

void clearSegments(void);
void showDig(uint8_t position, uint8_t digit);

uint16_t angle = 0;
const uint8_t segments[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0, 0x40}; // добавить функцию digit и нормально выводить число angle +добавить ограничения и минусы

int main(void)
{
    DDRC = 0xFF;
    DDRA = (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4) | (1 << 5);
    clearSegments();
    EIMSK = (1 << 0);
    sei();
    while (1)
    {
        showDig(4, angle);
    }
}

void clearSegments(void)
{
    for (uint8_t i = 1; i <= 5; i++)
    {
        PORTA |= (1 << i);
        PORTC = 0;
        _delay_us(10);
        PORTA &= ~(1 << i);
    }
}

void showDig(uint8_t position, uint8_t digit)
{
    PORTA |= (1 << position);
    PORTC = segments[digit];
    _delay_ms(1);
    PORTA &= ~(1 << position);
}

ISR(INT0_vect)
{
    if ((PIND & (1 << 0)) != 0)
    {
        EICRA = (1 << ISC01);
        if ((PIND & (1 << 1)) != 0)
            angle--;
        else
            angle++;
    }
    else
    {
        EICRA = (1 << ISC01) | (1 << ISC00);
        if ((PIND & (1 << 1)) != 0)
            angle++;
        else
            angle--;
    }
}
