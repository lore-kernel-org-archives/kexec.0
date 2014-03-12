Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNlrd-000185-5l
 for kexec@lists.infradead.org; Wed, 12 Mar 2014 16:18:42 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 12 Mar 2014 16:18:18 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id CD6E01B0804B
 for <kexec@lists.infradead.org>; Wed, 12 Mar 2014 16:18:01 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2CGI2xe64225282
 for <kexec@lists.infradead.org>; Wed, 12 Mar 2014 16:18:02 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2CGIEOl016087
 for <kexec@lists.infradead.org>; Wed, 12 Mar 2014 10:18:14 -0600
Date: Wed, 12 Mar 2014 17:18:12 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: makedumpfile: get_max_mapnr() from ELF header problem
Message-ID: <20140312171812.02f0bfe1@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971F512A@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu> <531FDF6D.5080901@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971F512A@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, 12 Mar 2014 06:01:47 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> >(2014/02/28 21:41), Michael Holzheu wrote:
> >> Hello Atsushi,

[snip]

> >Looking into source code a little, max_mapnr is used only for calculating a size of two bitmaps. I guess there's any
> >s390-specific issue.
> 
> On second thought, Michael's log looks strange.
> 
> >> Excluding unnecessary pages        : [ 21 %] vtop_s390x: Address too big for the number of page table levels.
> >> readmem: Can't convert a virtual address(8000180104670) to physical address.
> >> readmem: type_addr: 0, addr:8000180104670, size:32768
> >> __exclude_unnecessary_pages: Can't read the buffer of struct page.
> 
> This message was shown during translating the virtual address of mem_map
> to the physical address:
> 
> __exclude_unnecessary_pages():
> 
>         if (!readmem(VADDR, mem_map,
>             page_cache + (index_pg * SIZE(page)),
>             SIZE(page) * pfn_mm)) {
>                 ERRMSG("Can't read the buffer of struct page.\n");
>                 return FALSE;
>         }
> 
> However, this should succeed even if mem= was specified because the
> corresponding page table must exist in the memory image since it was
> used by kernel actually. The address translation logic may have an issue.

To be honest I don't really understand what happens when the error occurs.

My test is a 1 TiB dump of a Linux system that has set mem=1G.

With makedumpfile 1.5.3 I see the following stack backtrace:

(gdb) bt
#0  vtop_s390x (vaddr=2251803034918936) at ./arch/s390x.c:236
#1  0x000000008001de44 in vaddr_to_paddr_s390x (vaddr=2251803034918936)
    at ./arch/s390x.c:300
#2  0x000000008001fb50 in readmem (type_addr=0, addr=2251803034918936, 
    bufptr=0x3ffffff6cf0, size=32768) at makedumpfile.c:349
#3  0x0000000080034cf2 in __exclude_unnecessary_pages (
    mem_map=2251803034918936, pfn_start=16777216, pfn_end=16842752)
    at makedumpfile.c:4189
#4  0x0000000080035716 in exclude_unnecessary_pages_cyclic ()
    at makedumpfile.c:4349
#5  0x00000000800358e4 in update_cyclic_region (pfn=0) at makedumpfile.c:4380
#6  0x00000000800384e0 in get_num_dumpable_cyclic () at makedumpfile.c:5060
#7  0x0000000080036850 in create_dump_bitmap () at makedumpfile.c:4585
#8  0x00000000800429c8 in create_dumpfile () at makedumpfile.c:7533
#9  0x00000000800490fc in main (argc=5, argv=0x3fffffff3d8)
    at makedumpfile.c:8651

Looks like makdumpfile wants to read a virtual address 2251803034918936
(hex 0x80000C0002018) which can't be resolved by the three level kernel
page table (max is 4 TiB here).

In the __exclude_unnecessary_pages() function the variables have the
following values:

(gdb) print pfn_end
$1 = 16842752
(gdb) print pfn
$2 = 16777216
(gdb) print pfn_start
$3 = 16777216
(gdb) print mem_map
$4 = 2251803034918936

I would appreciate any hints!

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
