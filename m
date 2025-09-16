Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2540CAC59B
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eoaSDlxtMPIzTU8QoVaWVE4hx4IrMtMzUoZMbgYwSY8=; b=QtHtkh4wF+53c0k5KugoXm3tZy
	bzxhCU99ry+i5BHdoUsByZQpiBa0ZhACVFEtYJ5vn4QSRlGnVJ0aV+/vJN3CmDtWisfH187ty2JJG
	K0uTXac+dnMXpxpwheQxoHMv4XLTh5O0Gw7aUhp78TIhwUWS7q2O8qYF5Ii1bmuzoBpuAV4DzHRuy
	YMyrAfy2bw38CA93AzA1isC+RpVNyTJs4cMBz7FWa5dH+pvXQU1l+tG+5p+muCVLGGyqu/iEoMQ6e
	aWfAu5clY5WuBFy4ALuw5kaXv5tJRmEDag9kymOijSZU44b+q27+CespFg4pAxpz+mTWzXkNVWNMZ
	0tN4sBZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsw-00000006CYU-18QF;
	Tue, 16 Sep 2025 01:53:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsu-00000006CY5-3jyQ
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:53:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eoaSDlxtMPIzTU8QoVaWVE4hx4IrMtMzUoZMbgYwSY8=; b=HRb58euy2YKKyZukcn+Ac+7x8R
	etdcFjxndDJVLcXoEOAQZldMWI6OczJJ1PwlFfsmNrKfNc6Pjqa0E3Sbwdz3DxFc2wU+Pp34QLAwc
	1MHlnDa5p3nqR+YcuaC4IMg556SWM4noC4E0IsSa7aXs6T9x/K3EOGB2pDD/HxGYrVL7h1MVh/72e
	EIV+NRbk9FMlvW/wW+V9shIpBEg+1ActgSMBzAwvW+9oapUyX0i5JTpWVGVveqmFjavuliYHgVEJy
	2k02kdGjApmwP4bGBcpPIz97ecfsvDarRY6h65OaM9+JPt3gWBjYfHYAE1paHrQRxY3XiSqxeojR+
	9pQh0DaA==;
Received: from out-188.mta0.migadu.com ([2001:41d0:1004:224b::bc])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsq-000000077kE-1Yxl
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:53:31 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoaSDlxtMPIzTU8QoVaWVE4hx4IrMtMzUoZMbgYwSY8=;
	b=CnjLJkn6ha4iEc9XKgwBuHq/4EksLaMJexbAZPWC+O3spQj16OhBG04uz9HreNNfUQ4ypG
	Mvkq3Kp/Nu3lkOtpmdDJejeyRYbb2X7NJD+tV/IVM5wqoMq/tPgp2Ozt+DUFMtQ2IGpxnH
	+2Yq9+sT3w5Dgg2S0BEhu8a07rZkP3U=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 07/10] LoongArch: Add pe_hdr->machine check for pei format images
Date: Tue, 16 Sep 2025 09:46:52 +0800
Message-Id: <20250916014655.841632-8-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025328_976969_28CE7D3E 
X-CRM114-Status: GOOD (  12.21  )
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

From: Youling Tang <tangyouling@kylinos.cn>

Add the pe_hdr->machine check to ensure that the kernel image is of the 64-bit
LoongArch architecture.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
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


