Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam11on2068.outbound.protection.outlook.com
 ([40.107.220.68] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8VYk-00GXlz-Ng
 for kexec@lists.infradead.org; Tue, 27 Jul 2021 22:28:24 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 10/11] powerpc/pseries/svm: Remove the now unused
 mem_encrypt_active() function
Date: Tue, 27 Jul 2021 17:26:13 -0500
Message-Id: <ce42e6ff7debc5b724c63352817e4346439d3160.1627424774.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
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
To: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

The mem_encrypt_active() function has been replaced by prot_guest_has(),
so remove the implementation.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/powerpc/include/asm/mem_encrypt.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
index ba9dab07c1be..2f26b8fc8d29 100644
--- a/arch/powerpc/include/asm/mem_encrypt.h
+++ b/arch/powerpc/include/asm/mem_encrypt.h
@@ -10,11 +10,6 @@
 
 #include <asm/svm.h>
 
-static inline bool mem_encrypt_active(void)
-{
-	return is_secure_guest();
-}
-
 static inline bool force_dma_unencrypted(struct device *dev)
 {
 	return is_secure_guest();
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
