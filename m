Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2C3W-0008RP-AV
	for kexec@lists.infradead.org; Thu, 07 May 2009 22:27:18 +0000
From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 00/14] RFC: x86: relocatable kernel changes
Date: Thu,  7 May 2009 15:26:48 -0700
Message-Id: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, sam@ravnborg.org, tglx@linutronix.de, vgoyal@redhat.com

This series is currently in -tip; the goal of it is to make the
semantics of the relocatable kernel fully the same as the
non-relocatable kernel when loaded by a relocating bootloader.  That
means CONFIG_PHYSICAL_START is honored to (a) be able to keep ZONE_DMA
free, and avoid the once-again-increasingly-common 15-16 MB hole
(don't ask me *why* this abortion is cropping up again, but I'm seeing
an increasing number of reports to the effect that it *is*) and (b) make
vmlinux match the runtime code in the normal case.

To deal with that constraint, CONFIG_PHYSICAL_START is taken as a
minimum address for the kernel.  Since a relocating bootloader may
have real reasons to load the kernel lower than that (for example,
because it has detected that it is on a small-memory system), this
adds two new fields to the bzImage header:

	runtime_start	- CONFIG_PHYSICAL_START
	runtime_size	- The contiguous memory space consumed by the kernel

The latter is the union of contiguous memory consumed by the kernel
during decompression and initialization; this is now possible thanks
to Jeremy's .brk patchset.  This isn't the same thing as the amount of
memory the kernel needs, but rather the amount of memory it will
assume that it can use before it starts to be able to read the memory
map.

The runtime_start field can be *written* by the bootloader if the
kernel is relocatable; e.g. by setting it to zero to indicate that the
load address should be used no matter what.

The physical address at which the kernel starts is now:

	align_up(max(load_address, runtime_start), kernel_alignment)

This seems to be the best possible compromise between the current
behaviors for relocatable and non-relocatable kernels.

This patchset also bumps up the default alignment to a PMD boundary (2
MB for x86-64 and PAE; 4 MB for !PAE).  I also change the default
CONFIG_PHYSICAL_START to 16 MB (4 MB for CONFIG_EMBEDDED).

The patchset also includes some plain optimizations.

 Documentation/x86/boot.txt             |   41 +++++++++
 arch/x86/Kconfig                       |   28 ++++--
 arch/x86/boot/Makefile                 |   24 ++++--
 arch/x86/boot/compressed/Makefile      |   51 +++--------
 arch/x86/boot/compressed/head_32.S     |  131 +++++++++++++---------------
 arch/x86/boot/compressed/head_64.S     |  129 ++++++++++++----------------
 arch/x86/boot/compressed/mkpiggy.c     |   97 +++++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S |    1 +
 arch/x86/boot/compressed/vmlinux.scr   |   10 --
 arch/x86/boot/header.S                 |   21 ++++-
 arch/x86/configs/i386_defconfig        |  148 ++++++++++++++++++++++++-------
 arch/x86/configs/x86_64_defconfig      |  148 ++++++++++++++++++++++++--------
 arch/x86/include/asm/boot.h            |   13 +++-
 arch/x86/include/asm/bootparam.h       |    2 +
 arch/x86/kernel/asm-offsets_32.c       |    1 +
 arch/x86/kernel/asm-offsets_64.c       |    1 +
 scripts/Makefile.lib                   |   11 ++-
 scripts/bin_size                       |    8 ++-
 18 files changed, 575 insertions(+), 290 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
