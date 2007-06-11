Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HxYTK-000710-L5
	for kexec@lists.infradead.org; Sun, 10 Jun 2007 21:13:33 -0400
Subject: makedumpfile-1.1.4: ia64 DISCONTIGMEM support
Message-Id: <20070611101334oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 11 Jun 2007 10:13:34 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>
Cc: Jay Lan <jlan@sgi.com>, Bernhard Walle <bwalle@suse.de>


Hi,

makedumpfile version 1.1.4 is released.
Please test it. Your opinions/comments are welcome.

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Changelog:
o Add ia64 DISCONTIGMEM support.
  A new makedumpfile supports ia64 DISCONTIGMEM.
o Add ia64_vtop().
  The translation function from a virtual address to a
  physical address is added for ia64.
  The patch was provided by Bernhard Walle, thanks.
o Add __FUNCTION__ to ERRMSG.
  The function name is added to ERRMSG.
o Cleanup README.
  The destination of BUG REPORT is changed to kexec-ml.
  The item REQUIREMENTS is added.
o Fix DISCONTIGMEM bitmap.
  This patch fixes the problem that it cannot output the part
  of bitmap on DISCONTIGMEM kernel.
o Fix ELF output with overlapping sections.
  The patch was provided by Bernhard Walle, thanks.


You can download the latest makedumpfile(ver. 1.1.4) from the following URL.
Details of the change are written on the CVS page of the following site.
https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.1.4.tar.gz"
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
