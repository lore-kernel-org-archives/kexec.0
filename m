Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JMxFO-0002Ed-Pm
	for kexec@lists.infradead.org; Thu, 07 Feb 2008 03:16:29 +0000
Message-Id: <47AA7832.9080909@mxs.nes.nec.co.jp>
Date: Thu, 07 Feb 2008 12:17:06 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.2.4: Add linux-2.6.24 support
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1010948319=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>
Cc: Nguyen Anh Quynh <aquynh@gmail.com>, Akio Takebe <takebe_akio@jp.fujitsu.com>

--===============1010948319==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

makedumpfile version 1.2.4 is released.
Please test it. Your opinions/comments are welcome.

Changelog:
o Add linux-2.6.24 support.
  An old makedumpfile didn't support linux-2.6.24, and it displays the
  following message on linux-2.6.24:
    The kernel version is not supported.
    The created dumpfile may be incomplete.

  A new makedumpfile was confirmed that it runs currently on linux-2.6.24,
  and it supports linux-2.6.24. So it doesn't display the above message.

o Add xen kernel support to the STDOUT feature (-F option).
  This patch was provided by Akio Takebe.
  http://lists.infradead.org/pipermail/kexec/2008-January/001250.html

o Fix the method looking for .debug_info section in get_debug_info().
  An old makedumpfile didn't quit the loop even if finding .debug_info
  section. The bug doesn't affect the program's functionality, but it
  should be fixed.
  This patch was provided by Nguyen Anh Quynh.

o Fix the problem that -d1 option cannot be specified without -x/-i option.
  -d1 option excludes pages filled with zero, and it should be able to run
  without -x/-i option.


Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  You can download the latest makedumpfile(ver. 1.2.4) from the following URL.
  Details of the change are written on the CVS page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.2.4.tar.gz"
  2. "cd makedumpfile"
  3. "make; make install"

Usage:
  makedumpfile [-c] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file

Example:
  If you want to exclude pages filled by zero, cache pages, user pages
  and free pages and to enable compression, please execute the following
  command.

  # makedumpfile -c -d 31 -x vmlinux /proc/vmcore dumpfile


Thanks
Ken'ichi Ohmichi



--===============1010948319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1010948319==--
