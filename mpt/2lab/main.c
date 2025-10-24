#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <math.h>

#define E 6
#define RS 7

void lcdCmd(uint8_t cmd);
void lcdInit(void);
void lcdData(uint8_t data);
void printNum(uint16_t num);

uint8_t r = 0;
uint8_t g = 255;
uint8_t b = 255;

int main(void)
{
    DDRE = (1 << 3) | (1 << 4) | (1 << 5);
    /* Инициализация таймера №3. 16 битная быстрая
    ШИМ, преддедитель на 8 */
    TCCR3A = (1 << COM3A1) | (1 << COM3B1) | (1 << COM3C1) | (1 << WGM30);
    TCCR3B = (1 << WGM32) | (1 << CS31);
    EIMSK = (1 << INT0);
    EICRA = (1 << ISC01) | (1 << ISC00);
    lcdInit();
    sei();
    while (1)
    {
        lcdCmd(0X01);
        lcdCmd((1 << 7) | 0);
        lcdData('R');
        lcdData(':');
        printNum(r);

        lcdData('G');
        lcdData(':');
        printNum(g);

        lcdCmd((1 << 7) | 64);
        lcdData('B');
        lcdData(':');
        printNum(b);

        OCR3AL = b;
        OCR3BL = g;
        OCR3CL = r;
        _delay_ms(300);
    }
}

void printNum(uint16_t num)
{
    lcdData(' ');
    if (num >= 100)
    {
        lcdData(num / 100 + '0');
        lcdData((num / 10) % 10 + '0');
        lcdData(num % 10 + '0');
    }
    else if (num >= 10)
    {
        lcdData((num / 10) % 10 + '0');
        lcdData(num % 10 + '0');
    }
    else
        lcdData(num % 10 + '0');

    lcdData(' ');
}

void lcdData(uint8_t data)
{ // посыл данных на экран
    DDRC = 0xFF;
    DDRD |= ((1 << E) | (1 << RS));
    PORTD |= (1 << RS);
    PORTC = data;
    PORTD |= (1 << E);
    _delay_us(5);
    PORTD &= ~(1 << E);
    _delay_ms(4);
}

void lcdInit(void)
{                                   // инициализация (ВКЛ) экрана
    DDRC = 0xFF;                    // все разряды PORTC на выход
    DDRD |= ((1 << E) | (1 << RS)); // разряды PORTD на выход
    _delay_ms(100);                 // задержка для установления питания
    lcdCmd(0x30);                   // \ вывод
    lcdCmd(0x30);                   // | трех
    lcdCmd(0x30);                   // / команд 0x30
    lcdCmd(0x38);                   // 8 разр.шина, 2 строки, 5 × 7 точек
    lcdCmd(0x0C);                   // включить ЖКИ
    lcdCmd(0x06);                   // инкремент курсора, без сдвига экрана
    lcdCmd(0x01);                   // очистить экран, курсор в начало
}

void lcdCmd(uint8_t cmd)
{                                   // посыл команды на экран
    DDRC = 0xFF;                    // все разряды PORTC на выход
    DDRD |= ((1 << E) | (1 << RS)); // разряды PORTD на выход
    PORTD &= ~(1 << RS);            // выбор регистра команд RS=0
    PORTC = cmd;                    // записать команду в порт PORTC
    PORTD |= (1 << E);              // \ сформировать на
    _delay_us(5);                   // | выводе E строб 1-0
    PORTD &= ~(1 << E);             // / передачи команды
    _delay_ms(4);                   // задержка для завершения записи
}

ISR(INT0_vect)
{
    if ((PIND & (1 << 0)) != 0)
    {
        EICRA = (1 << ISC01);
        if ((PIND & (1 << 1)) != 0)
        {
            r = (r < 255) ? r + 1 : 255;
            g = (g < 255) ? g + 1 : 255;
            b = (b < 255) ? b + 1 : 255;
        }
        else
        {
            r = (r > 1) ? r - 1 : 0;
            g = (g > 1) ? g - 1 : 0;
            b = (b > 1) ? b - 1 : 0;
        }
    }
    else
    {
        EICRA = (1 << ISC01) | (1 << ISC00);
        if ((PIND & (1 << 1)) != 0)
        {
            r = (r > 1) ? r - 1 : 0;
            g = (g > 1) ? g - 1 : 0;
            b = (b > 1) ? b - 1 : 0;
        }
        else
        {
            r = (r < 255) ? r + 1 : 255;
            g = (g < 255) ? g + 1 : 255;
            b = (b < 255) ? b + 1 : 255;
        }
    }
}