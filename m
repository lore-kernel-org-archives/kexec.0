Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUQz1-00021f-5O
 for kexec@lists.infradead.org; Thu, 18 Sep 2014 01:58:08 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s8I1vgU9005607
 for <kexec@lists.infradead.org>; Thu, 18 Sep 2014 10:57:42 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id s8I1vgx18905 for <kexec@lists.infradead.org>;
 Thu, 18 Sep 2014 10:57:42 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id s8I1vfhn015030
 for <kexec@lists.infradead.org>; Thu, 18 Sep 2014 10:57:42 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.5.7: hugepages are now excluded.
Date: Thu, 18 Sep 2014 01:56:05 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D4766E@BPXM01GP.gisp.nec.co.jp>
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

makedumpfile version 1.5.7 is released.
Your comments/patches are welcome.

Main new feature:
o Show the memory usage of 1st kernel
 - Add the new option "--mem-usage" to show the memory usage at
   a given moment in 1st kernel. This will be helpful to estimate
   the appropriate storage size to store a filtered dumpfile,
   thanks Baoquan.

o hugepage filtering
 - Both THPs and hugetlbfs pages are now excluded as user pages.
   As for hugetlbfs, this feature will be enabled for linux-3.16
   or later.

o Support new kernels
 - The supported kernel is updated to 3.16 in this version.

Changelog:
o New feature
  Commits related to "Show the memory usage of 1st kernel"
    - [PATCH v6 1/8] Initialize pfn_memhole in get_num_dumpable_cyclic. (by Baoquan He) 794d333
    - [PATCH v6 2/8] Functions to get crashkernel memory range. (by Baoquan He) d3f7969
    - [PATCH v6 3/8] Preparation functions for parsing vmcoreinfo. (by Baoquan He) 980935a
    - [PATCH v6 4/8] Set vmcoreinfo for kcore. (by Baoquan He) b3e8ea7
    - [PATCH v6 5/8] Prepare the dump loads for kcore analysis. (by Baoquan He) 6108722
    - [PATCH v6 6/8] Introduce a function exclude_zero_pages_cyclic(). (by Baoquan He) 78328df
    - [PATCH v6 7/8] Implement a function to print the memory usage. (by Baoquan He) fe88093
    - [PATCH v6 8/8] Add a new interface to show the memory usage of 1st kernel. (by Baoquan He) beee349
    - [PATCH v2 1/2] Supplement the description of option --mem-usage. (by Baoquan He) 1611dea
    - [PATCH v2 2/2] Message printing cleanup for option --mem-usage. (by Baoquan He) 185e3f4
  Other Commits
    - [PATCH v4 1/2] Generic handling of multi-page exclusions. (by Petr Tesarik) 6c19012
    - [PATCH v4 2/2] Get rid of overrun adjustments. (by Petr Tesarik) 22a614a
    - [PATCH v3 1/2] Initialize for vmalloc address translation support in PPC64 arch.
      (by Hari Bathini) 7e213b8
    - [PATCH v3 2/2] vtop address translation support for vmalloc region in PPC64 arch.
      (by Hari Bathini) 9ab929f
    - [PATCH v4] Exclude unnecessary hugepages. (by Atsushi Kumagai) e8b4f93

o Bugfix
    - [PATCH] Fix bug on is_sparsemem_extreme. (by Liu Hua) 5b143ba
    - [PATCH v3] Fix free bitmap_buffer_cyclic error. (by Arthur Zou) 0e7b1a6
    - [PATCH] ARM: fix bug on sparse_decode_mem_map. (by Liu Hua) 825729c
    - [PATCH] Get MAX_PHYSMEM_BITS and SECTION_SIZE_BITS from vmcore. (by Liu Hua) 5d1f209
    - [PATCH] Stop adjusting info->max_mapnr when no mem_maps are found. 
      (by Atsushi Kumagai) 5f4a810

o Cleanup
    - [PATCH v3] Introduce the mdf_pfn_t type. (by Petr Tesarik) 9dc6440
    - [PATCH] Fix Makefile for eppic_makedumpfile.so build. (by WANG Chao) 45fc42c
    - [PATCH 1/3] Remove the 1st bitmap buffer from the ELF path in cyclic mode. 
      (by Atsushi Kumagai) 16b94ab
    - [PATCH 2/3] Move counting pfn_memhole for cyclic mode. (by Atsushi Kumagai) 2648a8f
    - [PATCH 3/3] Stop maximizing the bitmap buffer to reduce the risk of OOM.
      (by Atsushi Kumagai) 0b73282
    - [PATCH] dump_log_entry: replace magic constant with a variable. (by Petr Tesarik) af7b518
    - [PATCH v2] Fix dmesg format after crash utility. (by Atsushi Kumagai) e64af5b
    - [PATCH] Fix description about filtering for Xen. (by Atsushi Kumagai) 2a98a91
    - [PATCH] Remove the task about remap allocator from TODO list. (by Atsushi Kumagai) ee8de90


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
  makedumpfile [-c] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file

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
