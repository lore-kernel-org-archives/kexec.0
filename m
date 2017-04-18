Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0088.outbound.protection.outlook.com
 ([104.47.34.88] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d0aYa-00040f-RZ
 for kexec@lists.infradead.org; Tue, 18 Apr 2017 21:21:06 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v5 24/32] iommu/amd: Disable AMD IOMMU if memory encryption
 is active
Date: Tue, 18 Apr 2017 16:20:30 -0500
Message-ID: <20170418212029.10190.92261.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
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
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>

For now, disable the AMD IOMMU if memory encryption is active. A future
patch will re-enable the function with full memory encryption support.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/iommu/amd_iommu_init.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5a11328..c72d13b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/kmemleak.h>
+#include <linux/mem_encrypt.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
@@ -2552,6 +2553,12 @@ int __init amd_iommu_detect(void)
 	if (amd_iommu_disabled)
 		return -ENODEV;
 
+	/* For now, disable the IOMMU if SME is active */
+	if (sme_active()) {
+		pr_notice("AMD-Vi: SME is active, disabling the IOMMU\n");
+		return -ENODEV;
+	}
+
 	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
 	if (ret)
 		return ret;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
