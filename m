Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32345C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WtPSTualifLMKrPscdaxYYSvvAOa0qqvuPKQOXD1RRA=; b=yKByGTiiEk7C8KpcADIbfE099w
	7HtQnDMzzsTZNNo9CHsCTZMFaEnnF9Q+Cgz/pcHCGMtYKxudAuEGS0OxFf5rQKNIKdS0Tzq2n57Cw
	fG/a51dRhvnYgjIquY0WO3xIkHMu/C7tv8fECcW47UTrgYEUQ193XLpCdStwASLUFyIP3Khkv8rru
	P1oWT3TvZwqldPy8XDyPXwf7lDAziR4O3TTiltI5vdBByjs4XXPIN92q3uDCVCRq5qao1NyVU2WMu
	H9/LyvKZBgmVemNKfPfjEc3PU/1ZzTgjwn07alFJh/qNeyu5CYouXO6N9dfbIHpCFXVc7E+aHnWBm
	GAZGysyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wexMv-00000002SlP-3P7j;
	Wed, 01 Jul 2026 16:00:57 +0000
Received: from out-170.mta0.migadu.com ([91.218.175.170])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wexMt-00000002ShC-0iIY
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 16:00:56 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782921651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtPSTualifLMKrPscdaxYYSvvAOa0qqvuPKQOXD1RRA=;
	b=uuF1W+lvBMPu2iHRn32L2o+mlCX5e9ZBVhPZQ7+Gjhk7o6DV+HjbYoTSjvqQglDQTUVQVr
	VkDWJrrp9sATf4rcXa9yyrbYvHADY85dp1G8BUTCMwSlSFOcrtTBhylBTT8ZMSEH4183Zj
	m/DIYNcek9JhiMIvBWZE6vSQEErGEs4=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo@loongson.cn,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v4 1/2] LoongArch: kexec: use core control page for relocation trampoline to avoid QEMU FDT conflict
Date: Wed,  1 Jul 2026 23:59:56 +0800
Message-Id: <20260701155957.534779-2-dongtai.guo@linux.dev>
In-Reply-To: <20260701155957.534779-1-dongtai.guo@linux.dev>
References: <20260701155957.534779-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_090055_351393_7DF47285 
X-CRM114-Status: GOOD (  13.30  )
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

From: George Guo <guodongtai@kylinos.cn>

KEXEC_CONTROL_CODE was hardcoded to TO_CACHE(0x100000).  QEMU places its
machine FDT at physical 0x100000 when booting with '-kernel', so
machine_kexec_prepare() overwrote the FDT with the relocation trampoline.
The kexec'd kernel's fdt_setup() then read trampoline code instead of a
valid FDT, earlycon auto-detection failed, and the second kernel booted
silently with no console output.

The trampoline does not need a fixed address.  It is executed by the
current kernel to relocate and enter the new kernel, and is dead once the
new kernel starts.  Drop KEXEC_CONTROL_CODE and reuse the
control_code_page that the kexec core already allocates (as arm64 and
riscv do).  That page is excluded from the relocation copy and lives
nowhere near 0x100000, so the QEMU FDT is left intact.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/kernel/machine_kexec.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index ced49194d9de..7ced6ca2dadb 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -21,8 +21,6 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 
-/* 0x100000 ~ 0x200000 is safe */
-#define KEXEC_CONTROL_CODE	TO_CACHE(0x100000UL)
 #define KEXEC_CMDLINE_ADDR	TO_CACHE(0x108000UL)
 
 static unsigned long reboot_code_buffer;
@@ -76,9 +74,14 @@ int machine_kexec_prepare(struct kimage *kimage)
 		}
 	}
 
-	/* kexec/kdump need a safe page to save reboot_code_buffer */
-	kimage->control_code_page = virt_to_page((void *)KEXEC_CONTROL_CODE);
-
+	/*
+	 * kexec/kdump need a safe page to save reboot_code_buffer.  Reuse the
+	 * control_code_page allocated by the kexec core (as arm64 and riscv
+	 * do) instead of a fixed address: the trampoline is only executed by
+	 * the current kernel before entering the new kernel, so it needs no
+	 * fixed or reserved location.  This also stops machine_kexec_prepare()
+	 * from overwriting QEMU's machine FDT at 0x100000.
+	 */
 	reboot_code_buffer = (unsigned long)page_address(kimage->control_code_page);
 	memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_new_kernel_size);
 
-- 
2.25.1


