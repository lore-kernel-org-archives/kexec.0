Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1curd6-0004lO-RI
 for kexec@lists.infradead.org; Mon, 03 Apr 2017 02:22:06 +0000
Received: by mail-pg0-x232.google.com with SMTP id x125so105478235pgb.0
 for <kexec@lists.infradead.org>; Sun, 02 Apr 2017 19:21:43 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v35 05/14] arm64: mm: add set_memory_valid()
Date: Mon,  3 Apr 2017 11:24:33 +0900
Message-Id: <20170403022440.12515-3-takahiro.akashi@linaro.org>
In-Reply-To: <20170403022139.12383-1-takahiro.akashi@linaro.org>
References: <20170403022139.12383-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: mark.rutland@arm.com, panand@redhat.com, ard.biesheuvel@linaro.org, geoff@infradead.org, dwmw2@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

This function validates and invalidates PTE entries, and will be utilized
in kdump to protect loaded crash dump kernel image.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/pageattr.c            | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 5a2a6ee65f65..728f933cef8c 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -154,5 +154,6 @@ int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
+int set_memory_valid(unsigned long addr, unsigned long size, int enable);
 
 #endif
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 8def55e7249b..3212ee0558f6 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -125,20 +125,23 @@ int set_memory_x(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL_GPL(set_memory_x);
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-void __kernel_map_pages(struct page *page, int numpages, int enable)
+int set_memory_valid(unsigned long addr, int numpages, int enable)
 {
-	unsigned long addr = (unsigned long) page_address(page);
-
 	if (enable)
-		__change_memory_common(addr, PAGE_SIZE * numpages,
+		return __change_memory_common(addr, PAGE_SIZE * numpages,
 					__pgprot(PTE_VALID),
 					__pgprot(0));
 	else
-		__change_memory_common(addr, PAGE_SIZE * numpages,
+		return __change_memory_common(addr, PAGE_SIZE * numpages,
 					__pgprot(0),
 					__pgprot(PTE_VALID));
 }
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	set_memory_valid((unsigned long)page_address(page), numpages, enable);
+}
 #ifdef CONFIG_HIBERNATION
 /*
  * When built with CONFIG_DEBUG_PAGEALLOC and CONFIG_HIBERNATION, this function
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
