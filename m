Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5opp-000407-60
 for kexec@lists.infradead.org; Thu, 14 Feb 2013 02:46:07 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id r1E2jwen024777
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 11:45:58 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id r1E2jwb16513 for kexec@lists.infradead.org;
 Thu, 14 Feb 2013 11:45:58 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id r1E2jvox002656
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 11:45:57 +0900 (JST)
Date: Thu, 14 Feb 2013 11:07:16 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.5.2: Secret data scrubbing with eppic language.
Message-Id: <20130214110716.7b2b9f9b0eba662caefc9410@mxc.nes.nec.co.jp>
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

makedumpfile version 1.5.2 is released.
Your comments/patches are welcome.

Main new feature:
o Support for eppic language
  This feature enables us to specify rules to scrub data in a
  dumpfile with eppic macro instead of the current configuration
  file (makedumpfile.conf). Currently, this feature works only
  for symbols in vmlinux while the current feature can work also
  for module symbols.
  
  To use this feature, you should build the extension module as
  below and move it to your library directory:
  
  # make eppic_makedumpfile.so

  To build this module, you should prepare eppic library from 
  the following URL:
  http://code.google.com/p/eppic/

o Exclude hwpoison page
  This is the default action in new makedumpfile.
  This feature excludes hwpoison pages in any dump_level, we can
  avoid touching poisoned pages and running into MCE during dump
  process.

Changelog:
o New feature
   Commits related to "Support for eppic language"
    - [PATCH v4 1/9] Initialize and setup eppic. (by Aravinda Prasad) 86f38e9
    - [PATCH v4 2/9] makedumpfile and eppic interface layer. (by Aravinda Prasad) 3e0747f
    - [PATCH v4 3/9] Eppic call back functions to query a dump image. (by Aravinda Prasad) 83b85ca
    - [PATCH v4 4/9] Implement apigetctype call back function. (by Aravinda Prasad) 9c5f56c
    - [PATCH v4 5/9] Implement apimember and apigetrtype call back functions. 
      (by Aravinda Prasad) b0bb9fb
    - [PATCH v4 6/9] Extend eppic built-in functions to include memset function. 
      (by Aravinda Prasad) 9c19ab0
    - [PATCH v4 7/9] Support fully typed symbol access mode. (by Aravinda Prasad) 63676e8
    - [PATCH v4 8/9] Hack for the limitation when compiled with -static. (by Aravinda Prasad) 46373c5
    - [PATCH v4 9/9] Update Documentation. (by Aravinda Prasad) a910399
   Other commit
    - [PATCH v2] Add a default action to exclude hwpoison page from vmcore.
      (by Mitsuhiro Tanino) 030800d
    - [PATCH] keep dumpfile pages in a cache. (by Petr Tesarik) 0aff0e5
o Bugfix
    - [PATCH] Fix PAGEOFFSET and PAGEBASE macros for i386 PAE. (by Atsushi Kumagai) 5d83960
    - [PATCH] --dump-dmesg fix for post 3.5 kernels. (by Louis Bouchard) 36c2458
    - [PATCH] ppc64: Auto-detect the correct MAX_PHYSMEM_BITS used in vmcore being analyzed. 
              (by Mahesh Salgaonkar) bfff315
    - [PATCH] Fix cyclic mode to scrub data with -E option. (by Atsushi Kumagai) f06bdd9
    - [PATCH] sadump: fix bug in checking a given physical address is present on memory. 
              (by HATAYAMA Daisuke) 1128de7
    - [PATCH] s390x: Allow HW Change-bit override for page table entries. (by Michael Holzheu) 6073b28
o Cleanup
    - [PATCH] sadump: fix warning about unused variable. (by HATAYAMA Daisuke) b93de26
    - [PATCH] sadump: fix warning messages in building time. (by HATAYAMA Daisuke) a1238cd
    - [PATCH] Cleanup: Delete incorrect comments of file handling. (by Atsushi Kumagai) 3104500


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
