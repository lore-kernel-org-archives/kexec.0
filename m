Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TgTWV-00017C-1s
 for kexec@lists.infradead.org; Thu, 06 Dec 2012 04:57:25 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id qB64vGwx006580
 for <kexec@lists.infradead.org>; Thu, 6 Dec 2012 13:57:16 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id qB64vGX27318 for kexec@lists.infradead.org;
 Thu, 6 Dec 2012 13:57:16 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id qB64vFuU011498
 for <kexec@lists.infradead.org>; Thu, 6 Dec 2012 13:57:15 +0900 (JST)
Date: Thu, 6 Dec 2012 13:32:08 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.5.1: Improve performance for cyclic mode.
Message-Id: <20121206133208.43a8ea142a88c2e17f5aab19@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

makedumpfile version 1.5.1 is released.
Your comments/patches are welcome.

Main new feature:
o Support for snappy compression
  This feature allows you to compress dump data by each page using snappy.
  This feature is optional, the user has to prepare snappy library and
  build binary with USESNAPPY=on to use it. 

o Introduce mem_map array logic
  This is the new logic of excluding free pages. This logic excludes free 
  pages by looking up mem_map array instead of free lists, and is expected
  good performance for cyclic mode.

  This feature requires the values below but vmcore doesn't include them,
  so the user has to prepare vmlinux or vmcoreinfo which includes them. 
  When running on cyclic mode and the required values exist, mem_map array
  logic is used. Otherwise, free list logic is used.

    kernel v2.6.38 to latest:
      - OFFSET(page._mapcount)
      - OFFSET(page.private)
      - NUMBER(PG_slab)
      - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)

    kernel v2.6.18 to v2.6.37:
      - OFFSET(page.private)
      - NUMBER(PG_buddy)

    kernel v2.6.15 to v2.6.17:
      Not supported.

  Additionally, I posted the patch below to add the values above to the
  upstream kernel:

    https://lkml.org/lkml/2012/11/21/90

  If you apply it to 1st kernel, you can use mem_map array logic without
  vmlinux.

Difference from RC:
o Drop "Support for eppic language"
  This feature is under discussion now, I have decided to postpone
  merging it. If you need this feature now, please use v1.5.1-rc:

     http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/v1.5.1-rc

Changelog:
o New feature
   Commits related to "Support for Xen4"
    - [PATCH v3 1/9] Make max_pfn symbol optional for Xen dumps. (by Petr Tesarik) 3823577
    - [PATCH v3 2/9] Xen: Fix the offset of the _domain field in struct page_info. 
      (by Petr Tesarik) 6f0e831
    - [PATCH v3 3/9] Read the Xen crash ELF note into memory at startup. (by Petr Tesarik) 4e11405
    - [PATCH v3 4/9] Split Xen setup into early and late. (by Petr Tesarik) e8295d2
    - [PATCH v3 5/9] Initialize phys_start during early Xen setup. (by Petr Tesarik) 064fbc1
    - [PATCH v3 6/9] Fix domain pickled_id computation for xen-3.4+. (by Petr Tesarik) 3ae13b4
    - [PATCH v3 7/9] Support Xen4 virtuall address space layout. (by Petr Tesarik) 51ea90a
    - [PATCH v3 8/9] Add support for filtering out user pages under Xen4. (by Petr Tesarik) fccad16
    - [PATCH v3 9/9] Do not fail for symbols removed in Xen4. (by Petr Tesarik) 9151172
    - [PATCH] Initialize Xen structures from initial(). (by Petr Tesarik) 56a388e
    - [PATCH] Remove unnecessary valid check for xen_phys_start. (by Atsushi Kumagai) c6248e0

   Commits related to "Support for snappy compression"
    - [PATCH 1/9] Add dump header for snappy. (by HATAYAMA Daisuke) 5634487
    - [PATCH 2/9] Add command-line processing for snappy. (by HATAYAMA Daisuke) 8c69b49
    - [PATCH 3/9] Add snappy build support. (by HATAYAMA Daisuke) c9a24d0
    - [PATCH 4/9] Notify snappy unsupporting when disabled. (by HATAYAMA Daisuke) d075b7f
    - [PATCH 5/9] Add compression processing. (by HATAYAMA Daisuke) 604aacc
    - [PATCH 6/9] Add uncompression processing. (by HATAYAMA Daisuke) 746d5f2
    - [PATCH 7/9] Add help message. (by HATAYAMA Daisuke) 550c19c
    - [PATCH 8/9] Add manual description. (by HATAYAMA Daisuke) ba3ee46
    - [PATCH 9/9] Add README description. (by Atsushi Kumagai) 0626577

   Commits related to "mem_map array logic"
    - [PATCH v2 01/10] Move page flags setup for old kernels after debuginfo initialization.
      (by HATAYAMA Daisuke) 4aca582
    - [PATCH v2 02/10] Add debuginfo interface for enum type size. (by HATAYAMA Daisuke) d3b0a1f
    - [PATCH v2 03/10] Add new parameters to various tables. (by HATAYAMA Daisuke) 7bbbb09
    - [PATCH v2 04/10] Add debuginfo-related processing for VMCOREINFO/VMLINUX. 
      (by HATAYAMA Daisuke) 9811a96
    - [PATCH v2 05/10] Add hardcoded page flag values. (by HATAYAMA Daisuke) cbd69fd
    - [PATCH v2 06/10] Exclude free pages by looking up mem_map array. (by HATAYAMA Daisuke) c4922d4
    - [PATCH v2 07/10] Add page_is_buddy for recent kernels. (by HATAYAMA Daisuke) 92281a8
    - [PATCH v2 08/10] Add page_is_buddy for PG_buddy. (by HATAYAMA Daisuke) 4462855
    - [PATCH v2 09/10] Add page_is_buddy for old kernels. (by HATAYAMA Daisuke) c2968c6
    - [PATCH v2 10/10] Warn cyclic buffer overrun and correct it if possible.
      (by HATAYAMA Daisuke) 51604a0
    - Revert "[PATCH v2 09/10] Add page_is_buddy for old kernels." (by Atsushi Kumagai) b797af5
    - [PATCH] Remove hardcoded PG_buddy value. (by Atsushi Kumagai) 511e160

   Other commit
    - [PATCH] Support for x86_64 1G pages. (by Petr Tesarik) 7b10a11
    - [PATCH] Change dwarf analyzer to search also into named containers. (by Atsushi Kumagai) 1f31b6a
    - [PATCH] s390x: Add 2GB frame support for page table walker. (by Michael Holzheu) f6ab608
    - [PATCH v2 1/2] Add get_free_memory_size() to get the amount of free memory. 
      (by Atsushi Kumagai) 6067dfe
    - [PATCH v2 2/2] Calculate the size of cyclic buffer automatically. (by Atsushi Kumagai) 4104adf
    - [PATCH] Support newer kernels. (by Atsushi Kumagai) 94b5c72

o Bugfix
    - [PATCH] add a missing return statement. (by Petr Tesarik) f6134c7
    - [PATCH] Fix to exclude_unnecessary_pages_cyclic. (by Cliff Wickman) a1c5f49

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

  # makedumpfile -c -d 31 -x vmlinux /proc/vmcore dumpfile


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
