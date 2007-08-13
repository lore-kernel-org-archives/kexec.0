Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKURA-0006vK-9q
	for kexec@lists.infradead.org; Mon, 13 Aug 2007 03:34:06 -0400
Subject: [RFC][PATCH 0/3] Embed vmcoreinfo into kernel file
Message-Id: <20070813163212oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 13 Aug 2007 16:32:12 +0900
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>
Cc: Don Zickus <dzickus@redhat.com>, Bernhard Walle <bwalle@suse.de>, Vivek Goyal <vgoyal@in.ibm.com>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>


Hi all,

# I resend this mail, because former mail had a suspicious header.

I updated Dan Aloni's patches for adding the feature that embeds
vmcoreinfo (information for dump filtering) into a kernel file.
This feature frees the restriction that makedumpfile user should
install a vmlinux file (including the debugging information).
Please test it. Your opinions/comments are welcome.


makedumpfile command is the dump filtering feature for kdump.
It creates a small dumpfile by filtering unnecessary pages
for the analysis. To distinguish unnecessary pages, it needs
a vmlinux file including the debugging information.
Now, the debugging package becomes a huge file, and it is hard
to install it into each system. Then, Dan Aloni created the patch
set to embed only necessary information into a kernel binary file,
and a vmlinux file including the debugging informaion is not
necessary.

Dan Aloni's patch:
http://lists.infradead.org/pipermail/kexec/2007-July/000303.html

Patches:
- [1/3] patch for linux-2.6.22.
  Changelog:
  * Rename "mkdfinfo" to "vmcoreinfo".
  * Multi memory models (FLATMEM, DISCONTIGMEM, and SPASEMEM) are
    supported.
  * The elf note typedef for vmcoreinfo is added because the original
    elf note size is limited to 1024.
  * The generation of the elf note is moved to boot time instead of
    crash time.

- [2/3] patch for kexec-tools-testing-20070330.
  Changelog:
  * Rename "mkdfinfo" to "vmcoreinfo".

- [3/3] patch for makedumpfile-v1.1.6.

Usage:
- Run the kernel applied the attached patch as the first kernel.
- Preload the second kernel by the kexec-tools applied the attached patch.
- Panic and switch to the second kernel.
- Get a dumpfile by the makedumpfile applied the attached patch:
  (Ex.) # makedumpfile -cd31 /proc/vmcore dumpfile

Todo:
- ia64 support.
  Translating the virtual address of "vmcoreinfo_note" to the physical address.
  (kernel-vmcoreinfo-note.patch)
- ppc64 support


Thanks
Ken'ichi Ohmichi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
