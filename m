Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFF1CA0FFF
	for <kexec@archiver.kernel.org>; Fri, 29 Aug 2025 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfR4dlTTpzmJe9cscuWulUa0CUhzj0IRltHWA7NFE3A=; b=4OlfK0j1O8XoGTjeqys6aNM9ui
	L5HuBN22uAMhfpui5FnRORQdWdC6ayhkgMcpShZCSu+oqAN+zQnA3PK8l5Z+DUDMw1CY4hMdV6dKT
	lj8YpRp6jxylAoQtZnDjoeoCj6+lb780OJuGP5GnljxEZ854KV67/UbKQPXy3G2HJduQLLCMYrO20
	ZmMX+tKD6g7yy2mnP5b/w1aIl/NHf50+aXtEe7Mirflarfbkq0PINAWkgn+Wg07lzzRrlNYBtxFB0
	Lq4dr8pETN06kCRyeXqViQXBaE47gVOljI9A4ja0E3yhB6VzQwcjpFn3YD4i81PwG7b3jf7JHXGiw
	40EszZIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urwDD-00000005IhL-41Ua;
	Fri, 29 Aug 2025 10:20:03 +0000
Received: from out-179.mta1.migadu.com ([2001:41d0:203:375::b3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urv9L-00000005635-3sT6
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 09:12:01 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756458718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfR4dlTTpzmJe9cscuWulUa0CUhzj0IRltHWA7NFE3A=;
	b=uL4a+cSauyyx0Ln7qIzXawttxLG1SGuMSatZCZC9jHXOXLVlwheDsjcbPAb3/d4m65esQr
	cHH7CqbG4q0BT5kGRvf2waiK11XySrGLcntTSK9xOCnQ6+JM62JUuE/cY/RB2U7rSPk0rz
	RN0k3vpyLPwa1QSgTTBFKyAnXtD6njU=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinios.cn>
Subject: [PATCH 7/7] LoongArch: Add pe_hdr->machine check for pei format images
Date: Fri, 29 Aug 2025 17:10:40 +0800
Message-Id: <20250829091040.35827-8-youling.tang@linux.dev>
In-Reply-To: <20250829091040.35827-1-youling.tang@linux.dev>
References: <20250829091040.35827-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_021200_107876_D387BFE8 
X-CRM114-Status: GOOD (  12.10  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Youling Tang <tangyouling@kylinios.cn>

Add the pe_hdr->machine check to ensure that the kernel image is of the 64-bit
LoongArch architecture.

Signed-off-by: Youling Tang <tangyouling@kylinios.cn>
---
 kexec/arch/loongarch/image-header.h        |  3 +++
 kexec/arch/loongarch/kexec-pei-loongarch.c | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/kexec/arch/loongarch/image-header.h b/kexec/arch/loongarch/image-header.h
index 0db7615..fc71ff2 100644
--- a/kexec/arch/loongarch/image-header.h
+++ b/kexec/arch/loongarch/image-header.h
@@ -35,6 +35,9 @@ struct loongarch_image_header {
 static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
 static const uint8_t loongarch_pe_machtype[6] = {'P','E', 0x0, 0x0, 0x64, 0x62};
 
+#define IMAGE_FILE_MACHINE_LOONGARCH64  0x6264 /* LoongArch 64-bit processor family */
+
+
 /**
  * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
  *
diff --git a/kexec/arch/loongarch/kexec-pei-loongarch.c b/kexec/arch/loongarch/kexec-pei-loongarch.c
index 1a19a39..e0a82b6 100644
--- a/kexec/arch/loongarch/kexec-pei-loongarch.c
+++ b/kexec/arch/loongarch/kexec-pei-loongarch.c
@@ -24,9 +24,20 @@
 #include "kexec-loongarch.h"
 #include "arch/options.h"
 
+#include <pe.h>
+
+static inline int loongarch_pe_check_machine(const struct pe_hdr *pe_hdr)
+{
+	if (!pe_hdr)
+		return 0;
+
+	return (pe_hdr->machine == IMAGE_FILE_MACHINE_LOONGARCH64);
+}
+
 int pei_loongarch_probe(const char *kernel_buf, off_t kernel_size)
 {
 	const struct loongarch_image_header *h;
+	const struct pe_hdr *pe_hdr;
 
 	if (kernel_size < sizeof(struct loongarch_image_header)) {
 		dbgprintf("%s: No loongarch image header.\n", __func__);
@@ -40,6 +51,12 @@ int pei_loongarch_probe(const char *kernel_buf, off_t kernel_size)
 		return -1;
 	}
 
+	pe_hdr = (const struct pe_hdr *)(kernel_buf + get_pehdr_offset(kernel_buf));
+	if (!loongarch_pe_check_machine(pe_hdr)) {
+		dbgprintf("%s: Bad loongarch pe_hdr machine.\n", __func__);
+		return -1;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


