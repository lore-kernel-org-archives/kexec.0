Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCEACA0EDC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 05:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vujQZVf5TyhJiS/dKOstIc0xO8kGAvT4jnpNPRHbLQw=; b=LcFa69bGD1p4rnhTFaBfwUSpIL
	znT/0nBRp+YwtXgbiGjXmkPmGBl9bpjBDy6KElQr24itWZBJH8LtLlrkIWNx2P3jyfJeZlbeupGNP
	ItI5e2pdwUSlm9W90ZDrUMQPuqINsswu807tevBE+4ATke5x3gulr4uAftUF9fK7u5QlUTpjFNdEF
	ruqaNLshePgkvIDNQSIIuztb6hZcEkE4u/EpqDVjTReQQUDTm2wimOyeMCytKGmf9Bi3KmRpxu+VZ
	ZW4Pdbc4GYlVMJ3hA2KE3tU4bWgEJzWYwGfdTCH3z5bOnxeskNOkkB42P+3T6q+p7LBWj5K2HOVvw
	fzUknzpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobqB-0000000CSf5-2w9v;
	Wed, 20 Aug 2025 05:58:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobpi-0000000CSZe-4AHt
	for kexec@bombadil.infradead.org;
	Wed, 20 Aug 2025 05:58:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vujQZVf5TyhJiS/dKOstIc0xO8kGAvT4jnpNPRHbLQw=; b=DbDbAHp2jbXbDFjw19L7BVJ77U
	fDqj4a0ywheadc+xbcDzcUh2GatENZHgneQq6N6bAKeUTUfTCRf+4NlqdMO7BRgbvFo+D1tA4KeA2
	FvBNou2tKbwjcicR4WOKuS+JjBr10KojUU4cuGJShClK6o24pPtppG93UgfJ3cvkKbe9jd32c9cxK
	RCWu/UdS1Ji9cfdZK2U8mEG3LmWU3ECGduOazmuwkx2rlrhb/EXDkrCdB0M5lSOPNhG3Z9484vWdK
	B1PiA6wKu2GdhITysiijjpjZCbhLtvY2M09TYBZMRT2t1eMidCbAP98I3Q8Yh106oZjJQI24RbMAA
	Fvng+nbg==;
Received: from out-180.mta1.migadu.com ([2001:41d0:203:375::b4])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobpV-00000000Bkr-0g3z
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 05:58:00 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755669450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vujQZVf5TyhJiS/dKOstIc0xO8kGAvT4jnpNPRHbLQw=;
	b=wYgzfL6AM7+kHoEZULtwgFeqaqqIJ3ROtOncqgOKt5FEDatvgWSHyc9I3GQqMyEwnCGWYv
	tpqmf262KxbSoZyQtg/8uqUnR8dfgdr0uV0MpBeMMG557tshJt8eiSk4g/9fY5Q9SL3mvE
	iEZXl7UiF1GWhS9+RotvutUcMKPJtS4=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 1/5] LoongArch: Add struct loongarch_image_header for kernel image
Date: Wed, 20 Aug 2025 13:56:56 +0800
Message-Id: <20250820055700.24344-2-youling.tang@linux.dev>
In-Reply-To: <20250820055700.24344-1-youling.tang@linux.dev>
References: <20250820055700.24344-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_065749_320649_445F45AE 
X-CRM114-Status: GOOD (  10.60  )
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

Define a dedicated image header structure for LoongArch architecture to
standardize kernel loading in bootloaders (primarily for kexec_file).

This header includes critical metadata such as PE signature, entry points,
image size and load address offset, etc.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/include/asm/image.h | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 arch/loongarch/include/asm/image.h

diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
new file mode 100644
index 000000000000..1f090736e71d
--- /dev/null
+++ b/arch/loongarch/include/asm/image.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * LoongArch binary image header.
+ *
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ *
+ * Most code is derived from LoongArch port of kexec-tools
+ */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+#ifndef __ASSEMBLY__
+
+/**
+ * struct loongarch_image_header
+ *
+ * @pe_sig: Optional PE format 'MZ' signature.
+ * @reserved_1: Reserved.
+ * @kernel_entry: Kernel image entry pointer.
+ * @image_size: An estimated size of the memory image size in LSB byte order.
+ * @text_offset: The image load offset in LSB byte order.
+ * @reserved_2: Reserved.
+ * @reserved_3: Reserved.
+ * @pe_header: Optional offset to a PE format header.
+ **/
+
+struct loongarch_image_header {
+	uint8_t pe_sig[2];
+	uint16_t reserved_1[3];
+	uint64_t kernel_entry;
+	uint64_t image_size;
+	uint64_t text_offset;
+	uint64_t reserved_2[3];
+	uint32_t reserved_3;
+	uint32_t pe_header;
+};
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_IMAGE_H */
-- 
2.43.0


