Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dps3B-0003tI-LR
 for kexec@lists.infradead.org; Thu, 07 Sep 2017 08:20:40 +0000
Received: by mail-oi0-x235.google.com with SMTP id n18so54605616oig.2
 for <kexec@lists.infradead.org>; Thu, 07 Sep 2017 01:20:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALKbUJQCd3C1NPxXba5jb9QYPUbEYNnx_dywxTsP+Rnejbt6YA@mail.gmail.com>
References: <CALKbUJQCd3C1NPxXba5jb9QYPUbEYNnx_dywxTsP+Rnejbt6YA@mail.gmail.com>
From: Sunil Kumar <sukumar@mvista.com>
Date: Thu, 7 Sep 2017 13:49:34 +0530
Message-ID: <CALKbUJTmkJV-bq1mnzqR5Q-RrX6OpSniTZd=z26QxqtJttPVMg@mail.gmail.com>
Subject: Fwd: zImage support for ppc
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

Hi

I am trying to boot zImage as the secondary kernel on Freescale
p2020ds ppc reference board. I am using the below commands to load the
secondary kernel:
$ kexec -d -l /usr/sbin/zImage --ramdisk=/usr/sbin/kcrashramfs.cpio.gz
 --append="console=ttyS0,115200 root=/dev/ram  maxcpus=1"
