Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hkw1d-0004NY-TQ
 for kexec@lists.infradead.org; Tue, 09 Jul 2019 19:43:45 +0000
From: Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 0/7] kexec: add generic support for elf kernel images
Date: Tue,  9 Jul 2019 21:43:21 +0200
Message-Id: <20190709194328.16991-1-svens@stackframe.org>
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
Cc: Sven Schnelle <svens@stackframe.org>, deller@gmx.de, linuxppc-dev@lists.ozlabs.org

Hi List,

i've split up the patch a bit more. The first one move the generic elf stuff
out of arch/powerpc to linux/kexec_elf.c, and prefixes the exposed functions
with kexec_. That other patches remove stuff that is not used as proposed in
the review.

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
  kexec_elf: remove elf_addr_to_cpu macro
  kexec_elf: remove Elf_Rel macro
  kexec_elf: remove unused variable in kexec_elf_load()

 arch/Kconfig                       |   3 +
 arch/powerpc/Kconfig               |   1 +
 arch/powerpc/kernel/kexec_elf_64.c | 551 +----------------------------
 include/linux/kexec.h              |  23 ++
 kernel/Makefile                    |   1 +
 kernel/kexec_elf.c                 | 389 ++++++++++++++++++++
 6 files changed, 427 insertions(+), 541 deletions(-)
 create mode 100644 kernel/kexec_elf.c

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
