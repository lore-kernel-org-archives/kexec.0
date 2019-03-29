Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9lSE-0001VE-QL
 for kexec@lists.infradead.org; Fri, 29 Mar 2019 06:57:32 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/2 v10] x86/kexec_file: add reserved e820 ranges to kdump
 kernel e820 table
Date: Fri, 29 Mar 2019 14:56:49 +0800
Message-Id: <20190329065649.12468-3-lijiang@redhat.com>
In-Reply-To: <20190329065649.12468-1-lijiang@redhat.com>
References: <20190329065649.12468-1-lijiang@redhat.com>
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

At present, when using the kexec_file_load() syscall to load the kernel
image and initramfs(for example: kexec -s -p xxx), the kernel does not
pass the e820 reserved ranges to the second kernel, which might cause
two problems:

The first one is the MMCONFIG issue. The basic problem is that this
device is in PCI segment 1 and the kernel PCI probing can not find it
without all the e820 I/O reservations being present in the e820 table.
And the kdump kernel does not have those reservations because the kexec
command does not pass the I/O reservation via the "memmap=xxx" command
line option. (This problem does not show up for other vendors, as SGI
is apparently the actually fails for everyone, but devices in segment 0
are then found by some legacy lookup method.) The workaround for this
is to pass the I/O reserved regions to the kdump kernel.

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
pass the e820 reserved ranges to the kdump kernel.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/crash.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 17ffc869cab8..1db2754df9e9 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -381,6 +381,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
 			memmap_entry_callback);
 
+	/* Add e820 reserved ranges */
+	cmd.type = E820_TYPE_RESERVED;
+	flags = IORESOURCE_MEM;
+	walk_iomem_res_desc(IORES_DESC_RESERVED, flags, 0, -1, &cmd,
+			   memmap_entry_callback);
+
 	/* Add crashk_low_res region */
 	if (crashk_low_res.end) {
 		ei.addr = crashk_low_res.start;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
