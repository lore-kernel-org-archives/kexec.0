Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1639DCA0EC1
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/IhL/CIlLPj6jA+N2gUQ5Qd+JhoFqSryy5qQsBgiWqg=; b=etj7rxTioZQG8Nbm3K4pwjPXah
	7qt53hyhqlz/bkAjI9nLjLiBhtarTp6XjVtkljqGsdgESD2MOgbcX7lenyr6nY8NfKJHLpCIlHAQS
	hV9+Qa0RQeb7877rmgxxs4ynKjtU4R+r78FZRJKPENJXORAXzRijxhXMxw/lcgem2pQ1SxuOqBIHH
	hiehDwKf7AwiLqMDR1VwkZ+fjAUcdzx3RuYJ0x+034Dn+9PIW+enb7smC4NrM9XOPvlm9H/gMPscI
	S75oaLI6hsMuYb/uyRMmMso/ShxbmBb0PavRxR+oFOKP9fdx7CwwHQMGGdrDqerBKcnOzUggWMXwZ
	nT92sTmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukTqK-00000003e1G-1WLT;
	Fri, 08 Aug 2025 20:37:36 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukTXW-00000003bl2-24Ey
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 20:18:11 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4b0a13bb0b7so28389661cf.2
        for <kexec@lists.infradead.org>; Fri, 08 Aug 2025 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684289; x=1755289089; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IhL/CIlLPj6jA+N2gUQ5Qd+JhoFqSryy5qQsBgiWqg=;
        b=Kdqt2aVHz9I8O850Pv826A7qBDkW5zRRyBIax0QamTSU5edSVGqI28vw4eBBz/CMta
         9zjuuYImQxTF5kv+7Vfoy3tXL/EvehipD6RWY9NYNrmbUN7G6IDIJjoNgzAQ4Q6ZoS59
         4AUqENXu8I9sfPVO9hY596WLEDlH2hLzYZnqfgZ4hQs2ghgV8rTsqpiMlhnF+f2oCoB9
         GulsaZCdlNcaWtM1APf1Qhbq+JQFtSCgb4Xw8j6Zeh2Ey/Omj9W+wACyYHqxjWWUqFZ+
         t5d6VDO2iA1yAPsrZ/AEQpLpYte7tCZdmeqOC6BGkm/M0U+6/DtRTKLFWTjpGH8MOGZ5
         p7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684289; x=1755289089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IhL/CIlLPj6jA+N2gUQ5Qd+JhoFqSryy5qQsBgiWqg=;
        b=pI1nX7DjNT+Zwol+TCVY2q3n+9KCGq2i0dkJTwmiin2XEJah2n65cWX8oBlGG3WYsk
         WOcX8g+DrA6i6lWzEdzrCqK6THOtp64O+TOmHzGQ1qztyE/P9LIm1TBi84VfhywD4Gg2
         AdLVLvs9l2hGX1a0GJZhYr3o4qBZvqs6iTmemBYBj1dTPHNj5PIscBz4c8C5igo7eUu1
         dfKdfIhNiF3TTOS/abQrfafhPc0fUx9rW8v7OJkIvyyhrKinBPNEryHvVR4mb9cY5QQG
         Ws03BYmPWaFEjCoNYF83EvjZHcNSTlwfYClePamaq4OvVrGmWIRwwKT3oSqDeX5k06PW
         IO1g==
X-Forwarded-Encrypted: i=1; AJvYcCWKOWom+fSEsuESQ/pNfL3a+f5FV4/jm5HM7+GsxoOyTwLdTD7usmfki6OGSzDo5DeGpIVhUg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJ/TU9u7ORkmY3oNQ2oE0YO3VDHcyE7FnpQtVW0fa1br/XGJPn
	FjsXA9tB33ClvUPqRpwpL592SJcHnqDLsd3Bl8nUNNilnNXxbqUM17uCemfehIVM1Fs=
X-Gm-Gg: ASbGncvhOZU+mqkJJSuma5H7FoDfXkqZQXxAPUTgyzh9KhBZeltIVsvfC348x1ggFDK
	1L7gaWcUxz3EcfwmaIoAc3vCFk/AhSBrxP/tcx0p/frcB2XB8D+YfB7cAn2ph6hZ61wVVGdPwWs
	u0FFeNN3e/wwbfCX35EIyYKM5k2z4b6gW/IzYqHt3AXMGk6y83ftE+ccgbr7FwfyXCsvsLHvr6k
	3f5pPVwUDHbhL7EMIfqG0JuxtviuDiRWPFL7TUNoNVx1BHrhvbueP4ws6aYrTlNwD/3isAcBd1b
	fSHRuIQsGmq0Ji2c98YqkpAgmQL6clL1fSj/CRUZ2bKYncCQK57yq5iDxOPk36cLcxdHEuKxiyA
	PwiXWxtTsK9CQK/vvwxqTFbzWpW9FXmDgv0WAT21Y0yt3KpUSAbgMiPXoOvu/TB+oiaRTgnVsyM
	Tsi5kbM2zdofyd
X-Google-Smtp-Source: AGHT+IGD0W3/4r3I4y7shiD9XqPrTR2Wufmh8nPmwN+kRpU8+fKQFyJQNnxe7IT04T5XIjK11kh55A==
X-Received: by 2002:a05:622a:293:b0:4b0:74ac:db48 with SMTP id d75a77b69052e-4b0aed032eamr52138771cf.5.1754684289383;
        Fri, 08 Aug 2025 13:18:09 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07c80ddbbsm59490131cf.57.2025.08.08.13.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:18:08 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/3] kho: init new_physxa->phys_bits to fix lockdep
Date: Fri,  8 Aug 2025 20:18:02 +0000
Message-ID: <20250808201804.772010-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250808201804.772010-1-pasha.tatashin@soleen.com>
References: <20250808201804.772010-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_131810_530375_288BD404 
X-CRM114-Status: GOOD (  12.39  )
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/kexec_handover.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e49743ae52c5..65145972d6d6 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -144,14 +144,34 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
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
+		int err;
+
+		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
+		if (!new_physxa)
+			return -ENOMEM;
+
+		xa_init(&new_physxa->phys_bits);
+		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
+				    GFP_KERNEL);
+
+		err = xa_err(physxa);
+		if (err || physxa) {
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+
+			if (err)
+				return err;
+		} else {
+			physxa = new_physxa;
+		}
+	}
 
 	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
 				sizeof(*bits));
-- 
2.50.1.703.g449372360f-goog


