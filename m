Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h6v0z-0003hx-Sw
 for kexec@lists.infradead.org; Thu, 21 Mar 2019 10:33:39 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
Date: Thu, 21 Mar 2019 18:33:07 +0800
Message-Id: <20190321103309.27883-2-lijiang@redhat.com>
In-Reply-To: <20190321103309.27883-1-lijiang@redhat.com>
References: <20190321103309.27883-1-lijiang@redhat.com>
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

Following the commit <0e4c12b45aa8> ("x86/mm, resource: Use
PAGE_KERNEL protection for ioremap of memory pages"), here
it is really checking for the 'IORES_DESC_ACPI_*' values.
Therefore, it is necessary to change the examination condition
to avoid confusion.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/mm/ioremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 0029604af8a4..0e3ba620612d 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -83,7 +83,8 @@ static bool __ioremap_check_ram(struct resource *res)
 
 static int __ioremap_check_desc_other(struct resource *res)
 {
-	return (res->desc != IORES_DESC_NONE);
+	return ((res->desc == IORES_DESC_ACPI_TABLES) ||
+		(res->desc == IORES_DESC_ACPI_NV_STORAGE));
 }
 
 static int __ioremap_res_check(struct resource *res, void *arg)
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
