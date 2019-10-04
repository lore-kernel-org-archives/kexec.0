Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGSgw-000222-OF
 for kexec@lists.infradead.org; Fri, 04 Oct 2019 18:52:40 +0000
Received: by mail-qk1-x742.google.com with SMTP id w2so6775278qkf.2
 for <kexec@lists.infradead.org>; Fri, 04 Oct 2019 11:52:37 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v6 00/17] arm64: MMU enabled kexec relocation
Date: Fri,  4 Oct 2019 14:52:17 -0400
Message-Id: <20191004185234.31471-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com

Changelog:
v6:
	- Sync with mainline tip
	- Added Acked's from Dave Young
v5:
	- Addressed comments from Matthias Brugger: added review-by's, improved
	  comments, and made cleanups to swsusp_arch_resume() in addition to
	  create_safe_exec_page().
	- Synced with mainline tip.

v4:
	- Addressed comments from James Morse.
	- Split "check pgd table allocation" into two patches, and moved to
	  the beginning of series  for simpler backport of the fixes.
	  Added "Fixes:" tags to commit logs.
	- Changed "arm64, hibernate:" to "arm64: hibernate:"
	- Added Reviewed-by's
	- Moved "add PUD_SECT_RDONLY" earlier in series to be with other
	  clean-ups
	- Added "Derived from:" to arch/arm64/mm/trans_pgd.c
	- Removed "flags" from trans_info
	- Changed .trans_alloc_page assumption to return zeroed page.
	- Simplify changes to trans_pgd_map_page(), by keeping the old
	  code.
	- Simplify changes to trans_pgd_create_copy, by keeping the old
	  code.
	- Removed: "add trans_pgd_create_empty"
	- replace init_mm with NULL, and keep using non "__" version of
	  populate functions.
v3:
	- Split changes to create_safe_exec_page() into several patches for
	  easier review as request by Mark Rutland. This is why this series
	  has 3 more patches.
	- Renamed trans_table to tans_pgd as agreed with Mark. The header
	  comment in trans_pgd.c explains that trans stands for
	  transitional page tables. Meaning they are used in transition
	  between two kernels.
v2:
	- Fixed hibernate bug reported by James Morse
	- Addressed comments from James Morse:
	  * More incremental changes to trans_table
	  * Removed TRANS_FORCEMAP
	  * Added kexec reboot data for image with 380M in size.

Enable MMU during kexec relocation in order to improve reboot performance.

If kexec functionality is used for a fast system update, with a minimal
downtime, the relocation of kernel + initramfs takes a significant portion
of reboot.

The reason for slow relocation is because it is done without MMU, and thus
not benefiting from D-Cache.

Performance data
----------------
For this experiment, the size of kernel plus initramfs is small, only 25M.
If initramfs was larger, than the improvements would be greater, as time
spent in relocation is proportional to the size of relocation.

Previously:
kernel shutdown	0.022131328s
relocation	0.440510736s
kernel startup	0.294706768s

Relocation was taking: 58.2% of reboot time

Now:
kernel shutdown	0.032066576s
relocation	0.022158152s
kernel startup	0.296055880s

Now: Relocation takes 6.3% of reboot time

Total reboot is x2.16 times faster.

With bigger userland (fitImage 380M), the reboot time is improved by 3.57s,
and is reduced from 3.9s down to 0.33s

Previous approaches and discussions
-----------------------------------
https://lore.kernel.org/lkml/20190923203427.294286-1-pasha.tatashin@soleen.com
version 5 of this series

https://lore.kernel.org/lkml/20190909181221.309510-1-pasha.tatashin@soleen.com
version 4 of this series

https://lore.kernel.org/lkml/20190821183204.23576-1-pasha.tatashin@soleen.com
version 3 of this series

https://lore.kernel.org/lkml/20190817024629.26611-1-pasha.tatashin@soleen.com
version 2 of this series

https://lore.kernel.org/lkml/20190801152439.11363-1-pasha.tatashin@soleen.com
version 1 of this series

https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
reserve space for kexec to avoid relocation, involves changes to generic code
to optimize a problem that exists on arm64 only:

https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
The first attempt to enable MMU, some bugs that prevented performance
improvement. The page tables unnecessary configured idmap for the whole
physical space.

https://lore.kernel.org/lkml/20190731153857.4045-1-pasha.tatashin@soleen.com
No linear copy, bug with EL2 reboots.

Pavel Tatashin (17):
  kexec: quiet down kexec reboot
  arm64: hibernate: pass the allocated pgdp to ttbr0
  arm64: hibernate: check pgd table allocation
  arm64: hibernate: use get_safe_page directly
  arm64: hibernate: remove gotos as they are not needed
  arm64: hibernate: rename dst to page in create_safe_exec_page
  arm64: hibernate: add PUD_SECT_RDONLY
  arm64: hibernate: add trans_pgd public functions
  arm64: hibernate: move page handling function to new trans_pgd.c
  arm64: trans_pgd: make trans_pgd_map_page generic
  arm64: trans_pgd: pass allocator trans_pgd_create_copy
  arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
  kexec: add machine_kexec_post_load()
  arm64: kexec: move relocation function setup and clean up
  arm64: kexec: add expandable argument to relocation function
  arm64: kexec: configure trans_pgd page table for kexec
  arm64: kexec: enable MMU during kexec relocation

 arch/arm64/Kconfig                     |   4 +
 arch/arm64/include/asm/kexec.h         |  51 ++++-
 arch/arm64/include/asm/pgtable-hwdef.h |   1 +
 arch/arm64/include/asm/trans_pgd.h     |  34 ++++
 arch/arm64/kernel/asm-offsets.c        |  14 ++
 arch/arm64/kernel/cpu-reset.S          |   4 +-
 arch/arm64/kernel/cpu-reset.h          |   8 +-
 arch/arm64/kernel/hibernate.c          | 245 +++++--------------------
 arch/arm64/kernel/machine_kexec.c      | 196 ++++++++++++++++----
 arch/arm64/kernel/relocate_kernel.S    | 196 ++++++++++----------
 arch/arm64/mm/Makefile                 |   1 +
 arch/arm64/mm/trans_pgd.c              | 244 ++++++++++++++++++++++++
 kernel/kexec.c                         |   4 +
 kernel/kexec_core.c                    |   8 +-
 kernel/kexec_file.c                    |   4 +
 kernel/kexec_internal.h                |   2 +
 16 files changed, 674 insertions(+), 342 deletions(-)
 create mode 100644 arch/arm64/include/asm/trans_pgd.h
 create mode 100644 arch/arm64/mm/trans_pgd.c

-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
