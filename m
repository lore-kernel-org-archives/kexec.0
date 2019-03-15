Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h4k8g-0005YF-5Q
 for kexec@lists.infradead.org; Fri, 15 Mar 2019 10:32:35 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when SEV is
 active
Date: Fri, 15 Mar 2019 18:32:01 +0800
Message-Id: <20190315103203.13128-2-lijiang@redhat.com>
In-Reply-To: <20190315103203.13128-1-lijiang@redhat.com>
References: <20190315103203.13128-1-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

Currently, the arch_kexec_post_{alloc,free}_pages unconditionally
maps the kexec area as decrypted. This works fine when SME is active.
Because in SME, the first kernel is loaded in decrypted area by the
BIOS, so the second kernel must be also loaded into the decrypted
memory.

When SEV is active, the first kernel is loaded into the encrypted
area, so the second kernel must be also loaded into the encrypted
memory. Lets make sure that arch_kexec_post_{alloc,free}_pages does
not clear the memory encryption mask from the kexec area when SEV
is active.

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..bcebf4993da4 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -566,7 +566,10 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 	 * not encrypted because when we boot to the new kernel the
 	 * pages won't be accessed encrypted (initially).
 	 */
-	return set_memory_decrypted((unsigned long)vaddr, pages);
+	if (sme_active())
+		return set_memory_decrypted((unsigned long)vaddr, pages);
+
+	return 0;
 }
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
@@ -575,5 +578,6 @@ void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 	 * If SME is active we need to reset the pages back to being
 	 * an encrypted mapping before freeing them.
 	 */
-	set_memory_encrypted((unsigned long)vaddr, pages);
+	if (sme_active())
+		set_memory_encrypted((unsigned long)vaddr, pages);
 }
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
