Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]
	helo=TX2EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1ObR9F-00037O-EO
	for kexec@lists.infradead.org; Wed, 21 Jul 2010 04:43:14 +0000
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH v3 0/7] Fixup booting with device trees and uImage/elf on ppc32
Date: Tue, 20 Jul 2010 23:42:57 -0500
Message-ID: <1279687384-9770-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: muvarov@gmail.com, Matthew McClintock <msm@freescale.com>, sebastian@breakpoint.cc

This patch series adds full support for booting with a flat device tree
with either uImage or elf file formats. Kexec and Kdump should work, and
you should also be able to use ramdisks or reuse your current ramdisk as well

This patch series was tested on an mpc85xx system with a kernel version
2.6.35-rc3

v1: Initial version

v2: Added support for fs2dt (file system to device tree)

v3: Fix some misc. git problems I had and other code cleanups

Matthew McClintock (7):
  Restore kexec uImage-ppc to working state
  Fix case where phys_addr_t != unsigned long when reading proc entries
  Update uImage to support crash kernel and misc fixes
  Update Elf-ppc to support crash kernel and misc fixes
  Add support for ramdisk on ppc32 for uImage-ppc and Elf-ppc
  Add support for reworking flat device tree support
  Add documentation/howto for mpc85xx systems

 doc/mpc85xx.txt                       |  190 +++++++++++++++++++++
 kexec/arch/ppc/Makefile               |    1 +
 kexec/arch/ppc/fixup_dtb.c            |  298 ++++++++++++++++++++++++++++++++-
 kexec/arch/ppc/fixup_dtb.h            |    6 +-
 kexec/arch/ppc/include/arch/options.h |    3 +
 kexec/arch/ppc/kexec-elf-ppc.c        |  186 +++++++++------------
 kexec/arch/ppc/kexec-ppc.c            |  262 +++++++++++++++++------------
 kexec/arch/ppc/kexec-ppc.h            |    3 +
 kexec/arch/ppc/kexec-uImage-ppc.c     |  136 ++++++++++++---
 kexec/arch/ppc/ops.h                  |    1 -
 purgatory/arch/ppc/purgatory-ppc.c    |    5 +
 11 files changed, 852 insertions(+), 239 deletions(-)
 create mode 100644 doc/mpc85xx.txt



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
