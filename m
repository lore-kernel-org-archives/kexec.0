Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U7cGt-0000yR-Qm
 for kexec@lists.infradead.org; Tue, 19 Feb 2013 01:45:29 +0000
Received: from mailgate4.nec.co.jp ([10.7.69.184])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id r1J1jOmw007044
 for <kexec@lists.infradead.org>; Tue, 19 Feb 2013 10:45:24 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id r1J1jOT27744 for kexec@lists.infradead.org;
 Tue, 19 Feb 2013 10:45:24 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id r1J1jNDh000467
 for <kexec@lists.infradead.org>; Tue, 19 Feb 2013 10:45:23 +0900 (JST)
Date: Tue, 19 Feb 2013 10:26:43 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.5.3: Fix dummy implementation for readpage_sadump.
Message-Id: <20130219102643.d9dff1851b86b5d427c7c097@mxc.nes.nec.co.jp>
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

makedumpfile version 1.5.3 is released.
Your comments/patches are welcome.

1.5.2 has compilation error in all architectures except x86/x86_64,
please update to 1.5.3.

Changelog:

o Bugfix
    - [PATCH] Fix dummy implementation for readpage_sadump. (by Atsushi Kumagai) 71a2f88

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
