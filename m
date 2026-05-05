Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D57CD343A
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 00:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b+FOv1S5jZxTI8xiOq/TIFYAKVGB2GSKJ5eXMG7ksgc=; b=ijd61SRb5Zz/DS4zzsBRJ7Aihv
	CxYxcUarzl67Xzu0KfJKHQ+YscdMNKL3+TtjcK3DaL/nqg9iwZf9wxeZi7faWBYVBxdX9DDTpQkS2
	zc9PXAU5ez4uR6ML3RAweTB+2QhCSXW2uLPR95b1K6Hgxox8Tv91cPaOuHh5gChGRM2FtzLqyofMu
	6nnF+tFxeJk00do65X+YiVgI+0BMqDB+EwFRO/gS196WMdUySHJmB+MfmiQelfkbSlFzlasKszfUk
	WV8HtPWXpdk2GYWO4cjrYd8btdmo/XuTYh19ukvt9jnrMRfxX70Gwumi9cgdIr/nMmK5iXFqnzwJB
	S24AYKvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3dY-0000000EiSB-2lsS;
	Tue, 05 May 2026 00:27:44 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3dW-0000000EiR2-1HO6
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 00:27:43 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-83603145987so1050625b3a.2
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940861; x=1778545661; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+FOv1S5jZxTI8xiOq/TIFYAKVGB2GSKJ5eXMG7ksgc=;
        b=dXMgutA7RnGXNAQa+moPQhIvyTaKYLV4gQcEX4MnzeqjBcwrD0M/939wp9G30U4sIy
         VqPSF713jrASRS3E9u+/Wc2/v3gOKx1egeHuixbVj1ErLI2yhMq9yzqt1r2llFR4DlIg
         fUtDRXW2aNCHAmymDcm2HgG1FB1j6DcD19yCV+HynpEEh4YowqAW+KGjzX/zqIY4XidH
         t4Zypc+4tz09bJM0bP+r7MTrZ2EWA33cdqcSSbfoTrL0WM0K2CXvUMvyVh1PLccIpKsV
         Xdqo0HKtuXmGFIN8hwHePwaI+6VmRTE1Kv7B3MhRRLEsnvIfdjaxSYm3a2eTJgs2NX6F
         degQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940861; x=1778545661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+FOv1S5jZxTI8xiOq/TIFYAKVGB2GSKJ5eXMG7ksgc=;
        b=eLI1U9xgew+cLVOdxFPcMXSAAk0uPuCFxc8HCc1hu0dB/9wzfTybZcv+9OGgIPwVVQ
         b7kdgnwZzjspa4L3HmxkHE3RvD11yO4+DSVSqMaj0pT/5bAUd5tu+pBxREsYOb8BlJA+
         x4PwfATGkSC6nmP4mtgzJICJskIuN6e5YTYUj15UKy1eEIZAnOUuI1cfKYQu5s1lCPwF
         uilI0fDyIi/2zf3E2L/NlVvVWeQZrnXkzCu99wX1ACwNkEggG3WrryE2MLquklNwoXkx
         DYTMc/Ad8C7pJEHbqjkIQOGdpOrjxQiD/359O4uVe5NG9Z5BLvaVVf4rXPvu0wjbOQMS
         KtIw==
X-Forwarded-Encrypted: i=1; AFNElJ/i7L3nyxbmB4+A/29vyaSeHZxKvWdPI4wVhOxLhfoTKpnonUsT7Nv7ITni1zQttW3BS5DwJg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1+mTsIJm+KA9pJ1wQ7Mq/kcDgOnyrDpvU/ktg0gEKeHjjrHHA
	nMVPlZu7e4lbwP+KoutaNpsBZ++qx6Bhi/2Z5X2DtekL7S0lsjLAq9vXxMMGji2TK1mnqh9POjp
	m9Cx9uVqzsfdNMg==
X-Received: from pfnj5.prod.google.com ([2002:aa7:83c5:0:b0:82f:8a3b:87f0])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1f04:b0:836:5c3c:2051 with SMTP id d2e1a72fcca58-83923d96a31mr1009427b3a.23.1777940860319;
 Mon, 04 May 2026 17:27:40 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:34 +0000
In-Reply-To: <20260505002737.2213734-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260505002737.2213734-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-2-skhawaja@google.com>
Subject: [RFC PATCH 1/4] dma: Add DMA allocation preservation KHO ABI
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_172742_343029_00F501F0 
X-CRM114-Status: GOOD (  13.55  )
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

The DMA allocations can be backed by a variety of allocators. Add KHO
ABI for the preservation of contiguous allocations that are done through
dma-direct.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/kho/abi/dma_alloc.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/linux/kho/abi/dma_alloc.h

diff --git a/include/linux/kho/abi/dma_alloc.h b/include/linux/kho/abi/dma_alloc.h
new file mode 100644
index 000000000000..46e61db81abe
--- /dev/null
+++ b/include/linux/kho/abi/dma_alloc.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KHO_ABI_DMA_ALLOC_H
+#define _LINUX_KHO_ABI_DMA_ALLOC_H
+
+#include <linux/types.h>
+
+/**
+ * DOC: DMA Alloc ABI
+ *
+ * This header defines the structures used to serialize the state of DMA
+ * allocations, done by device driver, across a Live Update.
+ *
+ * Only DMA allocations done through dma-direct that are contiguous and
+ * allocated using alloc_page are supported.
+ */
+
+/**
+ * struct dma_alloc_ser - Serialized state of a single DMA allocation
+ * @page_phys: Physical address of the preserved pages
+ * @size: Size of the DMA allocation
+ * @force_decrypted: Whether the memory is force decrypted in previous kernel
+ */
+struct dma_alloc_ser {
+	u64 page_phys;
+	u64 size;
+	u8 force_decrypted;
+	u8 padding[7];
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_DMA_ALLOC_H */
-- 
2.54.0.545.g6539524ca2-goog


