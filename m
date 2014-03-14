Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WONuW-0004Lm-Cq
 for kexec@lists.infradead.org; Fri, 14 Mar 2014 08:56:14 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile: get_max_mapnr() from ELF header problem
Date: Fri, 14 Mar 2014 08:54:11 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F672F@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu> <531FDF6D.5080901@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971F512A@BPXM01GP.gisp.nec.co.jp>
 <20140312171812.02f0bfe1@holzheu>
In-Reply-To: <20140312171812.02f0bfe1@holzheu>
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

>My test is a 1 TiB dump of a Linux system that has set mem=1G.
>
>With makedumpfile 1.5.3 I see the following stack backtrace:
>
>(gdb) bt
>#0  vtop_s390x (vaddr=2251803034918936) at ./arch/s390x.c:236
>#1  0x000000008001de44 in vaddr_to_paddr_s390x (vaddr=2251803034918936)
>    at ./arch/s390x.c:300
>#2  0x000000008001fb50 in readmem (type_addr=0, addr=2251803034918936,
>    bufptr=0x3ffffff6cf0, size=32768) at makedumpfile.c:349
>#3  0x0000000080034cf2 in __exclude_unnecessary_pages (
>    mem_map=2251803034918936, pfn_start=16777216, pfn_end=16842752)
>    at makedumpfile.c:4189
>#4  0x0000000080035716 in exclude_unnecessary_pages_cyclic ()
>    at makedumpfile.c:4349
>#5  0x00000000800358e4 in update_cyclic_region (pfn=0) at makedumpfile.c:4380
>#6  0x00000000800384e0 in get_num_dumpable_cyclic () at makedumpfile.c:5060
>#7  0x0000000080036850 in create_dump_bitmap () at makedumpfile.c:4585
>#8  0x00000000800429c8 in create_dumpfile () at makedumpfile.c:7533
>#9  0x00000000800490fc in main (argc=5, argv=0x3fffffff3d8)
>    at makedumpfile.c:8651
>
>Looks like makdumpfile wants to read a virtual address 2251803034918936
>(hex 0x80000C0002018) which can't be resolved by the three level kernel
>page table (max is 4 TiB here).
>
>In the __exclude_unnecessary_pages() function the variables have the
>following values:
>
>(gdb) print pfn_end
>$1 = 16842752
>(gdb) print pfn
>$2 = 16777216
>(gdb) print pfn_start
>$3 = 16777216
>(gdb) print mem_map
>$4 = 2251803034918936
>
> I would appreciate any hints!

What were these values when you didn't specify mem=1G ?
The mem_map information can be shown with -D option
like below:

    $ makedumpfile -D -cd31 vmcore dumpfile
    ...

    Memory type  : SPARSEMEM

    mem_map (0)
      mem_map    : f6d7f000
      pfn_start  : 0
      pfn_end    : 20000
    mem_map (1)
      mem_map    : f697f000
      pfn_start  : 20000
      pfn_end    : 40000
    ...

Could you show me both log of mem=1G and log of no mem= option ?
The difference may help us.

BTW, is the command below the actual command line you used ?

  makedumpfile -c -d 31 vmcore dump.kdump

If yes, the dumpfile must have VMOCREINFO since you didn't
specify neither -x nor -i option, i.e. the s390 dump tool
generates a PT_NOTE entry as VMCOREINFO, really ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
