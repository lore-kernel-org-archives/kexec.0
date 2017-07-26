Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com
 ([104.47.32.76] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1daQgK-0001yP-Dh
 for kexec@lists.infradead.org; Wed, 26 Jul 2017 18:05:13 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v1 1/2] x86/mm,
 kexec: Fix memory corruption with SME on successive kexecs
Date: Wed, 26 Jul 2017 13:04:33 -0500
Message-Id: <28648b23b9957506069e20bd985e3d7e8af94780.1501092102.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1501092102.git.thomas.lendacky@amd.com>
References: <cover.1501092102.git.thomas.lendacky@amd.com>
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
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

After issuing successive kexecs it was found that the SHA hash failed
verification when booting the kexec'd kernel.  When SME is enabled, the
change from using pages that were marked encrypted to now being marked as
not encrypted (through new identify mapped page tables) results in memory
corruption if there are any cache entries for the previously encrypted
pages. This is because separate cache entries can exist for the same
physical location but tagged both with and without the encryption bit.

To prevent this, issue a wbinvd before copying the pages from the source
location to the destination location to clear any possible cache entry
conflicts.

Cc: <kexec@lists.infradead.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 98111b3..c11d8bc 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -132,6 +132,13 @@ identity_mapped:
 	/* Flush the TLB (needed?) */
 	movq	%r9, %cr3
 
+	/*
+	 * If SME is/was active, there could be old encrypted cache line
+	 * entries that will conflict with the now unencrypted memory
+	 * used by kexec. Flush the caches before copying the kernel.
+	 */
+	wbinvd
+
 	movq	%rcx, %r11
 	call	swap_pages
 
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
