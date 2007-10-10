Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IfVxW-00071H-6d
	for kexec@lists.infradead.org; Wed, 10 Oct 2007 08:26:25 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9A7ODGW027572
	for <kexec@lists.infradead.org>; Wed, 10 Oct 2007 16:24:13 +0900 (JST)
Received: from mailgate3.nec.co.jp (mailgate53.nec.co.jp [10.7.69.160])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9A7MCwI011079
	for <kexec@lists.infradead.org>; Wed, 10 Oct 2007 16:22:12 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id l9A7MCu18613 for kexec@lists.infradead.org;
	Wed, 10 Oct 2007 16:22:12 +0900 (JST)
Received: from yonosuke.jp.nec.com (yonosuke.jp.nec.com [10.26.220.15]) by
	mailsv3.nec.co.jp (8.11.7/3.7W-MAILSV4-NEC) with ESMTP
	id l9A7MCB20910 for <kexec@lists.infradead.org>;
	Wed, 10 Oct 2007 16:22:12 +0900 (JST)
Message-Id: <470C7DC0.7070801@mxs.nes.nec.co.jp>
Date: Wed, 10 Oct 2007 16:22:40 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.2.1: Add virtual memmap support for x86_64 sparsemem
	kernel.
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
Errors-To: kexec-bounces@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>


Hi,

makedumpfile version 1.2.1 is released.
Please test it. Your opinions/comments are welcome.

Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Changelog:
o Add virtual memmap support for x86_64 sparsemem kernel.
  On linux-2.6.24, virtual memmap will be implemented, and x86_64
  sparsemem kernel will have "struct page" in virtual memmap area.
  To support virtual memmap, the feature which translates virtual
  address into physical address by 4-levels-paging is added.

o Add the message_level (16) for printing the report message.
  Example:
   Printing progress indicator(1), common message(2), error message(4),
   and report message(16).

   # makedumpfile --message-level 23 -d 31 -x vmlinux /proc/vmcore dumpfile
   [100 %]
   Original pages  : 0x0000000000137f10
     Excluded pages   : 0x000000000012a9cd
       Pages filled with zero  : 0x0000000000120579
       Cache pages             : 0x00000000000067e2
       Cache pages + private   : 0x00000000000010a3
       User process data pages : 0x000000000000249a
       Free pages              : 0x0000000000000735
     Remaining pages  : 0x000000000000d543
     (The number of pages is reduced to 4%.)
   Memory Hole     : 0x00000000000380f0
   --------------------------------------------------
   Total pages     : 0x0000000000170000
   
   The dumpfile is saved to dumpfile.
   
   makedumpfile Completed.
   #

o Add linux-2.6.23 support because makedumpfile was tested on linux-2.6.23.

o Change the common/debug message output to STDOUT from STDERR if not
  specifying '-F' option, so that users can read the help message easily.
  ('-F' option outputs the dump data to STDOUT for piping it by ssh
  command etc.)

o Some cleanups
  - Rename read_vmcoreinfo_structure() to read_vmcoreinfo_long() because
    the function is used also for the usages other than structures.
  - Cleanup the code for translating virtual address to physical address.


You can download the latest makedumpfile(ver. 1.2.1) from the following URL.
Details of the change are written on the CVS page of the following site.
https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.2.1.tar.gz"
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
