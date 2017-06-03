Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dH9JR-0000yx-L3
 for kexec@lists.infradead.org; Sat, 03 Jun 2017 13:41:55 +0000
Received: by mail-it0-x22a.google.com with SMTP id r63so42371920itc.1
 for <kexec@lists.infradead.org>; Sat, 03 Jun 2017 06:41:32 -0700 (PDT)
MIME-Version: 1.0
From: Mahesh V <maheshvenkateshwaran@gmail.com>
Date: Sat, 3 Jun 2017 19:11:31 +0530
Message-ID: <CAEwzPJ0GZuzPXGLB2NcZt=JQq3+BQFeAeD-VxX280rY+wEQHbQ@mail.gmail.com>
Subject: crash kernel not booting
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi folks,

Have mostly exhausted all my options to make my ARM crash kernel boot :(.
Nothings worked so far. Any pointers as to how should I proceed further?

Following are my .config parameters that I set.
+CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
+CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_LL_UART_NONE=y
+CONFIG_EARLY_PRINTK=y

defaults. If I set CONFIG_ARM_PATCH_PHYS_VIRT, I get a compile error
('__pv_phys_offset' undeclared here (not in a function))

CONFIG_PHYS_OFFSET=0x41500000
# CONFIG_ARM_PATCH_PHYS_VIRT is not set
# CONFIG_AUTO_ZRELADDR is not set


I am trying to load the uncompressed vmlinux (not uImage or zImage) to
0x44800000 location in my RAM (crash kernel location)

iomem has the following entry
44800000-5fbfffff : System RAM
  44800000-4ddfffff : Crash kernel


I used the following kexec command to load the kernel to that location
/aruba/bin/kexec -d -p /aruba/bin/vmlinux
--command-line="console=ttyHSL1,9600n8 rdinit=/sbin/init ubi.mtd=aos0
ubi.mtd=aos1 ubi.mtd=ubifs crashkernel=150m@1096m earlyprintk noisy"
--atags --mem-min=0x44800000


The crash kernel vmlinux does load at that location. Verified using dd
command (44808000 == 1149272064)
/aruba/bin # dd if=/dev/mem skip=1149272064 bs=1 count=20  | od -x
20+0000000     457f    464c    0101    0001    0000    0000    0000    0000
0 records in
20+00000020     0002    0028
 records out
0000024


However when I object dump the vmlinux, it has addresses pointing to c0000000
Is this the reason why my crash kernel never boots (because the
locations in  vmlinux is c0000000 and not 0x44800000 which is my start
address)

these are the last few lines after crashing the main kernel

[ 7152.560043] Code: e3a02001 e5832000 f57ff04f e3a03000 (e5c32000)
[ 7152.634583] Loading crashdump kernel...
[ 7152.678819] image start ---- image->start 44808000
[ 7152.736082]  kexec start address 44808000,
[ 7152.786098]  reboot_code_buffer 0xc3300000,
[ 7152.837144]  reboot_code_buffer_phys 44800000,
[ 7152.891315]  kexec_mach_type 4704
[ 7152.931927] Bye!
[ 7152.953920] Inside __soft_restart !! c037fb68 4187fb68
[ 7153.016338] __soft_restart final address 44800000

code snippet from process.c in static void __soft_restart(void *addr) function
        phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
        printk(KERN_EMERG "__soft_restart final address %p \n",
(unsigned char *)addr);

        phys_reset((unsigned long)addr);
        /* Should never get here. */
        BUG();


After cpu_reset I do not see any prints or kernel messages. How do I
debug further ?
Any pointers would help


objdump of my vmlinux

[mv_iap43_2 linux-3.4.0 (IAP-OCTOMORE)]$
../../../../aos-cmn/tools/armv7-openwrt-linux-gnu-uClibc-0.9.33.2/bin/arm-openwrt-linux-objdump
-d vmlinux | less

vmlinux:     file format elf32-littlearm


Disassembly of section .head.text:

c0008000 <stext>:
c0008000:       e321f0d3        msr     CPSR_c, #211    ; 0xd3
c0008004:       ee109f10        mrc     15, 0, r9, cr0, cr0, {0}
c0008008:       eb0daf8c        bl      c0373e40 <__lookup_processor_type>
c000800c:       e1b0a005        movs    sl, r5
c0008010:       e28f302c        add     r3, pc, #44     ; 0x2c
c0008014:       e8930110        ldm     r3, {r4, r8}
c0008018:       e0434004        sub     r4, r3, r4
c000801c:       e0888004        add     r8, r8, r4
c0008020:       eb000009        bl      c000804c <__vet_atags>
c0008024:       eb1fdff5        bl      c0800000 <__init_begin>
c0008028:       eb000159        bl      c0008594 <__create_page_tables>
c000802c:       e59fd00c        ldr     sp, [pc, #12]   ; c0008040 <stext+0x40>
c0008030:       e28fe004        add     lr, pc, #4
c0008034:       e1a08004        mov     r8, r4
c0008038:       e28af010        add     pc, sl, #16
c000803c:       ea0daf74        b       c0373e14 <__enable_mmu>
c0008040:       c080005c        .word   0xc080005c
c0008044:       c0008044        .word   0xc0008044
c0008048:       c0000000        .word   0xc0000000


 Thanks in advance
regards,
Mahesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
