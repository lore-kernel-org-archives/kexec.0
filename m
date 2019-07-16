Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hnQku-00052K-UU
 for kexec@lists.infradead.org; Tue, 16 Jul 2019 16:56:46 +0000
Received: by mail-qk1-x744.google.com with SMTP id w190so15147834qkc.6
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2019 09:56:43 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [RFC v1 0/4] arm64: MMU enabled kexec kernel relocation
Date: Tue, 16 Jul 2019 12:56:37 -0400
Message-Id: <20190716165641.6990-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Added identity mapped page table, and keep MMU enabled while
kernel is being relocated from sparse pages to the final
destination during kexec.

More description about the problem I am trying to solve here, can be
found here:
https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com/

This patch series works in terms, that I can kexec-reboot both in QEMU
and on a physical machine. However, I do not see performance improvement
during relocation. The performance is just as slow as before with disabled
caches.

Am I missing something? Perhaps, there is some flag that I should also
enable in page table? Please provide me with any suggestions.

Pavel Tatashin (4):
  arm64, mm: identity mapped page table
  arm64, kexec: interface preparation for mmu enabled kexec
  arm64, kexec: add kexec's own identity page table
  arm64: Keep MMU on while kernel is being relocated

 arch/arm64/include/asm/ident_map.h  |  26 ++++++
 arch/arm64/include/asm/kexec.h      |   5 +-
 arch/arm64/kernel/cpu-reset.S       |   8 --
 arch/arm64/kernel/cpu-reset.h       |   7 +-
 arch/arm64/kernel/machine_kexec.c   | 128 +++++++++++++++++++++-------
 arch/arm64/kernel/relocate_kernel.S |  36 +++++---
 arch/arm64/mm/Makefile              |   1 +
 arch/arm64/mm/ident_map.c           |  99 +++++++++++++++++++++
 8 files changed, 255 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm64/include/asm/ident_map.h
 create mode 100644 arch/arm64/mm/ident_map.c

-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
