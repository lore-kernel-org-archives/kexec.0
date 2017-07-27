Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1daaX9-0008L5-Hv
 for kexec@lists.infradead.org; Thu, 27 Jul 2017 04:36:26 +0000
Received: from mailgate01.nec.co.jp ([114.179.233.122])
 by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id v6R4Zws4029433
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Thu, 27 Jul 2017 13:35:58 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id v6R4ZwiV032156
 for <kexec@lists.infradead.org>; Thu, 27 Jul 2017 13:35:58 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id v6R4ZgAJ020569
 for <kexec@lists.infradead.org>; Thu, 27 Jul 2017 13:35:58 +0900
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: makedumpfile-1.6.2: Add support for sparc64
Date: Thu, 27 Jul 2017 04:32:46 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EF4423@BPXM01GP.gisp.nec.co.jp>
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

makedumpfile version 1.6.2 is released.
Your comments/patches are welcome.

Main new feature:
o Support for sparc64
 - sparc64 is supported from this version, it's tested on kernel-4.1.12.

o Add new option for --dump-dmesg
 - Introduce the new option "--partial-dmesg", it can exclude the buffers
   cleared by "dmesg --clear" while the current --dump-dmesg always extracts
   the whole ring buffer.   

o Support new kernels
 - The supported kernel is updated to 4.11 in this version.

Changelog:
o New feature
    - [PATCH] Add initial sparc64 support (by Tom Hromatka) 001d9b7
    - [PATCH v5 1/2] Add runtime kaslr offset if it exists (by Pratyush Anand) 2bfb7f1
    - [PATCH v5 2/2] x86_64: Calculate page_offset in case of re-filtering/sadump/virsh dump (by Pratyush Anand) 4944f93
    - [PATCH v2] Add the --partial-dmesg option to dump only non-cleared dmesg (by Ivan Delalande) ec5da81
    - [PATCH v3 1/2] Fold the calc of time delta into a func (by Pingfan Liu) 1192446
    - [PATCH v3 2/2] print_info: Show the remaining time of dump progress (by Pingfan Liu) 3438e8d

o Bugfix
    - [PATCH] elf_info.c: fix memory leak in get_kcore_dump_loads() (by Pingfan Liu) f10d1e2
    - [PATCH] Error on re-filtering the dump file with no free pages (by Mikhail Zaslonko) deb8e1f
    - [PATCH] Fix get_kcore_dump_loads() error case (by Pratyush Anand) a569d63
    - [PATCH] sadump: set info->page_size before cache_init() (by Hatayama, Daisuke) b98e6e0
    - [PATCH] Fix the use of Xen physical and machine addresses (by Petr Tesarik) e765785
    - [PATCH V3] elf_info: Fix file_size if segment is excluded (by Pratyush Anand) 88731c7
    - [PATCH v3] Prevent data loss in last page of ELF core dumpfile (by Eric DeVolder) 622f0d7
    - [PATCH] Consider not page-size aligned phys_end for paddr_to_pfn() (by Atsushi Kumagai) 25259e6
    - [PATCH] Fix the regression caused by moving cache_init() earlier (by Atsushi Kumagai) be0461f

o Cleanup
    - [PATCH 1/4] eppic: Rename scripts to reflect validity of kernel version (by Kamalesh Babulal) b55b29f
    - [PATCH 2/4] eppic/vhost_net_buffers: Introduce changes for kernel 3.19 (by Kamalesh Babulal) 0a1d8ee
    - [PATCH 3/4] eppic/dir_names: Introduce changes for kernel 3.14 (by Kamalesh Babulal) 5c822a7
    - [PATCH 4/4] eppic/keyring: Introduce changes for kernel 4.4 (by Kamalesh Babulal) 19fe701
    - [PATCH v3 1/7] show_mem_usage(): calculate page offset after elf load (by Pratyush Anand) 4b0bed3
    - [PATCH v3 2/7] initial(): call cache_init() a bit early (by Pratyush Anand) 8e2834b
    - [PATCH v3 3/7] x86_64: check physical address in PT_LOAD for none direct mapped regions (by Pratyush Anand) f136302
    - [PATCH v3 4/7] elf_info: kcore: check for invalid physical address (by Pratyush Anand) f4ab689
    - [PATCH v3 5/7] makedumpfile: Correct the calculation of kvaddr in set_kcore_vmcoreinfo (by Baoquan He) 4c53423
    - [PATCH v3 6/7] makedumpfile: Discard process_dump_load (by Baoquan He) f3ff8c6
    - [PATCH v3 7/7] mem-usage: allow to work only with -f for kernel version < 4.11 (by Pratyush Anand) 78cbb40
    - [PATCH] Fix typo in the ERRMSG of function show_mem_usage (by Eric Desrochers) ade8512
    - [PATCH] Fix other typos in messages (by Atsushi Kumagai) b171374
    - [PATCH] Fix compiler warnings (by Eric DeVolder) 04dab93

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
