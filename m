Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i1FZ8-0000JO-As
 for kexec@lists.infradead.org; Fri, 23 Aug 2019 19:49:44 +0000
From: Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v5 0/7] kexec: add generic support for elf kernel images
Date: Fri, 23 Aug 2019 21:49:12 +0200
Message-Id: <20190823194919.30916-1-svens@stackframe.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>, linuxppc-dev@lists.ozlabs.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Changes to v4:
 - rebase on current powerpc/merge tree
 - fix syscall name in commit message
 - remove a few unused #defines in arch/powerpc/kernel/kexec_elf_64.c

Changes to v3:
 - add support for 32-bit ELF files

Changes to v2:
 - use git format-patch -C

Changes to v1:
 - split up patch into smaller pieces
 - rebase onto powerpc/next
 - remove unused variable in kexec_elf_load()

Changes to RFC version:
 - remove unused Elf_Rel macro
 - remove section header parsing
 - remove PURGATORY_STACK_SIZE
 - change order of elf_*_to_cpu() functions
 - remove elf_addr_to_cpu macro

Sven Schnelle (7):
  kexec: add KEXEC_ELF
  kexec_elf: change order of elf_*_to_cpu() functions
  kexec_elf: remove parsing of section headers
  kexec_elf: remove PURGATORY_STACK_SIZE
  kexec_elf: remove Elf_Rel macro
  kexec_elf: remove unused variable in kexec_elf_load()
  kexec_elf: support 32 bit ELF files

 arch/Kconfig                                  |   3 +
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/kernel/kexec_elf_64.c            | 545 +-----------------
 include/linux/kexec.h                         |  23 +
 kernel/Makefile                               |   1 +
 .../kexec_elf_64.c => kernel/kexec_elf.c      | 394 +++----------
 6 files changed, 115 insertions(+), 852 deletions(-)
 copy arch/powerpc/kernel/kexec_elf_64.c => kernel/kexec_elf.c (50%)

-- 
2.23.0.rc1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
