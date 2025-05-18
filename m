Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E24C54799
	for <kexec@archiver.kernel.org>; Sun, 18 May 2025 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jw2dpSffr8RX9goKmQzU5QzfxiCiCR6iGea0YOCC1M4=; b=Hz+p16z3An7YJehCjgIYRDlWyB
	W9ykLCKv1HIbL0LEn/IKSTu3iFXBxMN13SXK+/yRwXKs+lUnugncpKCVLCgAGkpa/0mqcOZUd3TVX
	ChJzpZZ1CkSqo2Zes6yPku6L6xrSrViDF538ZsURGdgkz4f02zG6DjHVxEY9ySJ8hHmAjd4Fx/bBn
	i4UIZv0l+TJkx7ZRy8VfdcVfoABItrp/w9VWipIrrkzJJ5fUD8ARljveG88mztARRIh/2+RzFw3JS
	SfBbSIG+dZcJH4ChKy3ZTGcTDIPrS/X2SgzogEwWH28wj7EYfYevIbphMG2aB78qgfXaxWnhUBB5J
	ZayOEd7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGevJ-00000007BXY-3zdc;
	Sun, 18 May 2025 14:23:29 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGevG-00000007BW3-3ZF4
	for kexec@lists.infradead.org;
	Sun, 18 May 2025 14:23:27 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-231e76f6eafso15785445ad.0
        for <kexec@lists.infradead.org>; Sun, 18 May 2025 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747578205; x=1748183005; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jw2dpSffr8RX9goKmQzU5QzfxiCiCR6iGea0YOCC1M4=;
        b=d7VDy7fQufSCSfN82SzaBPYWkY1euFdclBHVaOwTzTvrGHIQABzFbKiMiOwv7V2oAj
         t6U7STeWk4F44L068jWQG47AUEsg8BA/f3l+YCs3JdLhPTKquTN4pcDitTh3rvAway2B
         3UDn6LE1nFCDdO6MYv2OOmu00jD7XlA6a9rTcgWa4Nyl5SOHQlm09vcorq+7s95ihFx5
         Lu39EdN1va+W/F2BeBVdPYNkG8f2iX+CIvDQTchSk90un7BfiNAwwfcRINJh0G6YDtiz
         qUhpav/gwi5DsJM6VqtxnWJmvZ8V9m6tm6Xo2rx8T1JyxXE5lgZZcdCslgnX6Hvu2eIE
         hynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747578205; x=1748183005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jw2dpSffr8RX9goKmQzU5QzfxiCiCR6iGea0YOCC1M4=;
        b=RHUsPTXX2FSyu8F300apWyhyRtgPvdqCKgmsczoVbSJfpDGJCHiMlMZjW4/LJ1RmvY
         q3W8VIXIpbDcGcsScDMj1PAIiB7iFE9etSodUIhrBlK5F1goCu0C13Y0WI9irGvyWTHc
         ZuN9pXCPddI+0To4mPvkLl5a3tkEZwGMMHIIlZxAY7vwejRGuAEsqeFVqSHPgKZfAXgs
         2JalQaWJF2HkvnAwGOk6SoSMPb2AORtl+03NgpNNYmgKNKwCIZL6mnS3lg1N6Rg9KQLh
         29O6ZhhnYgOb+aoQ5MiuX2gvpS4kaGr6ZYC9hrJI0iBFH+h3IJZCmv/aCb4LQ2N0TBHv
         +kDw==
X-Forwarded-Encrypted: i=1; AJvYcCVlXSimPqLR0wcML7x1t6OrAk75k47S7kULKwV2QSwh7sM0s/FJ21r74JH0jDp2IQY6NNFM1g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRjp1oGFUIV1aFp9/lfQJmVzA4a+J7Xk7y7VQ7d8SLikroKuIj
	gsU5C0i/MdezoJKAB3N3964V13OIYGCRciLlrZHD8o1chm9F0GEQG5TpZnmRpc6yKjGgct2W9Sa
	KFj/yNfVEn1e3wHXa9mAxNg==
X-Google-Smtp-Source: AGHT+IGzKyPFMK6YyK4TGGsc6lr8b7/MNxcwKiEDM7oMNN3Ku0K0uTb4I+HdKbUzhe8ilI6IRXoO+yKkaMNPsrkp
X-Received: from plbp13.prod.google.com ([2002:a17:903:174d:b0:232:1c72:1f78])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ecd2:b0:224:2384:5b40 with SMTP id d9443c01a7336-231de31b3dbmr148737165ad.24.1747578205410;
 Sun, 18 May 2025 07:23:25 -0700 (PDT)
Date: Sun, 18 May 2025 07:23:15 -0700
In-Reply-To: <20250518142315.241670-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250518142315.241670-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250518142315.241670-3-changyuanl@google.com>
Subject: [PATCH 2/2] KHO: init new_physxa->phys_bits to fix lockdep
From: Changyuan Lyu <changyuanl@google.com>
To: rppt@kernel.org, akpm@linux-foundation.org
Cc: graf@amazon.com, bhe@redhat.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, chrisl@kernel.org, 
	pasha.tatashin@soleen.com, jasonmiu@google.com, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_072326_888844_0404CF10 
X-CRM114-Status: GOOD (  11.86  )
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

From: Pasha Tatashin <pasha.tatashin@soleen.com>

Lockdep shows the following warning:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.

[<ffffffff810133a6>] dump_stack_lvl+0x66/0xa0
[<ffffffff8136012c>] assign_lock_key+0x10c/0x120
[<ffffffff81358bb4>] register_lock_class+0xf4/0x2f0
[<ffffffff813597ff>] __lock_acquire+0x7f/0x2c40
[<ffffffff81360cb0>] ? __pfx_hlock_conflict+0x10/0x10
[<ffffffff811707be>] ? native_flush_tlb_global+0x8e/0xa0
[<ffffffff8117096e>] ? __flush_tlb_all+0x4e/0xa0
[<ffffffff81172fc2>] ? __kernel_map_pages+0x112/0x140
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff81359556>] lock_acquire+0xe6/0x280
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff8100b9e0>] _raw_spin_lock+0x30/0x40
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff813ec327>] xa_load_or_alloc+0x67/0xe0
[<ffffffff813eb4c0>] kho_preserve_folio+0x90/0x100
[<ffffffff813ebb7f>] __kho_finalize+0xcf/0x400
[<ffffffff813ebef4>] kho_finalize+0x34/0x70

This is becase xa has its own lock, that is not initialized in
xa_load_or_alloc.

Modifiy __kho_preserve_order(), to properly call
xa_init(&new_physxa->phys_bits);

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 69b953551677..f0ac6a9170f8 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 				unsigned int order)
 {
 	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa;
+	struct kho_mem_phys *physxa, *new_physxa;
 	const unsigned long pfn_high = pfn >> order;

 	might_sleep();

-	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
-	if (IS_ERR(physxa))
-		return PTR_ERR(physxa);
+	physxa = xa_load(&track->orders, order);
+	if (!physxa) {
+		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
+		if (!new_physxa)
+			return -ENOMEM;
+
+		xa_init(&new_physxa->phys_bits);
+		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
+				    GFP_KERNEL);
+		if (xa_is_err(physxa)) {
+			int err_ret = xa_err(physxa);
+
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+
+			return err_ret;
+		}
+		if (physxa) {
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+		} else {
+			physxa = new_physxa;
+		}
+	}

 	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
 				sizeof(*bits));
--
2.49.0.1101.gccaa498523-goog

