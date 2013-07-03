Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UuC3x-0007E2-ET
 for kexec@lists.infradead.org; Wed, 03 Jul 2013 01:40:55 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id r631eRIG009889
 for <kexec@lists.infradead.org>; Wed, 3 Jul 2013 10:40:27 +0900 (JST)
Received: from mailsv.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id r631eRl08861 for <kexec@lists.infradead.org>;
 Wed, 3 Jul 2013 10:40:27 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id r631eRqe015997
 for <kexec@lists.infradead.org>; Wed, 3 Jul 2013 10:40:27 +0900 (JST)
Date: Wed, 3 Jul 2013 10:18:53 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.5.4: Improve read performance by using mmap.
Message-Id: <20130703101853.7eab11c6322d4cc3f1a6e821@mxc.nes.nec.co.jp>
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
To: kexec@lists.infradead.org

Hello,

makedumpfile version 1.5.4 is released.
Your comments/patches are welcome.

Main new feature:
o Support for mmap
  With the patchset below, mmap(2) will be supported on /proc/vmcore.

    [PATCH v8 0/9] kdump, vmcore: support mmap() on /proc/vmcore
    https://lkml.org/lkml/2013/5/23/8

  If the kernel support mmap(2), makedumpfile (and other tools) should
  use it to get more read performance.
  Accordingly, v1.5.4 try to read /proc/vmcore with mmap(2) first.
  If the 2nd kernel doesn't support mmap(2), makedumpfile uses read(2)
  as usual. This deciding is done internally and automatically, so
  you don't need to be aware of this feature.
  
  NOTE:
   - You can see two benchmarks of using mmap:
      https://lkml.org/lkml/2013/3/27/19
      https://lkml.org/lkml/2013/3/26/914

   - v1.5.4 supports mmap officially, so I'll remove the mmap branch soon.
 
o Enhancement for data scrubbing with EPPIC
  Since "Data scrubbing with EPPIC" was introduced, this feature
  can scrub only the symbols included in vmlinux.
  However, v1.5.4 works also for module symbols.

Changelog:
o New feature
    - [PATCH] Improve reading speed with mmap(). (by Atsushi Kumagai) 95fe0a6
    - [PATCH 1/4] Introduce new symbols to look at the first vmap_area. (by Atsushi Kumagai) 759b78c
    - [PATCH 2/4] Use vmap_area_list to get vmalloc_start for i386. (by Atsushi Kumagai) cee64e3
    - [PATCH 3/4] Use vmap_area_list to get vmalloc_start for ppc32. (by Atsushi Kumagai) 8145e41
    - [PATCH 4/4] Use vmap_area_list to get vmalloc_start for ppc64. (by Atsushi Kumagai) e203095
    - [PATCH] Add support to module symbols. (by Aravinda Prasad) 31afac9

o Bugfix
    - [PATCH 1/2] Add the function to get real physical address. (by Atsushi Kumagai) 9ab6a29
    - [PATCH 2/2] Fix the handling of the pages correspond to border of PT_LOAD.
      (by Atsushi Kumagai) f854b37
    - [PATCH 1/3] elf, sadump: move KEXEC macros from sadump_info.c to elf_info.h.
      (by HATAYAMA Daisuke) 279e5c0
    - [PATCH 2/3] elf: swap checking order of VMCOREINFO and VMCOREINFO_XEN.
      (by HATAYAMA Daisuke) a5badad
    - [PATCH 3/3] elf: distinguish ELF note types by ELF note name space. (by HATAYAMA Daisuke) ddec112
    - [PATCH 1/2] Move scrubbing process from reader to writer. (by Atsushi Kumagai) d98a613
    - [PATCH 2/2] Fix the issue which can happen around overlapping segments. 
      (by Atsushi Kumagai) 0906837
    - [PATCH] Add a help message into man page of makedumpfile for -b option. (by Jingbai Ma) dd59013
    - [PATCH] Close the dwfl handle before next invocation of init_dwarf_info().
      (by Mahesh J Salgaonkar) 406a145
    - [PATCH] Copy over the 'erase_ch' member while splitting filter info.
      (by Mahesh J Salgaonkar) 8e87678
    - [PATCH] s390x: Allow large page and change override bits. (by Michael Holzheu) 5af332e

o Cleanup
    - [PATCH] Fix the insertion position of the comment of readpage_elf(). (by Atsushi Kumagai) 3a1e4bc
    - [PATCH] Cleanup: Extract the logic which look flag_usemmap. (by Atsushi Kumagai) 2178c03
    - [PATCH] Message on non-mmap kernels. (by Cliff Wickman) 595bdd7
    - [PATCH] Add error handling for read_with_mmap(). (by Atsushi Kumagai) dbb3925
    - [PATCH] Cleanup: Move the usage message of -b option to a more suitable position.
      (by Atsushi Kumagai) 0097767
    - [PATCH] Clean up readmem() by removing its recursive call. (by HATAYAMA Daisuke) ba1fd63
    - [PATCH] Cleanup: Convert multiple spaces to tabs in erase_info.h. (by Atsushi Kumagai) 61ddde3
    - [PATCH] Skip multiple pages filtered as free pages. (by HATAYAMA Daisuke) 080bfab
    - [PATCH] Check dump file early. (by Michael Holzheu) 6f3075c
    - [PATCH] Fix max offset relative to file. (by HATAYAMA Daisuke) 5c94eed
    - [PATCH] Fix missing count of filtered free pages. (by HATAYAMA Daisuke) dd1f5f1
    - [PATCH] Buddy identification when noncyclic. (by Cliff Wickman) f475311
    - [PATCH] Warn on vmlinux without dwarf. (by Cliff Wickman) 8198e7d
    - Revert "[PATCH] Fix cyclic mode to scrub data with -E option." (by Atsushi Kumagai) e81517f


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
