Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JfB8M-00049l-Mf
	for kexec@lists.infradead.org; Fri, 28 Mar 2008 09:44:27 +0000
Received: from mailgate3.nec.co.jp (mailgate53E.nec.co.jp [10.7.69.161])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m2S9iMHb018551
	for <kexec@lists.infradead.org>; Fri, 28 Mar 2008 18:44:22 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id m2S9iMj19808 for kexec@lists.infradead.org;
	Fri, 28 Mar 2008 18:44:22 +0900 (JST)
Received: from kaishu.jp.nec.com (kaishu.jp.nec.com [10.26.220.5])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id m2S9iLDI029193
	for <kexec@lists.infradead.org>; Fri, 28 Mar 2008 18:44:21 +0900 (JST)
Message-Id: <47ECBDF5.4060200@mxs.nes.nec.co.jp>
Date: Fri, 28 Mar 2008 18:44:21 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.2.5: Follow the changes of page flags
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0543980550=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>

--===============0543980550==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

makedumpfile version 1.2.5 is released.
Please test it. Your opinions/comments are welcome.

Changelog:
 o New feature
   - follow the changes of page flags.
     To follow the changes of page flags in linux kernel, a new
     makedumpfile can get these values from the vmcoreinfo data.
 o Code Cleanup
   - delete unnecessary flag.
   - add create_dumpfile() for readability.
 o Bugfix
   - fix error return values of vtop().


Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  You can download the latest makedumpfile(ver. 1.2.5) from the following URL.
  Details of the change are written on the CVS page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.2.5.tar.gz"
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



--===============0543980550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0543980550==--
