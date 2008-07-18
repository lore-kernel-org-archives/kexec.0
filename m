Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJfNe-0002Dv-0j
	for kexec@lists.infradead.org; Fri, 18 Jul 2008 02:07:34 +0000
Message-Id: <487FFAD5.4040302@mxs.nes.nec.co.jp>
Date: Fri, 18 Jul 2008 11:07:17 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.2.7: Add linux-2.6.26 and xen-3.1.2 support
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1094150733=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>, Akio Takebe <takebe_akio@jp.fujitsu.com>, Itsuro ODA <oda@valinux.co.jp>, Neil Horman <nhorman@redhat.com>
Cc: kexec-ml <kexec@lists.infradead.org>

--===============1094150733==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

makedumpfile version 1.2.7 is released.
Thank you for many patches.
Please test it. Your opinions/comments are welcome.

Changelog:
 o New feature
   - Add xen-3.1.2 support (Akio Takebe)
   - handle x86_64 xen code/data relocation (Itsuro ODA)
   - Add linux-2.6.26 support.
   - Add the progress bar for creating dump bitmap (Bernhard Walle)
   - Shrink the time for creating dump bitmap.

 o Bugfix
   - Fix vmcoreinfo generation on 32bit hosts for 64bit kernels (Bernhard Walle)
   - Fix compile warning (Bernhard Walle)
   - Fix illegal buffer access (Itsuro ODA)
   - Improve error handing when SIZE(nodemask_t) is undefined (Bernhard Walle)

 o Code Cleanup
   - Remove trailing whitespace (Bernhard Walle)
   - Remove unnecessary description in manpage.
   - Cleanup machine dependent method.
   - Cleanup open_dump_file() method.

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  You can download the latest makedumpfile(ver. 1.2.7) from the following URL.
  Details of the change are written on the CVS page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.2.7.tar.gz"
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


--===============1094150733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1094150733==--
