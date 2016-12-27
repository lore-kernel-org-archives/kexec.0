Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cLnBd-0004mp-7X
 for kexec@lists.infradead.org; Tue, 27 Dec 2016 08:32:46 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id uBR8WLgD001439
 for <kexec@lists.infradead.org>; Tue, 27 Dec 2016 17:32:21 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id uBR8WKV27907 for <kexec@lists.infradead.org>;
 Tue, 27 Dec 2016 17:32:20 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id uBR8WKPM016116
 for <kexec@lists.infradead.org>; Tue, 27 Dec 2016 17:32:20 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: makedumpfile-1.6.1: Enhance the support for ppc64 and arm64
Date: Tue, 27 Dec 2016 07:38:16 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E8ED81@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

Thank you for waiting, at last makedumpfile version 1.6.1 is released.
Your comments/patches are welcome.

Main new feature:
o Support new kernels
 - The supported kernel is updated to 4.8 in this version.

Changelog:
o New feature
    - [PATCH v2] Support _count -> _refcount rename in struct page (by Vitaly Kuznetsov) ed46b6a
    - [PATCH 1/8] ppc64: fix vtop page translation for 4K pages (by Hari Bathini) cf02f88
    - [PATCH 2/8] ppc64: Use kernel terminology for each level in 4-level page table (by Hari Bathini) 37abbe1
    - [PATCH 3/8] ppc64: address changes in kernel v4.5 (by Hari Bathini) bc86b61
    - [PATCH 4/8] ppc64: address change in _PAGE_PRESNT flag for PowerISA v3.0 (by Hari Bathini) 3003fbe
    - [PATCH 5/8] ppc64: use physical addresses and unfold pud for 64K page size (by Hari Bathini) afe7f9f
    - [PATCH 6/8] ppc64: support big endian Linux page tables (by Hari Bathini) f3d7cc5
    - [PATCH 7/8] ppc64: use the same masked bit values for 4K and 64K pagesizes (by Hari Bathini) 398746a
    - [PATCH 8/8] ppc64: enable address translation support for radix mmu (by Hari Bathini) ed65d60
    - [PATCH 01/10] arm64: cleanup code, comment, blank space, blank lines etc (by Pratyush Anand) c42c582
    - [PATCH 02/10] read_vmcoreinfo_long: Allow to read hex values as well (by Pratyush Anand) b01fa28
    - [PATCH 03/10] Introduce read_vmcoreinfo_ulong() (by Pratyush Anand) edc314e
    - [PATCH 04/10] arm64: use already available PAGESIZE() and PAGESHIFT() macros (by Pratyush Anand) 48581a7
    - [PATCH 05/10] arm64: fix page_offset definition (by Pratyush Anand) a4335c6
    - [PATCH 06/10] arm64: fix re-filtering (by Pratyush Anand) 618b76c
    - [PATCH 07/10] arm64: use value of VA_BITS and PHYS_OFFSET embedded into vmcore (by Pratyush Anand) 74df822
    - [PATCH 08/10] arm64: immunize identity mapped address finding w.r.t. kernel changes (by Pratyush Anand) a84f726
    - [PATCH 09/10] arm64: Add support for 4level 4K page translations table (by Azriel Samson) 969ee30
    - [PATCH 10/10] arm64: fix memory layout as per changes in v4.6 kernel (by Pratyush Anand) b6fe70c

o Bugfix
    - [PATCH 1/2] sadump: fix segmentation fault on sadump-related formats (by HATAYAMA Daisuke) 0ba14bc
    - [PATCH 2/2] sadump: fix wrong progress report on sadump formats (by HATAYAMA Daisuke) d5d268b
    - [PATCH] Fix module init base and size offset for kernel v4.5 (by Guenther Hutzl) 32dd468
    - [PATCH] Fix uninitialized file descriptors for parallel dump (by Atsushi Kumagai) 1474dd4
    - [PATCH] x86_64: Set zero to phys_base for the kernel older than 2.6.22 (by Atsushi Kumagai) 114060b

o Cleanup
    - [PATCH] Add more descriptions of multi-threads feature (by Zhou Wenjian) 2af8d6a
    - [PATCH v2] Cleanup: Use a negative number for uninitialized file descriptors (by Petr Tesarik) 8b8fa9f
    - [PATCH v3 1/3] open_dump_bitmap: open bitmap file in non-cyclic case (by Martin Wilck) a8d8657
    - [PATCH v3 2/3] move call to open_dump_bitmap() to after call to initial() (by Martin Wilck) 3696c40
    - [PATCH v3 3/3] close_dump_bitmap: simplify logic (by Martin Wilck) c1c53f8
    - [PATCH v2 1/2] Adapt code to get value of phys_base (by Baoquan He) acdbb1d
    - [PATCH V2 1/4] x86_64: Calculate page_offset from pt_load (by Pratyush Anand) 0c9dd01
    - [PATCH V2 2/4] x86_64: translate all VA to PA using page table values (by Pratyush Anand) c41e33c
    - [PATCH V2 3/4] x86_64: kill is_vmalloc_addr_x86_64() (by Pratyush Anand) 8419f4d
    - [PATCH V2 4/4] x86_64: kill some unused initialization (by Pratyush Anand) ecb3719
    - [PATCH v2 2/2] Clean up unused KERNEL_IMAGE_SIZE (by Atsushi Kumagai) 0068010

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  You can download the latest makedumpfile from the following URL.
  Details of the change are written on the git page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-x.y.z.tar.gz"
  2. "cd makedumpfile-x.y.z"
  3. "make; make install"

Usage:
  makedumpfile [-c|-l|-p] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file

Example:
  If you want to exclude pages filled by zero, cache pages, user pages
  and free pages and to enable compression, please execute the following
  command.	

  # makedumpfile -c -d 31 /proc/vmcore dumpfile


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
