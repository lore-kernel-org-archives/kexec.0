Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KixdU-0002v5-Rr
	for kexec@lists.infradead.org; Thu, 25 Sep 2008 20:40:30 +0000
From: "Worth, Kevin" <kevin.worth@hp.com>
Date: Thu, 25 Sep 2008 20:39:30 +0000
Subject: RE: Problems writing ELF dumps with makedumpfile 1.2.9
Message-ID: <28113A0489833849A1CF9EC16F4215434049588E80@GVW1097EXB.americas.hpqcorp.net>
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>
	<48D72B2B.3000406@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>
	<48D9EDDC.1070600@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>
	<48DB29A6.3070608@mxs.nes.nec.co.jp>
In-Reply-To: <48DB29A6.3070608@mxs.nes.nec.co.jp>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

Hi Ken,ichi,

Below is the additional information you asked for (run with the patch you attached). It appears the binutils readelf has problems with reading the vmcore file (got error message "readelf: Error: Could not locate '/proc/vmcore'.  System error message: Value too large for defined data type"). I installed elfutils and used eu-readelf. That appears to work correctly.



Checking for memory holes          : [  0 %]
Checking for memory holes          : [100 %]
Excluding unnecessary pages        : [100 %]
Excluding free pages               : [100 %]
Excluding zero pages               : [  2 %]
Excluding zero pages               : [ 44 %] readmem: Can't seek the dump memory(/proc/vmcore). (Invalid argument) offset:b2800000ae7a02d8, addr:2c00000000
create_2nd_bitmap: Can't exclude pages filled with zerocreate_2nd_bitmap: for creating an ELF dumpfile.
LOAD (0)
  phys_start : 0
  phys_end   : a0000
  virt_start : c0000000
  virt_end   : c00a0000
LOAD (1)
  phys_start : 100000
  phys_end   : 1000000
  virt_start : c0100000
  virt_end   : c1000000
LOAD (2)
  phys_start : 5000000
  phys_end   : 38000000
  virt_start : c5000000
  virt_end   : f8000000
LOAD (3)
  phys_start : 38000000
  phys_end   : bf790000
  virt_start : ffffffffffffffff
  virt_end   : 8778ffff
LOAD (4)
  phys_start : 100000000
  phys_end   : 140000000
  virt_start : ffffffffffffffff
  virt_end   : 3fffffff
Linux kdump

max_mapnr    : 140000

PAE          : ON
kernel_start : 40000000
vmalloc_start: f8800000

num of NODEs : 1


Memory type  : FLATMEM

mem_map (0)
  mem_map    : 45000000
  pfn_start  : 0
  pfn_end    : 140000

makedumpfile Failed.

ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Ident Version:                     1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              CORE (Core file)
  Machine:                           Intel 80386
  Version:                           1 (current)
  Entry point address:               0
  Start of program headers:          64 (bytes into file)
  Start of section headers:          0 (bytes into file)
  Flags:
  Size of this header:               64 (bytes)
  Size of program header entries:    56 (bytes)
  Number of program headers entries: 6
  Size of section header entries:    0 (bytes)
  Number of section headers entries: 0 ([0] not available)
  Section header string table index: 0

Section Headers:
[Nr] Name                 Type         Addr             Off      Size     ES Flags Lk Inf Al

Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
  NOTE           0x000190 0x0000000000000000 0x0000000000000000 0x000148 0x000148     0x0
  LOAD           0x0002d8 0x00000000c0000000 0x0000000000000000 0x0a0000 0x0a0000 RWE 0x0
  LOAD           0x0a02d8 0x00000000c0100000 0x0000000000100000 0xf00000 0xf00000 RWE 0x0
  LOAD           0xfa02d8 0x00000000c5000000 0x0000000005000000 0x33000000 0x33000000 RWE 0x0
  LOAD           0x33fa02d8 0xffffffffffffffff 0x0000000038000000 0x87790000 0x87790000 RWE 0x0
  LOAD           0xbb7302d8 0xffffffffffffffff 0x0000000100000000 0x40000000 0x40000000 RWE 0x0

 Section to Segment mapping:
  Segment Sections...
   00
   01
   02
   03
   04
   05

