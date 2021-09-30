Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVx5u-00EhWc-AH
 for kexec@lists.infradead.org; Thu, 30 Sep 2021 14:31:36 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id o15so3706339qvq.4
 for <kexec@lists.infradead.org>; Thu, 30 Sep 2021 07:31:30 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v18 13/15] arm64: kexec: remove the pre-kexec PoC maintenance
Date: Thu, 30 Sep 2021 14:31:11 +0000
Message-Id: <20210930143113.1502553-14-pasha.tatashin@soleen.com>
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, kernelfans@gmail.com, akpm@linux-foundation.org

Now that kexec does its relocations with the MMU enabled, we no longer
need to clean the relocation data to the PoC.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 43 -------------------------------
 1 file changed, 43 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 1e9a2a45e016..559d47a3c59c 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -77,48 +77,6 @@ int machine_kexec_prepare(struct kimage *kimage)
 	return 0;
 }
 
-/**
- * kexec_list_flush - Helper to flush the kimage list and source pages to PoC.
- */
-static void kexec_list_flush(struct kimage *kimage)
-{
-	kimage_entry_t *entry;
-
-	dcache_clean_inval_poc((unsigned long)kimage,
-			       (unsigned long)kimage + sizeof(*kimage));
-
-	for (entry = &kimage->head; ; entry++) {
-		unsigned int flag;
-		unsigned long addr;
-
-		/* flush the list entries. */
-		dcache_clean_inval_poc((unsigned long)entry,
-				    (unsigned long)entry +
-					    sizeof(kimage_entry_t));
-
-		flag = *entry & IND_FLAGS;
-		if (flag == IND_DONE)
-			break;
-
-		addr = (unsigned long)phys_to_virt(*entry & PAGE_MASK);
-
-		switch (flag) {
-		case IND_INDIRECTION:
-			/* Set entry point just before the new list page. */
-			entry = (kimage_entry_t *)addr - 1;
-			break;
-		case IND_SOURCE:
-			/* flush the source pages. */
-			dcache_clean_inval_poc(addr, addr + PAGE_SIZE);
-			break;
-		case IND_DESTINATION:
-			break;
-		default:
-			BUG();
-		}
-	}
-}
-
 /**
  * kexec_segment_flush - Helper to flush the kimage segments to PoC.
  */
@@ -207,7 +165,6 @@ int machine_kexec_post_load(struct kimage *kimage)
 			       (unsigned long)reloc_code + reloc_size);
 	icache_inval_pou((uintptr_t)reloc_code,
 			 (uintptr_t)reloc_code + reloc_size);
-	kexec_list_flush(kimage);
 	kexec_image_info(kimage);
 
 	return 0;
-- 
2.33.0.800.g4c38ced690-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
