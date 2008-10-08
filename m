Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([59.145.155.7] helo=e28esmtp07.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnZHE-0001hR-C3
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 13:40:33 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp07.in.ibm.com (8.13.1/8.13.1) with ESMTP id m98DeSCB016068
	for <kexec@lists.infradead.org>; Wed, 8 Oct 2008 19:10:28 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m98DeSiu1622248
	for <kexec@lists.infradead.org>; Wed, 8 Oct 2008 19:10:28 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m98DeR6C015227
	for <kexec@lists.infradead.org>; Thu, 9 Oct 2008 00:40:28 +1100
Message-ID: <48ECB84D.30707@in.ibm.com>
Date: Wed, 08 Oct 2008 19:10:29 +0530
From: Chandru <chandru@in.ibm.com>
MIME-Version: 1.0
Subject: Re: kdump: quad core Opteron
References: <48EB5B68.8010401@in.ibm.com> <20081007132401.GA4007@redhat.com>
In-Reply-To: <20081007132401.GA4007@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org

Vivek Goyal wrote:
> Hi Chandru,
>
> How much memory this system has got. Can you also paste the output of 
> /proc/iomem of first kernel.
>
> Does this system has GART? So looks like we are accessing some memory area
> which platform does not like. (We saw issues with GART in the past.)
>   
The system has 8GB of RAM. /proc/iomem shows the following without 
mem=4G boot parameter

[root@abc]# cat /proc/iomem

00000000-0009afff : System RAM
0009b000-0009ffff : reserved
000e0000-000fffff : reserved
00100000-cff9f6ff : System RAM
00200000-0048adc9 : Kernel code
0048adca-005ee18f : Kernel data
0076d000-00823a4b : Kernel bss
02000000-11ffffff : Crash kernel
20000000-23ffffff : GART
cff9f700-cffa6fff : ACPI Tables
cffa7000-cfffffff : reserved
d4000000-d41fffff : PCI Bus 0000:01
d4000000-d41fffff : PCI Bus 0000:02
d4000000-d41fffff : PCI Bus 0000:03
d4000000-d41fffff : 0000:03:00.0
d4200000-d421ffff : 0000:00:05.0
d6000000-d6ffffff : PCI Bus 0000:0a
d7000000-d7ffffff : PCI Bus 0000:09
d8000000-d8ffffff : PCI Bus 0000:08
d9000000-d9ffffff : PCI Bus 0000:07
db000000-dcffffff : PCI Bus 0000:05
dc000000-dcffffff : PCI Bus 0000:06
de000000-e70fffff : PCI Bus 0000:01
de000000-e50fffff : PCI Bus 0000:02
de000000-e2ffffff : PCI Bus 0000:04
de000000-dfffffff : 0000:04:00.0
de000000-dfffffff : bnx2
e0000000-e1ffffff : 0000:04:00.1
e0000000-e1ffffff : bnx2
e4000000-e50fffff : PCI Bus 0000:03
e5000000-e500ffff : 0000:03:00.0
e5000000-e500ffff : mpt
e5010000-e5013fff : 0000:03:00.0
e5010000-e5013fff : mpt
e7000000-e701ffff : 0000:01:00.0
e8000000-efffffff : 0000:00:05.0
f3fed000-f3fedfff : 0000:00:0f.2
f3fed000-f3fedfff : ehci_hcd
f3fee000-f3feefff : 0000:00:0f.1
f3fee000-f3feefff : ohci_hcd
f3fef000-f3feffff : 0000:00:0f.0
f3fef000-f3feffff : ohci_hcd
f3ff0000-f3ffffff : 0000:00:05.0
f4000000-fbffffff : reserved
fa000000-faafffff : PCI MMCONFIG 0
fec00000-ffffffff : reserved
fec00000-fec00fff : IOAPIC 0
fec02000-fec02fff : IOAPIC 1
fed00000-fed003ff : HPET 0
fee00000-fee00fff : Local APIC
100000000-22fffffff : System RAM



With mem=4G /proc/iomem is as follows. The GART memory range seems to be 
missing here

00000000-0009afff : System RAM
0009b000-0009ffff : reserved
000e0000-000fffff : reserved
00100000-cff9f6ff : System RAM
00200000-0048adc9 : Kernel code
0048adca-005ee18f : Kernel data
0076d000-00823a4b : Kernel bss
02000000-11ffffff : Crash kernel
cff9f700-cffa6fff : ACPI Tables
cffa7000-cfffffff : reserved
d4000000-d41fffff : PCI Bus 0000:01
d4000000-d41fffff : PCI Bus 0000:02
d4000000-d41fffff : PCI Bus 0000:03
d4000000-d41fffff : 0000:03:00.0
d4200000-d421ffff : 0000:00:05.0
d6000000-d6ffffff : PCI Bus 0000:0a
d7000000-d7ffffff : PCI Bus 0000:09
d8000000-d8ffffff : PCI Bus 0000:08
d9000000-d9ffffff : PCI Bus 0000:07
db000000-dcffffff : PCI Bus 0000:05
dc000000-dcffffff : PCI Bus 0000:06
de000000-e70fffff : PCI Bus 0000:01
de000000-e50fffff : PCI Bus 0000:02
de000000-e2ffffff : PCI Bus 0000:04
de000000-dfffffff : 0000:04:00.0
de000000-dfffffff : bnx2
e0000000-e1ffffff : 0000:04:00.1
e0000000-e1ffffff : bnx2
e4000000-e50fffff : PCI Bus 0000:03
e5000000-e500ffff : 0000:03:00.0
e5000000-e500ffff : mpt
e5010000-e5013fff : 0000:03:00.0
e5010000-e5013fff : mpt
e7000000-e701ffff : 0000:01:00.0
e8000000-efffffff : 0000:00:05.0
f3fed000-f3fedfff : 0000:00:0f.2
f3fed000-f3fedfff : ehci_hcd
f3fee000-f3feefff : 0000:00:0f.1
f3fee000-f3feefff : ohci_hcd
f3fef000-f3feffff : 0000:00:0f.0
f3fef000-f3feffff : ohci_hcd
f3ff0000-f3ffffff : 0000:00:05.0
f4000000-fbffffff : reserved
fa000000-faafffff : PCI MMCONFIG 0
fec00000-ffffffff : reserved
fec00000-fec00fff : IOAPIC 0
fec02000-fec02fff : IOAPIC 1
fed00000-fed003ff : HPET 0
fee00000-fee00fff : Local APIC


> Can you also provide /proc/vmcore ELF header (readelf output), in both
> the cases (mem=4G and without that).
>   
ELF header with mem=4G

ELF Header:
Magic: 7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
Class: ELF64
Data: 2's complement, little endian
Version: 1 (current)
OS/ABI: UNIX - System V
ABI Version: 0
Type: CORE (Core file)
Machine: Advanced Micro Devices X86-64
Version: 0x1
Entry point address: 0x0
Start of program headers: 64 (bytes into file)
Start of section headers: 0 (bytes into file)
Flags: 0x0
Size of this header: 64 (bytes)
Size of program headers: 56 (bytes)
Number of program headers: 5
Size of section headers: 0 (bytes)
Number of section headers: 0
Section header string table index: 0

There are no sections in this file.

There are no sections in this file.

Program Headers:
Type Offset VirtAddr PhysAddr
FileSiz MemSiz Flags Align
NOTE 0x0000000000000158 0x0000000000000000 0x0000000000000000
0x0000000000000b20 0x0000000000000b20 0
LOAD 0x0000000000000c78 0xffffffff80200000 0x0000000000200000
0x0000000000624000 0x0000000000624000 RWE 0
LOAD 0x0000000000624c78 0xffff810000000000 0x0000000000000000
0x00000000000a0000 0x00000000000a0000 RWE 0
LOAD 0x00000000006c4c78 0xffff810000100000 0x0000000000100000
0x0000000001f00000 0x0000000001f00000 RWE 0
LOAD 0x00000000025c4c78 0xffff810012000000 0x0000000012000000
0x00000000bdf9f700 0x00000000bdf9f700 RWE 0

There is no dynamic section in this file.

There are no relocations in this file.

There are no unwind sections in this file.

No version information found in this file.

Notes at offset 0x00000158 with length 0x00000b20:
Owner Data size Description
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)


