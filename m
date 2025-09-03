Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31139CA1011
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 03:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9B6OfEVdBH7wSZaIebpK16txAhX6ctZF4LG8My4lKI0=; b=LYGzHEq23gudu9i5HfDMAGgdgz
	ne21bT9n8QvfP8yybH9BTI6U7rZ/VOo5Xjk8KohHjSqEEN2xCf9n6rIJEczbVfoxy1oG8m8U1dUYy
	ZE8uiTFtCv3JbipPideG5wyfl/V56Iw+Kb6Gr+in4CeooVLhzcxofqg5IB76opCdvBSvmfNFz0iF3
	OYXP5tJrVvyzfThsrAOTjPBOSPqb5zWiIuHwZI+8exuhW2ldnJ5QCdEoJVOGMhC1bBpKqPiVef5XG
	8uB16BtLQXcefpxrFf2uYhqbg6x345U8g2KDTvHaVrMzI8qGpsWjTnAnJUZ+elcY/5IkKLfsUXN+n
	nRBz9XOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlP-00000003QzK-22qp;
	Wed, 03 Sep 2025 03:02:23 +0000
Received: from out-185.mta0.migadu.com ([2001:41d0:1004:224b::b9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlK-00000003Qva-3L3F
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 03:02:20 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B6OfEVdBH7wSZaIebpK16txAhX6ctZF4LG8My4lKI0=;
	b=G7jOzflNI/vNR76mNjnQLgVxECxcx7TMgYOD0x3Tw8+UYC/6d0kHe2p0kLEJMe5tQd0wv6
	klmRVAZm5+zdcvBSJO9B5TVMqtsF95dpyCvCHBvz7NvnCfTO+FJ2QaG8ai7Jph2EIVg5cm
	GNadLNnoX5YawEMWVjJIHqEEF+pfDPU=
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
Subject: [PATCH v4 1/7] LoongArch: Add struct loongarch_image_header for kernel image
Date: Wed,  3 Sep 2025 11:00:54 +0800
Message-Id: <20250903030100.196744-2-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
References: <20250903030100.196744-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_200218_973028_F2AAB552 
X-CRM114-Status: GOOD (  10.59  )
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
 arch/loongarch/include/asm/image.h | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 arch/loongarch/include/asm/image.h

diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
new file mode 100644
index 000000000000..ff539711c9ea
--- /dev/null
+++ b/arch/loongarch/include/asm/image.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * LoongArch binary image header for EFI(PE/COFF) format.
+ *
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+#ifndef __ASSEMBLER__
+
+/**
+ * struct loongarch_image_header
+ *
+ * @dos_sig: Optional PE format 'MZ' signature.
+ * @padding_1: Reserved.
+ * @kernel_entry: Kernel image entry pointer.
+ * @kernel_asize: An estimated size of the memory image size in LSB byte order.
+ * @text_offset: The image load offset in LSB byte order.
+ * @padding_2: Reserved.
+ * @pe_header: Optional offset to a PE format header.
+ **/
+
+struct loongarch_image_header {
+	uint8_t dos_sig[2];
+	uint16_t padding_1[3];
+	uint64_t kernel_entry;
+	uint64_t kernel_asize;
+	uint64_t text_offset;
+	uint32_t padding_2[7];
+	uint32_t pe_header;
+};
+
+#endif /* __ASSEMBLER__ */
+#endif /* __ASM_IMAGE_H */
-- 
2.43.0


