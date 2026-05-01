Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5FFFF885A
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D3bCYUylpNTAuWyS15iXLK7eGG+AcPbkT8lStAYKXTI=; b=1z9kIEJrvbyZVs/qneAf0e/8+p
	Jeb+3VuVntKI4nIZPhLc5SDef/dW0a/AEkapUkwiqluwm6aWXsi5U2SP67cvmnRPup92K93jAfMqm
	icDfKJgUBJf+mmtURxvYow0Y66CCzSw4H83xfVEnNLvB3L7UZmXfaSe3+XsyegIb1+34Dm6WgiRlR
	mk/axGi+nj+wC3EH6VxMY0X9MOzRn7pACjtEo9G9kTDJQYuP7hAR90+yQyNXHAJtjrzTihr+Fyjbf
	gFbh5RLrrSIyLIEDU9QNxcE1FxikaCnAxsrJQ5Y66HlRn6bMQncRIzwulwU9HU3MzRVlBUP62y90v
	1w5uNi+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkV3-00000006YfZ-1kIt;
	Fri, 01 May 2026 09:49:33 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkV1-00000006Yet-12wc
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 09:49:32 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso1033248b3a.3
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777628970; x=1778233770; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3bCYUylpNTAuWyS15iXLK7eGG+AcPbkT8lStAYKXTI=;
        b=Ua6ovoFQBUt332yaBQBX5jQXICCL0SBk56aDk/nQ5B/seJSBccxK55/DXZrDWp+8pX
         YaXDNnsWW2pCwsOkEfHxwARnKOPRZkjDWWzFt0tsc9zQzQcGivlLe33WaIFUnBxnDfEi
         +7xF3JarjmFw4UiL6YbH4lWMTwiFm32ZQkFk3Y/uET9+sxNeYwMzHwT4SNQ9E+9tOXRD
         0oX3thyEOlqEC1Z9TtL6IkeYxWZ9DWuKwp+EHIGy5FYw9t2+p4G8RhvixVGSW37D2ZA9
         qezJdaLTo3gQrxrHCRSXhCHnOpD40HfEGQgDnLdtQTucUwBXl+l0gr9t8/TatzLowdTw
         Zcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777628970; x=1778233770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3bCYUylpNTAuWyS15iXLK7eGG+AcPbkT8lStAYKXTI=;
        b=CuByh7euR6QKftPUxjd63eqIMUz+yhrtRdP4ggPpH3daPjgXJ7PB3KO+hgo1cz7EI2
         XQtLwjD01r6cliopogTPC8jQVTBOAqlH9t9f+7tQofSmPK/1DsnCa4AVKoU8OjCq2bF3
         FWWJ77EE/Q2HzOgP2xkcILyAGPczUTCks58ZuqfAU118Pdz8y0+srXXI8igAjMuwvoUD
         Ui5tSMoHwfpue7URomyNIocPibwdI/cASzeTb35JihcQIL7m3Goqyxv1O3fJUYIiRB7y
         6G+d4Mr8fzKczC38EmUuxyE25Bz2XUH2Mv6GURKgKns9b7qOfAGFxI7sVkowEYfhNeYY
         4GRw==
X-Forwarded-Encrypted: i=1; AFNElJ/MfMJ7j/fb8XzKLKKSTL8+l1OP2hCe9dEIlf/VKfBnfvH7A/+nA/x3YcBp67B2/No5fV/b5A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+iNgszo6UIYgVR+clzXdJiduRHT3xSBpVxyo+QVlalt1pzuFa
	UKZ9iwbjtD9YaP9YuyETx38KcZxbgqod7P3Om/vevnoHqCZG2lX2Libf
