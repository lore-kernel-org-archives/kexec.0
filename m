Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hipp2-0008Qy-Ou
	for kexec@lists.infradead.org; Tue, 01 May 2007 11:43:07 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l41AgmgB024485
	for <kexec@lists.infradead.org>; Tue, 1 May 2007 06:42:48 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l41Agl8u190708
	for <kexec@lists.infradead.org>; Tue, 1 May 2007 04:42:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l41AglQD029535
	for <kexec@lists.infradead.org>; Tue, 1 May 2007 04:42:47 -0600
Date: Tue, 1 May 2007 16:12:31 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: gdb 6.5 does not open linux kernel core file properly
Message-ID: <20070501104231.GA5204@in.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: gdb@sourceware.org
Cc: Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>

Hi,

I am using gdb to open a linux kernel core file generated for x86_64
platform. But gdb is not analyzing the dumps properly. Its getting the
wrong symbol values. For example, following case prints two different values
for same symbol panic_timeout.


#gdb vmlinux
(gdb) p &panic_timeout
$1 = (int *) 0xffffffff808a1fa8


#gdb vmlinux vmcore
(gdb) p &panic_timeout
$1 = (int *) 0xffffffff008aaebf

First one is the right value. Why gdb is giving incorrect results while
opened with vmcore?

I am using GNU gdb Red Hat Linux (6.5-5.fc6rh).

This problem is not present in gdb 6.4. It works perfectly fine.

Note, this vmlinux file is of ET_DYN type. It has been compiled as an
executable and then an external program changes elf type to ET_DYN because
this is a fully relocatable executable and can be loaded at any physical 
address.

Any idea, what's wrong.

vmlinux ELF header is as follows.

ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Shared object file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x200000
  Start of program headers:          64 (bytes into file)
  Start of section headers:          61579848 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         5
  Size of section headers:           64 (bytes)
  Number of section headers:         51
  Section header string table index: 48

vmcore ELF header and PT_LOAD headers are as follows.

ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              CORE (Core file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          64 (bytes into file)
  Start of section headers:          0 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         6
  Size of section headers:           0 (bytes)
  Number of section headers:         0
  Section header string table index: 0
There are no sections in this file.

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x0000000000000190 0x0000000000000000 0x0000000000000000
                 0x0000000000000b20 0x0000000000000b20         0
  LOAD           0x0000000000000cb0 0xffffffff80200000 0x0000000000200000
                 0x0000000000742000 0x0000000000742000  RWE    0
  LOAD           0x0000000000742cb0 0xffff810000000000 0x0000000000000000
                 0x00000000000a0000 0x00000000000a0000  RWE    0
  LOAD           0x00000000007e2cb0 0xffff810000100000 0x0000000000100000
                 0x0000000000f00000 0x0000000000f00000  RWE    0
  LOAD           0x00000000016e2cb0 0xffff810009000000 0x0000000009000000
                 0x00000000c6f8dc80 0x00000000c6f8dc80  RWE    0
  LOAD           0x00000000c8670930 0xffff810100000000 0x0000000100000000
                 0x0000000130000000 0x0000000130000000  RWE    0

Thanks
Vivek
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