Note segment of 328 bytes at offset 0x190:
  Owner          Data size  Type
  CORE                 144  PRSTATUS
    SIGINFO:  signo: 0, code = 0, errno = 0
    signal: 0, pending: 00000000, holding:        0
    pid: 5158, ppid = 0, pgrp = 0, sid = 0
     utime:      0.000000s,  stime:      0.000000s
    cutime:      0.000000s, cstime:      0.000000s
    eax: 00000000  ebx: 403d4600  ecx: 5ee14000  edx: 00000000
    esi: 00000000  edi: 00000063  ebp: f2cdbf30  esp: f2cdbee8
    eip: 4014dbb5  eflags: 00000046  original eax: f2cdbf7c
    cs: 0060  ds: 007b  es: 007b  fs: 0000  gs: 8241  ss: 0068

  CORE                 144  PRSTATUS
    SIGINFO:  signo: 0, code = 0, errno = 0
    signal: 0, pending: 00000000, holding:        0
    pid: 0, ppid = 0, pgrp = 0, sid = 0
     utime:      0.000000s,  stime:      0.000000s
    cutime:      0.000000s, cstime:      0.000000s
    eax: 00000030  ebx: 00000001  ecx: 00000001  edx: 00000000
    esi: 00000030  edi: 5d586008  ebp: 5d587f3c  esp: 5d587f30
    eip: 40101289  eflags: 00000046  original eax: 00000030
    cs: 0060  ds: 007b  es: 007b  fs: 0000  gs: 00d8  ss: 0068



-----Original Message-----
From: Ken'ichi Ohmichi [mailto:oomichi@mxs.nes.nec.co.jp]
Sent: Wednesday, September 24, 2008 11:03 PM
To: Worth, Kevin
Cc: Masaki Tachibana; kexec-ml
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9


Hi Kevin,

Thank you for the test and the report.

Worth, Kevin wrote:
> Wow! That was quick turn-around time- just over 12 hours!
>
> The line breaks in the email caused problems with patching, and I'd rather not sync completely to the CVS tree,
> but I was able to just pull the patches from sourceforge using the following links
> http://makedumpfile.cvs.sourceforge.net/makedumpfile/makedumpfile/makedumpfile.c?r1=1.7.2.48&r2=1.7.2.49&view=patch
> http://makedumpfile.cvs.sourceforge.net/makedumpfile/makedumpfile/makedumpfile.h?r1=1.4.2.31&r2=1.4.2.32&view=patch
> http://makedumpfile.cvs.sourceforge.net/makedumpfile/makedumpfile/x86.c?r1=1.2.2.20&r2=1.2.2.21&view=patch
>
> The diff looked identical to what you sent, so I patched the source and built.
>
> It appears to now work fine when I specify "-d 31", and it continues to work on my system with 2GB of memory.

That is good.

> However, on my identically-configured (identical hardware too) system with 4GB of memory my log file contains.
> This was just triggered with an alt-sysrq-c.
>
> ^MChecking for memory holes          : [  0 %] ^MChecking for memory holes
>     : [100 %] ^MExcluding unnecessary pages        : [100 %] ^MExcluding free pa
> ges               : [100 %] ^MExcluding zero pages               : [ 18 %] readm
> em: Can't seek the dump memory(/proc/vmcore). Invalid argument
> create_2nd_bitmap: Can't exclude pages filled with zerocreate_2nd_bitmap: for cr
> eating an ELF dumpfile.
>
> makedumpfile Failed.

According to your test, lseek(2) failed by EINVAL in readmem().
I want to know the 'offset' value and the 'addr' value to solve it.
Could you test again with both the attached patch and yesterday patch ?

One more, please run makedumpfile with '-D' option for debugging,
and send me both the result and `readelf -a /proc/vmcore` output.
`readelf -a /proc/vmcore` output is useful, because the 'offset'
is taken by referring PT_LOAD header of ELF header,


Thanks
Ken'ichi Ohmichi


diff -puN makedumpfile.org/makedumpfile.c makedumpfile/makedumpfile.c
--- makedumpfile.org/makedumpfile.c     2008-09-25 14:59:52.000000000 +0900
+++ makedumpfile/makedumpfile.c 2008-09-25 14:59:00.000000000 +0900
@@ -257,8 +257,8 @@ readmem(int type_addr, unsigned long lon
        }

        if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-               ERRMSG("Can't seek the dump memory(%s). %s\n",
-                   info->name_memory, strerror(errno));
+               ERRMSG("Can't seek the dump memory(%s). (%s) offset:%llx, addr:%llx\n",
+                   info->name_memory, strerror(errno), offset, addr);
                return FALSE;
        }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
