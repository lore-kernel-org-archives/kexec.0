Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Nng-008v0K-Fe
 for kexec@lists.infradead.org; Mon, 05 Jul 2021 12:34:13 +0000
Received: by mail-lf1-x133.google.com with SMTP id bq39so19605099lfb.12
 for <kexec@lists.infradead.org>; Mon, 05 Jul 2021 05:34:11 -0700 (PDT)
From: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Subject: [PATCH] makedumpfile/arm: fix page_offset determination
Date: Mon,  5 Jul 2021 14:33:54 +0200
Message-Id: <20210705123354.1173984-1-grzegorz.jaszczyk@linaro.org>
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
To: k-hagio-ab@nec.com
Cc: kexec@lists.infradead.org, Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>

When the CONFIG_STRICT_KERNEL_RWX is enabled for the armv7 kernel the
_stext is aligned to 1<<SECTION_SHIFT, which with hitherto code causes
wrong page_offset determination.

Suit mask used for page_offset in a way that it will allow to correctly
determine page_offset regardless of CONFIG_STRICT_KERNEL_RWX and
CONFIG_ARM_LPAE settings.

Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 arch/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm.c b/arch/arm.c
index 33536fc..7ae9cb1 100644
--- a/arch/arm.c
+++ b/arch/arm.c
@@ -80,7 +80,7 @@ get_phys_base_arm(void)
 int
 get_machdep_info_arm(void)
 {
-	info->page_offset = SYMBOL(_stext) & 0xffff0000UL;
+	info->page_offset = SYMBOL(_stext) & 0xffc00000UL;
 
 	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
 	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
-- 
2.29.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
