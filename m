Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kcb3v-0007A3-P9
	for kexec@lists.infradead.org; Mon, 08 Sep 2008 07:21:28 +0000
Message-ID: <48C4CC14.1030404@mxs.nes.nec.co.jp>
Date: Mon, 08 Sep 2008 15:54:12 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.2.9: Support ia64 discontigmem kernels of linux-2.6.20+
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1117518322=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>
Cc: Jay Lan <jlan@sgi.com>, Bernhard Walle <bwalle@suse.de>

--===============1117518322==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

makedumpfile version 1.2.9 is released.
Your comments/patches are welcome.

Changelog:
 o New feature
   - Support ia64 discontigmem kernels of linux-2.6.20+.
   - Support x86_64 linux-2.6.27 kernel.
   - Add makedumpfile's spec file.
   - Add "--vtop" option for debugging.
   - Add the debugging message for ia64 pgtable.
   - Get information from vmcoreinfo of /proc/vmcore even if -x/-i option.

 o Bugfix
   - Add free() for error handling.
   - Fix NOT_FOUND value of SIZE(nodemask_t).

 o Code Cleanup
   - Use the terminal sizes of 80 for the IMPLEMENTATION file. (Bernhard Walle)
   - Use static allocation instead of malloc().
   - Add get_num_dumpable() function.
   - Remove the unused pointer.
   - Remove the unused code.
   - Make the ELF methods simple.
   - Merge the same code in write_elf_pages().
   - Add "void" to some arguments.
   - Separate the dependency code to machine and linux version.
   - Cleanup vaddr_to_paddr() function.


Explanation of makedumpfile:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.

Download:
  You can download the latest makedumpfile from the following URL.
  Details of the change are written on the CVS page of the following site.
  https://sourceforge.net/projects/makedumpfile/

Method of installation:
  You can compile the makedumpfile command as follows;
  1. "tar -zxvf makedumpfile-1.2.9.tar.gz"
  2. "cd makedumpfile-1.2.9"
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



--===============1117518322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1117518322==--
