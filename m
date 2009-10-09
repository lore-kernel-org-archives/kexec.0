Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Mw61v-0005kx-Fy
	for kexec@lists.infradead.org; Fri, 09 Oct 2009 03:20:37 +0000
Message-ID: <4ACEA2A3.5090706@mxs.nes.nec.co.jp>
Date: Fri, 09 Oct 2009 11:40:35 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.3.4: Support kdump-compressed format for input file.
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>
Cc: Dave Anderson <anderson@redhat.com>, Takao Indoh <tindoh@redhat.com>, Minoru Usui <usui@mxm.nes.nec.co.jp>, CAI Qian <caiqian@redhat.com>


Hi,

makedumpfile version 1.3.4 is released.
Your comments/patches are welcome.

Changelog:
 o New feature
   - Support kdump-compressed format for input file. (by Takao Indoh)
      A new makedumpfile can read dumpfile which is kdump-compressed format
      instead of /proc/vmcore and re-filter it.
   - Add dump filtering on an x86_64 xen domain-0.
      A new makedumpfile can exclude unnecessary pages (cache pages, user
      process data pages, and free pages) on on x86_64 xen domain-0.
   - Save utsname data into disk_dump_header.
      A new makedumpfile saves utsname data into disk_dump_header.
      The crash utility can output the data from a dumpfile by 'help -n'.
   - Add linux-2.6.30 - 2.6.31 support.

 o Bugfix
   - Fix some lacks of free(). (by Minoru Usui)

 o Code Cleanup
   - Add some comments to code for the readability.
   - Remove VERSION_LINUX_2_6_XX.
   - Add paddr_to_pfn() and pfn_to_paddr() macros.
   - Merge the version information of makedumpfile.
   - Merge the PT_NOTE methods of both elf64 and elf32.
   - Reduce some indents in exclude_unnecessary_pages().
   - Remove unnecessary spaces.
   - read_disk_dump_header() and read_kdump_sub_header().
   - Use DISKDUMP_HDADER_BLOCKS for the readability.

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
Ken'ichi Ohmichi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
