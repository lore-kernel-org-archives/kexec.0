Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1N82vF-0001NQ-NN
	for kexec@lists.infradead.org; Wed, 11 Nov 2009 02:27:06 +0000
Message-ID: <4AFA1EE7.7050704@mxs.nes.nec.co.jp>
Date: Wed, 11 Nov 2009 11:18:15 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: makedumpfile-1.3.5: Store vmcoreinfo data into a dumpfile in the
	kdump-compressed format.
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
Cc: Takao Indoh <tindoh@redhat.com>, CAI Qian <caiqian@redhat.com>


Hi,

makedumpfile version 1.3.5 is released.
Your comments/patches are welcome.

Changelog:
o New feature
  - Store vmcoreinfo data into a dumpfile in the kdump-compressed format.
  - Read vmcoreinfo data from a kdump-compressed dumpfile.

    For usability, this patchset makes '-x'/'-i' option unnecessary
    for re-filtering.

    makedumpfile v1.3.4 can read a dumpfile in the kdump-compressed
    format instead of /proc/vmcore and re-filter it.
    When re-filtering, makedumpfile v1.3.4 needs '-x'/'-i' option.
    If not specifying, it failed like the following:

      # makedumpfile -c -d 3 /proc/vmcore vmcore.1
      ...
      The dumpfile is saved to vmcore.1
      ...
      #
      # /makedumpfile -c -d 31 vmcore.1 vmcore.2
      vmcore.1 doesn't contain vmcoreinfo.
      Specify '-x' option or '-i' option.
      Commandline parameter is invalid.
      Try `makedumpfile --help' for more information.
      #

    A new makedumpfile (v1.3.5) takes vmcoreinfo data from /proc/vmcore
    and stores the data into a dumpfile in the kdump-compressed fomat.
    When re-filtering, makedumpfile takes the data from the dumpfile and
    uses it. So '-x'/'-i' option is not necessary.

o Code Cleanup
  - Set the calculated value to dh->sub_hdr_size.
  - Fix some indents in write_kdump_header().
  - Unify the name of kdump_sub_header.
  - Fix the typo of DISKDUMP_HEADER_BLOCKS.
  - Add the description about re-filtering into manpage.
  - Fix the description in manpage and README.

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
Ken'ichi Ohmichi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
