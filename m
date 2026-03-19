Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FFA1091924
	for <kexec@archiver.kernel.org>; Thu, 19 Mar 2026 21:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=smcAMeBF3eFvC+OZUcjPasWlZlCzzD66XLXM7VGnv/E=; b=HodeWtPh+U4UWD7Kgkz3SyrZ2G
	1WSu+POaVLXolRZJwzAmESO1eQsrL0RT4AGr4HAZk8yeVtIK9+uyOgF6K9LClIWLk6KRP1Rgeyp86
	0Jwp6/a+Wx2cE3dtnNQ3+IG3FYZXf7pizSWnRWUroMT1/TYlR69od/3ePZbfQ5GpjlT8yuk4sd6uT
	b9/Q/GkW+PbgsjKKFWAmoPULH01qfOwColjaWCIk+PfoO0J2prW8GQgbwOivVyWGby3I8R4+0j271
	hLuOD6H/lJXLrf+wueH9+k8k0MVOdPTroDllsgUaDrokfZ6MIf2DrAKDtIZnE9ZAh32/26DntUlAu
	NnBmkEIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3KZH-0000000BZZM-3ZRZ;
	Thu, 19 Mar 2026 21:06:11 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3KZF-0000000BZZ0-1ZCN
	for kexec@lists.infradead.org;
	Thu, 19 Mar 2026 21:06:10 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-4836abfc742so13183595e9.0
        for <kexec@lists.infradead.org>; Thu, 19 Mar 2026 14:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773954366; x=1774559166; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=smcAMeBF3eFvC+OZUcjPasWlZlCzzD66XLXM7VGnv/E=;
        b=BhlMCm4uWjAg7XhgrpeMlJGDEr82fY6FnyLC9Z7pODGCE2JRQywRH7hyORrJYFsJ5h
         PfaMe8nIf+4gq+CdxbST3NWP5f0a7ZokeRwLHz2ryiWU/wK6nEJSd+2LN5mLGPPFNLh8
         esAC8Wlarx79jywkM5EwOR6N0YtmtQgTHAiQBsoBrq/X68XyiTdcMp1odxlxWdkSCJ0F
         gnw+K7OYT/nEkdu1G/ThKrCcxhtz86VVzVxpObUr+9j/2BSGljVufRHFieGKt57WC1yO
         5xSrhpY0kuAwjLYSw/ln4s4I3CE84hN7OvECQT8pzKl/j4KY3V+Oa0XSI0bn8jc3m8mS
         zaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773954366; x=1774559166;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smcAMeBF3eFvC+OZUcjPasWlZlCzzD66XLXM7VGnv/E=;
        b=S8Sqknad+Qgxc1CqH47pxGW+vQbWpsLmctDCdDPFQw4Qo2bQgaOGgTEcFH9nuCfHKm
         lpEugETvCpC5YTH5jA8yBnE/MLhr6DTGYm7oIXJqEUs5UtcGef5lWsm8y/jooh+QZu0u
         Z7AjgcWIxM9sHw/g3VI+e5nqdT5FAmk5UVaSYMUW4B46yItHMANVrXAn8ghLrzxneUyY
         aX3F+3s4F13qqcJIc7jrkRYMwm0m0KpUpemD8mqnf3NfQW04DUsIDcM8rW+SXsFjAkAo
         ZJLNcPKa9merFOszMc1EqJIi6KtZXWjRuhsg957KWnkdprEuOFGIVW+O46HLAnP/gey9
         WUCw==
X-Forwarded-Encrypted: i=1; AJvYcCWyh1acYVfNbm9KmutrewNQusAyh8nGtJmqTBH9zaptYUrRw48gQKJcSxbRNDcrCQazLWYTEA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz67ZKnQL6m6hkxfNETZyDxkm3Y4wND+txcDqAOC+FiNzqN6Vhs
	Ll0XptSXNWO413Oumst0ODUBXd7GjOftQ6BjjhNZYlVpIlgCw4cLDn+u3DCY4ySIwUwF82B6xes
	1zw==
X-Received: from wmjk5.prod.google.com ([2002:a7b:c305:0:b0:485:2e9a:31b4])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:468b:b0:477:54f9:6ac2
 with SMTP id 5b1f17b1804b1-486feb5f9c1mr10150515e9.0.1773954366292; Thu, 19
 Mar 2026 14:06:06 -0700 (PDT)
Date: Thu, 19 Mar 2026 22:03:53 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260319210528.1694513-2-elver@google.com>
Subject: [PATCH v2] kho: use checked arithmetic in deserialize_bitmap()
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_140609_428942_BB9A385B 
X-CRM114-Status: GOOD (  12.53  )
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

The function deserialize_bitmap() calculates the reservation size using:

    int sz = 1 << (order + PAGE_SHIFT);

If a corrupted KHO image provides an order >= 20 (on systems with 4KB
pages), the shift amount becomes >= 32, which overflows the 32-bit
integer. This results in a zero-size memory reservation.

Furthermore, the physical address calculation:

    phys_addr_t phys = elm->phys_start + (bit << (order + PAGE_SHIFT));

can also overflow and wrap around if the order is large. This allows a
corrupt KHO image to cause out-of-bounds updates to page->private of
arbitrary physical pages during early boot.

Fix this by changing 'sz' to 'unsigned long' and using checked add and
shift to safely calculate the shift amount, size, and physical address,
skipping malformed chunks. This allows preserving memory with an order
larger than MAX_PAGE_ORDER.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Switch to unsigned long and use checked shift and add (Mike).

v1: https://lore.kernel.org/all/20260214010013.3027519-1-elver@google.com/
---
 kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index cc68a3692905..0d8417dcd3ff 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -19,6 +19,7 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
+#include <linux/overflow.h>
 #include <linux/page-isolation.h>
 #include <linux/unaligned.h>
 #include <linux/vmalloc.h>
@@ -461,15 +462,29 @@ static void __init deserialize_bitmap(unsigned int order,
 				      struct khoser_mem_bitmap_ptr *elm)
 {
 	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
+	unsigned int shift;
 	unsigned long bit;
+	unsigned long sz;
+
+	if (check_add_overflow(order, PAGE_SHIFT, &shift) ||
+	    check_shl_overflow(1UL, shift, &sz)) {
+		pr_warn("invalid order %u for preserved bitmap\n", order);
+		return;
+	}
 
 	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
-		int sz = 1 << (order + PAGE_SHIFT);
-		phys_addr_t phys =
-			elm->phys_start + (bit << (order + PAGE_SHIFT));
-		struct page *page = phys_to_page(phys);
+		phys_addr_t offset, phys;
+		struct page *page;
 		union kho_page_info info;
 
+		if (check_shl_overflow((phys_addr_t)bit, shift, &offset) ||
+		    check_add_overflow(elm->phys_start, offset, &phys)) {
+			pr_warn("invalid phys layout for preserved bitmap\n");
+			return;
+		}
+
+		page = phys_to_page(phys);
+
 		memblock_reserve(phys, sz);
 		memblock_reserved_mark_noinit(phys, sz);
 		info.magic = KHO_PAGE_MAGIC;
-- 
2.53.0.1018.g2bb0e51243-goog


