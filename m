Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WKJJr-0001HF-VJ
 for kexec@lists.infradead.org; Mon, 03 Mar 2014 03:13:33 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile: get_max_mapnr() from ELF header problem
Date: Mon, 3 Mar 2014 03:11:23 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971EFABE@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu>
In-Reply-To: <20140228134148.15b60ceb@holzheu>
Content-Language: ja-JP
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Michael,

>Hello Atsushi,
>
>On s390 we have the following little problem:
>
>We use hypervisor or stand-alone dump tools to create Linux system
>dumps. These tools do not know the kernel parameter line and dump the
>full physical memory.
>
>We use makedumpfile to filter those dumps.
>
>If a Linux system has specified the "mem=" parameter, the dump tools
>still dump the whole phypsical memory.

I guess this is a problem of the tools, it sounds that the tools ignore
the actual memory map and just make wrong ELF headers.
How do the tools decide the range of System RAM to create ELF headers ?

At least, if the tools respect the actual memory map like /proc/vmcore, it
can create correct ELF headers and makedumpfile will work normally.

>Unfortunately in "get_max_mapnr()" makedumpfile uses the ELF header to
>get the maxmimum page frame number. Since this is not the correct value
>in our case makedumpfile fails to filter the dump.

makedumpfile depends on the ELF file format, you know.
I think you should fix the tools to create correct ELF files.


Thanks
Atsushi Kumagai

>We get the following error on s390 with makedumpfile version 1.5.3:
>
>makedumpfile -c -d 31 vmcore dump.kdump
>cyclic buffer size has been changed: 22156083 => 22156032
>Excluding unnecessary pages        : [ 21 %] vtop_s390x: Address too big for the number of page table levels.
>readmem: Can't convert a virtual address(8000180104670) to physical address.
>readmem: type_addr: 0, addr:8000180104670, size:32768
>__exclude_unnecessary_pages: Can't read the buffer of struct page.
>Excluding unnecessary pages        : [ 23 %] vtop_s390x: Address too big for the number of page table levels. readmem:
>Can't convert a
>virtual address(8000180104670) to physical address. readmem: type_addr:
>0, addr:8000180104670, size:327681.5.5 __exclude_unnecessary_pages:
>Can't read the buffer of struct page.
>
>Since version 1.5.4 makedumpfile seems to loop in __exclude_unnecessary_pages().
>
>We thought about several ways to fix this problem but have not found a
>good solution up to now.
>
>Do you have an idea how we could fix that?
>
>Best Regards,
>Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
