Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Lvntl-0001ub-OC
	for kexec@lists.infradead.org; Mon, 20 Apr 2009 07:26:46 +0000
Message-ID: <49EC137E.9050803@mxs.nes.nec.co.jp>
Date: Mon, 20 Apr 2009 15:17:34 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.3.3: Add --split option.
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>
Cc: Petr Tesarik <ptesarik@suse.cz>, Takao Indoh <tindoh@redhat.com>, Dave Anderson <anderson@redhat.com>


Hi,

makedumpfile version 1.3.3 is released.
Your comments/patches are welcome.

Changelog:
o New feature
  - Add --split option. (by Takao Indoh)
    Split the dump data to multiple dumpfiles in parallel.
    If specifying dumpfiles on different storage devices, a device can share
    I/O load with other devices and it reduces time for saving the dump data.
    The file size of each dumpfile is smaller than the system memory size
    which is divided by the number of dumpfiles.
    This feature supports only the kdump-compressed format.
    Example:
     # makedumpfile --split -d 31 -x vmlinux /proc/vmcore dumpfile1 dumpfile2

  - Add --reassemble option.
    Reassemble multiple dumpfiles, which are created by --split option, into
    one dumpfile. dumpfile1 and dumpfile2 are reassembled into dumpfile on
    the following example.
    Example:
     # makedumpfile --reassemble dumpfile1 dumpfile2 dumpfile

  - Add multiple dump_levels to "-d" option.
    If specifying multiple dump_levels with the delimiter ',', makedumpfile
    retries to create a dumpfile by other dump_level when "No space on device"
    error happens. For example, if dump_level is "11,31" and makedumpfile fails
    by dump_level 11, makedumpfile retries it by dump_level 31.

  - Add linux-2.6.29 support.

o Bugfix
  - Use current page_size for KDUMP files. (by Petr Tesarik)
  - Truncate dumpfile if overwriting it.
  - Add free calls for error handling.
  - Add fclose() calls for vmcoreinfo file. 

o Code Cleanup
  - Delete unused functions.
  - Clean up the method of bitmap.
  - Clean up the method for reading vmcoreinfo from /proc/vmcore.

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
