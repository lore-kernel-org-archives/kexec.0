Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D69FF885A
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=byHariOe/418DnHhAYKU/dMJ4rRms9bwPBY0UESk+2U=; b=xKF4LGvsiG6iA9FuqNyrI5g3wl
	uMJW9nmk6CjaSdgtXaLaYYQc1Y3EhtkHylJKyDbed0EIT8PTbEAC0N/wPf7Wff9C2fJ/uJrypYmqv
	TfCDV1GDyaxYkEWZLX/aX19RrMrNKu01Cc209JrfM9dARiWrhVo483d9IaZ6dwB6FXlfpqBJKFZmg
	52zh4dr7uVjAd8kJLzd3Gnkp13GEzGo/4CaKnZPnQg+KGChpDpmAhlvJRIO1RxhBCm8nJ7ibs0QiP
	Rt/q0tWeUK8Tw5eDe37utScI2Cq7ENuSN7G5XwXbxb185u/njQJ3k6KSZ8qrCknhjCPx0+ZplTviU
	W2NDk/hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkVK-00000006Ynj-3A1V;
	Fri, 01 May 2026 09:49:50 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkVI-00000006YmH-3zTJ
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 09:49:50 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-82f69adeecbso803879b3a.2
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777628988; x=1778233788; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byHariOe/418DnHhAYKU/dMJ4rRms9bwPBY0UESk+2U=;
        b=i6ZHdC07FomRC3BGs/KAhQdj24cntnzi2KdYGJzgt8tCHfUD4iZIuPC5krZ1lN3oi0
         HQQJmpp4vMX33qSlJHlX1EAA2GRTC0LPTxyJ/hNQysaGBRoe2noxgNvDvEtp54aVZROK
         72WCCAT45zckURHIIgHhEVmYf6HzXq+iHlrDx7Iq7YKi3BrSJ7f9qqDC2kbSf4VLi6Si
         cVMl/NQx7cisoUFsFXiIWYr6klFtdDXP/AueNZ/GD8BxRfGfx70Spreym/3YXSVlb6ar
         emM/ywttDSWaqv1WX947io76vWXI+0oj51Rs7RkrpWYoVVqa/1Yb6sDJ87cSwSQvvf2L
         NUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777628988; x=1778233788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byHariOe/418DnHhAYKU/dMJ4rRms9bwPBY0UESk+2U=;
        b=NKDDo/3Bn1NXZ2Kjddo4eGLDwnFCWTOfsqcjj9h/Rod0bo84CuWTmOH/TIjrq5CxhD
         yfM/8BQVDlXLSA3Xn66inz9ZSxKnYSErRIIy85S4gahI5uz3wB3vnPoSxxIIJvneRF5D
         0m1q+FwNuQquYIwRmkveqXiTOWZmRKnFrkx9JwSfwQdLzh9eiQqxVGZIlUU62BYUqaei
         sdwik4ZsUZFaM0BRBfNUFT6IXuhyBtitiSAJu9Hz1s1hOTJ4IN3i5GkrIK5wQIgMQsfR
         SfoznhXtSDcP1DrytSGETXdRDuMdB0I9yHbRA5VgfqJo45r7uui2iGJKKgdobxlVJj9D
         UJdg==
X-Forwarded-Encrypted: i=1; AFNElJ/Vids8BlrKbdcjn5kRZXN0jXgvTKihIoHQfJ5HL2+f42ruv6xVR0cpfA1p/h3kho/nwYtc2Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yynft5yhqZZiu7B2ijaZGahVsNJazHly6sNF9wOZD9KciOr2xo3
	GstH8HXlQ92AWote/qVEARCQs4+2zQnSfUP/GMixf3O4B3/MHY9h2pw8
X-Gm-Gg: AeBDieu4Ho4q7Y6Wse42lfNkrJckjLdRqh0gKk4zbtF24LJ+rpndB959SVrsc9Gjyzs
	TCkESZ23QPlwDF0GyH9v4WkBT0yDc4HSF0uu2jGcj+E/uD/qmA8bDccDeyhP0be6pA1GHJc4R5T
	omMXzVUnCBtkE3L2YRgE89riczkTr9NZlCirnzZ4GcLJtN28G3t8gj1OodCLm1vi3Gqq/1FmqtI
	GhP4qoCQz85MNQgnQzPO4BNSBfBbN+aRY44MJILVVTEmAPfrFn2D7ERb5rEm2XpdMxVhLd4onuI
	FJb/HeHsgYEyOAdfT2GYi1r6v2HFqx/7M/jYqKb7+za6JHg+epF0IpwBCGWFhY86vkC4kKIknxr
	IJWYXzgsIl94kNao2k9V3n1KscSXBS2DVgDcjDNJRSfhYNBteSA3JF9VgDD7efgDXAbBXoOdGXF
	41++81IZ/MoUNonXRpz4rSeyKH6AZqAbA0LUfgNg==
X-Received: by 2002:a05:6a00:3cc5:b0:82c:9c47:fef9 with SMTP id d2e1a72fcca58-834fe05cc9bmr8047701b3a.2.1777628987950;
        Fri, 01 May 2026 02:49:47 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:eebe:247e:613c:24d7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582dd55sm2042729b3a.1.2026.05.01.02.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:49:47 -0700 (PDT)
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
Subject: [PATCH RFC 5/5] liveupdate: validate restored LUO FLB metadata
Date: Fri,  1 May 2026 17:46:37 +0800
Message-ID: <20260501094637.38650-6-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_024948_993865_33683692 
X-CRM114-Status: GOOD (  10.69  )
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
 kernel/liveupdate/luo_flb.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index 00f5494812c4..e80032669cea 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -162,6 +162,7 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	struct luo_flb_header *fh = &luo_flb_global.incoming;
 	struct liveupdate_flb_op_args args = {0};
 	bool found = false;
+	u64 count;
 	int err;
 
 	guard(mutex)(&private->incoming.lock);
@@ -175,7 +176,14 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	if (!fh->active)
 		return -ENODATA;
 
-	for (int i = 0; i < fh->header_ser->count; i++) {
+	count = fh->header_ser->count;
+	if (count > LUO_FLB_MAX) {
+		pr_err("Invalid FLB count: %llu\n",
+		       (unsigned long long)count);
+		return -EINVAL;
+	}
+
+	for (u64 i = 0; i < count; i++) {
 		if (!strcmp(fh->ser[i].name, flb->compatible)) {
 			private->incoming.data = fh->ser[i].data;
 			private->incoming.count = fh->ser[i].count;
@@ -620,7 +628,20 @@ int __init luo_flb_setup_incoming(void *fdt_in)
 	}
 
 	header_ser_pa = get_unaligned((u64 *)ptr);
+	if (!kho_is_preserved(header_ser_pa, LUO_FLB_PGCNT)) {
+		pr_err("FLB header is not KHO preserved: %#llx\n",
+		       (unsigned long long)header_ser_pa);
+		return -EINVAL;
+	}
+
 	header_ser = phys_to_virt(header_ser_pa);
+	if (header_ser->pgcnt != LUO_FLB_PGCNT ||
+	    header_ser->count > LUO_FLB_MAX) {
+		pr_err("Invalid FLB header: pgcnt %llu count %llu\n",
+		       (unsigned long long)header_ser->pgcnt,
+		       (unsigned long long)header_ser->count);
+		return -EINVAL;
+	}
 
 	luo_flb_global.incoming.header_ser = header_ser;
 	luo_flb_global.incoming.ser = (void *)(header_ser + 1);
-- 
2.53.0


