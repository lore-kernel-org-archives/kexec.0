Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZH6d-0004qZ-CC
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 08:16:57 +0000
Received: from mailgate4.nec.co.jp ([10.7.69.184])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id qAG8GitT026133
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 17:16:44 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id qAG8Gih29842 for kexec@lists.infradead.org;
 Fri, 16 Nov 2012 17:16:44 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id qAG8Gihg009552
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 17:16:44 +0900 (JST)
Date: Fri, 16 Nov 2012 17:15:39 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC] makedumpfile-1.5.1 RC
Message-Id: <20121116171539.152467f3611c12fbd6b6be0d@mxc.nes.nec.co.jp>
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

This is the makedumpfile version 1.5.1-rc.
Your comments/patches are welcome.

  http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/v1.5.1-rc

If there is no problem, I will release v1.5.1 GA on Nov 28.


Main new feature:
o Support for snappy compression
  This feature allows you to compress dump data by each page using snappy.
  This feature is optional, the user has to prepare snappy library and
  build binary with USESNAPPY=on to use it. 

o Support for eppic language
  This feature allows you to scrub data in a dumpfile with eppic macro.
  Eppic macro can specify more flexible rules for scrubbing than the original
  rules specified with --config option.
  This feature is optional, the user has to prepare eppic (and tinfo) library 
  and build binary with EPPIC=on to use it. 

o Introduce mem_map array logic
  This is the new logic of excluding free pages. This logic excludes free 
  pages by looking up mem_map array instead of free lists, be expected
  good performance for cyclic mode.
  This feature requires the values below but vmcore doesn't include them,
  so the user has to prepare vmlinux or vmcoreinfo which includes them. 
  When running on cyclic mode and the required values exist, mem_map array
  logic is used. Otherwise, free list logic is used.
  
    - OFFSET(page._mapcount)
    - OFFSET(page.private)
    - SIZE(pageflags)
    - NUMBER(PG_buddy)
    - NUMBER(PG_slab)
    - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)

  Additionally, I will post the patch to add the values above to the upstream
  kernel, so vmlinux and vmcoreinfo will be unnecessary for this feature soon.


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

   Commits related to "Support for eppic language"
    - [PATCH v2 1/7] Initialize and setup eppic. (by Aravinda Prasad) 5a9be3f
    - [PATCH v2 2/7] makedumpfile and eppic interface layer. (by Aravinda Prasad) da46854
    - [PATCH v2 3/7] Eppic call back functions to query a dump image. (by Aravinda Prasad) 3808381
    - [PATCH v2 4/7] Implement apigetctype call back function. (by Aravinda Prasad) 213cc99
    - [PATCH v2 5/7] Implement apimember and apigetrtype call back functions. 
      (by Aravinda Prasad) 424a241
    - [PATCH v2 6/7] Extend eppic built-in functions to include memset function. 
      (by Aravinda Prasad) 587d8a3
    - [PATCH v2 7/7] Support fully typed symbol access mode. (by Aravinda Prasad) 4f3e0da

   Commits related to "mem_map array logic"
    - [PATCH v2 01/10] Move page flags setup for old kernels after debuginfo initialization. 
      (by HATAYAMA Daisuke) ed3fe07
    - [PATCH v2 02/10] Add debuginfo interface for enum type size. (by HATAYAMA Daisuke) e308a72
    - [PATCH v2 03/10] Add new parameters to various tables. (by HATAYAMA Daisuke) 0ba57be
    - [PATCH v2 04/10] Add debuginfo-related processing for VMCOREINFO/VMLINUX.
      (by HATAYAMA Daisuke) b1f49d6
    - [PATCH v2 05/10] Add hardcoded page flag values. (by HATAYAMA Daisuke) d2f87bc
    - [PATCH v2 06/10] Exclude free pages by looking up mem_map array. (by HATAYAMA Daisuke) 8f74a27
    - [PATCH v2 07/10] Add page_is_buddy for recent kernels. (by HATAYAMA Daisuke) a0a9fa7
    - [PATCH v2 08/10] Add page_is_buddy for PG_buddy. (by HATAYAMA Daisuke) a2f411c
    - [PATCH v2 09/10] Add page_is_buddy for old kernels. (by HATAYAMA Daisuke) db3553a
    - [PATCH v2 10/10] Warn cyclic buffer overrun and correct it if possible.
      (by HATAYAMA Daisuke) a0b9d84

   Other commit
    - [PATCH] Support for x86_64 1G pages. (by Petr Tesarik) 7b10a11
    - [PATCH] Change dwarf analyzer to search also into named containers. (by Atsushi Kumagai) 1f31b6a
    - [PATCH] s390x: Add 2GB frame support for page table walker. (by Michael Holzheu) f6ab608
    - [PATCH v2 1/2] Add get_free_memory_size() to get the amount of free memory.
      (by Atsushi Kumagai) 8dd4a17
    - [PATCH v2 2/2] Calculate the size of cyclic buffer automatically. (by Atsushi Kumagai) 01db605

o Bugfix
    - [PATCH] add a missing return statement. (by Petr Tesarik) f6134c7


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
