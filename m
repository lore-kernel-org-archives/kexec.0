Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fZtFD-0000ZE-Db
 for kexec@lists.infradead.org; Mon, 02 Jul 2018 07:27:38 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 4/5 V5] Adjust some permanent mappings in unencrypted ways for
 kdump when SME is enabled.
Date: Mon,  2 Jul 2018 15:26:38 +0800
Message-Id: <20180702072639.10110-5-lijiang@redhat.com>
In-Reply-To: <20180702072639.10110-1-lijiang@redhat.com>
References: <20180702072639.10110-1-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

For kdump, the acpi table and dmi table will need to be remapped in
unencrypted ways during early init, they have just a simple wrapper
around early_memremap(), but the early_memremap() remaps the memory
in encrypted ways by default when SME is enabled, so we put some logic
into the early_memremap_pgprot_adjust(), which will have an opportunity
to adjust it.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/mm/ioremap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index e01e6c6..3c1c8c4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -689,8 +689,17 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 	encrypted_prot = true;
 
 	if (sme_active()) {
+		/*
+		 * In kdump mode, the acpi table and dmi table will need to
+		 * be remapped in unencrypted ways during early init when
+		 * SME is enabled. They have just a simple wrapper around
+		 * early_memremap(), but the early_memremap() remaps the
+		 * memory in encrypted ways by default when SME is enabled,
+		 * so we must adjust it.
+		 */
 		if (early_memremap_is_setup_data(phys_addr, size) ||
-		    memremap_is_efi_data(phys_addr, size))
+		    memremap_is_efi_data(phys_addr, size) ||
+		    is_kdump_kernel())
 			encrypted_prot = false;
 	}
 
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
