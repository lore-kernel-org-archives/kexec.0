Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K4QiD-0006rL-Eq
	for kexec@lists.infradead.org; Fri, 06 Jun 2008 01:25:50 +0000
Received: from mailgate3.nec.co.jp (mailgate53A.nec.co.jp [10.7.69.192])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m561Pkrr022643
	for <kexec@lists.infradead.org>; Fri, 6 Jun 2008 10:25:46 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id m561PkJ27681 for kexec@lists.infradead.org;
	Fri, 6 Jun 2008 10:25:46 +0900 (JST)
Received: from shoin.jp.nec.com (shoin.jp.nec.com [10.26.220.3])
	by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id m561Pjia019951
	for <kexec@lists.infradead.org>; Fri, 6 Jun 2008 10:25:45 +0900 (JST)
Message-Id: <48489218.3050904@mxs.nes.nec.co.jp>
Date: Fri, 06 Jun 2008 10:25:44 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.2.6: Extract vmcoreinfo from /proc/vmcore for Xen
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1581060871=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>

--===============1581060871==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

makedumpfile version 1.2.6 is released.
Please test it. Your opinions/comments are welcome.

Changelog:
 o New feature
   - Extract vmcoreinfo from /proc/vmcore for Xen (by Itsuro ODA)
   - Add linux-2.6.25 support
   - Add '--help' option
 o Bugfix
   - Fix the error code of Xen extracting feature (by Akio Takebe)
   - Fix the ia64 problem that invalid data is copied around overlapping
     segments.
 o Code Cleanup
   - make create_dump_bitmap() simple

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  You can download the latest makedumpfile(ver. 1.2.6) from the following URL.
  Details of the change are written on the CVS page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.2.6.tar.gz"
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


--===============1581060871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1581060871==--
