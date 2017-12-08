// Copyright 2016 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#include <stdio.h>
#include "uart.h"
#include "spi.h"
#include "event.h"
#include "int.h"

#define CMD_PP        0x02   // page program
#define CMD_WREN      0x06   // write enable
#define CMD_P4E       0x20   // parameter 4 KB erase
#define CMD_SE        0xD8   // sector erase
#define CMD_BE        0x60   // bulk erase
#define CMD_WRAR      0x71   // write to any register
#define CMD_RDAR      0x65   // read any register
#define CMD_4READ     0x13   // read with 4 byte address

#define CMD_RDSR1     0x05   // read status register 1
#define CMD_PDSR2     0x07   // read status register 2
#define CMD_RDCR      0x35   // read configuration register

#define tx_buffer_size   32
#define rx_buffer_size   32

volatile unsigned int eot_f;
unsigned int tx_buffer[tx_buffer_size];
unsigned int rx_buffer[rx_buffer_size];
unsigned int rx_ptr;
unsigned int tx_ptr;
unsigned int tx_cnt;
unsigned int rx_cnt;

int flash_get_wip()
{
    int status;
    eot_f = 0;
    rx_ptr = 0;
    spi_setup_cmd_addr(CMD_RDSR1, 8, 0, 0);
    spi_set_datalen(8);
    spi_start_transaction(SPI_CMD_RD, SPI_CSN0);
    while(!eot_f);
    return rx_buffer[0] & 0x1;
}
void flash_write_enable()
{
    while(flash_get_wip());
    //write enable
    eot_f = 0;
    spi_setup_cmd_addr(0, 0, 0, 0);               
    spi_set_datalen(8);
    *(volatile int*) (SPI_REG_TXFIFO) = CMD_WREN << 24;
    spi_start_transaction(SPI_CMD_WR, SPI_CSN0);
    while(!eot_f);
}
void flash_sector_erase_parameter(unsigned int address)
{
    //check if a write/erase is in process wait until it ends
    spi_setup_dummy(0, 0);
    while(flash_get_wip());

    //send write enable command
    flash_write_enable();

    //send page for erase
    eot_f = 0;
    spi_setup_cmd_addr(CMD_P4E, 8, 0, 0);    
    spi_set_datalen(32);
    *(volatile int*) (SPI_REG_TXFIFO) = address;
    spi_start_transaction(SPI_CMD_WR, SPI_CSN0);
    while(!eot_f);
}

