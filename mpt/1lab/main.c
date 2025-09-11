#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <math.h>

#define EMPTY 10
#define MINUS 11

void clearSegments(void);
void numout(int32_t number);
void drawposneg(int32_t number);
int8_t Digit(int32_t d, uint8_t m);

int32_t angle = 100;
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
        numout(angle);
    }
}

int8_t Digit(int32_t d, uint8_t m)
{

    int8_t i = 5, a;
    if (d < 0)
        d *= -1;
    while (i)
    {               // цикл по разрядам числа
        a = d % 10; // выделяем очередной разряд
        if (i-- == m)
            break; // выделен заданный разряд - уходим
        d /= 10;   // уменьшаем число в 10 раз
    }
    return (a);
}

void numout(int32_t number) // функция, которая выводит цифру
{

    if (number == 0)
    {
        PORTA |= (1 << 5);   // подача в регистр нужной последовательности, чтобы выбрать нужный разряд
        PORTC = segments[0]; // подача изображения нужной цифры
        _delay_us(10);
        PORTA &= ~(1 << 5);
        return;
    }

    uint8_t i = 2; // номер разряда

    while (Digit(number, i) == 0) // с помощью этого цикла мы убираем нули
    {
        PORTA |= (1 << i);
        PORTC = 0x0;
        _delay_us(20); // пауза
        PORTA &= ~(1 << i);
        i++; // переход в следующий разряд
    }

    while (i <= 5) // запоминает i при котором у нас первая не нулевая цифра и выводит последовательно оставшиеся цифры в разряды
    {
        PORTA |= (1 << i);
         // подача в регистр нужной последовательности, чтобы выбрать нужный разряд
        PORTC = segments[Digit(number, i)];
        _delay_us(20);      // подача в регистр нужной последовательности, чтобы выбрать нужный разряд
        PORTA &= ~(1 << i); // ставим регистр в изначальное значение
        i++;                // переход в следующий разряд
    }
    drawposneg(number);
}

void drawposneg(int32_t number)
{
    if (number < 0)
    {
        PORTA |= (1 << 1);       // подача в регистр нужной последовательности, чтобы выбрать нужный разряд
        PORTC = segments[MINUS]; // подача изображения нужной цифры
        _delay_us(10);
        PORTA &= ~(1 << 1);
    }
    else
    {
        PORTA |= (1 << 1); // подача в регистр нужной последовательности, чтобы выбрать нужный разряд
        PORTC = segments[EMPTY];
        _delay_us(10);
        PORTA &= ~(1 << 1);
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
