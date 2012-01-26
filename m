Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RqEZv-0006Py-Vo
 for kexec@lists.infradead.org; Thu, 26 Jan 2012 01:56:44 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q0Q1uXno025438
 for <kexec@lists.infradead.org>; Thu, 26 Jan 2012 10:56:33 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q0Q1uWO12850 for kexec@lists.infradead.org;
 Thu, 26 Jan 2012 10:56:32 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q0Q1uVsu009881
 for <kexec@lists.infradead.org>; Thu, 26 Jan 2012 10:56:32 +0900 (JST)
Date: Thu, 26 Jan 2012 10:52:45 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.4.2: Fix compilation error for some architectures.
Message-Id: <20120126105245.114df17b.kumagai-atsushi@mxc.nes.nec.co.jp>
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

makedumpfile version 1.4.2 is released.
Your comments/patches are welcome.

This version is released earlier than usual because 1.4.1 has 
compilation error in some architectures.

Changelog:
o New feature
    - [PATCH] s390x: Auto-detect the correct MAX_PHYSMEM_BITS used in vmcore being analyzed.
      (for s390x 64TB memory by Mahesh Salgaonkar) 440ed48

o Bugfix
    - [PATCH] Fix compilation error in sadump_info.h. (by Michael Holzheu) 25ae552

o Code Cleanup
    - [PATCH] Add Makefile parameter to use dynamic libraries. (by Atsushi Kumagai) 67b2be2


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
