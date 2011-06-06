Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QTRNE-0003Lp-CY
	for kexec@lists.infradead.org; Mon, 06 Jun 2011 04:25:09 +0000
Received: from mailgate4.nec.co.jp ([10.7.69.184])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p564P08D012150
	for <kexec@lists.infradead.org>; Mon, 6 Jun 2011 13:25:00 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id p564P0l10687 for kexec@lists.infradead.org;
	Mon, 6 Jun 2011 13:25:00 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
	by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id p564OxC0023824
	for <kexec@lists.infradead.org>; Mon, 6 Jun 2011 13:24:59 +0900 (JST)
Date: Mon, 6 Jun 2011 12:16:11 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: makedumpfile-1.3.8: Fix dump refiltering for s390x.
Message-Id: <20110606121611.c8113896.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

makedumpfile version 1.3.8 is released.
Your comments/patches are welcome.

Changelog:
o Bugfix
 - [PATCH] makedumpfile: s390x: Fix dump refiltering for s390x. (by Mahesh Salgaonkar) Commit ID=f30ba66
 - [PATCH] s390x: Fix KVBASE to correct value for s390x architecture (by Mahesh Salgaonkar) Commit ID=c69f915
 - [PATCH] Copy correct nr_cpus info to dumpfile during re-filtering. (by Mahesh Salgaonkar) Commit ID=c4f1c98
 - [PATCH] BUGFIX: Avoid SIGSEGV when specifying -V option. (by Ken'ichi Ohmichi) Commit ID=5b8c2da


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
