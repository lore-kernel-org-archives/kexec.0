Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
Date: Wed,  5 May 2010 09:54:12 +0300
Message-Id: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: kexec@lists.infradead.org, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>

Hello,

This is re-send of the series. I didn't receive any comments on this but we
found few minor things during in-house review which are incorporated.

Changes to v1:
	- corrected kernel-doc for crash_setup_regs()
	- check return value of ioremap() in copy_oldmem_page()

Changes to RFC version:
	- crash_setup_regs() uses Russell's suggestion for saving registers
	- copy_oldmem_page() code is changed to use ioremap()
	- there is no need for special 'mem=' parameters

I've tested this on N900 and beagleboard.

Thanks,
Mw

Mika Westerberg (8):
  arm: kdump: reserve memory for crashkernel
  arm: kdump: implement crash_setup_regs()
  arm: kdump: implement machine_crash_shutdown()
  arm: kdump: skip indirection page when crashing
  arm: kdump: implement copy_oldmem_page()
  arm: allow passing an ELF64 header to elf_check_arch()
  arm: kdump: add support for elfcorehdr= parameter
  arm: kdump: add CONFIG_CRASH_DUMP Kconfig option

 arch/arm/Kconfig                  |   12 ++++++
 arch/arm/include/asm/elf.h        |    4 +-
 arch/arm/include/asm/kexec.h      |   22 +++++++++-
 arch/arm/kernel/Makefile          |    1 +
 arch/arm/kernel/crash_dump.c      |   60 +++++++++++++++++++++++++++++
 arch/arm/kernel/elf.c             |    6 ++-
 arch/arm/kernel/machine_kexec.c   |    4 ++
 arch/arm/kernel/relocate_kernel.S |    6 +++
 arch/arm/kernel/setup.c           |   76 +++++++++++++++++++++++++++++++++++++
 9 files changed, 184 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/kernel/crash_dump.c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
