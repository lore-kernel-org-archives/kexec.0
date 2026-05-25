Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888DACD5BCB
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 06:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RpXKe3wAdCVMwU6Llg7SIPesFhMG6uKuOmrHw+vv3aU=; b=HZ52EeozXecXLf18J7IQuOs3Fx
	Iel/WVX7Bb1K/xhji+iG8BH5AkKfZvRPTS0AB35+BHx/U4Lw+7eakOOWTHquD4BPnTpr4o3wFsgWn
	yVHuLcPMnBvid28e3DowIwUvp8Aj3jU+kAo8SQfqLg5ltYuHBDmdpFuWzhWMiF7panDAQSKUXLiZ4
	KleC2V3zAIyB4mL4AdB7AnTAHT1juKunsQb15S/pEtHG06FPOpXR6WdAHujIXJN6Iq+dJ4jL8YJ2L
	PapxUOhicaFcMq3EnCSr6Mocrb82CSp9AdedZQysD3nhY+imGPWOe0t6co4ioxw43Zygs8K8Lyng2
	iTvg1RWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROnk-0000000GQ4y-00Rf;
	Mon, 25 May 2026 06:28:36 +0000
Received: from out-178.mta1.migadu.com ([95.215.58.178])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROng-0000000GQ2f-3Zt4
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 06:28:34 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779690510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpXKe3wAdCVMwU6Llg7SIPesFhMG6uKuOmrHw+vv3aU=;
	b=vUYWyZ1CdvfZMVBvkgDZVbpei57KgtJs9mNpdIt8reqlu40mKSoS6h5RB2R2LDIOZMvIA3
	7wD1tTsQvzyaW5cW3fY+xdCoerMSlFATNZAzoiFX+PB+IxAQ6fG/swWTRU8fGQxzBcT63L
	bQbqgORkRf7hUz3cU/du0doFMLefN78=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: kernel@xen0n.name,
	graf@amazon.com,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4/7] LoongArch: kexec: avoid overwriting QEMU's machine FDT at 0x100000
Date: Mon, 25 May 2026 14:28:07 +0800
Message-Id: <20260525062810.103367-5-dongtai.guo@linux.dev>
In-Reply-To: <20260525062810.103367-1-dongtai.guo@linux.dev>
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_232833_043687_E9BF0C22 
X-CRM114-Status: GOOD (  11.35  )
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

QEMU places its machine FDT at physical address 0x100000 when booting
with '-kernel'.  KEXEC_CONTROL_CODE was defined at the same address, so
machine_kexec_prepare() overwrites the FDT with the relocation trampoline
before jumping to the new kernel.

The kexec'd kernel's fdt_setup() reads the FDT pointer from the EFI
config table (FDTPTR = 0x100000) and finds trampoline code instead of a
valid FDT, so earlycon auto-detection fails and the second kernel boots
silently with no console output.

Move KEXEC_CONTROL_CODE to 0x180000, which is still within the first 2MB
reserved by memblock_init() and does not conflict with the QEMU FDT.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/kernel/machine_kexec.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index d7fafda1d541..44df7dbd3de5 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -21,8 +21,13 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 
-/* 0x100000 ~ 0x200000 is safe */
-#define KEXEC_CONTROL_CODE	TO_CACHE(0x100000UL)
+/*
+ * Both addresses are within the first 2MB which is always reserved by
+ * memblock_init().  Avoid 0x100000 because QEMU places its machine FDT
+ * there when using '-kernel'; overwriting it silences earlycon in the
+ * kexec'd kernel.
+ */
+#define KEXEC_CONTROL_CODE	TO_CACHE(0x180000UL)
 #define KEXEC_CMDLINE_ADDR	TO_CACHE(0x108000UL)
 
 static unsigned long reboot_code_buffer;
-- 
2.25.1