X-Gm-Gg: AeBDietgzDsxD7w8+9gaGr1YxEQumZUqL/J4A/pGi4PYCvvHCYtlgfy6WPq8xrFpgFM
	Tsq0UrGXGdXHM7MVB9lh9ngoA5jWHMEEm1v7BWpuaJDPL+e62yuheGY8zOwDzvqGSyR94bSsiU1
	U3+7t6H/IAN5cJKK3VVrElK41HR3qFo1PyxTUVHQz1+ZOR4/BEe0HiUn+pWqbM0EwiICc0rAZQs
	2dLTcaOkMjj3HzSwNxIncfV2hOd4V9IAthoWHwC/e3T8/UU9n3YfdbxebSaOMuAvHU5sRJh9WgA
	4xgS5IZbP/Er4fKCoU7njGUwqv9Cov3w697tXx5a8HtwJb1n8hAtcrgfPDgjjfED2eM33DDlD82
	H2tBRw1W53av91xJ/OzWyV2RWJpkSnpWBPJrDX4DBXEy/ekmESpKjy+WmC11Z0oVrCylt05onId
	t0+4ipTy562rXueITL8pzspfnplsWY2mOG++v8Xg==
X-Received: by 2002:aa7:8886:0:b0:82f:9985:d4a1 with SMTP id d2e1a72fcca58-8351a58db50mr2518784b3a.24.1777628970155;
        Fri, 01 May 2026 02:49:30 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:eebe:247e:613c:24d7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582dd55sm2042729b3a.1.2026.05.01.02.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:49:29 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/5] kexec: handover: add helper to check preserved page ranges
Date: Fri,  1 May 2026 17:46:33 +0800
Message-ID: <20260501094637.38650-2-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_024931_291218_4B156641 
X-CRM114-Status: GOOD (  12.94  )
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

Signed-off-by: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
---
 include/linux/kexec_handover.h     |  6 +++++
 kernel/liveupdate/kexec_handover.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..fb09943ab232 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -19,6 +19,7 @@ struct page;
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 bool is_kho_boot(void);
+bool kho_is_preserved(phys_addr_t phys, unsigned long nr_pages);
 
 int kho_preserve_folio(struct folio *folio);
 void kho_unpreserve_folio(struct folio *folio);
@@ -51,6 +52,11 @@ static inline bool is_kho_boot(void)
 	return false;
 }
 
+static inline bool kho_is_preserved(phys_addr_t phys, unsigned long nr_pages)
+{
+	return false;
+}
+
 static inline int kho_preserve_folio(struct folio *folio)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 94762de1fe5f..fe9f11190705 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "KHO: " fmt
 
+#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/cma.h>
 #include <linux/kmemleak.h>
@@ -429,6 +430,40 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 	return page;
 }
 
+/**
+ * kho_is_preserved - Verify that a physical page range belongs to KHO.
+ * @phys: physical address of the first page in the range.
+ * @nr_pages: number of pages that the caller expects to access.
+ *
+ * Use this before phys_to_virt() when a physical address comes from restored
+ * metadata. It checks that @phys starts a KHO-preserved allocation large
+ * enough to cover @nr_pages.
+ *
+ * This only checks the KHO marker. It does not restore, free, or take
+ * ownership of the pages.
+ *
+ * Return: true if @phys starts a preserved KHO allocation large enough to cover
+ * @nr_pages, false otherwise.
+ */
+bool kho_is_preserved(phys_addr_t phys, unsigned long nr_pages)
+{
+	struct page *page;
+	union kho_page_info info;
+
+	if (!nr_pages || !IS_ALIGNED(phys, PAGE_SIZE))
+		return false;
+
+	page = pfn_to_online_page(PHYS_PFN(phys));
+	if (!page)
+		return false;
+
+	info.page_private = page->private;
+	if (info.magic != KHO_PAGE_MAGIC || info.order >= BITS_PER_LONG)
+		return false;
+
+	return nr_pages <= BIT(info.order);
+}
+
 /**
  * kho_restore_folio - recreates the folio from the preserved memory.
  * @phys: physical address of the folio.
-- 
2.53.0


