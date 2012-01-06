Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Riz8z-0001qk-61
 for kexec@lists.infradead.org; Fri, 06 Jan 2012 02:02:59 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q0622gt5024842
 for <kexec@lists.infradead.org>; Fri, 6 Jan 2012 11:02:42 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q0622gS19000 for kexec@lists.infradead.org;
 Fri, 6 Jan 2012 11:02:42 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q0622fqk027806
 for <kexec@lists.infradead.org>; Fri, 6 Jan 2012 11:02:42 +0900 (JST)
Date: Fri, 6 Jan 2012 10:45:01 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.4.1: Support for Fujitsu stand-alone dump format.
Message-Id: <20120106104501.010db891.kumagai-atsushi@mxc.nes.nec.co.jp>
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

Hi,

makedumpfile version 1.4.1 is released.
Your comments/patches are welcome.

Daisuke Hatayama made a lot of effort to implement "Fujitsu stand-alone
dump format support" feature. Thanks, Hatayama-san.

o The explanation about a new feature "Fujitsu stand-alone dump format support":
  Fujitsu stand-alone dump (sadump) format is the original format used by Fujitsu.
  The sadump format is similar to diskdump format.

  This feature convert sadump-related format into kdump-compressed format.
  When converting sadump-related format, -x option is definitely necessary.
  Because, VMCORE created by sadump has NO debug information including VMCOREINFO.

  This feature tested on only x86 and x86_64.

  Ex. Convert multiple VMCOREs in a single commandline input.

    # makedumpfile [OPTION] -x VMLINUX --diskset=VMCORE1 --diskset=VMCORE2 DUMPFILE


Changelog:
o New feature
  Commits related to "Fujitsu stand-alone dump format support"
    - [PATCH v2 01/14] Add sadump module header file (by HATAYAMA Daisuke) c00d65c
    - [PATCH v2 02/14] Extend DumpInfo structure (by HATAYAMA Daisuke) 9a068b5
    - [PATCH v2 03/14] Implement command-line processing (by HATAYAMA Daisuke) 3964c98
    - [PATCH v2 04/14] Verify and read VMCORE(s) in sadump-related formats (by HATAYAMA Daisuke) ff19f9f
    - [PATCH v2 05/14] Export helpers for bitmap table handling (by HATAYAMA Daisuke) eda6066
    - [PATCH v2 06/14] Initialize internal data according to sadump-related formats (by HATAYAMA Daisuke) 0819b77
    - [PATCH v2 07/14] Initialize debug information for ELF note extraction (by HATAYAMA Daisuke) 7890646
    - [PATCH v2 08/14] Implement readmem() interface on sadump-related formats (by HATAYAMA Daisuke) 9c0e854
    - [PATCH v2 09/14] Estimate phys_base based on linux_banner position (by HATAYAMA Daisuke) 5054dd8
    - [PATCH v2 10/14] Generate and save VMCOREINFO and ELF note information (by HATAYAMA Daisuke) ef2832f
    - [PATCH v2 11/14] Process CPUs based on online ones (by HATAYAMA Daisuke) 13dd70a
    - [PATCH v2 12/14] Read kexec backup region (by HATAYAMA Daisuke) fc655b4
    - [PATCH v2 13/14] Add description of sadump-related formats in usage information (by HATAYAMA Daisuke) d6259de
    - [PATCH v2 14/14] Add description of sadump-related formats in manual page (by HATAYAMA Daisuke) c28ac15

o Bugfix
    - [PATCH] Fix off-by-one bug in page_to_pfn() (by Wen Congyang) 8ef4f34
    - [PATCH] s390x: Obtain the vmalloc_start value from high_memory for s390x arch. (by Mahesh Salgaonkar) ff1e067
    - [PATCH] Fix spelling mistakes in error messages. (by Atsushi Kumagai) a7282dd
    - [PATCH] Fix man page section number of makedumpfile.conf. (by Atsushi Kumagai) 98af7d5

o Code Cleanup
    - [PATCH] Cleanup: Fix description of DUMP levels. (by Atsushi Kumagai) 101c563
      (Based on "[PATCH]: fix makedumpfile cache page exclusion dump levels." by Thayumanavar S)
    - [PATCH] Cleanup: Add description of analysis tools in man page. (by Atsushi Kumagai) 2df7a4a
    - [PATCH] Cleanup: Convert multiple spaces to tabs. (by Atsushi Kumagai) 3bcc1d5
    - [PATCH] Cleanup: Delete unnecessary include "elf_info.h". (by Atsushi Kumagai) a296d8e
    - [PATCH] Cleanup: Fix some comments for "#endif". (by Atsushi Kumagai) c06b20e


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
