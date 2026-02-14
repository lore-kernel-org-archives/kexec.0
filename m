Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A218DEF99EA
	for <kexec@archiver.kernel.org>; Sat, 14 Feb 2026 01:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N52x8JQ9Owt92Dd5wyBCJma3b4DEePYMVk8MRoPWKBM=; b=XFUQLwmO+DbnTO42GWCmpymrGY
	ONvF1UWUT9xteVC4wZoc0GbdqzmqD5Ia29vfm830TsB5lotzLhY83l7RKbSk0YKaedHKmU+24vZkq
	PJ1nfU0DqHqq8ck7Y+YNF+iJV9IZPzgidC5Crl9a7V6skofu5MjTqGJDdGmYKv2+T2utjYptDjzFF
	hOR+uErXe9NRUMmIbeBAWYf0aPopr3XjrcTprzNG/hw+3rRy9wVjdcjFhGcc3eQZXxmuPyThqB7f7
	bIiH4LbGYRkL6OJUigyvPkedMQ6KAxjQMCMIiHVjeHfVDvpbfxff5ewwKb5i+GSN+bqGPB6MLTEzW
	mmeCjiXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr41W-000000045oW-0Vpc;
	Sat, 14 Feb 2026 01:00:38 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr41Q-000000045oC-2bCC
	for kexec@lists.infradead.org;
	Sat, 14 Feb 2026 01:00:33 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4837907ec88so6073185e9.0
        for <kexec@lists.infradead.org>; Fri, 13 Feb 2026 17:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771030829; x=1771635629; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N52x8JQ9Owt92Dd5wyBCJma3b4DEePYMVk8MRoPWKBM=;
        b=QtoBtpde9dBvJO9wGiaPwfPPBqIpyS5gY8UdhWn4BFwTspR5a5GSbYIyyBf6CSJflK
         y4/hnTgV6o1IqV5XXyk9ApRmKSRexkBWLmiY8e71rKhgdnM0TTgIamRNj/y1wcVPGavz
         0LrVI66m51OTXYvrurkb1T1dGBkBaR4+yEQTuYuLzfv7w5atmTbolWZLRDWRNnTHy8vq
         w/pb1Qi2zF9mtM0SPBCffeAGfmSN1iSzXeImVL8jR+YdK4GLQVLh0HuLXROk7d87RPZF
         DIlQ6toH6Rk21E1HnvF25dE6YvBF+b0w5OcdVQfBo5EdohXVt91LB+8axyTDgRyfKvHP
         4JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771030829; x=1771635629;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N52x8JQ9Owt92Dd5wyBCJma3b4DEePYMVk8MRoPWKBM=;
        b=OhN0yCZq4ZwAG6+1LAmO9XcKXFxof4JtKtN/W58K0W8AJjI9KCxyI4Y0pYQ4jV7LfW
         xwnXr9iErMc4/wcqDBCgUlF9qV5kjXb8HgnwkoCAR7x+2IIvwZFY4MtlA8Nyyus4swAn
         2GdElTJwwFsmSc8vUmA6pBN3N866mulwG7BWGYEBJ57XTo5i2jCPNnbByTPwwirEyo7N
         SN0dUroQNLdfHAbn/nROvKeZYVxDRIqpKNZRoXVxh3sjMC8i3Pk/mAcBxWWnwvnd3+5l
         0F1DCFOR2tHr9v3B99nkWb3Jt8T9ANV+5aA1vUtiy4SaCS+ArM7m5QEPWGPncAG6pmeb
         o8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8+0X91+WiAknqGPRRzumFoTEErseQuSUhsGYG/lunMqhxpC4aWp982ODRlPeHSid/o16WDQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwPkaTpNKna1YyFWPqAkqy/4iiPCnRKFbYkBe6jVr0Mv/HDdCIz
	+SeVPTN3JAPlwiaRQex/bIGI6YU10oF5yPiUln7UA6Uu7HLFXzxCcx27w5uvyhnkehvaVIzM10X
	t/g==
X-Received: from wmby28.prod.google.com ([2002:a05:600c:c05c:b0:480:3227:a124])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c1c:b0:477:7b16:5fb1
 with SMTP id 5b1f17b1804b1-483739ff8damr66109275e9.7.1771030829456; Fri, 13
 Feb 2026 17:00:29 -0800 (PST)
Date: Sat, 14 Feb 2026 01:57:51 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260214010013.3027519-1-elver@google.com>
Subject: [PATCH] kho: validate order in deserialize_bitmap()
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_170032_666947_E5298E16 
X-CRM114-Status: UNSURE (   9.47  )
X-CRM114-Notice: Please train this message.
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

Fix this by adding a bounds check for the order field.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/liveupdate/kexec_handover.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b851b09a8e99..ec353e4b68a6 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -463,6 +463,11 @@ static void __init deserialize_bitmap(unsigned int order,
 	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
 	unsigned long bit;
 
+	if (order > MAX_PAGE_ORDER) {
+		pr_warn("invalid order %u for preserved bitmap\n", order);
+		return;
+	}
+
 	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
 		int sz = 1 << (order + PAGE_SHIFT);
 		phys_addr_t phys =
-- 
2.53.0.335.g19a08e0c02-goog

