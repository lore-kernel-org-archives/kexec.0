Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50DCC44501
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1JfihMOdYGKLErlZtxkO4c74/sv22I0BBbL2ChDUSts=; b=imsMabCqTPooPIeGO+2uBn4ly6
	qq/nsLjqzTMueErQ4fr4KSPbnzga0MtPpLXxuWOTSTiSCrRl3CI8y19M2jv0Z8k6jSIZSCnHTZnnb
	MXyiGcFqv9TH71rsAGcjMRuADNUVAY8fUl7WF3ElBLVgDr8shFbfCsetQy7SlV4SRR6F0Rufy/c+6
	n3IXqD6uiAJiKqww0a/+Owr+vLqEEt8w2WWWHUtluZ1p4NnAopHoW0tV6OZvgePXbUSGKY2KqqCqR
	H79DtpnOvEmrvT3bYb1IwU6OOMHJp5NmkKgsGMbEeYknNP5JqObFvh5pTdQ+1E2qvHS+TqNpU/EaP
	BrFfxd1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0i-00000000cxM-0Ica;
	Wed, 08 Jul 2026 23:49:00 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0f-00000000cvn-2zsr
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:48:58 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-848544a8496so490058b3a.0
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554536; x=1784159336; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JfihMOdYGKLErlZtxkO4c74/sv22I0BBbL2ChDUSts=;
        b=HABUfhCgz9qXysdILH6pcobNq0q44OR8vc8As9ugwMFtD/MZeyPapc4TIwvhV+hCAR
         Ucva61sbR8ch6yn+V52LmK9tNPYcjYzGRhrxLh/HaJo4S34jlrMIop09jbeYZoiNAyuu
         0GdUuB7eJRgGZ3WJD8n4LfPvokDz2rJkYCWL6gI0Dd/83FioL4A6PgeQI3TygIs4oeah
         qmJB+CCR3COI5k/ybGPWH0NRWahm1JxZC2ZXbFUh1ozEfGZkWHNB1NzxXl6Qk9ndDw9V
         kGrGanwGh0tMlL/g2gcmYFft0JydZlw+E+jSmQr8nn61au6esYuFwqrfvHFqi+GVhkVr
         KvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554536; x=1784159336;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JfihMOdYGKLErlZtxkO4c74/sv22I0BBbL2ChDUSts=;
        b=JCzUBWe0NThgwjy6C6fY2QRV6PnzWpyUNkg1AuHHrjbPSU8GUlBXB5esKL+fh9gu6U
         OgjMSeJhI/yPrkC7aVg0+3Z/88PHaK7NGBQAJzKCtZMNwB6QTfwoX1IAEcbkaYraDCYT
         yzK2/LPqGV0ot9UPqfP79IhANTjlQij9/KShUhx6JNpKYEnI9K9Gbio2AD8JcxHwT8dc
         T5Wzh7nDCfoBbr05r+74OSzClyh5xazwIjbQPk0CborzHBdTPlbte4ivWdiL1xQlcV8s
         O/h+9l0TnJR6ktHwoNZC/2rp1UwBa+XQCjxEKaqq7ltVIQMcO8VNrpArbSQPwjtsO702
         QaUw==
X-Forwarded-Encrypted: i=1; AHgh+RpUEKXpuWaHZvafkXMSXi9gThz1AG+Ndq31oN55T8BAiCZp2PDUuXv3/ZeqoLnGR977584VSA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzo5qv7UhBZP2igZS2mxF/k117rQbWviHHkOu3+DZNKFVUPx09t
	dFdM4EzHF/sosdC0RZHhbJ0JcoQHc5MYubypEykmR0jNKiB2uRFPRpaKCpDqjIfQWxO6b9Y1plu
	gjuvXH/O3JUhvNA==
X-Received: from pgcc16.prod.google.com ([2002:a63:1c10:0:b0:c8b:2706:11a7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1144:b0:845:ec31:26cd with SMTP id d2e1a72fcca58-84843436d38mr4585247b3a.46.1783554535737;
 Wed, 08 Jul 2026 16:48:55 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:45 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-2-skhawaja@google.com>
Subject: [RFC PATCH v2 01/10] dma: Add DMA allocation preservation KHO ABI
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_164857_753108_D6A66A51 
X-CRM114-Status: GOOD (  14.35  )
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
 include/linux/kho/abi/dma_alloc.h | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/linux/kho/abi/dma_alloc.h

diff --git a/include/linux/kho/abi/dma_alloc.h b/include/linux/kho/abi/dma_alloc.h
new file mode 100644
index 000000000000..ae38cf1a1fc9
--- /dev/null
+++ b/include/linux/kho/abi/dma_alloc.h
@@ -0,0 +1,32 @@
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
+ * @attrs: DMA allocation attributes
+ * @force_decrypted: Whether the memory is force decrypted in previous kernel
+ */
+struct dma_alloc_ser {
+	u64 page_phys;
+	u64 size;
+	u64 attrs;
+	u8 force_decrypted;
+	u8 padding[7];
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_DMA_ALLOC_H */
-- 
2.55.0.795.g602f6c329a-goog


