Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ITZaz-0001ZG-V2
	for kexec@lists.infradead.org; Fri, 07 Sep 2007 04:53:49 -0400
Subject: makedumpfile-1.2.0: Extract vmcoreinfo from /proc/vmcore
Message-Id: <20070907175305oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 7 Sep 2007 17:53:05 +0900
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
Cc: Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, Vivek Goyal <vgoyal@in.ibm.com>, Itsuro ODA <oda@valinux.co.jp>, Andrew Morton <akpm@linux-foundation.org>


Hi,

makedumpfile version 1.2.0 is released.
Please test it. Your opinions/comments are welcome.

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.


Changelog:
o Extract vmcoreinfo from /proc/vmcore.
  makedumpfile command extracts the vmcoreinfo data from /proc/vmcore
  and uses it for dump filtering. It is a part of the following patchset:
  http://lists.infradead.org/pipermail/kexec/2007-August/000521.html

o linux-2.6.23-rc4-mm1 support.
  On linux-2.6.23-rc4-mm1, node_states[N_ONLINE] is added instead of
  node_online_map. makedumpfile can get the information from it.

o Add the "-d 1" option (skip zero-filled pages) for Xen.
  Other dump levels are invalid for Xen.
  The patch was provided by Itsuro Oda:
  http://lists.infradead.org/pipermail/kexec/2007-August/000490.html

o Add the feature which gets enum number.
  makedumpfile can get NR_FREE_PAGES dynamically.

o Some Cleanups
  - Cleanup README and comments by Randy Dunlap.
  - Cleanup Xen code.
  - Cleanup the indents.
  - Randomize the filename for the bitmap.
  - Unify PAGESHIFT and PAGE_SHIFT() to PAGE_SHIFT() because both
    macros have the same content.


You can download the latest makedumpfile(ver. 1.2.0) from the following URL.
Details of the change are written on the CVS page of the following site.
https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.2.0.tar.gz"
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
