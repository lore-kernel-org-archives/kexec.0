Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hIkGN-0005Mc-Ut
 for kexec@lists.infradead.org; Tue, 23 Apr 2019 01:30:25 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel e820
 table
Date: Tue, 23 Apr 2019 09:30:04 +0800
Message-Id: <20190423013007.17838-1-lijiang@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

This patchset did three things:

a). x86/e820, resource: add a new I/O resource descriptor 'IORES_DESC_
    RESERVED'

b). x86/mm: change the check condition in SEV because a new descriptor is
    introduced

c). x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

Changes since v1:
1. Modified the value of flags to "0", when walking through the whole
tree for e820 reserved ranges.

Changes since v2:
1. Modified the value of flags to "0", when walking through the whole
tree for e820 reserved ranges.
2. Modified the invalid SOB chain issue.

Changes since v3:
1. Dropped [PATCH 1/3 v3] resource: fix an error which walks through iomem
   resources. Please refer to this commit <010a93bf97c7> "resource: Fix
   find_next_iomem_res() iteration issue"

Changes since v4:
1. Improve the patch log, and add kernel log.

Changes since v5:
1. Rewrite these patches log.

Changes since v6:
1. Modify the [PATCH 1/2], and add the new I/O resource descriptor
   'IORES_DESC_RESERVED' for the iomem resources search interfaces,
   and also updates these codes relates to 'IORES_DESC_NONE'.
2. Modify the [PATCH 2/2], and walk through io resource based on the
   new descriptor 'IORES_DESC_RESERVED'.
3. Update patch log.

Changes since v7:
1. Improve patch log.
2. Improve this function __ioremap_check_desc_other().
3. Modify code comment in the __ioremap_check_desc_other()

Changes since v8:
1. Get rid of all changes about ia64.(Borislav's suggestion)
2. Change the examination condition to the 'IORES_DESC_ACPI_*'.
3. Modify the signature. This patch(add the new I/O resource
   descriptor 'IORES_DESC_RESERVED') was suggested by Boris.

Changes since v9:
1. Improve patch log.
2. No need to modify the kernel/resource.c, so correct them.
3. Change the name of the __ioremap_check_desc_other() to
   __ioremap_check_desc_none_and_reserved(), and modify the
   check condition, add comment above it.

Changes since v10:
1. Split them into three patches, the second patch is currently added.
2. Change struct ioremap_mem_flags to struct ioremap_desc and redefine
it.
3. Change the name of the __ioremap_check_desc_other() to
__ioremap_check_desc().
4. Change the check condition in SEV and also improve them.
5. Modify the return value for some functions.

Lianbo Jiang (3):
  x86/e820, resource: add a new I/O resource descriptor
    'IORES_DESC_RESERVED'
  x86/mm: change the check condition in SEV because a new descriptor is
    introduced
  x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

 arch/x86/kernel/crash.c |  6 +++++
 arch/x86/kernel/e820.c  |  2 +-
 arch/x86/mm/ioremap.c   | 59 ++++++++++++++++++++++++++---------------
 include/linux/ioport.h  | 10 +++++++
 4 files changed, 54 insertions(+), 23 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
