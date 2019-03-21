Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h6v0q-0003fM-Gt
 for kexec@lists.infradead.org; Thu, 21 Mar 2019 10:33:30 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/3 v9] add reserved e820 ranges to the kdump kernel e820 table
Date: Thu, 21 Mar 2019 18:33:06 +0800
Message-Id: <20190321103309.27883-1-lijiang@redhat.com>
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
a). Change the examination condition to avoid confusion

Following the commit <0e4c12b45aa8> ("x86/mm, resource: Use
PAGE_KERNEL protection for ioremap of memory pages"), here
it is really checking for the 'IORES_DESC_ACPI_*' values.
Therefore, it is necessary to change the examination condition
to avoid confusion.

b). add a new I/O resource descriptor 'IORES_DESC_RESERVED'

When doing kexec_file_load, the first kernel needs to pass the e820
reserved ranges to the second kernel. But kernel can not exactly
match the e820 reserved ranges when walking through the iomem resources
with the descriptor 'IORES_DESC_NONE', because several e820 types(
e.g. E820_TYPE_RESERVED_KERN/E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820
_TYPE_RESERVED) are converted to the descriptor 'IORES_DESC_NONE'. It
may pass these four types to the kdump kernel, that is not desired result.

So, this patch adds a new I/O resource descriptor 'IORES_DESC_RESERVED'
for the iomem resources search interfaces. It is helpful to exactly
match the reserved resource ranges when walking through iomem resources.

In addition, since the new descriptor 'IORES_DESC_RESERVED' is introduced,
these code originally related to the descriptor 'IORES_DESC_NONE' need to
be updated. Otherwise, it will be easily confused and also cause some
errors. Because the 'E820_TYPE_RESERVED' type is converted to the new
descriptor 'IORES_DESC_RESERVED' instead of 'IORES_DESC_NONE', it has been
changed.

c). add the e820 reserved ranges to kdump kernel e820 table

At present, when use the kexec_file_load syscall to load the kernel image
and initramfs(for example: kexec -s -p xxx), kernel does not pass the e820
reserved ranges to the second kernel, which might cause two problems:

The first one is the MMCONFIG issue. The basic problem is that this device
is in PCI segment 1 and the kernel PCI probing can not find it without all
the e820 I/O reservations being present in the e820 table. And the kdump
kernel does not have those reservations because the kexec command does not
pass the I/O reservation via the "memmap=xxx" command line option. (This
problem does not show up for other vendors, as SGI is apparently the
actually fails for everyone, but devices in segment 0 are then found by
some legacy lookup method.) The workaround for this is to pass the I/O
reserved regions to the kdump kernel.

MMCONFIG(aka ECAM) space is described in the ACPI MCFG table. If you don't
have ECAM: (a) PCI devices won't work at all on non-x86 systems that use
only ECAM for config access, (b) you won't be albe to access devices on
non-0 segments, (c) you won't be able to access extended config space(
address 0x100-0xffff), which means none of the Extended Capabilities will
be available(AER, ACS, ATS, etc). [Bjorn's comment]

The second issue is that the SME kdump kernel doesn't work without the
e820 reserved ranges. When SME is active in kdump kernel, actually, those
reserved regions are still decrypted, but because those reserved ranges are
not present at all in kdump kernel e820 table, those reserved regions are
considered as encrypted, it goes wrong.

The e820 reserved range is useful in kdump kernel, so it is necessary to
pass the e820 reserved ranges to kdump kernel.

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

Lianbo Jiang (3):
  x86/mm: Change the examination condition to avoid confusion
  resource: add the new I/O resource descriptor 'IORES_DESC_RESERVED'
  x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

 arch/x86/kernel/crash.c | 6 ++++++
 arch/x86/kernel/e820.c  | 2 +-
 arch/x86/mm/ioremap.c   | 3 ++-
 include/linux/ioport.h  | 1 +
 kernel/resource.c       | 6 +++---
 5 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
