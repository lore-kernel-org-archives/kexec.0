Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMpdL-00032Z-D5
 for kexec@lists.infradead.org; Wed, 14 Nov 2018 07:30:44 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/2 v6] x86/kexec_file: add reserved e820 ranges to kdump
 kernel e820 table
Date: Wed, 14 Nov 2018 15:29:26 +0800
Message-Id: <20181114072926.13312-3-lijiang@redhat.com>
In-Reply-To: <20181114072926.13312-1-lijiang@redhat.com>
References: <20181114072926.13312-1-lijiang@redhat.com>
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
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

At present, when use the kexec_file_load syscall to load the kernel image
and initramfs(for example: kexec -s -p xxx), the upstream kernel does not
pass the e820 reserved ranges to the second kernel, which might produce
two problems:

The first one is the MMCONFIG issue, although which does not make the
system crash or hang, this issue is still a potential risk, and also
might lead to the hot-plug device could not be recognized in kdump kernel.
Because the PCI MMCONFIG(extended mode) requires the reserved region
otherwise it falls back to legacy mode. For example, the kdump kernel
outputs the following log.

Example:
......
[   19.798354] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[   19.800653] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
[   19.800995] PCI: not using MMCONFIG
......

The correct kernel log is like this:
......
[    0.082649] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    0.083610] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
......

The second issue is that the e820 reserved ranges do not setup in kdump
kernel, which will cause some functions that related to the e820 reserved
ranges to become invalid. For example:

early_memremap()->
early_memremap_pgprot_adjust()->
memremap_should_map_decrypted()->
e820__get_entry_type()

Please focus on these functions, early_memremap_pgprot_adjust() and
memremap_should_map_decrypted().

In the first kernel, these ranges sit in e820 reserved ranges, so the
memremap_should_map_decrypted() will return true, that is to say, the
reserved memory is decrypted, then the early_memremap_pgprot_adjust()
will call the pgprot_decrypted() to clear the memory encryption mask.

In the second kernel, because the e820 reserved ranges are not passed
to the second kernel, these ranges don't sit in the e820 reserved ranges,
so the memremap_should_map_decrypted() will return false, that is to say,
the reserved memory is encrypted, and then the early_memremap_pgprot_
adjust() will also call the pgprot_encrypted() to set the memory encryption
mask.

In fact, in the second kernel, the e820 reserved memory is still decrypted.
Obviously, it has gone wrong. So, this issue must be fixed, otherwise kdump
won't work in this case.

The e820 reserved range is useful in kdump kernel, so it is necessary to
pass the e820 reserved ranges to kdump kernel.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
Changes since v5:
1. Improve the patch log

 arch/x86/kernel/crash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index ae724a6e0a5f..d3167125800e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -384,6 +384,10 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
 			memmap_entry_callback);
 
+	cmd.type = E820_TYPE_RESERVED;
+	walk_iomem_res_desc(IORES_DESC_NONE, 0, 0, -1, &cmd,
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
