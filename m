Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bAr2y-0006gJ-Ge
 for kexec@lists.infradead.org; Thu, 09 Jun 2016 03:54:21 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id u593rugp011785
 for <kexec@lists.infradead.org>; Thu, 9 Jun 2016 12:53:56 +0900 (JST)
Received: from mailsv.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id u593ruR22199 for <kexec@lists.infradead.org>;
 Thu, 9 Jun 2016 12:53:56 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id u593ruZ4023924
 for <kexec@lists.infradead.org>; Thu, 9 Jun 2016 12:53:56 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: makedumpfile-1.6.0: Exclude page structures of non-dumped pages
Date: Thu, 9 Jun 2016 03:51:44 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E4A7D3@BPXM01GP.gisp.nec.co.jp>
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

makedumpfile version 1.6.0 is released.
Your comments/patches are welcome.

Main new feature:
o Exclude page structures of non-dumped pages
 - Add the new option "-e" to exclude the page structures which correspond
   to excluded pages. This option will bring a great performance, but it 
   will harm analyticity a little bit. Please see the note below:

   NOTE: If you specify this option, crash will show the message below
         and the 'kmem' command will not work.

       This dumpfile is incomplete because the page structures associated
       with excluded pages may also be excluded.  This may cause the crash
       session to fail entirely, may cause commands to fail (most notably
       the "kmem" command), or may result in unpredictable runtime behavior.

   Now this option supports only x86_64.

o Support new kernels
 - The supported kernel is updated to 4.5 in this version.

Changelog:
o New feature
    - [PATCH V7] Exclude page structures of non-dumped pages. (by Cliff Wickman) 46176a9
    - [PATCH 1/4] ARM64: Refactor code to support multiple page level. (by Pratyush Anand) 28a4729
    - [PATCH 2/4] ARM64: Decide VA Bits on the basis of _stext symbol value. (by Pratyush Anand) a93301d
    - [PATCH 3/4] ARM64: Fix KVBASE. (by Pratyush Anand) ec85257
    - [PATCH 4/4] ARM64: Fix for ARM64 3 level translation tables. (by Sameer Goel) c92a63d

o Bugfix
    - [PATCH] Fix bitmap buffer release code. (by Atsushi Kumagai) 7556e69
    - [PATCH 1/3] Keep segment memory size when re-filtering ELF dumps (by Petr Tesarik) 606fe8c
    - [PATCH 2/3] Mark unstored ELF pages as filtered (by Petr Tesarik) 1cdabcd
    - [PATCH 3/3] Rewrite readpage_elf (by Petr Tesarik) 7a7cebc
    - [PATCH] Looking for page.compound_order/compound_dtor to exclude hugepages
      (by Atsushi Kumagai) 5bc1f52
    - [PATCH] Skip examining compound tail pages (by Atsushi Kumagai) 13b4233
    - [PATCH] arm64: fix two level pmd calculation (by Pratyush Anand) 6759c72
    - [PATCH] Fix module core base and size offset for kernel v4.5 (by Pratyush Anand) fa6a75a
    - [PATCH] Fix deleted macro by mistake for ia64 (by Atsushi Kumagai) cfe652e
    - [PATCH] Fix boundary value bug for checking memory holes (by Atsushi Kumagai) 11a6dae
    - [PATCH] Skip null entries to walk page tables correctly (by Atsushi Kumagai) ecf7a13
    - [PATCH] Fix read data corruption for multi thread feature. (by Atsushi Kumagai) ae848e8

o Cleanup
    - [PATCH] Remove useless definitions of return value. (by Atsushi Kumagai) 3d32567
    - [PATCH] Clean up the in-accurate message printing about mmap (by Baoquan He) 2b8c001
    - [PATCH v8] Improve the performance of --num-threads -d 31 (by Zhou Wenjian) dfa2447
    - [PATCH] Fix compilation warning (by Pratyush Anand) 7dda810
    - [PATCH] Fix compilation warnings for x86_64 (by Atsushi Kumagai) 27b5fb5
    - [PATCH] Fix man page to add -p option (by Atsushi Kumagai) e444aad
    - [PATCH] Fix compilation warning (by Andrey Skvortsov) 484c6b1

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
