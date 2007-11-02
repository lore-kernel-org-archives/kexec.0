Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1Intrn-00033g-Lh
	for kexec@lists.infradead.org; Fri, 02 Nov 2007 06:35:14 -0400
Received: from mailgate3.nec.co.jp (mailgate54.nec.co.jp [10.7.69.193])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lA2AZ47f001284
	for <kexec@lists.infradead.org>; Fri, 2 Nov 2007 19:35:04 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id lA2AZ3w07730 for kexec@lists.infradead.org;
	Fri, 2 Nov 2007 19:35:03 +0900 (JST)
Received: from togyo.jp.nec.com (togyo.jp.nec.com [10.26.220.4]) by
	mailsv.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
	id lA2AZ3C02356 for <kexec@lists.infradead.org>;
	Fri, 2 Nov 2007 19:35:03 +0900 (JST)
Message-Id: <472AFD76.5070304@mxs.nes.nec.co.jp>
Date: Fri, 02 Nov 2007 19:35:34 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.2.2: Fix the problem that vmcoreinfo cannot be
	extracted from ELF32 /proc/vmcore
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0543794330=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>

--===============0543794330==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

makedumpfile version 1.2.2 is released.
Please test it. Your opinions/comments are welcome.

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Changelog:
o Fix the problem that vmcoreinfo cannot be extracted from ELF32 /proc/vmcore.
  There was a problem that makedumpfile cannot extract vmcoreinfo from
  an ELF32 /proc/vmcore:
    # makedumpfile -cd31 /proc/vmcore dumpfile
    get_pt_note_info: Can't find PT_NOTE Phdr.
    
    makedumpfile Failed.
    #
  The cause was that makedumpfile checked the address of flag_elf64 instead of
  the value.


Download:
  You can download the latest makedumpfile(ver. 1.2.2) from the following URL.
  Details of the change are written on the CVS page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.2.2.tar.gz"
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




--===============0543794330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0543794330==--