------------------------------------------------------------------------------------

ELF header without mem=4G

ELF Header:
Magic: 7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
Class: ELF64
Data: 2's complement, little endian
Version: 1 (current)
OS/ABI: UNIX - System V
ABI Version: 0
Type: CORE (Core file)
Machine: Advanced Micro Devices X86-64
Version: 0x1
Entry point address: 0x0
Start of program headers: 64 (bytes into file)
Start of section headers: 0 (bytes into file)
Flags: 0x0
Size of this header: 64 (bytes)
Size of program headers: 56 (bytes)
Number of program headers: 6
Size of section headers: 0 (bytes)
Number of section headers: 0
Section header string table index: 0

There are no sections in this file.

There are no sections in this file.

Program Headers:
Type Offset VirtAddr PhysAddr
FileSiz MemSiz Flags Align
NOTE 0x0000000000000190 0x0000000000000000 0x0000000000000000
0x0000000000000b20 0x0000000000000b20 0
LOAD 0x0000000000000cb0 0xffffffff80200000 0x0000000000200000
0x0000000000624000 0x0000000000624000 RWE 0
LOAD 0x0000000000624cb0 0xffff810000000000 0x0000000000000000
0x00000000000a0000 0x00000000000a0000 RWE 0
LOAD 0x00000000006c4cb0 0xffff810000100000 0x0000000000100000
0x0000000001f00000 0x0000000001f00000 RWE 0
LOAD 0x00000000025c4cb0 0xffff810012000000 0x0000000012000000
0x00000000bdf9f700 0x00000000bdf9f700 RWE 0
LOAD 0x00000000c05643b0 0xffff810100000000 0x0000000100000000
0x0000000130000000 0x0000000130000000 RWE 0

There is no dynamic section in this file.

There are no relocations in this file.

There are no unwind sections in this file.

No version information found in this file.

Notes at offset 0x00000190 with length 0x00000b20:
Owner Data size Description
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)
CORE 0x00000150 NT_PRSTATUS (prstatus structure)


> You can try putting some printk in /proc/vmcore code and see which
> physical memory area you are accessing when system goes bust. If in all
> the failure cases it is same physical memory area, then we can try to find
> what's so special about it.
> Thanks
> Vivek
>   

The vmcore-incomplete files are of different sizes at different runs ( 
18M, 32M.. ) and in case of n/w copy we get ( 190M, 198M ).
I tried with the patch priovided by Bob Montgomery and it seems like it 
is working on this machine.

Thanks,
Chandru

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