void flash_bulk_erase(void)
{
    //check if a write/erase is in process wait until it ends
    spi_setup_dummy(0, 0);
    while(flash_get_wip());

    //send write enable command
    flash_write_enable();

    //send page for erase
    eot_f = 0;
    spi_setup_cmd_addr(0, 0, 0, 0);
    spi_set_datalen(8);
    *(volatile int*) (SPI_REG_TXFIFO) = CMD_BE << 24;
    spi_start_transaction(SPI_CMD_WR, SPI_CSN0);
    while(!eot_f);
}
/*
addr: the address data will be write.
size: the data word length, must smaller than 512.
*/
void flash_write_data(unsigned int addr, unsigned int size)
{
    while(flash_get_wip());
    flash_write_enable();
    eot_f = 0;
    tx_ptr = 0;
    tx_cnt = size;
    spi_setup_cmd_addr(CMD_PP, 8, addr, 32);
    spi_set_datalen(size * 32);
    spi_start_transaction(SPI_CMD_WR, SPI_CSN0);
    //enable fifo int, enable count int, count rx set 0, count tx set 1, rx threshold set 1, tx threshold set 1
    *(volatile int*) (SPI_REG_INTCFG) = (1 << 31) | (1 << 30) | (1 << 16) | (1 << 8) | 1;
    //spi_write_fifo(buffer, size * 32);
    while(!eot_f);
    *(volatile int*) (SPI_REG_INTCFG) = 0;
}
/*
addr: the address data will be write.
size: the data word length.
*/
void flash_read_data(unsigned int addr, unsigned int size)
{
    while(flash_get_wip());
    eot_f = 0;
    rx_ptr = 0;
    //rx_cnt = size;
    spi_setup_cmd_addr(CMD_4READ, 8, addr, 32);
    spi_set_datalen(size * 32);
    spi_start_transaction(SPI_CMD_RD, SPI_CSN0);
    //enable fifo int, enable count int, count rx set 1, count tx set 1, rx threshold set 1, tx threshold set 1
    *(volatile int*) (SPI_REG_INTCFG) = (1 << 31) | (1 << 30) | (1 << 24) | (1 << 16) | (1 << 8) | 1;
    //spi_write_fifo(buffer, size * 32);
    while(!eot_f);
    *(volatile int*) (SPI_REG_INTCFG) = 0;
}
void flash_init(void)
{
    eot_f = 0;
    rx_ptr = 0;
    spi_setup_cmd_addr(0x9F, 8, 0, 0);
    spi_set_datalen(32);
    printf("start transcation and wait int.\n");
    spi_start_transaction(SPI_CMD_RD, SPI_CSN0);
    while(!eot_f);
    int id = rx_buffer[0];
    printf("flash id is:%x\n", rx_buffer[0]);

    flash_write_enable();
    
    //CMD B7 is set 32 bit addr
    eot_f = 0;
    spi_setup_cmd_addr(0, 0, 0, 0);                  
    spi_set_datalen(8);
    *(volatile int*) (SPI_REG_TXFIFO) = 0xB7 << 24;
    spi_start_transaction(SPI_CMD_WR, SPI_CSN0);
    while(!eot_f);
    
    //bit[7] is 1, all addr become 32
    eot_f = 0;
    rx_ptr = 0;
    spi_setup_cmd_addr(CMD_RDAR, 8, 0x800003, 32);     
    spi_setup_dummy(8, 0);
    spi_set_datalen(8);
    spi_start_transaction(SPI_CMD_RD, SPI_CSN0);
    while(!eot_f);
    printf("CR2: %x \n", rx_buffer[0]);
    if(rx_buffer[0]&0x80)
        printf("enter 32bit addr \n");
    else 
        printf("failed enter 32bit addr \n");
    
    flash_write_enable();

    eot_f = 0;
    spi_setup_cmd_addr(CMD_WRAR, 8, 0x800004, 32);
    spi_set_datalen(8);
    *(volatile int*) (SPI_REG_TXFIFO) = 0x10 << 24;
    spi_start_transaction(SPI_CMD_WR, SPI_CSN0);
    while(!eot_f);
    
    eot_f = 0;
    rx_ptr = 0;
    spi_setup_cmd_addr(CMD_RDAR, 8, 0x800004, 32);
    spi_setup_dummy(8, 0);
    spi_set_datalen(8);
    spi_start_transaction(SPI_CMD_RD, SPI_CSN0);
    while(!eot_f);
    printf("CR3: %x \n", rx_buffer[0]);
    if(rx_buffer[0]&0x10)
        printf("wrap at 512kb \n");
    else
        printf("fail to wrap at 512kb \n");
    spi_setup_dummy(0, 0);
}

// 26: spim R/T finished
void ISR_SPIM0 (void){
    ICP = (1 << 26);
    int rx_fifo = (((*(volatile int*) (SPI_REG_STATUS)) >> 16) & 0xFF);
    if(rx_fifo != 0){
        for(int i = 0; i < rx_fifo; i++)
            rx_buffer[rx_ptr++] = *(volatile int*) (SPI_REG_RXFIFO);
    }
    if(tx_cnt != 0){
         *(volatile int*) (SPI_REG_TXFIFO) = tx_buffer[tx_ptr++];
         tx_cnt--;
    }
}  

// 27: spim end of transmission
// the remain data of transmission read here
void ISR_SPIM1 (void){
    ICP = (1 << 27);
    eot_f = 1;
    int rx_fifo = (((*(volatile int*) (SPI_REG_STATUS)) >> 16) & 0xFF);
    if(rx_fifo != 0){
        for(int i = 0; i < rx_fifo; i++)
            rx_buffer[rx_ptr++] = *(volatile int*) (SPI_REG_RXFIFO);
    }
    int tx_fifo = (((*(volatile int*) (SPI_REG_STATUS)) >> 24) & 0xFF);
    if(tx_fifo != 0){
        printf("EOF.tx_fifo_num: %x \n", tx_fifo);
    }
}


int main()
{
    printf("spi flash program\n");
    spi_setup_master(1);
    *(volatile int*)(SPI_REG_CLKDIV) = 0x4;
    *(volatile int*)(SPI_REG_INTCFG) = 0x0;
    int_enable();

    IER = 0x0C000000; // enable SPI R/T and eot interrupt
    
    flash_init();
    flash_write_enable();
    flash_sector_erase_parameter(0);
    flash_write_enable();
    
    for(int i = 0; i < 32; i++)
    {
        tx_buffer[i] = i;
    }
    flash_write_data(0, 32);
    flash_read_data(0, 32);
    for(int i = 0; i < 32; i++)
    {
        printf("rx_buffer: %x\n", rx_buffer[i]);
    }
    
   return 0;
}  









