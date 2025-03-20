Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5425DC35FFC
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 02:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ilsQeNiRJnAcOliWxyBDLHi9DId7Z2YXJm9lAmFy6DI=; b=E/a6ym77DUvUDrIGYiyf8E2LeJ
	b5bhLyheUH9jSHCjjLzRqf2J0uw//ikCFcTuNHifGqWIGVxEn7t7FRf1sKfE405SeQEeAuORP7+Xx
	fnpryn35u3m3LvQ+BE5/PVE7T1lZT2iSsaWwZQRMJXxDOobk/l2SUMLnT1a/6wHW6GFQlFr+fbUAO
	chbJnehNPO6A/2iHW4VG8aZHkuQ3NAj7gK8Q10MzL3Z5CeLBKD9o4lAfbekw9FYF0+7OJC8Ir0eDi
	BrW+sV6K4XBCXr9X9G0ySVYxjm78SxegW/QRNVBi64LhgfAjVPXbzulcF4n6/bpKPvw5hvHgh3P7+
	zOOLvOPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv5Dj-0000000Amf8-2usl;
	Thu, 20 Mar 2025 02:01:19 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58e-0000000AkJh-2JvW
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:05 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so447100a91.1
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435763; x=1743040563; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilsQeNiRJnAcOliWxyBDLHi9DId7Z2YXJm9lAmFy6DI=;
        b=jlwA9Nfc60IaXYizbVB3sDRygeOe1l6K2q8sj6rT8I1zO5qPstiZwINuL77WA752dG
         WCQTjVk8b3Lwsw7w5juaHz8YEDC5ApcK7Ekh6qQjvkghzxKDcInsapYJQRjUuN5iCbQE
         P3QwWf16HjulEfV9SBveLCNHR2kROcqh88uGp5ziPZPt37RSjbD4go+j+2hhKUkVkIsD
         rMlZe1EuL8gHCXpysorpkDBhS6uNhSSYYfq5wVjbPy9esA3bSTCqHf4v0PCqjipvjz22
         Ei0Ol2ORn16tGdAzPRtUwGAbqhZN7jURqgySk8ot9SLoRQ+oH4WS1MzuKOo7v7NaGhKo
         foww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435763; x=1743040563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilsQeNiRJnAcOliWxyBDLHi9DId7Z2YXJm9lAmFy6DI=;
        b=sA9bHbu4/r0hrVAvlx/ieR30c7cfMH0UsB04VMzxs1Yn+SNMUAD/YvlAdy7x36VDTi
         ULZupqHKlGN9/+yiBdbygSjNG0zPDcpuksCv/ideWBoWnGCtEF11n+H3X3TowOwIWy4Q
         2kLVQY0aKEPtCVMPj3aK3ycNyPN6eozvOcqwKQRHsDpgEh9PXG7d8L1EUOZGz5AaycLc
         zM1HqeYpi4SXae2BzP/kQUbQjHzthAs+U/fx96LCHmRzZ/HpU4dEsYDla3PdfwCjAS/X
         GmuyaKYFsy/T5liHTK+X6m7Y7tO2EN1/TYaamGIiGfDgf1XeMuzIBOmhAO6Np9kSrYd5
         N3aA==
X-Forwarded-Encrypted: i=1; AJvYcCWHxvJYRBTvIYNww2DesHYm+6YjzasERuqfeimZUiEPTjAeSWo593LDIyAJN/lIp6o81AXqVg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwXtyLsfw4usJSLOG9vz6MjBS8j+8PFNRP7ODanp/VPwgNPa+Hh
	9Pe0WpbSyXa7N1SAwCImv6Ru0Kri+wRcfETcJJopUr8C7xhGaLQFyDEZiCvt+exzF7Ei3hU+ySc
	22gG1K1If6FaBTqhYuQ==
X-Google-Smtp-Source: AGHT+IHLp0TM25605mfB4iWKOjzImtCB+u2sC+62Tcd+2pSs/X0minmUzplavXz6x1NXqtyXk3N9lUuGrg30J6Xe
X-Received: from pgbdo13.prod.google.com ([2002:a05:6a02:e8d:b0:af2:8474:f67e])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:594:b0:1f5:7b6f:f8e8 with SMTP id adf61e73a8af0-1fbeae9141bmr8613381637.6.1742435763548;
 Wed, 19 Mar 2025 18:56:03 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:37 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-3-changyuanl@google.com>
Subject: [PATCH v5 02/16] mm/mm_init: rename init_reserved_page to init_deferred_page
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_185604_604445_58F01D93 
X-CRM114-Status: GOOD (  10.99  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
function performs initialization of a struct page that would have been
deferred normally.

Rename it to init_deferred_page() to better reflect what the function does.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2630cc30147e..c4b425125bad 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -705,7 +705,7 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static void __meminit init_reserved_page(unsigned long pfn, int nid)
+static void __meminit init_deferred_page(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
 	int zid;
@@ -739,7 +739,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static inline void init_reserved_page(unsigned long pfn, int nid)
+static inline void init_deferred_page(unsigned long pfn, int nid)
 {
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
@@ -760,7 +760,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_reserved_page(start_pfn, nid);
+			init_deferred_page(start_pfn, nid);
 
 			/*
 			 * no need for atomic set_bit because the struct
-- 
2.48.1.711.g2feabab25a-goog