-------------------------------------------------------------------------------------------------------------------------------------------------------
my_load:667: do
Try gzip decompression.
kernel: 0xb7a8d008 kernel_size: 0x32be60
0000000000000000-00000000e0000000 : 0
get base memory ranges:1
sym:      .data info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .data value: 32e950 addr: 329032
sym:      .data info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .data value: 32e950 addr: 32903a
sym: sha256_starts info: 12 other: 00 shndx: 2 value: 94c size: bc
sym: sha256_starts value: 329970 addr: 329044
sym: sha256_update info: 12 other: 00 shndx: 2 value: 528c size: 190
sym: sha256_update value: 32e2b0 addr: 32905c
sym: sha256_finish info: 12 other: 00 shndx: 2 value: 541c size: 498
sym: sha256_finish value: 32e440 addr: 32907c
sym:     memcmp info: 12 other: 00 shndx: 2 value: 61c size: 38
sym: memcmp value: 329640 addr: 329090
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e8d8 addr: 32909e
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e8d8 addr: 3290a2
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e908 addr: 3290a6
sym:     printf info: 12 other: 00 shndx: 2 value: 540 size: 68
sym: printf value: 329564 addr: 3290a8
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e8f8 addr: 3290ae
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e8f8 addr: 3290b2
sym:     printf info: 12 other: 00 shndx: 2 value: 540 size: 68
sym: printf value: 329564 addr: 3290b4
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e908 addr: 3290be
sym:     printf info: 12 other: 00 shndx: 2 value: 540 size: 68
sym: printf value: 329564 addr: 3290cc
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e910 addr: 3290de
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e910 addr: 3290e6
sym:     printf info: 12 other: 00 shndx: 2 value: 540 size: 68
sym: printf value: 329564 addr: 3290ec
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e914 addr: 3290f2
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e914 addr: 3290f6
sym:     printf info: 12 other: 00 shndx: 2 value: 540 size: 68
sym: printf value: 329564 addr: 3290f8
sym:     printf info: 12 other: 00 shndx: 2 value: 540 size: 68
sym: printf value: 329564 addr: 329104
sym:     printf info: 12 other: 00 shndx: 2 value: 540 size: 68
sym: printf value: 329564 addr: 329118
sym: _restgpr_27_x info: 12 other: 00 shndx: 2 value: 8a4 size: 0
sym: _restgpr_27_x value: 3298c8 addr: 329124
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e924 addr: 32912e
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e924 addr: 329136
sym:     printf info: 12 other: 00 shndx: 2 value: 540 size: 68
sym: printf value: 329564 addr: 32913c
sym: setup_arch info: 12 other: 00 shndx: 2 value: 93c size: 4
sym: setup_arch value: 329960 addr: 329140
sym: verify_sha256_digest info: 12 other: 00 shndx: 2 value: 0 size: 104
sym: verify_sha256_digest value: 329024 addr: 329144
sym: post_verification_setup_arch info: 12 other: 00 shndx: 2 value: 940 size: 4
sym: post_verification_setup_arch value: 329964 addr: 329160
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e938 addr: 32918a
sym:    putchar info: 12 other: 00 shndx: 2 value: 948 size: 4
sym: putchar value: 32996c addr: 3291b4
sym:    putchar info: 12 other: 00 shndx: 2 value: 948 size: 4
sym: putchar value: 32996c addr: 329224
sym:  __lshrdi3 info: 10 other: 00 shndx: 2 value: 918 size: 0
sym: __lshrdi3 value: 32993c addr: 32933c
sym: .rodata.str1.4 info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata.str1.4 value: 32e938 addr: 329342
sym:    putchar info: 12 other: 00 shndx: 2 value: 948 size: 4
sym: putchar value: 32996c addr: 3294dc
sym: _restgpr_20_x info: 12 other: 00 shndx: 2 value: 888 size: 0
sym: _restgpr_20_x value: 3298ac addr: 329504
sym:   vsprintf info: 12 other: 00 shndx: 2 value: 140 size: 3a4
sym: vsprintf value: 329164 addr: 329550
sym:   vsprintf info: 12 other: 00 shndx: 2 value: 140 size: 3a4
sym: vsprintf value: 329164 addr: 3295b8
sym: my_thread_ptr info: 11 other: 00 shndx: 6 value: 4 size: 4
sym: my_thread_ptr value: 32eab4 addr: 32978a
sym: my_thread_ptr info: 11 other: 00 shndx: 6 value: 4 size: 4
sym: my_thread_ptr value: 32eab4 addr: 32978e
sym:      stack info: 11 other: 00 shndx: 6 value: c size: 4
sym: stack value: 32eabc addr: 329796
sym:      stack info: 11 other: 00 shndx: 6 value: c size: 4
sym: stack value: 32eabc addr: 32979a
sym:  purgatory info: 12 other: 00 shndx: 2 value: 104 size: 3c
sym: purgatory value: 329128 addr: 3297a4
sym:  dt_offset info: 11 other: 00 shndx: 6 value: 8 size: 4
sym: dt_offset value: 32eab8 addr: 3297be
sym:  dt_offset info: 11 other: 00 shndx: 6 value: 8 size: 4
sym: dt_offset value: 32eab8 addr: 3297c2
sym:     kernel info: 11 other: 00 shndx: 6 value: 0 size: 4
sym: kernel value: 32eab0 addr: 3297da
sym:     kernel info: 11 other: 00 shndx: 6 value: 0 size: 4
sym: kernel value: 32eab0 addr: 3297de
sym:     memcpy info: 12 other: 00 shndx: 2 value: 5f8 size: 24
sym: memcpy value: 32961c addr: 32e380
sym: sha256_process info: 12 other: 00 shndx: 2 value: a08 size: 4884
sym: sha256_process value: 329a2c addr: 32e394
sym: sha256_process info: 12 other: 00 shndx: 2 value: a08 size: 4884
sym: sha256_process value: 329a2c addr: 32e3cc
sym:     memcpy info: 12 other: 00 shndx: 2 value: 5f8 size: 24
sym: memcpy value: 32961c addr: 32e41c
sym:      .data info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .data value: 32ea70 addr: 32e53e
sym:      .data info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .data value: 32ea70 addr: 32e542
sym: sha256_update info: 12 other: 00 shndx: 2 value: 528c size: 190
sym: sha256_update value: 32e2b0 addr: 32e548
sym: sha256_update info: 12 other: 00 shndx: 2 value: 528c size: 190
sym: sha256_update value: 32e2b0 addr: 32e55c
Modified cmdline:console=ttyS0,115200 root=/dev/ram  maxcpus=1
reserve regions: 2
0: offset: 23fc000, size: 4000
1: offset: 2fd0e000, size: 2f131a
debug.dtb written
kexec_load: entry = 0x329678 flags = 0x0
nr_segments = 4
segment[0].buf   = 0xb7a9d008
segment[0].bufsz = 0x318c65
segment[0].mem   = (nil)
segment[0].memsz = 0x329000
segment[1].buf   = 0x10082a50
segment[1].bufsz = 0x5ac8
segment[1].mem   = 0x329000
segment[1].memsz = 0x6000
segment[2].buf   = 0x10088580
segment[2].bufsz = 0x3090
segment[2].mem   = 0x23fc000
segment[2].memsz = 0x4000
segment[3].buf   = 0xb779b008
segment[3].bufsz = 0x2f131a
segment[3].mem   = 0x2fd0e000
segment[3].memsz = 0x2f2000
-------------------------------------------------------------------------------------------------------------------------------------------------------
and execute the secondary kernel using the below command
$ kexec -e

As the zImage is also and elf file format, but the control is not
getting transferred to the zImage.
I can see kexec is able to load all the segments properly, but looks
like its not able to figure out the entry point to start execution
with zImage.
-------------------------------------------------------------------------------------------------------------------------------------------------------
kexec_load: entry = 0x329678 flags = 0x0
-------------------------------------------------------------------------------------------------------------------------------------------------------

On the same board (i.e. Freescale p2020ds), uImage and vmlinux works fine.

Just curious to know , why the zImage support is still not provided in
the kexec for ppc ??
Is there any restriction from kexec design point of view ?

Thanks & Regards,
Sunil Kumar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
